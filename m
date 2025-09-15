Return-Path: <linux-fsdevel+bounces-61435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BD9B5826D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD15A1A210D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768F6288C2B;
	Mon, 15 Sep 2025 16:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zV/k/JN+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44404286898
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 16:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954755; cv=none; b=syQGVCUAJZx/pCKm1CR/T+hHDETPpEXYuVQpY95xbsrjuLP5Uda2XgNCGuNTmhCvpi73two9D3ezfCVQwWGb800G64KxEfcnBVdNwz0+CP71ertWhYnVBTtTWQICiOCUWAUQqaKXd3+/YSBj0iWe1KHuNZxqrgAEkpTdccGPRz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954755; c=relaxed/simple;
	bh=vPqrFhzsoS56yk34gogqjEXAKiAKcL51MnvFt/0vTxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FEDg9hZvT5Psjsjtme/9jS7Sy5W1gFrLT8kO+/F0cN93Yf+L8dFh432qsZkE8ltXISiyA40V7xcS7xSOoUVY6Cigua4zvqxBzHsC7CPtbpBEwyI0wKS90Ymacut4SlLHHWZ7/w32RRYgQrk052oKeNvzYqbZ0YMPO7nm7lijd4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zV/k/JN+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24456ebed7bso58555705ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757954752; x=1758559552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=zV/k/JN+MEs5mTleaLd/vdGTldfkvMs9MFHiB7jKUhkcINpmK79TDVqdPin9BNv2o9
         VmNHWv406Dj7sIufglyt8C8zDiLy6lRB1+z8X869/5iTJjhJzWOfVuWbS6XBK4sgews8
         9u8DrFyTcvo6UUdgtRbWBQ26Mv6zghSrdvgX/pP/eGJnD6rObeFKl22e3foOx3Y+9LMI
         k2kwvqw+ODGe0A4rAoQ80qoiSJFar4+n+1vByHVOeso+429EXL//YmjNqu79XREIRQ9+
         bgAq4lqrkPTv8udsm19RkT16QSMiF+UZ7wUDgdnBMrOD+7rjvVUBridRM4Ef9TB4Idya
         t6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954752; x=1758559552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dh1IS3JVHOf86RTcG+zb9g2w/Ys+63vuY/qru+PreQ=;
        b=aYtgqwNEoQNRsoKl1vklFyfNKLPj8P2J7S1UZ5IOgk1EiPAtKZogVeL3/T4UU2YICe
         Jn/CzIrYCyQ5l0IOemrNTxfJW450Qv29Aa+CJfN6iDoMi4xaeLZc+DCYjuTS5FKRnAHX
         LnzCOsgU58AdngYKRL2YlRGpRpH+CuIrYdUsghYhD8CnDRyrXvHlw3KmlJ5Lk0s1B/Rm
         yDOnv9Yds84nw3KdGLU/p9r0J6arjaLTHTCX7NyV+/RcHOl6hWrae4xeH/mse55n6583
         Yds4AREN1yBZWgwVoFoHp74N4rJ26qmpU65AQ3f4LVQvQg1Cbr/xw+5AfaM5Fy7ySLLP
         RWPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0Lb5vatpCDN4L3tbZLi4Pn3fX6Ti4/xk2IEXOyE94eYeEVaehmf2CMqgITNzRctkQQ/pPpfSIEofR4ilh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7xjgMeVCZqlhKJuvfs7aPYyZfWLgAAZCbSsUeNZPG/cu+8pc8
	6uFj46wmTgPGTtsurXLKGZ/m+OU24QfOWbzM9eEj4fdLPEuH6vH4D4OO0i9SQrj8bQnRLImry4n
	8noigtS8ZOhq5JUYAccdykPQvSQ==
X-Google-Smtp-Source: AGHT+IETeFsnzxOgNLMCiDHUaYpnu2vRB/Fb66R7+b7xgDA1s+PPQqB4+bTMKY9LvQ479LuxEWFmKDI75ZPJsp8Xlg==
X-Received: from plkb5.prod.google.com ([2002:a17:903:fa5:b0:264:7b3c:4fe4])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac2:b0:24b:1585:6350 with SMTP id d9443c01a7336-25d2ac3c545mr185756655ad.11.1757954752355;
 Mon, 15 Sep 2025 09:45:52 -0700 (PDT)
Date: Mon, 15 Sep 2025 09:36:32 -0700
In-Reply-To: <20250915163838.631445-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250915163838.631445-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250915163838.631445-2-kaleshsingh@google.com>
Subject: [PATCH v2 1/7] mm: fix off-by-one error in VMA count limit checks
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de
Cc: kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>, stable@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The VMA count limit check in do_mmap() and do_brk_flags() uses a
strict inequality (>), which allows a process's VMA count to exceed
the configured sysctl_max_map_count limit by one.

A process with mm->map_count == sysctl_max_map_count will incorrectly
pass this check and then exceed the limit upon allocation of a new VMA
when its map_count is incremented.

Other VMA allocation paths, such as split_vma(), already use the
correct, inclusive (>=) comparison.

Fix this bug by changing the comparison to be inclusive in do_mmap()
and do_brk_flags(), bringing them in line with the correct behavior
of other allocation paths.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: <stable@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Chnages in v2:
 - Fix mmap check, per Pedro

 mm/mmap.c | 2 +-
 mm/vma.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7306253cc3b5..e5370e7fcd8f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 		return -EOVERFLOW;
 
 	/* Too many mappings? */
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	/*
diff --git a/mm/vma.c b/mm/vma.c
index 3b12c7579831..033a388bc4b1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2772,7 +2772,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
 
-	if (mm->map_count > sysctl_max_map_count)
+	if (mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
 
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
-- 
2.51.0.384.g4c02a37b29-goog


