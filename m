Return-Path: <linux-fsdevel+bounces-59143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9926EB34EB2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 00:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99EB1B23B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 22:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BD9303C81;
	Mon, 25 Aug 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqFyfybE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B922FE58D;
	Mon, 25 Aug 2025 21:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159151; cv=none; b=YaZeiQKarfZ42QUCyEfltf01Ugv7knT4Du484kHSv+iLsXOcNf+UWO2cTHGJiWVoBsWegcNcjMVwwXTgoIc9+cGmmzrsq/yIkSyJCmV6ByoE4Kb9KWh89NnLFH/5gVwD5Y2FbcHDSoArMuKLAXVWt0yKJpDijdg5bA8UR1DIpMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159151; c=relaxed/simple;
	bh=nVCrffrR+DUX0JkeKJS/+8PysmYnJ/7dUNKSEtKrCoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dA+WhcGB2Xjvm8wzcIXrHZXmfZej0jQT3NoSn5JRGfGxS7yMt/JwHpkfRUCvRAKyqc9w44VzOO3jGJhJ7RbMHEjS9wdQ9DA7T0UgP8ySRDBi7KKQJRy0rolRJlX7sgGP7rx5tppoJnocgHv9LaJuEu72FTCHPC3LmCoHWmPLLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqFyfybE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28856C2BC86;
	Mon, 25 Aug 2025 21:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159151;
	bh=nVCrffrR+DUX0JkeKJS/+8PysmYnJ/7dUNKSEtKrCoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kqFyfybE6YrJtV+sQ+pU5uNwmRKtogdDT2PMTX8N6GNgDYAwYHjNyv1IRn6qXN8kU
	 MjeD73au5c18Q7Eqi4WYtaqZ7Fi7fWWplc4A9T8K07y2Rhx5Vry4odu+eyv4NW8pvh
	 cHsqYe2RFZ3ZJIYO3+o0zRpQ36GgiTt8zycxRm2/lk0bbJfRHyCrkf821r6icKOes2
	 2Gwr3RCeDENFvqjzk+B29r761X0sZXQdgPX6APFA5VDABqhmLWugSGM8zE8Z7n7kS8
	 v/oiKt+dockBoReLqhR4kAtu0M/K0VCxVKvetSMX2vYVJQutbw4FWj63pwnRnYyhim
	 YAeT6/vY2bYAg==
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] tools headers: Sync uapi/linux/fcntl.h with the kernel source
Date: Mon, 25 Aug 2025 14:59:00 -0700
Message-ID: <20250825215904.2594216-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  3941e37f62fe2c3c uapi/fcntl: add FD_PIDFS_ROOT
  cd5d2006327b6d84 uapi/fcntl: add FD_INVALID
  67fcec2919e4ed31 fcntl/pidfd: redefine PIDFD_SELF_THREAD_GROUP
  a4c746f06853f91d uapi/fcntl: mark range as reserved

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/perf/trace/beauty/include/uapi/linux/fcntl.h include/uapi/linux/fcntl.h

Please see tools/include/uapi/README for further details.

Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 .../trace/beauty/include/uapi/linux/fcntl.h    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index a15ac2fa4b202fa0..f291ab4f94ebccac 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -90,10 +90,28 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+/* Reserved kernel ranges [-100], [-10000, -40000]. */
 #define AT_FDCWD		-100    /* Special value for dirfd used to
 					   indicate openat should use the
 					   current working directory. */
 
+/*
+ * The concept of process and threads in userland and the kernel is a confusing
+ * one - within the kernel every thread is a 'task' with its own individual PID,
+ * however from userland's point of view threads are grouped by a single PID,
+ * which is that of the 'thread group leader', typically the first thread
+ * spawned.
+ *
+ * To cut the Gideon knot, for internal kernel usage, we refer to
+ * PIDFD_SELF_THREAD to refer to the current thread (or task from a kernel
+ * perspective), and PIDFD_SELF_THREAD_GROUP to refer to the current thread
+ * group leader...
+ */
+#define PIDFD_SELF_THREAD		-10000 /* Current thread. */
+#define PIDFD_SELF_THREAD_GROUP		-10001 /* Current thread group leader. */
+
+#define FD_PIDFS_ROOT			-10002 /* Root of the pidfs filesystem */
+#define FD_INVALID			-10009 /* Invalid file descriptor: -10000 - EBADF = -10009 */
 
 /* Generic flags for the *at(2) family of syscalls. */
 
-- 
2.51.0.261.g7ce5a0a67e-goog


