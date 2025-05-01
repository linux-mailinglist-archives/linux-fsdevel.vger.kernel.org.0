Return-Path: <linux-fsdevel+bounces-47834-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CDAAA6165
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93B19C0C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3020E70C;
	Thu,  1 May 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NdTNJAYu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372420C49C
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 May 2025 16:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746116938; cv=none; b=opF05tCAX5RvPp5b9jOG9gXw9OwNVnltI6ARNEEXxZiRmdLTke1k6SK3YrZSG2rTFHGNFYOAHjyuH3SyHMPp/tALWvjng4G9hPNNI2bomIA6TShTFmuLJNoUhrGbaN8JddHXXA27iQNhwi58KPT12LTZRe0+azOhvKZHasl30A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746116938; c=relaxed/simple;
	bh=ObE5VS/qIwThd+nOKdwv90xGXHk/JPOnMtDyXpBTZRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aM122QtKRHo+s/36eq6JGUMy1ntDpAPtDGa2Es7FCNsE9JuQxGmWWRYWKKdZI6dxqH+rNa484hQIhga/Z9WZvXUYHTyN38NwjAoEQWZOylU63jwhh9KyeS1GgbgCS6BrQjC/EUzb5qL7vO74rXdTEkKas9gc0dmlkxp1dJRsYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NdTNJAYu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746116935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=POFJZm9mCkwmAkqxkeFxdJcXQWJvnT1NIr0tGy5Ovr8=;
	b=NdTNJAYuF0zTtFsU/LG2NEUf5EwvMbcA5QcMwGJ+inNWgZczdbFZE5cjKQo+RpAmPdTNEr
	eAoqtFfwq/PxZ6ToeOQjSf00vF1EZVAsERQ9iB3UwfvhzybZbw8AdkJWlYfzUd3IVL50uf
	sqrYkQ6ECpcEYPA7KVUmY7RaA0nf5lQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-tuUVZe38MpitTchJ2ezfrw-1; Thu, 01 May 2025 12:28:53 -0400
X-MC-Unique: tuUVZe38MpitTchJ2ezfrw-1
X-Mimecast-MFC-AGG-ID: tuUVZe38MpitTchJ2ezfrw_1746116933
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c5c9abdbd3so107096485a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 May 2025 09:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746116933; x=1746721733;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POFJZm9mCkwmAkqxkeFxdJcXQWJvnT1NIr0tGy5Ovr8=;
        b=JFFpaNNFVykcQBVu4MZGmHUa28UMYiSIqfA8YrJ/9GUj4GB93JbOF4VllqeWVY02G2
         p9/ld9NtW8qx47SSSK5HVt1GZZnl2NlJ+Bj0+BhryInQWO8LjtWDyVRk9FZK/05RrHe1
         wMEArt8WYqtv1sLAePCsTeau3EvPtpyqYBcV3kzMZEUq1lKl1wogVRjTaY6wfxN/fDeT
         dIKcKuTzjttXkbpdfK1584GxuLOaGSbdV2eQmJ7S6sswFzCXCdqshVgydRAkDmmfxoEX
         rLujuNsfMJKB0oBuer2hhkQFFzp/vJ7CJePXxcly9M8rW+lstD2SEgKIXXdTNB6wPkw+
         vxAg==
X-Forwarded-Encrypted: i=1; AJvYcCXCkEPoUpHFbw7zvYqqDmQb5FUn2v7EuQZNIClmiKO3pmP0qLAdA3hVjEkkmBIcOU7j/XlC+GuUo9rEGmxU@vger.kernel.org
X-Gm-Message-State: AOJu0YwEoo86XLMPFRLZqb/AJfDevyyFJjnmqKqXLYjrYoX7ucecsv3y
	xNGa3H+g66Q8PQVhAKgTagRpr5SxcJAgpj56ImVtQ1cKst2yG+H3kHJGiYCiGfeO9g0RNXj1aft
	npJLWZWSKDpPCiznjgnjUabvUfghWbrDXRND93CBlNX3R6p04JJnlWwApDhs1r/FEhAHKt2k=
