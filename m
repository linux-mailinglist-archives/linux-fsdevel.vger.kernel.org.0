Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97E5099B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 09:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386242AbiDUH4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356531AbiDUH4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:56:02 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E244DFB3;
        Thu, 21 Apr 2022 00:53:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VAdmSw9_1650527585;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VAdmSw9_1650527585)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 15:53:08 +0800
Date:   Thu, 21 Apr 2022 15:53:05 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
Subject: Re: [PATCH v9 10/21] erofs: add fscache mode check helper
Message-ID: <YmENYam/pVJ+Riyy@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com, zhangjiachen.jaycee@bytedance.com
References: <20220415123614.54024-1-jefflexu@linux.alibaba.com>
 <20220415123614.54024-11-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-11-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 08:36:03PM +0800, Jeffle Xu wrote:
> Until then erofs is exactly blockdev based filesystem.
> 
> A new fscache-based mode is going to be introduced for erofs to support
> scenarios where on-demand read semantics is needed, e.g. container
> image distribution. In this case, erofs could be mounted from data blobs
> through fscache.
> 
> Add a helper checking which mode erofs works in, and twist the code in
> prep for the following fscache mode.

in preparation for the upcoming fscache mode.

> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/internal.h |  5 +++++
>  fs/erofs/super.c    | 44 +++++++++++++++++++++++++++++---------------
>  2 files changed, 34 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index fe9564e5091e..05a97533b1e9 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -161,6 +161,11 @@ struct erofs_sb_info {
>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
>  #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
>  
> +static inline bool erofs_is_fscache_mode(struct super_block *sb)
> +{
> +	return IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && !sb->s_bdev;
> +}
> +
>  enum {
>  	EROFS_ZIP_CACHE_DISABLED,
>  	EROFS_ZIP_CACHE_READAHEAD,
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 0c4b41130c2f..724d5ff0d78c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -259,15 +259,19 @@ static int erofs_init_devices(struct super_block *sb,
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> -		bdev = blkdev_get_by_path(dif->path,
> -					  FMODE_READ | FMODE_EXCL,
> -					  sb->s_type);
> -		if (IS_ERR(bdev)) {
> -			err = PTR_ERR(bdev);
> -			break;
> +		if (!erofs_is_fscache_mode(sb)) {
> +			bdev = blkdev_get_by_path(dif->path,
> +						  FMODE_READ | FMODE_EXCL,
> +						  sb->s_type);
> +			if (IS_ERR(bdev)) {
> +				err = PTR_ERR(bdev);
> +				break;
> +			}
> +			dif->bdev = bdev;
> +			dif->dax_dev = fs_dax_get_by_bdev(bdev,
> +							  &dif->dax_part_off);
>  		}
> -		dif->bdev = bdev;
> -		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
> +
>  		dif->blocks = le32_to_cpu(dis->blocks);
>  		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
>  		sbi->total_blocks += dif->blocks;
> @@ -586,21 +590,28 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>  
>  	sb->s_magic = EROFS_SUPER_MAGIC;
>  
> -	if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
> -		erofs_err(sb, "failed to set erofs blksize");
> -		return -EINVAL;
> -	}
> -
>  	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
>  	if (!sbi)
>  		return -ENOMEM;
>  
>  	sb->s_fs_info = sbi;
>  	sbi->opt = ctx->opt;
> -	sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->dax_part_off);
>  	sbi->devs = ctx->devs;
>  	ctx->devs = NULL;
>  
> +	if (erofs_is_fscache_mode(sb)) {
> +		sb->s_blocksize = EROFS_BLKSIZ;
> +		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
> +	} else {
> +		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
> +			erofs_err(sb, "failed to set erofs blksize");
> +			return -EINVAL;
> +		}
> +
> +		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
> +						  &sbi->dax_part_off);
> +	}
> +
>  	err = erofs_read_superblock(sb);
>  	if (err)
>  		return err;
> @@ -857,7 +868,10 @@ static int erofs_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>  	struct super_block *sb = dentry->d_sb;
>  	struct erofs_sb_info *sbi = EROFS_SB(sb);
> -	u64 id = huge_encode_dev(sb->s_bdev->bd_dev);
> +	u64 id = 0;
> +
> +	if (!erofs_is_fscache_mode(sb))
> +		id = huge_encode_dev(sb->s_bdev->bd_dev);
>  
>  	buf->f_type = sb->s_magic;
>  	buf->f_bsize = EROFS_BLKSIZ;
> -- 
> 2.27.0
