Return-Path: <linux-fsdevel+bounces-75791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNEECkxWemlm5QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:32:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78303A7CB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34B45302C5DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172CD25A2B4;
	Wed, 28 Jan 2026 18:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7Jfe186"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0AA37105B;
	Wed, 28 Jan 2026 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625155; cv=none; b=tEK5uwbO5Eb0EbIgBYySGnwB4IvzAsnJX0fOyqfoAuhNyNGqZGU8N79jgYAEtb0hM/8hVuY1Gf/P92DF60cqBwsLLM699QCrT4L6FW4zMosR0mzMDH2AdUBD6BjfB4ITYzXkiTGqyZgvEPJfIaQacYDeiVx1XPK0ty8jeobqgwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625155; c=relaxed/simple;
	bh=5AjA3SD0xtDmV2WAyXS75p4kFdb/OZYhRaqk/aoUYd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnERSklcYWaOL0IAte/3h9E6yBiPXsrUt5fdAUOuITsAFrpIo81jXARqFjh4VDcPpg2jSHhNcpEsiLkbEXvnSX9bJ/9AQrqShTeZilrdNXtyBODEagd+gD5AFVMvBUgLcSkYIbWE5GrHtWbPSkFoYquWxcoc32YgoUTgtN2mR6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7Jfe186; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82008C4CEF1;
	Wed, 28 Jan 2026 18:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769625154;
	bh=5AjA3SD0xtDmV2WAyXS75p4kFdb/OZYhRaqk/aoUYd0=;
	h=From:To:Cc:Subject:Date:From;
	b=p7Jfe186jOgLmm0hMq43yYaHnhprtnzy4DIBtzcG5cKXPCngjbAhBiLyHqXc2l40O
	 fiAbrvhnXi814RtYUT/fFAQH0Y3pqf9D5dknCTrkFafk35HLulmKc0tm1hUNTP9g47
	 aGKyo1wCozxhks3bF9L6LrfRMiSjt3wJkYvWpoFHDcXr9tkuJRTdpebrXex+8h23LA
	 BWvd5jkG4AyEEU82ivbMAVKlIZxE7tFreZDVOlpuarygoNKk8v00Yl//PIEpLZ2mAj
	 a8R7sg71qmKMYhcxbqUNDI8pIkiLXMecxTvOk3PcbbtKV9tiF62BRhxL933U5LTl9w
	 gS2I8rCUq3enw==
From: Andrii Nakryiko <andrii@kernel.org>
To: akpm@linux-foundation.org,
	linux-mm@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org,
	surenb@google.com,
	Andrii Nakryiko <andrii@kernel.org>,
	syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Subject: [PATCH mm-stable] procfs: avoid fetching build ID while holding VMA lock
Date: Wed, 28 Jan 2026 10:32:32 -0800
Message-ID: <20260128183232.2854138-1-andrii@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75791-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrii@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,4e70c8e0a2017b432f7a];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 78303A7CB4
X-Rspamd-Action: no action

Fix PROCMAP_QUERY to fetch optional build ID only after dropping mmap_lock or
per-VMA lock, whichever was used to lock VMA under question, to avoid deadlock
reported by syzbot:

 -> #1 (&mm->mmap_lock){++++}-{4:4}:
        __might_fault+0xed/0x170
        _copy_to_iter+0x118/0x1720
        copy_page_to_iter+0x12d/0x1e0
        filemap_read+0x720/0x10a0
        blkdev_read_iter+0x2b5/0x4e0
        vfs_read+0x7f4/0xae0
        ksys_read+0x12a/0x250
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (&sb->s_type->i_mutex_key#8){++++}-{4:4}:
        __lock_acquire+0x1509/0x26d0
        lock_acquire+0x185/0x340
        down_read+0x98/0x490
        blkdev_read_iter+0x2a7/0x4e0
        __kernel_read+0x39a/0xa90
        freader_fetch+0x1d5/0xa80
        __build_id_parse.isra.0+0xea/0x6a0
        do_procmap_query+0xd75/0x1050
        procfs_procmap_ioctl+0x7a/0xb0
        __x64_sys_ioctl+0x18e/0x210
        do_syscall_64+0xcb/0xf80
        entry_SYSCALL_64_after_hwframe+0x77/0x7f

 other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   rlock(&mm->mmap_lock);
                                lock(&sb->s_type->i_mutex_key#8);
                                lock(&mm->mmap_lock);
   rlock(&sb->s_type->i_mutex_key#8);

  *** DEADLOCK ***

To make this safe, we need to grab file refcount while VMA is still locked, but
other than that everything is pretty straightforward. Internal build_id_parse()
API assumes VMA is passed, but it only needs the underlying file reference, so
just add another variant build_id_parse_file() that expects file passed
directly.

Fixes: ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")
Reported-by: syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c      | 42 ++++++++++++++++++++++++++---------------
 include/linux/buildid.h |  3 +++
 lib/buildid.c           | 34 +++++++++++++++++++++++++--------
 3 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 480db575553e..dd3b5cf9f0b7 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -656,6 +656,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 	struct proc_maps_locking_ctx lock_ctx = { .mm = mm };
 	struct procmap_query karg;
 	struct vm_area_struct *vma;
+	struct file *vm_file = NULL;
 	const char *name = NULL;
 	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
@@ -727,21 +728,6 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		karg.inode = 0;
 	}
 
-	if (karg.build_id_size) {
-		__u32 build_id_sz;
-
-		err = build_id_parse(vma, build_id_buf, &build_id_sz);
-		if (err) {
-			karg.build_id_size = 0;
-		} else {
-			if (karg.build_id_size < build_id_sz) {
-				err = -ENAMETOOLONG;
-				goto out;
-			}
-			karg.build_id_size = build_id_sz;
-		}
-	}
-
 	if (karg.vma_name_size) {
 		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
@@ -775,10 +761,34 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		karg.vma_name_size = name_sz;
 	}
 
+	if (karg.build_id_size && vma->vm_file)
+		vm_file = get_file(vma->vm_file);
+
 	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
 
+	if (karg.build_id_size) {
+		__u32 build_id_sz;
+
+		if (vm_file)
+			err = build_id_parse_file(vm_file, build_id_buf, &build_id_sz);
+		else
+			err = -ENOENT;
+		if (err) {
+			karg.build_id_size = 0;
+		} else {
+			if (karg.build_id_size < build_id_sz) {
+				err = -ENAMETOOLONG;
+				goto out;
+			}
+			karg.build_id_size = build_id_sz;
+		}
+	}
+
+	if (vm_file)
+		fput(vm_file);
+
 	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
 					       name, karg.vma_name_size)) {
 		kfree(name_buf);
@@ -798,6 +808,8 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+	if (vm_file)
+		fput(vm_file);
 	kfree(name_buf);
 	return err;
 }
