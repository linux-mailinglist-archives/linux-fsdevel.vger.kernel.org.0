Return-Path: <linux-fsdevel+bounces-67580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDAAC43D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 13:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6272D3B0D45
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 12:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375042E7BCF;
	Sun,  9 Nov 2025 12:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4pf0aKg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10282E7658
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Nov 2025 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689791; cv=none; b=DwVw8qrZkORtbTAusxuYgixc0ilvF1VonYEtDrxYtyomvV+GzNORISuEiJp+1+y63Z4MCTwjx//CTOlDQsj0FEhydEt22RDBN7zntj1u5sBA/rVJbmZr/Geo705cZQ5DQj86C6Gno9YA0KdLJoWmfib6Fjkzm4OsSG/txzTjRAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689791; c=relaxed/simple;
	bh=qxv9oP1S4VQrVQ/WUkjRbwz93uUoCYdrmXkz6+1+qEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PM31s7vtkK0Qj8hnZgTNuNdoMetVmt+XGlioCKrX6KBkKmk6kF5SShkLRK2gx9Sqt97lNs03x9Jm9Wr//SOTbfx9rU5Kp5YqoiqzM0w3AqQ3bSYhnt8GFLd3YheTKpuRPYcM0hlRFWtvrGAAVqmemt2WTNdBR+auEi7TO1OT9wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4pf0aKg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso3686120a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Nov 2025 04:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762689785; x=1763294585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhv3s6l+/V0AVNQ6yZgHV88airWpT9eUaCudXwyxKRw=;
        b=O4pf0aKgdNZtPmz3A03L+8ya2nc1NnoP+3ocdwjilDmcAzPLBe7rXLv6094vJvdTN6
         9kS+85umdip1HVUEWoeFmPjOtfPGM9x6aIrvG5GpvJaGT3Ik24GN3MKnywlFXWQxKEU0
         j9iGKmCcmUNLvaOvaUr9JCoKgH+LqDYnVujNXqyRMTRVKjlFWieNave4CmNDUUGLmuru
         Ny7YR/jU4oX8n+TA/PijAmHQnziq905aIbTFtrvBAiQs+PoTNGlI8hxweOAQLue44ww2
         ctKjeeGamGOaqmF3bN9D4CKsFPpJTV3IO7vWstG5p1SJmmwZ8AU02nyTY1TLdF9oRYYY
         a76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689785; x=1763294585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhv3s6l+/V0AVNQ6yZgHV88airWpT9eUaCudXwyxKRw=;
        b=QUAQyFg++U44SGlw7AtP6l/g4rF4G+eFy2veQiAX5FrtGuKUpiQyzGoIhanAunN2Er
         D+WtbtbPLsIA6/eayGJ3RXN6ZPHD+L0LLlbJNsWkb+7ONE8lTTkuWEFkvN7HkiSBX9zf
         gTd/NLxttS1RqJ97wioDfHfwEVieD0z2B47JS6US60fS+crSdKBzoF6TxuxVMDoZ2YKK
         jvseVgURjWhNv+NzKKNMxZSPbBI3KuZ5mgB7Nc/iCDdhkFZfWIRdc8FzBxBwnVyiPCiz
         IdRKdnpDCB+hTDvdrgeJIIkspr0yooHxepXTYxtusZ6nV4NR0kmy8l2WoHGulFNGJgvZ
         cNXw==
X-Forwarded-Encrypted: i=1; AJvYcCXUUBLWomISwRwTQNbx74dvOYd1HAKgJze+5RBodZeyXfb4Q7xy+8qRXG/6P0tcZTbMnP9DjSjijzlbe64v@vger.kernel.org
X-Gm-Message-State: AOJu0YwiNbrfYxMavvG4O75idR1QfgDF5h8t6dE7/xWrq/ltn9rjAl4a
	lsJ5/hxLJI49V0lTa5bAAGiHL6YocW+RzIJpXKY4WCD7AtwesF5jb2I4
