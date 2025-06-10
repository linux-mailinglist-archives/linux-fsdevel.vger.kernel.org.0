Return-Path: <linux-fsdevel+bounces-51142-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64636AD3019
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE143B68CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667E9284B2E;
	Tue, 10 Jun 2025 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fYA8bxqo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564A72820C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=HonEWpj0Sd6l4bm6wLgqVj2neVFE9drwZltJvJXwFiBK8Uy45wtnXl4/+D0jxa3VXuReBYb2U1DiXZXkdHHc2bl9Ie3ssamnYHZAgcnGF97KqBuSFjKvtDYP7lBF7Ydcys6N2UIiSF8Kzm5fERGrNl0cXZA9yy6/hPKC+HWeZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=/fj/Stqzr+tADDS9YkOlDttoX3k0/sl8a6+eldceIAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKuXCRWcnkJ6LN7jcKTuiDPIp28qFMjSnAnclo6DBVSyR4NroScmyUdeSGV1Prho28tLkjdy37IFz4UNyuX6uaeeMUgkDAXwzfcelAO/Nv9Tru+dWTxyCrHDRv6zqs2Tk8PzfyU1TwzBo/rpJY7dW4BNlOtQcKST8pyDmA9kMAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fYA8bxqo; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Z+0MqgxmhZxcoAVDREW7L6SoB6Y2Yus1bvCKBDHqphU=; b=fYA8bxqoDRhcQWvhH9i984+eGl
	DPfeAU5VxSIZzXwFqrLjCHBBR+S+/gINPmK4ETs/yCRRKr5xKu6RYC+cnnObDyCuxFa25TvqalE0R
	IAHWTczHuiR4MfokB7dge+cG1evKvDSc+n6eTT7p7dhL6n+iTj5WvmeL2RS6xbeRm0Wx3rARlxc5N
	3Il72O8jEABlVxmVovOV5bHQJhEF6kNxrfoDbXe8i8DQBUsmF/BKWCeEd3aCIP7V0ViNqNRvpn7u4
	hOE3cBJX3BFPqzyUkaRMAdceY0DVrOnQ/WDuyKM9RP2f9ePJvhnfHRVwTiND7YFs4ASVVCa8/qXNS
	tjd4sn2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEy-00000004jOe-21Zf;
	Tue, 10 Jun 2025 08:21:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 23/26] pivot_root(): reorder tree surgeries, collapse unhash_mnt() and put_mountpoint()
Date: Tue, 10 Jun 2025 09:21:45 +0100
Message-ID: <20250610082148.1127550-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7df00ed26db5..60dcfe4aa976 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4642,7 +4642,7 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 {
 	struct path new, old, root;
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
-	struct mountpoint *old_mp, *root_mp;
+	struct mountpoint *old_mp;
 	int error;
 
 	if (!may_mount())
@@ -4705,20 +4705,19 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
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


