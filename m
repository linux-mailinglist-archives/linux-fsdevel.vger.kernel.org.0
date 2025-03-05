Return-Path: <linux-fsdevel+bounces-43223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF332A4FB41
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 11:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4169F165E3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 10:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2A22063C6;
	Wed,  5 Mar 2025 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+D8tmmX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEB3205E3F
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 10:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741169313; cv=none; b=cpb0wuHzh40Zq75aFsNH6Rm5rYO4kCgLnvfCAQLvCmiJsRqHw6vADz47gBhZfaN4zhNu84wD1FqO1kv6Ej7kBpkSUZzEIMD9az1yzSZA8BbPgOgGGcmmoOnTvHBnUTPNdBF6CtllD9Y8UC8DRP+un5X+ZnrPKChVM+5kUgQdyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741169313; c=relaxed/simple;
	bh=U6mTq7uPSmFsVQwB9kIWePLPFLU1GJaGShIt5xcso9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JfWWx+5K4Tr55QncT7v+FaZcp4yXSCvgAZeH+5DXHkU+gyqiE09IYRWHFn5aHP+SP0BC41SUq0A52R77uP4ATq2TCkvgUWMcCSvhzMNNT/aDA33ky9xs2b3DUcjgU+afQ0cbeecWVn7TaRSiZIRphCPUMUWjA7MvKJEnvydMhwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+D8tmmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEC0C4CEE9;
	Wed,  5 Mar 2025 10:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741169313;
	bh=U6mTq7uPSmFsVQwB9kIWePLPFLU1GJaGShIt5xcso9w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W+D8tmmXXETUewamUdv4GS5e1crakTOVLSCSvieJZol6PW1OUOR9yfavAv2t9oOL6
	 2j0KIfvacSQasyfLG5cW8WwniAZsOXxpYdKezxMw9KeHPShaTC+CBHaMfn0zuI01G/
	 IDjL2Tb4/sTYZUezRpuy++eUBvb0K2f1RjBTVTHhhcRIJ5NHP/KS7Vn0CiTW/Y2YlG
	 i2HNSY/FwbpQFqyJXE1KY5WzOYAoXLkm8m2M3S/1bhW4ER9884lHubHZWfqZ8P/SFA
	 8cunfcP6631NFjeyw1NovE3lDazbvIxy9P8mtfxmMj4lM6klaTrtTtuYIfhKrWcDze
	 PtWSOX9ccal2Q==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 05 Mar 2025 11:08:13 +0100
Subject: [PATCH v3 03/16] pidfs: move setting flags into pidfs_alloc_file()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-work-pidfs-kill_on_last_close-v3-3-c8c3d8361705@kernel.org>
References: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
In-Reply-To: <20250305-work-pidfs-kill_on_last_close-v3-0-c8c3d8361705@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Mike Yuan <me@yhndnzj.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U6mTq7uPSmFsVQwB9kIWePLPFLU1GJaGShIt5xcso9w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSfUJqxfB6r5o0rwS7GLlddDCy5N9Y/28+d8MwiXffas
 iVN4szTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSKs7wz84h2HX+rh2PXzQ/
 yTgoM7X/YcKs+x9maki+LZjtdGO3djQjw4fpHA8/Z9t8L5px8kvRLp95PLnbGNS9hOL9tSZl+s2
 +xg8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead od adding it into __pidfd_prepare() place it where the actual
file allocation happens and update the outdated comment.

Link: https://lore.kernel.org/r/20250304-work-pidfs-kill_on_last_close-v2-3-44fdacfaa7b7@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


