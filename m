Return-Path: <linux-fsdevel+bounces-36173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A54079DEF01
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 05:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D0D328167C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2024 04:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B16B13C67E;
	Sat, 30 Nov 2024 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQi4IFxS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9A5588B;
	Sat, 30 Nov 2024 04:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732942485; cv=none; b=oOt6RdV/7Jpp3aZm13Btqj/Lu7pl5JdVvN6poDsc9lk0lXRVtRH5LqMJ5O1mM7w95hbbT/nKGtTH9AITiYHF+eaovJYvWr4XneA3kncbRJ2xISDuHbf9fOwENv7mA3KCRXrzlY4ZhLDb5abosHkVCaImwsJ/1pNAjJbwCslojYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732942485; c=relaxed/simple;
	bh=aCxakwcfVdMumx7XBGW2MeqYuhOvg/sHlb8AzZkdy88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ho9L3jCWAQFyAmnmSO6VneXOKQ9O2Ju98rTgu2IYS9uICtVHlAkAL1zs/NhZ0dvC7SfsqTC91mBus2AcKXxRbdEv77O5Aga4zibY9ce164FlVbeF4gAqXjhaC6jcxXf4WLfHUYWGZ4OL/p+fFmcm8oUqbSyu02Mk1Uto5Ht8XIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQi4IFxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEACC4CECC;
	Sat, 30 Nov 2024 04:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732942485;
	bh=aCxakwcfVdMumx7XBGW2MeqYuhOvg/sHlb8AzZkdy88=;
	h=From:To:Cc:Subject:Date:From;
	b=qQi4IFxSpj84eyvJB1SO2yvWP13PTANMBvLiZ8PelEdeF0NJA/CnqT9wCNaoTl6TG
	 +eam9CteJ8HTHK4gfLZ9DT3wSRjuaPQB4AkyM2rFnRj8HhIq36bRO5YYKyZs7SbZlK
	 8hWH12oGk68lOJUzT+twvWyRBKUvEUv7aB89yuK8hOllLAK8CTkZKzXR0pu7OxXN22
	 9EgQ32j5UsJhl9a7hdAIcuFnS9A/gJOHwVTMAd5FLrWBWml4Ehaa/AznyNKB/SsLoL
	 keIU/dNb/zNS+K9cdGSO0zVKBGVFPOYb6YaTMt310S1pHsIaPe0aFShYtXXGr3/205
	 d7y2BW5TZlvRw==
From: Kees Cook <kees@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Tycho Andersen <tandersen@netflix.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Fri, 29 Nov 2024 20:54:38 -0800
Message-Id: <20241130045437.work.390-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3936; i=kees@kernel.org; h=from:subject:message-id; bh=aCxakwcfVdMumx7XBGW2MeqYuhOvg/sHlb8AzZkdy88=; b=owGbwMvMwCVmps19z/KJym7G02pJDOles/qCNukktoSGha36rGrq0yfNW1Y3ecvlxP4dzbqBG 0yePmbqKGVhEONikBVTZAmyc49z8XjbHu4+VxFmDisTyBAGLk4BmEi6KcNfQd7rTNpXnFf+U1hx NKfaXCSDd2tu59bq7bGdSzS+yFscYPhnNNl6pZK6wlGfA3mLUxYanj+xLFJ9z5sP8aUvw0urPUS YAQ==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Zbigniew mentioned at Linux Plumber's that systemd is interested in
switching to execveat() for service execution, but can't, because the
contents of /proc/pid/comm are the file descriptor which was used,
instead of the path to the binary. This makes the output of tools like
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
CC: Aleksa Sarai <cyphar@cyphar.com>
Link: https://github.com/uapi-group/kernel-features#set-comm-field-before-exec
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org

Here's what I've put together from the various suggestions. I didn't
want to needlessly grow bprm, so I just added a flag instead. Otherwise,
this is very similar to what Linus and Al suggested.
---
 fs/exec.c               | 22 +++++++++++++++++++---
 include/linux/binfmts.h |  4 +++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 5f16500ac325..d897d60ca5c2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1347,7 +1347,21 @@ int begin_new_exec(struct linux_binprm * bprm)
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
+		rcu_read_lock();
+		/* The dentry name won't change while we hold the rcu read lock. */
+		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
+				true);
+		rcu_read_unlock();
+	} else {
+		__set_task_comm(me, kbasename(bprm->filename), true);
+	}
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1521,11 +1535,13 @@ static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int fl
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
index e6c00e860951..3305c849abd6 100644
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
2.34.1


