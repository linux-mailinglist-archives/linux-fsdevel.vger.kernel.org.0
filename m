Return-Path: <linux-fsdevel+bounces-18705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D82698BB8C1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 02:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462FAB21C92
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 00:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152C814F78;
	Sat,  4 May 2024 00:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEFOCn6M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8A107B3;
	Sat,  4 May 2024 00:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782618; cv=none; b=KwaFp7iFLQJp0+fofwC/kGaIAm6SsI0q8I7X83fz6wmXm9wGdOUQsEgTrAsnobGpBvUqDAYXsapUWETX7ObMKyxEzmw8IPNE6iIxiC/d7GQJaJDolvxAGk+ECcVRcJrGgXXAzJDKlHagAAuB0IeiDwZHunebqU4QLh5UpJyur1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782618; c=relaxed/simple;
	bh=akE5P6xvZT48f5LRQWKFAyRAluTFD6SKWbtJB6gxXDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwNU+mmdmc3nwF+dQdhcgHkVGaqtuw0vf26fd+xsmPvzz3uJyZPPZQLTb6i056tNOPe4kBFa2yoh8waaOEpsKImE5tGph1Jj1iqUn74YD7pLQlV/Zr1H/DwGfCa9mPIV6tYZAi/axZMmf4wXRUFuyeyoqCn9KmeY38nBB/Z/AL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEFOCn6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A35C4AF1A;
	Sat,  4 May 2024 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782618;
	bh=akE5P6xvZT48f5LRQWKFAyRAluTFD6SKWbtJB6gxXDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mEFOCn6M0/9FUvNcIDMh645SuA6hG0akoQKvB+ogesqfmOVkkryzy317thFixlYaT
	 jT0pIGyWZec5FtbBb2fvSdERaUl+MA2M1GiODZsWdBqLdR2zAzt2TR1GUqAn8TgJ6c
	 jtGuzWWJ8q5/TpHhLac5Df+dU4ptxTmZiiBA1VOXmgXkQ0+5v8eSxYTuoLpj92koNh
	 aLG4yZedRRylNI0sepW39uw9NDJcJBauAHNY0kq9ZhmbPUPAQ5HWjbrP+A/QWCMhh4
	 UlFI5mCAFWYuZr40FZlblG//YUIcPds3/uSqo0HtePPOViVrumGVaDLsbMz2j7riB+
	 zH166DwWwqaVw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	gregkh@linuxfoundation.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 3/5] tools: sync uapi/linux/fs.h header into tools subdir
Date: Fri,  3 May 2024 17:30:04 -0700
Message-ID: <20240504003006.3303334-4-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504003006.3303334-1-andrii@kernel.org>
References: <20240504003006.3303334-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep them in sync for use from BPF selftests.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 .../perf/trace/beauty/include/uapi/linux/fs.h | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fs.h b/tools/perf/trace/beauty/include/uapi/linux/fs.h
index 45e4e64fd664..fe8924a8d916 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fs.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fs.h
@@ -393,4 +393,36 @@ struct pm_scan_arg {
 	__u64 return_mask;
 };
 
+/* /proc/<pid>/maps ioctl */
+#define PROCFS_IOCTL_MAGIC 0x9f
+#define PROCFS_PROCMAP_QUERY	_IOWR(PROCFS_IOCTL_MAGIC, 1, struct procfs_procmap_query)
+
+enum procmap_query_flags {
+	PROCFS_PROCMAP_EXACT_OR_NEXT_VMA = 0x01,
+};
+
+enum procmap_vma_flags {
+	PROCFS_PROCMAP_VMA_READABLE = 0x01,
+	PROCFS_PROCMAP_VMA_WRITABLE = 0x02,
+	PROCFS_PROCMAP_VMA_EXECUTABLE = 0x04,
+	PROCFS_PROCMAP_VMA_SHARED = 0x08,
+};
+
+struct procfs_procmap_query {
+	__u64 size;
+	__u64 query_flags;		/* in */
+	__u64 query_addr;		/* in */
+	__u64 vma_start;		/* out */
+	__u64 vma_end;			/* out */
+	__u64 vma_flags;		/* out */
+	__u64 vma_offset;		/* out */
+	__u64 inode;			/* out */
+	__u32 dev_major;		/* out */
+	__u32 dev_minor;		/* out */
+	__u32 vma_name_size;		/* in/out */
+	__u32 build_id_size;		/* in/out */
+	__u64 vma_name_addr;		/* in */
+	__u64 build_id_addr;		/* in */
+};
+
 #endif /* _UAPI_LINUX_FS_H */
-- 
2.43.0


