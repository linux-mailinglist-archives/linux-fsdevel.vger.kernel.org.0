Return-Path: <linux-fsdevel+bounces-70080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 983B1C901A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 21:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CB674E5160
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B77310764;
	Thu, 27 Nov 2025 20:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="svG/114H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4677330274B
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764274583; cv=none; b=d2h0bGw52lsFF1JeLd1s4/9qUdgHmKgJfgfz7CxpzraxdxSY/A3ampjuKeSU4Y0fnzbOJQjxj6ol9m5TLhRWIxo/9agrop6G6gSGZ0iH9VnXf49EU6SmIPeybfe+fOseliX0OYKwUAtO/3vN+sxoVPhDl+GkVf0mfCByD3P7Ii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764274583; c=relaxed/simple;
	bh=RuStPMzzMAcBsN0dVzMXva8X7y+MX0+S9tP6GR5UnlI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kuoGvZgDviDdj+6ZErLh2n7q125t7cQWAsuJHcQdpc9bLDh9nWk/JhYDItGxQupcu0hSsXFmZ4uMGReSEgWOd8WhHHRIzGARNUTH7OaSyWuh8oOK09Y5qCIjSlazYnaZqIRz1oCuWpqUCdxFubBqq5GPGvl4XFkLcTZMTHrSZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=svG/114H; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29848363458so20654995ad.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 12:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764274581; x=1764879381; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PzA2hWCLFb6HsHvCRAMBT0nuurbeyN6o+QjR7DzipWU=;
        b=svG/114HAf4OOTFCA9XGgi2CbhOk3DB2IkPlPCJHWU26WjxV3DzoAGmP+PSX2j1p+C
         FvXmRfTIa2h4V8JytoUyFm0qYYA7yjajlIuwi/d5Dsgiw3jWH/aNi833h+m44A0pRKIg
         +VYkoGFfBMun8X3iYvud+yt2bH3E6C25bmQczrBlrUy7Mp7sDqy4LPJUz5SdMKmrbTul
         Ps0S7KbWq+UqgaP1v8WWA12jcgVUrBFROLVl8o4G2Az3ud8uwYJHsC71+V8R9GeCH16l
         U3qOtglSszI00NBPF55XrTFi8h8000oCz8XYiGtocQux/tVCD611STsW21bmLWMIt+NV
         WvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764274581; x=1764879381;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzA2hWCLFb6HsHvCRAMBT0nuurbeyN6o+QjR7DzipWU=;
        b=qMuiHNoX2XCTUGrPbKrpLIZS3w+214Yx7h8X87R593x9FjIfe1OMSZMW3X8SI3FqnR
         bDhefQzhQfLficxTp5I47VeLX77evO8zzdGjcKF5yiqsYqfbkL0TOq6Hdk4/qJYFwlXQ
         lvpSPHgQLv9p/1ev2qnQ9Vybph+F9RtlJH1ll/CvTbGEo9ZB74MU3c/GUI2B4kbyZwNz
         da4CY2DqHnh27QiOfwe4SRFqtDgaNBM1bU4xy7qeXZqNO3uh4zn9E63ZIgdatkci1631
         11VNVCPYFxFgIIU2U6OnVxDpMy30lEDOvNMSz/sOzt71sHcIiWeigUn+FMqHa1Yry2hc
         CTZg==
X-Forwarded-Encrypted: i=1; AJvYcCXrsrswmf+i2B8PIMLTa/HjiCg5zDitGWABmOS3Zkw4qd1HgGW+V7Xd2LKcwvGULVr/c/nryHxm5optEpxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzZuhYP5FURybP5P8tZ5IlDWeIkIddFoPG/fUcAKDisfPpYTx9b
	656E51CADrqiEo+yh8JP3vwW8n6ivEAqzlR5A600fOcWmRbtL/SK9TnfvNO8/brZn7DkHEOGKjt
	udKtSLA==
