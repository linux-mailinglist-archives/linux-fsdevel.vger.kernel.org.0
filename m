Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880A2B401A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbfIPSN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 14:13:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46274 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbfIPSN2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:13:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8mbg074246;
        Mon, 16 Sep 2019 18:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=07u0EeaqXOjbjPXzrGYNnWT42o9ZSfdWH0ECUq2ex4U=;
 b=HAVbvJfm1tRDs//BRKR5238hl8WIWSo1SaHdtyIaDLoDYwFutIwcToBmy+F7Dy7fd7nu
 oddIwvJKh0tIhqv2fUQ2+9JcxE3HH9ylZNgnVjzQG9PMEzOuPuXULIoLa+ajilRNjwBD
 AbFaTS7FRPPtWZDTfT6sf3gI5/ohknJCi2QLgGkgRNTHMSCrS4gvd/pwwAGHXLQ9bRAH
 WldeGEFqUi8zF7Cd4ZBKIo8TEUQR1F+Xq6onCM04Mx6iT0hwQPcrOkPVjMxBdOzQc8mN
 DnMDAVhtcQ+cX37QD0HYXkK7KHFN7nrS64tgP0orvxn4vP3G5a9rBlsJMTR69GcEXBDl vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2v2bx2seq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:13:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8GI8e9q076022;
        Mon, 16 Sep 2019 18:13:00 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2v0nb54t2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Sep 2019 18:13:00 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8GICxmn016188;
        Mon, 16 Sep 2019 18:12:59 GMT
Received: from localhost (/10.159.225.108)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Sep 2019 11:12:59 -0700
Date:   Mon, 16 Sep 2019 11:12:58 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/19] iomap: ignore non-shared or non-data blocks in
 xfs_file_dirty
Message-ID: <20190916181258.GI2229799@magnolia>
References: <20190909182722.16783-1-hch@lst.de>
 <20190909182722.16783-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909182722.16783-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1909160178
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9382 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1909160178
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 09, 2019 at 08:27:07PM +0200, Christoph Hellwig wrote:
> xfs_file_dirty is used to unshare reflink blocks.  Rename the function
> to xfs_file_unshare to better document that purpose, and skip iomaps
> that are not shared are don't need zeroing.  This will allow to simplify

                      ^^^ "and"

> the caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Otherwise this looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/iomap/buffered-io.c | 15 +++++++++++----
>  fs/xfs/xfs_reflink.c   |  2 +-
>  include/linux/iomap.h  |  2 +-
>  3 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 33e03992d8a7..0b05551d9b5a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -872,12 +872,19 @@ __iomap_read_page(struct inode *inode, loff_t offset)
>  }
>  
>  static loff_t
> -iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
> +iomap_unshare_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  		struct iomap *iomap)
>  {
>  	long status = 0;
>  	ssize_t written = 0;
>  
> +	/* don't bother with blocks that are not shared to start with */
> +	if (!(iomap->flags & IOMAP_F_SHARED))
> +		return length;
> +	/* don't bother with holes or unwritten extents */
> +	if (iomap->type == IOMAP_HOLE || iomap->type == IOMAP_UNWRITTEN)
> +		return length;
> +
>  	do {
>  		struct page *page, *rpage;
>  		unsigned long offset;	/* Offset into pagecache page */
> @@ -917,14 +924,14 @@ iomap_dirty_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
>  }
>  
>  int
> -iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
> +iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops)
>  {
>  	loff_t ret;
>  
>  	while (len) {
>  		ret = iomap_apply(inode, pos, len, IOMAP_WRITE, ops, NULL,
> -				iomap_dirty_actor);
> +				iomap_unshare_actor);
>  		if (ret <= 0)
>  			return ret;
>  		pos += ret;
> @@ -933,7 +940,7 @@ iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(iomap_file_dirty);
> +EXPORT_SYMBOL_GPL(iomap_file_unshare);
>  
>  static int iomap_zero(struct inode *inode, loff_t pos, unsigned offset,
>  		unsigned bytes, struct iomap *iomap)
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index c4ec7afd1170..cadc0456804d 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -1442,7 +1442,7 @@ xfs_reflink_dirty_extents(
>  			flen = XFS_FSB_TO_B(mp, rlen);
>  			if (fpos + flen > isize)
>  				flen = isize - fpos;
> -			error = iomap_file_dirty(VFS_I(ip), fpos, flen,
> +			error = iomap_file_unshare(VFS_I(ip), fpos, flen,
>  					&xfs_iomap_ops);
>  			xfs_ilock(ip, XFS_ILOCK_EXCL);
>  			if (error)
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 8adcc8dd4498..3a0f0975a57e 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -183,7 +183,7 @@ int iomap_migrate_page(struct address_space *mapping, struct page *newpage,
>  #else
>  #define iomap_migrate_page NULL
>  #endif
> -int iomap_file_dirty(struct inode *inode, loff_t pos, loff_t len,
> +int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
>  		const struct iomap_ops *ops);
>  int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
>  		bool *did_zero, const struct iomap_ops *ops);
> -- 
> 2.20.1
> 
