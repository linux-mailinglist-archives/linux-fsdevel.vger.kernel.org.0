Return-Path: <linux-fsdevel+bounces-45722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D6A7B7D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB801786E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F018CC10;
	Fri,  4 Apr 2025 06:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Km/dTclp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1B18BC3D;
	Fri,  4 Apr 2025 06:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748527; cv=none; b=AEBBoK+/yGmQmX1+Z3GSgno0+nvbY85yKcnTQwQcczNlIGPJijxwbL6V3uDupdyv3vliR76EFdiYWCj0JPkl5NxwfgOZQZnE4XW5DPD91vtV4Ya1p14tccFjSq4CImz3B5mILEFKzhiyyqTMz6oI8+DRNBxJnsEVz5V4oxcejsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748527; c=relaxed/simple;
	bh=uf4rYD9t2gn5zV19MtRg0HceEF4u822rbbG6f5CZEoM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nhw9IsH//af5ru7+/nIU+Ub/Zo8Thj7zOGUTKdnwaZaRDYiuiSfr3O+VVU7GXVCX6wYoADwk2GctrAXj6+aYHedwOyi+16wD5W8UX9GcGH171wmRETLN1ZB+ezDlY/cfoB4Pbl0jo9JRN+k2I4F4yzj7ZKjKOTFPab5+p5zYkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Km/dTclp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-224191d92e4so16346385ad.3;
        Thu, 03 Apr 2025 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743748525; x=1744353325; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L6lJnoTkwzdjXsC0+52u0ropQ0W1YSxIsAMlZ25CPTk=;
        b=Km/dTclpeejlfW4FI0B/oTuTQndM4RiMswu7RetEv9TqH/CvesYdQzflKai6dYxVAT
         5LDGCR+ktHKDkmMc1xug0ophdvp5XiiA3s9FE0CgguM+zVjSIBh4ZSZo8VvEh8xne7l+
         JHF0jsw3SBWEHbsQlMHCndU/pG1+pZhExcgoWAKtsjHyw+xjOVk05XEJhNmqnv3tUINo
         SYZcCvxTU5l119Zq4ZtCSVLl0hWvs3MxWcw7PCEf6qNZ263hDXXyPAEvaoi0ImfmQEhw
         OdcsR+qsQXRJmGejpoe3OU5yN76/QyQEA8yg+TlcscLn+wP0/MY98pBTqkyqLjuwZYjs
         5Sog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743748525; x=1744353325;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6lJnoTkwzdjXsC0+52u0ropQ0W1YSxIsAMlZ25CPTk=;
        b=QfulELwYfxzy9GTprNvKLFHCkYvwBqy01SkVeONqK8Gz2cb3WC0j6/Ph1UXd/jNq6t
         5QxsEAyageOVs10CvyJTnwv00vVrU69b6xMITWdu4uqN7XWCxjBcRU2dIGD+8VZpunZA
         2iGBCjdV0odQfimF9KYb9AlTTYBhgf+KgAythovGGr0pIUnTK+rKVnRoc2iYnv7eQeic
         4AlJwkag0dC2KBYwL4I4CBfeHHkwowqfEuTyI4DN1qarximeF+EmQLG8UyIpPqf+B5ZC
         CFBqnu6JreaYR2N073G42tptiB/HaGZ6ivCpt2Ej2zg52wrCLhWVacxgwYHhWcQAHl5w
         230g==
X-Forwarded-Encrypted: i=1; AJvYcCX9vosNNNsBz7M0BdKnq8gGdU8v4inBIL3k1bbPGy7V4jFfo8P97qs9TVyDT+eDJnaXQxhjhEe6Te8k5qvo@vger.kernel.org, AJvYcCXei4IVD5w+hldKyfO+o34Q2o6015eX7z8LCSrNWCpx9kmwqDQ4FjUPpS/72qNVHdnK/BYdd4eYURJbrtEi@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6i54twEKvIaZFF6rUW5upvIvK1VEZRXYsKij3q7IYCMhDDo1P
	bn+S60Oy9MJh9yKlQn164ZGmXr8DgpkglgiMP7JG8YC7Y9taDm+j
