Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C46349A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 20:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhCYTLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 15:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhCYTLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:11:00 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D462FC061760
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:10:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g25so1808321wmh.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Mar 2021 12:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xjvw4hFvgpXEdEyLOwCoYu7tEGHrW0NPxhD9uHWiJU4=;
        b=bSWH/ycgN82Wejo6yRufImfb5gjJFjznf7cGlwQ2p3/NZTyhora8LDcSI+ctWWmDDl
         4F+Ta01LBMTgMXVIDRgEneBIuinpxUttbZlCGp5Vo+QATDukVannUIcdru8puMUoCTfO
         0AmqLlevQCNlOQZWMDZ9NP+9F0Ke9fH0lhyuR5XgqhBaq0HEnCNQVddSkZgWEDUd98aW
         RAG4ixniMw2HaFxT7kmZUSyfW+nOLGxiDxoI1JoBshchAcDqH09MdQVgp3DPneI48z28
         ArwSpHFbyYNlkxE/oxzF6kO8wyPSCerwnmnWZKjVx4TJnxqO7jcMdy7SIZoI04Vlsfln
         Zksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xjvw4hFvgpXEdEyLOwCoYu7tEGHrW0NPxhD9uHWiJU4=;
        b=pbktnYFy7y9h8aK4zlNi0AFfOhD5vcDVb2UlYu5W5dZf2uK4yXS9XJu3GVThMXjzHa
         HcUnQNtwKNOlxNC2zV8LrlLfpyrdI1p40+tbuEJ5P7pFuVj8zaEqY9Oe19QDfA/TOUR2
         IKIRVUHGgpRjbnw+3Q1VNVvOysqnG5gjrksAge2qX+IOWmiCXBk5/l0gzL0GVohgGm7l
         psXIoxgUhWFsSInaEV+ri/rSK3vbuSaGvP6JvCcv1+2OXw7JJSeezfKU+UF1DQCnX/+v
         P4M/bzMG+HMrSQMsyQERdpXU3GB9ldwSsWXe0DEi1NhbGAyEs97Dm3yJZaYP5WMCI0Ah
         M0qg==
X-Gm-Message-State: AOAM532M3I/f4MXJM9wYQrFFbBWO7vOHk7lNPjZoGkrIAxNBhPos4+jm
        /gWTh4PH7IV9D20qkVkCmJ0qNg==
X-Google-Smtp-Source: ABdhPJwT3my6f9/QdRwahfkowwHF6UPPglLJeluPEMYuJNzhRuH3FOlaVG9t7s3PvxZWZsbYoZhsUw==
X-Received: by 2002:a1c:7209:: with SMTP id n9mr9680498wmc.132.1616699458252;
        Thu, 25 Mar 2021 12:10:58 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:248e:270b:f7ab:435d])
        by smtp.gmail.com with ESMTPSA id r10sm8011391wmh.45.2021.03.25.12.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:10:57 -0700 (PDT)
Date:   Thu, 25 Mar 2021 20:10:51 +0100
From:   Marco Elver <elver@google.com>
To:     peterz@infradead.org
Cc:     alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de, glider@google.com,
        viro@zeniv.linux.org.uk, arnd@arndb.de, christian@brauner.io,
        dvyukov@google.com, jannh@google.com, axboe@kernel.dk,
        mascasa@google.com, pcc@google.com, irogers@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 01/11] perf: Rework perf_event_exit_event()
Message-ID: <YFzgO0AhGFODmgc1@elver.google.com>
References: <20210324112503.623833-1-elver@google.com>
 <20210324112503.623833-2-elver@google.com>
 <YFxjJam0ErVmk99i@elver.google.com>
 <YFy3qI65dBfbsZ1z@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFy3qI65dBfbsZ1z@elver.google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 25, 2021 at 05:17PM +0100, Marco Elver wrote:
