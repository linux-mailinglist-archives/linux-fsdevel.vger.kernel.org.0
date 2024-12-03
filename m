Return-Path: <linux-fsdevel+bounces-36303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0F9E121D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 04:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED8B2829D6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 03:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3D1D4348;
	Tue,  3 Dec 2024 03:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPQS33jM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE61B3959;
	Tue,  3 Dec 2024 03:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733198037; cv=none; b=Cjxny0RTTkBENYooWqEKzM7Q3TgVussMuXCXzjCeTfFc0zTJiXYIRAoQilSQYCbaHAfOObFQ2i5O+L1Ex3MELMqnigbp7WJyQdXFmLH910zToa3M1Zs24GX9beYncvHaR8FQBEdESmY1lhO7QhvwQqTtFjJVKPtoOkU2wKr5IAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733198037; c=relaxed/simple;
	bh=BQm/1aP/K8xvjEddkH1/orrgM/dsPMVCSgObmtMyX8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTMhQL9eFkrMAgfkek0YkgKWO6Pu8FWoRNMb+3RsVoFw+DJqTvEFnDswUNkydB2Tl1EumC/JxdT7erDHNDLKJwgET7cuSUDzFZPyl4/DnBYQ9eGv9ViDRfizamrMES0zRyey/SF9PNeSUHtvm3mKVqGjGy5/wvJUo6QKmoFxKU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPQS33jM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2521DC4CEE3;
	Tue,  3 Dec 2024 03:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733198037;
	bh=BQm/1aP/K8xvjEddkH1/orrgM/dsPMVCSgObmtMyX8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IPQS33jM0NIJL+o45Z8vwy4uo23P0YfyCHf+fV/dkterpOJglAFiJZ0VIUWd0fMHT
	 8Nz1JsMVOq+jXyKCamqLy90zKm1LAwd7sU1Qu+jMCg7pK94nALz2jYr0LrNc+1V6uv
	 fsSRyZ+PxY3LMUKpqQuHrd9D6ppdq/NOrI5WAqf/UWAmceFtw9jIijUexEv2/dlDDE
	 pSNcQxpcI4ou2vMBppcEHZjilroM+DWBjXN89McaVYq02xkCP5g2s4pFrYWZNExGtK
	 mXQXj4XeWBEjpCU36r2vP0iZP5kRaI4l5M5TCFr42MAD/rlB2UrSLHn3WFuoSckhvF
	 m+Zb7Uz2GdNGQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/11] tools headers: Sync uapi/linux/mount.h with the kernel sources
Date: Mon,  2 Dec 2024 19:53:47 -0800
Message-ID: <20241203035349.1901262-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241203035349.1901262-1-namhyung@kernel.org>
References: <20241203035349.1901262-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  aefff51e1c2986e1 statmount: retrieve security mount options
  2f4d4503e9e5ab76 statmount: add flag to retrieve unescaped options
  44010543fc8bedad fs: add the ability for statmount() to report the sb_source
  ed9d95f691c29748 fs: add the ability for statmount() to report the fs_subtype

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/mount.h include/uapi/linux/mount.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/mount.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/mount.h b/tools/perf/trace/beauty/include/uapi/linux/mount.h
index 225bc366ffcbf031..c07008816acae89c 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/mount.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/mount.h
@@ -154,7 +154,7 @@ struct mount_attr {
  */
 struct statmount {
 	__u32 size;		/* Total size, including strings */
-	__u32 mnt_opts;		/* [str] Mount options of the mount */
+	__u32 mnt_opts;		/* [str] Options (comma separated, escaped) */
 	__u64 mask;		/* What results were written */
 	__u32 sb_dev_major;	/* Device ID */
 	__u32 sb_dev_minor;
@@ -173,7 +173,13 @@ struct statmount {
 	__u32 mnt_root;		/* [str] Root of mount relative to root of fs */
 	__u32 mnt_point;	/* [str] Mountpoint relative to current root */
 	__u64 mnt_ns_id;	/* ID of the mount namespace */
-	__u64 __spare2[49];
+	__u32 fs_subtype;	/* [str] Subtype of fs_type (if any) */
+	__u32 sb_source;	/* [str] Source string of the mount */
+	__u32 opt_num;		/* Number of fs options */
+	__u32 opt_array;	/* [str] Array of nul terminated fs options */
+	__u32 opt_sec_num;	/* Number of security options */
+	__u32 opt_sec_array;	/* [str] Array of nul terminated security options */
+	__u64 __spare2[46];
 	char str[];		/* Variable size part containing strings */
 };
 
@@ -207,6 +213,10 @@ struct mnt_id_req {
 #define STATMOUNT_FS_TYPE		0x00000020U	/* Want/got fs_type */
 #define STATMOUNT_MNT_NS_ID		0x00000040U	/* Want/got mnt_ns_id */
 #define STATMOUNT_MNT_OPTS		0x00000080U	/* Want/got mnt_opts */
+#define STATMOUNT_FS_SUBTYPE		0x00000100U	/* Want/got fs_subtype */
+#define STATMOUNT_SB_SOURCE		0x00000200U	/* Want/got sb_source */
+#define STATMOUNT_OPT_ARRAY		0x00000400U	/* Want/got opt_... */
+#define STATMOUNT_OPT_SEC_ARRAY		0x00000800U	/* Want/got opt_sec... */
 
 /*
  * Special @mnt_id values that can be passed to listmount
-- 
2.47.0.338.g60cca15819-goog