X-Gm-Gg: ASbGncsN32DIZ3QPA91AQnLIKXpxQCgTlBVYln/7aZLg3Cu3d6DxCD+FHLY63L6hyto
	3JMmKx2YdqcqS+Ru1nUM3euK4eqLukV0lC5n4ANRcSA0OUVPb8ZUjPQMlmelELOwl7xzqf8a5Sm
	pGQdadI/e6+XH1tBt0m2wJ38M1B2S8w2wZCC6WVrfPF+/lvZMgscVx3FCaWmAZzw0PSy+2uzEYB
	zapH9kQmmxA3hGtP0kxcmqdz80367QT+MzpQwSBaPyUJ9JImeANuELahGaIkJ0pEB7qck9Y/D+d
	GHw8QaSk73qFBzZ983GNVa/8LhSMnipH9jIZxTEGBvr6rxqehuuNZdAbVG54tu7lA3uRD4Ai6g=
	=
X-Google-Smtp-Source: AGHT+IEx1KAgPqM1x7d8Wskej+UazaVhLKu8QqS4ldLsoA80gD3oBB5ji46YWPEQp1hH+Z3aRdYE9A==
X-Received: by 2002:a17:903:2ec5:b0:216:6283:5a8c with SMTP id d9443c01a7336-22a8a0a3599mr29852915ad.39.1743748525461;
        Thu, 03 Apr 2025 23:35:25 -0700 (PDT)
Received: from localhost.localdomain ([221.214.202.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e1b4sm25105335ad.181.2025.04.03.23.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 23:35:25 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: superman.xpt@gmail.com
Cc: adrian.ratiu@collabora.com,
	akpm@linux-foundation.org,
	brauner@kernel.org,
	felix.moessbauer@siemens.com,
	jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mjguzik@gmail.com,
	syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
	syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com,
	tglx@linutronix.de,
	viro@zeniv.linux.org.uk,
	xu.xin16@zte.com.cn
Subject: [PATCH V5] proc: Fix the issue of proc_mem_open returning NULL
Date: Thu,  3 Apr 2025 23:33:57 -0700
Message-Id: <20250404063357.78891-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250331170647.36285-1-superman.xpt@gmail.com>
References: <20250331170647.36285-1-superman.xpt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

The function proc_mem_open() can return an errno, NULL, or mm_struct*.
If it fails to acquire mm, it returns NULL, but the caller does not
check for the case when the return value is NULL.

The following conditions lead to failure in acquiring mm:

  - The task is a kernel thread (PF_KTHREAD)
  - The task is exiting (PF_EXITING)

Changes:

  - Add documentation comments for the return value of proc_mem_open().
  - Add checks in the caller to return -ESRCH when proc_mem_open()
    returns NULL.

Reported-by: syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/000000000000f52642060d4e3750@google.com
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
V4 -> V5: Completed the changelog
V3 -> V4: Revised the comments
V2 -> V3: Added comments to explain the proc_mem_open() return value
V1 -> V2: Added the missing NULL check, dropped the proc_mem_open() modification

 fs/proc/base.c       | 12 +++++++++---
 fs/proc/task_mmu.c   | 12 ++++++------
 fs/proc/task_nommu.c |  4 ++--
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index b0d4e1908b22..85a3f5e253d4 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -827,7 +827,13 @@ static const struct file_operations proc_single_file_operations = {
 	.release	= single_release,
 };
 
-
+/*
+ * proc_mem_open() can return errno, NULL or mm_struct*.
+ *
+ *   - Returns NULL if the task has no mm (PF_KTHREAD or PF_EXITING)
+ *   - Returns mm_struct* on success
+ *   - Returns error code on failure
+ */
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
@@ -854,8 +860,8 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 {
 	struct mm_struct *mm = proc_mem_open(inode, mode);
 
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 
 	file->private_data = mm;
 	return 0;
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 994cde10e3f4..b9e3bd006346 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -212,8 +212,8 @@ static int proc_maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
@@ -1325,8 +1325,8 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		ret = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		ret = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		single_release(inode, file);
 		goto out_free;
@@ -2069,8 +2069,8 @@ static int pagemap_open(struct inode *inode, struct file *file)
 	struct mm_struct *mm;
 
 	mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(mm))
-		return PTR_ERR(mm);
+	if (IS_ERR_OR_NULL(mm))
+		return mm ? PTR_ERR(mm) : -ESRCH;
 	file->private_data = mm;
 	return 0;
 }
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index bce674533000..59bfd61d653a 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -260,8 +260,8 @@ static int maps_open(struct inode *inode, struct file *file,
 
 	priv->inode = inode;
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
-	if (IS_ERR(priv->mm)) {
-		int err = PTR_ERR(priv->mm);
+	if (IS_ERR_OR_NULL(priv->mm)) {
+		int err = priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
 
 		seq_release_private(inode, file);
 		return err;
-- 
2.17.1