[...]
> > syzkaller found a crash with stack trace pointing at changes in this
> > patch. Can't tell if this is an old issue or introduced in this series.
> 
> Yay, I found a reproducer. v5.12-rc4 is good, and sadly with this patch only we
> crash. :-/
> 
> Here's a stacktrace with just this patch applied:
> 
> | BUG: kernel NULL pointer dereference, address: 00000000000007af
[...]
> | RIP: 0010:task_pid_ptr kernel/pid.c:324 [inline]
> | RIP: 0010:__task_pid_nr_ns+0x112/0x240 kernel/pid.c:500
[...]
> | Call Trace:
> |  perf_event_pid_type kernel/events/core.c:1412 [inline]
> |  perf_event_pid kernel/events/core.c:1421 [inline]
> |  perf_event_read_event+0x78/0x1d0 kernel/events/core.c:7406
> |  sync_child_event kernel/events/core.c:12404 [inline]
> |  perf_child_detach kernel/events/core.c:2223 [inline]
> |  __perf_remove_from_context+0x14d/0x280 kernel/events/core.c:2359
> |  perf_remove_from_context+0x9f/0xf0 kernel/events/core.c:2395
> |  perf_event_exit_event kernel/events/core.c:12442 [inline]
> |  perf_event_exit_task_context kernel/events/core.c:12523 [inline]
> |  perf_event_exit_task+0x276/0x4c0 kernel/events/core.c:12556
> |  do_exit+0x4cd/0xed0 kernel/exit.c:834
> |  do_group_exit+0x4d/0xf0 kernel/exit.c:922
> |  get_signal+0x1d2/0xf30 kernel/signal.c:2777
> |  arch_do_signal_or_restart+0xf7/0x750 arch/x86/kernel/signal.c:789
> |  handle_signal_work kernel/entry/common.c:147 [inline]
> |  exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
> |  exit_to_user_mode_prepare+0x113/0x190 kernel/entry/common.c:208
> |  irqentry_exit_to_user_mode+0x6/0x30 kernel/entry/common.c:314
> |  asm_exc_general_protection+0x1e/0x30 arch/x86/include/asm/idtentry.h:571

I spun up gdb, and it showed me this:

| #0  perf_event_read_event (event=event@entry=0xffff888107cd5000, task=task@entry=0xffffffffffffffff)
|     at kernel/events/core.c:7397
									^^^ TASK_TOMBSTONE
| #1  0xffffffff811fc9cd in sync_child_event (child_event=0xffff888107cd5000) at kernel/events/core.c:12404
| #2  perf_child_detach (event=0xffff888107cd5000) at kernel/events/core.c:2223
| #3  __perf_remove_from_context (event=event@entry=0xffff888107cd5000, cpuctx=cpuctx@entry=0xffff88842fdf0c00,
|     ctx=ctx@entry=0xffff8881073cb800, info=info@entry=0x3 <fixed_percpu_data+3>) at kernel/events/core.c:2359
| #4  0xffffffff811fcb9f in perf_remove_from_context (event=event@entry=0xffff888107cd5000, flags=flags@entry=3)
|     at kernel/events/core.c:2395
| #5  0xffffffff81204526 in perf_event_exit_event (ctx=0xffff8881073cb800, event=0xffff888107cd5000)
|     at kernel/events/core.c:12442
| #6  perf_event_exit_task_context (ctxn=0, child=0xffff88810531a200) at kernel/events/core.c:12523
| #7  perf_event_exit_task (child=0xffff88810531a200) at kernel/events/core.c:12556
| #8  0xffffffff8108838d in do_exit (code=code@entry=11) at kernel/exit.c:834
| #9  0xffffffff81088e4d in do_group_exit (exit_code=11) at kernel/exit.c:922

and therefore synthesized this fix on top:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 57de8d436efd..e77294c7e654 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12400,7 +12400,7 @@ static void sync_child_event(struct perf_event *child_event)
 	if (child_event->attr.inherit_stat) {
 		struct task_struct *task = child_event->ctx->task;
 
-		if (task)
+		if (task && task != TASK_TOMBSTONE)
 			perf_event_read_event(child_event, task);
 	}
 
which fixes the problem. My guess is that the parent and child are both
racing to exit?

Does that make any sense?

Thanks,
-- Marco
