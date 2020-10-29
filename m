Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E870929F0C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgJ2QHk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50135 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725814AbgJ2QHk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603987658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jJkX2CgkVafsxqj8d9NfHXlDKDCt+j6Kwpu97HKmos=;
        b=F7Bz8HSBmpsc/M001/0VuUM9YaUH1AjJXSlwJVd0x3fSVQDH5B3IGyGXVLr8bQB7zoqlg4
        sWU6wVVABwtZsr7bPqeEdRfdg8Fgu29lqAfesfffHlbld9anGc8YOA2LfUOtWCARPZ6bj5
        MPY9VIE3yXOrmPAmT5yu992Gw796MVY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-AyGhRxkzMRa9nV6KJDjy_A-1; Thu, 29 Oct 2020 12:07:36 -0400
X-MC-Unique: AyGhRxkzMRa9nV6KJDjy_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 117F9809DF3;
        Thu, 29 Oct 2020 16:07:35 +0000 (UTC)
Received: from bfoster (ovpn-113-186.rdu2.redhat.com [10.10.113.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A1F960C17;
        Thu, 29 Oct 2020 16:07:34 +0000 (UTC)
Date:   Thu, 29 Oct 2020 12:07:32 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iomap: support partial page discard on writeback
 block mapping failure
Message-ID: <20201029160732.GA1660404@bfoster>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-3-bfoster@redhat.com>
 <20201029152718.GK1061252@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029152718.GK1061252@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 08:27:18AM -0700, Darrick J. Wong wrote:
> On Thu, Oct 29, 2020 at 09:23:24AM -0400, Brian Foster wrote:
> > iomap writeback mapping failure only calls into ->discard_page() if
> > the current page has not been added to the ioend. Accordingly, the
> > XFS callback assumes a full page discard and invalidation. This is
> > problematic for sub-page block size filesystems where some portion
> > of a page might have been mapped successfully before a failure to
> > map a delalloc block occurs. ->discard_page() is not called in that
> > error scenario and the bio is explicitly failed by iomap via the
> > error return from ->prepare_ioend(). As a result, the filesystem
> > leaks delalloc blocks and corrupts the filesystem block counters.
> > 
> > Since XFS is the only user of ->discard_page(), tweak the semantics
> > to invoke the callback unconditionally on mapping errors and provide
> > the file offset that failed to map. Update xfs_discard_page() to
> > discard the corresponding portion of the file and pass the range
> > along to iomap_invalidatepage(). The latter already properly handles
> > both full and sub-page scenarios by not changing any iomap or page
> > state on sub-page invalidations.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  fs/iomap/buffered-io.c | 15 ++++++++-------
> >  fs/xfs/xfs_aops.c      | 13 +++++++------
> >  include/linux/iomap.h  |  2 +-
> >  3 files changed, 16 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index bcfc288dba3f..d1f04eabc7e4 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -1412,14 +1412,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> >  	 * appropriately.
> >  	 */
> >  	if (unlikely(error)) {
> > +		/*
> > +		 * Let the filesystem know what portion of the current page
> > +		 * failed to map. If the page wasn't been added to ioend, it
> > +		 * won't be affected by I/O completion and we must unlock it
> > +		 * now.
> > +		 */
> > +		if (wpc->ops->discard_page)
> > +			wpc->ops->discard_page(page, file_offset);
> >  		if (!count) {
> > -			/*
> > -			 * If the current page hasn't been added to ioend, it
> > -			 * won't be affected by I/O completions and we must
> > -			 * discard and unlock it right here.
> > -			 */
> > -			if (wpc->ops->discard_page)
> > -				wpc->ops->discard_page(page);
> >  			ClearPageUptodate(page);
> >  			unlock_page(page);
> >  			goto done;
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index b35611882ff9..46920c530b20 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -527,13 +527,14 @@ xfs_prepare_ioend(
> >   */
> >  static void
> >  xfs_discard_page(
> > -	struct page		*page)
> > +	struct page		*page,
> > +	loff_t			fileoff)
> >  {
> >  	struct inode		*inode = page->mapping->host;
> >  	struct xfs_inode	*ip = XFS_I(inode);
> >  	struct xfs_mount	*mp = ip->i_mount;
> > -	loff_t			offset = page_offset(page);
> > -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> > +	unsigned int		pageoff = offset_in_page(fileoff);
> > +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
> >  	int			error;
> >  
> >  	if (XFS_FORCED_SHUTDOWN(mp))
> > @@ -541,14 +542,14 @@ xfs_discard_page(
> >  
> >  	xfs_alert_ratelimited(mp,
> >  		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> > -			page, ip->i_ino, offset);
> > +			page, ip->i_ino, fileoff);
> >  
> >  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> > -			PAGE_SIZE / i_blocksize(inode));
> > +			(PAGE_SIZE - pageoff) / i_blocksize(inode));
> 
> Er... could you rebase this against 5.10-rc1, please?  willy changed
> that line to not use PAGE_SIZE directly.
> 

Sure.. (note that there's still a PAGE_SIZE usage in the
iomap_invalidatepage() call).

> I /think/ the way to resolve the merge conflict here is to change this
> last argument to:
> 
> (i_blocks_per_page(page) - pageoff) / i_blocksize(inode)
> 

Hmm... pageoff is bytes so that doesn't look quite right. How about
something like this?

	...
	unsigned int            pageoff = offset_in_page(fileoff);
	xfs_fileoff_t           pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);

	...
        error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
				i_blocks_per_page(inode, page) - pageoff_fsb);
	...

Brian

> --D
> 
> >  	if (error && !XFS_FORCED_SHUTDOWN(mp))
> >  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
> >  out_invalidate:
> > -	iomap_invalidatepage(page, 0, PAGE_SIZE);
> > +	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
> >  }
> >  
> >  static const struct iomap_writeback_ops xfs_writeback_ops = {
> > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > index 4d1d3c3469e9..36e0ab19210a 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -220,7 +220,7 @@ struct iomap_writeback_ops {
> >  	 * Optional, allows the file system to discard state on a page where
> >  	 * we failed to submit any I/O.
> >  	 */
> > -	void (*discard_page)(struct page *page);
> > +	void (*discard_page)(struct page *page, loff_t fileoff);
> >  };
> >  
> >  struct iomap_writepage_ctx {
> > -- 
> > 2.25.4
> > 
> 

