Return-Path: <linux-fsdevel+bounces-9942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3BC84654A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA7F1B21616
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 01:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DD86AA6;
	Fri,  2 Feb 2024 01:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGhBmI0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBA26123
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836377; cv=none; b=i4uXISwHg5xXXl4+f7+LywcCIws4S+5JeT8TXrnU9uo8XJfY7wmNZIQa6JY0wJfE7VsVXa4mGXM/J1zjY9dXAmPo1nNWi0AboRlA6cwu36y+nJULmlgaKUNjvpNCi5lFd3rvLU5GHutjcHgE4tkm5i0Dk7qTkdT8tfUmmWKTMlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836377; c=relaxed/simple;
	bh=p/rKfqSNYUjMIZEFvvBdSXGCTq8YJYgTxVTzw7HPMFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c8MY+NRG7Sidarg4oS7Ph0+q/ZWJm21wHBg7LhLkq/GJSoe6m8SqWtjQqutCzeAali5XPz3pQPrbSsPIrHGgiP16VT6ROkgcEUd5YUTWUnTfUTod/BVBPMTfTqUS2LczURyvG6U8zbAkuJpbAIftdpO7b+FD1pbD/UPvHfnNdAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DGhBmI0/; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6daf694b439so1244330b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Feb 2024 17:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706836375; x=1707441175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivmfb83FwDkP3x6pfBlSqzRjLeN2tS1ZFLqnXqOH+KQ=;
        b=DGhBmI0/JFSWTisKcg4Rt5zPyfNNHJe2TG5NYwEEPhyoLLhAli25bC9snvkRx65evL
         rOjdwB9Ec3DuwrDZI8ZDL4wKqrswMu77inWh4Ee7gfw7e1QrbE+ygSDPbOuZCN6Pev6V
         H4UVwrC/DZH42lHr9S0Ry5uZNsE6qA/H8IjG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706836375; x=1707441175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ivmfb83FwDkP3x6pfBlSqzRjLeN2tS1ZFLqnXqOH+KQ=;
        b=Q36TY02Z+X3VAgaq10Krdei2yk5byiobXC/snOBfgiD6JajbfAstUpmIiZkbU//L1K
         5mdoCsAVHc7toyFgPFq4RSpBOup9r8B4xB6Krg06DQws9thXW2nCRT3h1aqkSxPL47Bl
         W6qElAFE/nNSeh2nYJp5uyaZeduo/Y6pYWB9PUDABcxNNgwjjaLoL4kZrF1ecRpeYw6t
         shomnFQb+R3YqL8b0SH23JfqBMFcbYy+lS8ytI9FO1+Wi3Jlq+MdT73AnriwsazvuRAm
         Ea8hrrzdjb2rm6fKd1Ozi8XdylLRxpotX9fR6j+7fHfysxPR71Cvajqqx+RigPL/kskO
         zyYw==
X-Gm-Message-State: AOJu0YybrX9gMaqhpjMIxQf8HT0xWJoMVXKMvXQ+mUNYW1VD6B9108tH
	M+QjlIkFlGncMf89bjv0ab7VD//HBybDu+ShVC9dVAC7fnD8wBNlSaTbatJzrAnjPwVGWpgffWl
	YJIGc
X-Google-Smtp-Source: AGHT+IFDLmhjSiFVUREChNi1Tz0JkUPOtT5xeLTdp3wsTuUWxF0qy+TElN2h3bus8LcjLTvkFWgsLQ==
X-Received: by 2002:a05:6a20:1e4a:b0:19e:34e4:818e with SMTP id cy10-20020a056a201e4a00b0019e34e4818emr5927684pzb.8.1706836374922;
        Thu, 01 Feb 2024 17:12:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX9Lpj6ULXgFZCsNzmvUHNd4fR20Uvm9EzQKaw5VFE+b9uGRRAZZuOix2g7mfo4/n8QpkXkGuL1XMuZdly9WCJXCWwjPKeEFq/8SurjdII7TyEl8ua0KJ7y0AQqocJE06RcJsDLN0DF1pMlTPAAKalV3CU0zxysbTjG9k9PtzkoTmv0VvzG/j5AdyuHpZVgOvcxVNC7hXvpt4Ngug7f+fnFmYBgfM6E3Yygw5+cFkqpGtmCdBbPSERktQE/WgcdP8m57ZzzpHHi48/PT9J2t0I=
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:4039:2bf1:e8b6:32e6])
        by smtp.gmail.com with ESMTPSA id kt5-20020a170903088500b001d70af5be17sm423057plb.229.2024.02.01.17.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 17:12:54 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] regset: use vmalloc() for regset_get_alloc()
