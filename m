Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC4731E11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 18:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjFOQny (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 12:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236510AbjFOQnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72BDD2D67
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 09:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1A561F12
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jun 2023 16:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCF1C433C8;
        Thu, 15 Jun 2023 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686847392;
        bh=29UqMzKsugUAu7mXMIRtYH9jxqLb1Je4+7bj236hTb8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=F3kFwHCPwFJb/DBd8wsyfsUvhNvNulgEhWc8Va1EnvZwlcFpUiWjbuLnQwNWMhzYh
         M63Pn2ICZtH88nfS9Z8EIP1wIKbEqBLrR4TBRr3AfmV7nxqgfZYoEaXT8BCuZsGSYX
         wUucwyUM7wVUJdV07e6b5HO3RmaqjK2bROIqXe9kKZa9e+rYdrbaOjKlPTOFlZdP2q
         +iXfxOlDt2AgJjqS5W4k1EPn3QE6IWsAfGGqRJMY/JTwAZ4qyzpXb2vV0FxEx0bY6z
         NMGtx5RVB7RbSJ54S6hqbADLQ6MjDMhGr8IkH1FRl+238n6ydHGh39sU8xZI8AIS0Z
         eyFT+PorSo6EA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DCDE9CE0BB2; Thu, 15 Jun 2023 09:43:11 -0700 (PDT)
Date:   Thu, 15 Jun 2023 09:43:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <0658d317-4f44-4b74-8234-8dc037505f77@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
 <CAEf4BzY-MRYnzGiZmW7AVJYgYdHW1_jOphbipRrHRTtdfq3_wQ@mail.gmail.com>
 <20230525141813.TFZLWM4M@linutronix.de>
 <CAEf4Bzaipoo6X_2Fh5WTV-m0yjP0pvhqi7-FPFtGOrSzNpdGJQ@mail.gmail.com>
 <20230526112356.fOlWmeOF@linutronix.de>
 <CAEf4Bzawgrn2DhR9uvXwFFiLR9g+j4RYC6cr3n+eRD_RoKBAJA@mail.gmail.com>
 <20230605163733.LD-UCcso@linutronix.de>
 <CAEf4BzZ=VZcLZmtRefLtRyRb7uLTb6e=RVw82rxjLNqE=8kT-w@mail.gmail.com>
 <20230614083430.oENawF8f@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614083430.oENawF8f@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:34:30AM +0200, Sebastian Andrzej Siewior wrote:
> bpf_free_inode() is invoked as a RCU callback. Usually RCU callbacks are
> invoked within softirq context. By setting rcutree.use_softirq=0 boot
> option the RCU callbacks will be invoked in a per-CPU kthread with
> bottom halves disabled which implies a RCU read section.
> 
> On PREEMPT_RT the context remains fully preemptible. The RCU read
> section however does not allow schedule() invocation. The latter happens
> in mutex_lock() performed by bpf_trampoline_unlink_prog() originated
> from bpf_link_put().

Just to make sure that I understand, you are proposing that the RCU
callbacks continue to run with BH disabled, but that BH-disabled regions
are preemptible in kernels built with CONFIG_PREEMPT_RT=y?

Or did I miss a turn in there somewhere?

							Thanx, Paul

> It was pointed out that the bpf_link_put() invocation should not be
> delayed if originated from close(). It was also pointed out that other
> invocations from within a syscall should also avoid the workqueue.
> Everyone else should use workqueue by default to remain safe in the
> future (while auditing the code, every caller was preemptible except for
> the RCU case).
> 
> Let bpf_link_put() use the worker unconditionally. Add
> bpf_link_put_direct() which will directly free the resources and is used
> by close() and from within __sys_bpf().
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v3…v4:
>   - Revert back to bpf_link_put_direct() to the direct free and let
>     bpf_link_put() use the worker. Let close() and all invocations from
>     within the syscall use bpf_link_put_direct() which are all instances
>     within syscall.c here.
> 
> v2…v3:
>   - Drop bpf_link_put_direct(). Let bpf_link_put() do the direct free
>     and add bpf_link_put_from_atomic() to do the delayed free via the
>     worker.
> 
> v1…v2:
>    - Add bpf_link_put_direct() to be used from bpf_link_release() as
>      suggested.
> 
>  kernel/bpf/syscall.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 14f39c1e573ee..8f09aef5949d4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2777,28 +2777,31 @@ static void bpf_link_put_deferred(struct work_struct *work)
>  	bpf_link_free(link);
>  }
>  
> -/* bpf_link_put can be called from atomic context, but ensures that resources
> - * are freed from process context
> +/* bpf_link_put might be called from atomic context. It needs to be called
> + * from sleepable context in order to acquire sleeping locks during the process.
>   */
>  void bpf_link_put(struct bpf_link *link)
>  {
>  	if (!atomic64_dec_and_test(&link->refcnt))
>  		return;
>  
> -	if (in_atomic()) {
> -		INIT_WORK(&link->work, bpf_link_put_deferred);
> -		schedule_work(&link->work);
> -	} else {
> -		bpf_link_free(link);
> -	}
> +	INIT_WORK(&link->work, bpf_link_put_deferred);
> +	schedule_work(&link->work);
>  }
>  EXPORT_SYMBOL(bpf_link_put);
>  
> +static void bpf_link_put_direct(struct bpf_link *link)
> +{
> +	if (!atomic64_dec_and_test(&link->refcnt))
> +		return;
> +	bpf_link_free(link);
> +}
> +
>  static int bpf_link_release(struct inode *inode, struct file *filp)
>  {
>  	struct bpf_link *link = filp->private_data;
>  
> -	bpf_link_put(link);
> +	bpf_link_put_direct(link);
>  	return 0;
>  }
>  
> @@ -4764,7 +4767,7 @@ static int link_update(union bpf_attr *attr)
>  	if (ret)
>  		bpf_prog_put(new_prog);
>  out_put_link:
> -	bpf_link_put(link);
> +	bpf_link_put_direct(link);
>  	return ret;
>  }
>  
> @@ -4787,7 +4790,7 @@ static int link_detach(union bpf_attr *attr)
>  	else
>  		ret = -EOPNOTSUPP;
>  
> -	bpf_link_put(link);
> +	bpf_link_put_direct(link);
>  	return ret;
>  }
>  
> @@ -4857,7 +4860,7 @@ static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
>  
>  	fd = bpf_link_new_fd(link);
>  	if (fd < 0)
> -		bpf_link_put(link);
> +		bpf_link_put_direct(link);
>  
>  	return fd;
>  }
> @@ -4934,7 +4937,7 @@ static int bpf_iter_create(union bpf_attr *attr)
>  		return PTR_ERR(link);
>  
>  	err = bpf_iter_new_fd(link);
> -	bpf_link_put(link);
> +	bpf_link_put_direct(link);
>  
>  	return err;
>  }
> -- 
> 2.40.1
> 
