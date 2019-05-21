Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82D32539F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2019 17:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfEUPRb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 May 2019 11:17:31 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58554 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfEUPRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 May 2019 11:17:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1mgP100602;
        Tue, 21 May 2019 15:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=8AVZkoBPVQWKSHRM3naLkNx4PGQvHgsKDNXXfZ9BJPM=;
 b=uBC3gJC/91gkOFdD6OjPXLEnzTlSyjQGCrmDVXhZL1I5manJ/JcGmIyvwR78kPPUEAMf
 VLuBHjCJq7J6itF1dPh3VhIUoe/s5PdjwsfFNO2HT/JvPp9bhP1Hyotxgv5w8orPU2eI
 rbg5jB9wGKnRCbZCqH2R8aL1sB+iiOPLlvz3Yy9qU13cgrhj0cK7WGE9eUPQ/xFM+W3N
 4JeH/rBHz9e5qWCYrUqJ5XPlGpADGbRk6Z95xoP93H3QMOG+BR7IOtfdFjtL33ndytTR
 O3eeS/eBqlZ/NAuyAmn+Hj+vGiddEZ3xP0CZaLChLLPcE8ZDPXdV3e6CcKLQaoZ5jc2G iw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2sjapqe15h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:16:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LFDeAd052707;
        Tue, 21 May 2019 15:14:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2sks1jgsqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:14:54 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4LFEld2015657;
        Tue, 21 May 2019 15:14:48 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 15:14:47 +0000
Date:   Tue, 21 May 2019 08:14:45 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-btrfs@vger.kernel.org, kilobyte@angband.pl,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, david@fromorbit.com,
        willy@infradead.org, hch@lst.de, dsterba@suse.cz,
        nborisov@suse.com, linux-nvdimm@lists.01.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 03/18] btrfs: basic dax read
Message-ID: <20190521151445.GA5125@magnolia>
References: <20190429172649.8288-1-rgoldwyn@suse.de>
 <20190429172649.8288-4-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429172649.8288-4-rgoldwyn@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210094
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:26:34PM -0500, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Perform a basic read using iomap support. The btrfs_iomap_begin()
> finds the extent at the position and fills the iomap data
> structure with the values.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/Makefile |  1 +
>  fs/btrfs/ctree.h  |  5 +++++
>  fs/btrfs/dax.c    | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/file.c   | 11 ++++++++++-
>  4 files changed, 65 insertions(+), 1 deletion(-)
>  create mode 100644 fs/btrfs/dax.c
> 
> diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
> index ca693dd554e9..1fa77b875ae9 100644
> --- a/fs/btrfs/Makefile
> +++ b/fs/btrfs/Makefile
> @@ -12,6 +12,7 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
>  	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
>  	   uuid-tree.o props.o free-space-tree.o tree-checker.o
>  
> +btrfs-$(CONFIG_FS_DAX) += dax.o
>  btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
>  btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
>  btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 9512f49262dd..b7bbe5130a3b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3795,6 +3795,11 @@ int btrfs_reada_wait(void *handle);
>  void btrfs_reada_detach(void *handle);
>  int btree_readahead_hook(struct extent_buffer *eb, int err);
>  
> +#ifdef CONFIG_FS_DAX
> +/* dax.c */
> +ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to);
> +#endif /* CONFIG_FS_DAX */
> +
>  static inline int is_fstree(u64 rootid)
>  {
>  	if (rootid == BTRFS_FS_TREE_OBJECTID ||
> diff --git a/fs/btrfs/dax.c b/fs/btrfs/dax.c
> new file mode 100644
> index 000000000000..bf3d46b0acb6
> --- /dev/null
> +++ b/fs/btrfs/dax.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * DAX support for BTRFS
> + *
> + * Copyright (c) 2019  SUSE Linux
> + * Author: Goldwyn Rodrigues <rgoldwyn@suse.com>
> + */
> +
> +#ifdef CONFIG_FS_DAX
> +#include <linux/dax.h>
> +#include <linux/iomap.h>
> +#include "ctree.h"
> +#include "btrfs_inode.h"
> +
> +static int btrfs_iomap_begin(struct inode *inode, loff_t pos,
> +		loff_t length, unsigned flags, struct iomap *iomap)
> +{
> +	struct extent_map *em;
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, pos, length, 0);
> +	if (em->block_start == EXTENT_MAP_HOLE) {
> +		iomap->type = IOMAP_HOLE;
> +		return 0;

I'm not doing a rigorous review of the btrfs-specific pieces, but you're
required to fill out the other iomap fields for a read hole.

--D

> +	}
> +	iomap->type = IOMAP_MAPPED;
> +	iomap->bdev = em->bdev;
> +	iomap->dax_dev = fs_info->dax_dev;
> +	iomap->offset = em->start;
> +	iomap->length = em->len;
> +	iomap->addr = em->block_start;
> +	return 0;
> +}
> +
> +static const struct iomap_ops btrfs_iomap_ops = {
> +	.iomap_begin		= btrfs_iomap_begin,
> +};
> +
> +ssize_t btrfs_file_dax_read(struct kiocb *iocb, struct iov_iter *to)
> +{
> +	ssize_t ret;
> +	struct inode *inode = file_inode(iocb->ki_filp);
> +
> +	inode_lock_shared(inode);
> +	ret = dax_iomap_rw(iocb, to, &btrfs_iomap_ops);
> +	inode_unlock_shared(inode);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_FS_DAX */
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index 34fe8a58b0e9..9194591f9eea 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -3288,9 +3288,18 @@ static int btrfs_file_open(struct inode *inode, struct file *filp)
>  	return generic_file_open(inode, filp);
>  }
>  
> +static ssize_t btrfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
> +{
> +#ifdef CONFIG_FS_DAX
> +	if (IS_DAX(file_inode(iocb->ki_filp)))
> +		return btrfs_file_dax_read(iocb, to);
> +#endif
> +	return generic_file_read_iter(iocb, to);
> +}
> +
>  const struct file_operations btrfs_file_operations = {
>  	.llseek		= btrfs_file_llseek,
> -	.read_iter      = generic_file_read_iter,
> +	.read_iter      = btrfs_file_read_iter,
>  	.splice_read	= generic_file_splice_read,
>  	.write_iter	= btrfs_file_write_iter,
>  	.mmap		= btrfs_file_mmap,
> -- 
> 2.16.4
> 
