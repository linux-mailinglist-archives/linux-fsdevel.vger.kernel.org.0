Return-Path: <linux-fsdevel+bounces-47831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6CBAA6146
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B394C0AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3220B81D;
	Thu,  1 May 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtCCEvZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F522DC797
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116325; cv=none; b=WAVcs9mSbKnI+LkomPiM+xuTrR+PkFHAMABiB4DPl5WtaCFW26sypPrV+2M1XLnUqdaLI1VfZeOdTuaod24GZcSQmVlCXAuQCZkhu/W46lRuCVhMWjz1HmmlKL0pmIAWAYy0P2UaxdkOV+aMSJxLuM4iicXfn9pkrjpYcf6UAvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116325; c=relaxed/simple;
	bh=eEeuNESMSvQBFTcFinvyp/9bOH4S+FuH4OGoDBBwhHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRqKw9Z0GoAhU+XQA7PAgyZjVk4WUcnwrEf0Go5szkROlcdtc2t8xzLRkOKK62t9ltiAsTXHTteBG00Sztxk9xK5h/1u1/x0auoHFG+4wuMXJMNT+6xDEtlQzpjNJYi/15IMbO276wSadLTiV2zDDtO9kgt+F7gfBbzClJyXFsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtCCEvZf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746116322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NGjIYWqwjaqx0wjkbFDj85fINsD60E6U2Seb+FFfQNg=;
	b=QtCCEvZf5ZHHHy8yrP1VkdvIb3WMT0HnQsV2PHa52R6LxZ802YzMg9+fby5wCLfXjEKwSu
	95M14akGnEFUU7QLCH6E85ZujDziYdZAESbM6X5ClUrMz65tPPfYPBtlXBYyMGiK6UfSra
	R9TwqQ7R/m7++m09oK48eQAxpHp0H3I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-NccP2LkJOa655pZFuq_LbQ-1; Thu, 01 May 2025 12:18:39 -0400
X-MC-Unique: NccP2LkJOa655pZFuq_LbQ-1
X-Mimecast-MFC-AGG-ID: NccP2LkJOa655pZFuq_LbQ_1746116319
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-476900d10caso27659991cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 09:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746116319; x=1746721119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGjIYWqwjaqx0wjkbFDj85fINsD60E6U2Seb+FFfQNg=;
        b=olcM3jegOjrqjwa8eHOfjWHX9mTqxbvICiaK0Z3maSSFfExwUe+oG1lIvlrSglfK11
         lkfsHPmuSUlbm44k97NY3+tWz3LVQLPqrwgdLyk1JAXD5kwZG1AtEL3+YYCQ7ZEaP8bA
         tegS7jnEPt5E+K64bC1mR0WHRsQF9NyO8lWkVPDCrLsNqPRBLgKpj6xpcDTV8CIzF0GP
         Wxn4RyLhbhN/YtPaX9jwcCFFe+QcbV90Oly36FV1NttsQWmdVj8rDdjn39JczrYmZAXa
         SaG2p7cToIyUfDg6Myj8SPodI157gOC8qw1+2/HeS+/i0IrazZvgnNSX8ia04mG2qRo0
         I2Qg==
X-Forwarded-Encrypted: i=1; AJvYcCUIQs7fzreTb1pdF5m8sNM1atkssmSY3H/Zmuq3wIgkDOWQtV+O5GMu15BfoRKbfFZzWBjkWnz22g5ljvrx@vger.kernel.org
X-Gm-Message-State: AOJu0YzAIARowAwHahccln7FAIVy+GOJ8wBU4HgaJcM4qdE3BJanBp3H
	jS5mhP5ZulTpCEhM96Tlfw/fMqsNBssN2VlpSz2vWUJnNXVTc8evxfhWiMLxeMWr5JqJLkcpmwq
	m0WEG4UrtIzGobQUWVFB6ygpxvk8mlJw6D1skNIj3mlfRnOXm0lp3HBsBAQEBf/Y=
