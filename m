Return-Path: <linux-fsdevel+bounces-47290-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A2A9B815
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830701B83068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60E728BAA0;
	Thu, 24 Apr 2025 19:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGey5/ME"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DD47483
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 19:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745522029; cv=none; b=cSKaovg9+Gvq/zDQHbVMqRxMtdW/jz3debKplj6NwLyz6tz8S5WXiTfzsPJ+R5SJIsW4cnvJ2silVluPElpfvHFm+GoPkgZJaAdwIjeEw/uWzbAZEK9h6fBWBZtZdMuS3GbPUau/BWL1o6LmlHXD/x/ozbJ0i14D2lPmBTm2f5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745522029; c=relaxed/simple;
	bh=pTYuE1+UQE57G5zROLvqGRpojDu5cg7j3HznET+k4jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alng40zxUYWAGBqXcElzVZBwSe45TDTdQNlq8mG4idOph+O66iVuZxIXzk+50rIV1Sr3DsTDxyqPZscWwLbC97qPKoo36uacst8+LXcqXbBxiCzTe4kCyfV2YsaE+dqyhRoJ7HklJXskAzM+Brw1rrI0hGfu7AzWI1URLmhS+b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGey5/ME; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745522024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFVuq6NQhUA1J1Yggk5U+IsnP1OX3MNjPs3xA85dIXk=;
	b=PGey5/MEn85RWMK/iioaVf9rUy5lptfplMWQvzypvKkC5E5KUweLsImYX9yNTtZ7EHD6dX
	Rpbp/LrbO9sDopelROrKrIKIs5ih6lZxwGyyW1atBJn9WSrjusC1/T9rXJclqtTguH62Nj
	cVyolxOPXoN16kEB1V5w13vzFv/kHYY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-FC-_OD9VNvWskScOpvbuqQ-1; Thu, 24 Apr 2025 15:13:43 -0400
X-MC-Unique: FC-_OD9VNvWskScOpvbuqQ-1
X-Mimecast-MFC-AGG-ID: FC-_OD9VNvWskScOpvbuqQ_1745522023
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6f2b4ab462cso13239296d6.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745522023; x=1746126823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFVuq6NQhUA1J1Yggk5U+IsnP1OX3MNjPs3xA85dIXk=;
        b=Nqs/LCfDdO3FEF4bmzzQ6O3EIBspQJ57+b9D8nuKrskrUqTsutUG1otWqkFWT9bl9U
         YJzSklGDh6hNRlEKzKFu/VylHsTfoE2PfcYufiLY9X2zYV2tufRzAmYZHtsQvbEr6JE9
         lGSWYoD8MsG3Nv+E1Tu+iEN76vmfY7uWNEJeCzjPiNBXecP7YXwzDmF/oHoEUhDUA9Do
         k/1Ufaa2mHhyA40YSWKVrYlD/UVBh72pS+nxt+v5/L/hOv33w6uyxdS+0G6/6JQ+X5ul
         8Qt0ZOgSCx535lUuyK81vusrN+azX2L/ZBh6NwZF6Wsdsj6/sugcbvozG2vSqGsdT7p3
         ESKw==
X-Forwarded-Encrypted: i=1; AJvYcCVCtiXLKIW128S88xBQjQAbzLmH6M/BDMtFEJ2HgTAfHnxTaGRRaPFwkaj+LU2lAi5x4AqsF7Wh1fngfNmD@vger.kernel.org
X-Gm-Message-State: AOJu0YykVb3rTo91rjvKN0EqUXQIRE0gCxOdSYCaRHwEgFuQGDGY20oZ
	lvRj0CCBZf9aELrC4dR6wRHlVsKkrxT60kzBbkwU1PtiJrLQzhKJuEtRan7xM8HBVYfKz/osRNp
	96e/R5p0Yzbm/DfSlWD380cy4NFS64GAfgRWpbNoPeIYlQdx6ExoR4uE4gAT01d8=
