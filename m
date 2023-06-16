Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C4A7335F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 18:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244144AbjFPQaW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 12:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFPQaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A21297A
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 09:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD2FC61B95
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 16:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2EEA5C433C0;
        Fri, 16 Jun 2023 16:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686933020;
        bh=5uu+YHj0xfgHXctEozIuOa6T5BFR5lY8KLB5ut6qO2M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nkO/pZ92LpgE8VJfscCdh1Pc2ImBDE4RFPJ854rBJ4z6NnHvz+H5MlvzWzxYqVH+Z
         q3YEn83LWKy1wx/JJ6/tSKYTcWcHnAFcBemEyBpYc6eLfGXqQ2UpZC9EbW519PnrSi
         eNaGx8JZEEUaseKy9v3e6lB2dWykrDzdpGj91r04ZlgD7oaJPmYpq+2ec1genoNIXu
         XnL2AbVd87NyMlMkuI6uQ+DvCNmGig+X68AGDJuqIBFMMr5yeFqqpIZcb0eLg4eB12
         oWbd2sNxUmFACrk8mWmkIxdshvvT8isIhaxMZsHJgCinohKAh+V5a31LPodTcw5iAC
         e03zN1bwnC42Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 084F5E21EEA;
        Fri, 16 Jun 2023 16:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] bpf: Remove in_atomic() from bpf_link_put().
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168693302002.15027.13621981423578755110.git-patchwork-notify@kernel.org>
Date:   Fri, 16 Jun 2023 16:30:20 +0000
References: <20230614083430.oENawF8f@linutronix.de>
In-Reply-To: <20230614083430.oENawF8f@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     andrii.nakryiko@gmail.com, alexei.starovoitov@gmail.com,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        john.fastabend@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, linux-fsdevel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Wed, 14 Jun 2023 10:34:30 +0200 you wrote:
> bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> invoked within softirq context. By setting rcutree.use_softirq=0 boot
> option the RCU callbacks will be invoked in a per-CPU kthread with
> bottom halves disabled which implies a RCU read section.
> 
> On PREEMPT_RT the context remains fully preemptible. The RCU read
> section however does not allow schedule() invocation. The latter happens
> in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> from bpf_link_put().
> 
> [...]

Here is the summary with links:
  - [v4] bpf: Remove in_atomic() from bpf_link_put().
    https://git.kernel.org/bpf/bpf-next/c/ab5d47bd41b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


