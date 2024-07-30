Return-Path: <linux-fsdevel+bounces-24563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DAE940763
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 07:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5F3B228EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 05:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50FF19E82C;
	Tue, 30 Jul 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJZLme2c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B1C19E7F4;
	Tue, 30 Jul 2024 05:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316516; cv=none; b=JVCAc0r6QmEMHqL9QfrUe+BpZOb6dD1KUaT0qOdCxqIBotZR+QtoT52bZKQfbdak8BzRCOxFB0DKHOO1HCspJTt0+TdLwNdr2H3pfweYxVKmRtzb52lLnC8kW8r9phHRbwEnyIUGvP1aKfR1r146VGeehHmWnjhknnx7LrDGgAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316516; c=relaxed/simple;
	bh=40/H9ZbBn6+yc66cQA7ik6EVZRSXm5GV9IAlCl/Wg4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AfjMjjoSLOU8NcKqxeLjcs0QyCqd77PalBRn01kDnFrYGZv8sNzL9dslqYHmNVq59NmTPJaDhX759ZSX7/LGh/Vi3zOXisp9CCXPa0XGjzgOcvFokdTM2UXAbexTMl9ugXBls2+V0wF5pvd/2pKoNkGG47q/FQPlVQaJWSU6kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJZLme2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C88EC4AF0A;
	Tue, 30 Jul 2024 05:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722316515;
	bh=40/H9ZbBn6+yc66cQA7ik6EVZRSXm5GV9IAlCl/Wg4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJZLme2cVWlp5otdL20ZDl46dzumzTQ8NQN9c++DQ1Gac4hJN+v/t6HTSYujuBtn5
	 nDhJ9epDlqFFwVQIiqrsbLnZOuQt5zBAyx2pdPveswj3EXaq333rXz/bcrvQbbh6eY
	 +i0ead02VeGSFfevXiQvH/mhYkf6n7uUasIYucFaPcphs2vEG7FUKRKdysvLQxXH1G
	 Fx0QIWPdgeHtFhZe7D9Bl0zB6Suki3R77gkOl9O0YKkO9S5Hp74BGqsqjKjHTFI4v2
	 z/sJLWLTEL2+adUOSoYfJJyvV+Oz5gf291jswc5OXGZ+nz8iOKATzZxln+Od35ozS8
	 1e+yDzPHbdgjA==
From: viro@kernel.org
To: linux-fsdevel@vger.kernel.org
Cc: amir73il@gmail.com,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	cgroups@vger.kernel.org,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: [PATCH 31/39] convert cifs_ioctl_copychunk()
Date: Tue, 30 Jul 2024 01:16:17 -0400
Message-Id: <20240730051625.14349-31-viro@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730051625.14349-1-viro@kernel.org>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

fdput() moved past mnt_drop_file_write(); harmless, if somewhat cringeworthy.
Reordering could be avoided either by adding an explicit scope or by making
mnt_drop_file_write() called via __cleanup.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/ioctl.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 94bf2e5014d9..6d9df3646df3 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -72,7 +72,6 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 			unsigned long srcfd)
 {
 	int rc;
-	struct fd src_file;
 	struct inode *src_inode;
 
 	cifs_dbg(FYI, "ioctl copychunk range\n");
@@ -89,8 +88,8 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 		return rc;
 	}
 
-	src_file = fdget(srcfd);
-	if (!fd_file(src_file)) {
+	CLASS(fd, src_file)(srcfd);
+	if (fd_empty(src_file)) {
 		rc = -EBADF;
 		goto out_drop_write;
 	}
@@ -98,20 +97,18 @@ static long cifs_ioctl_copychunk(unsigned int xid, struct file *dst_file,
 	if (fd_file(src_file)->f_op->unlocked_ioctl != cifs_ioctl) {
 		rc = -EBADF;
 		cifs_dbg(VFS, "src file seems to be from a different filesystem type\n");
-		goto out_fput;
+		goto out_drop_write;
 	}
 
 	src_inode = file_inode(fd_file(src_file));
 	rc = -EINVAL;
 	if (S_ISDIR(src_inode->i_mode))
-		goto out_fput;
+		goto out_drop_write;
 
 	rc = cifs_file_copychunk_range(xid, fd_file(src_file), 0, dst_file, 0,
 					src_inode->i_size, 0);
 	if (rc > 0)
 		rc = 0;
-out_fput:
-	fdput(src_file);
 out_drop_write:
 	mnt_drop_write_file(dst_file);
 	return rc;
-- 
2.39.2


