Return-Path: <linux-fsdevel+bounces-42845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B01CA499AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 13:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387251729CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2025 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901726B979;
	Fri, 28 Feb 2025 12:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5xh+Riv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F331426B2B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Feb 2025 12:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746665; cv=none; b=ld2/0ZhLlkDkE0Y28iFogoYag29q6sj0PanPW6ds7ypuyW1u1yvj5eJwmVkGs57geXoYRRlIpk7uK8+g47N5/DQLzzZquaEtc5bMbkJS5tjarZedYb2oW5qe6oeeMOFyotcRTpiThAMP4vOFlL43XicxrLXOJMGIOhi46IFEeSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746665; c=relaxed/simple;
	bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEIsRXSAk6hi1LOPeouceL1IWjL+9lSI1lNcmc2WKo03owiB61qtlxcRYcxATXBHd+FEE+vRS2xK6w5N/I2kICrAOnhafeQFStTvK/HcNdPU5qnwlhby63hAm+8srFYr9qwCvwcrn/Pgb5NkJPgv/XbvT/QiKRzfM11lxYSlKpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5xh+Riv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F233FC4CEE4;
	Fri, 28 Feb 2025 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740746664;
	bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d5xh+RivOsP6bmwuHLL+O5WRpgdBscvg5WXQiMQ4pfCiABlAvJovt8GwKvwvIqV98
	 SB+5dbBLHgVyvue4obIJJaGwLqQ7tLRJLqkM5+ZxdlsiNV8f4KlNNFzRir9Z/rqQPg
	 /2Af1v3zlNrl/ov+os0zvoUBDKuQfBMiQLU1/K4HzleVXJdcSS1JsgqFOqot8MMb0M
	 nbkEhCnqwwcI5hdVgnWfEnPdOfHo9fcqioz8l0ItfgyuHVMtanje2kxKeq406ZIoVH
	 uiEQZdQzLZIOG66wBodSnAJ4rXYhrQJ3wSTNiguICl19No7NlOBvxvL/AzsyMumrM4
	 p6y4hAbyhAMpA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 28 Feb 2025 13:44:02 +0100
Subject: [PATCH RFC 02/10] pidfd: rely on automatic cleanup in
 __pidfd_prepare()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-work-pidfs-kill_on_last_close-v1-2-5bd7e6bb428e@kernel.org>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
In-Reply-To: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xZdRWqml/Qk46PZe4c1qABRXAGdLWAu0Z0kdDnaX9os=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQfXL+oQSQpb51VilS+WY7/D8XP90yXNTNr1B5YE8m5d
 YHa2WzdjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInE1zIybLhQPbeIJ2C/k8Ir
 gRze7nY3iWufpvQEvNx+wtQmODrgPsP/Yh555bVuDK/uejIe9c7XslwSpHXVv/sVr4jhofbqI48
 YAQ==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Rely on scope-based cleanup for the allocated file descriptor.

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


