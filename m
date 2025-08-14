Return-Path: <linux-fsdevel+bounces-57866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 500EBB26176
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 11:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D73188BFE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 09:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022AD2ED14F;
	Thu, 14 Aug 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS8APo4E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6355287241;
	Thu, 14 Aug 2025 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755164740; cv=none; b=eMquOtPxV8wKKD+k6QcH7ukCuTlNY7qlla4ASwKDpCeBaAf7hv0L/0tdIPLa4Grm7VpCWoNolfp9ixEZY3Id1G5/ZyUu9iIe/Xo9Hiww4XtWcrgHfNrXIDKCnOvO2bw0k5pTYWNIo4J0BsASP3BsYnlzn2aZv/6OWTpvyatiAFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755164740; c=relaxed/simple;
	bh=KM92jO8VeknSMnZUwnTA8K+PnMbF85QSmFWuuxCNr4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ee5tjSAGdHlyakSD4xfOz2YcMmM97vc6ZrDwkRr/jetDAaCrUrJSN7Z/dFlpfupXmEcmJ+DcH3YCtCmzQ+Ni6sp2Eq0uHAo4ShV3klhatdzrNDwvaPesERVV9Pw+sVw8uv6fN11kQUnliVkp6xB7LLUmtXznCBaexSVUjy/+ow0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS8APo4E; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso581101b3a.1;
        Thu, 14 Aug 2025 02:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755164735; x=1755769535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMN0x5Zo7hh9TITRfrQy5jjYiGyYIfO4mlcflHw2ibQ=;
        b=IS8APo4Eww3RJyZ9ffbehmmd09h3g0j3fTngDO4cSdrOMY6Oh68WSN7TqPHFIAZ5rX
         mGqQfVyDo+8qd/MVoEyO32rGwcVa7Lhg5DpoNWqBEB3bLETMlKf0xU1JcFrJ2Mjntwz5
         1WfAPSTZgB6Gb8qep2f6hTw60u1K2gDHpIxnVu9L0QTdQnQU3jrRNJh2Kfaqdl66UNMh
         3xpeCi+ziPB5mMsk91mp5wzFq0gL2tMU9aO5yhsWTQBqZjLGaBwcCwFRro8C1+j+KAmK
         Cc+D35jrRlDU6IZG09tW+SxI58dnGsL3e7443PBY61Ss3UhqyzOsCuOpGA4KEx9FxKzf
         ZQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755164735; x=1755769535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oMN0x5Zo7hh9TITRfrQy5jjYiGyYIfO4mlcflHw2ibQ=;
        b=iMnCykZ8DEVxPkVQrfBPbbjkoXXEmR7wIXMTdNjSy8IY9ywYsbzeZtOArgxo/5yXd/
         CEPv+LAnKTApdbh348D7eIqn+qT0UK3Ao1sUnpE4higvS1hEC3hqXzE+ZUY8L2oRe8Ei
         2OPgi4BiRMTgDZiFlEOwh4k+B78tQkCa7ipp9lhG+JqgQ3xJ8nB6n1wlilSIA6NgI3js
         Wl1w4vaq079xFqthYoG0bVqBWXf9bPRPLCfj1jdFBMPpkRTbbrKlhwQ6AfRHxmLqClDG
         MzhyiP8q2NO2v8xl2AdFfRj5hljBLk3rjLXat8JCBLdDDLt2TeM/5djuiQfovt/I6BBo
         SVeA==
X-Forwarded-Encrypted: i=1; AJvYcCXGRLOseZXhaJLTRyHXRzeAOQEzyo7s/McWJLsKdXUB79oKk8+6SHUKywNr9hR10NyeTu9heK3JhQWH9VM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4LFG1vdHyxvfOw+pRQ9RxFuduu96amguT4cGbXnXdPRF37SFj
	SE8Y4DmCNFDPF4mdmqjGdVtb1qgy7XnSWMbQSgeycb8OmqwthQoEg5pC
