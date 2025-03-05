Return-Path: <linux-fsdevel+bounces-43222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD70A4FB40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A1827A346F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85AF205E2E;
	Wed,  5 Mar 2025 10:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSs02nA/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554781C8612
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169311; cv=none; b=F+FARfu6A3lqQimOVsmRqwu5yW+alM5CMT+1xC856SFLbXbQcwjJ+s3CEHuS22D2cfHXF50PpUl61EklLbNMTUF+zI5Jgov2o1wBUq4U/QYe+D25tF9ftPiveSC8CCFcUmq2G+8NdGEy9wSTLEAxW+2CJvtfv37yHIvLh/CPKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169311; c=relaxed/simple;
	bh=av4DkB7WFvAYLnrOfF/XuXugIucHUQhRFCeRNgZsKuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ujn7e633ODIilC2GvVYp08baAl3F1vfDVdz5Jg11uVvPzPw35NS+d12KrJLez6eJQEfdsR6MfpUTvuMGtBpqVOJVZ1nwAsXDlpTloV+dPQ4JpgTMgRAlhtGfBHOwr4PE1F0MsKFHbn0+7qi6l1+EgVYArMLGbO1n54muu4EcEMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSs02nA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9B4C4CEEE;
	Wed,  5 Mar 2025 10:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169310;
	bh=av4DkB7WFvAYLnrOfF/XuXugIucHUQhRFCeRNgZsKuk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rSs02nA/ylmlAJdDufAbmHCiv402qUeeLAoA9M1rJycbH/QXgJrzD6KpzGqLn1Fzp
	 KW3Vqk66KBff+Oos9PNJCdZfZNDDOB30HbIH/Ub2jPc45gHMTNgY8W853XXrzje+7R
	 ZjUh4BJ2YrtS6BHVBYZPY6baP6F+XYHZI/vhD9mG17vtMqxwTYe3mz2lW1/+pVQWhr
	 NZAWOzUPiSGcNk1VeZL1S4kPjuMfcyomOqlUlU0TOuKyz+AfjBOzyrO0TrnFAugJVQ
	 rTli0zPvmvxvF0nkgfu+KaItjww/oUw1pcrQfismjLwRS4/lQ+yHXlSWf1WjecW2vL
	 onfeWoiHFV0ew==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:12 +0100
Subject: [PATCH v3 02/16] pidfd: rely on automatic cleanup in
 __pidfd_prepare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-2-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1287; i=brauner@kernel.org;
 h=from:subject:message-id; bh=av4DkB7WFvAYLnrOfF/XuXugIucHUQhRFCeRNgZsKuk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJoh4Ghx5uW8wivPX0XYsP33qG/f0yw2IfBwwGu2v
 3ZfHXdKdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkmjYjw/FFa47PyBXgl9Eq
 vTb5h4yxg1161OGOF+J2jb8TwkXXH2f4zfL3iS9jzoN6oWUzLwUnrVqUU7iKKUmB/913u4Jun8I
 T/AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on scope-based cleanup for the allocated file descriptor.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-2-44fdacfaa7b7@kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/fork.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..6230f5256bc5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2032,25 +2032,23 @@ static inline void rcu_copy_process(struct task_struct *p)
  */
 static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	int pidfd;
 	struct file *pidfd_file;
 
-	pidfd = get_unused_fd_flags(O_CLOEXEC);
+	CLASS(get_unused_fd, pidfd)(O_CLOEXEC);
 	if (pidfd < 0)
 		return pidfd;
 
 	pidfd_file = pidfs_alloc_file(pid, flags | O_RDWR);
-	if (IS_ERR(pidfd_file)) {
-		put_unused_fd(pidfd);
+	if (IS_ERR(pidfd_file))
 		return PTR_ERR(pidfd_file);
-	}
+
 	/*
 	 * anon_inode_getfile() ignores everything outside of the
 	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
 	 */
 	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 	*ret = pidfd_file;
-	return pidfd;
+	return take_fd(pidfd);
 }
 
 /**

-- 
2.47.2