X-Gm-Gg: ASbGncsWDKVJDJGLx65JWai00VBPulAFxcfDpFoSyGVzN86H9H8LaKHBBRn7X6Y5hTT
	L68Lrdbd1FZhrRumdljkj3UICs4HJ+h5hitpyBw/NvqY7R1hvVgmVl0f6cdeqDg4brsWYGiRbF6
	bWZl2VfbJjuXlrZF3ptigkGFBOyd8u8Xlfyvbkcr3NV+dcTFNWT+eloaRh5HHuv98i9hZsq1G6q
	w3eS5WOtHL6GskYTYawhyB9KFOyWOQt6AMsVxkPiwekgsPyEyuFr597bFAq64h55eeIRKPyOPnF
	RCE=
X-Received: by 2002:a05:620a:4150:b0:7c5:602f:51fc with SMTP id af79cd13be357-7caceffd66fmr404954785a.44.1746116932616;
        Thu, 01 May 2025 09:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaLtDw2oaUnXy5i1K0ukWVnpC8lWGFP2VjjF8AJY1HY9brz4VmAyqEbWQHCliEQppWDHSJEA==
X-Received: by 2002:a05:620a:4150:b0:7c5:602f:51fc with SMTP id af79cd13be357-7caceffd66fmr404951385a.44.1746116932148;
        Thu, 01 May 2025 09:28:52 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cad23c3cf3sm65689985a.36.2025.05.01.09.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 09:28:51 -0700 (PDT)
Date: Thu, 1 May 2025 12:28:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <aBOhQVr-jmY1nvlb@x1.local>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
 <20250424140344.GA840@cmpxchg.org>
 <aAqCXfPirHqWMlb4@x1.local>
 <86e2e26e-e939-4c45-879c-5021473cfb5a@kernel.dk>
 <aAqNYsMvU-7I-nu1@x1.local>
 <26a0a28c-197f-4d0b-ad58-c003d72b1700@kernel.dk>
 <aAqXlcYI9j39zQnE@x1.local>
 <aBOe27gBqlwIj6lD@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aBOe27gBqlwIj6lD@x1.local>

