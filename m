Return-Path: <linux-fsdevel+bounces-47288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F479A9B65B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 20:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62A3D3BAC58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 18:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20771F09B4;
	Thu, 24 Apr 2025 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fo56xeXN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7331FC0EA
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519207; cv=none; b=ZNx8lLfcLLQe95y25PfJYw7NuHPly8ce5jOCutPtRruvYOq9MGRQ8qv31EWvGSItcRAHAZHc8imnMJjDInJ9zRMKyV9OGRtiZ3iEvESSorg724WAJrSeUtJUfRbhVuDEDHwM5yQtnniKKn3sSIOsciGh2LXWbvxuAM8XIrEHYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519207; c=relaxed/simple;
	bh=GPb2T7J6wVDW3cf6fZT/7fsxI3kE0TE7xya41wQShwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HE4fJ0SikluJGQ1rHdWjEg/NOIPdIC995vKhMLNQ04fGv2aEzErF3oYIrnbDpCzOohJUBPidmlhAZFa4ma4h1rV3w/7VdfJTHM6zcGpx54jyOl3isRz2+1y3bqwTg2EiyIygie5w8F8KzxZoOd/T2euKJ1Iy6wlsz1z+hLjyB0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fo56xeXN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745519203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zf9fN4uPxYqilQqe6FukB7BMsnH9qJym/Yt+HGTXGJ8=;
	b=fo56xeXNaZxy7Ibn52daX6N7bQsZnCKw6W2wIqH3zoL9mKtlComgT5mrGk/0Tmfj9cRStm
	iym5kxB98JhyHfba9AjofNZjk7TJW6BHKvSsM1XTLja0GAwbdyWVqT7zPvd0KKh7qeflvD
	xbZGwVIP8yGMcjZdp8PDDb9ld2Zpmlg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-2lEwu728PyatKii36yvKnw-1; Thu, 24 Apr 2025 14:26:42 -0400
X-MC-Unique: 2lEwu728PyatKii36yvKnw-1
X-Mimecast-MFC-AGG-ID: 2lEwu728PyatKii36yvKnw_1745519202
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c791987cf6so276827385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 11:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519202; x=1746124002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zf9fN4uPxYqilQqe6FukB7BMsnH9qJym/Yt+HGTXGJ8=;
        b=Wd6JsrYqCLUO0qlhoAeu0vUwTVJpg0rnZftUldVrWGdTR3WTfChg3l/fu1cFDrSPWb
         HtW+XywZD2aIAVdb3tY8xTkk5A6KjYU7Oddx+a6tngXHXYOBEe7/ppfz0TADU6BEtfB9
         56IrVhEudrzGl4ECAiP6cjAf9BhkxS1xFUmn/5S5dv24XwYAFs6tUZGk78Zv3qslIjuH
         YT5Q7R6LJMApv1+lq7JE5646TF9oW8BkEPfh4lNGyDOk0wJN2jG6SBHizZ/z0TDzL+Co
         BRW5M3xK/badjgRecGamGn/Y/86xnkpeBsqO+j0G4clisgraMmaAfwgrBeJcL+0UWN/f
         i+1w==
X-Forwarded-Encrypted: i=1; AJvYcCX78fT8WLFC5TTNyrsUYHd6HMAmKQOQNTgB1DZBbzBToWo2TrUmvKCcFtltbIS0NVSA7PMsp1nicZAri1zV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Rt//uU7qkJNflzgU6wgJgPaNa3uIwyw4DYMxt8nWyy6wCHoj
	wLsdcwbfjcALYuKHKEzwi3vpQ3PTTYm75XXO0g61mr8qgPJh61nU6TkF7U8hlp6XcgYeqE+OsOJ
	3+JgRnGmcvZQeOJRpsmnbkqcdTgQ4WIurjFglxr99olUqwI3INlhKO0UNMkz2wsjf/HHdvAw=
