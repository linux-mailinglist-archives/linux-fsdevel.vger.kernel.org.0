Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4F529F0DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgJ2QNM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 12:13:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42380 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgJ2QNL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:13:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TG9ErG156978;
        Thu, 29 Oct 2020 16:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bHoj8umFYPWY0A4MzESGkhTRt3TkvuqQ/Jd2QnoOiOI=;
 b=E1Jkqt18IAvScHjQeJ0D3iY4zyIVReT6u/g9R8MHzatXcY8ZG6jGOljbg0UoQ3wKdUHT
 pZZgetr6FBx27f+/yvjzoSqMvnWDvGWHuHPrvrc37LRmcJUNdtRCEh/bc1L33Fz/AjGS
 wqiUmlhjA8j5yHEWNJrepiQPidF8WZhYvg/s54Uh7wv8of8/ph+8X0NVDN9VkNbPnmN4
 4QTgqsdSq+H3vI9TSNRbGGC62u6Ta24ZtQd7he4ed4JcKMCiXkhCp0h5fysX14x6UaTi
 /+NfFhjxbRVr2gLZrhdEQPCUHWtv26jLi4WoTug0zFpYyHRV40+GyYZdpu7wvITnbfFK Tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34cc7m5rph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 16:13:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TGAYFb175310;
        Thu, 29 Oct 2020 16:13:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34cwupy18e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 16:13:02 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09TGD07E031655;
        Thu, 29 Oct 2020 16:13:00 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 09:13:00 -0700
Date:   Thu, 29 Oct 2020 09:12:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iomap: support partial page discard on writeback
 block mapping failure
Message-ID: <20201029161258.GA1061246@magnolia>
References: <20201029132325.1663790-1-bfoster@redhat.com>
 <20201029132325.1663790-3-bfoster@redhat.com>
 <20201029152718.GK1061252@magnolia>
 <20201029160732.GA1660404@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029160732.GA1660404@bfoster>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010290113
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 12:07:32PM -0400, Brian Foster wrote:
> On Thu, Oct 29, 2020 at 08:27:18AM -0700, Darrick J. Wong wrote:
> > On Thu, Oct 29, 2020 at 09:23:24AM -0400, Brian Foster wrote:
> > > iomap writeback mapping failure only calls into ->discard_page() if
> > > the current page has not been added to the ioend. Accordingly, the
> > > XFS callback assumes a full page discard and invalidation. This is
> > > problematic for sub-page block size filesystems where some portion
> > > of a page might have been mapped successfully before a failure to
> > > map a delalloc block occurs. ->discard_page() is not called in that
> > > error scenario and the bio is explicitly failed by iomap via the
> > > error return from ->prepare_ioend(). As a result, the filesystem
> > > leaks delalloc blocks and corrupts the filesystem block counters.
> > > 
> > > Since XFS is the only user of ->discard_page(), tweak the semantics
> > > to invoke the callback unconditionally on mapping errors and provide
> > > the file offset that failed to map. Update xfs_discard_page() to
> > > discard the corresponding portion of the file and pass the range
> > > along to iomap_invalidatepage(). The latter already properly handles
> > > both full and sub-page scenarios by not changing any iomap or page
> > > state on sub-page invalidations.
> > > 
> > > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > > ---
> > >  fs/iomap/buffered-io.c | 15 ++++++++-------
> > >  fs/xfs/xfs_aops.c      | 13 +++++++------
> > >  include/linux/iomap.h  |  2 +-
> > >  3 files changed, 16 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > > index bcfc288dba3f..d1f04eabc7e4 100644
> > > --- a/fs/iomap/buffered-io.c
> > > +++ b/fs/iomap/buffered-io.c
> > > @@ -1412,14 +1412,15 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
> > >  	 * appropriately.
> > >  	 */
> > >  	if (unlikely(error)) {
> > > +		/*
> > > +		 * Let the filesystem know what portion of the current page
> > > +		 * failed to map. If the page wasn't been added to ioend, it
> > > +		 * won't be affected by I/O completion and we must unlock it
> > > +		 * now.
> > > +		 */
> > > +		if (wpc->ops->discard_page)
> > > +			wpc->ops->discard_page(page, file_offset);
> > >  		if (!count) {
> > > -			/*
> > > -			 * If the current page hasn't been added to ioend, it
> > > -			 * won't be affected by I/O completions and we must
> > > -			 * discard and unlock it right here.
> > > -			 */
> > > -			if (wpc->ops->discard_page)
> > > -				wpc->ops->discard_page(page);
> > >  			ClearPageUptodate(page);
> > >  			unlock_page(page);
> > >  			goto done;
> > > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > > index b35611882ff9..46920c530b20 100644
> > > --- a/fs/xfs/xfs_aops.c
> > > +++ b/fs/xfs/xfs_aops.c
> > > @@ -527,13 +527,14 @@ xfs_prepare_ioend(
> > >   */
> > >  static void
> > >  xfs_discard_page(
> > > -	struct page		*page)
> > > +	struct page		*page,
> > > +	loff_t			fileoff)
> > >  {
> > >  	struct inode		*inode = page->mapping->host;
> > >  	struct xfs_inode	*ip = XFS_I(inode);
> > >  	struct xfs_mount	*mp = ip->i_mount;
> > > -	loff_t			offset = page_offset(page);
> > > -	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, offset);
> > > +	unsigned int		pageoff = offset_in_page(fileoff);
> > > +	xfs_fileoff_t		start_fsb = XFS_B_TO_FSBT(mp, fileoff);
> > >  	int			error;
> > >  
> > >  	if (XFS_FORCED_SHUTDOWN(mp))
> > > @@ -541,14 +542,14 @@ xfs_discard_page(
> > >  
> > >  	xfs_alert_ratelimited(mp,
> > >  		"page discard on page "PTR_FMT", inode 0x%llx, offset %llu.",
> > > -			page, ip->i_ino, offset);
> > > +			page, ip->i_ino, fileoff);
> > >  
> > >  	error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> > > -			PAGE_SIZE / i_blocksize(inode));
> > > +			(PAGE_SIZE - pageoff) / i_blocksize(inode));
> > 
> > Er... could you rebase this against 5.10-rc1, please?  willy changed
> > that line to not use PAGE_SIZE directly.
> > 
> 
> Sure.. (note that there's still a PAGE_SIZE usage in the
> iomap_invalidatepage() call).

