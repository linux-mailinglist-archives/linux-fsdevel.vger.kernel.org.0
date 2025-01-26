Return-Path: <linux-fsdevel+bounces-40127-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 413EAA1C8A0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 15:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890E3166259
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEC419D080;
	Sun, 26 Jan 2025 14:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENg3tkJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41BA15E5D4;
	Sun, 26 Jan 2025 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902951; cv=none; b=QSBr/Rsyo+W3GDrIqMCQYleVFBmT9dwgfW0AQZB0n5xd/5WDpxErxk2dcXqrBrn0RM7Drp6MOz8ozkGr9Vl3Ba/prfy0Tk6PD2cU9NkAQtqpseY5fFXYqEvyqv4eOSDk2abwX/nSB29bvTs/v2pmno9H3T42KB3MrFI4ZXmR60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902951; c=relaxed/simple;
	bh=zhtN49e0yQxVBN/iIZ28eZPRpCySibQixtPUROJQi0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIVfQWUdBEtxW1ZrNv9GYcqDvVaQuW8hxPqfbNIx2Vn9IrKNnbsoNT7YpMH91h9R3S0HE/pAsvcZMaQs3RPko75MCGKZcYTeFFKKaYWV9pMjceK8Z7OrgOpBUL09ZRqzuHNVR4WQUJKYt1zxf8IF8YiXjPFU+wsdIMs/hFG1nrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENg3tkJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1D7C4CEE2;
	Sun, 26 Jan 2025 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902951;
	bh=zhtN49e0yQxVBN/iIZ28eZPRpCySibQixtPUROJQi0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ENg3tkJkpvMbDswfjoWUb5MDsBW/k1K5QgBVxQOpGzOJewLzDAHzurQatbuWf/tB4
	 n1nTDE0mVrlcuaCvsEdKgicr+1EvJJ5ZHtJyO8iGi/GQtLoFLHArfhhL2VwhxDyGWK
	 EuJneKKWU7BgJhG1j2B37N0K/gF8EcsjvX84Aetkb/jTRzZmMK+PaFxR1gnXvaDqwf
	 jJJMy5FnW6/zjs/mCHHm1j4krlCFnrSKTcsd8ALMrh8K4DV5SyWH/2JTzTr1CMnGW7
	 WKQdRyuJ7vKNwRMNVRyoqvIV+H8yhPXZRDdl70bsuCqbpHxyIixWNetjoDQ2vfCeYo
	 tXHT6RO6eMuJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Tycho Andersen <tandersen@netflix.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.6 2/5] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Sun, 26 Jan 2025 09:49:03 -0500
Message-Id: <20250126144906.925468-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144906.925468-1-sashal@kernel.org>
References: <20250126144906.925468-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees@kernel.org>

[ Upstream commit 543841d1806029889c2f69f040e88b247aba8e22 ]

Zbigniew mentioned at Linux Plumber's that systemd is interested in
switching to execveat() for service execution, but can't, because the
contents of /proc/pid/comm are the file descriptor which was used,
instead of the path to the binary[1]. This makes the output of tools like
top and ps useless, especially in a world where most fds are opened
CLOEXEC so the number is truly meaningless.

When the filename passed in is empty (e.g. with AT_EMPTY_PATH), use the
dentry's filename for "comm" instead of using the useless numeral from
the synthetic fdpath construction. This way the actual exec machinery
is unchanged, but cosmetically the comm looks reasonable to admins
investigating things.

Instead of adding TASK_COMM_LEN more bytes to bprm, use one of the unused
flag bits to indicate that we need to set "comm" from the dentry.

Suggested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
Suggested-by: Tycho Andersen <tandersen@netflix.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec [1]
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Tested-by: Zbigniew Jędrzejewski-Szmek <zbyszek@in.waw.pl>
Signed-off-by: Kees Cook <kees@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exec.c               | 29 ++++++++++++++++++++++++++---
 include/linux/binfmts.h |  4 +++-
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 7776209d98c10..4a6255aa4ea7f 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1362,7 +1362,28 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If the original filename was empty, alloc_bprm() made up a path
+	 * that will probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->comm_from_dentry) {
+		/*
+		 * Hold RCU lock to keep the name from being freed behind our back.
+		 * Use acquire semantics to make sure the terminating NUL from
+		 * __d_alloc() is seen.
+		 *
+		 * Note, we're deliberately sloppy here. We don't need to care about
+		 * detecting a concurrent rename and just want a terminated name.
+		 */
+		rcu_read_lock();
+		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+				true);
+		rcu_read_unlock();
+	} else {
+		__set_task_comm(me, kbasename(bprm->filename), true);
+	}
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1521,11 +1542,13 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename)
 	if (fd == AT_FDCWD || filename->name[0] == '/') {
 		bprm->filename = filename->name;
 	} else {
-		if (filename->name[0] == '\0')
+		if (filename->name[0] == '\0') {
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d", fd);
-		else
+			bprm->comm_from_dentry = 1;
+		} else {
 			bprm->fdpath = kasprintf(GFP_KERNEL, "/dev/fd/%d/%s",
 						  fd, filename->name);
+		}
 		if (!bprm->fdpath)
 			goto out_free;
 
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 8d51f69f9f5ef..af9056d78fadf 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -42,7 +42,9 @@ struct linux_binprm {
 		 * Set when errors can no longer be returned to the
 		 * original userspace.
 		 */
-		point_of_no_return:1;
+		point_of_no_return:1,
+		/* Set when "comm" must come from the dentry. */
+		comm_from_dentry:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
-- 
2.39.5


