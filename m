Return-Path: <linux-fsdevel+bounces-51128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB20AD3002
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368421893221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1E283142;
	Tue, 10 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SBruGkQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4511280317
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543714; cv=none; b=fpxq34q2J9iwl20KMCyvuWMiS/ux22u+Jocx01jAJXl/FD6XEllBZf2LIyatOLV4dgOXRtzLTY25Vs95NModSXDk1iBc+dZ25V5AvOxXnSBRdA9+baCVaBrX1Xaab3OXH/Gv5BCDNS/GdRIeOEINmKUZq3FJXM92xAQsCfn1C3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543714; c=relaxed/simple;
	bh=hm+sYrKB1/FnBj/FnxdAokKxS7bPZXDUJ55gQ5eynl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt7G0pRAXSDTwXGJpwkjMampo8EXapSw6V9to9uO5VAW2V1pKf7BrA+v+2FbMOgbpf48xdcEglId5UdNL0F/iHVTU/tcbFI5Ck/a4IHs/Neafh8Uh+P/39i25wItkNgPf44USgZL3PlL410Jjyuv2yZsVWyVSU6Pt51q8SALXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SBruGkQJ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HS3dZNNGFLJVpLglAmVDCU5I1Q8RMM1+E1e8GtNRMRs=; b=SBruGkQJX08VAayFHQZ+Srgy+K
	IFmnqCuSjUh21zlKTFCIlA7pJiV/96rsCIwDgTIOlYSwKNAESfCrqsh7pyJX99kfVH/fBZ7QGwgaC
	/MhHgjtiNz+qV8L89De26o2iZoc45PC4jIi3F5iHwkgDXJv3638R15/1euNKmjE3hcYwNxT5E6FKf
	mgI2WB11MR/XgfkQJZBFtevCtMPZfTmAJACT7BC0xDr4qvwucxVeyPeb4yCusS6PvDmb16WraVOCl
	a2A2jvsNvyFMtXV/VWnDm2izgqvyXfKa/4kFSns+MVLmPjQysfrBOQ2hfev9ELZk7fHpdRuDAfsGs
	kizwAU0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jM2-1H7U;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 09/26] clone_mnt(): simplify the propagation-related logics
Date: Tue, 10 Jun 2025 09:21:31 +0100
Message-ID: <20250610082148.1127550-9-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d6c81eab6a11..02e9f37f49b9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1337,6 +1337,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
+	mnt->mnt.mnt_flags = READ_ONCE(old->mnt.mnt_flags) &
+			     ~MNT_INTERNAL_FLAGS;
+
 	if (flag & (CL_SLAVE | CL_PRIVATE | CL_SHARED_TO_SLAVE))
 		mnt->mnt_group_id = 0; /* not a peer of original */
 	else
@@ -1348,8 +1351,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
+	if (mnt->mnt_group_id)
+		set_mnt_shared(mnt);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1362,22 +1365,20 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
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
@@ -1385,7 +1386,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		if (!list_empty(&old->mnt_expire))
 			list_add(&mnt->mnt_expire, &old->mnt_expire);
 	}
-
 	return mnt;
 
  out_free:
-- 
2.39.5


