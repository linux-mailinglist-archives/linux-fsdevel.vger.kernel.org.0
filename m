Return-Path: <linux-fsdevel+bounces-57458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47114B21D08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DE018902C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 05:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7102C21E3;
	Tue, 12 Aug 2025 05:39:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0D2C21CA
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977177; cv=none; b=YEzfvLvjl/BoJEFybzS6mMZYIP309xEzLY3yUA814xL8hksqvv4bpEw6shbjOAfDtQ4Fq92ogpBbVJKS1ZZU6MDyX0/8vkh3QsLPUuXEvV9j6eKe2+gMKQ3qpkAGlP/dqYsFPh27C7JhJNbiiomFpzmNeB1CngGl7CnpaRJTIwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977177; c=relaxed/simple;
	bh=/wJPXLKXi/hjlkjVzhdSQNzsofLYxwRHhB2lewtlAsw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=MBt7ivAqF2YZxndOQQg2nBDzavLxx2VdFm9+bR5hw++kQrXtIQEiWmeeFExDHpCPXwYgL+h3NnGORng2sXzUK8KPH6TPBRhjAuUKZd99e2TU2USE2VWZIv7V4R4QTdOe7rqW8Pi/lEbsNuNMrtxmFG8UjeJqTRXSl4CvlBIlTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso569613a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 22:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754977174; x=1755581974;
        h=content-transfer-encoding:subject:cc:to:organization:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+nYesaofewjTOWrYiEbyiHj4letDKw4MCbW6PRIKeA=;
        b=iyP5V5+alVhWGXPI9U4Ar50k+EWhHPQDzWFqbN2OBJ2m0uaY6dgenGVmzqQALln7cB
         jAWlMya5MjDJtsd2GcilB1q3cVmHeZc9DMwJIE6xXVA3YLXgiGgZ/Etqqzgygs3clpsg
         djSRZTcftExjjp8XGo4zosZt2LHAeU7LjxTt0EW3YG4mjIpCue+TWZfOnZDVhfsVKwVD
         mPFMBYT3WCykyGVAJP/S6ecHLuMSDAdSrUZTflAyNYHsyD4FlzRZ+7ErvUZdQrB8TQcc
         ihHw18dEDsKlmuFB16UNEfZ/R/afX82mtFk9EgFYOJ7VUjt/zdrGomsEtZldXIPCZySG
         /dqA==
X-Forwarded-Encrypted: i=1; AJvYcCUs5Kg7hGZD+fBkt1VdK6qeXVUg5Bw04yzkGGsEjzpqznMNu7nN1+g88PHDA4FRSEkeukGkOlUP/+lENUZb@vger.kernel.org
X-Gm-Message-State: AOJu0YwR12dYwHvFweiP11CBNN5YxT/BIbdX3/GmmTDtegPm9yn2xbr1
	lWEn6lPyGPC5LyMOqQ4Bsch12JJPYBGRpti2j2xYuqJqLmNhWHbpRTbreTg5T9Xb
X-Gm-Gg: ASbGncstAb+Fv1G6hyMdMP5NXmglu4HiiSCHs7bT7xRP1bQE5PjrTwZLrw5wYhhmkRZ
	KSnjDv4WNdaYJC3KkdQhFv0FgbMAjKIBgliAKkOf2FcCVZ9gLfINdfmhK1pxu6s2sHEDtwUpzLU
	Ska40SCm0CW4DPmuu8XHrb1Xpu55/0XlO/ZuNQEHpCgLtk3jdDK+aC7jFT7dT9H65dS1ThDybQd
	ajc8fID5MkJUQ2JL5xsorxp27/RSE8aLSNTBxI826ZcMBpwqCtiurKERGvT7SjEQZeH9jvKgGqh
	1nLSxnG2jAS9fPm+fLATqQAjOFv8bD3lygcei6TwTrHJaHgEJmESXxeLgGL3k17ko1FHX8nwCgH
	ag60udTziY7qPRNK2ZbnuG9mmpkf3WlL/
X-Google-Smtp-Source: AGHT+IHWl9tLgoI5Lw90OM/vTjnQgJaEThUvIsnVfUSsqMko19oF+Bh6EyLcsgm84GWQWAA/nOHT1w==
X-Received: by 2002:a05:6a00:2283:b0:72a:a7a4:99ca with SMTP id d2e1a72fcca58-76e16abcba6mr204829b3a.2.1754977173611;
        Mon, 11 Aug 2025 22:39:33 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c6f0c862fsm6028283b3a.115.2025.08.11.22.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 22:39:33 -0700 (PDT)
