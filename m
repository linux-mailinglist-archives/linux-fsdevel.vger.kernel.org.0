Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB093EA843
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Aug 2021 18:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhHLQJ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhHLQJ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 12:09:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3240C061756;
        Thu, 12 Aug 2021 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3ggCTefGyEQqGD5qJ6gx/hdFOfa/39aAvqrR+WXMTs=; b=iQKEiFSHifkz/aMYVIuAV3z7Nb
        FGQvQ3i6MA6/vF/6Hr1DYRNQ901AT/g1Fr7+gyRmfmkElsQWg42oVEwYUHfuheAuNN1AmDwCklie6
        SiZYhdSlOw3zbRB7M43QUXVvPoyFdPlPAjn/PqgycopxyYXprlR4mNvkB7OuMbJsNiHkYFBGmLmzS
        BMtkfWiztlgH4InA7aALn73MQe/SMRcg8yl51JI2OratAzlvyeSZvRVk+hAUNTX3fBscOdGRCauvw
        EcHOGebkUx8YMa8m2HhjPpWTkUT1npqgmgTDJHTgzpQE/fuopk2LnZUbJ1ohnX9UXbnAn2b54tDQi
        +il0q2Bg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mEDEc-00EkBp-FL; Thu, 12 Aug 2021 16:07:21 +0000
Date:   Thu, 12 Aug 2021 17:07:10 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] netfs, afs, ceph: Use folios
Message-ID: <YRVHLu3OAwylCONm@casper.infradead.org>
References: <2408234.1628687271@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2408234.1628687271@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 02:07:51PM +0100, David Howells wrote:
>  (*) Can page_endio() be split into two separate functions, one for read
>      and one for write?  If seems a waste of time to conditionally switch
>      between two different branches.

At this point I'm thinking ...

static inline void folio_end_read(struct folio *folio, int err)
{
	if (!err)
		folio_set_uptodate(folio);
	folio_unlock(folio);
}

Clearly the page isn't uptodate at this point, or ->readpage wouldn't've
been called.  So there's no need to clear it.  And PageError is
completely useless.

Part of this exercise was to find gaps in the API.  It looks like there
aren't too many places I missed that AFS hits.

> @@ -78,7 +78,7 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
>  			goto flush_conflicting_write;
>  	}
>  
> -	*_page = page;
> +	*_page = &folio->page;

Can't do anything about this one; the write_begin API needs to be fixed.

> @@ -87,17 +87,17 @@ int afs_write_begin(struct file *file, struct address_space *mapping,
>  	 */
>  flush_conflicting_write:
>  	_debug("flush conflict");
> -	ret = write_one_page(page);
> +	ret = write_one_page(&folio->page);

I have folio_write_one() in my tree:

https://git.infradead.org/users/willy/pagecache.git/commitdiff/82b9f3c7b258de31bf3d3fa4cc587a6d17b5fe40

it's in the "nice to have", rather than "filesystems depend on it" pile,
so I should move it over.

> @@ -174,40 +175,32 @@ static void afs_kill_pages(struct address_space *mapping,
[...]
> +		folio_clear_uptodate(folio);
> +		folio_end_writeback(folio);
> +		folio_lock(folio);
> +		generic_error_remove_page(mapping, &folio->page);
> +		folio_unlock(folio);
> +		folio_put(folio);

This one I'm entirely missing.  It's awkward.  I'll work on it.

> @@ -497,8 +480,8 @@ static void afs_extend_writeback(struct address_space *mapping,
>  			else if (t == psize || new_content)
>  				stop = false;
>  
> -			index += thp_nr_pages(page);
> -			if (!pagevec_add(&pvec, page))
> +			index += folio_nr_pages(folio);
> +			if (!pagevec_add(&pvec, &folio->page))

Pagevecs are also awkward.  I haven't quite figured out how to
transition them to folios.

> @@ -933,29 +919,28 @@ int afs_launder_page(struct page *page)
>  	unsigned int f, t;
>  	int ret = 0;
>  
> -	_enter("{%lx}", page->index);
> +	_enter("{%lx}", folio_index(folio));
>  
> -	priv = page_private(page);
> -	if (clear_page_dirty_for_io(page)) {
> +	priv = (unsigned long)folio_get_private(folio);
> +	if (folio_clear_dirty_for_io(folio)) {
>  		f = 0;
> -		t = thp_size(page);
> -		if (PagePrivate(page)) {
> -			f = afs_page_dirty_from(page, priv);
> -			t = afs_page_dirty_to(page, priv);
> +		t = folio_size(folio);
> +		if (folio_test_private(folio)) {
> +			f = afs_folio_dirty_from(folio, priv);
> +			t = afs_folio_dirty_to(folio, priv);
>  		}
>  
> -		bv[0].bv_page = page;
> +		bv[0].bv_page = &folio->page;
>  		bv[0].bv_offset = f;
>  		bv[0].bv_len = t - f;

I should probably add a wrapper to init a bvec.

>  zero_out:
> -	zero_user_segments(page, 0, offset, offset + len, thp_size(page));
> +	zero_user_segments(&folio->page, 0, offset, offset + len, folio_size(folio));

Yeah, that's ugly.

