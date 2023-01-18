Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D80672996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 21:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjARUlE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 15:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjARUlB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 15:41:01 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76CD4A202;
        Wed, 18 Jan 2023 12:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=md4uxanlxoNCe8b7gZ4uQll2YVbv50mEZqFSNP3ZnLU=; b=ILnzoL+FrViTUNFXn7/4Gknk1C
        Hq3IMtMMl24o/v4Rk232I9bNeFJ8Vy0p0oF387AqCU8GVxQR9wkPOUH7oZ4PAFsk1YvfXRs3NFpqF
        cr3w+1BNURAhHpGsoZmlnj/LoKnn5jy2n7aryqPFSVRzRBbnOyvTmxBerMZqvmAcNlbu9g1WfWnHE
        NeUiWw2n5QyW3cReWUPgFLVbLLdx8tqHbCkomzUvpJVvUmLVUf65FeaXkUzuLyFP5NuUvGUG7fCZ1
        +P8Ic49FpE3HdcMkaBW6oEbh75zvK8Zm+SiBgomFNP8VrOderQ4P57tgzm5XjBwpLp/F1qMWS93Oh
        u4aPJMtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pIFE7-00067h-1t;
        Wed, 18 Jan 2023 20:40:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4B06A300094;
        Wed, 18 Jan 2023 21:40:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C87823BD9D65; Wed, 18 Jan 2023 21:40:33 +0100 (CET)
Date:   Wed, 18 Jan 2023 21:40:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Message-ID: <Y8hZQI6UfDHhH3tj@hirez.programming.kicks-ass.net>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-2-gregory.price@memverge.com>
 <Y8gpZ+T/re7mEDjB@hirez.programming.kicks-ass.net>
 <CAD3UvdSpOMAOUm1CYJ5vOyEsiVZCQdiWaTmXjq1vWVFq1DhQ0w@mail.gmail.com>
 <Y8hNS4aCkkOLv1M/@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8hNS4aCkkOLv1M/@memverge.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:49:31PM -0500, Gregory Price wrote:
> On Wed, Jan 18, 2023 at 02:41:00PM -0500, Gregory Price wrote:
> > ---------- Forwarded message ---------
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Wed, Jan 18, 2023 at 12:16 PM
> > Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall
> > User Dispatch Suspension
> > To: Gregory Price <gourry.memverge@gmail.com>
> > 
> > 
> > On Mon, Jan 09, 2023 at 10:33:46AM -0500, Gregory Price wrote:
> > > @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
> > >       struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> > >       char state;
> > >
> > > +     if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
> > > +                     unlikely(current->ptrace &
> > PT_SUSPEND_SYSCALL_USER_DISPATCH))
> > > +             return false;
> > > +
> > >       if (likely(instruction_pointer(regs) - sd->offset < sd->len))
> > >               return false;
> > >
> > 
> > So by making syscall_user_dispatch() return false, we'll make
> > syscall_trace_enter() continue to handle things, and supposedly you want
> > to land in ptrace_report_syscall_entry(), right?
> >
> > ... snip ...
> > 
> > Should setting this then not also depend on having
> > SYSCALL_WORK_SYSCALL_TRACE set? Because without that, you get 'funny'
> > things.
> 
> Hm, this is an interesting question.  My thoughts are that I want the
> process to handle the syscall as-if syscall user dispatch was not
> present at all, regardless of SYSCALL_TRACE.
> 
> This is because some software, like CRIU, actually injects syscalls to
> run in the context of the software in an effort to collect resources.

Oh, right. I used to know that.

> So I actually *want* those 'funny' things to occur, because they're most
> likely intentional.  I don't necessarily want to intercept system calls
> that subsequently occur (although i might).
> 
> So if this feature required SYSCALL_TRACE, you would no longer be able
> to inject system calls ala CRIU.

Yeah, I suppose you're right. It makes it a very sharp instrument, but I
suppose you get what you asked for.
