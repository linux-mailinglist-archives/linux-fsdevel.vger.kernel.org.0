Return-Path: <linux-fsdevel+bounces-58599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F6CB2F5C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 12:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EE6AA5424
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD703093BF;
	Thu, 21 Aug 2025 10:58:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000182ED17C;
	Thu, 21 Aug 2025 10:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773897; cv=none; b=VJsNZFVr4ddyDHMMMpUAnns+FSfbGQqy0UoozePHg/9Cd0dlihNytestWgBroKnAMs3N9+AfoDBUtlNvWfVvRkJCgcQBKVQY6/BiQ1U7mrsXDYCHLQWCZ809aIIhJ8NU3VO04Pzdj6Gd8ZoonVbFTgHrCx579vOadvfNgeFKv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773897; c=relaxed/simple;
	bh=l3jMKIk6lYIIzI4SccsDJUmeup9tuX38D/XM4qedxQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F86P/nI1SrQC59EanqajbO1vpxMeyFC70j1AIS/uDkfWep58mYI0SqHfMb3BAQ09vmIrQgZBricmsF9H5KmJaE8IGaO94fBEPUMRevkrTtryPQc5Sr3A+yVWFzi6nKTLLtEUm0uA0CqMN0yuhTmNTorsFuL2iCi+Ct/Q6DUW0+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4c70fC2v03zYl7h7;
	Thu, 21 Aug 2025 18:57:55 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 18:58:08 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 21 Aug
 2025 18:58:07 +0800
From: wangzijie <wangzijie1@honor.com>
To: <akpm@linux-foundation.org>, <brauner@kernel.org>,
	<viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>,
	<rick.p.edgecombe@intel.com>, <ast@kernel.org>, <k.shutemov@gmail.com>,
	<jirislaby@kernel.org>, <linux-fsdevel@vger.kernel.org>
CC: <polynomial-c@gmx.de>, <gregkh@linuxfoundation.org>,
	<stable@vger.kernel.org>, <regressions@lists.linux.dev>, wangzijie
	<wangzijie1@honor.com>
Subject: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Date: Thu, 21 Aug 2025 18:58:06 +0800
Message-ID: <20250821105806.1453833-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: w002.hihonor.com (10.68.28.120) To a011.hihonor.com
 (10.68.31.243)

To avoid potential UAF issues during module removal races, we use pde_set_flags()
to save proc_ops flags in PDE itself before proc_register(), and then use
pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.

However, the pde_set_flags() call was missing when creating net related proc files.
This omission caused incorrect behavior which FMODE_LSEEK was being cleared
inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].

Fix this by ensuring pde_set_flags() is called when register proc entry, and add
NULL check for proc_ops in pde_set_flags().

[1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/

Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
Cc: stable@vger.kernel.org
Reported-by: Lars Wendler <polynomial-c@gmx.de>
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
v3:
- followed by Christian's suggestion to stash pde->proc_ops in a local const variable
v2:
- followed by Jiri's suggestion to refractor code and reformat commit message
---
 fs/proc/generic.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/fs/proc/generic.c b/fs/proc/generic.c
index 76e800e38..bd0c099cf 100644
--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -367,6 +367,25 @@ static const struct inode_operations proc_dir_inode_operations = {
 	.setattr	= proc_notify_change,
 };
 
+static void pde_set_flags(struct proc_dir_entry *pde)
+{
+	const struct proc_ops *proc_ops = pde->proc_ops;
+
+	if (!proc_ops)
+		return;
+
+	if (proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
+		pde->flags |= PROC_ENTRY_PERMANENT;
+	if (proc_ops->proc_read_iter)
+		pde->flags |= PROC_ENTRY_proc_read_iter;
+#ifdef CONFIG_COMPAT
+	if (proc_ops->proc_compat_ioctl)
+		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
+#endif
+	if (proc_ops->proc_lseek)
+		pde->flags |= PROC_ENTRY_proc_lseek;
+}
+
 /* returns the registered entry, or frees dp and returns NULL on failure */
 struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 		struct proc_dir_entry *dp)
@@ -374,6 +393,8 @@ struct proc_dir_entry *proc_register(struct proc_dir_entry *dir,
 	if (proc_alloc_inum(&dp->low_ino))
 		goto out_free_entry;
 
+	pde_set_flags(dp);
+
 	write_lock(&proc_subdir_lock);
 	dp->parent = dir;
 	if (pde_subdir_insert(dir, dp) == false) {
@@ -561,20 +582,6 @@ struct proc_dir_entry *proc_create_reg(const char *name, umode_t mode,
 	return p;
 }
 
-static void pde_set_flags(struct proc_dir_entry *pde)
-{
-	if (pde->proc_ops->proc_flags & PROC_ENTRY_PERMANENT)
-		pde->flags |= PROC_ENTRY_PERMANENT;
-	if (pde->proc_ops->proc_read_iter)
-		pde->flags |= PROC_ENTRY_proc_read_iter;
-#ifdef CONFIG_COMPAT
-	if (pde->proc_ops->proc_compat_ioctl)
-		pde->flags |= PROC_ENTRY_proc_compat_ioctl;
-#endif
-	if (pde->proc_ops->proc_lseek)
-		pde->flags |= PROC_ENTRY_proc_lseek;
-}
-
 struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 		struct proc_dir_entry *parent,
 		const struct proc_ops *proc_ops, void *data)
@@ -585,7 +592,6 @@ struct proc_dir_entry *proc_create_data(const char *name, umode_t mode,
 	if (!p)
 		return NULL;
 	p->proc_ops = proc_ops;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_data);
@@ -636,7 +642,6 @@ struct proc_dir_entry *proc_create_seq_private(const char *name, umode_t mode,
 	p->proc_ops = &proc_seq_ops;
 	p->seq_ops = ops;
 	p->state_size = state_size;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_seq_private);
@@ -667,7 +672,6 @@ struct proc_dir_entry *proc_create_single_data(const char *name, umode_t mode,
 		return NULL;
 	p->proc_ops = &proc_single_ops;
 	p->single_show = show;
-	pde_set_flags(p);
 	return proc_register(parent, p);
 }
 EXPORT_SYMBOL(proc_create_single_data);
-- 
2.25.1