diff --git a/include/linux/buildid.h b/include/linux/buildid.h
index 831c1b4b626c..7acc06b22fb7 100644
--- a/include/linux/buildid.h
+++ b/include/linux/buildid.h
@@ -7,7 +7,10 @@
 #define BUILD_ID_SIZE_MAX 20
 
 struct vm_area_struct;
+struct file;
+
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
+int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size);
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size);
 int build_id_parse_buf(const void *buf, unsigned char *build_id, u32 buf_size);
 
diff --git a/lib/buildid.c b/lib/buildid.c
index 818331051afe..dc643a6293c1 100644
--- a/lib/buildid.c
+++ b/lib/buildid.c
@@ -279,7 +279,7 @@ static int get_build_id_64(struct freader *r, unsigned char *build_id, __u32 *si
 /* enough for Elf64_Ehdr, Elf64_Phdr, and all the smaller requests */
 #define MAX_FREADER_BUF_SZ 64
 
-static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
+static int __build_id_parse(struct file *file, unsigned char *build_id,
 			    __u32 *size, bool may_fault)
 {
 	const Elf32_Ehdr *ehdr;
@@ -287,11 +287,7 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
 	char buf[MAX_FREADER_BUF_SZ];
 	int ret;
 
-	/* only works for page backed storage  */
-	if (!vma->vm_file)
-		return -EINVAL;
-
-	freader_init_from_file(&r, buf, sizeof(buf), vma->vm_file, may_fault);
+	freader_init_from_file(&r, buf, sizeof(buf), file, may_fault);
 
 	/* fetch first 18 bytes of ELF header for checks */
 	ehdr = freader_fetch(&r, 0, offsetofend(Elf32_Ehdr, e_type));
@@ -332,7 +328,10 @@ static int __build_id_parse(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	return __build_id_parse(vma, build_id, size, false /* !may_fault */);
+	if (!vma->vm_file)
+		return -EINVAL;
+
+	return __build_id_parse(vma->vm_file, build_id, size, false /* !may_fault */);
 }
 
 /*
@@ -348,7 +347,26 @@ int build_id_parse_nofault(struct vm_area_struct *vma, unsigned char *build_id,
  */
 int build_id_parse(struct vm_area_struct *vma, unsigned char *build_id, __u32 *size)
 {
-	return __build_id_parse(vma, build_id, size, true /* may_fault */);
+	if (!vma->vm_file)
+		return -EINVAL;
+
+	return __build_id_parse(vma->vm_file, build_id, size, true /* may_fault */);
+}
+
+/*
+ * Parse build ID of ELF file
+ * @vma:      file object
+ * @build_id: buffer to store build id, at least BUILD_ID_SIZE long
+ * @size:     returns actual build id size in case of success
+ *
+ * Assumes faultable context and can cause page faults to bring in file data
+ * into page cache.
+ *
+ * Return: 0 on success; negative error, otherwise
+ */
+int build_id_parse_file(struct file *file, unsigned char *build_id, __u32 *size)
+{
+	return __build_id_parse(file, build_id, size, true /* may_fault */);
 }
 
 /**
-- 
2.47.3