On Thu, May 01, 2025 at 12:18:35PM -0400, Peter Xu wrote:
> On Thu, Apr 24, 2025 at 03:57:09PM -0400, Peter Xu wrote:
> > On Thu, Apr 24, 2025 at 01:20:46PM -0600, Jens Axboe wrote:
> > > On 4/24/25 1:13 PM, Peter Xu wrote:
> > > 
> > > (skipping to this bit as I think we're mostly in agreement on the above)
> > > 
> > > >>> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> > > >>> index 296d294142c8..fa721525d93a 100644
> > > >>> --- a/arch/x86/mm/fault.c
> > > >>> +++ b/arch/x86/mm/fault.c
> > > >>> @@ -1300,9 +1300,14 @@ void do_user_addr_fault(struct pt_regs *regs,
> > > >>>          * We set FAULT_FLAG_USER based on the register state, not
> > > >>>          * based on X86_PF_USER. User space accesses that cause
> > > >>>          * system page faults are still user accesses.
> > > >>> +        *
> > > >>> +        * When we're in user mode, allow fast response on non-fatal
> > > >>> +        * signals.  Do not set this in kernel mode faults because normally
> > > >>> +        * a kernel fault means the fault must be resolved anyway before
> > > >>> +        * going back to userspace.
> > > >>>          */
> > > >>>         if (user_mode(regs))
> > > >>> -               flags |= FAULT_FLAG_USER;
> > > >>> +               flags |= FAULT_FLAG_USER | FAULT_FLAG_INTERRUPTIBLE;
> > > >>>  
> > > >>>  #ifdef CONFIG_X86_64
> > > >>>         /*
> > > >>> diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > >>> index 9b701cfbef22..a80f3f609b37 100644
> > > >>> --- a/include/linux/mm.h
> > > >>> +++ b/include/linux/mm.h
> > > >>> @@ -487,8 +487,7 @@ extern unsigned int kobjsize(const void *objp);
> > > >>>   * arch-specific page fault handlers.
> > > >>>   */
> > > >>>  #define FAULT_FLAG_DEFAULT  (FAULT_FLAG_ALLOW_RETRY | \
> > > >>> -                            FAULT_FLAG_KILLABLE | \
> > > >>> -                            FAULT_FLAG_INTERRUPTIBLE)
> > > >>> +                            FAULT_FLAG_KILLABLE)
> > > >>> ===8<===
> > > >>>
> > > >>> That also kind of matches with what we do with fault_signal_pending().
> > > >>> Would it make sense?
> > > >>
> > > >> I don't think doing a non-bounded non-interruptible sleep for a
> > > >> condition that may never resolve (eg userfaultfd never fills the fault)
> > > >> is a good idea. What happens if the condition never becomes true? You
> > > > 
> > > > If page fault is never going to be resolved, normally we sigkill the
> > > > program as it can't move any further with no way to resolve the page fault.
> > > > 
> > > > But yeah that's based on the fact sigkill will work first..
> > > 
> > > Yep
> > > 
> > > >> can't even kill the task at that point... Generally UNINTERRUPTIBLE
> > > >> sleep should only be used if it's a bounded wait.
> > > >>
> > > >> For example, if I ran my previous write(2) reproducer here and the task
> > > >> got killed or exited before the userfaultfd fills the fault, then you'd
> > > >> have the task stuck in 'D' forever. Can't be killed, can't get
> > > >> reclaimed.
> > > >>
> > > >> In other words, this won't work.
> > > > 
> > > > .. Would you help explain why it didn't work even for SIGKILL?  Above will
> > > > still set FAULT_FLAG_KILLABLE, hence I thought SIGKILL would always work
> > > > regardless.
> > > > 
> > > > For such kernel user page access, IIUC it should respond to SIGKILL in
> > > > handle_userfault(), then fault_signal_pending() would trap the SIGKILL this
> > > > time -> going kernel fixups. Then the upper stack should get -EFAULT in the
> > > > exception fixup path.
> > > > 
> > > > I could have missed something..
> > > 
> > > It won't work because sending the signal will not wake the process in
> > > question as it's sleeping uninterruptibly, forever. My looping approach
> > > still works for fatal signals as we abort the loop every now and then,
> > > hence we know it won't be stuck forever. But if you don't have a timeout
> > > on that uninterruptible sleep, it's not waking from being sent a signal
> > > alone.
> > > 
> > > Example:
> > > 
> > > axboe@m2max-kvm ~> sudo ./tufd 
> > > got buf 0xffff89800000
> > > child will write
> > > Page fault
> > > flags = 0; address = ffff89800000
> > > wait on child
> > > fish: Job 1, 'sudo ./tufd' terminated by signal SIGKILL (Forced quit)
> > > 
> > > meanwhile in ps:
> > > 
> > > root         837     837  0.0    2  0.0  14628  1220 ?        Dl   12:37   0:00 ./tufd
> > > root         837     838  0.0    2  0.0  14628  1220 ?        Sl   12:37   0:00 ./tufd
> > 
> > I don't know TASK_WAKEKILL well, but I was hoping it would work in this
> > case.. E.g., even if with the patch, we still have chance to not use any
> > timeout at [1] below?
> > 
> >         if (likely(must_wait && !READ_ONCE(ctx->released))) {
> >                 wake_up_poll(&ctx->fd_wqh, EPOLLIN);
> > -               schedule();
> > +               /* See comment in userfaultfd_get_blocking_state() */
> > +               if (!wait_mode.timeout)
> > +                       schedule();   <----------------------------- [1]
> > +               else
> > +                       schedule_timeout(HZ / 10);
> >         }
> > 
> > So my understanding is sigkill also need to work always for [1] if
> > FAULT_FLAG_KILLABLE is set (which should always be, iiuc).
> > 
> > Did I miss something else? It would be helpful too if you could share the
> > reproducer; I can give it a shot.
> 
> Since the signal issue alone can definitely be reproduced with any
> reproducer that triggers the fault in the kernel.. I wrote one today with
> write() syscall, I'll attach that at the end.
> 
> I did try this patch, meanwhile I also verified that actually what I
> provided previously (at the end of the reply) can also avoid the cpu
> spinning, and it is also killable at least here..
> 
> https://lore.kernel.org/all/aAqCXfPirHqWMlb4@x1.local/
> 
> Jens, could you help me to find why that simpler (and IMHO must cleaner)
> change wouldn't work for your case?
> 
> The important thing is, as I mentioned above sigkill need to also work for
> [1], and I really want to know when it won't.. meanwhile it's logically
> incorrect to set INTERRUPTIBLE for kernel faults, which this patch didn't
> really address.

