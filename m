Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B967E4E7458
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 14:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357465AbiCYNnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 09:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCYNnX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:43:23 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD28CFBBB;
        Fri, 25 Mar 2022 06:41:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0V89jU5E_1648215702;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V89jU5E_1648215702)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Mar 2022 21:41:44 +0800
Date:   Fri, 25 Mar 2022 21:41:42 +0800
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
Subject: Re: [PATCH v6 12/22] erofs: add cookie context helper functions
Message-ID: <Yj3GlpvjL3u0RTjN@B-P7TQMD6M-0146.local>
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
 <20220325122223.102958-13-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325122223.102958-13-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle,

On Fri, Mar 25, 2022 at 08:22:13PM +0800, Jeffle Xu wrote:
> Introduce "struct erofs_fscache" for managing cookie for backinig file,
> and helper functions for initializing and cleaning up this context
> structure.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/fscache.c  | 61 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/internal.h | 14 +++++++++++
>  2 files changed, 75 insertions(+)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 08cf570a0810..73235fd43bf6 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -7,6 +7,67 @@
>  
>  static struct fscache_volume *volume;
>  
> +static int erofs_fscache_init_cookie(struct erofs_fscache *ctx, char *path)
> +{
> +	struct fscache_cookie *cookie;
> +
> +	cookie = fscache_acquire_cookie(volume, FSCACHE_ADV_WANT_CACHE_SIZE,
> +					path, strlen(path),
> +					NULL, 0, 0);

It'd be better to rearrange in one line?

					path, strlen(path), NULL, 0, 0);

> +	if (!cookie)
> +		return -EINVAL;
> +
> +	fscache_use_cookie(cookie, false);
> +	ctx->cookie = cookie;
> +	return 0;
> +}
> +
> +static inline void erofs_fscache_cleanup_cookie(struct erofs_fscache *ctx)
> +{
> +	struct fscache_cookie *cookie = ctx->cookie;
> +
> +	fscache_unuse_cookie(cookie, NULL, NULL);
> +	fscache_relinquish_cookie(cookie, false);
> +	ctx->cookie = NULL;
> +}
> +
> +/*
> + * erofs_fscache_get - create an fscache context for blob file
> + * @sb:		superblock
> + * @path:	name of blob file
> + *
> + * Return: fscache context on success, ERR_PTR() on failure.
> + */
> +struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path)

erofs_fscache_register?

> +{
> +	struct erofs_fscache *ctx;
> +	int ret;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = erofs_fscache_init_cookie(ctx, path);

Can we fold it here? No need to introduce such simple wrapper..

> +	if (ret) {
> +		erofs_err(sb, "failed to init cookie");

It would be better to print the path?

> +		goto err;

		kfree(ctx);
		return ERR_PTR(ret);

At least for now.

> +	}
> +
> +	return ctx;
> +err:
> +	kfree(ctx);
> +	return ERR_PTR(ret);
> +}
> +
> +void erofs_fscache_put(struct erofs_fscache *ctx)

erofs_fscache_unregister?

> +{
> +	if (!ctx)
> +		return;
> +
> +	erofs_fscache_cleanup_cookie(ctx);

Fold it too, since such helper doesn't simplify code a lot but need
to take one more time to redirect..

Thanks,
Gao Xiang

> +	kfree(ctx);
> +}
> +
>  int __init erofs_init_fscache(void)
>  {
>  	volume = fscache_acquire_volume("erofs", NULL, NULL, 0);
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 45b8b0dd8a27..d4f2b43cedae 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -96,6 +96,10 @@ struct erofs_sb_lz4_info {
>  	u16 max_pclusterblks;
>  };
>  
> +struct erofs_fscache {
> +	struct fscache_cookie *cookie;
> +};
> +
>  struct erofs_sb_info {
>  	struct erofs_mount_opts opt;	/* options */
>  #ifdef CONFIG_EROFS_FS_ZIP
> @@ -620,9 +624,19 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
>  #ifdef CONFIG_EROFS_FS_ONDEMAND
>  int erofs_init_fscache(void);
>  void erofs_exit_fscache(void);
> +
> +struct erofs_fscache *erofs_fscache_get(struct super_block *sb, char *path);
> +void erofs_fscache_put(struct erofs_fscache *ctx);
>  #else
>  static inline int erofs_init_fscache(void) { return 0; }
>  static inline void erofs_exit_fscache(void) {}
> +
> +static inline struct erofs_fscache *erofs_fscache_get(struct super_block *sb,
> +						      char *path)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +static inline void erofs_fscache_put(struct erofs_fscache *ctx) {}
>  #endif
>  
>  #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
> -- 
> 2.27.0
