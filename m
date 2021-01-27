Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F04305F20
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 16:10:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343693AbhA0PJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jan 2021 10:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbhA0PH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:07:59 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84327C061786
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 07:07:17 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id w1so3078970ejf.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Jan 2021 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N7A1x2GC1x0hF+kEQdhgJbtckU1NEuvdrANE8Zk2mBc=;
        b=PwO46OqOPXu+s13hTP8dIKnBU7ghxNkqb7PMprEjiCc6JwFpe65E/p95W2LoKqZ0K+
         aqE2Q0kATuO5txfH2C7ti1pKIEW/fcipNQh4EEysIke8rK3e7MvDnpB8RI5g8aJ6PzvI
         ttlHr2PXcKsfWLso+s3LtOzSVFIR1fgy2Nb4VGsVAQaFtsMpfXH8jVewSTfWsKNYIoF/
         fUctJgZ2E0i7HqIDsfJ4wonPFkXT7Tec7Z1s+GbnaQRH08YFVNFfxRBbIoXhlZ21RT7D
         5U1PduvF3d5Wj2dcWmhS0Tp4RFU5HaIbnRK/AkpX9QoxhaLwNZEF4ldk4gb4K4tpgcVo
         tIRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N7A1x2GC1x0hF+kEQdhgJbtckU1NEuvdrANE8Zk2mBc=;
        b=qyv6V0EZsmRstKdrF7V31RxCQzUwVmNtSxjg4aqRAXdmlNvZBjVHPCMwTr3Wgblduy
         fo4NGrxQeZKpgzIcSdwb28k2Z8duddUEcTIjvuRpbKBDCcGFlQJ2iSVxyCNElwsJsr1I
         4BQEeP8XQX/F5lZOcgChZqos10V1fH+EhM1j1KCzSLi0PHDlG6BH8P5B/dh7yMYMCXYD
         EVIexLJSBdogBxnR11+hwHWsBbcDs48WFIr7bYhD4c6MW/VZm3lCRrTLELvZAYIo8w6S
         oCpBazGuuBvDhBA37S5MvdvWsEiomkR+QzeOVLpvaiq25+k+KCYS3NqKWNbkYK0F5ueT
         mc7Q==
X-Gm-Message-State: AOAM532EewyuzNdjgUwUJvRcv1RQrDo8iEq7IGQUqXzD2doxkRqDQt3Y
        yoGIn8VzHbw6Wx1QrsSbuwgllA==
X-Google-Smtp-Source: ABdhPJyH0Ua5BpkkZT8m+HW+HXL+QZRCAvd2STIW12zU9jFUOSFTkPgl0rUhiiiIAHB8ZtWkX9Yoxg==
X-Received: by 2002:a17:906:5846:: with SMTP id h6mr7083231ejs.521.1611760036032;
        Wed, 27 Jan 2021 07:07:16 -0800 (PST)
Received: from google.com ([2a00:79e0:2:11:1ea0:b8ff:fe79:fe73])
        by smtp.gmail.com with ESMTPSA id s15sm962666ejy.68.2021.01.27.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 07:07:15 -0800 (PST)
Date:   Wed, 27 Jan 2021 16:07:09 +0100
From:   Piotr Figiel <figiel@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        mathieu.desnoyers@efficios.com, viro@zeniv.linux.org.uk,
        peterz@infradead.org, paulmck@kernel.org, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com
Subject: Re: [PATCH v3] fs/proc: Expose RSEQ configuration
Message-ID: <YBGBnQWJDVZ7Y7s6@google.com>
References: <20210126185412.175204-1-figiel@google.com>
 <20210126112547.d3f18b6a2abe864e8bfa7fcd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126112547.d3f18b6a2abe864e8bfa7fcd@linux-foundation.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:25:47AM -0800, Andrew Morton wrote:
> On Tue, 26 Jan 2021 19:54:12 +0100 Piotr Figiel <figiel@google.com> wrote:
> > To achieve above goals expose the RSEQ structure address and the
> > signature value with the new per-thread procfs file "rseq".
> Using "/proc/<pid>/rseq" would be more informative.
> 
> >  fs/exec.c      |  2 ++
> >  fs/proc/base.c | 22 ++++++++++++++++++++++
> >  kernel/rseq.c  |  4 ++++
> 
> A Documentation/ update would be appropriate.
> 
> > +	task_lock(current);
> >  	rseq_execve(current);
> > +	task_unlock(current);
> 
> There's a comment over the task_lock() implementation which explains
> what things it locks.  An update to that would be helpful.

Agreed I'll include fixes for above comments in v4.

> > --- a/fs/proc/base.c
> > +++ b/fs/proc/base.c
> > @@ -662,6 +662,22 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
> >  
> >  	return 0;
> >  }
> > +
> > +#ifdef CONFIG_RSEQ
> > +static int proc_pid_rseq(struct seq_file *m, struct pid_namespace *ns,
> > +				struct pid *pid, struct task_struct *task)
> > +{
> > +	int res = lock_trace(task);
> > +
> > +	if (res)
> > +		return res;
> > +	task_lock(task);
> > +	seq_printf(m, "%px %08x\n", task->rseq, task->rseq_sig);
> > +	task_unlock(task);
> > +	unlock_trace(task);
> > +	return 0;
> > +}
> 
> Do we actually need task_lock() for this purpose?  Would
> exec_update_lock() alone be adequate and appropriate?

Now rseq syscall which modifies those fields isn't synchronised with
exec_update_lock. So either a new lock or task_lock() could be used or
exec_update_lock could be reused in the syscall.  I decided against
exec_update_lock reuse in the syscall because it's normally used to
guard access checks against concurrent setuid exec. This could be
potentially confusing as it's not relevant for the the rseq syscall
code.
I think task_lock usage here is also consistent with how it's used
across the kernel.

Whether we need consistent rseq and rseq_sig pairs in the proc output, I
think there's some argument for it (discussed also in parallel thread
with Mathieu Desnoyers).

Best regards,
Piotr.
