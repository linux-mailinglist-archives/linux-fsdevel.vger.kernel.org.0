Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E7331DD23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 17:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhBQQSk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 11:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233070AbhBQQSi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 11:18:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9CFC061574;
        Wed, 17 Feb 2021 08:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VfrUoqOUihVjvmCvSLv9mlyS0o00nDdsmdN3qvEoA00=; b=cSa+ST1CT82tnPFcDFN6385/gf
        fX5ue2PIy1WjeGVEzkDGZMTsFzLmqC7c+WYAQLnYutzJbsajtl2Jh42nC0w4lqBcrHrlZkXESMSyp
        xlcoDR3Wp9R6AuEdsi/ty3h3DDMfecTJMK444IMwUHEhC9geKbbRqshaygCMw7xBUsOlIbyDSduNy
        dmDRIklz83kii8sK5gQXi1rPYZtyfyYvM4vvxJRvwGML8x9D7AnF0WgJAsIE2nAV7DOSN//6W8z37
        7Iss1QwTmm8FBDB49gMScTNNT7Ln/Ocl0tdU2/isZxvLSBXMpl/SURMPrdCcTpYsHSkF0tAUW3gJk
        KVjidQgA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lCPSg-000e1H-2j; Wed, 17 Feb 2021 16:14:28 +0000
Date:   Wed, 17 Feb 2021 16:13:58 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
Message-ID: <20210217161358.GM2858050@casper.infradead.org>
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 15, 2021 at 03:44:52PM +0000, David Howells wrote:
> +++ b/include/linux/pagemap.h
> @@ -761,6 +761,8 @@ extern void __delete_from_page_cache(struct page *page, void *shadow);
>  int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask);
>  void delete_from_page_cache_batch(struct address_space *mapping,
>  				  struct pagevec *pvec);
> +void readahead_expand(struct readahead_control *ractl,
> +		      loff_t new_start, size_t new_len);

If we're revising this patchset, I'd rather this lived with the other
readahead declarations, ie after the definition of readahead_control.

> +	/* Expand the trailing edge upwards */
> +	while (ractl->_nr_pages < new_nr_pages) {
> +		unsigned long index = ractl->_index + ractl->_nr_pages;
> +		struct page *page = xa_load(&mapping->i_pages, index);
> +
> +		if (page && !xa_is_value(page))
> +			return; /* Page apparently present */
> +
> +		page = __page_cache_alloc(gfp_mask);
> +		if (!page)
> +			return;
> +		if (add_to_page_cache_lru(page, mapping, index, gfp_mask) < 0) {
> +			put_page(page);
> +			return;
> +		}
> +		ractl->_nr_pages++;
> +	}

We're defeating the ondemand_readahead() algorithm here.  Let's suppose
userspace is doing 64kB reads, the filesystem is OrangeFS which only
wants to do 4MB reads, the page cache is initially empty and there's
only one thread doing a sequential read.  ondemand_readahead() calls
get_init_ra_size() which tells it to allocate 128kB and set the async
marker at 64kB.  Then orangefs calls readahead_expand() to allocate the
remainder of the 4MB.  After the app has read the first 64kB, it comes
back to read the next 64kB, sees the readahead marker and tries to trigger
the next batch of readahead, but it's already present, so it does nothing
(see page_cache_ra_unbounded() for what happens with pages present).

Then it keeps going through the 4MB that's been read, not seeing any more
readahead markers, gets to 4MB and asks for ... 256kB?  Not quite sure.
Anyway, it then has to wait for the next 4MB because the readahead didn't
overlap with the application processing.

So readahead_expand() needs to adjust the file's f_ra so that when the
application gets to 64kB, it kicks off the readahead of 4MB-8MB chunk (and
then when we get to 4MB+256kB, it kicks off the readahead of 8MB-12MB,
and so on).

Unless someone sees a better way to do this?  I don't
want to inadvertently break POSIX_FADV_WILLNEED which calls
force_page_cache_readahead() and should not perturb the kernel's
ondemand algorithm.  Perhaps we need to add an 'ra' pointer to the
ractl to indicate whether the file_ra_state should be updated by
readahead_expand()?