X-Gm-Gg: ASbGncu1yiUkSyW7cg8JLA/s3hgfASmnxNM8fR3rU2ZAwVp/9RMn/WttSida3Vz2dBq
	NRROqclylB5/arQzCGeeUTfdIBV63xXgutZOnxZu20bszSZFD8PablFm4fmF4sIlwfzrWvrYFwT
	A0JQIKf0UuPz5B8AADpEaMtUsbQoRHNpkSE/f7PKe/dOAPopdXgn20Upql2xPRDVgiWQgtgEZ5S
	cPI7/esLGTAze8gbgbnJ7xT5DkaRqIZPn263eQeA8XNH0tb4XKm69yWJc1DMUfG15Ev39UOkr93
	Hrw=
X-Received: by 2002:a05:622a:58ce:b0:476:8e3e:2da3 with SMTP id d75a77b69052e-489e4f6fc2dmr127590441cf.30.1746116319173;
        Thu, 01 May 2025 09:18:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcqIuCWmckq0jndOW/QTvuIZgj2Fq8NtAAmLCfxHQ8TD/Z8m2S6F5ri3+/pogtyaymp4yTeA==
X-Received: by 2002:a05:622a:58ce:b0:476:8e3e:2da3 with SMTP id d75a77b69052e-489e4f6fc2dmr127589841cf.30.1746116318571;
        Thu, 01 May 2025 09:18:38 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-48b98d0fb2dsm5669031cf.77.2025.05.01.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:18:38 -0700 (PDT)
Date: Thu, 1 May 2025 12:18:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aBOe27gBqlwIj6lD@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>
 <aAqNYsMvU-7I-nu1@x1.local>
 <26a0a28c-197f-4d0b-ad58-c003d72b1700@kernel.dk>
 <aAqXlcYI9j39zQnE@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aAqXlcYI9j39zQnE@x1.local>

