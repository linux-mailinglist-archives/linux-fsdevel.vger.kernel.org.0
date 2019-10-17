Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E422CDB678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2019 20:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441273AbfJQSll (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Oct 2019 14:41:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42006 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390183AbfJQSll (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:41:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIdUii173365;
        Thu, 17 Oct 2019 18:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ynIkxSCdwQKk9aa/KnzRuvgSRVE+FPNztS00eAkD9AQ=;
 b=mPjZen38MEfU2u+YmLexAo/03+Uu92Ep0QWKcFeN0+tBJ5S43xI4/X7O2AoBSdgHwl+W
 xZTccM7Fs57m7i8b2AkBqMW9eW/yEfmevsPpBJcrILfbUip6wLtOFDxI5uvzjHP4ltu3
 xRbJTH7ipCBPwmhwOlBwH0vMovgPHtZ7W6HUDrZfUlrkdB7IE4Y2FMZfkgKglpYU0I37
 f3qDVqId1krq0dFzksKL9mT7zIDuO2tAVK9DEbwyMiArY7D3nyHeSEGZebDsePu/U/ut
 yYLrqSzdu9F7xciMRN4Bk34r2RtON+1+8FtUVXdIlCPOtFKmWyDpQgKyZ3PYhQxaP+PJ sA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vk6sr0any-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:41:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9HIXHug050325;
        Thu, 17 Oct 2019 18:39:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vpvtm3d6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Oct 2019 18:39:25 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9HIdImJ007701;
        Thu, 17 Oct 2019 18:39:18 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Oct 2019 18:39:18 +0000
Date:   Thu, 17 Oct 2019 11:39:17 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH 01/14] iomap: iomap that extends beyond EOF should be
 marked dirty
Message-ID: <20191017183917.GL13108@magnolia>
References: <20191017175624.30305-1-hch@lst.de>
 <20191017175624.30305-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017175624.30305-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910170166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170167
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 17, 2019 at 07:56:11PM +0200, Christoph Hellwig wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When doing a direct IO that spans the current EOF, and there are
> written blocks beyond EOF that extend beyond the current write, the
> only metadata update that needs to be done is a file size extension.
> 
> However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> there is IO completion metadata updates required, and hence we may
> fail to correctly sync file size extensions made in IO completion
> when O_DSYNC writes are being used and the hardware supports FUA.
> 
> Hence when setting IOMAP_F_DIRTY, we need to also take into account
> whether the iomap spans the current EOF. If it does, then we need to
> mark it dirty so that IO completion will call generic_write_sync()
> to flush the inode size update to stable storage correctly.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks ok, but need fixes tag.  Also, might it be wise to split off the
ext4 section into a separate patch so that it can be backported
separately?

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/ext4/inode.c       | 9 ++++++++-
>  fs/xfs/xfs_iomap.c    | 7 +++++++
>  include/linux/iomap.h | 2 ++
>  3 files changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 516faa280ced..e9dc52537e5b 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3523,9 +3523,16 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  			return ret;
>  	}
>  
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
>  	iomap->flags = 0;
> -	if (ext4_inode_datasync_dirty(inode))
> +	if (ext4_inode_datasync_dirty(inode) ||
> +	    offset + length > i_size_read(inode))
>  		iomap->flags |= IOMAP_F_DIRTY;
> +
>  	iomap->bdev = inode->i_sb->s_bdev;
>  	iomap->dax_dev = sbi->s_daxdev;
>  	iomap->offset = (u64)first_block << blkbits;
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index f780e223b118..32993c2acbd9 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1049,6 +1049,13 @@ xfs_file_iomap_begin(
>  	trace_xfs_iomap_alloc(ip, offset, length, XFS_DATA_FORK, &imap);
>  
>  out_finish:
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes pending or have been made here.
> +	 */
> +	if ((flags & IOMAP_WRITE) && offset + length > i_size_read(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;
>  	return xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
>  
>  out_found:
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 7aa5d6117936..24bd227d59f9 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -32,6 +32,8 @@ struct vm_fault;
>   *
>   * IOMAP_F_DIRTY indicates the inode has uncommitted metadata needed to access
>   * written data and requires fdatasync to commit them to persistent storage.
> + * This needs to take into account metadata changes that *may* be made at IO
> + * completion, such as file size updates from direct IO.
>   */
>  #define IOMAP_F_NEW		0x01	/* blocks have been newly allocated */
>  #define IOMAP_F_DIRTY		0x02	/* uncommitted metadata */
> -- 
> 2.20.1
> 
