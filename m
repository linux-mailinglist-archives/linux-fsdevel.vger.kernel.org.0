Return-Path: <linux-fsdevel+bounces-69492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61267C7D90D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 23:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD595351CB8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Nov 2025 22:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6C2DE6F8;
	Sat, 22 Nov 2025 22:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="K6CWY2cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300552DAFB5
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763850260; cv=none; b=O5pOqUXZpuvErR5NQbJsJoa5Dsfki4j3qTmuPcgq/83h/ngxQEvN3PLp9yK2c8vlZ1Q2IG0nuI0jvpS/GuSu2qLdxVNzAB+4J6XdH5Wpq1O+3izSa+u/D6BlAHY9yHV//MJxOyF0PlYx54FVJPPOSuAbnQLQUSbAlxYaaLCBaks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763850260; c=relaxed/simple;
	bh=Qr8jJbtYkvKZNZeZt5x6RtbksbSJrimm82dpy5dwktM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGDg1iVFVlHkAtzmNLIVfnUcl6V+WJPjpNayen4X8Sf1Y9+HoQkJhyCKJvw9JLUda1a2Y+ULDk1GqhtzFqYW1L9uNSjeXjUAiPJ52k0dWE+wgmaMQuTLzlWQv1vCEAvrg7DfIP3iURO75ROBWBSK3aKgSJIVw8kZhlMrergjmGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=K6CWY2cf; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-642f3bab0c8so2202830d50.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 22 Nov 2025 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763850257; x=1764455057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3SsEWcfoC9wTWzpyUGqKCgnql8plxpKqJFH67bD/ic=;
        b=K6CWY2cfGaMAdw+GJe/cIMND7Isupzex4tVuMvVjLvSrnJGwkEKpjNeT6ihEeusdOG
         m4l1rlsXnZk0ObYKgLKY6RXJ2+nplKAnxFIu64G/UZpa014UQtLrrgwgCoP490wqFUz2
         XTnOamaXFijm7tNiJ/e755k3JtPq7louVuCUtPtReIXSLh0pZEBsWcv7GN9HPijq6mG2
         0HWeLjjvsynI82EAh5D+ugfGVAaumFsVipuJEM9/ZY97jLhlNbPdMPMS23wlU6Yzkjz7
         dKkA8ThExl1wHzf3siCEREi2kSDAGeUwB1Z17V48WNps/18MDSSKLRw14+uLOtwK+XnE
         wfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763850257; x=1764455057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U3SsEWcfoC9wTWzpyUGqKCgnql8plxpKqJFH67bD/ic=;
        b=iY0B7VKg6UM3lbmx6GSiK4lcCz29p8WiNGCLAAkByNyZNF7iN6qIcVMmgGTeYDCO27
         vAZKa7Ql3rsSl2ZstIyEsym8SoN/w34juB0Pp30l61zM4jvESCcjW88HqlD3LzMY06c2
         yZA8hdhG+vQScDtC5DRQzWwBU2VM6btgliQxIj7BV+eX91lYZfK2nCG7uFtA0S7Ya/n9
         bCwRngxfl4a/DT09TW/BbBU5Cw8Ah0f2JNOqcl1d9sEtmDZgyfY5EEAm8SiKBpv/CFJN
         qtjf3hqs+/XV3lt8YvHdW1qsuxeYa8OGxnXh8V+bCH58IMFF04h3ksNMUwTCQzdq4pZI
         UpZA==
X-Forwarded-Encrypted: i=1; AJvYcCV6sRfaveLvCoxqU7BY1rRDk6FOcUJEe1IitOoGWGpHQu0/PFS75rUAso5a/VBPaYfuXon9j729NE/zPYlO@vger.kernel.org
X-Gm-Message-State: AOJu0YxhojDF+2MzHl9DJV925XZH0bpraiQ0KSMLwX91UBzenKnMqdM/
	TyHKywVwzSiQRK/3Tkyc1xnU5iTr9TKorM8kEcQ9AGgfXWoh9YoOEflWkF4BUWIEoJw=
X-Gm-Gg: ASbGncv/PM4KMT/03axZLJaLIGZS5zi6uaCUWSk2iLQ6F0VlhZUaLipQn8/jm+LAPVN
	83sf1df0Y0TFPpQbg/1WOWFrL7mK9hj/cOjUs7gNusK+phU4Qg9o1yu5gt3RVu0/1szjthuAN0u
	34CpDTv05yOi1KD8u3gRyrmP0PZ4BOP/8efdHfiT8uRJzjobUlS4XYS85NFJBzOMpD+fmH8cbU0
	xLoJy3klHdEUnloqQkiSlmm02+7HG+77Z3mo0yqOoxsdqnjOwO/OD4n3Xvu6qVEz41AmbG7KKOk
	CCveEN7/YSWYJJKyiMi3186ijA81+swz2hCDczfGsntgFoII9O69Z5PrVUc0RxVmbuWZAwdRiWq
	pLe6AM1IT4epzWmWuw+slU5mQjWceHo3qfXJRpq4Xwl/W6/EvnQegwjZn1yiisTxXm/BVBGiTpr
	tnY2mdBduFfIKWOBtcgURRKd8sFM8OQjUxvilmTbxTk9MGnWWvSKmf7euPG7R8KfcybIjWRJARo
	rrrxYw=
X-Google-Smtp-Source: AGHT+IGN8V9s1y7QiOXXSQkfpg2Me3ul34/5J4KwUo57XUBRpeUqmFQ1wvJ0i+/kbCzYrwZ02S+fug==
X-Received: by 2002:a05:690e:148f:b0:63f:b8d0:7e2c with SMTP id 956f58d0204a3-64302a2fe8dmr5068390d50.2.1763850257000;
        Sat, 22 Nov 2025 14:24:17 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a79779a4esm28858937b3.0.2025.11.22.14.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 14:24:16 -0800 (PST)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org
