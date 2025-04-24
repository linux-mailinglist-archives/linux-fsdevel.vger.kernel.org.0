Return-Path: <linux-fsdevel+bounces-47255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FBCA9B013
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 16:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2BB46138B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD983186294;
	Thu, 24 Apr 2025 14:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="JVB5zuBs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4517A316
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 14:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503434; cv=none; b=Wh59vThc5qgRw+JxNL9XiuMKDB2Vhk51Jcgg6g55xVithxhIFRZXGFVkUEjoFsO5yN1VRMm92JAGWhWpFAHjL4qGFqEZHbTFHawU+x3+O+t2cNlMIyS5ue+1UK2GQ0GCxoUrKKMh4bKWpzyXOHgdJ3Q1Q3B9ktrjHSjeC0s9f5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503434; c=relaxed/simple;
	bh=he2bo1OHmbzSUcAhDfTbEjnkCUwILvbIlIEFwgJCDbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=go+cfVA/6/BcwKCxyOgC3tvQZcvXC41F4rvhId4mPeQWpU/o5TUowroVVvy26hMJjDjVOIwXO5VbdgCiFzB3K5w7vTJ4WkUyFPavcdxRAFdTsR+Bz+Y9AJIWa6TxO2L8fKAfOOGZlwhcxlIdmN2krslGKwseADzGibGCoOjEu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=JVB5zuBs; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-6f0cfbe2042so13589166d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1745503429; x=1746108229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuBoOpzO4HI7+MmYJqWcOQNx+WCqjRzx2t0T6b4RNog=;
        b=JVB5zuBseGOlqqHToV2ajcmMXy77WFZsMdsKEZcXz33nCrThAwcQrUDPvTZtIhQ6R0
         hlFB54jGML4h+r8l8SBqJM/q/jKY+Ej0zyRvzUnhmb9W6cU3Zdu6HgGhUxiXOKJ0+Unv
         5HL8dep1KmT1L8gu5wkA8P/PgCug/GHZO/EbGQg6MUn3SsKEjOwXdRvGOl2x6hJDu6Zh
         FM7ppxy78n2JFRnluiKQjdViWxeqDXNr1FAVPCyv2QTW9t2AcUqBzslJwSNlW5xfv6+c
         wtfQadhh1J+bZEp89kPmGhnoy6/PQmPwzzQbGQXcM7TeyWPrGodfzbUcJ8OZD3HdeegM
         SZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745503429; x=1746108229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuBoOpzO4HI7+MmYJqWcOQNx+WCqjRzx2t0T6b4RNog=;
        b=Jc3HWS3yHptEc/rnltRhRWKWJJ6wklVF4Y6XdURsHQpXhejlHfW+LTT70GXyPQ36bp
         dSJ4nK919csfWV9GcEs5D9rFsfvBhwYQ/hWq3xy0tFwyTpDMbAUE8c/miWXmutoZNoMt
         H2iusobiHfGzE2GewBrGS8xjMXnJDAVN4ruUPNeV6Ui7KJcf25DeHSTYU7s1/N4WgHfi
         YXkIyjJVMhOsl3CVKIEi6AttO2K4+XXvMAn/sNY/83yZuiOQjMQUEVMPImkuD8+RlJb2
         4iZTkABGZLafS1vf8CKdPDRcLYHhdAh3LsvEbSBGhCV7MnOwQfu4t18/5nmd3dRVw6L3
         Jedg==
X-Forwarded-Encrypted: i=1; AJvYcCXfkRwG3nzfa300iFvpQzzWY6IEMaxPs5IHPhG1Xn6ddHC94s0MaRzgd+n2fO/azZ/uXtuat04Uqs6wX5XC@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3MRtO6DuyN4Fp9hvb8o9le7cEx+tNiU4jNDtDTEaid5lf/C8u
	/5v6aaLQ8u9IoO4YHkwMy+JBt1En7SNF7/suD9MW19MYT9dxwUtBjuP57Jb5JAw7mLeUwhSMjB0
	dVe5rWw==
X-Gm-Gg: ASbGncuYtKTS4qXVoCoy9HDeHVsLoiFfh4hYdHC5QA95Gzyfd0o/j3USoW/s7QnkJKz
	MEaYhsbAVubETgAVu5u2sckc2el23ynGYdDqsJknssvh1A06tboF3lBAtmAD4ZaI2Nj3E7NQobV
	jSl8TDRZiCqK0whCQajAQZzQ780nD83HR+P6P15hEZj1CaLDdgD4FYSWWEmtYUdHPQioLpW2fxf
	p4joPJHPTBZ0bMVtBKHYf8UAbzyZMHGOxjFPsQC98yAtQiRRgeo1W2sNnu2z7FHSyxaX3IkvrYC
	4FgBOKpXt26ra5KiBbyKYbcY2qhoPp2/CLbok6F7GuWSB8u62w==
