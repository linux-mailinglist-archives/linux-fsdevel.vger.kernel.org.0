Return-Path: <linux-fsdevel+bounces-10486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E784B872
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 15:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9A61F26CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 14:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC91332B9;
	Tue,  6 Feb 2024 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlwG/D5t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3373131E40;
	Tue,  6 Feb 2024 14:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231174; cv=none; b=BmdJVrBGUKcGGCOddcOVc3yo82MO50AZdq9FuRVbSVAVm7mMk5zpekwQcz3CMTg5DFb+sNJmjho9EWk+uy4K1X6DluLwwVlqVbSlZi+MiqhBS0Dbx/xRRzYzLv2sJ1+nWQUUQUNe2ZZ5RdN1GI57+F/K5bfY4p3lJly39bB9/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231174; c=relaxed/simple;
	bh=WM6G8+4SZkOtjR5TKR7CAXeyhI3wvKML7VzcZML8OWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QS6e+DQIQnQV+ZrR3J+Lxz+6Te0hENL4wJXUDj36fdT708c81xLxr4qfNYknnaBjzgf9sPnqcQr5ZjHyDqOoNzFYKgZ56QxlhCD6jBXz7jtf5fd2rFUvsZ+DoelPypJHa0KnC15UcHGEs2aXS1uK11Tu/4Q1FL2HY3lNMTYQwr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlwG/D5t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A678BC433F1;
	Tue,  6 Feb 2024 14:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707231174;
	bh=WM6G8+4SZkOtjR5TKR7CAXeyhI3wvKML7VzcZML8OWo=;
	h=From:Date:Subject:To:Cc:From;
	b=VlwG/D5t+2JeXoqVpFAf7vTkRwYqTVz7krGVvLoEBc0xIFkcF/hk3A5t5HeFVLT6m
	 T1THwDt/e6y/WLXJBXLOd0FM4X22o4fvUv9uxr7jL3V8e1doBRSzzREdhwozulHNMb
	 vSwthXdFgGLGSxiatqBBgMeo+4otoV9YPrPph4esgl099thYUgF1L0GDyhL9+AXsfv
	 df4tPcWfsgoti6riJYJ685M81tdiVVcj64GDAk7Ur/irQGKd0hPHICEGo98qnVqTaz
	 Ga50WIU1CevHJyv85lcQfI8jvCg4hymHDjHkqrwBSE9qhs+CPVvxI40Yxs4xvnfdqL
	 klUle3Qu52TKw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Feb 2024 09:52:49 -0500
Subject: [PATCH] ceph: mark lock variable __maybe_unused in
 ceph_count_file_locks
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-flsplit-v1-1-17497d0c1e14@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMBHwmUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIwMz3bSc4oKczBLdFJM0EyPzFMtUg8QUJaDqgqLUtMwKsEnRsbW1AL5
 tN/VZAAAA
To: Christian Brauner <brauner@kernel.org>, Xiubo Li <xiubli@redhat.com>, 
 Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1555; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=WM6G8+4SZkOtjR5TKR7CAXeyhI3wvKML7VzcZML8OWo=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBlwkfFR8f7zh3ukzkRgliPb0GctNJwERkyRt83s
 +DFJqcyI+yJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZcJHxQAKCRAADmhBGVaC
 FYOvD/9GMpgNxpq4H21CrUmYR5+jKs33o2/9lPtAbT6DHmL4/mAcx8AZgt+ZsESLnLGfSsk2A6G
 C0lUkJlUZTp515FJWMVKdJAbFhNMNIR4YT4wvMdko8pDnVJE34s0Hm2N1xVT7Uq3RthCHscf8Vl
 g1cfyySni5hjZTkuUVhG0JbvcQ+Pz7ZBMfsSxztv5hjqUmjStF3GVkTpLsSEZsyVJxEfRCvG/bH
 oYnKupZd7V9MqFRolYFNnfxl/U64D3vRot9udxBshgX+EBkU/n6PQsCdon/nLthvpoF0rHFHJSG
 vQwD1/0JCf58cHAI+49CxAh1j2BZtDxiMdHxGi425T1wwhAck9kWJKVkQ4Uu5uWQHoVoNbA3x9t
 /dQse0Hwa3mH+UUzuuWQojG3aIFy3kAIlUMae6f6DmH8CbZdfOY1oPsCdju9iGerwwx2OwYrvsz
 P0z6NE8QaQwmw7EdfJwIG+maXL2xfF6gI7YC1cbYIkr9wUChxVDJ2u9zH7OeNSP3HS2GvUCAGUG
 +GjBWhldW10uZ6da5YWvtVQUyzv9gEeL1BIiUwnRzYplqw6e20P4c50/17Cb3lM1FsqgUx2kgmi
 UUQ5wxcuLtCClRGCMQfocnOEwHRc+ER4ziOmmRvRO4B44zXGTZm0zhaCGhd6FAPvpRHTgWZH/B9
 sPchd4DNDBr2A8w==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The "lock" variable won't be used if CONFIG_FILE_LOCKING=n. We can't
remove it altogether though, since we do need it for the
for_each_file_lock loops. Reduce its scope and mark it __maybe_unused.

Fixes: 3956f35fbd36 ("ceph: adapt to breakup of struct file_lock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202402062210.3YyBVGF1-lkp@intel.com/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This warning is fallout from the big file_lock re-org, so this should
probably go in via Christian's tree.
---
 fs/ceph/locks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ebf4ac0055dd..edfbf94f0d14 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -377,7 +377,6 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 {
 	struct ceph_client *cl = ceph_inode_to_client(inode);
-	struct file_lock *lock;
 	struct file_lock_context *ctx;
 
 	*fcntl_count = 0;
@@ -385,6 +384,8 @@ void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 
 	ctx = locks_inode_context(inode);
 	if (ctx) {
+		struct file_lock __maybe_unused *lock;
+
 		spin_lock(&ctx->flc_lock);
 		for_each_file_lock(lock, &ctx->flc_posix)
 			++(*fcntl_count);

---
base-commit: 77f8316a9199a752ffcd136bd01d0566f54e0ea9
change-id: 20240206-flsplit-d4f427d9e0ad

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


