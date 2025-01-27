Return-Path: <linux-fsdevel+bounces-40164-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054DAA2007E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 23:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439291886452
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2025 22:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE521DE3D5;
	Mon, 27 Jan 2025 22:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ss76KQYx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF551DE3B8;
	Mon, 27 Jan 2025 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738016481; cv=none; b=mjXsjb272ly2q4oCccqW2PXtWOyobWuVCmeogxJU8Ex6TBur9TIpYUjIBkO/847Mo+UVgfEkND9e3W8bHHYKwlt4ABLmwt4bbSP5F3t6e4JCd0N5fCuPOWBmbGDCQagbemLaIE5+KKme3vwbo0MlJJd46JYnIfnjVgUrd2Sv5nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738016481; c=relaxed/simple;
	bh=4xM5GmrbIafh9OA6F7trKBrxUqS4abqgi5jrfUGrN+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kLpEF8Ht+ath8lPZ0CHckup+IlQNl5OvbSRiRltFjv8rGunampzcy5zdV+0HbGuxYqTe0qDguKViFpIG+7tYrvunNguD9TZO+Gw7fSMUc8JUS6MwC9sdIfQG5Ho9/Iux1EIv4h+0zjoGXwAP5AxeiIut9HWtXDl86eTN3H+4nw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ss76KQYx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF70C4CED2;
	Mon, 27 Jan 2025 22:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738016480;
	bh=4xM5GmrbIafh9OA6F7trKBrxUqS4abqgi5jrfUGrN+I=;
	h=From:To:Cc:Subject:Date:From;
	b=ss76KQYxKiJDlvPPDR6Fjv7j8LneXb5twX0eVkpvtfMQcn3u8Fk2USj+AWBlxvy40
	 5fqoq7WNxVCgLaYJcMah0hDgLHk8SsIliRDvkxFKbtesq0AdkaTxGGR8ifwMAY6VgR
	 6S+mrTCJBJSCEUQcoW6rkupbS5x6cXORTO4uFXXxL77TaaQp2YhU5gUpK0Frdy5sTh
	 XSh3NtAArjkOisx/HnJhRcwod3lqbTPUDvCyxhMXw78m3hI+rNASZjBBSey1PW+MJT
	 kFct/KLU+p5zirffmabFZ3Tm+vHHm+cnfKieCVGqP3ya6pwI4jPt/pDwTFBMYJYK4y
	 zxZZv3UlsmayQ==
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
Subject: [PATCH v2] mm,procfs: allow read-only remote mm access under CAP_PERFMON
Date: Mon, 27 Jan 2025 14:21:14 -0800
Message-ID: <20250127222114.1132392-1-andrii@kernel.org>
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
permitted by CAP_PERFMON. So /proc/PID/mem, which uses
PTRACE_MODE_ATTACH, won't be permitted by CAP_PERFMON, but
/proc/PID/maps, /proc/PID/environ, and a bunch of other read-only
contents will be allowable under CAP_PERFMON.

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
v1->v2:
  - expanded commit message a bit more about PTRACE_MODE_ATTACH vs
    PTRACE_MODE_READ uses inside procfs; left the generic logic untouched, as
    it still seems generally meaningful to allow CAP_PERFMON for read-only
    memory access, given its use within perf and BPF subsystems;
  - moved perfmon_capable() check after ptrace_may_access() to minimize the
    worry of extra audit messages where CAP_SYS_PTRACE would be provided
    (Christian);
  - s/can/may/_access_mm rename (Kees);

 kernel/fork.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ded49f18cd95..452018f752a1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1547,6 +1547,17 @@ struct mm_struct *get_task_mm(struct task_struct *task)
 }
 EXPORT_SYMBOL_GPL(get_task_mm);
 
+static bool may_access_mm(struct mm_struct *mm, struct task_struct *task, unsigned int mode)
+{
+	if (mm == current->mm)
+		return true;
+	if (ptrace_may_access(task, mode))
+		return true;
+	if ((mode & PTRACE_MODE_READ) && perfmon_capable())
+		return true;
+	return false;
+}
+
 struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 {
 	struct mm_struct *mm;
@@ -1559,7 +1570,7 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 	mm = get_task_mm(task);
 	if (!mm) {
 		mm = ERR_PTR(-ESRCH);
-	} else if (mm != current->mm && !ptrace_may_access(task, mode)) {
+	} else if (!may_access_mm(mm, task, mode)) {
 		mmput(mm);
 		mm = ERR_PTR(-EACCES);
 	}
-- 
2.43.5