X-Gm-Gg: ASbGncsQjTVAzFDiZda4MhHfzYY1fy1kwjsWt1NKAXsbpWLlJELZbYslqqF6BIoYCPc
	HsbzjJn9zBStvhacR23mwfhV0+EwL5JjgV8CixPy/9YvYah0Do2Zt1aednz1arH5OSpy2i/dp8D
	qUno+uyQVBQLSQbAwHvYyXTUoiSUww5qIxGiLOrGOmT0W3Nc7EHgVUeyu622fjxUzNuPc87BKM1
	l2j7svVCZcTkHGhigEYd9bSOFSy/CapJZ1nq/y3K/iqD1AKpvQh34plLzzWN00Puko4d9UKf/kF
	zbI=
X-Received: by 2002:a05:620a:1b99:b0:7c5:43b4:fa97 with SMTP id af79cd13be357-7c95ef62ed8mr65536185a.53.1745519201605;
        Thu, 24 Apr 2025 11:26:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWadddF4tTVGtsR9D4nXlp5wgIoy+YSZhoYxEZ8+RIfT9JL70XbLnOSO0r756wTUMaiFpfxA==
X-Received: by 2002:a05:620a:1b99:b0:7c5:43b4:fa97 with SMTP id af79cd13be357-7c95ef62ed8mr65533285a.53.1745519201263;
        Thu, 24 Apr 2025 11:26:41 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958cdc62bsm117826985a.55.2025.04.24.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 11:26:40 -0700 (PDT)
Date: Thu, 24 Apr 2025 14:26:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAqCXfPirHqWMlb4@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424140344.GA840@cmpxchg.org>

