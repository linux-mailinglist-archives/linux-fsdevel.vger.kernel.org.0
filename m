Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D55A8C0A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 05:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIADty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 23:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIADtw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:49:52 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80332FE;
        Wed, 31 Aug 2022 20:49:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VNul.ye_1662004180;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VNul.ye_1662004180)
          by smtp.aliyun-inc.com;
          Thu, 01 Sep 2022 11:49:41 +0800
Date:   Thu, 1 Sep 2022 11:49:39 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jia Zhu <zhujia.zj@bytedance.com>
Cc:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
Subject: Re: [RFC PATCH 2/5] erofs: introduce fscache-based domain
Message-ID: <YxAr0xdrP0LgCibA@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jia Zhu <zhujia.zj@bytedance.com>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        huyue2@coolpad.com
References: <20220831123125.68693-1-zhujia.zj@bytedance.com>
 <20220831123125.68693-3-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220831123125.68693-3-zhujia.zj@bytedance.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 08:31:22PM +0800, Jia Zhu wrote:
> A new fscache-based shared domain mode is going to be introduced for
> erofs. In which case, same data blobs in same domain will be shared
> and reused to reduce on-disk space usage.
> 
> As the first step, we use pseudo mnt to manage and maintain domain's
> lifecycle.
> 
> The implementation of sharing blobs will be introduced in subsequent
> patches.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/Makefile   |   2 +-
>  fs/erofs/domain.c   | 115 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/fscache.c  |  10 +++-
>  fs/erofs/internal.h |  20 +++++++-
>  fs/erofs/super.c    |  17 ++++---
>  5 files changed, 154 insertions(+), 10 deletions(-)
>  create mode 100644 fs/erofs/domain.c
> 
> diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
> index 99bbc597a3e9..a4af7ecf636f 100644
> --- a/fs/erofs/Makefile
> +++ b/fs/erofs/Makefile
> @@ -5,4 +5,4 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
>  erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
>  erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
>  erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
> -erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
> +erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o domain.o
> diff --git a/fs/erofs/domain.c b/fs/erofs/domain.c
> new file mode 100644
> index 000000000000..6461e4ee3582
> --- /dev/null
> +++ b/fs/erofs/domain.c

`domain` is now still entirely designed for fscache backend.

I'd suggest moving the code below to fscache.c for now until we
could find more use cases more than fscache.

> @@ -0,0 +1,115 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2022, Bytedance Inc. All rights reserved.

Also you could move this line to fscache.c as well.

> + */
> +
> +#include <linux/pseudo_fs.h>
> +#include <linux/fs_context.h>
> +#include <linux/magic.h>
> +#include <linux/fscache.h>
> +
> +#include "internal.h"
> +
> +static DEFINE_SPINLOCK(erofs_domain_list_lock);
> +static LIST_HEAD(erofs_domain_list);
> +
> +void erofs_fscache_domain_get(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	refcount_inc(&domain->ref);
> +}
> +
> +void erofs_fscache_domain_put(struct erofs_domain *domain)
> +{
> +	if (!domain)
> +		return;
> +	if (refcount_dec_and_test(&domain->ref)) {
> +		fscache_relinquish_volume(domain->volume, NULL, false);
> +		spin_lock(&erofs_domain_list_lock);
> +		list_del(&domain->list);
> +		spin_unlock(&erofs_domain_list_lock);
> +		kern_unmount(domain->mnt);
> +		kfree(domain->domain_id);
> +		kfree(domain);
> +	}
> +}
> +
> +static int anon_inodefs_init_fs_context(struct fs_context *fc)
> +{
> +	struct pseudo_fs_context *ctx = init_pseudo(fc, ANON_INODE_FS_MAGIC);
> +
> +	if (!ctx)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static struct file_system_type anon_inode_fs_type = {
> +	.name		= "pseudo_domainfs",
> +	.init_fs_context = anon_inodefs_init_fs_context,
> +	.kill_sb	= kill_anon_super,
> +};

Could we just use erofs filesystem type but with a special sb instead?
No need to cause messes like this.

Thanks,
Gao Xiang