On Thu, Apr 24, 2025 at 03:57:09PM -0400, Peter Xu wrote:
> On Thu, Apr 24, 2025 at 01:20:46PM -0600, Jens Axboe wrote:
> > On 4/24/25 1:13 PM, Peter Xu wrote:
> > 
> > (skipping to this bit as I think we're mostly in agreement on the above)
> > 
> > >>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > >>> index 296d294142c8..fa721525d93a 100644
> > >>> --- a/arch/x86/mm/fault.c
> > >>> +++ b/arch/x86/mm/fault.c
> > >>> @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
> > >>>          * We set FAULT_FLAG_USER based on the register state, not
> > >>>          * based on X86_PF_USER. User space accesses that cause
> > >>>          * system page faults are still user accesses.
> > >>> +        *
> > >>> +        * When we're in user mode, allow fast response on non-fatal
> > >>> +        * signals.  Do not set this in kernel mode faults because normally
> > >>> +        * a kernel fault means the fault must be resolved anyway before
> > >>> +        * going back to userspace.
> > >>>          */
> > >>>         if (user_mode(regs))
> > >>> -               flags |= FAULT_FLAG_USER;
> > >>> +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
> > >>>  
> > >>>  #ifdef CONFIG_X86_64
> > >>>         /*
> > >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> > >>> index 9b701cfbef22..a80f3f609b37 100644
> > >>> --- a/include/linux/mm.h
> > >>> +++ b/include/linux/mm.h
> > >>> @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
> > >>>   * arch-specific page fault handlers.
> > >>>   */
> > >>>  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
> > >>> -                            FAULT_FLAG_KILLABLE | \
> > >>> -                            FAULT_FLAG_INTERRUPTIBLE)
> > >>> +                            FAULT_FLAG_KILLABLE)
> > >>> ===8<===
> > >>>
> > >>> That also kind of matches with what we do with fault_signal_pending().
> > >>> Would it make sense?
> > >>
> > >> I don't think doing a non-bounded non-interruptible sleep for a
> > >> condition that may never resolve (eg userfaultfd never fills the fault)
> > >> is a good idea. What happens if the condition never becomes true? You
> > > 
> > > If page fault is never going to be resolved, normally we sigkill the
> > > program as it can't move any further with no way to resolve the page fault.
> > > 
> > > But yeah that's based on the fact sigkill will work first..
> > 
> > Yep
> > 
> > >> can't even kill the task at that point... Generally UNINTERRUPTIBLE
> > >> sleep should only be used if it's a bounded wait.
> > >>
> > >> For example, if I ran my previous write(2) reproducer here and the task
> > >> got killed or exited before the userfaultfd fills the fault, then you'd
> > >> have the task stuck in 'D' forever. Can't be killed, can't get
> > >> reclaimed.
> > >>
> > >> In other words, this won't work.
> > > 
> > > .. Would you help explain why it didn't work even for SIGKILL?  Above will
> > > still set FAULT_FLAG_KILLABLE, hence I thought SIGKILL would always work
> > > regardless.
> > > 
> > > For such kernel user page access, IIUC it should respond to SIGKILL in
> > > handle_userfault(), then fault_signal_pending() would trap the SIGKILL this
> > > time -> going kernel fixups. Then the upper stack should get -EFAULT in the
> > > exception fixup path.
> > > 
> > > I could have missed something..
> > 
> > It won't work because sending the signal will not wake the process in
> > question as it's sleeping uninterruptibly, forever. My looping approach
> > still works for fatal signals as we abort the loop every now and then,
> > hence we know it won't be stuck forever. But if you don't have a timeout
> > on that uninterruptible sleep, it's not waking from being sent a signal
> > alone.
> > 
> > Example:
> > 
> > axboe@m2max-kvm ~> sudo ./tufd 
> > got buf 0xffff89800000
> > child will write
> > Page fault
> > flags = 0; address = ffff89800000
> > wait on child
> > fish: Job 1, 'sudo ./tufd' terminated by signal SIGKILL (Forced quit)
> > 
> > meanwhile in ps:
> > 
> > root         837     837  0.0    2  0.0  14628  1220 ?        Dl   12:37   0:00 ./tufd
> > root         837     838  0.0    2  0.0  14628  1220 ?        Sl   12:37   0:00 ./tufd
> 
> I don't know TASK_WAKEKILL well, but I was hoping it would work in this
> case.. E.g., even if with the patch, we still have chance to not use any
> timeout at [1] below?
> 
>         if (likely(must_wait && !READ_ONCE(ctx->released))) {
>                 wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> -               schedule();
> +               /* See comment in userfaultfd_get_blocking_state() */
> +               if (!wait_mode.timeout)
> +                       schedule();   <----------------------------- [1]
> +               else
> +                       schedule_timeout(HZ / 10);
>         }
> 
> So my understanding is sigkill also need to work always for [1] if
> FAULT_FLAG_KILLABLE is set (which should always be, iiuc).
> 
> Did I miss something else? It would be helpful too if you could share the
> reproducer; I can give it a shot.

Since the signal issue alone can definitely be reproduced with any
reproducer that triggers the fault in the kernel.. I wrote one today with
write() syscall, I'll attach that at the end.

I did try this patch, meanwhile I also verified that actually what I
provided previously (at the end of the reply) can also avoid the cpu
spinning, and it is also killable at least here..

https://lore.kernel.org/all/aAqCXfPirHqWMlb4@x1.local/

Jens, could you help me to find why that simpler (and IMHO must cleaner)
change wouldn't work for your case?

The important thing is, as I mentioned above sigkill need to also work for
[1], and I really want to know when it won't.. meanwhile it's logically
incorrect to set INTERRUPTIBLE for kernel faults, which this patch didn't
really address.

Thanks,

-- 
Peter Xu


