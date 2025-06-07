Return-Path: <linux-fsdevel+bounces-50888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B09DAD0AF4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 04:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B540D188EC92
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 02:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D63D2586EC;
	Sat,  7 Jun 2025 02:14:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4275C8F54
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 02:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749262443; cv=none; b=iXhvbpot6xopJzmA0PtdPd7+dKfatQOaFrrMK6flNnReKXoLa4MGg5k1mTdEjh+syppkyz+77ULGieKMsdfkSf+0mMk6CubaGSrRsy7imYBKn7o+9EY4EkbaSJvTmYx61En+nlr9z3O4z386uu6L+wnsgd/dXDbAfsCD9FSnAnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749262443; c=relaxed/simple;
	bh=/3lnas8VaJOgkZKT5o/RiwzlC7GzWHvMC3593+OaJqM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZiFSCVIojAxifwsIdo1NyydjgvkVqvlgA5AQQpfyZE/N14GF4c/6fdp1YehM8lJFO1RqEMwK6kH10/xYtcBJO46sOB00Wg0zSN1RcNdBzGp7dpgFKXD2FhQ+rl9Jr6E6+cjoWBgELY3zhmmRkhU/KAl9L2L29cKgKaivj+W3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4bDhWW4gvZzYkxh5;
	Sat,  7 Jun 2025 10:11:35 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Jun
 2025 10:13:55 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 7 Jun
 2025 10:13:54 +0800
From: wangzijie <wangzijie1@honor.com>
To: <viro@zeniv.linux.org.uk>, <akpm@linux-foundation.org>,
	<rick.p.edgecombe@intel.com>, <ast@kernel.org>, <adobriyan@gmail.com>,
	<kirill.shutemov@linux.intel.com>, <linux-fsdevel@vger.kernel.org>
CC: wangzijie <wangzijie1@honor.com>
Subject: [PATCH] proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al.
Date: Sat, 7 Jun 2025 10:13:53 +0800
Message-ID: <20250607021353.1127963-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a011.hihonor.com
 (10.68.31.243)

Check pde->proc_ops->proc_lseek directly may cause UAF in rmmod scenario. It's a gap
in proc_reg_open() after commit 654b33ada4ab("proc: fix UAF in proc_get_inode()").
Followed by AI Viro's suggestion, fix it in same manner.

Signed-off-by: wangzijie <wangzijie1@honor.com>
---
 fs/proc/generic.c       | 2 ++
 fs/proc/inode.c         | 2 +-
 fs/proc/internal.h      | 5 +++++
 include/linux/proc_fs.h | 1 +
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index a3e22803c..e0e50914a 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -569,6 +569,8 @@ static void pde_set_flags(struct proc_dir_entry *pde)
 	if (pde->proc_ops->proc_compat_ioctl)
 		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
 #endif
+	if (pde->proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
 }
 
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
diff --git a/fs/proc/inode.c b/fs/proc/inode.c
index a3eb3b740..73074b9c7 100644
--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -473,7 +473,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	typeof_member(struct proc_ops, proc_open) open;
 	struct pde_opener *pdeo;
 
-	if (!pde->proc_ops->proc_lseek)
+	if (!pde_has_proc_lseek(pde))
 		file->f_mode &= ~FMODE_LSEEK;
 
 	if (pde_is_permanent(pde)) {
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 96122e91c..3d48ffe72 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -99,6 +99,11 @@ static inline bool pde_has_proc_compat_ioctl(const struct proc_dir_entry *pde)
 #endif
 }
 
+static inline bool pde_has_proc_lseek(const struct proc_dir_entry *pde)
+{
+	return pde->flags & PROC_ENTRY_proc_lseek;
+}
+
 extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
diff --git a/include/linux/proc_fs.h b/include/linux/proc_fs.h
index ea62201c7..703d0c76c 100644
--- a/include/linux/proc_fs.h
+++ b/include/linux/proc_fs.h
@@ -27,6 +27,7 @@ enum {
 
 	PROC_ENTRY_proc_read_iter	= 1U << 1,
 	PROC_ENTRY_proc_compat_ioctl	= 1U << 2,
+	PROC_ENTRY_proc_lseek		= 1U << 3,
 };
 
 struct proc_ops {
-- 
2.25.1


