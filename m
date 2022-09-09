Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F69E5B34AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIIJzt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 05:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIIJzs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:55:48 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D6D51DE;
        Fri,  9 Sep 2022 02:55:45 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VP9-zDX_1662717341;
Received: from 30.221.130.74(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VP9-zDX_1662717341)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:55:42 +0800
Message-ID: <3f75d266-7ccd-be6d-657c-fe0633b25687@linux.alibaba.com>
Date:   Fri, 9 Sep 2022 17:55:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH V2 4/5] erofs: remove duplicated unregister_cookie
Content-Language: en-US
To:     Jia Zhu <zhujia.zj@bytedance.com>, linux-erofs@lists.ozlabs.org,
        xiang@kernel.org, chao@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, huyue2@coolpad.com
References: <20220902105305.79687-1-zhujia.zj@bytedance.com>
 <20220902105305.79687-5-zhujia.zj@bytedance.com>
From:   JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <20220902105305.79687-5-zhujia.zj@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/2/22 6:53 PM, Jia Zhu wrote:
> In erofs umount scenario, erofs_fscache_unregister_cookie() is called
> twice in kill_sb() and put_super().
> 
> It works for original semantics, cause 'ctx' will be set to NULL in
> put_super() and will not be unregister again in kill_sb().
> However, in shared domain scenario, we use refcount to maintain the
> lifecycle of cookie. Unregister the cookie twice will cause it to be
> released early.
> 
> For the above reasons, this patch removes duplicate unregister_cookie
> and move fscache_unregister_* before shotdown_super() to prevent busy
> inode(ctx->inode) when umount.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/erofs/super.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 69de1731f454..667a78f0ee70 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -919,19 +919,20 @@ static void erofs_kill_sb(struct super_block *sb)
>  		kill_litter_super(sb);
>  		return;
>  	}
> -	if (erofs_is_fscache_mode(sb))
> -		generic_shutdown_super(sb);
> -	else
> -		kill_block_super(sb);
> -
>  	sbi = EROFS_SB(sb);
>  	if (!sbi)
>  		return;
>  
> +	if (erofs_is_fscache_mode(sb)) {
> +		erofs_fscache_unregister_cookie(&sbi->s_fscache);
> +		erofs_fscache_unregister_fs(sb);
> +		generic_shutdown_super(sb);

Generally we can't do clean ups before generic_shutdown_super(), since
generic_shutdown_super() may trigger IO, e.g. in sync_filesystem(),
though it's not the case for erofs (read-only).

How about embedding erofs_fscache_unregister_cookie() into
erofs_fscache_unregister_fs(), and thus we can check domain_id in
erofs_fscache_unregister_fs()?

> +	} else {
> +		kill_block_super(sb);
> +	}
> +
>  	erofs_free_dev_context(sbi->devs);
>  	fs_put_dax(sbi->dax_dev, NULL);
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
> -	erofs_fscache_unregister_fs(sb);
>  	kfree(sbi->opt.fsid);
>  	kfree(sbi->opt.domain_id);
>  	kfree(sbi);
> @@ -951,7 +952,6 @@ static void erofs_put_super(struct super_block *sb)
>  	iput(sbi->managed_cache);
>  	sbi->managed_cache = NULL;
>  #endif
> -	erofs_fscache_unregister_cookie(&sbi->s_fscache);
>  }
>  
>  struct file_system_type erofs_fs_type = {

-- 
Thanks,
Jingbo
