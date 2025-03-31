Return-Path: <linux-fsdevel+bounces-45353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0345A767ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 16:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFEA5188AA02
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391F2147FC;
	Mon, 31 Mar 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbch4Ga9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6832147E5;
	Mon, 31 Mar 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431538; cv=none; b=k9sGR7qu3UgqTl7tz7VLj5S6borUrcuTgzCk4swrYcqsjq6jcOMJi4+TBoivHP1kaadZK5ghRyc42kP5PLUELeQO0m6TaH3WX6HwqRL6WZdgdtp7ehNyI9Kq7UxlkjXv5NKWyxWmnvutfY5mNw8UEjX3KIUwGHoRHxgBUPy2O6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431538; c=relaxed/simple;
	bh=9Fff4mIbvxYOHFyWMiniPzdkQn1qH+1iy/v7hfo72Sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGQ1qDlJ+6u+wPgMxWajnhD+/u4DMRPGxSwpQ4m68fYtA75DBN+uTnkyFlA2FrjmS4ZqKwPAUQ+m6MbDr8WECnF0wHyZOyzMwyX4hXu6kiwhfwBRh6U3ii1OTY1DehCpHYXQLqVXpddSLBpy47MBB8jkShA4YXaeyJuKViQ3K+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbch4Ga9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29544C4CEE4;
	Mon, 31 Mar 2025 14:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431537;
	bh=9Fff4mIbvxYOHFyWMiniPzdkQn1qH+1iy/v7hfo72Sg=;
	h=From:To:Cc:Subject:Date:From;
	b=sbch4Ga90yfN/8uKND7ZW1omHV+QOk3FbvwfyOiOzZb4eXazyODJqJp3aHyw4/luN
	 08hF4Dv2yyXhwh5lqEIDv0vcbR8M2V8MfoFEXH6pJUCWd2i8DPdG9RsfGoGKtxpSWA
	 ZGcoYBPnNPeOuY1njCxuW8mYPWlNGQhUDM3WPQ/y7pjsW50IQHF9IqOuCaHqLTfY78
	 kxuS1UY4h/GZy0Q9p76LtTC3yGo4BYAyD6N1NchlXDmkjjmwxAu+pvt3zR6+Jl01QM
	 kAW5/Zb4+uymMbwMIuKhY6mdq6ly/PxmxEiMMMqp1GCSBaj2tHdx3EsSDI2tgAseKu
	 2z9WQtY5/oUzw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mateusz Guzik <mjguzik@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 1/2] fs: consistently deref the files table with rcu_dereference_raw()
Date: Mon, 31 Mar 2025 10:32:13 -0400
Message-Id: <20250331143214.1667735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Mateusz Guzik <mjguzik@gmail.com>

[ Upstream commit f381640e1bd4f2de7ccafbfe8703d33c3718aad9 ]

... except when the table is known to be only used by one thread.

A file pointer can get installed at any moment despite the ->file_lock
being held since the following:
8a81252b774b53e6 ("fs/file.c: don't acquire files->file_lock in fd_install()")

Accesses subject to such a race can in principle suffer load tearing.

While here redo the comment in dup_fd -- it only covered a race against
files showing up, still assuming fd_install() takes the lock.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/r/20250313135725.1320914-1-mjguzik@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 25c6e53b03f8f..97e2a9e09b70c 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -418,17 +418,25 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	old_fds = old_fdt->fd;
 	new_fds = new_fdt->fd;
 
+	/*
+	 * We may be racing against fd allocation from other threads using this
+	 * files_struct, despite holding ->file_lock.
+	 *
+	 * alloc_fd() might have already claimed a slot, while fd_install()
+	 * did not populate it yet. Note the latter operates locklessly, so
+	 * the file can show up as we are walking the array below.
+	 *
+	 * At the same time we know no files will disappear as all other
+	 * operations take the lock.
+	 *
+	 * Instead of trying to placate userspace racing with itself, we
+	 * ref the file if we see it and mark the fd slot as unused otherwise.
+	 */
 	for (i = open_files; i != 0; i--) {
-		struct file *f = *old_fds++;
+		struct file *f = rcu_dereference_raw(*old_fds++);
 		if (f) {
 			get_file(f);
 		} else {
-			/*
-			 * The fd may be claimed in the fd bitmap but not yet
-			 * instantiated in the files array if a sibling thread
-			 * is partway through open().  So make sure that this
-			 * fd is available to the new process.
-			 */
 			__clear_open_fd(open_files - i, new_fdt);
 		}
 		rcu_assign_pointer(*new_fds++, f);
@@ -679,7 +687,7 @@ struct file *file_close_fd_locked(struct files_struct *files, unsigned fd)
 		return NULL;
 
 	fd = array_index_nospec(fd, fdt->max_fds);
-	file = fdt->fd[fd];
+	file = rcu_dereference_raw(fdt->fd[fd]);
 	if (file) {
 		rcu_assign_pointer(fdt->fd[fd], NULL);
 		__put_unused_fd(files, fd);
@@ -1245,7 +1253,7 @@ __releases(&files->file_lock)
 	 */
 	fdt = files_fdtable(files);
 	fd = array_index_nospec(fd, fdt->max_fds);
-	tofree = fdt->fd[fd];
+	tofree = rcu_dereference_raw(fdt->fd[fd]);
 	if (!tofree && fd_is_open(fd, fdt))
 		goto Ebusy;
 	get_file(file);
-- 
2.39.5


