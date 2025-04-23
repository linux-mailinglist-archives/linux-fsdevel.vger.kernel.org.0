Return-Path: <linux-fsdevel+bounces-47144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886BA99C1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 01:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3776217E114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 23:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FC22AE48;
	Wed, 23 Apr 2025 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vFEtul2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238671DD539
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745451433; cv=none; b=G6J90UzzpsGL8bi55T06BjE5sTdT/6RAd+HfNdfp8MV8yWhDxhMPSAOoLrEZs8M2fVytFqxkPU2KDuZvAevNqJqgdidPzAdhHCuoufqn+TIur58WcfMnhhDg4u0Nxyrprwu7Jr5qtKYSRLJ30w1KctDwHF7y/eC4uy9AZD4ksqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745451433; c=relaxed/simple;
	bh=OCZXg1CW3TAVFpbvKOZRzwLidKkrxUp3L4tUyscnjrQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=cz07sWU5UG7hI8DlS2V7mEtBjRx6rPchjkucJeR6qYo+bdM4ZLaNw6XDl3ZueXilIMrX+coV52FnWjvtjG3JBhXOvkuIgAhc/Eq4E9Ng5BTq7pWGy3zv2tbjWSdmNlZvVXejug/mjsouZqUXCzdWHWJ0v+eAXTVCEf+NQ0j8Zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vFEtul2V; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-86135ae2a29so37787639f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 16:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745451428; x=1746056228; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFKOnGdjBqau8OmYx/BNPb2ao+RmVqkaUpGcFvuPwg8=;
        b=vFEtul2VwIWAeTcRKTR/C1j+CzYU/BvF3VnusUyGc+n2AF/CeXvboAm2hdEQz66Dgu
         aljOuhZKAtkCqI4yG0yjqhBo2mS1+PLdoacjJjBy+Yz1TeKHWZhqdgSDG6ruy1/jE/3c
         72A3QwxjJx6QXAREYZjWwG/ZRprQlq1io5apsELHmn/H8xefG1LWnLEQxSxn/Q6vC1W0
         N8ceY5a1GKmwBuUOzRz514HtDJ50K4LxqFcfC/h1l3HEfb2MbZn4w8fV5NMHqR5fLakD
         8Plz8CbeTFqqNPYFOG4TDYVHKcyM9oHui1G2TcIKPTfad4LclKROtrGix4RZA/jQvHjn
         n6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745451428; x=1746056228;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KFKOnGdjBqau8OmYx/BNPb2ao+RmVqkaUpGcFvuPwg8=;
        b=dKVp5dKV1JuQSEwRmRaGFK/FSN/eA+VW371i6b20Klz5IK/JxJ0EmwFzcoWuODN6ck
         nfbpLs14GnaARKSJZS8tfGAqMjTdS1i6dszmqv42tPw8nrjQ+zPdVCEJVfghHKDvm/PA
         vHB93mcxcJnRDjl1CeM1PXKeQtemz6pknLgE5Q2ok8w/4bIYEV3ATH7Na4c0LObhlkHX
         VPlBDBinl8x2GO2bpn3UOZUr3u2kCTbLhBajPVlVrQAqIYRxX+ICHiDFQI5iGf5BnfxK
         ADLQ75wJEkFxdg+icMJZX1RYvxptzE/piBl/vxTWCG3fccX+ud/nkuEexEY16pmV36Zs
         09ZA==
X-Gm-Message-State: AOJu0YzbQH6QIxRoPgB55KTy/VILHa9y8xpmi/xyP8/C4fBDo69ztbKM
	5BneXmfvmMV6S3FVt8vtbmDH7ie+kScg29IoR9K9y/DYxY9gC+wTa9zgT4RzAMg=
X-Gm-Gg: ASbGncsvv8dJpjho5geRi/viKXHsT9xLp3O0tFbZ6/2WOhgEYGogfp8H+DSq3OcMjyr
	LN0WN6UF2yG4Oiqr2vPpHfwA+RCPggK5g/HUfTCawHgeWrmoW+1jLcTXC72o/+eu6oO7gItvE3X
	2K6QVZBN3xdt3N5s1I+j7BKLm9yc8GQ70528YKg6d+kYKg9GRfSbZhYvovg+WvVZ7Ok7OmlHDst
	ij3hLyMMFBp7Uw03pHt/BM2hqGrOSQd3XOhwUkjHEx223mZXVO+w9klTmU5kDYM7O0JzjWbAxY9
	771Uy1gHojFsa1ONdrf3J51khnPxErrOmTXqXA==
X-Google-Smtp-Source: AGHT+IGXZyUahui3XSgoqPBy1noMGucKZpOXTwqslsPuoScRJsBmFS0fk7QC4nn06z2EmRRinXRvww==
X-Received: by 2002:a05:6602:7517:b0:85b:35b1:53b4 with SMTP id ca18e2360f4ac-8644fa93533mr97241839f.12.1745451428150;
        Wed, 23 Apr 2025 16:37:08 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a3d50esm22133173.37.2025.04.23.16.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 16:37:07 -0700 (PDT)
