Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71846718EE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 01:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjEaXAd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 19:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjEaXAa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 19:00:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B17395
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:00:29 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f829e958bdso381761cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 May 2023 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1685574028; x=1688166028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0HZUJ9Xeqz50b7aBXXY0k1OB628If4tjQVlpNYXbrg=;
        b=c8ZnTjaDbmcWq232e1fAz87Ax0uKnggDk315cWcJWO7m03O4hnSMc/qW+z614a/wp7
         US4EIJHOEIj2moCfN3Sugp1Xc5F3Q7qNCigyjQAxHFG90WvN29ABQDJbFcZfFFKMYA7a
         XEQfUrG5eOsmFFkkl4gbleMC3rT9/fPoVa6LcSkb27skfJCl7HABL68aXIqeGwrb0fws
         X5wHH8VprVcsyfyT6ffZIfbEV88bobWh6E6Mko4F0gYRtVfo7plEO/KGNp/VxdkUIJ6m
         VZUnFRR1vwZuFWgR3q9qY8jdjY3Wnurq6GL2d3OJ18IeV15E88JH+WJs4scrK8AlI/+c
         k10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685574028; x=1688166028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0HZUJ9Xeqz50b7aBXXY0k1OB628If4tjQVlpNYXbrg=;
        b=Z0XvVcMSHryHv40he7D2/K7BU645WztEwVP11+0iG63z6r88duTy2NfazcMCUnVpwe
         nexmpQKPY5R3zfOSIA5X2xPAM12F6Tfhso1ftA/JtGhnWLRnFAAgskaKZY0CjS/eKACm
         ydNJ7NkkqXM8e4m8vBUiDNZ0CyPOdGXuHyxLiWc6XGNqW4pzpmaaTTDOs2zhTNuDiadX
         fkPvcNeyWB0K3XPfuTHURWl3FGPWDdYrEEzHtqHBIYTVoB+Gp8qVCR9cnLc0MsQuWVrB
         sb0xYf+pBni3+KtGYVkGMDqATgZ4XTh2E7vuhWoeh/INNTLktkD5hM44HZhmZBVAMpBW
         HgZQ==
X-Gm-Message-State: AC+VfDxFuaGpO2i0bfFkPxDlPSnztw7cCnRiAosxi57s6ufFMRja3+gc
        EElfO0znaETuSSRltnWdXw6yPg==
X-Google-Smtp-Source: ACHHUZ6Z8dVuendKvwp2Tyj/JbX1Kz/VEmTb75NYE8IZtQGpnk80VhFF8Lu8uqvpxB+QQ3TF2qQczg==
X-Received: by 2002:a05:622a:198f:b0:3f6:c52e:21bc with SMTP id u15-20020a05622a198f00b003f6c52e21bcmr7769143qtc.19.1685574028426;
        Wed, 31 May 2023 16:00:28 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-188.pa.nsw.optusnet.com.au. [49.179.0.188])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b001ae6fe84244sm1912225plb.243.2023.05.31.16.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 16:00:27 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q4Unp-006Hhv-1I;
        Thu, 01 Jun 2023 09:00:25 +1000
Date:   Thu, 1 Jun 2023 09:00:25 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Qi Zheng <qi.zheng@linux.dev>
Cc:     akpm@linux-foundation.org, tkhai@ya.ru, roman.gushchin@linux.dev,
        vbabka@suse.cz, viro@zeniv.linux.org.uk, brauner@kernel.org,
        djwong@kernel.org, hughd@google.com, paulmck@kernel.org,
        muchun.song@linux.dev, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH 3/8] fs: move list_lru_destroy() to destroy_super_work()
Message-ID: <ZHfRiUjiK/Z0yuUX@dread.disaster.area>
References: <20230531095742.2480623-1-qi.zheng@linux.dev>
 <20230531095742.2480623-4-qi.zheng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531095742.2480623-4-qi.zheng@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 31, 2023 at 09:57:37AM +0000, Qi Zheng wrote:
> From: Kirill Tkhai <tkhai@ya.ru>
> 
> The patch makes s_dentry_lru and s_inode_lru be destroyed
> later from the workqueue. This is preparation to split
> unregister_shrinker(super_block::s_shrink) in two stages,
> and to call finalize stage from destroy_super_work().
> 
> Note, that generic filesystem shrinker unregistration
> is safe to be split in two stages right after this
> patch, since super_cache_count() and super_cache_scan()
> have a deal with s_dentry_lru and s_inode_lru only.
> 
> But there are two exceptions: XFS and SHMEM, which
> define .nr_cached_objects() and .free_cached_objects()
> callbacks. These two do not allow us to do the splitting
> right after this patch. They touch fs-specific data,
> which is destroyed earlier, than destroy_super_work().
> So, we can't call unregister_shrinker_delayed_finalize()
> from destroy_super_work() because of them, and next
> patches make preparations to make this possible.
> 
> Signed-off-by: Kirill Tkhai <tkhai@ya.ru>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  fs/super.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 8d8d68799b34..2ce4c72720f3 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -159,6 +159,11 @@ static void destroy_super_work(struct work_struct *work)
>  							destroy_work);
>  	int i;
>  
> +	WARN_ON(list_lru_count(&s->s_dentry_lru));
> +	WARN_ON(list_lru_count(&s->s_inode_lru));
> +	list_lru_destroy(&s->s_dentry_lru);
> +	list_lru_destroy(&s->s_inode_lru);
> +
>  	for (i = 0; i < SB_FREEZE_LEVELS; i++)
>  		percpu_free_rwsem(&s->s_writers.rw_sem[i]);
>  	kfree(s);
> @@ -177,8 +182,6 @@ static void destroy_unused_super(struct super_block *s)
>  	if (!s)
>  		return;
>  	up_write(&s->s_umount);
> -	list_lru_destroy(&s->s_dentry_lru);
> -	list_lru_destroy(&s->s_inode_lru);
>  	security_sb_free(s);
>  	put_user_ns(s->s_user_ns);
>  	kfree(s->s_subtype);
> @@ -287,8 +290,6 @@ static void __put_super(struct super_block *s)
>  {
>  	if (!--s->s_count) {
>  		list_del_init(&s->s_list);
> -		WARN_ON(s->s_dentry_lru.node);
> -		WARN_ON(s->s_inode_lru.node);

Why are you removing the wanrings from here? Regardless of where
we tear down the lru lists, they *must* be empty here otherwise we
have a memory leak. Hence I don't think these warnings should be
moved at all.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
