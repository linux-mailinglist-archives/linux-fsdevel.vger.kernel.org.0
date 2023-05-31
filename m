Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E1718EDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 00:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjEaW5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 18:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjEaW5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 18:57:40 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82F6107
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:57:38 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-19f31d6b661so364471fac.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 15:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685573858; x=1688165858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hu0DKnynpdBIeYnyWz2HVJfbhb3koTdW7dRzhdCwkpE=;
        b=C+vo8MF6j6b26zd/kzN7FloSBAwgpYOfsZzLbtMx0PS/lge+w0N9lHeWtQY7X36TYm
         cF1mChKOnlQYeDMXZhoZVhC9hMmlz8Q26FJzvKc0cxBqc8YIVIziVwzJTHdEJoIKO7rm
         1MIELHU0YEvn0Dz26LPsqCWVIBn9kif+HqJ8iEzx9/Xg0kNl3HBBoheSivZ5R0+rIoq4
         TYsoDTwG3PsPYiwkS3pDVby4KnLVifMBamUTJQkOjcVerkyaElp8UdqIvs0M9b3mdtYH
         h7BIkdD70b8bmxMd+aqnnDTW4VG9sj4r6ckkbI5SWgZBdY0rKk4aumSdAahQfoVXqntH
         pG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685573858; x=1688165858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hu0DKnynpdBIeYnyWz2HVJfbhb3koTdW7dRzhdCwkpE=;
        b=WIoCGSfkh8XduMWjuFVltcpGwSZQFbG6hIMhcfGQ3VabPWWuNTjVJ/r8DWTR+rFomi
         DGr9mjNxFA9iwKsuOPiNIG5tF/OL24EcrCVOvpZZqSJ8C4cz6C0DRY6Uk3KWNKBwzzHZ
         KjwcGtFvmZMGczovxIylgTMWYRPTa1xjhIh0QxmjBoOu+OZbL3AGpF3jxqJOhXaRglTk
         u7NKNAjP2zgW3c7u1w5FWn/elUeM5Aj/aKSKlxswtyNhsgZDojhqhTZI9HSZCbvJ/Iw2
         fEBQ9A4nE7iikkAWfSwVSj4jg0ljQX9XJf9DyHlRunO141cbZLl9HWWyYxMoL0EimjNe
         qcDQ==
X-Gm-Message-State: AC+VfDwpgkDfLp9yYnDwbyXM9OX4Np2aCnQDHdwoTLO/2lowxaFUYg4p
        m8jDxFX3pBpmWgvDFcChoNhC8A==
X-Google-Smtp-Source: ACHHUZ7+S8SpNNc9Gy8ZY/8ExdkaNqqUpWjOsfKLh/C3mvnAwfubkjJMA4xthDeXFgyOoB8qNU5WXA==
X-Received: by 2002:a05:6870:3747:b0:19f:16fc:3c51 with SMTP id a7-20020a056870374700b0019f16fc3c51mr4522675oak.9.1685573858247;
        Wed, 31 May 2023 15:57:38 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id x38-20020a634866000000b0053fc6df5895sm1812332pgk.39.2023.05.31.15.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:57:37 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4Ul4-006Hcf-0h;
        Thu, 01 Jun 2023 08:57:34 +1000
Date:   Thu, 1 Jun 2023 08:57:34 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 2/8] mm: vmscan: split unregister_shrinker()
Message-ID: <ZHfQ3gzFToAfee/d@dread.disaster.area>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-3-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-3-qi.zheng@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:36AM +0000, Qi Zheng wrote:
> From: Kirill Tkhai <tkhai@ya.ru>
> 
> This and the next patches in this series aim to make
> time effect of synchronize_srcu() invisible for user.
> The patch splits unregister_shrinker() in two functions:
> 
> 	unregister_shrinker_delayed_initiate()
> 	unregister_shrinker_delayed_finalize()
> 
> and shrinker users may make the second of them to be called
> asynchronous (e.g., from workqueue). Next patches make
> superblock shrinker to follow this way, so user-visible
> umount() time won't contain delays from synchronize_srcu().
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/shrinker.h |  2 ++
>  mm/vmscan.c              | 22 ++++++++++++++++++----
>  2 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 224293b2dd06..e9d5a19d83fe 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -102,6 +102,8 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
>  extern int __printf(2, 3) register_shrinker(struct shrinker *shrinker,
>  					    const char *fmt, ...);
>  extern void unregister_shrinker(struct shrinker *shrinker);
> +extern void unregister_shrinker_delayed_initiate(struct shrinker *shrinker);
> +extern void unregister_shrinker_delayed_finalize(struct shrinker *shrinker);
>  extern void free_prealloced_shrinker(struct shrinker *shrinker);
>  extern void synchronize_shrinkers(void);
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index a773e97e152e..baf8d2327d70 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -799,10 +799,7 @@ int register_shrinker(struct shrinker *shrinker, const char *fmt, ...)
>  #endif
>  EXPORT_SYMBOL(register_shrinker);
>  
> -/*
> - * Remove one
> - */
> -void unregister_shrinker(struct shrinker *shrinker)
> +void unregister_shrinker_delayed_initiate(struct shrinker *shrinker)
>  {
>  	struct dentry *debugfs_entry;
>  	int debugfs_id;
> @@ -819,6 +816,13 @@ void unregister_shrinker(struct shrinker *shrinker)
>  	mutex_unlock(&shrinker_mutex);
>  
>  	shrinker_debugfs_remove(debugfs_entry, debugfs_id);
> +}
> +EXPORT_SYMBOL(unregister_shrinker_delayed_initiate);
> +
> +void unregister_shrinker_delayed_finalize(struct shrinker *shrinker)
> +{
> +	if (!shrinker->nr_deferred)
> +		return;

This is new logic and isn't explained anywhere: why do we want to
avoid RCU cleanup if (shrinker->nr_deferred == 0)? Regardless,
whatever this is avoiding, it needs a comment to explain it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
