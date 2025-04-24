Return-Path: <linux-fsdevel+bounces-47294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C286DA9B892
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E25B92795D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAEA293440;
	Thu, 24 Apr 2025 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUbsCcIj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7878F59
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 19:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745524638; cv=none; b=UfU+ZNjKN1AYt1MIAbqZkDeE6dr9Uyc2DCisaLzSg/Wk47ZIeCIF7PkHYjcrL/S/YwD59n/kS4gtXCxC/zVFt/EWKUYn062mYitn26vQjOXJTQzyqkVu675a1ZyRh8Se821LYvl0BH7rdihwy1RrbQuUcGURXmRNhxsnxvR4Qx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745524638; c=relaxed/simple;
	bh=LW4B/4q6WkRLc5LuQzSPYeyL8n4gMKbD60Ou+hkkSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWEId7rpDwzJLNdyK6AkauYVhmKyanxEHHc12hirVs8nm08VE68/s61IhU01goEpAeSJjrjSz7uXL/w8js/2l8cqcEp9AHI67g5LCYXzkBYS1H22DX/JEwErK5mivcp0eWdoDe7EURBacdCPXoW+iX/79OfMEa5mPFUjGmRwfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUbsCcIj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745524635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i8hpAx0eweqVSXXbQhjnLIlU+eThfWl13dDIADUavMI=;
	b=aUbsCcIjKF4NXZbFC4mYPX7TVA47aARIDBSNr2Jmgkhb0CGp6iKLatzGpahooeeMer+rt/
	Nf5+YtK3dbKQaAe2pMT7ZRzdj56Zc7t2wNlHfqx10nBTKXJFVpwB9kq15mw4oVQhIuNLNE
	SH/oCFvZXfeQX86cRxm2cpe17aVrdEk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-yDOkkhS6PX6iP7GdyTvM0g-1; Thu, 24 Apr 2025 15:57:13 -0400
X-MC-Unique: yDOkkhS6PX6iP7GdyTvM0g-1
X-Mimecast-MFC-AGG-ID: yDOkkhS6PX6iP7GdyTvM0g_1745524633
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6e91d8a7165so25053596d6.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 12:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745524633; x=1746129433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8hpAx0eweqVSXXbQhjnLIlU+eThfWl13dDIADUavMI=;
        b=Vi2WoTce0By5r2A3p2uIN08QjqCe3Og8tbEFSqs5CL2CHj7tJiCzbykT2yc0ac/eOk
         nOA4GH4ooH39llFniDuBjNwPwVQ1YaKxrpkS3gPQ0eKgxe427TfgktXaLt8SqXQIJCgw
         xxhMarnXy/fXHWYadW28/I2VsSiZZA1nJln54TqUtAlBQhNsgS1Svds1PUJl8Wk2jrwo
         aJB7IaXQ06paU9SYyWV6wBG141V8yZNn6Y8B6CznqB2fg9doHkYs1VCCnX1agZV2+TiU
         TkmOWJvocpF7Cu0OdV+xKA9tt8qsrTXplfCl+Ix9/ib8y+6w4P7yHqHa9zbAoBvkABNs
         Vl9w==
X-Forwarded-Encrypted: i=1; AJvYcCVt37i9ahYHH5OhHq+SG4suLAqNJA9SS3MK7F2V4Z4YNgF4/oEyypBtL3dEm2gE4IVmNWYn942YJYQAd46R@vger.kernel.org
X-Gm-Message-State: AOJu0YzU9u7IlXmbd15R5Vh/ahs7jaueXkROVStk2N4puN/dK6EqCS/2
	7TAmrjdFoQ2VQQGpDn05VKBteECBEQ+0tbzGIZQTXqETbO+IxYpQFHt9IFZzRR/Wb7fAUTEhS4M
	g6mYmSUAZ6UNBYCE7ZHUSzXNxD60GBJcNcbOhB/4KlsFTVmDJPK8iE0kgpxFcaiY=
X-Gm-Gg: ASbGncsGa8XcxBHKI7GdsDX3gRlXXgbzdTnVnXW6voOtXEjuT8471YAsp8+9kh6fQLh
	7a9xhxrskEF7Q5EZ6m+Mam+PPZB76TZRNBBQRqQ7fZ2oUymf9eDfR4LQ2SdCLcmFbcoj9q3Mcxx
	dQ5WDsEPTfY3sJvAJLczvwvMfP00xxsYrb4IGRSKvGahPBnBJbAoXB89PZSVgodLxlNiNaX34q9
	s4k4pNKe9xYWIt3PoXJMi89FPVasNCqrCtnuMSwrJ40hSQeSlmjrbrFyFTy0enU0uSSTbNXh2pq
	AIw=
X-Received: by 2002:a05:620a:1d02:b0:7c7:a356:105d with SMTP id af79cd13be357-7c956ea97f0mr731904985a.4.1745524633376;
        Thu, 24 Apr 2025 12:57:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV96oy+u6GUAI7e6Y1VzaKBV3VTfTOAsdjbVU9gCpAcjyZBNWfDAeMQWeTUVag4urC4RbwLg==
