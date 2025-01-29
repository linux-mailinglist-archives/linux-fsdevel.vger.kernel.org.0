Return-Path: <linux-fsdevel+bounces-40267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F072DA2157B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9F6164D3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 00:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D01552FD;
	Wed, 29 Jan 2025 00:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMQr51eX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475543166;
	Wed, 29 Jan 2025 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109874; cv=none; b=dZyGBqsguICjf5ZNLZb00t/5eVp19xx4OhqE/kSwUYjlQwRT5OdIZt5C5qu/e5e7j4fATk11R4K5i0KfLq1tyrl+j5P/2/nl5Fl4vzZFI5oB4XUI2KhtmxCqO/16NwbGZ2l+o5SoaTwhxQ9jOFYSBArl71BmMrsB/6bRWjbgmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109874; c=relaxed/simple;
	bh=rhcPxDE/hGrU4tf9/2EyzDn71kVa3O0+HXsB6rQX/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aVnzb/G+R1Tq+yka/FC6aHwL6U/OWLeK8280Xwwrrfjkky4JL3j348TPiCFl09auNOIFF8e+XGz9ZQWhdKFK/G7v+wAcTdHpwHQOMGCQ8QLXXW0qV7rsL4wRFEGdUyj0gC/tVuCFkmfjcX5CyW1xu7UmcJcst8oWAnQuZrwbnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMQr51eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF80C4CED3;
	Wed, 29 Jan 2025 00:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738109874;
	bh=rhcPxDE/hGrU4tf9/2EyzDn71kVa3O0+HXsB6rQX/xg=;
	h=From:To:Cc:Subject:Date:From;
	b=XMQr51eXkbgeqEBNx86SM3BNnHtKhdZ+DwW0CQw3KFQaBJU4p+Xa/y4x+vBGlceeM
	 J8T/UOk/6HEc6WyfirILBWGMo/CidLMIuS/xexztcRoWWEtQNmQUHwRfVNuGJ6c2mk
	 ebLST4lm8SjTzlGN5/d4TE5OW1pnRPVn1+L1VCOelReXoCWC+tPyLieXsFo1soWERW
	 rBy6NjICdHHW8f6yVqVzWn8fgdhOpd/1YZQbmzOEYoz7YgvuKb8GrCiqBLsb130PUe
	 MJXcGsFpKLnYoOd6jUFngLM5O+hh5dVbLmGpqzVg68ot6KJamoPW9CRdVpFjkk7T1p
	 JtL10Th6zOpwA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	peterz@infradead.org,
	mingo@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	shakeel.butt@linux.dev,
	rppt@kernel.org,
	liam.howlett@oracle.com,
	surenb@google.com,
	kees@kernel.org,
	jannh@google.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] docs,procfs: document /proc/PID/* access permission checks
Date: Tue, 28 Jan 2025 16:17:47 -0800
Message-ID: <20250129001747.759990-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a paragraph explaining what sort of capabilities a process would
need to read procfs data for some other process. Also mention that
reading data for its own process doesn't require any extra permissions.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 Documentation/filesystems/proc.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 09f0aed5a08b..0e7825bb1e3a 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -128,6 +128,16 @@ process running on the system, which is named after the process ID (PID).
 The link  'self'  points to  the process reading the file system. Each process
 subdirectory has the entries listed in Table 1-1.
 
+A process can read its own information from /proc/PID/* with no extra
+permissions. When reading /proc/PID/* information for other processes, reading
+process is required to have either CAP_SYS_PTRACE capability with
+PTRACE_MODE_READ access permissions, or, alternatively, CAP_PERFMON
+capability. This applies to all read-only information like `maps`, `environ`,
+`pagemap`, etc. The only exception is `mem` file due to its read-write nature,
+which requires CAP_SYS_PTRACE capabilities with more elevated
+PTRACE_MODE_ATTACH permissions; CAP_PERFMON capability does not grant access
+to /proc/PID/mem for other processes.
+
 Note that an open file descriptor to /proc/<pid> or to any of its
 contained files or subdirectories does not prevent <pid> being reused
 for some other process in the event that <pid> exits. Operations on
-- 
2.43.5


