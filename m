Return-Path: <linux-fsdevel+bounces-69816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 95483C86196
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58FB54EBD73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7F32FA1F;
	Tue, 25 Nov 2025 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="iXZw7hfl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3132A3C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764089969; cv=none; b=Yau1cSVwcjpKPDFFnPftR0otpFMTnaPDxAq18xIGRQXstDSqRM2ZAQxdmJ8ZKGmwDcr8SFlgiJC9uWZdNta35XJ2zbQ04MB/fRrj3sZa8a8lP95SI8aJ9mKSYjgnzGwvZOb3oylFqISFAiVhf2n0n49wBRSWz84TgJUXqmaVI3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764089969; c=relaxed/simple;
	bh=ezNu/UBbOrIs2ef8T8E6PIoZkTOz+W6uTYCkXqjXYwY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ot2pSChGng4jUFqBZBsiIr2g+Lr4YZsCXXUFlv4kVNHpwXby12KZCWkLWwO9Y+TX93OBOPn8rO+SFwlLOy7xjjptMDHI+9UgJ3FDJaYM/0xvROY2O35EoyLMAZugMgUFqfjRbEhru7gPRUvkBBBVKhj7CU7m0hdIycAsVgc4Hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=iXZw7hfl; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-78a6c7ac3caso57376047b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764089967; x=1764694767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfc1qJ15XMNkzBnOIVsDqUunQIJaXY9mGIdNtvrgttY=;
        b=iXZw7hflZL7OAS3iiBkI+haDyFOeuxrCbcXhxhCggPHlLlNevBxiD4s++ploTPjSEg
         hpLJCVg842lCZofYF+gEk8BNDtOAWHNaVTwwZArzbK+34BFg4J+OnHauAEJp5CSH/DRr
         HTD/fBRFMT4js/gOiRpZwQaePpmJ+jCrahnasy79zmdyrUQjEmF7kv7Hj4wweteX18eK
         +1tsKbtoKnfaxv/JNbhfWcqTcqDauafF3qxp0vzLZKyDpLMNG/XQFFQkvPhia/WZK0IW
         SVWzbgWzHyAASWTX3R9BTqhqbh3Pdb29XJXfVA9fTDm8W3+yQKIYrbN9WxZKBLqeBHcM
         5S7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764089967; x=1764694767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nfc1qJ15XMNkzBnOIVsDqUunQIJaXY9mGIdNtvrgttY=;
        b=WWZdKtunadfZq8x4eDzBveOF+/Wx4gHiEqecijUSfQOD56/k8Na8fBY2GwsegBj2w5
         8RMaT2D0mlvL5l60uqtefkwTIGMVDXL/1pINmkTuis49qjFGz6PRVm1XvTCWWhZR8gjp
         sTpLfJfsYvEAiLusCNYecctHLvxC8LKhOiK7P4hGp2Qh28iRE3tsDBS9NkXZZk0IHZSG
         zpTxdm/QNf9pIeiXZfPgcEknsA2QfWLFq3/YYJfmH3rzH+Mle7eG+QMaZ2ukTt0CKskB
         uWyO+nxnEH/vVo531NPr1DQXjRSbfk/tGYQ1qfFfIO0yRWm9vrClJrJ/ECRUpqxD6IOQ
         /1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7a1M4+uIftOCWd0+lcbZglr8JU3gfLh6gF9BTp5NFpTr6/Ffy2O1i2fKsx6PQFkp44zrvklHM5RAxnPHG@vger.kernel.org
X-Gm-Message-State: AOJu0YxvLuXiEiQN4NC73GyYosj2PUbTx98iv3gv2llHhzZ9ATst1WtA
	0W1F2ZP0amd7ll1MsbbAj6Bp2JN4O0aBhD6pKvV3EnGAHXWMBcogsgdET+1rFoD6OeI=
X-Gm-Gg: ASbGncugHKfvjVVs5a1CkensKIdMG/fB6oADkBJUJWa1wXaqUgRGExo546I7kMpLhkz
	CovrOBlpoMEkkpiOXoOhNlsCrLPxCYreZcAEojYQbuoE4lS0pZniV7TmtWDasYjG3bHZqSGk/y2
	pjVHs7nCOTLXsRaJVYv9/ejWwfcV31PAuk9qWtMM8wwRrGvwPfn1eS+3DvBSngD/bMQzsh8YI/X
	xHY0W38YxjKyw8PkByi7Nfu3WubiTGq0QTwgV3L+DjbYKmXAWFvAo7lL68iXKE5cKwRUv7CNQdD
	kVHxACUSPZR8Gi84gC/CY6wAkdSOGF70gya9a+7u2fQwfFzxE74lcioN5u/PcNd4io122/PH3Ss
	V6L5BKLjMBy0huwsVLfAmobuDbaTl95VxQtyU1MpOfc2Cxk1JkzBQzihPa90UfXdbybeGEqcxTD
	bDImvNlSUilF4WHrMjsKRlJrWNfADKdHvbmcWfizP37OfNii2AZPpIUKf+2CZ3H2iw
X-Google-Smtp-Source: AGHT+IF5jBi+6cZ6abg5wWWkMVh+/fFfNNV00PFFZKtXm2L1YcP9KpDzV5NTX/aunBS8G3bL9Na65Q==
X-Received: by 2002:a05:690c:4807:b0:786:5f42:5ac8 with SMTP id 00721157ae682-78a8b4720d7mr142868507b3.15.1764089966707;
        Tue, 25 Nov 2025 08:59:26 -0800 (PST)
Received: from soleen.c.googlers.com.com (182.221.85.34.bc.googleusercontent.com. [34.85.221.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a5518sm57284357b3.14.2025.11.25.08.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 08:59:16 -0800 (PST)
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
Subject: [PATCH v8 10/18] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
Date: Tue, 25 Nov 2025 11:58:40 -0500
Message-ID: <20251125165850.3389713-11-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
In-Reply-To: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
References: <20251125165850.3389713-1-pasha.tatashin@soleen.com>
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
2.52.0.460.gd25c4c69ec-goog