X-Gm-Gg: ASbGncuMqGE4LM/AxIzslCFBd2Oo5Cso2fR7bQYKrQZe4Rn2voS0wyGjCwmyVSOpyzd
	3Ym1hU+SgsV2B04wvILwKtiuzwEUKPaT/3mkBw3GoCGkz1Rg9yUhLCDYFmJgiLgg1EMaiUABz2L
	6EqhOq2pIKfvfzDHbMESfGJVAULUoww1VbJRAQ1q3hZncwbmjdsNurFRylUlSNPbOY8UjMeglSH
	7/FLhvuaONBdupy22lrtcLbPoNt5SEzitL76uctuqLL8D5R/iGK+fWfWhHZy4z54tOBiIXuRH1e
	oaY=
X-Received: by 2002:a05:6214:c44:b0:6f4:c8df:43d2 with SMTP id 6a1803df08f44-6f4c95aecf6mr13476926d6.35.1745522022635;
        Thu, 24 Apr 2025 12:13:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgto+GVUd/DHwGF88Fe2YO75/a2RDPjFmBCbN6iwyzjT+9UmEplNqQO0qFf5AzOrOQlckJrg==
X-Received: by 2002:a05:6214:c44:b0:6f4:c8df:43d2 with SMTP id 6a1803df08f44-6f4c95aecf6mr13476326d6.35.1745522022076;
        Thu, 24 Apr 2025 12:13:42 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c093437dsm12695926d6.39.2025.04.24.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:13:41 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:13:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAqNYsMvU-7I-nu1@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>

