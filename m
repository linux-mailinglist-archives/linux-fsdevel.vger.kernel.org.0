Return-Path: <linux-fsdevel+bounces-68969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A783C6A6FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC0304F5754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E62D36827E;
	Tue, 18 Nov 2025 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaMsgEqK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE4336827A
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480998; cv=none; b=MHpTYXUQJyH1aP4ZxM5eZQnNIMtfx1KS2vYHksfmEPuVx1pyqfSSzkni8PXFfqQs0wk74Eo6vjn39WgenSkZ8cTZkqRyUvbOqXlzB44CAKzUFVOaJXf64Cgjqgh5b+LvTQ9zwh92zZPrK+eQe1dXZnqt9mbeGn5jiJKzV8H5nMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480998; c=relaxed/simple;
	bh=xoUetjnEEcZndnsBI2Vk93UKdd0/KtjvhSYesA/sgNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpL5qfJ+KSZcbYp7N866A7GmnXsKYtBzEgVi5ci2k0szS9bqoNQc/B2m9I415ficKMILX8NzedZwhr+Xus4xNCbsURcErgY9/oeLfjPwPu/Wp3UrjG19l7R0AHaMFvfO4whJZ3QKzP9wUrvu4MSU5QYoE2Wa/OiSO6AwUpkG81I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaMsgEqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09061C4AF09;
	Tue, 18 Nov 2025 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480997;
	bh=xoUetjnEEcZndnsBI2Vk93UKdd0/KtjvhSYesA/sgNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IaMsgEqKvlN+m5sHLtkMYIaGin1nSubEJksfkNrerV3JrNmpAbupjzgc3/FbtKF5+
	 ZNyDvyAupJp9UhVwMP0n6JyPgpcuxhziKTB7LzJltbDvVbQdmKAMdyh0W8FZ9axhNC
	 R7Ukm4b708fJjzfILFG+7eiFH41hh7u5xHTG3cx3wvCIxQ+21aJxZ5PISTFGiT4euW
	 qs35WM+RSlY4c4+uzuwKwCx/jgQytO42VF+7DUiDW0O3YrfAfejPMUTRucPpoC1/EQ
	 6YFdZsLShGyYM7pXt9rPeRdlaFI7Eg9HqAIvYtO74xk/LdrZJ3ZcU9+TJvYsmz8bhR
	 1jWLhh02wldJg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:50 +0100
Subject: [PATCH DRAFT RFC UNTESTED 10/18] fs: eventpoll
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-10-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xoUetjnEEcZndnsBI2Vk93UKdd0/KtjvhSYesA/sgNs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO1X+ZJf8izv0PS/ezztFy//uGdhrkxQIrerMV+Tt
 MB9obXnOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSE8HwP2PeBDlGK7PCu7ce
 xT67dNRcIv3OVaW/IXcFGfPlXwQnn2L4n/WwKHXD3Yk5FVcf2UsyTrmbeW7BNfHkmzXLQ9/KSG6
 o5wIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/eventpoll.c | 33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index ee7c4b683ec3..d707e96f3685 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -2165,9 +2165,8 @@ static void clear_tfile_check_list(void)
  */
 static int do_epoll_create(int flags)
 {
-	int error, fd;
-	struct eventpoll *ep = NULL;
-	struct file *file;
+	int error;
+	struct eventpoll *ep;
 
 	/* Check the EPOLL_* constant for consistency.  */
 	BUILD_BUG_ON(EPOLL_CLOEXEC != O_CLOEXEC);
@@ -2184,26 +2183,16 @@ static int do_epoll_create(int flags)
 	 * Creates all the items needed to setup an eventpoll file. That is,
 	 * a file structure and a free file descriptor.
 	 */
-	fd = get_unused_fd_flags(O_RDWR | (flags & O_CLOEXEC));
-	if (fd < 0) {
-		error = fd;
-		goto out_free_ep;
-	}
-	file = anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
-				 O_RDWR | (flags & O_CLOEXEC));
-	if (IS_ERR(file)) {
-		error = PTR_ERR(file);
-		goto out_free_fd;
+	FD_PREPARE(fdprep, O_RDWR | (flags & O_CLOEXEC),
+		   anon_inode_getfile("[eventpoll]", &eventpoll_fops, ep,
+				      O_RDWR | (flags & O_CLOEXEC)));
+	if (fd_prepare_failed(fdprep)) {
+		ep_clear_and_put(ep);
+		return fd_prepare_error(fdprep);
 	}
-	ep->file = file;
-	fd_install(fd, file);
-	return fd;
-
-out_free_fd:
-	put_unused_fd(fd);
-out_free_ep:
-	ep_clear_and_put(ep);
-	return error;
+
+	ep->file = fd_prepare_file(fdprep);
+	return fd_publish(fdprep);
 }
 
 SYSCALL_DEFINE1(epoll_create1, int, flags)

-- 
2.47.3


