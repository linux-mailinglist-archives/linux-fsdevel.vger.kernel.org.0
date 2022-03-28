Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68B4E91EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239994AbiC1Jwl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 05:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235436AbiC1Jwk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:52:40 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E4C541BB;
        Mon, 28 Mar 2022 02:50:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V8QUozc_1648461053;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V8QUozc_1648461053)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 28 Mar 2022 17:50:55 +0800
Date:   Mon, 28 Mar 2022 17:50:52 +0800
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
Subject: Re: [PATCH v6 20/22] erofs: implement fscache-based data read for
 data blobs
Message-ID: <YkGE/DtZ3VeddqRL@B-P7TQMD6M-0146.local>
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
 <20220325122223.102958-21-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-21-jefflexu@linux.alibaba.com>
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

On Fri, Mar 25, 2022 at 08:22:21PM +0800, Jeffle Xu wrote:
> Implements the data plane of reading data from data blob file over
> fscache.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/data.c     |  3 +++
>  fs/erofs/fscache.c  | 15 +++++++++++++--
>  fs/erofs/internal.h |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> index b4571bea93d5..b9a05de3c3b2 100644
> --- a/fs/erofs/data.c
> +++ b/fs/erofs/data.c
> @@ -206,6 +206,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  	map->m_bdev = sb->s_bdev;
>  	map->m_daxdev = EROFS_SB(sb)->dax_dev;
>  	map->m_dax_part_off = EROFS_SB(sb)->dax_part_off;
> +	map->m_fscache = EROFS_SB(sb)->bootstrap;
>  
>  	if (map->m_deviceid) {
>  		down_read(&devs->rwsem);
> @@ -217,6 +218,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  		map->m_bdev = dif->bdev;
>  		map->m_daxdev = dif->dax_dev;
>  		map->m_dax_part_off = dif->dax_part_off;
> +		map->m_fscache = dif->blob;
>  		up_read(&devs->rwsem);
>  	} else if (devs->extra_devices) {
>  		down_read(&devs->rwsem);
> @@ -234,6 +236,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
>  				map->m_bdev = dif->bdev;
>  				map->m_daxdev = dif->dax_dev;
>  				map->m_dax_part_off = dif->dax_part_off;
> +				map->m_fscache = dif->blob;
>  				break;
>  			}
>  		}
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index d75958470645..cbb39657615e 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -63,9 +63,20 @@ static int erofs_fscache_readpage_blob(struct file *data, struct page *page)
>  static inline int erofs_fscache_get_map(struct erofs_map_blocks *map,
>  					struct super_block *sb)
>  {

So erofs_fscache_get_map seems really unneeded...
erofs_map_dev can be used directly so we can avoid this patch.

Thanks,
Gao Xiang

> -	struct erofs_sb_info *sbi = EROFS_SB(sb);
> +	struct erofs_map_dev mdev;
> +	int ret;
> +
> +	mdev = (struct erofs_map_dev) {
> +		.m_deviceid = map->m_deviceid,
> +		.m_pa = map->m_pa,
> +	};
> +
> +	ret = erofs_map_dev(sb, &mdev);
> +	if (ret)
> +		return ret;
>  
> -	map->m_fscache	= sbi->bootstrap;
> +	map->m_fscache	= mdev.m_fscache;
> +	map->m_pa	= mdev.m_pa;
>  	return 0;
>  }
>  
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 94a118caf580..cea08f12a2c3 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -487,6 +487,7 @@ struct erofs_map_dev {
>  	struct block_device *m_bdev;
>  	struct dax_device *m_daxdev;
>  	u64 m_dax_part_off;
> +	struct erofs_fscache *m_fscache;
>  
>  	erofs_off_t m_pa;
>  	unsigned int m_deviceid;
> -- 
> 2.27.0
