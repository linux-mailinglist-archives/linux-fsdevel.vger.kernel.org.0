Return-Path: <linux-fsdevel+bounces-66748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9C6C2B63E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 287F734955E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E734B3043D1;
	Mon,  3 Nov 2025 11:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVEFfMfx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D013043C8;
	Mon,  3 Nov 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169273; cv=none; b=k/Wr1dvKmmIEBCFB7i4yY/+loIrvaWbVdvDC0FvVbEugYBsCRG5lMw3wVqONzu9QurZnOqduBVKHajt+FG2zixWsHDlTX6oVLMeL5C0ph6iRBeE70HW3qIXGEXknahlrH4DsOvodehKh9P1k9N4c/I5wnksw5la6S7KeirR16P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169273; c=relaxed/simple;
	bh=M/gRfyTv5mKfZ+5BvhWQ76LEQ3tFhX77yWuNWTckzIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eq6+YQ2FlLq/2aHMdTHdRbmHfmPdZ/oFTC0TgtnKGGiG6ichr2xChmNFrT5h24TZ+LXsaAkg4z30id+kHmy1840qDuZvgznSxpWSWWbQWedizzJYZfkBplaKTaQVfF1dculmdFMkk+XMRgc+5LiVGh5Jkw864nlbPcivskqh1Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVEFfMfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAA1C4CEFD;
	Mon,  3 Nov 2025 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169271;
	bh=M/gRfyTv5mKfZ+5BvhWQ76LEQ3tFhX77yWuNWTckzIg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BVEFfMfxhAtcDHBJCjcRf39J+5yktLhjR/ZEOHo9p2nFmgkmjYFFNsz5oIU/U8ZTL
	 9irmY+G64LxOeURMJwzrYYPbRuyimLKkAsFmswkr6ayePhzuTycrYOMwvYBjeg44kL
	 fZh4MxKTDUwste9fqOKAyNQ2wYd7iH3XkjngIZOlmUGVNO+/HlDAszhoz8tfJHzN7K
	 A6ysUam7UPg/1PHBR93Mf6ID+j+UPcWIpBlrThXvVM3VzfY2pKJMW5jcUiwixDaa05
	 1ZHbalHthOrPVyftU1mntAlNvT/Fog0UCTJ0nGQl9ANDYuJecuRDHSA3zVl7E3MiBm
	 NqcPsTSXtAoHQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:27:03 +0100
Subject: [PATCH 15/16] cgroup: use credential guards in
 cgroup_attach_permissions()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-15-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349; i=brauner@kernel.org;
 h=from:subject:message-id; bh=M/gRfyTv5mKfZ+5BvhWQ76LEQ3tFhX77yWuNWTckzIg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTOwIF1HWiI55/L9ds6r6Ed+EQyobr71rc98e/UptT
 nKn4XWzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn0SzH8sxB2VDhxXOsZr/O3
 xuBV7de9Su/HHFLoTA64c5B7742/KYwMa6dOZXfuuuMXXnvh69dXJwVX68SutZe8tXda4kPLf4u
 mMwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fdee387f0d6b..9f61f7cfc8d1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5363,7 +5363,6 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	struct cgroup_file_ctx *ctx = of->priv;
 	struct cgroup *src_cgrp, *dst_cgrp;
 	struct task_struct *task;
-	const struct cred *saved_cred;
 	ssize_t ret;
 	enum cgroup_attach_lock_mode lock_mode;
 
@@ -5386,11 +5385,10 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * permissions using the credentials from file open to protect against
 	 * inherited fd attacks.
 	 */
-	saved_cred = override_creds(of->file->f_cred);
-	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
-					of->file->f_path.dentry->d_sb,
-					threadgroup, ctx->ns);
-	revert_creds(saved_cred);
+	scoped_with_creds(of->file->f_cred)
+		ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
+						of->file->f_path.dentry->d_sb,
+						threadgroup, ctx->ns);
 	if (ret)
 		goto out_finish;
 

-- 
2.47.3