Date: Thu,  1 Feb 2024 17:12:03 -0800
Message-ID: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While browsing through ChromeOS crash reports, I found one with an
allocation failure that looked like this:

  chrome: page allocation failure: order:7,
          mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
	  nodemask=(null),cpuset=urgent,mems_allowed=0
  CPU: 7 PID: 3295 Comm: chrome Not tainted
          5.15.133-20574-g8044615ac35c #1 (HASH:1162 1)
  Hardware name: Google Lazor (rev3 - 8) with KB Backlight (DT)
  Call trace:
  dump_backtrace+0x0/0x1ec
  show_stack+0x20/0x2c
  dump_stack_lvl+0x60/0x78
  dump_stack+0x18/0x38
  warn_alloc+0x104/0x174
  __alloc_pages+0x5f0/0x6e4
  kmalloc_order+0x44/0x98
  kmalloc_order_trace+0x34/0x124
  __kmalloc+0x228/0x36c
  __regset_get+0x68/0xcc
  regset_get_alloc+0x1c/0x28
  elf_core_dump+0x3d8/0xd8c
  do_coredump+0xeb8/0x1378
  get_signal+0x14c/0x804
  ...

An order 7 allocation is (1 << 7) contiguous pages, or 512K. It's not
a surprise that this allocation failed on a system that's been running
for a while.

In this case we're just generating a core dump and there's no reason
we need contiguous memory. Change the allocation to vmalloc(). We'll
change the free in binfmt_elf to kvfree() which works regardless of
how the memory was allocated.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I don't know this code at all, but I _think_ I've identified the
places where the memory is freed correctly. Please double-check that I
didn't miss anything obvious, though!

 fs/binfmt_elf.c | 2 +-
 kernel/regset.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 5397b552fbeb..ac178ad38823 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1928,7 +1928,7 @@ static void free_note_info(struct elf_note_info *info)
 		threads = t->next;
 		WARN_ON(t->notes[0].data && t->notes[0].data != &t->prstatus);
 		for (i = 1; i < info->thread_notes; ++i)
-			kfree(t->notes[i].data);
+			kvfree(t->notes[i].data);
 		kfree(t);
 	}
 	kfree(info->psinfo.data);
diff --git a/kernel/regset.c b/kernel/regset.c
index 586823786f39..ed8d8cf3a22c 100644
--- a/kernel/regset.c
+++ b/kernel/regset.c
@@ -2,6 +2,7 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/regset.h>
+#include <linux/vmalloc.h>
 
 static int __regset_get(struct task_struct *target,
 			const struct user_regset *regset,
@@ -16,14 +17,14 @@ static int __regset_get(struct task_struct *target,
 	if (size > regset->n * regset->size)
 		size = regset->n * regset->size;
 	if (!p) {
-		to_free = p = kzalloc(size, GFP_KERNEL);
+		to_free = p = vmalloc(size);
 		if (!p)
 			return -ENOMEM;
 	}
 	res = regset->regset_get(target, regset,
 			   (struct membuf){.p = p, .left = size});
 	if (res < 0) {
-		kfree(to_free);
+		vfree(to_free);
 		return res;
 	}
 	*data = p;
@@ -71,6 +72,6 @@ int copy_regset_to_user(struct task_struct *target,
 	ret = regset_get_alloc(target, regset, size, &buf);
 	if (ret > 0)
 		ret = copy_to_user(data, buf, ret) ? -EFAULT : 0;
-	kfree(buf);
+	vfree(buf);
 	return ret;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