X-Received: by 2002:a05:620a:1d02:b0:7c7:a356:105d with SMTP id af79cd13be357-7c956ea97f0mr731901085a.4.1745524632928;
        Thu, 24 Apr 2025 12:57:12 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958ce3d54sm127025185a.51.2025.04.24.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 12:57:11 -0700 (PDT)
Date: Thu, 24 Apr 2025 15:57:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aAqXlcYI9j39zQnE@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>
 <aAqNYsMvU-7I-nu1@x1.local>
 <26a0a28c-197f-4d0b-ad58-c003d72b1700@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26a0a28c-197f-4d0b-ad58-c003d72b1700@kernel.dk>

On Thu, Apr 24, 2025 at 01:20:46PM -0600, Jens Axboe wrote:
> On 4/24/25 1:13 PM, Peter Xu wrote:
> 
> (skipping to this bit as I think we're mostly in agreement on the above)
> 
> >>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> >>> index 296d294142c8..fa721525d93a 100644
> >>> --- a/arch/x86/mm/fault.c
> >>> +++ b/arch/x86/mm/fault.c
> >>> @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
> >>>          * We set FAULT_FLAG_USER based on the register state, not
> >>>          * based on X86_PF_USER. User space accesses that cause
> >>>          * system page faults are still user accesses.
> >>> +        *
> >>> +        * When we're in user mode, allow fast response on non-fatal
> >>> +        * signals.  Do not set this in kernel mode faults because normally
> >>> +        * a kernel fault means the fault must be resolved anyway before
> >>> +        * going back to userspace.
> >>>          */
> >>>         if (user_mode(regs))
> >>> -               flags |= FAULT_FLAG_USER;
> >>> +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
> >>>  
> >>>  #ifdef CONFIG_X86_64
> >>>         /*
> >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> >>> index 9b701cfbef22..a80f3f609b37 100644
> >>> --- a/include/linux/mm.h
> >>> +++ b/include/linux/mm.h
> >>> @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
> >>>   * arch-specific page fault handlers.
> >>>   */
> >>>  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
> >>> -                            FAULT_FLAG_KILLABLE | \
> >>> -                            FAULT_FLAG_INTERRUPTIBLE)
> >>> +                            FAULT_FLAG_KILLABLE)
> >>> ===8<===
> >>>
> >>> That also kind of matches with what we do with fault_signal_pending().
> >>> Would it make sense?
> >>
> >> I don't think doing a non-bounded non-interruptible sleep for a
> >> condition that may never resolve (eg userfaultfd never fills the fault)
> >> is a good idea. What happens if the condition never becomes true? You
> > 
> > If page fault is never going to be resolved, normally we sigkill the
> > program as it can't move any further with no way to resolve the page fault.
> > 
> > But yeah that's based on the fact sigkill will work first..
> 
> Yep
> 
> >> can't even kill the task at that point... Generally UNINTERRUPTIBLE
> >> sleep should only be used if it's a bounded wait.
> >>
> >> For example, if I ran my previous write(2) reproducer here and the task
> >> got killed or exited before the userfaultfd fills the fault, then you'd
> >> have the task stuck in 'D' forever. Can't be killed, can't get
> >> reclaimed.
> >>
> >> In other words, this won't work.
> > 
> > .. Would you help explain why it didn't work even for SIGKILL?  Above will
> > still set FAULT_FLAG_KILLABLE, hence I thought SIGKILL would always work
> > regardless.
> > 
> > For such kernel user page access, IIUC it should respond to SIGKILL in
> > handle_userfault(), then fault_signal_pending() would trap the SIGKILL this
> > time -> going kernel fixups. Then the upper stack should get -EFAULT in the
> > exception fixup path.
> > 
> > I could have missed something..
> 
> It won't work because sending the signal will not wake the process in
> question as it's sleeping uninterruptibly, forever. My looping approach
> still works for fatal signals as we abort the loop every now and then,
> hence we know it won't be stuck forever. But if you don't have a timeout
> on that uninterruptible sleep, it's not waking from being sent a signal
> alone.
> 
> Example:
> 
> axboe@m2max-kvm ~> sudo ./tufd 
> got buf 0xffff89800000
> child will write
> Page fault
> flags = 0; address = ffff89800000
> wait on child
> fish: Job 1, 'sudo ./tufd' terminated by signal SIGKILL (Forced quit)
> 
> meanwhile in ps:
> 
> root         837     837  0.0    2  0.0  14628  1220 ?        Dl   12:37   0:00 ./tufd
> root         837     838  0.0    2  0.0  14628  1220 ?        Sl   12:37   0:00 ./tufd

I don't know TASK_WAKEKILL well, but I was hoping it would work in this
case.. E.g., even if with the patch, we still have chance to not use any
timeout at [1] below?

        if (likely(must_wait && !READ_ONCE(ctx->released))) {
                wake_up_poll(&ctx->fd_wqh, EPOLLIN);
-               schedule();
+               /* See comment in userfaultfd_get_blocking_state() */
+               if (!wait_mode.timeout)
+                       schedule();   <----------------------------- [1]
+               else
+                       schedule_timeout(HZ / 10);
        }

So my understanding is sigkill also need to work always for [1] if
FAULT_FLAG_KILLABLE is set (which should always be, iiuc).

Did I miss something else? It would be helpful too if you could share the
reproducer; I can give it a shot.

Thanks,

-- 
Peter Xu


