Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183BB6A67F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 08:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCAHI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 02:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAHIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:08:55 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F37ED3;
        Tue, 28 Feb 2023 23:08:53 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VcpPL0Q_1677654528;
Received: from 30.97.48.239(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VcpPL0Q_1677654528)
          by smtp.aliyun-inc.com;
          Wed, 01 Mar 2023 15:08:49 +0800
Message-ID: <c3c10f27-7941-6ccc-fa60-b5a289bf03ba@linux.alibaba.com>
Date:   Wed, 1 Mar 2023 15:08:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] erofs: support for mounting a single block device with
 multiple devices
To:     Jia Zhu <zhujia.zj@bytedance.com>, xiang@kernel.org,
        chao@kernel.org, gerry@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jefflexu@linux.alibaba.com, huyue2@coolpad.com,
        Xin Yin <yinxin.x@bytedance.com>
References: <20230301070417.13084-1-zhujia.zj@bytedance.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230301070417.13084-1-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jia,

On 2023/3/1 15:04, Jia Zhu wrote:
> In order to support mounting multi-layer container image as a block
> device, add single block device with multiple devices feature for EROFS.

In order to support mounting multi-blob container image as a single
flattened block device, add flattened block device feature for EROFS.

> 
> In this mode, all meta/data contents will be mapped into one block address.
> User could directly mount the block device by EROFS.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> Reviewed-by: Xin Yin <yinxin.x@bytedance.com>
> ---
>   fs/erofs/data.c  | 8 ++++++--
>   fs/erofs/super.c | 5 +++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index e16545849ea7..870b1f7fe1d4 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -195,9 +195,9 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   {
>   	struct erofs_dev_context *devs = EROFS_SB(sb)->devs;
>   	struct erofs_device_info *dif;
> +	bool flatdev = !!sb->s_bdev;

I'd like to land it in sbi and set it in advance?

Also, did you test this patch?

Thanks,
Gao Xiang


>   	int id;
>   
> -	/* primary device by default */
>   	map->m_bdev = sb->s_bdev;
>   	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>   	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
> @@ -210,12 +210,16 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>   			up_read(&devs->rwsem);
>   			return -ENODEV;
>   		}
> +		if (flatdev) {
> +			map->m_pa += blknr_to_addr(dif->mapped_blkaddr);
> +			map->m_deviceid = 0;
> +		}
>   		map->m_bdev = dif->bdev;
>   		map->m_daxdev = dif->dax_dev;
>   		map->m_dax_part_off = dif->dax_part_off;
>   		map->m_fscache = dif->fscache;
>   		up_read(&devs->rwsem);
> -	} else if (devs->extra_devices) {
> +	} else if (devs->extra_devices && !flatdev) {
>   		down_read(&devs->rwsem);
>   		idr_for_each_entry(&devs->tree, dif, id) {
>   			erofs_off_t startoff, length;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 19b1ae79cec4..4f9725b0950c 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -226,6 +226,7 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   	struct erofs_fscache *fscache;
>   	struct erofs_deviceslot *dis;
>   	struct block_device *bdev;
> +	bool flatdev = !!sb->s_bdev;
>   	void *ptr;
>   
>   	ptr = erofs_read_metabuf(buf, sb, erofs_blknr(*pos), EROFS_KMAP);
> @@ -248,6 +249,10 @@ static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
>   		if (IS_ERR(fscache))
>   			return PTR_ERR(fscache);
>   		dif->fscache = fscache;
> +	} else if (flatdev) {
> +		dif->bdev = sb->s_bdev;
> +		dif->dax_dev = EROFS_SB(sb)->dax_dev;
> +		dif->dax_part_off = sbi->dax_part_off;
>   	} else {
>   		bdev = blkdev_get_by_path(dif->path, FMODE_READ | FMODE_EXCL,
>   					  sb->s_type);
