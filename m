Return-Path: <linux-fsdevel+bounces-43059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A0AA4D8F7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 10:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25178170DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD51FE45A;
	Tue,  4 Mar 2025 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJp76jF2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF811FDE08
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 09:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081283; cv=none; b=uExZHuNp2DOs04TtbsDilKLr8ZaiR0ccKr551TS0jfVCpDaAKNxIjsOEK0yticePpJ1vn4xU73ga6BW0/dkunSH2g1GywEkTYIToYvovjyepdBftS/gUAwNigu+uKY+1kQTkKgqowCpP9fE+QzevyuDU69ftMURVwWxdIkgXCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081283; c=relaxed/simple;
	bh=axP2pjvEX4Nb309FegHVqfpLcC7ZJq5Ljce5fNX+woU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8EAwZNFMonLiSDzTKZGP3GkkIM61cqmlaYUhOigkcsr3HU9qjILkEYVWfT/6VWC7bQC0bDNUHRYhGjhACqA8gt1o2ZD3Ed5Gs1fNSXM1AKSHSLygO0Kh53fvSK+ULr/afmbNNRuJP7h7AZ+jPAdTmpeCsHVLXCt2K9X2P07HYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJp76jF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF51C4CEE8;
	Tue,  4 Mar 2025 09:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741081283;
	bh=axP2pjvEX4Nb309FegHVqfpLcC7ZJq5Ljce5fNX+woU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OJp76jF2/uduXDRjeKWLTT8vzyQWodGX+2TjOujJW7Sbpgpf6uHAt8K360NEXTCR/
	 j0U8PPi/9llPpC6DoO6K4Bk1gQSXMfyNipw8DlwoD33kmwVZWPC9090ZMdQKf5461C
	 uWlcU5sromLVq0bF3k+rSjmGpzx5kWbZqj7yx7peQiVjrifqZnYq3MAYhqCRK3Q/6M
	 tCZdr70RCQRFEctvuGQ/mgoM5ZzX8plUJUgbXUZ3njRRMbC/hdCNz13y/u2wkhFD0i
	 C380D1pawhvbM7Knul6ohPV+V2Y1qtLihXo6vL5NVqXYk1Icj60KVgPkFxMlnhsxyG
	 PQiGWHiAfPHCw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 04 Mar 2025 10:41:03 +0100
Subject: [PATCH v2 03/15] pidfs: move setting flags into pidfs_alloc_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-work-pidfs-kill_on_last_close-v2-3-44fdacfaa7b7@kernel.org>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
In-Reply-To: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=brauner@kernel.org;
 h=from:subject:message-id; bh=axP2pjvEX4Nb309FegHVqfpLcC7ZJq5Ljce5fNX+woU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfO7Vr7fMFrBIN0ycv/FtdqbS+5ItftezDO7+Zi/arr
 z5mvEfrX0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBETrMzMuz1a0z1cdtdysZt
 e+zXm66ZGyevPHXMhelNbsskuRyDPcIM/10duZ6sMJDK7z8wqfFe1vvHPFfaGxct5HYP4eDxnKY
 /kwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead od adding it into __pidfd_prepare() place it where the actual
file allocation happens and update the outdated comment.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c    | 4 ++++
 kernel/fork.c | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index aa8c8bda8c8f..ecc0dd886714 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
 		return ERR_PTR(ret);
 
 	pidfd_file = dentry_open(&path, flags, current_cred());
+	/* Raise PIDFD_THREAD explicitly as do_dentry_open() strips it. */
+	if (!IS_ERR(pidfd_file))
+		pidfd_file->f_flags |= (flags & PIDFD_THREAD);
+
 	path_put(&path);
 	return pidfd_file;
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 6230f5256bc5..8eac9cd3385b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2042,11 +2042,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
 	if (IS_ERR(pidfd_file))
 		return PTR_ERR(pidfd_file);
 
-	/*
-	 * anon_inode_getfile() ignores everything outside of the
-	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
-	 */
-	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
 	*ret = pidfd_file;
 	return take_fd(pidfd);
 }

-- 
2.47.2


