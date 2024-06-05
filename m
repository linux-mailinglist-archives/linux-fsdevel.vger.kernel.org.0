Return-Path: <linux-fsdevel+bounces-21067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C2C8FD31E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E7C2869C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BD8188CDF;
	Wed,  5 Jun 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3AYZ15AF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72FA61FD6;
	Wed,  5 Jun 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606225; cv=none; b=iOVufJIipnENx8fhekh+7lvdqCCIJYl0Q6jBVLKPoMjPySlTGRJnFgDVDTuz28Qa2fXFyCZkD1MVhEqZJvnBv7QOGScT+pmKZBlZPeA26vsz2Df9dF5ioLiQaTiXz6KkMJOLgUR6TB59s67biaUKbQPZXzs308JQ/zV1cqe3ugY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606225; c=relaxed/simple;
	bh=r8vTxJSt9oFOh/9CtnB9cm8GeC1a3icEgU2GNHOZxuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bzrskWBSlq9cUs2jyoNl7yOph8iRbK56KBYGd9cg9Kwj3ji5IPqQ2DX/DjkpgKd9a+YG6h9PzbUjJLFNg1GaJobCl9hTj3t/XLEksvucBl9cXb2K/B/zazdRlBGhvK9D0WUwCcuYXcczI/etsCTLkwPki0ih5sixjF9n+NSsOPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3AYZ15AF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717606216;
	bh=r8vTxJSt9oFOh/9CtnB9cm8GeC1a3icEgU2GNHOZxuE=;
	h=From:To:Cc:Subject:Date:From;
	b=3AYZ15AFB85fkCsf/9fpAXJN66Mq0C+da+koQ6zPIetiXS8c4MWok4fENZHwUNC9l
	 E0NLQczAdp5JYnJhNIaJSLq7vP/yAEWP+8CFB6PM+h4maeENMsii+JsLb+5JfY39dy
	 sH3eKqy7t7fPD0JiWvnNKAqiXos9TO3pJaaeQhPmbkiyxuhCvwywefCN7VaKTRoPpm
	 ZYrTq/f0xLgiPNH2beKaPduln9a7lg7qefVebioxq4DWOjbXVklDetYX8iL+QxzXGu
	 UPSaXL0VZh1+IR/E+Ne+iS7KDixap6P0N+ExLnQ52ssBqyaFLMWg8ZSBvx68k72kbg
	 DoYbOFM5WYqow==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 785A3378219B;
	Wed,  5 Jun 2024 16:50:15 +0000 (UTC)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel@collabora.com,
	gbiv@google.com,
	ryanbeltran@google.com,
	inglorion@google.com,
	ajordanr@google.com,
	jorgelo@chromium.org,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Jann Horn <jannh@google.com>,
	Kees Cook <keescook@chromium.org>,
	Christian Brauner <brauner@kernel.org>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH v5 1/2] proc: pass file instead of inode to proc_mem_open
Date: Wed,  5 Jun 2024 19:49:30 +0300
Message-ID: <20240605164931.3753-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file struct is required in proc_mem_open() so its
f_mode can be checked when deciding whether to allow or
deny /proc/*/mem open requests via the new read/write
and foll_force restriction mechanism.

Thus instead of directly passing the inode to the fun,
we pass the file and get the inode inside it.

Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
Reviewed-by: Kees Cook <kees@kernel.org>
---
Changes in v5:
* Fixed task_nommu.c 0day build error
* Added Reviewed-by tag by Kees C. (thanks!)
* Rebased on next-20240605
---
 fs/proc/base.c       | 6 +++---
 fs/proc/internal.h   | 2 +-
 fs/proc/task_mmu.c   | 6 +++---
 fs/proc/task_nommu.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675c..4c607089f66ed 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -794,9 +794,9 @@ static const struct file_operations proc_single_file_operations = {
 };
 
 
-struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
+struct mm_struct *proc_mem_open(struct file  *file, unsigned int mode)
 {
-	struct task_struct *task = get_proc_task(inode);
+	struct task_struct *task = get_proc_task(file->f_inode);
 	struct mm_struct *mm = ERR_PTR(-ESRCH);
 
 	if (task) {
@@ -816,7 +816,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 
 static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
-	struct mm_struct *mm = proc_mem_open(inode, mode);
+	struct mm_struct *mm = proc_mem_open(file, mode);
 
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index a71ac5379584a..d38b2eea40d12 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -295,7 +295,7 @@ struct proc_maps_private {
 #endif
 } __randomize_layout;
 
-struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
+struct mm_struct *proc_mem_open(struct file *file, unsigned int mode);
 
 extern const struct file_operations proc_pid_maps_operations;
 extern const struct file_operations proc_pid_numa_maps_operations;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f8d35f993fe50..fe3b2182b0aae 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -210,7 +210,7 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(priv->mm)) {
 		int err = PTR_ERR(priv->mm);
 
@@ -1030,7 +1030,7 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(priv->mm)) {
 		ret = PTR_ERR(priv->mm);
 
@@ -1754,7 +1754,7 @@ static int pagemap_open(struct inode *inode, struct file *file)
 {
 	struct mm_struct *mm;
 
-	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
 	file->private_data = mm;
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bce6745330003..a8ab182a4ed14 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -259,7 +259,7 @@ static int maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(priv->mm)) {
 		int err = PTR_ERR(priv->mm);
 
-- 
2.30.2