X-Google-Smtp-Source: AGHT+IG3yNDu4mOkcC2Fdkmw/uYC6OA9aWi1AaaEkz3b+cSzWrXrsLGKYhCBeqEjxc+suTqKYHDDZEHWo5E=
X-Received: from pgi128.prod.google.com ([2002:a63:886:0:b0:bd9:a349:94b0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2343:b0:294:ec7d:969c
 with SMTP id d9443c01a7336-29b6bf5d616mr283107625ad.49.1764274581541; Thu, 27
 Nov 2025 12:16:21 -0800 (PST)
Date: Thu, 27 Nov 2025 20:16:15 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251127201618.2115275-1-kuniyu@google.com>
Subject: [PATCH] fanotify: Don't call fsnotify_destroy_group() when
 fsnotify_alloc_group() fails.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the splat in __do_sys_fanotify_init(). [0]

The cited commit introduced the fsnotify_group class.

The constructor is fsnotify_alloc_group() and could fail,
so the error is handled this way:

	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
				     FSNOTIFY_GROUP_USER);
	if (IS_ERR(group))
		return PTR_ERR(group);

Even we return from the path, the destructor is triggered,
and the condition does not take IS_ERR() into account.

	if (_T) fsnotify_destroy_group(_T),

Thus, fsnotify_destroy_group() could be called for ERR_PTR().

Let's fix the condition to !IS_ERR_OR_NULL(_T).

[0]:
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 UID: 0 PID: 6016 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
Code: 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 c1 ef 03 48 b8 00 00 00 00 00 fc ff df <0f> b6 04 07 3c 08 0f 92 c0 e9 40 01 33 09 cc 66 66 66 66 66 66 2e
RSP: 0018:ffffc90003147c10 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: ffffffff8b5a8b4e RCX: 707d8ea8101f1b00
RDX: 0000000000000000 RSI: ffffffff8b5a8b4e RDI: 0000000000000003
RBP: ffffffff824e37fd R08: 0000000000000001 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1c0c6f3 R12: 0000000000000000
R13: 000000000000001c R14: 000000000000001c R15: 0000000000000001
FS:  000055556de07500(0000) GS:ffff888125f8b000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09c332b5a0 CR3: 00000000750b0000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __kasan_check_byte+0x12/0x40 mm/kasan/common.c:572
 kasan_check_byte include/linux/kasan.h:401 [inline]
 lock_acquire+0x84/0x340 kernel/locking/lockdep.c:5842
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 fsnotify_group_stop_queueing fs/notify/group.c:39 [inline]
 fsnotify_destroy_group+0x8d/0x320 fs/notify/group.c:58
 class_fsnotify_group_destructor fs/notify/fanotify/fanotify_user.c:1600 [inline]
 __do_sys_fanotify_init fs/notify/fanotify/fanotify_user.c:1759 [inline]
 __se_sys_fanotify_init+0x991/0xbc0 fs/notify/fanotify/fanotify_user.c:1607
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f09c338f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd8b6be3e8 EFLAGS: 00000246 ORIG_RAX: 000000000000012c
RAX: ffffffffffffffda RBX: 00007f09c35e5fa0 RCX: 00007f09c338f749
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000f00
RBP: 00007ffd8b6be440 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f09c35e5fa0 R14: 00007f09c35e5fa0 R15: 0000000000000002
 </TASK>
Modules linked in:

Fixes: 3a6b564a6beb ("fanotify: convert fanotify_init() to FD_PREPARE()")
Reported-by: syzbot+321168dfa622eda99689@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6928b121.a70a0220.d98e3.0110.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 fs/notify/fanotify/fanotify_user.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index be0a96ad4316..d0b9b984002f 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1598,10 +1598,10 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
 }
 
 DEFINE_CLASS(fsnotify_group,
-	      struct fsnotify_group *,
-	      if (_T) fsnotify_destroy_group(_T),
-	      fsnotify_alloc_group(ops, flags),
-	      const struct fsnotify_ops *ops, int flags)
+	     struct fsnotify_group *,
+	     if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
+	     fsnotify_alloc_group(ops, flags),
+	     const struct fsnotify_ops *ops, int flags)
 
 /* fanotify syscalls */
 SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
-- 
2.52.0.158.g65b55ccf14-goog


