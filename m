Return-Path: <linux-fsdevel+bounces-53022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96FAE9288
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740901882295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E73093A3;
	Wed, 25 Jun 2025 23:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ChrAJ4UX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1356C306DA5
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893570; cv=none; b=Y9Y0TZ5QgWcHBXouTz7I7aHq4Hu7Y8JVrgE+IvAxwMLi7WBJ4NxeyOeg8FG9AWGpp1hWHEhkrLD+8FE6d7YzIBLmRg9aAnbkoKWHGG90V4cxYFlTzDi2sB0p1rLW9DAr0/O0JPc9z9Rqf8QWeP2IYKrmmXOW76FLi3KXQVjMYUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893570; c=relaxed/simple;
	bh=30GwfOPk4OSJwfXww5xApnDUnwtMsQ1hVV+ge74wZ9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5632wGhZNRH/U4fkX56fbkR73Gf30blfst4LHgb44vH7qoHprnQhmgXzsVcd6yPtYHz1KmMq+GkIFkn+l/EAsZ5NF2keE+a+a1TR/pKdFLoyUywyLiD3ewsvdfSOXvm8G6bnIpOVs/v39oUkykdFK10d2BWZgevtjkF8WgT7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ChrAJ4UX; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8601ce24c9so272816276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jun 2025 16:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893567; x=1751498367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8ttgCxJcE3UWPna1GSp5WvPQd8LCM7eXREvoZYzvG0=;
        b=ChrAJ4UX2GdsUlIUj/l6PgtqRrg68uHZZiTlb3Ueh5H+FfM10T5d3mdBudf2slgRnZ
         8M2gsW3bKAICWNuAOqoMRb270B/3JOX12htWydm6l92aWFR7Ks8h/a/IkpBAjtX0GJTK
         FDnatIx74CegqtyV8NVbuMIIkQgOitS4QAZWP6DQJ6fTcx8kcSmKn/dplz5cXc7zItKr
         jGoC5mdWE63GigyS1v/rrOxiiuxYOy5LcvIO6FNEhebXkZKJ48PLYbdSQyziPcUeQIr6
         OI5cFYvR/qUeUmHBglRVyryLUsuPfBtU+8tPJSkv1yEHPXmhx5lgrFJRGtHxMIs24Emm
         lexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893567; x=1751498367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8ttgCxJcE3UWPna1GSp5WvPQd8LCM7eXREvoZYzvG0=;
        b=k1VjHUdssMuVlJyIGoheapBH+0o4Up1lSHPssX25X62osaDFhYQZ+ZVHo6u0ocCjqC
         B3QvvgkJPDyH7SUewb/xZkmDJVCiyjE203gRwlOlmQH7THaSoLpJPw5MDY7XzqBbj9UM
         JlXRGq/fMI1XEV8kLvlqs5FMgjcweAsREb+uJT0NfFpOR7jxX5l74k3cIMCwMCA5uC4X
         7Sx+Ro+Z2v6g20SYfAXh+GpvqxpnzEBeFEcLibok4yhmNWp0gJr/gx/3yQKWmXwbalft
         Z7qwGue4Lxo3B5NKKjKhjQMVH3mSd2bnXABZcmFoYYRy+FMHPWmX6FZG6scWZYRiLlwC
         bdOw==
X-Forwarded-Encrypted: i=1; AJvYcCUapUA4Ozeyxl5rlohhX6j++CmRbF5LeKjvpy2NXTEebnlGgEK1lsYFATxWG61RC/iNxBKoLlkY+4eqd2b0@vger.kernel.org
X-Gm-Message-State: AOJu0YxHmJqpQeO1s8Evp3yn4ndyN1lrHmNFOcWCetAxiSCgMv7NJ++6
	vTJm7Z+5lf1plgDLeH4hlznDgcoQ0UDN7ZxngIfR51UqjQiu4cHN8MaAFFmZfckgRVE=
X-Gm-Gg: ASbGncsTRVyX/ELMrmkTgEI4cUXEUayOUYQA5dq9lba6OVOej4vw6AT1KdvsPZ/Z0rp
	/bDXE1n6gEwVF35J0fpZCXvLxJyMcHyby87UYrj0mZX90tgrxLOAAF3BZ6Usf2zRan4tgx43GtB
	UiNs3UaosrvzgCH6+JFr0MweeH7xC8tCtcpvFynKmmE7N7ppznH2+8XRxEp8KOS1NypZsJatK+O
	/XaTlXm17r+Es9FSKfObgP93zEQsPUMqGRHh+Jp+Ov/M7Ql6EeBrJWjUkHLRVGU4oIUNOmRkA8s
	Sc6TLSt8xTJ7mOfLEfPXz4QAoqxaCcpRhatCRIS00BV4tYipbWf0Bdpq6JmNmWCKlmFJlirpHJQ
	Kt/2bZ/KqGOpf9m1vWdcY9M9ZTWOUwNcZA+ylgoaEDrK9L0hCWV1H
X-Google-Smtp-Source: AGHT+IE1pma/OI7F9Z9q+/yKqcLVvi7QSXRzKzluPfGgyPm9xYfbfJNVSej/XTGmvtY9GN91WObkjQ==
X-Received: by 2002:a05:690c:6082:b0:714:349:583d with SMTP id 00721157ae682-71406ca1431mr68358807b3.8.1750893566981;
        Wed, 25 Jun 2025 16:19:26 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:19:26 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
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
	zhangguopeng@kylinos.cn,
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 25/32] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
Date: Wed, 25 Jun 2025 23:18:12 +0000
Message-ID: <20250625231838.1897085-26-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
---
 include/linux/shmem_fs.h |  6 ++++++
 mm/shmem.c               | 24 +++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 5f03a39a26f7..578a5f3d1935 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -10,6 +10,7 @@
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/bits.h>
 
 /* inode in-kernel data */
 
@@ -17,6 +18,11 @@
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
index 3a5a65b1f41a..953d89f62882 100644
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
 
@@ -1557,7 +1557,7 @@ int shmem_writeout(struct folio *folio, struct writeback_control *wbc)
 	if (WARN_ON_ONCE(!wbc->for_reclaim))
 		goto redirty;
 
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
@@ -3062,7 +3062,9 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = flags & VM_NORESERVE;
+	info->flags = 0;
+	if (flags & VM_NORESERVE)
+		info->flags |= SHMEM_F_NORESERVE;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
-- 
2.50.0.727.gbf7dc18ff4-goog