<nod> I think he has more for 5.11, but in the meantime it's just fixing
the merge conflicts. :)

> > I /think/ the way to resolve the merge conflict here is to change this
> > last argument to:
> > 
> > (i_blocks_per_page(page) - pageoff) / i_blocksize(inode)
> > 
> 
> Hmm... pageoff is bytes so that doesn't look quite right. How about
> something like this?
> 
> 	...
> 	unsigned int            pageoff = offset_in_page(fileoff);
> 	xfs_fileoff_t           pageoff_fsb = XFS_B_TO_FSBT(mp, pageoff);
> 
> 	...
>         error = xfs_bmap_punch_delalloc_range(ip, start_fsb,
> 				i_blocks_per_page(inode, page) - pageoff_fsb);
> 	...

You could probably combine the two variables, but otherwise that looks
fine to me.

--D

> 
> Brian
> 
> > --D
> > 
> > >  	if (error && !XFS_FORCED_SHUTDOWN(mp))
> > >  		xfs_alert(mp, "page discard unable to remove delalloc mapping.");
> > >  out_invalidate:
> > > -	iomap_invalidatepage(page, 0, PAGE_SIZE);
> > > +	iomap_invalidatepage(page, pageoff, PAGE_SIZE - pageoff);
> > >  }
> > >  
> > >  static const struct iomap_writeback_ops xfs_writeback_ops = {
> > > diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> > > index 4d1d3c3469e9..36e0ab19210a 100644
> > > --- a/include/linux/iomap.h
> > > +++ b/include/linux/iomap.h
> > > @@ -220,7 +220,7 @@ struct iomap_writeback_ops {
> > >  	 * Optional, allows the file system to discard state on a page where
> > >  	 * we failed to submit any I/O.
> > >  	 */
> > > -	void (*discard_page)(struct page *page);
> > > +	void (*discard_page)(struct page *page, loff_t fileoff);
> > >  };
> > >  
> > >  struct iomap_writepage_ctx {
> > > -- 
> > > 2.25.4
> > > 
> > 
> 