X-Google-Smtp-Source: AGHT+IEIzbE+5QviSUqiQqOIlAq9SVAo+rU1CTcUl+6WL96U3eoCzmI0EQpuZ4GXtAcXFz4jgrHSvw==
X-Received: by 2002:a05:6214:509d:b0:6ea:eeb6:c82b with SMTP id 6a1803df08f44-6f4c0f4a7a7mr34487166d6.2.1745503428983;
        Thu, 24 Apr 2025 07:03:48 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:365a:60ff:fe62:ff29])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f4c0a74048sm9630576d6.85.2025.04.24.07.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 07:03:48 -0700 (PDT)
Date: Thu, 24 Apr 2025 10:03:44 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm/userfaultfd: prevent busy looping for tasks with
 signals pending
Message-ID: <20250424140344.GA840@cmpxchg.org>
References: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>

On Wed, Apr 23, 2025 at 05:37:06PM -0600, Jens Axboe wrote:
> userfaultfd may use interruptible sleeps to wait on userspace filling
> a page fault, which works fine if the task can be reliably put to
> sleeping waiting for that. However, if the task has a normal (ie
> non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
> cause schedule() to be a no-op.
> 
> For a task that registers a page with userfaultfd and then proceeds
> to do a write from it, if that task also has a signal pending then
> it'll essentially busy loop from do_page_fault() -> handle_userfault()
> until that fault has been filled. Normally it'd be expected that the
> task would sleep until that happens. Here's a trace from an application
> doing just that:
> 
> handle_userfault+0x4b8/0xa00 (P)
> hugetlb_fault+0xe24/0x1060
> handle_mm_fault+0x2bc/0x318
> do_page_fault+0x1e8/0x6f0

Makes sense. There is a fault_signal_pending() check before retrying:

static inline bool fault_signal_pending(vm_fault_t fault_flags,
                                        struct pt_regs *regs)
{
        return unlikely((fault_flags & VM_FAULT_RETRY) &&
                        (fatal_signal_pending(current) ||
                         (user_mode(regs) && signal_pending(current))));
}

Since it's an in-kernel fault, and the signal is non-fatal, it won't
stop looping until the fault is handled.

This in itself seems a bit sketchy. You have to hope there is no
dependency between handling the signal -> handling the fault inside
the userspace components.

> do_translation_fault+0x9c/0xd0
> do_mem_abort+0x44/0xa0
> el1_abort+0x3c/0x68
> el1h_64_sync_handler+0xd4/0x100
> el1h_64_sync+0x6c/0x70
> fault_in_readable+0x74/0x108 (P)
> iomap_file_buffered_write+0x14c/0x438
> blkdev_write_iter+0x1a8/0x340
> vfs_write+0x20c/0x348
> ksys_write+0x64/0x108
> __arm64_sys_write+0x1c/0x38
>
> where the task is looping with 100% CPU time in the above mentioned
> fault path.
> 
> Since it's impossible to handle signals, or other conditions like
> TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
> fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
> modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
> signals will still be handled by the caller, and the timeout is short
> enough to hopefully not cause any issues. If this is the first invocation
> of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
> is used.
>
> Cc: stable@vger.kernel.org
> Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")

When this patch was first introduced, VM_FAULT_RETRY would work only
once. The second try would have FAULT_FLAG_ALLOW_RETRY cleared,
causing handle_userfault() to return VM_SIGBUS, which would bubble
through the fixup table (kernel fault), -EFAULT from
iomap_file_buffered_write() and unwind the kernel stack this way.

So I'm thinking this is the more likely commit for Fixes: and stable:

commit 4064b982706375025628094e51d11cf1a958a5d3
Author: Peter Xu <peterx@redhat.com>
Date:   Wed Apr 1 21:08:45 2020 -0700

    mm: allow VM_FAULT_RETRY for multiple times

> Reported-by: Zhiwei Jiang <qq282012236@gmail.com>
> Link: https://lore.kernel.org/io-uring/20250422162913.1242057-1-qq282012236@gmail.com/
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