My reproducer:

$ cat uffd-kernel-sig.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <stdint.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <linux/userfaultfd.h>
#include <poll.h>
#include <pthread.h>
#include <fcntl.h>
#include <signal.h>
#include <errno.h>
#include <sys/ioctl.h>
#include <assert.h>

#define PAGE_SIZE 4096
#define BUFFER_PAGES 2

void sigusr1_handler(int signum) {
    printf("SIGUSR1 SIGNAL\n");
}

static int setup_userfaultfd(void *addr, size_t len) {
    int uffd = syscall(SYS_userfaultfd, O_CLOEXEC | O_NONBLOCK);
    if (uffd == -1) {
        perror("userfaultfd");
        exit(1);
    }

    struct uffdio_api ua = {
        .api = UFFD_API
    };
    if (ioctl(uffd, UFFDIO_API, &ua) == -1) {
        perror("UFFDIO_API");
        exit(1);
    }

    struct uffdio_register ur = {
        .range = {
            .start = (unsigned long)addr,
            .len = len
        },
        .mode = UFFDIO_REGISTER_MODE_MISSING
    };
    if (ioctl(uffd, UFFDIO_REGISTER, &ur) == -1) {
        perror("UFFDIO_REGISTER");
        exit(1);
    }

    return uffd;
}

void *signal_sender(void *arg) {
    pid_t pid = getpid();
    usleep(100000);
    kill(pid, SIGUSR1);
    return NULL;
}

int main() {
    struct sigaction sa;

    sa.sa_handler = sigusr1_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (sigaction(SIGUSR1, &sa, NULL) == -1) {
        perror("sigaction");
        exit(1);
    }

    size_t buffer_size = BUFFER_PAGES * PAGE_SIZE;

    void *src_buf = mmap(NULL, buffer_size, PROT_READ | PROT_WRITE,
                         MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (src_buf == MAP_FAILED) {
        perror("mmap src_buf");
        exit(1);
    }

    if (madvise(src_buf, buffer_size, MADV_DONTNEED) == -1) {
        perror("madvise");
        exit(1);
    }

    void *dst_buf = malloc(buffer_size);
    if (!dst_buf) {
        perror("malloc dst_buf");
        exit(1);
    }

    int uffd = setup_userfaultfd(src_buf, buffer_size);

    pthread_t thread;
    if (pthread_create(&thread, NULL, signal_sender, NULL) != 0) {
        perror("pthread_create");
        exit(1);
    }

    int tmp = open("/tmp/file", O_WRONLY | O_CREAT, 0644);
    if (tmp < 0) {
        exit(EXIT_FAILURE);
    }

    ssize_t written = write(tmp, src_buf, buffer_size);
    printf("write returned：%zd\n", written);

    close(tmp);

    return 0;
}

-- 
Peter Xu


