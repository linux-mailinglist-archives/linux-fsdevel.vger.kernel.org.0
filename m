Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2040E2FA778
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 18:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393707AbhARR1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 12:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393637AbhARR0a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:26:30 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CD0C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 09:25:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u19so18479580edx.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 09:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nm6HrK7oawuOwyXp1xJbpJjKfOkLLT1pH7TKml+09Lw=;
        b=oFaSiW4769WFoFpssMgp5qXiVVVfMhM+HhdNLvMoO+a7WHxDuc3F7Yx8KH2D+XBtIE
         AOTsbnBbbLoRTx+ePSnZnEevl1yeTf8/wUNvTuk84MQPbcxHj2Lk9Vkm185AZh5LefEt
         uCI4jqnVCtrwMNS6UgOgGod1dK9lAPkVYz+XgXDBNEXaoTJVPB0cEE+c6R9wb28q/beg
         /Uzw7qaBWrSL4q7B9FyxycJGvtbRp3YElk7cC0KvKCwvt8chEqaIka7EOqCbyK573qf4
         2yV1/urXsnpnH/RPH2PQIa4LohTNvZEOkBe38uAJnd4o5ZLjB8BC9FgLKWyEu1ntFdXe
         rrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nm6HrK7oawuOwyXp1xJbpJjKfOkLLT1pH7TKml+09Lw=;
        b=qQM/e63jKcLAFx6j1z7GmGkBHEy09yZBNUxcacqgk8vANYZuY5gIfCz/QUvIo4d9rn
         dr7vPlAiZpyxSNNphmBD/lRnjEvGSOtQGfePZ69B3Sfcgok7H2ccuihk6EXSNZNca04w
         cFJzdDZvYvsicSMw4lOoGruk1MhpLtP/cGyOdB6Vi7/iMjh44Ez+HUvNd4rHQXKJ9qUK
         BEmzGqlU1x5OeK3KM0Yo/tbslpFcndFyNckf05WODqBlr/FyEyNdKXPQbP6iSWG597LW
         uVp2L0d92SiOawEcPInyL64WFgcby2pxYCrUyomiLMi3C3haewIv8J7209yUoc3rT9kR
         M1yQ==
X-Gm-Message-State: AOAM532VLBoVCZ4QSGfaFCMNakf+3gRprbHvDFczWFUNpSeYRTXFiYTT
        yuphyH0Soe+S7Gbv44mErtU/eA==
X-Google-Smtp-Source: ABdhPJz1pyAmhAauNOkUxMnR/3e6dn53nTHqN1bTYfRJ8Zp16VuteI2Oe1AcVs0mjVEn/I4H5nQ/XA==
X-Received: by 2002:a05:6402:11c7:: with SMTP id j7mr396092edw.290.1610990747511;
        Mon, 18 Jan 2021 09:25:47 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
        by smtp.gmail.com with ESMTPSA id r7sm11127221edh.86.2021.01.18.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 09:25:46 -0800 (PST)
Date:   Mon, 18 Jan 2021 18:25:41 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2] fs/proc: Expose RSEQ configuration
Message-ID: <YAXElZrWTM3THlvK@google.com>
References: <20210114185445.996-1-figiel@google.com>
 <1530232798.13459.1610725460826.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530232798.13459.1610725460826.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi, thanks for review.

On Fri, Jan 15, 2021 at 10:44:20AM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 14, 2021, at 1:54 PM, Piotr Figiel figiel@google.com wrote:
> Added PeterZ, Paul and Boqun to CC. They are also listed as maintainers of rseq.
> Please CC them in your next round of patches.

OK.

> > Since C/R preserves TLS memory and addresses RSEQ ABI will be
> > restored using the address registered before C/R.
> How do you plan to re-register the rseq TLS for each thread upon
> restore ?

In CRIU restorer there is a moment when the code runs on behalf of the
restored thread after the memory is already restored but before the
control is passed to the application code. I'm going to use rseq()
syscall there with the checkpointed values of ABI address and signatures
(obtained via the newly added procfs file).

> I suspect you move the return IP to the abort either at checkpoint or
> restore if you detect that the thread is running in a rseq critical
> section.

Actually in the prototype implementation I use PTRACE_SINGLESTEP during
checkpointing (with some safeguards) to force the kernel to jump out of
the critical section before registers values are fetched. This has the
drawback though that the first instruction of abort handler is executed
upon checkpointing.
I'll likely rework it to update instruction pointer by getting abort
address with PTRACE_PEEKTEXT (via RSEQ ABI).
I think an option is to have a kernel interface to trigger the abort on
userspace's request without need for some hacks. This could be a ptrace
extension.  Alternatively attach could trigger RSEQ logic, but this is
potentially a breaking change for debuggers.

> > Detection whether the thread is in a critical section during C/R is
> > needed to enforce behavior of RSEQ abort during C/R. Attaching with
> > ptrace() before registers are dumped itself doesn't cause RSEQ
> > abort.
> Right, because the RSEQ abort is only done when going back to
> user-space, and AFAIU the checkpointed process will cease to exist,
> and won't go back to user-space, therefore bypassing any RSEQ abort.

The checkpointed process doesn't have to cease to exist, actually it can
continue, and when it's unpaused kernel will schedule the process and
should call the abort handler for RSEQ CS. But this will happen on the
checkpointing side after process state was already checkpointed.
For C/R is important that the checkpoint (serialized process state) is
safe wrt RSEQ.

> > Restoring the instruction pointer within the critical section is
> > problematic because rseq_cs may get cleared before the control is
> > passed to the migrated application code leading to RSEQ invariants
> > not being preserved.
> The commit message should state that both the per-thread rseq TLS area
> address and the signature are dumped within this new proc file.

I'll include this in v3, thanks.

> AFAIU lock_trace prevents concurrent exec() from modifying the task's
> content.  What prevents a concurrent rseq register/unregister to be
> executed concurrently with proc_pid_rseq ?

Yes, in this shape only ptrace prevents, as it was the intended use
case. Do you think it would make sense to add a mutex on task_struct for
the purpose of casual reader (sys admin?) consistency? This would be
locked only here and in the syscall during setting.

(Alternatively SMP barrier could be used to enforce the order so that
the ABI address is always written first, and the signature wouldn't make
sense on ABI address = 0, but probably being simply consistent is
better).

> I wonder if all those parentheses are needed. Wouldn't it be enough to have:

Will remove thanks.

Best regards, Piotr.
