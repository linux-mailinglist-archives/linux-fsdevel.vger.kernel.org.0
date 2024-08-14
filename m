Return-Path: <linux-fsdevel+bounces-25867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B819512AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 04:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C8284F44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 02:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C93224E8;
	Wed, 14 Aug 2024 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Qosryk1d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1822E3E5
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 02:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723603576; cv=none; b=K5dLBB90xmM1aIpJMO0SYOEn1HLFiMv5gBQTKs+vB9Xgr1WGR6ZDC/iBXywsIgBCGx1AHDEa3IZ1FZb3J8PCy1DD76wosNwSUYcIke1dGAc4ei1FqBb4MBBWNUM2zI3lRj4HJFi2KIeH4xZekvXEGKgoYLAmvF8/Txjz1FfMdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723603576; c=relaxed/simple;
	bh=HbPnQmc2wzO6neAO6PTfyWtMZST2zrnWxHU9ybdTbQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fh+XuwYps/PiIxhMpvS7ZqQmiC0NVnpYa2RDtNm8nRXnCXNzZr5tymc2NEYNlgSNncCCUf7MwmlCIJ/0MwicMKVwsh/uXVrxsl5MHeLAdjhq309M9CJDHVYdVlNxUU3ysfZKyPYzAb+E7QlG6Gh/1D4Sn8DwKUr/Mj7ogBm4aJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Qosryk1d; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723603570; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oGOS9NNFZw1ngtEUhdB8FxJC3GtTI8f3Bz1yhj15yDU=;
	b=Qosryk1dOSLSAhmjkiL4q5gmOdjlcun8hVEApzm5h821L/ytypVrAgLFQl2Jm/M1oO7NW+LpqHJuMU8rGb9bkK4zgW2wArDWMJXxn89UsQ729QZaHpd2aaM+BB0kq/vT+xK6eQDdG4CEr688LYtjHidgsp3w4qgqEoAR/2gLP8Y=
Received: from 30.221.146.67(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WCqjPr2_1723603568)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 10:46:09 +0800
Message-ID: <6ff03b54-fac8-47d4-bbda-7ebf7f8c9572@linux.alibaba.com>
Date: Wed, 14 Aug 2024 10:46:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, osandov@osandov.com, bernd.schubert@fastmail.fm,
 sweettea-kernel@dorminy.me, kernel-team@meta.com
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240813212149.1909627-1-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/24 5:21 AM, Joanne Koong wrote:
> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> fetched from the server after an open.
> 
> For fuse servers that are backed by network filesystems, this is
> needed to ensure that file attributes are up to date between
> consecutive open calls.
> 
> For example, if there is a file that is opened on two fuse mounts,
> in the following scenario:
> 
> on mount A, open file.txt w/ O_APPEND, write "hi", close file
> on mount B, open file.txt w/ O_APPEND, write "world", close file
> on mount A, open file.txt w/ O_APPEND, write "123", close file
> 
> when the file is reopened on mount A, the file inode contains the old
> size and the last append will overwrite the data that was written when
> the file was opened/written on mount B.
> 
> (This corruption can be reproduced on the example libfuse passthrough_hp
> server with writeback caching disabled and nopassthrough)
> 
> Having this flag as an option enables parity with NFS's close-to-open
> consistency.

It seems a general demand for close-to-open consistency similar to NFS
when the backend store for FUSE is a NFS-like filesystem.  We have a
similar private implementation for close-to-open consistency in our
internal distribution.  Also FYI there was a similar proposal for this:

https://lore.kernel.org/linux-fsdevel/20220608104202.19461-1-zhangjiachen.jaycee@bytedance.com/

> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/file.c            | 7 ++++++-
>  include/uapi/linux/fuse.h | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index f39456c65ed7..437487ce413d 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct file *file)
>  	err = fuse_do_open(fm, get_node_id(inode), file, false);
>  	if (!err) {
>  		ff = file->private_data;
> -		err = fuse_finish_open(inode, file);
> +		if (ff->open_flags & FOPEN_FETCH_ATTR) {
> +			fuse_invalidate_attr(inode);
> +			err = fuse_update_attributes(inode, file, STATX_BASIC_STATS);
> +		}
> +		if (!err)
> +			err = fuse_finish_open(inode, file);
>  		if (err)
>  			fuse_sync_release(fi, ff, file->f_flags);
>  		else if (is_truncate)
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index d08b99d60f6f..f5d1af6fe352 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -217,6 +217,9 @@
>   *  - add backing_id to fuse_open_out, add FOPEN_PASSTHROUGH open flag
>   *  - add FUSE_NO_EXPORT_SUPPORT init flag
>   *  - add FUSE_NOTIFY_RESEND, add FUSE_HAS_RESEND init flag
> + *
> + *  7.41
> + *  - add FOPEN_FETCH_ATTR
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -252,7 +255,7 @@
>  #define FUSE_KERNEL_VERSION 7
>  
>  /** Minor version number of this interface */
> -#define FUSE_KERNEL_MINOR_VERSION 40
> +#define FUSE_KERNEL_MINOR_VERSION 41
>  
>  /** The node ID of the root inode */
>  #define FUSE_ROOT_ID 1
> @@ -360,6 +363,7 @@ struct fuse_file_lock {
>   * FOPEN_NOFLUSH: don't flush data cache on close (unless FUSE_WRITEBACK_CACHE)
>   * FOPEN_PARALLEL_DIRECT_WRITES: Allow concurrent direct writes on the same inode
>   * FOPEN_PASSTHROUGH: passthrough read/write io for this open file
> + * FOPEN_FETCH_ATTR: attributes are fetched after file is opened
>   */
>  #define FOPEN_DIRECT_IO		(1 << 0)
>  #define FOPEN_KEEP_CACHE	(1 << 1)
> @@ -369,6 +373,7 @@ struct fuse_file_lock {
>  #define FOPEN_NOFLUSH		(1 << 5)
>  #define FOPEN_PARALLEL_DIRECT_WRITES	(1 << 6)
>  #define FOPEN_PASSTHROUGH	(1 << 7)
> +#define FOPEN_FETCH_ATTR	(1 << 8)
>  
>  /**
>   * INIT request/reply flags

Does this close-to-open consistency support writeback mode? AFAIK, the
cached ctime/mtime/size at the kernel side are always trusted while
these attributes from the server are dropped, see:

```
fuse_update_attributes
    fuse_update_get_attr
        cache_mask = fuse_get_cache_mask(inode)
            if writeback mode:
                return STATX_MTIME | STATX_CTIME | STATX_SIZE
```

Also FYI there's a similar proposal for enhancing the close-to-open
consistency in writeback mode to fix the above issue:

https://lore.kernel.org/linux-fsdevel/20220624055825.29183-1-zhangjiachen.jaycee@bytedance.com/

Besides, IIUC this patch only implements the revalidate-on-open semantic
for metadata.  To fulfill the full close-to-open consistency, do you
need to disable FOPEN_KEEP_CACHE to fulfill the revalidate-on-open
semantic for data? (Though the revalidate-on-open semantic for data is
not needed in your append-only case.)

-- 
Thanks,
Jingbo

