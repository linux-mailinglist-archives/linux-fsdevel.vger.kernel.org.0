Return-Path: <linux-fsdevel+bounces-20091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202C8CE041
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 06:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C1121F23414
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 04:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E744AECA;
	Fri, 24 May 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SGDSyMA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A14A990;
	Fri, 24 May 2024 04:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716523854; cv=none; b=Aubdhee2C0LhQP11kTc6QmNY8RFDSEA23blpmcemdt3QgSRCRwzRPBbzowWO7/r0LvCziJIWbMC8jtGryGhSbop8Yk6Y9a0A9OqM7xdzR51I2GUsMg/14tNcGJOfrg3N2dbmfqp7n1DUHyNyPJ34DOR5AuyzmU/oHFW/GeYvUtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716523854; c=relaxed/simple;
	bh=/x/7qV6pswSalCbC6o7pTWU/vn1XS+egPb3p7SBL30Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uux39UYjw2RgpDOsF4LlxwRWpx/y5uUJDFn199b44AwQHtgEcD3AcAPHK9ePSVofdMBuD1YC0QEODht/XsArZG+MdqGfDDy7rpyG4hfHjQpnZU+YbsESz8Yz8wEyG2k7psQYf5EjSDxoFGAUajC8EhYZ/pR/bfX6z6rMb4c2Vv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SGDSyMA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402F6C2BD11;
	Fri, 24 May 2024 04:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716523854;
	bh=/x/7qV6pswSalCbC6o7pTWU/vn1XS+egPb3p7SBL30Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SGDSyMA05INCp7JaIvbBjPly0Su26/b3/n57wy76Zk8EtpSuYXONCHkI5yDyrHt3i
	 79oEGExT1NXwBUpgfHlOlB+iWQqoa+Iojo+GCwsTDhTETd5+G5UVnSXBh53ZzdTrgq
	 mqU3Ky7I2ej1qtcyUVko64q2SrVSIY789f/yinONQ2/ueHET64sa6BKLp32vhSjw2l
	 9bNrpNNGXd9W/KpwmVrPOUsLcZlYOazYsR/YkiqdVu6KZZV+17VGpb2aPEr964gZi2
	 FNvZC2ND4seohJSb1WkKM9FQe/zocDvY2SUDe114ejqoDzfbvY7VC6g0/VG7nZeuwj
	 o+voZvJS/t1Ig==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	rppt@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 5/9] fs/procfs: add build ID fetching to PROCMAP_QUERY API
Date: Thu, 23 May 2024 21:10:27 -0700
Message-ID: <20240524041032.1048094-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240524041032.1048094-1-andrii@kernel.org>
References: <20240524041032.1048094-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The need to get ELF build ID reliably is an important aspect when
dealing with profiling and stack trace symbolization, and
/proc/<pid>/maps textual representation doesn't help with this.

