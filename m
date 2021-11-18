Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18434563DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 21:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhKRULx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Nov 2021 15:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhKRULx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Nov 2021 15:11:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E50C061574;
        Thu, 18 Nov 2021 12:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q4rNjiJsCgtPo7i//thZsANrSWxw8KLiweCm+rPioWU=; b=vM6AmhIHnAkhRsDbxBgnPj2NVM
        EMOi0WfXB24KGEayBF9TaG9uDCmusUOe4G36aBvYTXB/Vv45ezt+/pRIl+zOjb1Er/etg61HiIufb
        SKrlgFIHFbmCz6+lWs58UzrX1UdoUyGwpcV2cLoH5bNlK1m5jhx7X2eGrPVQ99uUM7pqdHj1l2v4k
        Eeezi9mkRJaXQs5xqCs71edLFpD6TMxvVg2WxJ26Ly0MEv8nXleZtoos/F3WX94RKHy2WkyeJYLoa
        +ms3+mgn2pbbFUlFXhr+PJRUC8KVobbVG5EUPbQokEGcRCF/l20ZI7TB8O2T9K0aaVqJSxtimgtLU
        gycrb8ww==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mnniC-008luj-C6; Thu, 18 Nov 2021 20:08:48 +0000
Date:   Thu, 18 Nov 2021 20:08:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 02/28] mm: Add functions to zero portions of a folio
Message-ID: <YZay0H3vl/L/GJmo@casper.infradead.org>
References: <20211108040551.1942823-1-willy@infradead.org>
 <20211108040551.1942823-3-willy@infradead.org>
 <20211117044527.GO24307@magnolia>
 <YZUMhDDHott2Q4W+@casper.infradead.org>
 <20211117170707.GW24307@magnolia>
 <YZZ3YJucR/WOpOaF@casper.infradead.org>
 <20211118172615.GA24307@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118172615.GA24307@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 18, 2021 at 09:26:15AM -0800, Darrick J. Wong wrote:
> On Thu, Nov 18, 2021 at 03:55:12PM +0000, Matthew Wilcox wrote:
> >                         if (buffer_new(bh)) {
> > ...
> >                                         folio_zero_segments(folio,
> >                                                 to, block_end,
> >                                                 block_start, from);
> > 
> > ("zero between block_start and block_end, except for the region
> > specified by 'from' and 'to'").  Except that for some reason the
> > ranges are specified backwards, so it's not obvious what's going on.
> > Converting that to folio_zero_ranges() would be a possibility, at the
> > expense of complexity in the caller, or using 'max' instead of 'end'
> > would also add complexity to the callers.
> 
> The call above looks like it is preparing to copy some data into the
> middle of a buffer by zero-initializing the bytes before and the bytes
> after that middle region.
> 
> Admittedly my fs-addled brain actually finds this hot mess easier to
> understand:
> 
> folio_zero_segments(folio, to, blocksize - 1, block_start, from - 1);
> 
> but I suppose the xend method involves less subtraction everywhere.

That's exactly what it's doing.  It's kind of funny because it's an
abstraction that permits a micro-optimisation (removing potentially one
kmap() call), but removes the opportunity for a larger optimisation
(removing several, and also removing calls to flush_dcache_folio).
That is, we could rewrite __block_write_begin_int() as:

static void *kremap_folio(void *kaddr, struct folio *folio)
{
	if (kaddr)
		return kaddr;
	/* buffer heads only support single page folios */
	return kmap_local_folio(folio, 0);
}

+       void *kaddr = NULL;
...
-                               if (block_end > to || block_start < from)
-                                       folio_zero_segments(folio,
-                                               to, block_end,
-                                               block_start, from);
+                               if (from > block_start) {
+                                       kaddr = kremap_folio(kaddr, folio);
+                                       memset(kaddr + block_start, 0,
+                                               block_start - from);
+                               }
+                               if (block_end > to) {
+                                       kaddr = kremap_folio(kaddr, folio);
+                                       memset(kaddr + to, 0, block_end - to);
+                               }
...
        }
+       if (kaddr) {
+               kunmap_local(kaddr);
+               flush_dcache_folio(folio);
+       }

That way if there are multiple unmapped+new buffers, we only kmap/kunmap
once per page.  I don't care to submit this as a patch though ... buffer
heads just need to go away.  iomap can't use an optimisation like this;
it already reports all the contiguous unmapped blocks as a single extent,
and if you have multiple unmapped extents per page, well ... I'm sorry
for you, but the overhead of kmap/kunmap is the least of your problems.

> Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Thanks.  Pushed to
https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/for-next

I'll give that until Monday to soak and send a pull request.
