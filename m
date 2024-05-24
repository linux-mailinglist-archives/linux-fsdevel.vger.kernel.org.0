Return-Path: <linux-fsdevel+bounces-20130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6304C8CEA47
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 21:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1755B1F214E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 19:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5238358ABC;
	Fri, 24 May 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pf1+u5er"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB72433BB;
	Fri, 24 May 2024 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716578987; cv=none; b=AaLHfi7imBQousaAwq1jNnqwwsHMRUqrZF/34nXIQJ0wqAv0yPQMX0TGd7FeWb8shYn7rhf8nzQUop+yphg7dSx/m7lR1EYToLR02xFnPqNe4da9iZUPbswKhqp2TxkmAGfBEzme9VfS3AryRUzt4gW/laLBP6ECPnPKi+D7Fig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716578987; c=relaxed/simple;
	bh=WmPIFGX+ZJkkhj6YLNT+xJYHijtzNwQllcZAiZDdrUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KhskuXuiOwsHIyHsFrEsMLCYfMCk9MpJ2rX+KSChIpNLiTChHoKJFHZjqGQdXQhD/vypkyRQbdtqMPTf9STGqqPr7/r/joc4/orxpDfCQnbaoxkkes4wWe3eXafhXsHlRh8WnyM4TGDG1hr/iG5vaPsyKaD72OnDfDAdkEdKlyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pf1+u5er; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716578984;
	bh=WmPIFGX+ZJkkhj6YLNT+xJYHijtzNwQllcZAiZDdrUk=;
	h=From:To:Cc:Subject:Date:From;
	b=Pf1+u5er/a1za+nTnktjqBqhN7FOcJ9SJHlj+pB2euGyHU69RJdU8D+CmjSEJFAx6
	 nRmnuEjDbYIzDGRRH9xbsx484DrZT4vdjIOR/za6q2Ki7V3OmMbE8+Vqalb/r6gtvM
	 Ilh7hBuopUJ9WuXDYK3hD83SIEbxywF3lCovycGuNr18XQhS4Se7v4UoO9kKB9taaK
	 CVUqIlQfxCXuuEUPRcquFpzlEW5ihHYaonWVfBWYFc9HEQSbL3ar9wQ45yOTqCSBev
	 8hXBmgOIukH9XC2uLDi+wWKXfKo6WfZ47hBihcdMiywKv5NO1oiIvIemb02dbEyr/s
	 uE2DatGXxk+/Q==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5AC023782163;
	Fri, 24 May 2024 19:29:43 +0000 (UTC)
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
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH v4 1/2] proc: pass file instead of inode to proc_mem_open
Date: Fri, 24 May 2024 22:28:57 +0300
Message-ID: <20240524192858.3206-1-adrian.ratiu@collabora.com>
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
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
* New in v4
---
 fs/proc/base.c     | 6 +++---
 fs/proc/internal.h | 2 +-
 fs/proc/task_mmu.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 18550c071d71..6faf1b3a4117 100644
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
index a71ac5379584..d38b2eea40d1 100644
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
index e5a5f015ff03..dc9abbf662be 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -210,7 +210,7 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 		return -ENOMEM;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(priv->mm)) {
 		int err = PTR_ERR(priv->mm);
 
@@ -1025,7 +1025,7 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 		goto out_free;
 
 	priv->inode = inode;
-	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(priv->mm)) {
 		ret = PTR_ERR(priv->mm);
 
@@ -1749,7 +1749,7 @@ static int pagemap_open(struct inode *inode, struct file *file)
 {
 	struct mm_struct *mm;
 
-	mm = proc_mem_open(inode, PTRACE_MODE_READ);
+	mm = proc_mem_open(file, PTRACE_MODE_READ);
 	if (IS_ERR(mm))
 		return PTR_ERR(mm);
 	file->private_data = mm;
-- 
2.44.1


