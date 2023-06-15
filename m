Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D19732045
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 21:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjFOTNt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 15:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTNr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:13:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666FA2721;
        Thu, 15 Jun 2023 12:13:46 -0700 (PDT)
Date:   Thu, 15 Jun 2023 21:13:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686856424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBqQ5MILVJDhkoUL+EsKjpNHQkz+R65nlK5QvW31nGY=;
        b=FuvMXHMJ9GlaLrR4VIVbHJe/Zci33pPR1FWbPKpGCHFinIi5YcwAiNgUkzrR6wnab+eIi3
        2wdY6EqWlbkjBYSTgsgNpdzCLC8lNku3jBiJegC1jcObNw06kIdR3pruHOfdWGu4g4yntn
        Fxwj7Tw307EuCyWynOzHIBgvmRSOlx8cj3gAKehnz8sq8oiOt+pPO16SQl28V6Bsy+5SYZ
        jJCOHHS4J1E8w1r/Qx7ffdMaV4vJT9hMBlQmNgplmIVT3LRwEnCY7uB97dGOYNaPc+UvWK
        khE2qlPRE1uD0C2Whk/qucJ37Dbqyc5PE0m88lBNWt2ESKz2m/zrj1CkxBcJ3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686856424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hBqQ5MILVJDhkoUL+EsKjpNHQkz+R65nlK5QvW31nGY=;
        b=dZByaRrGAuq2NkL2btZVujrvvzeoi75tg09EjIcc91DJ5jQWLYWtMaqLiOFHu53EW8N8Oa
        NCdzRnwgJGzz/2CQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230615191341.eAOiYzuZ@linutronix.de>
References: <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
 <20230614083430.oENawF8f@linutronix.de>
 <0658d317-4f44-4b74-8234-8dc037505f77@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0658d317-4f44-4b74-8234-8dc037505f77@paulmck-laptop>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-06-15 09:43:11 [-0700], Paul E. McKenney wrote:
> On Wed, Jun 14, 2023 at 10:34:30AM +0200, Sebastian Andrzej Siewior wrote:
> > bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> > invoked within softirq context. By setting rcutree.use_softirq=0 boot
> > option the RCU callbacks will be invoked in a per-CPU kthread with
> > bottom halves disabled which implies a RCU read section.
> > 
> > On PREEMPT_RT the context remains fully preemptible. The RCU read
> > section however does not allow schedule() invocation. The latter happens
> > in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> > from bpf_link_put().
> 
> Just to make sure that I understand, you are proposing that the RCU
> callbacks continue to run with BH disabled, but that BH-disabled regions
> are preemptible in kernels built with CONFIG_PREEMPT_RT=y?
> 
> Or did I miss a turn in there somewhere?

I'm not proposing anything, just stating what we have. On PREEMPT_RT
you are preemptible within the RCU callback but must not invoke
schedule(). Similar to the RCU read section on CONFIG_PREEMPT where you
are preemptible but must not invoke schedule(). 

> 
> 							Thanx, Paul

Sebastian