To get backing file's ELF build ID, application has to first resolve
VMA, then use it's start/end address range to follow a special
/proc/<pid>/map_files/<start>-<end> symlink to open the ELF file (this
is necessary because backing file might have been removed from the disk
or was already replaced with another binary in the same file path.

Such approach, beyond just adding complexity of having to do a bunch of
extra work, has extra security implications. Because application opens
underlying ELF file and needs read access to its entire contents (as far
as kernel is concerned), kernel puts additional capable() checks on
following /proc/<pid>/map_files/<start>-<end> symlink. And that makes
sense in general.

But in the case of build ID, profiler/symbolizer doesn't need the
contents of ELF file, per se. It's only build ID that is of interest,
and ELF build ID itself doesn't provide any sensitive information.

So this patch adds a way to request backing file's ELF build ID along
the rest of VMA information in the same API. User has control over
whether this piece of information is requested or not by either setting
build_id_size field to zero or non-zero maximum buffer size they
provided through build_id_addr field (which encodes user pointer as
__u64 field). This is a completely optional piece of information, and so
has no performance implications for user cases that don't care about
build ID, while improving performance and simplifying the setup for
those application that do need it.

Kernel already implements build ID fetching, which is used from BPF
subsystem. We are reusing this code here, but plan a follow up changes
to make it work better under more relaxed assumption (compared to what
existing code assumes) of being called from user process context, in
which page faults are allowed. BPF-specific implementation currently
bails out if necessary part of ELF file is not paged in, all due to
extra BPF-specific restrictions (like the need to fetch build ID in
restrictive contexts such as NMI handler).

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 fs/proc/task_mmu.c      | 25 ++++++++++++++++++++++++-
 include/uapi/linux/fs.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2b14d06d1def..c8f783644d36 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -22,6 +22,7 @@
 #include <linux/pkeys.h>
 #include <linux/minmax.h>
 #include <linux/overflow.h>
+#include <linux/buildid.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -453,6 +454,7 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 		vma_end_read(vma);
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
+
 no_vma:
 	if (mmap_locked)
 		mmap_read_unlock(mm);
@@ -474,7 +476,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	struct mm_struct *mm;
 	bool mm_locked;
 	const char *name = NULL;
-	char *name_buf = NULL;
+	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
 	int err;
 
@@ -496,6 +498,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	/* either both buffer address and size are set, or both should be zero */
 	if (!!karg.vma_name_size != !!karg.vma_name_addr)
 		return -EINVAL;
+	if (!!karg.build_id_size != !!karg.build_id_addr)
+		return -EINVAL;
 
 	mm = priv->mm;
 	if (!mm || !mmget_not_zero(mm))
@@ -534,6 +538,21 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	if (vma->vm_flags & VM_MAYSHARE)
 		karg.vma_flags |= PROCMAP_QUERY_VMA_SHARED;
 
+	if (karg.build_id_size) {
+		__u32 build_id_sz;
+
+		err = build_id_parse(vma, build_id_buf, &build_id_sz);
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
 	if (karg.vma_name_size) {
 		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
 		const struct path *path;
@@ -578,6 +597,10 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	}
 	kfree(name_buf);
 
+	if (karg.build_id_size && copy_to_user((void __user *)karg.build_id_addr,
+					       build_id_buf, karg.build_id_size))
+		return -EFAULT;
+
 	if (copy_to_user(uarg, &karg, min_t(size_t, sizeof(karg), usize)))
 		return -EFAULT;
 
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index f25e7004972d..7306022780d3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -509,6 +509,26 @@ struct procmap_query {
 	 * If set to zero, vma_name_addr should be set to zero as well
 	 */
 	__u32 vma_name_size;		/* in/out */
+	/*
+	 * If set to non-zero value, signals the request to extract and return
+	 * VMA's backing file's build ID, if the backing file is an ELF file
+	 * and it contains embedded build ID.
+	 *
+	 * Kernel will set this field to zero, if VMA has no backing file,
+	 * backing file is not an ELF file, or ELF file has no build ID
+	 * embedded.
+	 *
+	 * Build ID is a binary value (not a string). Kernel will set
+	 * build_id_size field to exact number of bytes used for build ID.
+	 * If build ID is requested and present, but needs more bytes than
+	 * user-supplied maximum buffer size (see build_id_addr field below),
+	 * -E2BIG error will be returned.
+	 *
+	 * If this field is set to non-zero value, build_id_addr should point
+	 * to valid user space memory buffer of at least build_id_size bytes.
+	 * If set to zero, build_id_addr should be set to zero as well
+	 */
+	__u32 build_id_size;		/* in/out */
 	/*
 	 * User-supplied address of a buffer of at least vma_name_size bytes
 	 * for kernel to fill with matched VMA's name (see vma_name_size field
@@ -517,6 +537,14 @@ struct procmap_query {
 	 * Should be set to zero if VMA name should not be returned.
 	 */
 	__u64 vma_name_addr;		/* in */
+	/*
+	 * User-supplied address of a buffer of at least build_id_size bytes
+	 * for kernel to fill with matched VMA's ELF build ID, if available
+	 * (see build_id_size field description above for details).
+	 *
+	 * Should be set to zero if build ID should not be returned.
+	 */
+	__u64 build_id_addr;		/* in */
 };
 
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


