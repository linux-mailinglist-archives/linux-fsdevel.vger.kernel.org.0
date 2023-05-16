Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A5705712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEPT1g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjEPT1f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 15:27:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71547B5
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684265204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FbZvmBy7Xu5p36p9xf/yVfMX/2icPS0uwZwtjXy0DwM=;
        b=g7h3DxbmsOuVY4R46Ecx82hI+s4OiOUuTcXscE1o/ms1eHpd0ILo0qcJHFdF7Dq3BozXKO
        a5cLr7rd0pYhR27iBbwNzFQ9EU+KUSnbiPAoWY+NKqUddQv8tFxA33V/RgRFAEAmZlZU6D
        5mYe/0WQyZZzkOYwtxNGPa/yYaqWjho=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-9sYjkZ_ONU-Wg_7Kz6suLw-1; Tue, 16 May 2023 15:26:42 -0400
X-MC-Unique: 9sYjkZ_ONU-Wg_7Kz6suLw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-61afc445dd5so85471836d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 12:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265202; x=1686857202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbZvmBy7Xu5p36p9xf/yVfMX/2icPS0uwZwtjXy0DwM=;
        b=KOaq/f0kRWH8bmOrk7Kp7+Vb+qTuRv0S5JftVON2uVDoL0GmRkZp2SeV9hvNrjbbUT
         3KdE56hkjOmfWOOCLBxguwTXSB/7Oo1jLJHWvPRwQHAkUtYaI5VJUM8Jng82HXsdGik5
         QL5rY2wkqi83ON78J447h7VzztNV/AbnzdI+1ErO3mdnqNm2mpIc+llYZU3W1h7bf/6V
         ggALut0tFE1P3Do7miFhNm/J8dDNbB+YDIYkF/GUr/Ez/gD7R5WIPJPXNGOZWaOcwPkA
         EnO6idUPFwS4WKaHbMRDYv+ouU20i3U1e2l+7Fweesm9hMgyxVXTrtxsCi1m1ct9+Zer
         F0CA==
X-Gm-Message-State: AC+VfDyLN8uqECb2+tTGS6V7R0uKyWrwDjsTZnXaQrqFSAvuw6JrcPwy
        zevVf/KN/HgqiQOLEEb0PJ5IM1eV4aFwHUCGOAxyJITXyhjitrOpvawLqwMimON7JKVsq9ZrGwo
        2qRPmtmj4LUpbhxYVF2ftLavl7lFOQUhmVQ==
X-Received: by 2002:a05:622a:d:b0:3f5:2341:5435 with SMTP id x13-20020a05622a000d00b003f523415435mr14953122qtw.61.1684265201940;
        Tue, 16 May 2023 12:26:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ50tDJ4umb6aa6I7f1zQnmpgRgHfd3Y/pzOpaSjxdRqsTMqQE+Erj0pWnSBslYYbIQMEnDlzw==
X-Received: by 2002:a05:622a:d:b0:3f5:2341:5435 with SMTP id x13-20020a05622a000d00b003f523415435mr14953089qtw.61.1684265201583;
        Tue, 16 May 2023 12:26:41 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id cx12-20020a05620a51cc00b007593bf6e345sm72133qkb.113.2023.05.16.12.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 12:26:40 -0700 (PDT)
Date:   Tue, 16 May 2023 15:29:08 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Aravinda Herle <araherle@in.ibm.com>
Subject: Re: [RFCv5 5/5] iomap: Add per-block dirty state tracking to improve
 performance
Message-ID: <ZGPZhMr0ZiPDxVkw@bfoster>
References: <ZGJMg2G4XVeFnMcY@bfoster>
 <878rdol4as.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rdol4as.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 16, 2023 at 08:19:31PM +0530, Ritesh Harjani wrote:
