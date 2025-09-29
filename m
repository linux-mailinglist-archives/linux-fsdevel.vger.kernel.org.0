Return-Path: <linux-fsdevel+bounces-62977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C3BA7B5C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 03:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AD2417B610
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Sep 2025 01:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE7E1F7569;
	Mon, 29 Sep 2025 01:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="arVbYY40"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F931278E44
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Sep 2025 01:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759107887; cv=none; b=fsohYJzKzr6k7zCFQDyutVj4urAZ5WEZ8K07lA0ZTy6jeiMHroSpTsCdItBbDTwsTHG0OwWre3PPtBF9xhO/2PjGzFh/A9MuiSwX66o/CUp1t9zORr5jS0N7FKVTkp/Zek5aWPVnGruqc6jqN82opQwFVXggjfjtf1duRBWMYCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759107887; c=relaxed/simple;
	bh=hkGL4iGBINyFUpwIkVmPBG/v+0aFAVp0ef3WvzV/lRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZKecpoCwBdiGlPgI0/pqO3C5tlPaj3S2TvtbvSqSeIsY49innOJ8nTFY4TDyZGx5JF/PHoYMVnDpa5Y6sQYBD62SXonQ/LdQtkhNiustRKnIu/E93sXq5hlS+gvUQcIiNvk+lCjBMixT8Ck2jntq5eAF/8jtRXwfyQLcFR7xvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=arVbYY40; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-816ac9f9507so524293285a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759107883; x=1759712683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3orCdZcM4OnRmQqZSjpp/rFEAME7J/Ll0MOwDMAGFw=;
        b=arVbYY40EKsaATvXkWqB2NUOF7nKmqwpk7E5gpOjjaHCilLu/qqNTKaBd8D0siAipG
         Pc6TgevnEkOOfnIa8PkDv0ZvMF4bo2i0YVWe8VtourutIvlZjVVeeqfN6p/lpAM3z0H1
         4Xa6dZiF87uSsS4TgC/PubuloH6fNk50pu4L+MDCSWvhmC8gGi9jeBKmEH9TIXE3TlmF
         Ldc6VK5vKLaJAikn0vIDI+SU+cHMvd46+Bsu46XVlwnhyKkzdMTeL1E+lF/ugri89t7T
         TmwpoDmOj+9bwUG6hACtZpA+2h1ovFY00bV0jNG9nBUnEF96nSamDc0pYQI6KTm/2xU3
         4yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759107883; x=1759712683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3orCdZcM4OnRmQqZSjpp/rFEAME7J/Ll0MOwDMAGFw=;
        b=cThNsr6glQMsSJsbxt/qWO3/SxLREkg6DH7Hk+u0eDu8YanhmaRftDT7x+ngIaKwaC
         Wv8u57W/cuC4XFj2nqKptUubi+fN6YZmPM5C9OxSl10G9thxpTTKP/7i+Ea/ifUOdB/c
         Wy91+5jSFqmSchklfRY+RzjuomEatMFolazeWCWaNwIb+FOztwnzt2WC3r3AuhqiUJX6
         yp6JxoC0r/549kGtwbaQ4a+o0kR+I5byRi4KdgAFO1DoORZuwxv8hzNSbEiNpIbIaBpB
         Ik990fhK5MCzwtrhG8H2lMWP+mhdSmCq9oUz8oY0huAfnIM25+eB07NaHgo34vh9Vnm6
         cB7A==
X-Forwarded-Encrypted: i=1; AJvYcCWtv/k0dbdDc99SrQuwOljXIU20p8QEtKCdNFkZt14J455PNwsweWKUZlNzaZFTZI/aynB1bYMNMptK0wt3@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc+yGKfY0hEVJXaD2bn0WRk3Hog+ianYKYlT3meJpkY4ZZ/LhN
	0NKKmvymIBdXZlBnhgloXcpevQ1/llgJUo1CxJZL2nhPYdGkhZk+gcm8T6xyF1WqI6s=
X-Gm-Gg: ASbGncvn8Dn7S6RQexrUfIecn21MNGtzhUFQQqoNIsF5aXM68GOS4nCYJKHFN6WXz6C
	Hihd4MxLAIGsihw/rvgJ5H8kGNbbx6fgiGDl03reczIDDHLg2Wteby61Vxf9crAhDj8cw8unM77
	PIhPSVVc/pxnsMrwKhn5D5HFd9QWWjxdTExDVrBZwmlffRVjk8qmwlz3ZruD/XHWP4/kljmnAAk
	UN+qoWXNkL45s1X1Iv1uoIkXoJKpo3+4lCKHvUn17RW69hv32j/GIlm6Pnn8hNw0BNL9rItvzbf
	vw0W4wvgEvMeccMJnK7J/Clp/xUHfGmFAT9S9ECQPauEjY0qYN4WaD10msoxV6j4ds/ahS84jg3
	zzAi7hU7vF/XamiIHKdgknqZ1NorX697E5SdBIvcH0sYekUgkPaXjHdoUiRwhvi6AeCyCst0Urh
	rwVjh2mDUylsh/mTqtBw==
X-Google-Smtp-Source: AGHT+IGJx0yEjs9NdTtup483rQFUUHbu23+HQshPBoJHcCouKPKah+/aB6Qgtrmj1NCU6W09m2WUMQ==
X-Received: by 2002:a05:620a:172a:b0:7e7:fd49:b0c7 with SMTP id af79cd13be357-8645c15e564mr910943285a.7.1759107883275;
        Sun, 28 Sep 2025 18:04:43 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db0c0fbe63sm64561521cf.23.2025.09.28.18.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 18:04:42 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com,
	hughd@google.com,
	skhawaja@google.com,
	chrisl@kernel.org,
	steven.sistare@oracle.com
Subject: [PATCH v4 21/30] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
Date: Mon, 29 Sep 2025 01:03:12 +0000
Message-ID: <20250929010321.3462457-22-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
In-Reply-To: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
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
 mm/shmem.c               | 29 ++++++++++++++++-------------
 2 files changed, 22 insertions(+), 13 deletions(-)

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
index b9081b817d28..ce3b912f62da 100644
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
@@ -2907,15 +2907,15 @@ int shmem_lock(struct file *file, int lock, struct ucounts *ucounts)
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
@@ -3059,7 +3059,8 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
-	info->flags = flags & VM_NORESERVE;
+	if (flags & VM_NORESERVE)
+		info->flags = SHMEM_F_NORESERVE;
 	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
@@ -5801,8 +5802,10 @@ static inline struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 /* common code */
 
 static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
-			loff_t size, unsigned long flags, unsigned int i_flags)
+				       loff_t size, unsigned long vm_flags,
+				       unsigned int i_flags)
 {
+	unsigned long flags = (vm_flags & VM_NORESERVE) ? SHMEM_F_NORESERVE : 0;
 	struct inode *inode;
 	struct file *res;
 
@@ -5819,7 +5822,7 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	inode = shmem_get_inode(&nop_mnt_idmap, mnt->mnt_sb, NULL,
-				S_IFREG | S_IRWXUGO, 0, flags);
+				S_IFREG | S_IRWXUGO, 0, vm_flags);
 	if (IS_ERR(inode)) {
 		shmem_unacct_size(flags, size);
 		return ERR_CAST(inode);
-- 
2.51.0.536.g15c5d4f767-goog