On Thu, Apr 24, 2025 at 12:40:56PM -0600, Jens Axboe wrote:
> On 4/24/25 12:26 PM, Peter Xu wrote:
> > On Thu, Apr 24, 2025 at 10:03:44AM -0400, Johannes Weiner wrote:
> >> On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
> >>> userfaultfd may use interruptible sleeps to wait on userspace filling
> >>> a page fault, which works fine if the task can be reliably put to
> >>> sleeping waiting for that. However, if the task has a normal (ie
> >>> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
> >>> cause schedule() to be a no-op.
> >>>
> >>> For a task that registers a page with userfaultfd and then proceeds
> >>> to do a write from it, if that task also has a signal pending then
> >>> it'll essentially busy loop from do_page_fault() -> handle_userfault()
> >>> until that fault has been filled. Normally it'd be expected that the
> >>> task would sleep until that happens. Here's a trace from an application
> >>> doing just that:
> >>>
> >>> handle_userfault+0x4b8/0xa00 (P)
> >>> hugetlb_fault+0xe24/0x1060
> >>> handle_mm_fault+0x2bc/0x318
> >>> do_page_fault+0x1e8/0x6f0
> >>
> >> Makes sense. There is a fault_signal_pending() check before retrying:
> >>
> >> static inline bool fault_signal_pending(vm_fault_t fault_flags,
> >>                                         struct pt_regs *regs)
> >> {
> >>         return unlikely((fault_flags & VM_FAULT_RETRY) &&
> >>                         (fatal_signal_pending(current) ||
> >>                          (user_mode(regs) && signal_pending(current))));
> >> }
> >>
> >> Since it's an in-kernel fault, and the signal is non-fatal, it won't
> >> stop looping until the fault is handled.
> >>
> >> This in itself seems a bit sketchy. You have to hope there is no
> >> dependency between handling the signal -> handling the fault inside
> >> the userspace components.
> > 
> > True. So far, my understanding is e.g. in an userfaultfd context the signal
> > handler is responsible for not touching any possible trapped pages, or the
> > sighandler needs fixing on its own.
> > 
> >>
> >>> do_translation_fault+0x9c/0xd0
> >>> do_mem_abort+0x44/0xa0
> >>> el1_abort+0x3c/0x68
> >>> el1h_64_sync_handler+0xd4/0x100
> >>> el1h_64_sync+0x6c/0x70
> >>> fault_in_readable+0x74/0x108 (P)
> >>> iomap_file_buffered_write+0x14c/0x438
> >>> blkdev_write_iter+0x1a8/0x340
> >>> vfs_write+0x20c/0x348
> >>> ksys_write+0x64/0x108
> >>> __arm64_sys_write+0x1c/0x38
> >>>
> >>> where the task is looping with 100% CPU time in the above mentioned
> >>> fault path.
> >>>
> >>> Since it's impossible to handle signals, or other conditions like
> >>> TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
> >>> fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
> >>> modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
> >>> signals will still be handled by the caller, and the timeout is short
> >>> enough to hopefully not cause any issues. If this is the first invocation
> >>> of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
> >>> is used.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> >>
> >> When this patch was first introduced, VM_FAULT_RETRY would work only
> >> once. The second try would have FAULT_FLAG_ALLOW_RETRY cleared,
> >> causing handle_userfault() to return VM_SIGBUS, which would bubble
> >> through the fixup table (kernel fault), -EFAULT from
> >> iomap_file_buffered_write() and unwind the kernel stack this way.
> > 
> > AFAIU we can't rely on the exception fixups because when reaching there it
> > means the user access is going to get a -EFAULT, but here the right
> > behavior is we keep waiting, aka, UNINTERRUPTIBLE wait until it's done.
> > 
> >>
> >> So I'm thinking this is the more likely commit for Fixes: and stable:
> >>
> >> commit 4064b982706375025628094e51d11cf1a958a5d3
> >> Author: Peter Xu <peterx@redhat.com>
> >> Date:   Wed Apr 1 21:08:45 2020 -0700
> >>
> >>     mm: allow VM_FAULT_RETRY for multiple times
> > 
> > IMHO the multiple attempts are still fine, instead it's problematic if we
> > wait in INTERRUPTIBLE mode even in !user mode..  so maybe it's slightly
> > more suitable to use this as Fixes:
> > 
> > commit c270a7eedcf278304e05ebd2c96807487c97db61
> > Author: Peter Xu <peterx@redhat.com>
> > Date:   Wed Apr 1 21:08:41 2020 -0700
> > 
> >     mm: introduce FAULT_FLAG_INTERRUPTIBLE
> > 
> > The important change there is:
> > 
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index 888272621f38..c076d3295958 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -462,9 +462,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
> >         uwq.ctx = ctx;
> >         uwq.waken = false;
> >  
> > -       return_to_userland =
> > -               (vmf->flags & (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE)) ==
> > -               (FAULT_FLAG_USER|FAULT_FLAG_KILLABLE);
> > +       return_to_userland = vmf->flags & FAULT_FLAG_INTERRUPTIBLE;
> >         blocking_state = return_to_userland ? TASK_INTERRUPTIBLE :
> >                          TASK_KILLABLE;
> > 
> > I think we still need to avoid checking FAULT_FLAG_USER, because e.g. in
> > some other use cases like GUP we'd still want the threads (KVM does GUP and
> > it's a heavy user of userfaultfd) to respond to non-fatals.
> > 
> > However maybe we shouldn't really set INTERRUPTIBLE at all if it's non-GUP
> > and if it's non-user either.
> > 
> > So in general, some trivial concerns here on the patch..
> > 
> > Firstly, waiting UNINTERRUPTIBLE (even if with a small timeout) if
> > FAULT_FLAG_INTERRUPTIBLE is set is a slight ABI violation to me - after
> > all, FAULT_FLAG_INTERRUPTIBLE says "please respond to non-fatal signals
> > too!".
> 
> First of all, it won't respond to signals _right now_ if waiting on
> userfaultd, so that ABI violation already exists. The UNINTERRUPTIBLE
> doesn't really change that at all.

Since we can't check pending signals in a loop.. IIUC it's still ok if we
only check it right before a major sleep would happen.  IIUC that means the
old code (at least the userfaultfd path..) is following the rules.

But yeah, I think even with HZ/10 timeout, it will still respond to
non-fatal signals more or less.  It isn't that bad, so my current concerns
are more of nitpicking category.  Sorry if that wasn't clear.  I'm just
trying to see whether we have something even better (and if possible, easier).

> 
> > Secondly, userfaultfd is indeed the only consumer of
> > FAULT_FLAG_INTERRUPTIBLE but not necessary always in the future.  While
> > this patch resolves it for userfaultfd, it might get caught again later if
> > something else in the kernel starts to respects the _INTERRUPTIBLE flag
> > request.  For example, __folio_lock_or_retry() ignores that flag so far,
> > but logically it should obey too (with a folio_wait_locked_interruptible)..
> > 
> > I also think it's not as elegant to have the magic HZ/10, and it's also
> > destined even the loop is less frequent that's a waste of time (as if the
> > user page access comes from kernel context, we must wait... until the page
> > fault is resolved..).
> 
> Yeah I don't love the magic either, but the actual value of it isn't
> important - it's just to prevent a CPU spin for these cases.

