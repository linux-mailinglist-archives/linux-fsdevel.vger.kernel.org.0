Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFE1B30FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Apr 2020 22:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUUNp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Apr 2020 16:13:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59696 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDUUNp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:13:45 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LK2brM134090;
        Tue, 21 Apr 2020 20:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=hc3EKpE/i0NRRdRTSFSD0gA/bZ9G0lF+IfO3Z7scYuI=;
 b=O3qpEO6G/y3LGCLBIr4Lxa3WKoucy4/Utz+gphsXv/d5teU/l7ajzPZgrmko0WqV3Kkg
 QLhgCbXJA/7S86YSSq6goNkLD3/K94LS290bn+pzveSn99Hk6Oc/DMpr7ZWkOziHBgu6
 m4OdrfOsQ7yfuSCpsOwtwr1VZIMyP1MD6EI65KCXuX1r0fzr3YWd648Z9zj9q0vEqa5p
 w7y4dM7YVwAxaUvpZHhnnVM9alKzeeIpeCEBToCYE11d6i34ddCQ4j6CTOCejgii5Ljd
 WhKUJ3M+Typ/s/TpjllgfsenNoH0PtU18C/OfPpYeZChNmSwOlg9dVok1I6uiLzkgusU iA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30fsgky50d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:13:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03LKDSSL193352;
        Tue, 21 Apr 2020 20:13:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30gb90vmcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Apr 2020 20:13:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03LKDUWu004838;
        Tue, 21 Apr 2020 20:13:31 GMT
Received: from localhost (/10.159.227.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 13:13:30 -0700
Date:   Tue, 21 Apr 2020 13:13:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V9 02/11] fs: Remove unneeded IS_DAX() check in
 io_is_direct()
Message-ID: <20200421201328.GZ6742@magnolia>
References: <20200421191754.3372370-1-ira.weiny@intel.com>
 <20200421191754.3372370-3-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421191754.3372370-3-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=1 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210151
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=1 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004210150
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 12:17:44PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Remove the check because DAX now has it's own read/write methods and
> file systems which support DAX check IS_DAX() prior to IOCB_DIRECT on
> their own.  Therefore, it does not matter if the file state is DAX when
> the iocb flags are created.
> 
> Also remove io_is_direct() as it is just a simple flag check.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks fine to me,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
> ---
> Changes from v8:
> 	Rebase to latest Linus tree
> 
> Changes from v6:
> 	remove io_is_direct() as well.
> 	Remove Reviews since this is quite a bit different.
> 
> Changes from v3:
> 	Reword commit message.
> 	Reordered to be a 'pre-cleanup' patch
> ---
>  drivers/block/loop.c | 6 +++---
>  include/linux/fs.h   | 7 +------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index da693e6a834e..14372df0f354 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -634,8 +634,8 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  
>  static inline void loop_update_dio(struct loop_device *lo)
>  {
> -	__loop_update_dio(lo, io_is_direct(lo->lo_backing_file) |
> -			lo->use_dio);
> +	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
> +				lo->use_dio);
>  }
>  
>  static void loop_reread_partitions(struct loop_device *lo,
> @@ -1028,7 +1028,7 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
>  	if (!(lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
>  		blk_queue_write_cache(lo->lo_queue, true, false);
>  
> -	if (io_is_direct(lo->lo_backing_file) && inode->i_sb->s_bdev) {
> +	if ((lo->lo_backing_file->f_flags & O_DIRECT) && inode->i_sb->s_bdev) {
>  		/* In case of direct I/O, match underlying block size */
>  		unsigned short bsize = bdev_logical_block_size(
>  			inode->i_sb->s_bdev);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 4f6f59b4f22a..a87cc5845a02 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3394,11 +3394,6 @@ extern void setattr_copy(struct inode *inode, const struct iattr *attr);
>  
>  extern int file_update_time(struct file *file);
>  
> -static inline bool io_is_direct(struct file *filp)
> -{
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> -}
> -
>  static inline bool vma_is_dax(const struct vm_area_struct *vma)
>  {
>  	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
> @@ -3423,7 +3418,7 @@ static inline int iocb_flags(struct file *file)
>  	int res = 0;
>  	if (file->f_flags & O_APPEND)
>  		res |= IOCB_APPEND;
> -	if (io_is_direct(file))
> +	if (file->f_flags & O_DIRECT)
>  		res |= IOCB_DIRECT;
>  	if ((file->f_flags & O_DSYNC) || IS_SYNC(file->f_mapping->host))
>  		res |= IOCB_DSYNC;
> -- 
> 2.25.1
> 
