Return-Path: <linux-fsdevel+bounces-21002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB0D8FC0AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 02:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DDB28256A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CC13BC1F;
	Wed,  5 Jun 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIIA33H5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C831D13B794;
	Wed,  5 Jun 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717547127; cv=none; b=VsFaXiGJfeQlG2Tl/1P2sdVaVTfc7oXqja+McD5xdE7Hqzd5fvyDKMhOXNdZ8zo0M+rR+g3Ip77ExeTEfJPe8RTI4vecceDnbKAoNqDV8THi23QWxG23WP9c80WzQUN0QPJs+fhpAopNehmk6uc2bNwEE8m1qcKf6ihrmVQ5Phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717547127; c=relaxed/simple;
	bh=AklsDx8YWfb7MKXDA8kKw+F7thNTeWZboAKDAUz54mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr+GfUXo4zA0T4Xo4S2D5gmlGuhSu0c2QGSJjG9BeWpTO6DjFsLo1AwLwxR77Tq/AvgY8GP9AS3NRNMY8O+4zxP/mw8OazXY/GGQxtqfmbLa7ekp2kFOl2j+y49NI+EsJjhhyGyGJzcOUtCC2fGrjwuyb0EpCbUwMKwLMerge0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIIA33H5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18380C32786;
	Wed,  5 Jun 2024 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717547127;
	bh=AklsDx8YWfb7MKXDA8kKw+F7thNTeWZboAKDAUz54mw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIIA33H5QH+tD7y9NWtd3jWhzSau3y32gUEvdrPPCiaQj/oK8V7ws3/uhQqrGa8E3
	 G+rv4eCpgX8sYu4K6Ej1pkHk/DPd7rD1GiC33BMXQo/fSWIbpYqeBzSrc4dStTjJpq
	 QZEZ6HGWIOeHp5x0zXBgVUoLLvXoD/CQO6gWw9fbki6qkV+qJoavysMPxs1BPfbM0W
	 3QsrVoUwFAS0QIMSppOa7H3qNufxa55g2CEMyy6DNN8ZCwB71Ns3L2G+WsmIx3UYX7
	 dTQwEieiqCwoAxfrATLcF5OS/CPBC6hr53IizeOVUsTFk/ufmFusqFS+Czfb/Dw4Bp
	 4Dh/vlrF/FLfw==
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
Subject: [PATCH v3 5/9] fs/procfs: add build ID fetching to PROCMAP_QUERY API
Date: Tue,  4 Jun 2024 17:24:50 -0700
Message-ID: <20240605002459.4091285-6-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605002459.4091285-1-andrii@kernel.org>
References: <20240605002459.4091285-1-andrii@kernel.org>
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
index 140032ffc551..4b7251fb1a4b 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -22,6 +22,7 @@
 #include <linux/pkeys.h>
 #include <linux/minmax.h>
 #include <linux/overflow.h>
+#include <linux/buildid.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -491,6 +492,7 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
 	vma_end_read(vma); /* no-op under !CONFIG_PER_VMA_LOCK */
 	if (flags & PROCMAP_QUERY_COVERING_OR_NEXT_VMA)
 		goto next_vma;
+
 no_vma:
 	return ERR_PTR(-ENOENT);
 }
@@ -501,7 +503,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	struct vm_area_struct *vma;
 	struct mm_struct *mm;
 	const char *name = NULL;
-	char *name_buf = NULL;
+	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
 	__u64 usize;
 	int err;
 
@@ -523,6 +525,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
 	/* either both buffer address and size are set, or both should be zero */
 	if (!!karg.vma_name_size != !!karg.vma_name_addr)
 		return -EINVAL;
+	if (!!karg.build_id_size != !!karg.build_id_addr)
+		return -EINVAL;
 
 	mm = priv->mm;
 	if (!mm || !mmget_not_zero(mm))
@@ -568,6 +572,21 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
@@ -612,6 +631,10 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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