Message-ID: <27c3a7f5-aad8-4f2a-a66e-ff5ae98f31eb@kernel.dk>
Date: Wed, 23 Apr 2025 17:37:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linux-MM <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] mm/userfaultfd: prevent busy looping for tasks with signals
 pending
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

userfaultfd may use interruptible sleeps to wait on userspace filling
a page fault, which works fine if the task can be reliably put to
sleeping waiting for that. However, if the task has a normal (ie
non-fatal) signal pending, then TASK_INTERRUPTIBLE sleep will simply
cause schedule() to be a no-op.

For a task that registers a page with userfaultfd and then proceeds
to do a write from it, if that task also has a signal pending then
it'll essentially busy loop from do_page_fault() -> handle_userfault()
until that fault has been filled. Normally it'd be expected that the
task would sleep until that happens. Here's a trace from an application
doing just that:

handle_userfault+0x4b8/0xa00 (P)
hugetlb_fault+0xe24/0x1060
handle_mm_fault+0x2bc/0x318
do_page_fault+0x1e8/0x6f0
do_translation_fault+0x9c/0xd0
do_mem_abort+0x44/0xa0
el1_abort+0x3c/0x68
el1h_64_sync_handler+0xd4/0x100
el1h_64_sync+0x6c/0x70
fault_in_readable+0x74/0x108 (P)
iomap_file_buffered_write+0x14c/0x438
blkdev_write_iter+0x1a8/0x340
vfs_write+0x20c/0x348
ksys_write+0x64/0x108
__arm64_sys_write+0x1c/0x38

where the task is looping with 100% CPU time in the above mentioned
fault path.

Since it's impossible to handle signals, or other conditions like
TIF_NOTIFY_SIGNAL that also prevents interruptible sleeping, from the
fault path, use TASK_UNINTERRUPTIBLE with a short timeout even for vmf
modes that would normally ask for INTERRUPTIBLE or KILLABLE sleep. Fatal
signals will still be handled by the caller, and the timeout is short
enough to hopefully not cause any issues. If this is the first invocation
of this fault, eg FAULT_FLAG_TRIED isn't set, then the normal sleep mode
is used.

Cc: stable@vger.kernel.org
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Reported-by: Zhiwei Jiang <qq282012236@gmail.com>
Link: https://lore.kernel.org/io-uring/20250422162913.1242057-1-qq282012236@gmail.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index d80f94346199..1016268c7b51 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -334,15 +334,29 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	return ret;
 }
 
-static inline unsigned int userfaultfd_get_blocking_state(unsigned int flags)
+struct userfault_wait {
+	unsigned int task_state;
+	bool timeout;
+};
+
+static struct userfault_wait userfaultfd_get_blocking_state(unsigned int flags)
 {
+	/*
+	 * If the fault has already been tried AND there's a signal pending
+	 * for this task, use TASK_UNINTERRUPTIBLE with a small timeout.
+	 * This prevents busy looping where schedule() otherwise does nothing
+	 * for TASK_INTERRUPTIBLE when the task has a signal pending.
+	 */
+	if ((flags & FAULT_FLAG_TRIED) && signal_pending(current))
+		return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, true };
+
 	if (flags & FAULT_FLAG_INTERRUPTIBLE)
-		return TASK_INTERRUPTIBLE;
+		return (struct userfault_wait) { TASK_INTERRUPTIBLE, false };
 
 	if (flags & FAULT_FLAG_KILLABLE)
-		return TASK_KILLABLE;
+		return (struct userfault_wait) { TASK_KILLABLE, false };
 
-	return TASK_UNINTERRUPTIBLE;
+	return (struct userfault_wait) { TASK_UNINTERRUPTIBLE, false };
 }
 
 /*
@@ -368,7 +382,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	struct userfaultfd_wait_queue uwq;
 	vm_fault_t ret = VM_FAULT_SIGBUS;
 	bool must_wait;
-	unsigned int blocking_state;
+	struct userfault_wait wait_mode;
 
 	/*
 	 * We don't do userfault handling for the final child pid update
@@ -466,7 +480,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	uwq.ctx = ctx;
 	uwq.waken = false;
 
-	blocking_state = userfaultfd_get_blocking_state(vmf->flags);
+	wait_mode = userfaultfd_get_blocking_state(vmf->flags);
 
         /*
          * Take the vma lock now, in order to safely call
@@ -488,7 +502,7 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 	 * following the spin_unlock to happen before the list_add in
 	 * __add_wait_queue.
 	 */
-	set_current_state(blocking_state);
+	set_current_state(wait_mode.task_state);
 	spin_unlock_irq(&ctx->fault_pending_wqh.lock);
 
 	if (!is_vm_hugetlb_page(vma))
@@ -501,7 +515,11 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (likely(must_wait && !READ_ONCE(ctx->released))) {
 		wake_up_poll(&ctx->fd_wqh, EPOLLIN);
-		schedule();
+		/* See comment in userfaultfd_get_blocking_state() */
+		if (!wait_mode.timeout)
+			schedule();
+		else
+			schedule_timeout(HZ / 10);
 	}
 
 	__set_current_state(TASK_RUNNING);

-- 
Jens Axboe


