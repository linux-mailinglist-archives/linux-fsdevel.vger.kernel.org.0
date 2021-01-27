Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE01F305F45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbhA0PP3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 10:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbhA0POu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:14:50 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB43C06174A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 07:14:09 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s11so2870250edd.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 07:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=65ksyZM56LYMi/17n5/nAjH2134nzomrwEiQi+8o7zE=;
        b=QvBUcDhfRre5rgXFZhYrYnO3VKwX8PbnCtBsVFGAG0PA13IkgQ2XRjN0X9y1v94zoB
         gBKtWqHyra8gcbf/JCH13pPvPwb9di+6XiLSEtS8n4a+Pyugks026dNW9xRTiMRVkGTv
         +4z8jRerwsiPf0fcYn2dv4T10Utb66B5Kc59R5bP5W7xttmBxRwM61JT66IJpb0RMYVZ
         s7TDJw9ZXJcUoyS+J0kUaB534ln2ybiroHCpOMIBnSaR6wPdV39WavvjOKfgCHHRTBAN
         xrLEy4rM6f6X6c8+fTA0nZbb/twPxjnmX1CkatKEcWHmVjkUoDndSbqDLp1sXYvuFhnx
         SBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=65ksyZM56LYMi/17n5/nAjH2134nzomrwEiQi+8o7zE=;
        b=ASskTZEl6cQ8ssv3r48Xmgs/1FvxJAGC6kA3njb+ynQIb77WlAimSat0QeR4pLgz88
         95X/isVDyTL0gl83U7Seen0Ph4qqhz7gbqDbztqz9dSr0MXn/c5lJc+gf+dxuvVjvRG1
         VCLDl/SIxzmR4rLx2w+xkLTnJQ2XqfsWbyUnQ8JwsEDiLcf08eGKt3y4xw30H6m2SYbP
         on7d8Y7+hJo6g5RHX2qcGbaGLJwbHt35MeviELr1p4e/4scxnesZwJHTmzdi7yt1/YQ6
         0gkwggdrF8f/12bHN4uqd8soNX81Zxih3ndRM8ZV2UkD+7af23ovDDVQrsaiXcInkcJH
         BP9Q==
X-Gm-Message-State: AOAM530BbDBFmj8mhx658kyXQMpyuF1EZwjQ0BnbOjpx30IpaeG129na
        GOJb4ZLlFrumjSOu7m6AvNmaJg==
X-Google-Smtp-Source: ABdhPJwVjoCGsw0QUtN6fAwKI2x8vq18sti3VRWHotgE12FpaSzKE03fMU244ooBacr70pUhd3FdIg==
X-Received: by 2002:a05:6402:4310:: with SMTP id m16mr9573676edc.207.1611760448361;
        Wed, 27 Jan 2021 07:14:08 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
        by smtp.gmail.com with ESMTPSA id m10sm1470468edi.54.2021.01.27.07.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:14:07 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:14:01 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v3] fs/proc: Expose RSEQ configuration
Message-ID: <YBGDOQutIx53Xbe+@google.com>
References: <20210126185412.175204-1-figiel@google.com>
 <177374191.8780.1611694726862.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177374191.8780.1611694726862.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 03:58:46PM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 26, 2021, at 1:54 PM, Piotr Figiel figiel@google.com wrote:
> [...]
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index a4f86a9d6937..6aea67878065 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -322,8 +322,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> > rseq_len,
> > 		ret = rseq_reset_rseq_cpu_id(current);
> > 		if (ret)
> > 			return ret;
> > +		task_lock(current);
> > 		current->rseq = NULL;
> > 		current->rseq_sig = 0;
> > +		task_unlock(current);
> > 		return 0;
> > 	}
> > 
> > @@ -353,8 +355,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> > rseq_len,
> > 		return -EINVAL;
> > 	if (!access_ok(rseq, rseq_len))
> > 		return -EFAULT;
> > +	task_lock(current);
> > 	current->rseq = rseq;
> > 	current->rseq_sig = sig;
> > +	task_unlock(current);
> 
> So AFAIU, the locks are there to make sure that whenever a user-space
> thread reads that state through that new /proc file ABI, it observes
> coherent "rseq" vs "rseq_sig" values.

Yes, that was the intention.

> However, I'm not convinced this is the right approach to consistency
> here.
> 
> Because if you add locking as done here, you ensure that the /proc
> file reader sees coherent values, but between the point where those
> values are read from kernel-space, copied to user-space, and then
> acted upon by user-space, those can very well have become outdated if
> the observed process runs concurrently.

You are right here, but I think this comment is valid for most of the
process information exported via procfs. The user can almost always make
a time of check/time of use race when interacting with procfs. I agree
that the locking added in v3 doesn't help much, but at least it does
provide a well defined answer: i.e. at least in some point of time the
effective configuration was as returned.
It makes it a bit easier to document and reason about the file contents,
compared to the inconsistent version.

> So my understanding here is that the only non-racy way to effectively
> use those values is to either read them from /proc/self/* (from the
> thread owning the task struct), or to ensure that the thread is
> stopped/frozen while the read is done.

Constraining this solely to the owning thread I think is a bit too
limiting. I think we could limit it to stopped threads but I don't think
it eliminates the potential of time of check/time of use races for the
user.  In this shape as in v3 - it's up to the user to decide if there
is a relevant risk of a race, if it's unwanted then the thread can be
stopped with e.g. ptrace, cgroup freeze or SIGSTOP.

Best regards,
Piotr.
