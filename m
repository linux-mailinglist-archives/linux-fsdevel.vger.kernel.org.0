Return-Path: <linux-fsdevel+bounces-53250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6209FAED28E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F11F18912AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAACE1D79A5;
	Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="orc8WaTW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6361940A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=qrqKVIrkGILH1Iduon11FCZynMlK9L3+yFFIEdaem4tpiF8XFnw4QOWRQ4ibgO9Y2zFTx7ujzUd3c2d0opDstQVo8cmkiU2zm3fAGqDHBYa0SKXrkyVLG/lqHCDdbR87YGst0yBX/YyF9W4VRR4Z1S1Se6LIo3/N3PsvpmdgDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=dgCXhTO9HiAchyjc1JO5nt3pMTajyCCzbBVILYUN19U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGC+K9jqz5mEjicfcM7NPODN6aKbRml+azX+JMsSUVNYZKDyEr+j2d8tqegPtnnNj8aCpNDF+Hs8SAhpa/Mhj3zN9GGN4T2J+I5parKL5il5X2DppdL9otPKj3nl+JzliHac3LzBccpVLfmUnhFmJLHpXSTMSSp6EWlFiMKmIS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=orc8WaTW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pjneicZ1f4nopB5RSwe7TjLEQ7rUgZQLlmopoFLzuto=; b=orc8WaTWAYp8HDY0id1EeNRXu/
	mUbPloBHkt6ArGAY6IFCE1EF+AHvhhv9EIWCzzt/Ilai1I8dG/xZh1SZLKYZVPVT0AV/4jDSL8ZXD
	PL5V0vgM3VYBp7CfIy673TeiKybgFQgqx8PRr9W880sr0Ih+Zm2yK5J5Xq95HBd+b04zMSqjE6r2Q
	jsvGDZq2BbZIYYkYGFLgokkYlOA/BL9exruc/0OWhO7ZI/QwDcUBim9EYP91a475aThJcxneCFi7z
	fIT4Au1dYussgsfzU/doESKSljw9d15FgG/FqXrv5cGAV+qdghv32AQhwJlC5o1sg83szbD32nwkc
	ct/fYJMA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005ox6-28yl;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 13/48] clone_mnt(): simplify the propagation-related logics
Date: Mon, 30 Jun 2025 03:52:20 +0100
Message-ID: <20250630025255.1387419-13-viro@zeniv.linux.org.uk>
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

The underlying rules are simple:
	* MNT_SHARED should be set iff ->mnt_group_id of new mount ends up
non-zero.
	* mounts should be on the same ->mnt_share cyclic list iff they have
the same non-zero ->mnt_group_id value.
	* CL_PRIVATE is mutually exclusive with MNT_SHARED, MNT_SLAVE,
MNT_SHARED_TO_SLAVE and MNT_EXPIRE; the whole point of that thing is to
get a clone of old mount that would *not* be on any namespace-related
lists.

The above allows to make the logics more straightforward; what's more,
it makes the proof that invariants are maintained much simpler.
The variant in mainline is safe (aside of a very narrow race with
unsafe modification of mnt_flags right after we had the mount exposed
in superblock's ->s_mounts; theoretically it can race with ro remount
of the original, but it's not easy to hit), but proof of its correctness
is really unpleasant.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 791904128f1e..12cf69da4320 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1301,6 +1301,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
+	mnt->mnt.mnt_flags = READ_ONCE(old->mnt.mnt_flags) &
+			     ~MNT_INTERNAL_FLAGS;
+
 	if (flag & (CL_SLAVE | CL_PRIVATE | CL_SHARED_TO_SLAVE))
 		mnt->mnt_group_id = 0; /* not a peer of original */
 	else
@@ -1312,8 +1315,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
+	if (mnt->mnt_group_id)
+		set_mnt_shared(mnt);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1326,22 +1329,20 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
 
+	if (flag & CL_PRIVATE)	// we are done with it
+		return mnt;
+
+	if (peers(mnt, old))
+		list_add(&mnt->mnt_share, &old->mnt_share);
+
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
 		list_add(&mnt->mnt_slave, &old->mnt_slave_list);
 		mnt->mnt_master = old;
-		CLEAR_MNT_SHARED(mnt);
-	} else if (!(flag & CL_PRIVATE)) {
-		if ((flag & CL_MAKE_SHARED) || IS_MNT_SHARED(old))
-			list_add(&mnt->mnt_share, &old->mnt_share);
-		if (IS_MNT_SLAVE(old))
-			list_add(&mnt->mnt_slave, &old->mnt_slave);
+	} else if (IS_MNT_SLAVE(old)) {
+		list_add(&mnt->mnt_slave, &old->mnt_slave);
 		mnt->mnt_master = old->mnt_master;
-	} else {
-		CLEAR_MNT_SHARED(mnt);
 	}
-	if (flag & CL_MAKE_SHARED)
-		set_mnt_shared(mnt);
 
 	/* stick the duplicate mount on the same expiry list
 	 * as the original if that was on one */
@@ -1349,7 +1350,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		if (!list_empty(&old->mnt_expire))
 			list_add(&mnt->mnt_expire, &old->mnt_expire);
 	}
-
 	return mnt;
 
  out_free:
-- 
2.39.5