X-Gm-Gg: ASbGncvZMxSR0OnoIWakDFVwcaNTvHG9OAnR+a8ZJ8GUCFCj0RbWJGfPLZKQFGEAbtv
	gEh+NKlEacR8/hQhXIvaYq0SBKD8aIDf8sSGaFFpZm7pAB3lzD3YH9Mr8jTX3R51javDdTUCERq
	vDBqYIWtr3vsm3x1DVz20k4ot/ou/qiEYranWWnlpPUBK7OQ7QObNX1fWrO2q91Kw4KofhxN+gr
	OwKN7xZ1gKCCKddm9x3sfXvCRNB8eUY78aewqnZXF2x79OHWAYf3dvUJkGYm92Vy2az1oX06k31
	6K7nYkkem/c259adKEWEb7tPDReCJCjKdFDscuYYixTuM81ABQi+nYVLF6mw0ua58uc8jsjlYbE
	t8Sx/EEl7MTMj5/TvZy+gVsWrDGUSpK+036crDyPv372bZDA0HYM9z8j3oCViwx35VfEox6MoVG
	JyuH06dmM55AhZVvQn6o52+Ls0SXXG
X-Google-Smtp-Source: AGHT+IG3C7V389BrCRAN1Uymn48CA1exKEYl6jou2mxxAV4PixPK6nvq4Y+wAWCq9YZtg3Qey1vBEg==
X-Received: by 2002:a05:6a00:cc2:b0:748:f6a0:7731 with SMTP id d2e1a72fcca58-76e3200dbdamr3122117b3a.23.1755164735051;
        Thu, 14 Aug 2025 02:45:35 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (1-175-133-46.dynamic-ip.hinet.net. [1.175.133.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c61dd2ce7sm13106519b3a.41.2025.08.14.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:45:34 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH v2 1/1] pidfs: Fix memory leak in pidfd_info()
Date: Thu, 14 Aug 2025 17:44:53 +0800
Message-Id: <20250814094453.15232-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After running the program 'ioctl_pidfd03' of Linux Test Project (LTP) or
the program 'pidfd_info_test' in 'tools/testing/selftests/pidfd' of the
kernel source, kmemleak reports the following memory leaks:

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xff110020e5988000 (size 8216):
    comm "ioctl_pidfd03", pid 10853, jiffies 4294800031
    hex dump (first 32 bytes):
      02 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
      00 00 00 00 af 01 00 00 80 00 00 00 00 00 00 00  ................
    backtrace (crc 69483047):
      kmem_cache_alloc_node_noprof+0x2fb/0x410
      copy_process+0x178/0x1740
      kernel_clone+0x99/0x3b0
      __do_sys_clone3+0xbe/0x100
      do_syscall_64+0x7b/0x2c0
      entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...
  unreferenced object 0xff11002097b70000 (size 8216):
  comm "pidfd_info_test", pid 11840, jiffies 4294889165
  hex dump (first 32 bytes):
    06 40 00 00 00 00 00 00 10 00 00 00 00 00 00 00  .@..............
    00 00 00 00 b5 00 00 00 80 00 00 00 00 00 00 00  ................
  backtrace (crc a6286bb7):
    kmem_cache_alloc_node_noprof+0x2fb/0x410
    copy_process+0x178/0x1740
    kernel_clone+0x99/0x3b0
    __do_sys_clone3+0xbe/0x100
    do_syscall_64+0x7b/0x2c0
    entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...

The leak occurs because pidfd_info() obtains a task_struct via
get_pid_task() but never calls put_task_struct() to drop the reference,
leaving task->usage unbalanced.

Fix the issue by adding '__free(put_task) = NULL' to the local variable
'task', ensuring that put_task_struct() is automatically invoked when
the variable goes out of scope.

Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
Changes in v2: Assign NULL to the local variable 'task'

---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..108e7527f837 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -296,12 +296,12 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
+	struct task_struct *task __free(put_task) = NULL;
 	struct pid *pid = pidfd_pid(file);
 	size_t usize = _IOC_SIZE(cmd);
 	struct pidfd_info kinfo = {};
 	struct pidfs_exit_info *exit_info;
 	struct user_namespace *user_ns;
-	struct task_struct *task;
 	struct pidfs_attr *attr;
 	const struct cred *c;
 	__u64 mask;
-- 
2.34.1


