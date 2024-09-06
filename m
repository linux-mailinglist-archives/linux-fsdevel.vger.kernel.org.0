Return-Path: <linux-fsdevel+bounces-28857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB2096F93B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 18:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7417EB25BDB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F11D3633;
	Fri,  6 Sep 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eirjc+KL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD63130E57
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725639870; cv=none; b=WQ6tOzvzR+kELjm2Sm40jqCc7pAFO+NjPS4nivrMlLO9ujEfjLtMrBAmU8umwDXWo+/Mp1lbZw7om1ITTsEM2WBqmQoBfpFd0PLYFT+f5T27qhjESmE9FvuD1LsrQLymcheCVhBlbfQTZCeuqUjOxQybj1NcWBMsbO/U6n7iNWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725639870; c=relaxed/simple;
	bh=bfoZ/kQtaXQdW3DuVEqR5m6WhTQyxSgEx5reONSVxvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r9UjcfYb0kzyLxaWFzoC4WQreS+v3jlEjqyFz2UjrXgkX7lIXwxk0YLDL9TNqRs3iFEcUl8JUIn/ODF7SOw2gYMjiBo7MPdwj5DF7emFZgQtx1+fjKXnlZjbGI0hGBJmmsvL8qpEi6lgF7qnUT+F3Cpk1nWHr+Vn/G0+v0xE6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eirjc+KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA589C4CEC4;
	Fri,  6 Sep 2024 16:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725639870;
	bh=bfoZ/kQtaXQdW3DuVEqR5m6WhTQyxSgEx5reONSVxvA=;
	h=From:To:Cc:Subject:Date:From;
	b=Eirjc+KLM4k66QJ/dgIQ15CybWkUBT+5m9U6LMK2w/xKKmu63fkRrOgDuAImA1OhN
	 ilS7nO2fknc91vNzwmMH9WlV4hE4Cs8Pa2Kl+wVlExmAMoveK/nGasN2G056mwlRyN
	 e2XDvS+kK4V3em4RLN07JAPxWvN4WJJfO2DvyURn2gSkMwNFCi/xTtHVHGzH9U55aD
	 QqBuUqjYfP11w8ZY60O6dAtfq+AkwYnApusyWLYRR8v0Y0SLx9IO4QsSmaDm6tlHcy
	 RcsQBAfENQMqFAuLocewI8dEBWO9VM7z/EiB0YFpi0yPcmudepFOwLMUVErf9jW46g
	 n3l4elCb03D8Q==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com,
	syzbot+cbe4b96e1194b0e34db6@syzkaller.appspotmail.com
Subject: [PATCH] libfs: fix get_stashed_dentry()
Date: Fri,  6 Sep 2024 18:22:22 +0200
Message-ID: <20240906-vfs-hotfix-5959800ffa68@brauner>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=brauner@kernel.org; h=from:subject:message-id; bh=bfoZ/kQtaXQdW3DuVEqR5m6WhTQyxSgEx5reONSVxvA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTd1mkx/Jfr/P95YeXqNVMD5j6QWL18beOD6+/1lzdxv zIRn/5CoaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiTwwZGf4YvD3VdHdXxsGr Vj91/l9bOGOne3/A0iVGU50SKiPt5lkw/FO6WjZNNuXk1TQREz/FWTfO7625POvmiQ5+NW+O7gT tE9wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

get_stashed_dentry() tries to optimistically retrieve a stashed dentry
from a provided location. It needs to ensure to hold rcu lock before it
dereference the stashed location to prevent UAF issues. Use
rcu_dereference() instead of READ_ONCE() it's effectively equivalent
with some lockdep bells and whistles and it communicates clearly that
this expects rcu protection.

Link: https://lore.kernel.org/r/20240906-vfs-hotfix-5959800ffa68@brauner
Fixes: 07fd7c329839 ("libfs: add path_from_stashed()")
Reported-by: syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com
Fixes: syzbot+f82b36bffae7ef78b6a7@syzkaller.appspotmail.com
Reported-by: syzbot+cbe4b96e1194b0e34db6@syzkaller.appspotmail.com
Fixes: syzbot+cbe4b96e1194b0e34db6@syzkaller.appspotmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Hey Linus,

Would you mind applying this fix directly? I should fix two syzbot
reports. Apparently that was already detected in June but not reported
due to a missing reproducer. I reckon it's pretty difficult to get a
reliable reproducer for this issue.

Thanks!
Christian
---
 fs/libfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 7874b23364e1..0e1b99923802 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2125,12 +2125,12 @@ struct timespec64 simple_inode_init_ts(struct inode *inode)
 }
 EXPORT_SYMBOL(simple_inode_init_ts);
 
-static inline struct dentry *get_stashed_dentry(struct dentry *stashed)
+static inline struct dentry *get_stashed_dentry(struct dentry **stashed)
 {
 	struct dentry *dentry;
 
 	guard(rcu)();
-	dentry = READ_ONCE(stashed);
+	dentry = rcu_dereference(*stashed);
 	if (!dentry)
 		return NULL;
 	if (!lockref_get_not_dead(&dentry->d_lockref))
@@ -2227,7 +2227,7 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 	const struct stashed_operations *sops = mnt->mnt_sb->s_fs_info;
 
 	/* See if dentry can be reused. */
-	path->dentry = get_stashed_dentry(*stashed);
+	path->dentry = get_stashed_dentry(stashed);
 	if (path->dentry) {
 		sops->put_data(data);
 		goto out_path;
-- 
2.45.2


