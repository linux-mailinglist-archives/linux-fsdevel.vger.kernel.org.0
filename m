Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662BD4E91BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 11:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiC1JuQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239926AbiC1JuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:50:15 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047BA31216;
        Mon, 28 Mar 2022 02:48:33 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8QUoPW_1648460907;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8QUoPW_1648460907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 17:48:29 +0800
Date:   Mon, 28 Mar 2022 17:48:26 +0800
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
        fannaihao@baidu.com
Subject: Re: [PATCH v6 19/22] erofs: register cookie context for data blobs
Message-ID: <YkGEasaBSCwfGdj3@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        tao.peng@linux.alibaba.com, gerry@linux.alibaba.com,
        eguan@linux.alibaba.com, linux-kernel@vger.kernel.org,
        luodaowen.backend@bytedance.com, tianzichen@kuaishou.com,
        fannaihao@baidu.com
References: <20220325122223.102958-1-jefflexu@linux.alibaba.com>
 <20220325122223.102958-20-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-20-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 25, 2022 at 08:22:20PM +0800, Jeffle Xu wrote:
> Similar to the multi device mode, erofs could be mounted from multiple
> blob files (one bootstrap blob file and optional multiple data blob
> files). In this case, each device slot contains the path of
> corresponding data blob file.
> 
> Registers corresponding cookie context for each data blob file.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  1 +
>  fs/erofs/super.c    | 30 ++++++++++++++++++++++--------
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 6537ededed51..94a118caf580 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -52,6 +52,7 @@ struct erofs_device_info {
>  	struct block_device *bdev;
>  	struct dax_device *dax_dev;

Place
	struct erofs_fscache *fscache;

>  	u64 dax_part_off;
> +	struct erofs_fscache *blob;

Instead here since `blob' is also nydus-specific.

Need to update the subject and commit message too.

>  
>  	u32 blocks;
>  	u32 mapped_blkaddr;
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index de5aeda4aea0..9a6f35e0c22b 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -259,15 +259,28 @@ static int erofs_init_devices(struct super_block *sb,
>  		}
>  		dis = ptr + erofs_blkoff(pos);
>  
> -		bdev = blkdev_get_by_path(dif->path,
> -					  FMODE_READ | FMODE_EXCL,
> -					  sb->s_type);
> -		if (IS_ERR(bdev)) {
> -			err = PTR_ERR(bdev);
> -			break;
> +		if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) &&
> +		    erofs_is_nodev_mode(sb)) {
> +			struct erofs_fscache *blob;

Same here.

Thanks,
Gao Xiang