On Thu, Apr 24, 2025 at 10:03:44AM -0400, Johannes Weiner wrote:
> On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
> > userfaultfd may use interruptible sleeps to wait on userspace filling
> > a page fault, which works fine if the task can be reliably put to
> > sleeping waiting for that. However, if the task has a normal (ie
> > non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
> > cause schedule() to be a no-op.
> > 
> > For a task that registers a page with userfaultfd and then proceeds
> > to do a write from it, if that task also has a signal pending then
> > it'll essentially busy loop from do_page_fault() -> handle_userfault()
> > until that fault has been filled. Normally it'd be expected that the
> > task would sleep until that happens. Here's a trace from an application
> > doing just that:
> > 
> > handle_userfault+0x4b8/0xa00 (P)
> > hugetlb_fault+0xe24/0x1060
> > handle_mm_fault+0x2bc/0x318
> > do_page_fault+0x1e8/0x6f0
> 
> Makes sense. There is a fault_signal_pending() check before retrying:
> 
> static inline bool fault_signal_pending(vm_fault_t fault_flags,
>                                         struct pt_regs *regs)
> {
>         return unlikely((fault_flags & VM_FAULT_RETRY) &&
>                         (fatal_signal_pending(current) ||
>                          (user_mode(regs) && signal_pending(current))));
> }
> 
> Since it's an in-kernel fault, and the signal is non-fatal, it won't
> stop looping until the fault is handled.
> 
> This in itself seems a bit sketchy. You have to hope there is no
> dependency between handling the signal -> handling the fault inside
> the userspace components.

True. So far, my understanding is e.g. in an userfaultfd context the signal
handler is responsible for not touching any possible trapped pages, or the
sighandler needs fixing on its own.

> 
> > do_translation_fault+0x9c/0xd0
> > do_mem_abort+0x44/0xa0
> > el1_abort+0x3c/0x68
> > el1h_64_sync_handler+0xd4/0x100
> > el1h_64_sync+0x6c/0x70
> > fault_in_readable+0x74/0x108 (P)
> > iomap_file_buffered_write+0x14c/0x438
> > blkdev_write_iter+0x1a8/0x340
> > vfs_write+0x20c/0x348
> > ksys_write+0x64/0x108
> > __arm64_sys_write+0x1c/0x38
> >
> > where the task is looping with 100% CPU time in the above mentioned
> > fault path.
> > 
> > Since it's impossible to handle signals, or other conditions like
> > TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
> > fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
> > modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
> > signals will still be handled by the caller, and the timeout is short
> > enough to hopefully not cause any issues. If this is the first invocation
> > of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
> > is used.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> 
> When this patch was first introduced, VM_FAULT_RETRY would work only
> once. The second try would have FAULT_FLAG_ALLOW_RETRY cleared,
> causing handle_userfault() to return VM_SIGBUS, which would bubble
> through the fixup table (kernel fault), -EFAULT from
> iomap_file_buffered_write() and unwind the kernel stack this way.

AFAIU we can't rely on the exception fixups because when reaching there it
means the user access is going to get a -EFAULT, but here the right
behavior is we keep waiting, aka, UNINTERRUPTIBLE wait until it's done.

> 
> So I'm thinking this is the more likely commit for Fixes: and stable:
> 
> commit 4064b982706375025628094e51d11cf1a958a5d3
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Apr 1 21:08:45 2020 -0700
> 
>     mm: allow VM_FAULT_RETRY for multiple times

IMHO the multiple attempts are still fine, instead it's problematic if we
wait in INTERRUPTIBLE mode even in !user mode..  so maybe it's slightly
more suitable to use this as Fixes:

commit c270a7eedcf278304e05ebd2c96807487c97db61
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Apr 1 21:08:41 2020 -0700

    mm: introduce FAULT_FLAG_INTERRUPTIBLE

The important change there is:

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 888272621f38..c076d3295958 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -462,9 +462,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
        uwq.ctx = ctx;
        uwq.waken = false;
 
-       return_to_userland =
-               (vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
-               (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);
+       return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
        blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
                         TASK_KILLABLE;

I think we still need to avoid checking FAULT_FLAG_USER, because e.g. in
some other use cases like GUP we'd still want the threads (KVM does GUP and
it's a heavy user of userfaultfd) to respond to non-fatals.

However maybe we shouldn't really set INTERRUPTIBLE at all if it's non-GUP
and if it's non-user either.

So in general, some trivial concerns here on the patch..

Firstly, waiting UNINTERRUPTIBLE (even if with a small timeout) if
FAULT_FLAG_INTERRUPTIBLE is set is a slight ABI violation to me - after
all, FAULT_FLAG_INTERRUPTIBLE says "please respond to non-fatal signals
too!".

Secondly, userfaultfd is indeed the only consumer of
FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
this patch resolves it for userfaultfd, it might get caught again later if
something else in the kernel starts to respects the _INTERRUPTIBLE flag
request.  For example, __folio_lock_or_retry() ignores that flag so far,
but logically it should obey too (with a folio_wait_locked_interruptible)..

I also think it's not as elegant to have the magic HZ/10, and it's also
destined even the loop is less frequent that's a waste of time (as if the
user page access comes from kernel context, we must wait... until the page
fault is resolved..).

Is it possible we simply unset the request from the top?  As discussed
above, I think we still need to make sure GUP at least works for
non-fatals, however I think it might be more reasonable we never set
_INTERRUPTIBLE for !gup, then this problem might go away too with all above
concerns addressed.

A not-even-compiled patch just to clarify what I meant (and it won't work
unless it makes sense to both of you and we'll need to touch all archs when
changing the default flags):

===8<===
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 296d294142c8..fa721525d93a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
         * We set FAULT_FLAG_USER based on the register state, not
         * based on X86_PF_USER. User space accesses that cause
         * system page faults are still user accesses.
+        *
+        * When we're in user mode, allow fast response on non-fatal
+        * signals.  Do not set this in kernel mode faults because normally
+        * a kernel fault means the fault must be resolved anyway before
+        * going back to userspace.
         */
        if (user_mode(regs))
-               flags |= FAULT_FLAG_USER;
+               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
 
 #ifdef CONFIG_X86_64
        /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b701cfbef22..a80f3f609b37 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
  * arch-specific page fault handlers.
  */
 #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
-                            FAULT_FLAG_KILLABLE | \
-                            FAULT_FLAG_INTERRUPTIBLE)
+                            FAULT_FLAG_KILLABLE)
===8<===

That also kind of matches with what we do with fault_signal_pending().
Would it make sense?

Thanks,

-- 
Peter Xu


