Return-Path: <linux-fsdevel+bounces-40128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D975AA1C8CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 15:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B773A76FC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jan 2025 14:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BA1A0BED;
	Sun, 26 Jan 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1HbLkxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0445016F288;
	Sun, 26 Jan 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737902963; cv=none; b=DvAT5FI3UDNJr3DBXdgdsOhaJwrPQIaMZgB4oUZSI62LgvMYlw50Bvm4zveekTPXfoeSkBjF+cmQgZPfOASGAXWh12LqBmly44XlnmIKKAqC0fJSckQOpi0Yx8PbQdrgFWBIykUCINvSr+7sBkr1F0bi69H0LJ/GjhDWzbd7bEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737902963; c=relaxed/simple;
	bh=EPqnee7cbUOCvKH/WkCn+vS3lvEN/aBPimSGlOlniKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wvw/mlgynzkLKRd0on8+6o+AFXpGV6t2upYbU5NMpKrnxoReXhqIUhheeHDjfuKQ+BHDhp4fJSXDu1aCGGGzwe9csX9w19u6tKx5Q8qiYFfVXsP9Wv2haRdo2Hn+bireI7EWK4aWu+w92+brLl1xCMl36Sd82ZESk/ddfVYRf1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1HbLkxx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C37AC4CED3;
	Sun, 26 Jan 2025 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737902962;
	bh=EPqnee7cbUOCvKH/WkCn+vS3lvEN/aBPimSGlOlniKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P1HbLkxx8xcYbgUw3U45+QBkw8e9SetgG3+5SCgYte0UMCNIz9X1Ra1oB8uSs9v1x
	 5/vuCoU+rPFI5B+k4tX7WJE7VoRdxdsMT3yVybvDGE5RAGXQRoRghorB7l7CAv5chP
	 SEgF7j/Bo1ftglFu2b0AcgTtkTF6bWNmF7YfruVIRm6sQGW56Fa4v4GSAZjxJT3j1Z
	 AoHzVAjEVHoMEvKOQN0HQHIFxP0P/pMNG7gbimmv4hZSxB8n9ORp/xvfbZm93jgD8A
	 c7PSswAB3FTadQRugKgWDwbJhHlQgVefxKj3CZVV/B1HTd8NRHWPM5kAEHDw9TcWpk
	 JtPkUL16Xvl5Q==
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
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 2/4] exec: fix up /proc/pid/comm in the execveat(AT_EMPTY_PATH) case
Date: Sun, 26 Jan 2025 09:49:15 -0500
Message-Id: <20250126144918.925549-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126144918.925549-1-sashal@kernel.org>
References: <20250126144918.925549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index a42c9b8b070d7..2039414cc6621 100644
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