> Brian Foster <bfoster@redhat.com> writes:
> 
> > On Mon, May 08, 2023 at 12:58:00AM +0530, Ritesh Harjani (IBM) wrote:
> >> When filesystem blocksize is less than folio size (either with
> >> mapping_large_folio_support() or with blocksize < pagesize) and when the
> >> folio is uptodate in pagecache, then even a byte write can cause
> >> an entire folio to be written to disk during writeback. This happens
> >> because we currently don't have a mechanism to track per-block dirty
> >> state within struct iomap_page. We currently only track uptodate state.
> >>
> >> This patch implements support for tracking per-block dirty state in
> >> iomap_page->state bitmap. This should help improve the filesystem write
> >> performance and help reduce write amplification.
> >>
> >> Performance testing of below fio workload reveals ~16x performance
> >> improvement using nvme with XFS (4k blocksize) on Power (64K pagesize)
> >> FIO reported write bw scores improved from around ~28 MBps to ~452 MBps.
> >>
> >> 1. <test_randwrite.fio>
> >> [global]
> >> 	ioengine=psync
> >> 	rw=randwrite
> >> 	overwrite=1
> >> 	pre_read=1
> >> 	direct=0
> >> 	bs=4k
> >> 	size=1G
> >> 	dir=./
> >> 	numjobs=8
> >> 	fdatasync=1
> >> 	runtime=60
> >> 	iodepth=64
> >> 	group_reporting=1
> >>
> >> [fio-run]
> >>
> >> 2. Also our internal performance team reported that this patch improves
> >>    their database workload performance by around ~83% (with XFS on Power)
> >>
> >> Reported-by: Aravinda Herle <araherle@in.ibm.com>
> >> Reported-by: Brian Foster <bfoster@redhat.com>
> >> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> >> ---
> >>  fs/gfs2/aops.c         |   2 +-
> >>  fs/iomap/buffered-io.c | 115 ++++++++++++++++++++++++++++++++++++++---
> >>  fs/xfs/xfs_aops.c      |   2 +-
> >>  fs/zonefs/file.c       |   2 +-
> >>  include/linux/iomap.h  |   1 +
> >>  5 files changed, 112 insertions(+), 10 deletions(-)
> >>
> > ...
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 25f20f269214..c7f41b26280a 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> > ...
> >> @@ -119,12 +169,20 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
> >>  	else
> >>  		gfp = GFP_NOFS | __GFP_NOFAIL;
> >>
> >> -	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(nr_blocks)),
> >> +	/*
> >> +	 * iop->state tracks two sets of state flags when the
> >> +	 * filesystem block size is smaller than the folio size.
> >> +	 * The first state tracks per-block uptodate and the
> >> +	 * second tracks per-block dirty state.
> >> +	 */
> >> +	iop = kzalloc(struct_size(iop, state, BITS_TO_LONGS(2 * nr_blocks)),
> >>  		      gfp);
> >>  	if (iop) {
> >>  		spin_lock_init(&iop->state_lock);
> >>  		if (folio_test_uptodate(folio))
> >>  			iop_set_range(iop, 0, nr_blocks);
> >> +		if (is_dirty)
> >> +			iop_set_range(iop, nr_blocks, nr_blocks);
> >
> > I find the is_dirty logic here a bit confusing. AFAICT, this is
> > primarily to handle the case where a folio is completely overwritten, so
> > no iop is allocated at write time, and so then writeback needs to
> > allocate the iop as fully dirty to reflect that. I.e., all iop_alloc()
> > callers other than iomap_writepage_map() either pass the result of
> > folio_test_dirty() or explicitly dirty the entire range of the folio
> > anyways.  iomap_dirty_folio() essentially does the latter because it
> > needs to dirty the entire folio regardless of whether the iop already
> > exists or not, right?
> 
> Yes.
> 
> >
> > If so and if I'm following all of that correctly, could this complexity
> > be isolated to iomap_writepage_map() by simply checking for the !iop
> > case first, then call iop_alloc() immediately followed by
> > set_range_dirty() of the entire folio? Then presumably iop_alloc() could
> > always just dirty based on folio state with the writeback path exception
> > case handled explicitly. Hm?
> >
> 
> Hi Brian,
> 
> It was discussed here [1] to pass is_dirty flag at the time of iop
> allocation. We can do what you are essentially suggesting, but it's just
> extra work i.e. we will again do some calculations of blocks_per_folio,
> start, end and more importantly take and release iop->state_lock
> spinlock. Whereas with above approach we could get away with this at the
> time of iop allocation itself.
> 

Hi Ritesh,

Isn't that extra work already occurring in iomap_dirty_folio()? I was
just thinking that maybe moving it to where it's apparently needed (i.e.
writeback) might eliminate the need for the param.

I suppose iomap_dirty_folio() would need to call filemap_dirty_folio()
first to make sure iop_alloc() sees the dirty state, but maybe that
would also allow skipping the iop alloc if the folio was already dirty
(i.e. if the folio was previously dirtied by a full buffered overwite
for example)?

I've appended a quick diff below (compile tested only) just to explain
what I mean. When doing that it also occurred to me that if we really
care about the separate call, we could keep the is_dirty param but do
the __iop_alloc() wrapper thing where iop_alloc() always passes
folio_test_dirty().

BTW, I think you left off your [1] discussion reference..

> Besides, isn't it easier this way? which as you also stated we will
> dirty all the blocks based on is_dirty flag, which is folio_test_dirty()
> except at the writeback time.
> 

My thinking was just that I kind of had to read through all of the
iop_alloc() callsites to grok the purpose of the parameter, which made
it seem unnecessarily confusing. But ultimately it made sense, so I
don't insist on changing it or anything if this approach is intentional
and/or preferred by others. That's just my .02 and I'll defer to your
preference. :)

