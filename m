Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC9874A0AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 17:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjGFPQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFPQy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 11:16:54 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6071C172B;
        Thu,  6 Jul 2023 08:16:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VmlC6s._1688656603;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VmlC6s._1688656603)
          by smtp.aliyun-inc.com;
          Thu, 06 Jul 2023 23:16:45 +0800
Message-ID: <88a298eb-eb7d-e03b-99b9-ead385894f95@linux.alibaba.com>
Date:   Thu, 6 Jul 2023 23:16:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 22/32] erofs: Convert to use blkdev_get_handle_by_path()
To:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-erofs@lists.ozlabs.org
References: <20230629165206.383-1-jack@suse.cz>
 <20230704122224.16257-22-jack@suse.cz>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230704122224.16257-22-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2023/7/4 20:21, Jan Kara wrote:
> Convert erofs to use blkdev_get_handle_by_path() and pass the handle
> around.
> 
> CC: Gao Xiang <xiang@kernel.org>
> CC: Chao Yu <chao@kernel.org>
> CC: linux-erofs@lists.ozlabs.org
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks for this:
Acked-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>   fs/erofs/data.c     |  4 ++--
>   fs/erofs/internal.h |  2 +-
>   fs/erofs/super.c    | 20 ++++++++++----------
>   3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index db5e4b7636ec..1fa60cfff267 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -222,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   			up_read(&devs->rwsem);
>   			return 0;
>   		}
> -		map->m_bdev = dif->bdev;
> +		map->m_bdev = dif->bdev_handle->bdev;
>   		map->m_daxdev = dif->dax_dev;
>   		map->m_dax_part_off = dif->dax_part_off;
>   		map->m_fscache = dif->fscache;
> @@ -240,7 +240,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   			if (map->m_pa >= startoff &&
>   			    map->m_pa < startoff + length) {
>   				map->m_pa -= startoff;
> -				map->m_bdev = dif->bdev;
> +				map->m_bdev = dif->bdev_handle->bdev;
>   				map->m_daxdev = dif->dax_dev;
>   				map->m_dax_part_off = dif->dax_part_off;
>   				map->m_fscache = dif->fscache;
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 36e32fa542f0..fabd3bb0c194 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -47,7 +47,7 @@ typedef u32 erofs_blk_t;
>   struct erofs_device_info {
>   	char *path;
>   	struct erofs_fscache *fscache;
> -	struct block_device *bdev;
> +	struct bdev_handle *bdev_handle;
>   	struct dax_device *dax_dev;
>   	u64 dax_part_off;
>   
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 9d6a3c6158bd..a4742cc05f95 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -230,7 +230,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>   	struct erofs_fscache *fscache;
>   	struct erofs_deviceslot *dis;
> -	struct block_device *bdev;
> +	struct bdev_handle *bdev_handle;
>   	void *ptr;
>   
>   	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(sb, *pos), EROFS_KMAP);
> @@ -254,13 +254,13 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   			return PTR_ERR(fscache);
>   		dif->fscache = fscache;
>   	} else if (!sbi->devs->flatdev) {
> -		bdev = blkdev_get_by_path(dif->path, BLK_OPEN_READ, sb->s_type,
> -					  NULL);
> -		if (IS_ERR(bdev))
> -			return PTR_ERR(bdev);
> -		dif->bdev = bdev;
> -		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off,
> -						  NULL, NULL);
> +		bdev_handle = blkdev_get_handle_by_path(dif->path,
> +				BLK_OPEN_READ, sb->s_type, NULL);
> +		if (IS_ERR(bdev_handle))
> +			return PTR_ERR(bdev_handle);
> +		dif->bdev_handle = bdev_handle;
> +		dif->dax_dev = fs_dax_get_by_bdev(bdev_handle->bdev,
> +				&dif->dax_part_off, NULL, NULL);
>   	}
>   
>   	dif->blocks = le32_to_cpu(dis->blocks);
> @@ -815,8 +815,8 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
>   	struct erofs_device_info *dif = ptr;
>   
>   	fs_put_dax(dif->dax_dev, NULL);
> -	if (dif->bdev)
> -		blkdev_put(dif->bdev, &erofs_fs_type);
> +	if (dif->bdev_handle)
> +		blkdev_handle_put(dif->bdev_handle);
>   	erofs_fscache_unregister_cookie(dif->fscache);
>   	dif->fscache = NULL;
>   	kfree(dif->path);
