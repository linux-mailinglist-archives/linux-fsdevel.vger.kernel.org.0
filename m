Return-Path: <linux-fsdevel+bounces-40010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7677A1AC07
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 22:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9028E7A4913
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 21:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF321CB501;
	Thu, 23 Jan 2025 21:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGRqBL/k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920548BF8;
	Thu, 23 Jan 2025 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737668649; cv=none; b=kt6zFM0IPU1mWfvCqXNncZMrOPU2Zc1nFB1QJ0CNh/NBH0zEgzgYiR5WhTcycg5D1KAeLLwbl3JXaq7ot7mD78ddPQw3nucfl2Wd7gV5v2CGLuN3sjIAwBa8HtJKKTcgKGGgfwxkGVdpV1NZln3jywrbOdvKyIe2E99n4bnlaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737668649; c=relaxed/simple;
	bh=R85lw46lWbNKwIBjKcm0nPFbL7eV+3oJagH3JDMENic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmOzlUL+nMs1z3CX5+CqVBCHaKTrNa5NnxmehW3TRs541HS/QvIkaPURBtylpc71IlpSY4HzBaKW9TgrfdJWultNGano/OE4IOnFAsKjt/YcMSjEfT9G1K1ukuBbaT/zLlsS9EKOkvhdMlAhn/4ipbZ+10X35NiGSf67tD/PKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGRqBL/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7964C4CED3;
	Thu, 23 Jan 2025 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737668649;
	bh=R85lw46lWbNKwIBjKcm0nPFbL7eV+3oJagH3JDMENic=;
	h=From:To:Cc:Subject:Date:From;
	b=YGRqBL/k5NSeLv2lvBxmXoUTbvMhc5e4DucR0zIIXXpZFHcApqrD7CdjkV+WKfdaf
	 p2RVk4P34gOSLzAF/ndbuuV96NKi4UGLY239QVETaMRmPUNn3U+Uv5dGzWCMbQ5s82
	 3Z9rPxzLgfzke5hOz6pEYBGcTH5Sl1bZdl/aV+o8gfDyHvcvt2UHD+OmVWd7DnVH+Q
	 fsA4ZqaQd3a14N3G/FLqZOh3XpGZTvxnAi+rMwaGyyVP1Rs1bnghl44oBtyGXU1/N0
	 wi/KdZ3+ORlGxlaFejSGFmNzobtElNImr+HEhoXeIOdnzNp4QaqnmomxFK2mardbjO
	 NDcTnul24Y0lQ==
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
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
Date: Thu, 23 Jan 2025 13:43:42 -0800
Message-ID: <20250123214342.4145818-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's very common for various tracing and profiling toolis to need to
access /proc/PID/maps contents for stack symbolization needs to learn
which shared libraries are mapped in memory, at which file offset, etc.
Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
are looking at data for our own process, which is a trivial case not too
relevant for profilers use cases).

Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
discover memory layout of another process: it allows to fully control
arbitrary other processes. This is problematic from security POV for
applications that only need read-only /proc/PID/maps (and other similar
read-only data) access, and in large production settings CAP_SYS_PTRACE
is frowned upon even for the system-wide profilers.

On the other hand, it's already possible to access similar kind of
information (and more) with just CAP_PERFMON capability. E.g., setting
up PERF_RECORD_MMAP collection through perf_event_open() would give one
similar information to what /proc/PID/maps provides.

CAP_PERFMON, together with CAP_BPF, is already a very common combination
for system-wide profiling and observability application. As such, it's
reasonable and convenient to be able to access /proc/PID/maps with
CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.

For procfs, these permissions are checked through common mm_access()
helper, and so we augment that with cap_perfmon() check *only* if
requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
permitted by CAP_PERFMON.

Besides procfs itself, mm_access() is used by process_madvise() and
process_vm_{readv,writev}() syscalls. The former one uses
PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
seems like a meaningful allowable capability as well.

process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
permissions (though for readv PTRACE_MODE_READ seems more reasonable,
but that's outside the scope of this change), and as such won't be
affected by this patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/fork.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ded49f18cd95..c57cb3ad9931 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 }
 EXPORT_SYMBOL_GPL(get_task_mm);
 
+static bool can_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
+{
+	if (mm == current->mm)
+		return true;
+	if ((mode & PTRACE_MODE_READ) && perfmon_capable())
+		return true;
+	return ptrace_may_access(task, mode);
+}
+
 struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 {
 	struct mm_struct *mm;
@@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 	mm = get_task_mm(task);
 	if (!mm) {
 		mm = ERR_PTR(-ESRCH);
-	} else if (mm != current->mm && !ptrace_may_access(task, mode)) {
+	} else if (!can_access_mm(mm, task, mode)) {
 		mmput(mm);
 		mm = ERR_PTR(-EACCES);
 	}
-- 
2.43.5


