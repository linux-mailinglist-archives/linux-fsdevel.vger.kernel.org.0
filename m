Return-Path: <linux-fsdevel+bounces-53243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3135AED289
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0A4189105C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBE51A23A0;
	Mon, 30 Jun 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BwIKRAP/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFBE156F4A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251978; cv=none; b=diNDME3Ek1kTSzltEuNPQQra0FpGJAyr3OYZHeGdm7wMj+3Fegplj6ibuQPvkWdryZHNx3/MHMUJJEtHq48GF/4NZwPDraytetajaO3ZK6kFcU/ISHKtEsjIhwAaiDBfVjT4IRdqeEhm+QPDMuk652smVTEN5qKZ4sRIc2k0iG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251978; c=relaxed/simple;
	bh=WHDb4a4Q6DK6p6FOTj2Pddo3Apnt1oSz3RDcxopSJsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQ1/CEYW3oQ5Koj8CHrOJZzv7Phbibf4RQp92JeZnl3EKO/MQL4zqXzRnKPQiQG1gxWA6o7uBLbhQORMk4nqScm1bFJxT1cSobjstd5nyYW+yWqJUjOuI/2Bvaimy8I/+/hlHhwIBa+fAEEsQ0d/v6gAC33fnSxnjHfZMAGWL0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BwIKRAP/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OsrTcgIl/dwkDFaq6A6rBVruDlRjq8B6p6FYyzAJyBg=; b=BwIKRAP/yDFt0udnRidYNNvJc5
	FKG2brNP1tX4a06W/Wef1cYY/wROR9YMuv4e3QCjV7hsi4jK9Y3ly0/7PAmoCGfYVZTvt2USR5pEK
	ZUrxwFOs5pGzTmGR/d6PK26uEQIiVoMT3+OpUKBPJtAiR7lMqkrLDem/3domNm5BK0xXTKvhBezB9
	ZKTD+ZCdwOHkmUqD50vzKiF7CRmuCVM2E6v1tf43ud35btm2jdMoYWJcQvPVjVr7+Xj6iQ8AgKrXl
	AQAN3K006G+FrDw2ETD24E3bWpxMEotfh+IgPt7+0la7mp2JU1ijh5fYLadILocS9NCLvDFBgMP2A
	L1u///Ng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4db-00000005ovq-1XJ0;
	Mon, 30 Jun 2025 02:52:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 01/48] attach_mnt(): expand in attach_recursive_mnt(), then lose the flag argument
Date: Mon, 30 Jun 2025 03:52:08 +0100
Message-ID: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025148.GA1383774@ZenIV>
References: <20250630025148.GA1383774@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

simpler that way - all but one caller pass false as 'beneath' argument,
and that one caller is actually happier with the call expanded - the
logics with choice of mountpoint is identical for 'moving' and 'attaching'
cases, and now that is no longer hidden.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 54c59e091919..1761d2c2fdae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1116,16 +1116,10 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
  * @parent:  the parent
  * @mnt:     the new mount
  * @mp:      the new mountpoint
- * @beneath: whether to mount @mnt beneath or on top of @parent
  *
- * If @beneath is false, mount @mnt at @mp on @parent. Then attach @mnt
+ * Mount @mnt at @mp on @parent. Then attach @mnt
  * to @parent's child mount list and to @mount_hashtable.
  *
- * If @beneath is true, remove @mnt from its current parent and
- * mountpoint and mount it on @mp on @parent, and mount @parent on the
- * old parent and old mountpoint of @mnt. Finally, attach @parent to
- * @mnt_hashtable and @parent->mnt_parent->mnt_mounts.
- *
  * Note, when __attach_mnt() is called @mnt->mnt_parent already points
  * to the correct parent.
  *
@@ -1133,18 +1127,9 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
  *          to have been acquired in that order.
  */
 static void attach_mnt(struct mount *mnt, struct mount *parent,
-		       struct mountpoint *mp, bool beneath)
+		       struct mountpoint *mp)
 {
-	if (beneath)
-		mnt_set_mountpoint_beneath(mnt, parent, mp);
-	else
-		mnt_set_mountpoint(parent, mp, mnt);
-	/*
-	 * Note, @mnt->mnt_parent has to be used. If @mnt was mounted
-	 * beneath @parent then @mnt will need to be attached to
-	 * @parent's old parent, not @parent. IOW, @mnt->mnt_parent
-	 * isn't the same mount as @parent.
-	 */
+	mnt_set_mountpoint(parent, mp, mnt);
 	__attach_mnt(mnt, mnt->mnt_parent);
 }
 
@@ -1157,7 +1142,7 @@ void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct m
 	hlist_del_init(&mnt->mnt_mp_list);
 	hlist_del_init_rcu(&mnt->mnt_hash);
 
-	attach_mnt(mnt, parent, mp, false);
+	attach_mnt(mnt, parent, mp);
 
 	put_mountpoint(old_mp);
 	mnt_add_count(old_parent, -1);
@@ -2295,7 +2280,7 @@ struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 				goto out;
 			lock_mount_hash();
 			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
-			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
+			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp);
 			unlock_mount_hash();
 		}
 	}
@@ -2743,10 +2728,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	if (moving) {
-		if (beneath)
-			dest_mp = smp;
 		unhash_mnt(source_mnt);
-		attach_mnt(source_mnt, top_mnt, dest_mp, beneath);
+		if (beneath)
+			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
+		else
+			mnt_set_mountpoint(top_mnt, dest_mp, source_mnt);
+		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
@@ -4827,9 +4814,9 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		root_mnt->mnt.mnt_flags &= ~MNT_LOCKED;
 	}
 	/* mount old root on put_old */
-	attach_mnt(root_mnt, old_mnt, old_mp, false);
+	attach_mnt(root_mnt, old_mnt, old_mp);
 	/* mount new_root on / */
-	attach_mnt(new_mnt, root_parent, root_mp, false);
+	attach_mnt(new_mnt, root_parent, root_mp);
 	mnt_add_count(root_parent, -1);
 	touch_mnt_namespace(current->nsproxy->mnt_ns);
 	/* A moved mount should not expire automatically */
-- 
2.39.5


