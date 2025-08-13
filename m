Return-Path: <linux-fsdevel+bounces-57698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77796B24A89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34C60173CB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A528A2E92C9;
	Wed, 13 Aug 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK/oiZ5O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69D72C0F71;
	Wed, 13 Aug 2025 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091367; cv=none; b=lQwNW7K3/46l0q+PwtAl96XHcA9L1dXSJjPdqmb4WwHiqZwV8yj0MZgT8b79AAgDVOAEouedQG0lleTS3jxZdRvYqfeboTHP4PRHtTryGIz5QcYG3A59hIJgg6qrpkUpdkELrHju6qskcUMYRSY2CPUxwRIX77Rh0JzUJrz5h0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091367; c=relaxed/simple;
	bh=cC9EbcQ7W8rrnOM6u+oTWWyWJWmyEl4B4Chr82W939s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iMEQYjztn8xlJKQ0oRseA7BbLWLOHeDPuri3rtwj/EX9cTJEXNdm6ZqK/s6d4NsKDBfllKQKFWxo7Bs2mHSt7en2zXV1S2SV+QZwqdwU5nq1MuvxrLgZDZJmyHUHAkxcX3wxYdDi2p1NAVz9JGxoImLTe6NA0NiHkmLFRiwLI/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK/oiZ5O; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so723656b3a.0;
        Wed, 13 Aug 2025 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091365; x=1755696165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LRW+1ITE4fmoTKhCIyuNHAOAPPzP4XgHdlZOizY4uIg=;
        b=NK/oiZ5O1Nqm+9Mqjh0iewYBER3CWn+FDNP//xedCwIfixh3x/9o3MgUS2C8hJezIf
         uXrkUZOSeW+MAuLMssRVvSpM1EZjuSkydqpbKi7+gUCW/KoDGAS6ixKmOeCg1j4B9zdN
         GeHk/nGlsWmshUG6APQ949Mf/F2STeyECs2UFsss/MRfAIfwXbxbO+HGP04ShnnYv62w
         ay4K45290f47eLMlz8yQZ4ToIHOqagPrTG1G+Uyu2z56z2S/P3aAJ99DTpIWWWsiykEv
         K1yPObhFXErcZhln0N7rXXsBapCYZP6Dq6K3mztkdP9lIBoSTDZBUZ9zpywOj1fgtS/b
         qKvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091365; x=1755696165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRW+1ITE4fmoTKhCIyuNHAOAPPzP4XgHdlZOizY4uIg=;
        b=Crws3t1u9ANXzW51OA1NKbT9/dTkgoRVMxzSpxpULsq2cXDSiTe7SQoHja+J7AkfcC
         uM8a5MEl0OpC9QYvS81trrLmeys/8/sRRLJkXhJXOuQL/48Pwg0mTDmV+qMr9+k/4B28
         ou+92PNgT37YyEVOC8zoa6zFIXm1YHNdzzKX+VnzAudsRbEdHxl7nsJIbzbiBuyKNIr9
         BZ5PpgJIUUAv4So2H8BHkhGG9iv8OEzkrlXz+UVjmCcMpUkfBy1bT95CPZwXxv0cQ99o
         GUxFxaJipw+PdsJJGVc9BmHq6i/AZKxauFQmLWMoN1JbkhZMlQd9wtNwEPFWg/F5e2KB
         bJxg==
X-Forwarded-Encrypted: i=1; AJvYcCUHPLaNqUSUymEMEe70w/ljFZEcwZUNWBJtZJpR4y0mXQHQLSCob0v3pi3DTGrTFb2lgC7We6F9heHHRgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFCHNEkX/OCLWZzdBgyHlOvmMGodqhAFGWWQW+2R3XCWhZF36p
	N5Hu8ZS25xliz3mZ+xDTzBtkrLht1eGhUlekp7kz/w3tFxPsJvozbiBr
X-Gm-Gg: ASbGncu2FATrvhkAiHy/DV4iVAj7HTNss26BmC6xbqp0TJRidnfgsigkMG8LAREnvnP
	l2+P8zyg2hI4LplkWPdZxyD+uSgPHLCzeKBt1IJNkVLlxFqEnlpuny9jHS7oHxzuK+LlRdtPLsq
	cu0Cu7LuvM7ENXJVwa7Z/t5VXbrM8yoVSApWkcu8f+ek0IgpX+LqGknl4QFQ84e5xMLI5cYAuuT
	Dv9AIEKEcLlGJ1RN+qZ1sAc/IAyZTG7cDsWWBT5+UB3IvbmlVnkRvUnrpwTg4BAoNTIYvGfeyFF
	rhIa4XzZaXYfbEyl57XwnhwllVzPOVBJWcjX8sKfihZz4zr3YL+wmD6E9uoGHfN89Ix8bkPkIc8
	ZcxBl2AfqWhi00svUgnViwKwOPZ5Bqv2OG1bRMTvxU5bQm+SsLsabWV/KfJfIDuK8o7ok/Lv+aY
	Dv4PEpL7hL7dGExBXGLnLPi/NyCIei
X-Google-Smtp-Source: AGHT+IGIrCTv1z0sW+jzBxZbAQHYFpfZ5Ano1CMYhstZsRLI+Reh4EnPb4zBaFiWYjoLURw4TansVQ==
X-Received: by 2002:a17:903:18e:b0:240:3cab:a57a with SMTP id d9443c01a7336-2430ea7187bmr41238205ad.12.1755091364371;
        Wed, 13 Aug 2025 06:22:44 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (1-175-133-46.dynamic-ip.hinet.net. [1.175.133.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899b43dsm325749645ad.136.2025.08.13.06.22.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:22:43 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] pidfs: Fix memory leak in pidfd_info()
Date: Wed, 13 Aug 2025 21:22:14 +0800
Message-Id: <20250813132214.4426-1-adrianhuang0701@gmail.com>
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

Fix the issue by adding __free(put_task) to the local variable 'task',
ensuring that put_task_struct() is automatically invoked when the
variable goes out of scope.

Fixes: 7477d7dce48a ("pidfs: allow to retrieve exit information")
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index edc35522d75c..857eb27c3d94 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -296,12 +296,12 @@ static __u32 pidfs_coredump_mask(unsigned long mm_flags)
 static long pidfd_info(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct pidfd_info __user *uinfo = (struct pidfd_info __user *)arg;
+	struct task_struct *task __free(put_task);
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


