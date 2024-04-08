Return-Path: <linux-fsdevel+bounces-16381-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E7B89CC05
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 20:55:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573791F224CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 18:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7CA145B03;
	Mon,  8 Apr 2024 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLIurUuQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10217144D39;
	Mon,  8 Apr 2024 18:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602523; cv=none; b=jQGKnXWKCWNAcnd1HLOmjl0O2sB2jtMH92hugBwqPgDNOS8GiNFZDxr+EkR5Kb0K5L7s8H2cQ2EDuwp2oWe/IboWYOtk/ca4WMm33iR1LiHqiowDSztnycgmC2TsuJmUj64JFAuagEAQBlMyowVWl38o4qyZin4SxwgcP1E0PV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602523; c=relaxed/simple;
	bh=tt1/IV9C6HBXt5HFZSl7RGB222B9JeY1+mENtOZxr5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNV9NHXxa2FUnChwCrXjEod4AxKe6CzSYPhMiS0ywjXT+GHF2H+FDscZrL3TPGiARH8AjBOTt8U+cxkaBBXPim7KZeB/qX5YdmPTj1NBk9OwfcHVu9teUmUnh7TvJAfK51bnL4k9vfvPmwluqCgIEmx6LjTGrj5QmkpklxhdqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLIurUuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32010C433B2;
	Mon,  8 Apr 2024 18:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602522;
	bh=tt1/IV9C6HBXt5HFZSl7RGB222B9JeY1+mENtOZxr5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SLIurUuQxEdN2QbKoiSrZtt8sL9C7GmIQaqz+ILBdDmANZbmFrUw3XtvHiCYGZEuP
	 t1HzB1TsgEbp2spEkqQ9GsLnLH385bNx134gdhwKWuNl5UBkgne/tV7fuutI3hQAXl
	 2nyPN7yiRlJH7TD1Y1rJXzQaJlQZMrwuzMA69bCAhXF6DVvpaaXbtDLUILsT6xPSic
	 YbDFiCawTzWGhP2Y0u19AxEMCTMvLstbUSy8QHuYewUiEcZT8j9ucdCi3GL606jb8e
	 zfikxB02PjpLSv8RDe3MzuW5ahaqbXg9bZCGpK8Qxo4xTJ5LUfi/K6hyaR1NpiNQIp
	 vXkSBV2HK05Yg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] tools/include: Sync uapi/linux/fs.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:13 -0700
Message-ID: <20240408185520.1550865-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  41bcbe59c3b3f ("fs: FS_IOC_GETUUID")
  ae8c511757304 ("fs: add FS_IOC_GETFSSYSFSPATH")
  73fa7547c70b3 ("vfs: add RWF_NOAPPEND flag for pwritev2")

This should be used to beautify fs syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/include/uapi/linux/fs.h | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 48ad69f7722e..45e4e64fd664 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -64,6 +64,24 @@ struct fstrim_range {
 	__u64 minlen;
 };
 
+/*
+ * We include a length field because some filesystems (vfat) have an identifier
+ * that we do want to expose as a UUID, but doesn't have the standard length.
+ *
+ * We use a fixed size buffer beacuse this interface will, by fiat, never
+ * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
+ * users to have to deal with that.
+ */
+struct fsuuid2 {
+	__u8	len;
+	__u8	uuid[16];
+};
+
+struct fs_sysfs_path {
+	__u8			len;
+	__u8			name[128];
+};
+
 /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
 #define FILE_DEDUPE_RANGE_SAME		0
 #define FILE_DEDUPE_RANGE_DIFFERS	1
@@ -215,6 +233,13 @@ struct fsxattr {
 #define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
 #define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
+/* Returns the external filesystem UUID, the same one blkid returns */
+#define FS_IOC_GETFSUUID		_IOR(0x15, 0, struct fsuuid2)
+/*
+ * Returns the path component under /sys/fs/ that refers to this filesystem;
+ * also /sys/kernel/debug/ for filesystems with debugfs exports
+ */
+#define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
 
 /*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
@@ -301,9 +326,12 @@ typedef int __bitwise __kernel_rwf_t;
 /* per-IO O_APPEND */
 #define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
 
+/* per-IO negation of O_APPEND */
+#define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND)
+			 RWF_APPEND | RWF_NOAPPEND)
 
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
-- 
2.44.0.478.gd926399ef9-goog


