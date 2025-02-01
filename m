Return-Path: <linux-fsdevel+bounces-40529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445BA247C2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 09:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B73C166FCD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC05145B1B;
	Sat,  1 Feb 2025 08:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="UzG5Bsyt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DF450EE;
	Sat,  1 Feb 2025 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738398696; cv=none; b=kwaosTAHHres7dJk1bRmrWo2hMRFI7ICejvC4efU3ULfocxAfCjEQLzrRBNdzeC82j02nn+JN9tCyZS5MSZuChnSHr9dlvB58lWIrlHFchOlkhs4xGKI6AJsYwVgY9DLoluv3IYP6gMwizmu3l78fSqC/cAD0CP8LzTm6RE5o7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738398696; c=relaxed/simple;
	bh=EtORstMEP5vEDoFhnNOmFLeQbb1NNqyYFa8DuPRNgYw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Pt8E2qenjWMRMJQFBheYdxn2qleN7uJjBE8Sesm8nEkDrOLesm8w2JfLrQE1feI0in+RKo6L6zEi2p6LrVtSDiJgHt96nRmY2vzERvywl2A6/cPc+IFCLY2t8HsfXMbGpNjw5lCSaBrjL+5iDVriNcLIYQ1GaBjjyFhbFGpoghE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=UzG5Bsyt; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id 5D0731771FC; Sat,  1 Feb 2025 08:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1738398687; bh=EtORstMEP5vEDoFhnNOmFLeQbb1NNqyYFa8DuPRNgYw=;
	h=Date:From:To:Subject:From;
	b=UzG5BsytUmXG7G/2Pngkuyfo4JKYtwlyDIYVHxvrx/hLhecdW0zJc5b0i+vLGjoyz
	 pOSuR2IR2bLw8i80onDVs0Epg8ohxX+U06hLsYzhDMCF33EF8TRwRnmjZFHOdckAK4
	 0iA7u+VSzkKaCSvwy/wdUy4wj45LGDZxENUiJ1QyBpesO+w4sdWFcYtZvDSySiTohu
	 vYTytAfFHUAYu7MXF+TXA5i3JJjBxHm9JvQOGRFRzHWPeBktbqjcL83dUibAsc/PMh
	 jCWq2slRAl90b0Lb1dmbkqmNX1pJcbEk2Aejun1WHjxOyof+m958kzAcBYE3dLo3PS
	 +xhAoNqEm9Ncw==
Date: Sat, 1 Feb 2025 08:31:27 +0000
From: Nir Lichtman <nir@lichtman.org>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kees@kernel.org, ebiederm@xmission.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] exec: remove redundant save asides of old pid/vpid
Message-ID: <20250201083127.GA1185473@lichtman.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Problem: Old pid and vpid are redundantly saved aside before starting to
parse the binary, with the comment claiming that it is required since
load_binary changes it, though from inspection in the source,
load_binary does not change the pid and this wouldn't make sense since
execve does not create any new process, quote from man page of execve:
"there is no new process; many attributes of the calling process remain
unchanged (in particular, its PID)."

Solution: Remove the saving aside of both and later on use them directly
from the current object, instead of via the saved aside objects.

Signed-off-by: Nir Lichtman <nir@lichtman.org>
---

Side-note: Tested this solution with a defconfig x86_64 and an initramfs
with Busybox and confirmed to work fine.

 fs/exec.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 506cd411f4ac..6bb0a7b15f7e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1789,15 +1789,8 @@ static int search_binary_handler(struct linux_binprm *bprm)
 /* binfmt handlers will call back into begin_new_exec() on success. */
 static int exec_binprm(struct linux_binprm *bprm)
 {
-	pid_t old_pid, old_vpid;
 	int ret, depth;
 
-	/* Need to fetch pid before load_binary changes it */
-	old_pid = current->pid;
-	rcu_read_lock();
-	old_vpid = task_pid_nr_ns(current, task_active_pid_ns(current->parent));
-	rcu_read_unlock();
-
 	/* This allows 4 levels of binfmt rewrites before failing hard. */
 	for (depth = 0;; depth++) {
 		struct file *exec;
@@ -1826,8 +1819,9 @@ static int exec_binprm(struct linux_binprm *bprm)
 	}
 
 	audit_bprm(bprm);
-	trace_sched_process_exec(current, old_pid, bprm);
-	ptrace_event(PTRACE_EVENT_EXEC, old_vpid);
+	trace_sched_process_exec(current, current->pid, bprm);
+	ptrace_event(PTRACE_EVENT_EXEC,
+			task_pid_nr_ns(current, task_active_pid_ns(current->parent)));
 	proc_exec_connector(current);
 	return 0;
 }
-- 
2.39.5


