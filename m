Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8467152A776
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbiEQP5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 11:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350691AbiEQP5l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 11:57:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D112DA9E;
        Tue, 17 May 2022 08:57:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EC8B60A51;
        Tue, 17 May 2022 15:57:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE671C385B8;
        Tue, 17 May 2022 15:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652803057;
        bh=owgmp1DiD03PRv6m+MFi+X4+vQ4q8Ap30A0lH1rSqOE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KNTqNJi7fmFYeUkGnyiV8amJYDWm3kSBSpVGLtjJRfsk58bnE2WYxD+veQwDNhkCf
         MsF59Rntla0minCoGJWJCEHIqFrxdtu1SL6WKjbsZiuEPQsU0ANrBxKkvKjHJFZNCO
         be1NB7wIep2R77+DBOwmr81llNwZ/zOwK9dqY6thcuDxLAgbM/AbBpKgwG+hP/0F6R
         XfqpDZEPkME7tSjz+bWN8l8wozWw5zFtr7PUOF/8VDxaCOew5lqcsb6+cVYAa4el6Q
         2gmvlFk6CHJdBgYeA41hNtJD+XMTk6x+Gk/89yrw8Yj0hg622gcZdkCa8K6lArO+Vd
         OFwmJzmiCESOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5D1835C04E7; Tue, 17 May 2022 08:57:37 -0700 (PDT)
Date:   Tue, 17 May 2022 08:57:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Merge adjacent CONFIG_TREE_RCU blocks
Message-ID: <20220517155737.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6931221b532ae7a5cf0eb229ace58acee4f0c1a.1652799977.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 17, 2022 at 05:07:31PM +0200, Geert Uytterhoeven wrote:
> There are two adjacent sysctl entries protected by the same
> CONFIG_TREE_RCU config symbol.  Merge them into a single block to
> improve readability.
> 
> Use the more common "#ifdef" form while at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

If you would like me to take this, please let me know.  (The default
would be not the upcoming merge window, but the one after that.)

If you would rather send it via some other path:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/sysctl.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 82bcf5e3009fa377..597069da18148f42 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2227,7 +2227,7 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -#if defined(CONFIG_TREE_RCU)
> +#ifdef CONFIG_TREE_RCU
>  	{
>  		.procname	= "panic_on_rcu_stall",
>  		.data		= &sysctl_panic_on_rcu_stall,
> @@ -2237,8 +2237,6 @@ static struct ctl_table kern_table[] = {
>  		.extra1		= SYSCTL_ZERO,
>  		.extra2		= SYSCTL_ONE,
>  	},
> -#endif
> -#if defined(CONFIG_TREE_RCU)
>  	{
>  		.procname	= "max_rcu_stall_to_panic",
>  		.data		= &sysctl_max_rcu_stall_to_panic,
> -- 
> 2.25.1
> 