> 
> >>  		folio_attach_private(folio, iop);
> >>  	}
> >>  	return iop;
> > ...
> >> @@ -561,6 +621,18 @@ void iomap_invalidate_folio(struct folio *folio, size_t offset, size_t len)
...
> >
> > WRT to the !iop case.. I _think_ this is handled correctly here because
> > that means we'd handle the folio as completely dirty at writeback time.
> > Is that the case? If so, it might be nice to document that assumption
> > somewhere (here or perhaps in the writeback path).
> >
> 
> !iop case is simply when we don't have a large folio and blocksize ==
>  pagesize. In that case we don't allocate any iop and simply returns
>  from iop_alloc().
> So then we just skip the loop which is only meant when we have blocks
> within a folio.
> 

Isn't it also the case that iop might be NULL at this point if the fs
has sub-folio blocks, but the folio was dirtied by a full overwrite of
the folio? Or did I misunderstand patch 4?

Brian

--- 8< ---

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 92e1e1061225..89b3053e3f2d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -155,7 +155,7 @@ static void iop_clear_range_dirty(struct folio *folio, size_t off, size_t len)
 }
 
 static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
-				    unsigned int flags, bool is_dirty)
+				    unsigned int flags)
 {
 	struct iomap_page *iop = to_iomap_page(folio);
 	unsigned int nr_blocks = i_blocks_per_folio(inode, folio);
@@ -181,7 +181,7 @@ static struct iomap_page *iop_alloc(struct inode *inode, struct folio *folio,
 		spin_lock_init(&iop->state_lock);
 		if (folio_test_uptodate(folio))
 			iop_set_range(iop, 0, nr_blocks);
-		if (is_dirty)
+		if (folio_test_dirty(folio))
 			iop_set_range(iop, nr_blocks, nr_blocks);
 		folio_attach_private(folio, iop);
 	}
@@ -326,8 +326,7 @@ static int iomap_read_inline_data(const struct iomap_iter *iter,
 	if (WARN_ON_ONCE(size > iomap->length))
 		return -EIO;
 	if (offset > 0)
-		iop = iop_alloc(iter->inode, folio, iter->flags,
-				folio_test_dirty(folio));
+		iop = iop_alloc(iter->inode, folio, iter->flags);
 	else
 		iop = to_iomap_page(folio);
 
@@ -365,8 +364,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 		return iomap_read_inline_data(iter, folio);
 
 	/* zero post-eof blocks as the page may be mapped */
-	iop = iop_alloc(iter->inode, folio, iter->flags,
-			folio_test_dirty(folio));
+	iop = iop_alloc(iter->inode, folio, iter->flags);
 	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
 	if (plen == 0)
 		goto done;
@@ -616,13 +614,10 @@ EXPORT_SYMBOL_GPL(iomap_invalidate_folio);
 
 bool iomap_dirty_folio(struct address_space *mapping, struct folio *folio)
 {
-	struct iomap_page *iop;
-	struct inode *inode = mapping->host;
-	size_t len = i_blocks_per_folio(inode, folio) << inode->i_blkbits;
-
-	iop = iop_alloc(inode, folio, 0, false);
-	iop_set_range_dirty(inode, folio, 0, len);
-	return filemap_dirty_folio(mapping, folio);
+	bool dirtied = filemap_dirty_folio(mapping, folio);
+	if (dirtied)
+		iop_alloc(mapping->host, folio, 0);
+	return dirtied;
 }
 EXPORT_SYMBOL_GPL(iomap_dirty_folio);
 
@@ -673,8 +668,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter, loff_t pos,
 	    pos + len >= folio_pos(folio) + folio_size(folio))
 		return 0;
 
-	iop = iop_alloc(iter->inode, folio, iter->flags,
-			folio_test_dirty(folio));
+	iop = iop_alloc(iter->inode, folio, iter->flags);
 
 	if ((iter->flags & IOMAP_NOWAIT) && !iop && nr_blocks > 1)
 		return -EAGAIN;
@@ -1759,7 +1753,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		struct writeback_control *wbc, struct inode *inode,
 		struct folio *folio, u64 end_pos)
 {
-	struct iomap_page *iop = iop_alloc(inode, folio, 0, true);
+	struct iomap_page *iop = to_iomap_page(folio);
 	struct iomap_ioend *ioend, *next;
 	unsigned len = i_blocksize(inode);
 	unsigned nblocks = i_blocks_per_folio(inode, folio);
@@ -1767,6 +1761,11 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	int error = 0, count = 0, i;
 	LIST_HEAD(submit_list);
 
+	if (!iop) {
+		iop = iop_alloc(inode, folio, 0);
+		iop_set_range_dirty(inode, folio, 0, folio_size(folio));
+	}
+
 	WARN_ON_ONCE(iop && atomic_read(&iop->write_bytes_pending) != 0);
 
 	/*

