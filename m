Return-Path: <linux-fsdevel+bounces-21642-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843659073FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 15:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED5428BAEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 13:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03663144D3A;
	Thu, 13 Jun 2024 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rCIvFHUB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5806143895;
	Thu, 13 Jun 2024 13:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286010; cv=none; b=UmsiR6HU+u+IQolx6smPXS+E2fya7i/7TTMyLzogy3dqGVWjrXwnYXjo87A87mUCUfR5VOJJ/qANudHCVZGALz/eOnEmUS3SrnR+A73XnjREjI4SEyldLcSgKcosGOEseNTdwsp9pdzv0CfO9Y2zqHXGy03l7uM16g1mvp0Fg1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286010; c=relaxed/simple;
	bh=mM/nGXvzfhzKRjtNF5lAJbBStRl1RPZ5BZMncy1sL9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnZ8gL+7nnAPUxQaw7Occ6gW9p7z/ewM/Lqe76FgN65d53EEq42gWCpakkEHybNFE7SLhbtOKqbpqqHABr9In6KTt5kRUUGJvrT8OtZlr/9tugp4kt9pqyVeQXZ2J1/qmXeS+oZCSp6MktREwBD2BufeQwfjeE3nc8e/gQcFFaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rCIvFHUB; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718286006;
	bh=mM/nGXvzfhzKRjtNF5lAJbBStRl1RPZ5BZMncy1sL9k=;
	h=From:To:Cc:Subject:Date:From;
	b=rCIvFHUBsO5NZzLnUDiHYsWRCOzH0+8w/ag1XyrR9PX/x4XX/uvnkxNzv2d8nVntG
	 y1Ld3hgr80TjTw6qLpnRICkElS4/mOugMovzdvHzFL1bp4NQzRJxIvGDS4rmlLYtru
	 EsJsllDL3M8DLJFdg1qda0xd6Cp657KA/gmNDhHEcf+AnPsalZMPDYh1MypzvlmHZ9
	 8fokoOZdOKqkSda4rutLNAGUU7ulLq4Yv75KS1ON1rLT/jverE/Cw7HoYARRgjAZbn
	 M/EWDvTqj1INdyeABnul94j2PB3HrSfxNHQArDomMU1SgliiFiwS+2dl5zbkEEzEwo
	 VxA9WdqQL8bnA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: aratiu)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA0C037820CD;
	Thu, 13 Jun 2024 13:40:05 +0000 (UTC)
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
Subject: [PATCH v6 1/2] proc: pass file instead of inode to proc_mem_open
Date: Thu, 13 Jun 2024 16:39:36 +0300
Message-ID: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.44.2
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
No changes in v6
---
 fs/proc/base.c       | 6 +++---
 fs/proc/internal.h   | 2 +-
 fs/proc/task_mmu.c   | 6 +++---
 fs/proc/task_nommu.c | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 72a1acd03675..4c607089f66e 100644
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
index f8d35f993fe5..fe3b2182b0aa 100644
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
index bce674533000..a8ab182a4ed1 100644
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
2.44.2