Message-ID: <7a68c944-0199-468e-a0f2-ae2a9f21225b@kzalloc.com>
Date: Tue, 12 Aug 2025 14:39:29 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, gfs2@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzkaller@googlegroups.com, Austin Kim <austindh.kim@gmail.com>
Subject: [BUG] gfs2: sleeping lock in gfs2_quota_init() with preempt disabled
 on PREEMPT_RT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

While testing with PREEMPT_RT enabled, I encountered a potential issue in
gfs2_quota_init() where preemption is disabled via bit_spin_lock(), but a
subsequent call eventually reaches a sleepable lock.

Below is the simplified call flow:
[PREEMPT_RT]

gfs2_quota_init()
   |
   v
  spin_lock_bucket()
   |-- bit_spin_lock()
   |     |
   |     +--> preempt_disable()   [Preemption disabled]
   v
  gfs2_qd_search_bucket()
       |
       v
     lockref_get_not_dead()
          |
          v
        spin_lock(&lockref->lock)   [Sleepable: sleeping in preemption disabled]

[NON-PREEMPT_RT]

gfs2_quota_init()
   |
   v
  spin_lock_bucket()
   |-- bit_spin_lock()
   |     |
   |     +--> preempt_disable()   [Preemption disabled]
   v
  gfs2_qd_search_bucket()
       |
       v
     lockref_get_not_dead()
          |
          v
        spin_lock(&lockref->lock)   [Non-sleeping spinlock]

BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15311, name: syz.6.947
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 1
Preemption disabled at:
[<ffff800081fa916c>] bit_spin_lock include/linux/bit_spinlock.h:25 [inline]
[<ffff800081fa916c>] hlist_bl_lock include/linux/list_bl.h:148 [inline]
[<ffff800081fa916c>] spin_lock_bucket+0x60/0x190 fs/gfs2/quota.c:98
CPU: 2 UID: 0 PID: 15311 Comm: syz.6.947 Not tainted 6.16.0-rc1-rt1-dirty #12 PREEMPT_RT 
Hardware name: QEMU KVM Virtual Machine, BIOS 2025.02-8 05/13/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:466 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0x148/0x1d8 lib/dump_stack.c:120
 dump_stack+0x1c/0x3c lib/dump_stack.c:129
 __might_resched+0x2e4/0x52c kernel/sched/core.c:8800
 __rt_spin_lock kernel/locking/spinlock_rt.c:48 [inline]
 rt_spin_lock+0xa8/0x1bc kernel/locking/spinlock_rt.c:57
 spin_lock include/linux/spinlock_rt.h:44 [inline]
 lockref_get_not_dead+0x30/0xd0 lib/lockref.c:155
 gfs2_qd_search_bucket fs/gfs2/quota.c:269 [inline]
 gfs2_quota_init+0x778/0x1114 fs/gfs2/quota.c:1460
 gfs2_make_fs_rw+0x144/0x26c fs/gfs2/super.c:149
 gfs2_fill_super+0x1448/0x1a38 fs/gfs2/ops_fstype.c:1278
 get_tree_bdev_flags+0x360/0x414 fs/super.c:1679
 get_tree_bdev+0x2c/0x3c fs/super.c:1702
 gfs2_get_tree+0x54/0x1b4 fs/gfs2/ops_fstype.c:1335
 vfs_get_tree+0x90/0x28c fs/super.c:1802
 do_new_mount+0x228/0x814 fs/namespace.c:3885
 path_mount+0x574/0xd64 fs/namespace.c:4209
 do_mount fs/namespace.c:4222 [inline]
 __do_sys_mount fs/namespace.c:4433 [inline]
 __se_sys_mount fs/namespace.c:4410 [inline]
 __arm64_sys_mount+0x3e8/0x468 fs/namespace.c:4410
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x40/0x13c arch/arm64/kernel/entry-common.c:767
 el0t_64_sync_handler+0x78/0x108 arch/arm64/kernel/entry-common.c:786
 el0t_64_sync+0x1ac/0x1b0 arch/arm64/kernel/entry.S:600


On non-RT kernels this is fine because spin_lock() is non-sleeping, but
on PREEMPT_RT many spinlocks map to sleepable locks, which causes sleeping
while preemption disabled.

At the moment, two possible approaches come to mind:

1. Avoid using the bit-spinlock in this path entirely
 - Rework the bucket protection so we do not call into code that may sleep
   while preemption is disabled.
 - no sleeping while preemption-disabled.
 - May require reworking bucket protection/race re-check logic.

2. Replace the inner lock with a non-sleeping primitive
 - (e.g., use a raw_spinlock_t for lockref->lock) so it can be taken while
   preemption is disabled.
 - Since lockref does not currently support raw_spinlock_t, this would require
   additional rework of the lockref structure.
 - Minimal structural change; avoids sleeping in the problematic context.


I can help test patches for this on both PREEMPT_RT and NON-RT kernels.


Thanks,
Yunseong Kim