Right.  If this patch is the only thing so far can fix it, I'm OK we go
with it first.  Said that..

> 
> > Is it possible we simply unset the request from the top?  As discussed
> > above, I think we still need to make sure GUP at least works for
> > non-fatals, however I think it might be more reasonable we never set
> > _INTERRUPTIBLE for !gup, then this problem might go away too with all above
> > concerns addressed.
> > 
> > A not-even-compiled patch just to clarify what I meant (and it won't work
> > unless it makes sense to both of you and we'll need to touch all archs when
> > changing the default flags):
> > 
> > ===8<===
> > diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > index 296d294142c8..fa721525d93a 100644
> > --- a/arch/x86/mm/fault.c
> > +++ b/arch/x86/mm/fault.c
> > @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
> >          * We set FAULT_FLAG_USER based on the register state, not
> >          * based on X86_PF_USER. User space accesses that cause
> >          * system page faults are still user accesses.
> > +        *
> > +        * When we're in user mode, allow fast response on non-fatal
> > +        * signals.  Do not set this in kernel mode faults because normally
> > +        * a kernel fault means the fault must be resolved anyway before
> > +        * going back to userspace.
> >          */
> >         if (user_mode(regs))
> > -               flags |= FAULT_FLAG_USER;
> > +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
> >  
> >  #ifdef CONFIG_X86_64
> >         /*
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 9b701cfbef22..a80f3f609b37 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
> >   * arch-specific page fault handlers.
> >   */
> >  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
> > -                            FAULT_FLAG_KILLABLE | \
> > -                            FAULT_FLAG_INTERRUPTIBLE)
> > +                            FAULT_FLAG_KILLABLE)
> > ===8<===
> > 
> > That also kind of matches with what we do with fault_signal_pending().
> > Would it make sense?
> 
> I don't think doing a non-bounded non-interruptible sleep for a
> condition that may never resolve (eg userfaultfd never fills the fault)
> is a good idea. What happens if the condition never becomes true? You

If page fault is never going to be resolved, normally we sigkill the
program as it can't move any further with no way to resolve the page fault.

But yeah that's based on the fact sigkill will work first..

> can't even kill the task at that point... Generally UNINTERRUPTIBLE
> sleep should only be used if it's a bounded wait.
> 
> For example, if I ran my previous write(2) reproducer here and the task
> got killed or exited before the userfaultfd fills the fault, then you'd
> have the task stuck in 'D' forever. Can't be killed, can't get
> reclaimed.
> 
> In other words, this won't work.

.. Would you help explain why it didn't work even for SIGKILL?  Above will
still set FAULT_FLAG_KILLABLE, hence I thought SIGKILL would always work
regardless.

For such kernel user page access, IIUC it should respond to SIGKILL in
handle_userfault(), then fault_signal_pending() would trap the SIGKILL this
time -> going kernel fixups. Then the upper stack should get -EFAULT in the
exception fixup path.

I could have missed something..

Thanks,

-- 
Peter Xu


