Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8953509E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 13:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388622AbiDULBi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388611AbiDULBi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:01:38 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348F32CC95;
        Thu, 21 Apr 2022 03:58:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VAejRZ._1650538721;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VAejRZ._1650538721)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Apr 2022 18:58:43 +0800
Date:   Thu, 21 Apr 2022 18:58:41 +0800
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
Subject: Re: [PATCH v9 16/21] erofs: register fscache context for extra data
 blobs
Message-ID: <YmE44WjWAYOkdnQ4@B-P7TQMD6M-0146.local>
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
 <20220415123614.54024-17-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220415123614.54024-17-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 08:36:09PM +0800, Jeffle Xu wrote:
> Similar to the multi device mode, erofs could be mounted from one
> primary data blob (mandatory) and multiple extra data blobs (optional).
> 
> Register fscache context for each extra data blob.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/data.c     | 3 +++
>  fs/erofs/internal.h | 2 ++
>  fs/erofs/super.c    | 8 +++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index bc22642358ec..14b64d960541 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -199,6 +199,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  	map->m_bdev = sb->s_bdev;
>  	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>  	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
> +	map->m_fscache = EROFS_SB(sb)->s_fscache;
>  
>  	if (map->m_deviceid) {
>  		down_read(&devs->rwsem);
> @@ -210,6 +211,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  		map->m_bdev = dif->bdev;
>  		map->m_daxdev = dif->dax_dev;
>  		map->m_dax_part_off = dif->dax_part_off;
> +		map->m_fscache = dif->fscache;
>  		up_read(&devs->rwsem);
>  	} else if (devs->extra_devices) {
>  		down_read(&devs->rwsem);
> @@ -227,6 +229,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  				map->m_bdev = dif->bdev;
>  				map->m_daxdev = dif->dax_dev;
>  				map->m_dax_part_off = dif->dax_part_off;
> +				map->m_fscache = dif->fscache;
>  				break;
>  			}
>  		}
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 386658416159..fa488af8dfcf 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -49,6 +49,7 @@ typedef u32 erofs_blk_t;
>  
>  struct erofs_device_info {
>  	char *path;
> +	struct erofs_fscache *fscache;
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;
>  	u64 dax_part_off;
> @@ -482,6 +483,7 @@ static inline int z_erofs_map_blocks_iter(struct inode *inode,
>  #endif	/* !CONFIG_EROFS_FS_ZIP */
>  
>  struct erofs_map_dev {
> +	struct erofs_fscache *m_fscache;
>  	struct block_device *m_bdev;
>  	struct dax_device *m_daxdev;
>  	u64 m_dax_part_off;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 61dc900295f9..c6755bcae4a6 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -259,7 +259,12 @@ static int erofs_init_devices(struct super_block *sb,
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> -		if (!erofs_is_fscache_mode(sb)) {
> +		if (erofs_is_fscache_mode(sb)) {
> +			err = erofs_fscache_register_cookie(sb, &dif->fscache,
> +							    dif->path, false);
> +			if (err)
> +				break;
> +		} else {
>  			bdev = blkdev_get_by_path(dif->path,
>  						  FMODE_READ | FMODE_EXCL,
>  						  sb->s_type);
> @@ -710,6 +715,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>  	fs_put_dax(dif->dax_dev);
>  	if (dif->bdev)
>  		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
> +	erofs_fscache_unregister_cookie(&dif->fscache);
>  	kfree(dif->path);
>  	kfree(dif);
>  	return 0;
> -- 
> 2.27.0
