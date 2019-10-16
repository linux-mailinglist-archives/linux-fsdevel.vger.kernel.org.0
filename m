Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150ECD8822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 07:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731775AbfJPF1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 01:27:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57736 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfJPF1X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 01:27:23 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9G5OSZm001300;
        Wed, 16 Oct 2019 05:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=83VNlAi3u25Os+7CgnB0F2bow9QKW1mZ3bZ2dQzhvA8=;
 b=A0qNVTc0/lGGX5YrHH51lvD0IJ2UUFKolgzJ1SzfolOT6qo61xFAxbvdkxDhSQLIQTnz
 fpnDMRheE3VOzUp0Pr+IDNrP2VgM76nnt0xieHSqz6XdSNTfU9W7kgMzChro6KDDHTwJ
 Vohlg/WqiRXBgaF8U+c2Yc9S+fKe6O7s0kTcp07416v7zbcvmTyVmxoyQL30jOZ7D4e3
 nKyUnetJMHIus8QqwSI536wbL+R6LOvtr2nQWlFkjoAxx7VzPVKEwB/cM669nLftB2QL
 sjq1nlXQf0X8epVk0QB3bslNMrnBWOoPsQTNIx8EofaBQP4m7kJfs2JtDuwlhwjkojqw pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2vk6sqm8uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 05:27:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9G5N40X081961;
        Wed, 16 Oct 2019 05:27:17 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2vnb0gkd8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 05:27:17 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9G5RFWg000489;
        Wed, 16 Oct 2019 05:27:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Oct 2019 22:27:15 -0700
Date:   Tue, 15 Oct 2019 22:27:13 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: iomap that extends beyond EOF should be marked
 dirty
Message-ID: <20191016052713.GX13108@magnolia>
References: <20191016051101.12620-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016051101.12620-1-david@fromorbit.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910160050
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9411 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910160050
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 04:11:01PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When doing a direct IO that spans the current EOF, and there are
> written blocks beyond EOF that extend beyond the current write, the
> only metadata update that needs to be done is a file size extension.
> 
> However, we don't mark such iomaps as IOMAP_F_DIRTY to indicate that
> there is IO completion metadata updates required, and hence we may
> fail to correctly sync file size extensions made in IO completion
> when O_DSYNC writes are beingt used and the hardware supports FUA.
> 
> Hence when setting IOMAP_F_DIRTY, we need to also take into account
> whether the iomap spans the current EOF. If it does, then we need to
> mark it dirty so that IO completion will call generic_write_sync()
> to flush the inode size update to stable storage correctly.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/ext4/inode.c       | 9 ++++++++-
>  fs/xfs/xfs_iomap.c    | 8 ++++++++
>  include/linux/iomap.h | 2 ++
>  3 files changed, 18 insertions(+), 1 deletion(-)
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
> index f780e223b118..38be06f19ea2 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -722,6 +722,14 @@ xfs_file_iomap_begin_delay(
>  		xfs_trim_extent(&imap, cmap.br_startoff, cmap.br_blockcount);
>  		shared = true;
>  	}
> +
> +	/*
> +	 * Writes that span EOF might trigger an IO size update on completion,
> +	 * so consider them to be dirty for the purposes of O_DSYNC even if
> +	 * there is no other metadata changes being made or are pending here.
> +	 */
> +	if (offset + count > i_size_read(inode))
> +		iomap->flags |= IOMAP_F_DIRTY;

This ought to be in xfs_direct_write_iomap_begin(), right?

(Hoping to see another rev of Christoph's iomap cleanup series... ;))

--D

>  	error = xfs_bmbt_to_iomap(ip, iomap, &imap, shared);
>  out_unlock:
>  	xfs_iunlock(ip, XFS_ILOCK_EXCL);
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
> 2.23.0.rc1
> 