X-Gm-Gg: ASbGncutdlL82dzWXDWq41chxOqD8MyZYDEXQRT4Sghic46ZelTGGYhIQcAZqTcjNUx
	ZDG/UDA5Yrxf0sKPemv6VidP2T1YQDubQkif3zZOCJb8VR11vFN9xuV3E6ic+rRhrI5i+AH+HVV
	EUucZoIjtaWFIxGv1BCljl3Ty9k2u94hAM3Q05rohD+0iGYTW0ZFfkwZr1H0M4S80oFoOOGPKo6
	1jRvnExE2YHUGN/gHgTb9ySa6AbEBgCVL1A8hEUiIznkrV0pOTm34+ZcwndAndUk6eRyjne/A5o
	+XQ8WVxZJVUpxMp1R+IjTtuhC5eKk9KZSxR3e65wP5WGCCZNaGRzaTFcu0OSKa+4VGkIP7ZnBmj
	9odjvdVskNHlu7l2D0RemF+H8URDtWtu1bDycoXXgB/yCIiyrpuCRmpN+Z6j63XrOwIoxmMbzBG
	4tAA90x5OR1s12vSIhuV0+Jf/+ubAwT/MRYrMVG3k3GXew4BfX
X-Google-Smtp-Source: AGHT+IE4B3XToGQDvImXqeLOymkkS7RFjZtOpBbs/n5FSVyFAWBKofw6zy/heUB61w1ZfdFoc2KFsg==
X-Received: by 2002:a05:6402:13d0:b0:640:b7f1:1ce0 with SMTP id 4fb4d7f45d1cf-6415e6efb3dmr3652910a12.23.1762689784947;
        Sun, 09 Nov 2025 04:03:04 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f86e9d7sm8775732a12.36.2025.11.09.04.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 04:03:04 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [MEH PATCH] fs: move fd_install() slowpath into a dedicated routine and provide commentary
Date: Sun,  9 Nov 2025 13:02:59 +0100
Message-ID: <20251109120259.1283435-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On stock kernel gcc 14 emits avoidable register spillage:
	endbr64
	call   ffffffff81374630 <__fentry__>
	push   %r13
	push   %r12
	push   %rbx
	sub    $0x8,%rsp
	[snip]

Total fast path is 99 bytes.

Moving the slowpath out avoids it and shortens the fast path to 74
bytes.

Take this opportunity to elaborate on the resize_in_progress machinery.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

I don't feel particularly strongly about the patch, so if there is
resistance and I'm not going to argue for it.

Spotted on the profile while looking at open()

 fs/file.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 28743b742e3c..d73730203bb5 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -641,6 +641,35 @@ void put_unused_fd(unsigned int fd)
 
 EXPORT_SYMBOL(put_unused_fd);
 
+/*
+ * Install a file pointer in the fd array while it is being resized.
+ *
+ * We need to make sure our update to the array does not get lost as the resizing
+ * thread can be copying the content as we modify it.
+ *
+ * We have two ways to do it:
+ * - go off CPU waiting for resize_in_progress to clear
+ * - take the spin lock
+ *
+ * The latter is trivial to implement and saves us from having to might_sleep()
+ * for debugging purposes.
+ *
+ * This is moved out of line from fd_install() to convince gcc to optimize that
+ * routine better.
+ */
+static void noinline fd_install_slowpath(unsigned int fd, struct file *file)
+{
+	struct files_struct *files = current->files;
+	struct fdtable *fdt;
+
+	rcu_read_unlock_sched();
+	spin_lock(&files->file_lock);
+	fdt = files_fdtable(files);
+	VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
+	rcu_assign_pointer(fdt->fd[fd], file);
+	spin_unlock(&files->file_lock);
+}
+
 /**
  * fd_install - install a file pointer in the fd array
  * @fd: file descriptor to install the file in
@@ -658,14 +687,8 @@ void fd_install(unsigned int fd, struct file *file)
 		return;
 
 	rcu_read_lock_sched();
-
 	if (unlikely(files->resize_in_progress)) {
-		rcu_read_unlock_sched();
-		spin_lock(&files->file_lock);
-		fdt = files_fdtable(files);
-		VFS_BUG_ON(rcu_access_pointer(fdt->fd[fd]) != NULL);
-		rcu_assign_pointer(fdt->fd[fd], file);
-		spin_unlock(&files->file_lock);
+		fd_install_slowpath(fd, file);
 		return;
 	}
 	/* coupled with smp_wmb() in expand_fdtable() */
-- 
2.48.1


