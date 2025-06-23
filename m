Return-Path: <linux-fsdevel+bounces-52457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAE4AE347F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D6483B05DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C101EEA28;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gQK48OSy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ADA1DD0C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654475; cv=none; b=DyIGideR+bJabZXJbIQkMEQQf+uni1zshr52qY5l/8IKxFJ41eBaJRl6FnHj//WdnCKOjBV22s7sovSSPi3lln6BXYUSZro8VK4Bs52X5CmKKgpM97GhRw2qH2F3Na8Jq3RVvbUnhC2uvpgFjhf4hcCPnMJJoWgs+XgoVRQx0zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654475; c=relaxed/simple;
	bh=EblqMTqfiBUuyO1XGLWlQc4bjSNPjerYUf7ynqahlKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeCAwD+SoOUNlcMPafsuXoY+luD0SdJfCOHJySuVSRcFbx9cCWx0A0Gq1KgsJU8C5CVli5mM3WBlts9SKDhJNC1XBBk9PJnj0MBbyCZTuy4SigZH9ZHIqZtYiHnLvukL7K3yvPCgKN016JaiNi1hsdx3UNezsDjm38GfhRzWr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gQK48OSy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4YlH/iEZxI7hDhIF/vDkmKjsK2uELIAKKj5m6iYDF4Q=; b=gQK48OSyDIsRdC++lbLzHnZl6r
	igg4uVNmmHBw5HB5WHRjzgutKPHx1RXnZZfSdASo8tap34/Vr2F2ei342K73q3CGtkDAJQ1JceMJe
	RWbDzqBdrjvQJsA06rTjKy2ZTFdWc5uUCkXwWz/5vy55SCPFMEb6lvgJgeD/gItU1/O41IxyAsTHa
	qXhKLvRwZYSiLJhXWd4C9bdrxHrPha09FfWyT1nQQcavrEbJtNA+ZO1J+SK9mNO6wnjVeOHz790zH
	F4QwFSmIvV8cjJvzkuvm0yVSR2juTQlH81K5wdgpdFUUVcjmdNFFqArvvWvL296OK9CkaVgil36vw
	VZVCh1gQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCS-00000005Kt3-1B6w;
	Mon, 23 Jun 2025 04:54:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 26/35] take ->mnt_expire handling under mount_lock [read_seqlock_excl]
Date: Mon, 23 Jun 2025 05:54:19 +0100
Message-ID: <20250623045428.1271612-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Doesn't take much massage, and we no longer need to make sure that
by the time of final mntput() the victim has been removed from the
list.  Makes life safer for ->d_automount() instances...

Rules:
	* all ->mnt_expire accesses are under mount_lock.
	* insertion into the list is done by mnt_set_expiry(), and
caller (->d_automount() instance) must hold a reference to mount
in question.  It shouldn't be done more than once for a mount.
	* if a mount on an expiry list is not yet mounted, it will
be ignored by anything that walks that list.
	* if the final mntput() finds its victim still on an expiry
list (in which case it must've never been mounted - umount_tree()
would've taken it out), it will remove the victim from the list.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c4aba4e096ae..164b80108cc4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1353,13 +1353,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		list_add(&mnt->mnt_slave, &old->mnt_slave);
 		mnt->mnt_master = old->mnt_master;
 	}
-
-	/* stick the duplicate mount on the same expiry list
-	 * as the original if that was on one */
-	if (flag & CL_EXPIRE) {
-		if (!list_empty(&old->mnt_expire))
-			list_add(&mnt->mnt_expire, &old->mnt_expire);
-	}
 	return mnt;
 
  out_free:
@@ -1452,6 +1445,8 @@ static void mntput_no_expire(struct mount *mnt)
 	rcu_read_unlock();
 
 	list_del(&mnt->mnt_instance);
+	if (unlikely(!list_empty(&mnt->mnt_expire)))
+		list_del(&mnt->mnt_expire);
 
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
 		struct mount *p, *tmp;
@@ -2273,6 +2268,13 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 			lock_mount_hash();
 			if (src_mnt->mnt.mnt_flags & MNT_LOCKED)
 				dst_mnt->mnt.mnt_flags |= MNT_LOCKED;
+			if (unlikely(flag & CL_EXPIRE)) {
+				/* stick the duplicate mount on the same expiry
+				 * list as the original if that was on one */
+				if (!list_empty(&src_mnt->mnt_expire))
+					list_add(&dst_mnt->mnt_expire,
+						 &src_mnt->mnt_expire);
+			}
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
 			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
@@ -3891,12 +3893,6 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 	namespace_unlock();
 	inode_unlock(dentry->d_inode);
 discard:
-	/* remove m from any expiration list it may be on */
-	if (!list_empty(&mnt->mnt_expire)) {
-		namespace_lock();
-		list_del_init(&mnt->mnt_expire);
-		namespace_unlock();
-	}
 	mntput(m);
 	return err;
 }
@@ -3908,11 +3904,9 @@ int finish_automount(struct vfsmount *m, const struct path *path)
  */
 void mnt_set_expiry(struct vfsmount *mnt, struct list_head *expiry_list)
 {
-	namespace_lock();
-
+	read_seqlock_excl(&mount_lock);
 	list_add_tail(&real_mount(mnt)->mnt_expire, expiry_list);
-
-	namespace_unlock();
+	read_sequnlock_excl(&mount_lock);
 }
 EXPORT_SYMBOL(mnt_set_expiry);
 
-- 
2.39.5


