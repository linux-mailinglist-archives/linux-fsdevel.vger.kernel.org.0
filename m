Return-Path: <linux-fsdevel+bounces-71884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F9CD7650
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 23:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D0D53055B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 22:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54FF33F8B8;
	Mon, 22 Dec 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhDIAIHy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC6432E72B;
	Mon, 22 Dec 2025 22:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766444242; cv=none; b=HLdVrfFW0bghSCJUPYRrz0wW7L0yytl0AKtGFwTP2dG742u4dscCmghie1xyEUVz9Z4geNC3pbD4jJ4OFrngI0vAeghwKTBDIZV4LdfsUAOX3cug8wMQ3LeDvOSHlyuVdcO912Cvi0fKwTKsvaCB5YwEE7QmUEA31bhJRwA4MSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766444242; c=relaxed/simple;
	bh=49MnGzZAQYqcyLlxZKydO8rdk9ZLuuAGgmq+qGPMu68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+oCIm3ukxZB+wWLzKcPnY3/24OPBfhFmKiiCxMnXE3fqvOOr6zlSneOlVfIsbDb/5vf2xwCEppTskJVOW+/Ary/q5oZQgmVPff0u6fF1mMEgpyh8voApZ3eGBUEFK6vptW2HfxemsDE6OwbyfzwcO9uvy1l7KhbQhID+175XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhDIAIHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57634C19421;
	Mon, 22 Dec 2025 22:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766444241;
	bh=49MnGzZAQYqcyLlxZKydO8rdk9ZLuuAGgmq+qGPMu68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhDIAIHyowlMyaMKSCZwqh+Oc+vHFYCUiCiD1KqDUvzKB8WWhqi8nndOE98azx3sg
	 d/kohivM5Z96B/DRHSBEGtxs8U1OtqiHH55gUIzGsaItzFAWOpjUJGszvOtQBTJZKh
	 qzfB2utYoEsKx9ihRbKxZSznrUjNX9ZNhxHbPDABF92RuUYsAkI3ZtZOGGT6qHVjdR
	 U6duuikWoRHGy1wKXrnVX1ru6c/3FQNBh3wvNSeH9M9dLmJs/aItyuXlrW5hL8t2PG
	 RbFMqPdOzq71QSRZNu70g70X7Il/JmDe1Y4KzvoxyMlucwuO8OWS9xti3BTML844Qn
	 ZTAtVz62hzLxg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/11] tools headers: Sync UAPI linux/fcntl.h with kernel sources
Date: Mon, 22 Dec 2025 14:57:08 -0800
Message-ID: <20251222225716.3565649-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
In-Reply-To: <20251222225716.3565649-1-namhyung@kernel.org>
References: <20251222225716.3565649-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up changes from:

  fe93446b5ebdaa89 ("vfs: use UAPI types for new struct delegation definition")
  4be9e04ebf75a5c4 ("vfs: add needed headers for new struct delegation definition")
  1602bad16d7df82f ("vfs: expose delegation support to userland")

This should be used to beautify fcntl syscall arguments and it addresses
these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/README.kernel-copies.

Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index 3741ea1b73d85000..aadfbf6e0cb3a004 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -4,6 +4,7 @@
 
 #include <asm/fcntl.h>
 #include <linux/openat2.h>
+#include <linux/types.h>
 
 #define F_SETLEASE	(F_LINUX_SPECIFIC_BASE + 0)
 #define F_GETLEASE	(F_LINUX_SPECIFIC_BASE + 1)
@@ -79,6 +80,17 @@
  */
 #define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
 
+/* Set/Get delegations */
+#define F_GETDELEG		(F_LINUX_SPECIFIC_BASE + 15)
+#define F_SETDELEG		(F_LINUX_SPECIFIC_BASE + 16)
+
+/* Argument structure for F_GETDELEG and F_SETDELEG */
+struct delegation {
+	__u32	d_flags;	/* Must be 0 */
+	__u16	d_type;		/* F_RDLCK, F_WRLCK, F_UNLCK */
+	__u16	__pad;		/* Must be 0 */
+};
+
 /*
  * Types of directory notifications that may be requested.
  */
-- 
2.52.0.351.gbe84eed79e-goog


