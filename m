Return-Path: <linux-fsdevel+bounces-53266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64DB1AED298
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26993B51C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5401F583D;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UzabY6ZS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FC91A3154
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251982; cv=none; b=Og4/iAwhK6dWeeKKqaiG5F2cxElTXR4KJxm2XfU4lLI3GQe7ZXhLJyRN1cuKnJXYy3noFOA10iQW3ohl+cnENk31LibqgyBIL4O0T9RSud0Qs6MpbksAtPQiMse8cDtUU1oVs+Bz/IyYuJ0w8ak0LUYmIz9VltfYRX/tbuS7iPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251982; c=relaxed/simple;
	bh=Uq7KDYWHC7xE3zh+iMoXFkQMy3p6Dl/Hsi5ATl7plgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhRRfZ6R0W9bHYE3S1DFjl0LE1y0tvx2cGCtCfQhLuOlvqPd62XnbZ7EremA9/IV4tNaQT4L09iP5+L2Ji9iMAwiolqQUlB/B+ndtNt9vH/RUSTGRq5SowtJCvjzajLbH/fVczBLcocO59YkaDKiW6c124CE4AtFpW6EFlhLixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UzabY6ZS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=NOd1KpTK3SItf5nemOpKY9R5B+0DMUos1m8YikpaLJc=; b=UzabY6ZSmMlQlWS0yAiBiAgh+L
	z1ky0moffOxp1WRYfufh1yMAs6oXIdGGlYMzKYobRPHYYvNTzszta8gKMqAbitjVmXFlrcGlbZ2HR
	63pvFWqnslby82Whs8819pDS5AwQsmefjkDM9A2Wnivm5SSQ3m3xN+hL5ak7OnBOyOD7vQDOoPzHc
	C9LUp+L2S6MVYFPx51/qumY3Gijnovk0U00i/qNPbMumxnTkhSTfGWIuIueHUPezyN/yD43O6IlyC
	ofoe/mCeetLtJhe+CESxt33+5dVw6iK2tDHen2G9e9DXEzBvpvUTJ704PRh6Yjn9xAlLl2zHuHFBo
	mgLNNCDA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005p0U-48Mn;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 25/48] pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
Date: Mon, 30 Jun 2025 03:52:32 +0100
Message-ID: <20250630025255.1387419-25-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

attach new_mnt *before* detaching root_mnt; that way we don't need to keep hold
on the mountpoint and one more pair of unhash_mnt()/put_mountpoint() gets
folded together into umount_mnt().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ff2281f780dc..eee73e945a54 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4685,7 +4685,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 {
 	struct path new, old, root;
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
-	struct mountpoint *old_mp, *root_mp;
+	struct mountpoint *old_mp;
 	int error;
 
 	if (!may_mount())
@@ -4748,20 +4748,19 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		goto out4;
 	lock_mount_hash();
 	umount_mnt(new_mnt);
-	root_mp = unhash_mnt(root_mnt);  /* we'll need its mountpoint */
 	if (root_mnt->mnt.mnt_flags & MNT_LOCKED) {
 		new_mnt->mnt.mnt_flags |= MNT_LOCKED;
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
 	}
-	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, root_parent, root_mp);
+	attach_mnt(new_mnt, root_parent, root_mnt->mnt_mp);
+	umount_mnt(root_mnt);
 	mnt_add_count(root_parent, -1);
+	/* mount old root on put_old */
+	attach_mnt(root_mnt, old_mnt, old_mp);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
 	list_del_init(&new_mnt->mnt_expire);
-	put_mountpoint(root_mp);
 	unlock_mount_hash();
 	mnt_notify_add(root_mnt);
 	mnt_notify_add(new_mnt);
-- 
2.39.5


