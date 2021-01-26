Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC89304C60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbhAZWk0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:40:26 -0500
Received: from mail.efficios.com ([167.114.26.124]:48022 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbhAZU7d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:59:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5697B303303;
        Tue, 26 Jan 2021 15:58:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ksCNnvqxkXSD; Tue, 26 Jan 2021 15:58:47 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0A249303185;
        Tue, 26 Jan 2021 15:58:47 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 0A249303185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1611694727;
        bh=I3/hpZJOIu/7e1K9VjmD2SsXkD5x8/h5pPXc/jkuDZI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=AgpVk5yoo8Vvagw7pEGFbYl0UWx8JTPBbv96HkM3q0dSD5pF3TS2rRxxfNi1+RyIY
         LwGaFwqLjsnDZzJ2Mxin36ZGswCrASMhYAhdI72Tpwj47jFtmNYl3jvsFYmZbr6oyb
         GgwmX7hp46IMeTsHvCZUeFe6PlRQHw93NMhCYqQxLlXj8fjj16U9VbdOI2I6Fvm+zO
         h/vCoyaavAIF4ZwdB1rW3LwZj2riMILUwE9h6mB23LRIK4uVx9lH6nZrGSftUASsbY
         Dn6yjyjneZfrGLbbf1WbyXqtcJ5uNjBralovdsCVeo8+2BChDPc9OdTCzb5kRfGboR
         bz3aQLjeODcgg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UdTi47ARWm6H; Tue, 26 Jan 2021 15:58:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EBD14302E59;
        Tue, 26 Jan 2021 15:58:46 -0500 (EST)
Date:   Tue, 26 Jan 2021 15:58:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>
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
Message-ID: <177374191.8780.1611694726862.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210126185412.175204-1-figiel@google.com>
References: <20210126185412.175204-1-figiel@google.com>
Subject: Re: [PATCH v3] fs/proc: Expose RSEQ configuration
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3991 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3980)
Thread-Topic: fs/proc: Expose RSEQ configuration
Thread-Index: qgjz5+Hm+HS9/yWT0voBbZMBiZa9vQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- On Jan 26, 2021, at 1:54 PM, Piotr Figiel figiel@google.com wrote:
[...]
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index a4f86a9d6937..6aea67878065 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -322,8 +322,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 		ret = rseq_reset_rseq_cpu_id(current);
> 		if (ret)
> 			return ret;
> +		task_lock(current);
> 		current->rseq = NULL;
> 		current->rseq_sig = 0;
> +		task_unlock(current);
> 		return 0;
> 	}
> 
> @@ -353,8 +355,10 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 		return -EINVAL;
> 	if (!access_ok(rseq, rseq_len))
> 		return -EFAULT;
> +	task_lock(current);
> 	current->rseq = rseq;
> 	current->rseq_sig = sig;
> +	task_unlock(current);

So AFAIU, the locks are there to make sure that whenever a user-space thread reads
that state through that new /proc file ABI, it observes coherent "rseq" vs "rseq_sig"
values. However, I'm not convinced this is the right approach to consistency here.

Because if you add locking as done here, you ensure that the /proc file reader
sees coherent values, but between the point where those values are read from
kernel-space, copied to user-space, and then acted upon by user-space, those can
very well have become outdated if the observed process runs concurrently.

So my understanding here is that the only non-racy way to effectively use those
values is to either read them from /proc/self/* (from the thread owning the task struct),
or to ensure that the thread is stopped/frozen while the read is done.

Maybe we should consider validating that the proc file is used from the right context
(from self or when the target thread is stopped/frozen) rather than add dubious locking ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