Subject: [PATCH v7 10/22] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
Date: Sat, 22 Nov 2025 17:23:37 -0500
Message-ID: <20251122222351.1059049-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.rc2.455.g230fcf2819-goog
In-Reply-To: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
References: <20251122222351.1059049-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pratyush Yadav <ptyadav@amazon.de>

shmem_inode_info::flags can have the VM flags VM_NORESERVE and
VM_LOCKED. These are used to suppress pre-accounting or to lock the
pages in the inode respectively. Using the VM flags directly makes it
difficult to add shmem-specific flags that are unrelated to VM behavior
since one would need to find a VM flag not used by shmem and re-purpose
it.

Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
information, but their bits are independent of the VM flags. Callers can
still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed to
the shmem-specific flag internally.

No functional changes intended.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/shmem_fs.h |  6 ++++++
 mm/shmem.c               | 28 +++++++++++++++-------------
 2 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0e47465ef0fd..650874b400b5 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -10,6 +10,7 @@
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/bits.h>
 
 struct swap_iocb;
 
@@ -19,6 +20,11 @@ struct swap_iocb;
 #define SHMEM_MAXQUOTAS 2
 #endif
 
+/* Suppress pre-accounting of the entire object size. */
+#define SHMEM_F_NORESERVE	BIT(0)
+/* Disallow swapping. */
+#define SHMEM_F_LOCKED		BIT(1)
+
 struct shmem_inode_info {
 	spinlock_t		lock;
 	unsigned int		seals;		/* shmem seals */
diff --git a/mm/shmem.c b/mm/shmem.c
index 58701d14dd96..1d5036dec08a 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -175,20 +175,20 @@ static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
  */
 static inline int shmem_acct_size(unsigned long flags, loff_t size)
 {
-	return (flags & VM_NORESERVE) ?
+	return (flags & SHMEM_F_NORESERVE) ?
 		0 : security_vm_enough_memory_mm(current->mm, VM_ACCT(size));
 }
 
 static inline void shmem_unacct_size(unsigned long flags, loff_t size)
 {
-	if (!(flags & VM_NORESERVE))
+	if (!(flags & SHMEM_F_NORESERVE))
 		vm_unacct_memory(VM_ACCT(size));
 }
 
 static inline int shmem_reacct_size(unsigned long flags,
 		loff_t oldsize, loff_t newsize)
 {
-	if (!(flags & VM_NORESERVE)) {
+	if (!(flags & SHMEM_F_NORESERVE)) {
 		if (VM_ACCT(newsize) > VM_ACCT(oldsize))
 			return security_vm_enough_memory_mm(current->mm,
 					VM_ACCT(newsize) - VM_ACCT(oldsize));
@@ -206,7 +206,7 @@ static inline int shmem_reacct_size(unsigned long flags,
  */
 static inline int shmem_acct_blocks(unsigned long flags, long pages)
 {
-	if (!(flags & VM_NORESERVE))
+	if (!(flags & SHMEM_F_NORESERVE))
 		return 0;
 
 	return security_vm_enough_memory_mm(current->mm,
@@ -215,7 +215,7 @@ static inline int shmem_acct_blocks(unsigned long flags, long pages)
 
 static inline void shmem_unacct_blocks(unsigned long flags, long pages)
 {
-	if (flags & VM_NORESERVE)
+	if (flags & SHMEM_F_NORESERVE)
 		vm_unacct_memory(pages * VM_ACCT(PAGE_SIZE));
 }
 
@@ -1551,7 +1551,7 @@ int shmem_writeout(struct folio *folio, struct swap_iocb **plug,
 	int nr_pages;
 	bool split = false;
 
-	if ((info->flags & VM_LOCKED) || sbinfo->noswap)
+	if ((info->flags & SHMEM_F_LOCKED) || sbinfo->noswap)
 		goto redirty;
 
 	if (!total_swap_pages)
@@ -2910,15 +2910,15 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
 	 * ipc_lock_object() when called from shmctl_do_lock(),
 	 * no serialization needed when called from shm_destroy().
 	 */
-	if (lock && !(info->flags & VM_LOCKED)) {
+	if (lock && !(info->flags & SHMEM_F_LOCKED)) {
 		if (!user_shm_lock(inode->i_size, ucounts))
 			goto out_nomem;
-		info->flags |= VM_LOCKED;
+		info->flags |= SHMEM_F_LOCKED;
 		mapping_set_unevictable(file->f_mapping);
 	}
-	if (!lock && (info->flags & VM_LOCKED) && ucounts) {
+	if (!lock && (info->flags & SHMEM_F_LOCKED) && ucounts) {
 		user_shm_unlock(inode->i_size, ucounts);
-		info->flags &= ~VM_LOCKED;
+		info->flags &= ~SHMEM_F_LOCKED;
 		mapping_clear_unevictable(file->f_mapping);
 	}
 	retval = 0;
@@ -3062,7 +3062,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = flags & VM_NORESERVE;
+	info->flags = (flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -5804,8 +5804,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-			loff_t size, unsigned long flags, unsigned int i_flags)
+				       loff_t size, unsigned long vm_flags,
+				       unsigned int i_flags)
 {
+	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5822,7 +5824,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, flags);
+				S_IFREG | S_IRWXUGO, 0, vm_flags);
 	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_CAST(inode);
-- 
2.52.0.rc2.455.g230fcf2819-goog


