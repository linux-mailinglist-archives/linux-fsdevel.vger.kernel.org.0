Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836954DBEE4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 07:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiCQGFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 02:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiCQGFa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:05:30 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1127FA27CE;
        Wed, 16 Mar 2022 22:36:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0V7Q-ubC_1647495378;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V7Q-ubC_1647495378)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Mar 2022 13:36:20 +0800
Date:   Thu, 17 Mar 2022 13:36:17 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
Subject: Re: [Linux-cachefs] [PATCH v5 10/22] erofs: add mode checking helper
Message-ID: <YjLI0cCcxtg/rEHj@B-P7TQMD6M-0146.local>
Mail-Followup-To: Jeffle Xu <jefflexu@linux.alibaba.com>,
        dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        gregkh@linuxfoundation.org, tao.peng@linux.alibaba.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, luodaowen.backend@bytedance.com,
        eguan@linux.alibaba.com, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-11-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-11-jefflexu@linux.alibaba.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:17:11PM +0800, Jeffle Xu wrote:
> Until then erofs is exactly blockdev based filesystem. In other using
> scenarios (e.g. container image), erofs needs to run upon files.
> 
> This patch set is going to introduces a new nodev mode, in which erofs
> could be mounted from a bootstrap blob file containing complete erofs
> image.
> 
> Add a helper checking which mode erofs works in.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index e424293f47a2..f66af9ebda43 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -161,6 +161,11 @@ struct erofs_sb_info {
>  #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
>  #define test_opt(opt, option)	((opt)->mount_opt & EROFS_MOUNT_##option)
>  
> +static inline bool erofs_bdev_mode(struct super_block *sb)

How about renaming it as erofs_is_nodev_mode()?

Thanks,
Gao Xiang

> +{
> +	return sb->s_bdev;
> +}
> +
>  enum {
>  	EROFS_ZIP_CACHE_DISABLED,
>  	EROFS_ZIP_CACHE_READAHEAD,
> -- 
> 2.27.0
> 
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
