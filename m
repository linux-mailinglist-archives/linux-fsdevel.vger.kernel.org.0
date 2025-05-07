Return-Path: <linux-fsdevel+bounces-48428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35104AAEDBA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 23:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A092C5003E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 21:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9EE28FFC2;
	Wed,  7 May 2025 21:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HAKNhiIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0DC7E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746652529; cv=none; b=rn2Z/fVQczkE1lcRHd/JHyrar0sKAkR/xwY5Bs6zxv5qE7g4eJFSIHh5rdtIYZAAE+BqIjyHbqtbeFNUOBRiOc7B/ZwC05lhpzInxn0RBS6rLdDO5cYKBvyMiSohu3lnmUo4hOZkJcNFSeExWRyoHaw9YDYg9u8Srdm5zJtFdQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746652529; c=relaxed/simple;
	bh=4mwrNEZcGwQ9wxQ+w8B1HmJrQDNN4brkNaPrtU70NsA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dddHudtlhUY46WR2TeiZnC1hybYdY5wfvHC+lBAw8wHp30HjY3jp5RiLM+88oZlALTaubY3TtXGwgm1kBHtXmt/I6mRdd90DkyvnG8XXGFlJ2dvfZU+HAulxpWNA3ITix1kw8PcaYFWGzKwoTY9FxYbjC0F30mhX89nbG8/0GYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HAKNhiIW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fDrtPjgJvedzKvDF7oXiyIHw9T0kg6hL7xXeQGL750U=; b=HAKNhiIWYYujLybHC0VhSLu4t3
	8AhnvIpHezoADwpi/qBdRA+ApAfIQZK18DsX4qDa742lakFrKIXtOBef+lQ0twlL1WKJ//o1jrw/L
	m90OzJvmwdxHdX0xTAGDw6SCvrqqUm6bBK9OU3URapvKqxLVAra4MIWt6RwaiujjvDkyMJUyQQUe/
	0mXhnI2B1Z21oWjFNZ6j5arUiuNF6A/+RP1Sk9tLoaRTQs2CTMOLHLp9B6V/07vrG96HVZHbcUjsT
	6eFeZYB3vaOQnSqwvIfiDN11z2W8/gki6t76Q7HRa3XM2ECK8ordYqOQF2f5p+rbXmLLRwosWJ/yR
	VwRbO2Nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCm6t-00000001bwE-26UZ;
	Wed, 07 May 2025 21:15:23 +0000
Date: Wed, 7 May 2025 22:15:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH][CFT][RFC] clone_mnt(): simplify the propagation-related
 logics
Message-ID: <20250507211523.GW2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

[
Help with testing and review would be very welcome; it does survive
xfstests and ltp.  No visible regressions on kselftests either.
IIRC, Christian mentioned some bunch of mount-related regression
tests somewhere; was that a part of kselftests, or is it something
separate?
]

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
diff --git a/fs/namespace.c b/fs/namespace.c
index 165b3bd26857..4456a6448b45 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1351,6 +1351,9 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	if (!mnt)
 		return ERR_PTR(-ENOMEM);
 
+	mnt->mnt.mnt_flags = READ_ONCE(old->mnt.mnt_flags) &
+			     ~MNT_INTERNAL_FLAGS;
+
 	if (flag & (CL_SLAVE | CL_PRIVATE | CL_SHARED_TO_SLAVE))
 		mnt->mnt_group_id = 0; /* not a peer of original */
 	else
@@ -1362,8 +1365,8 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 			goto out_free;
 	}
 
-	mnt->mnt.mnt_flags = old->mnt.mnt_flags;
-	mnt->mnt.mnt_flags &= ~(MNT_WRITE_HOLD|MNT_MARKED|MNT_INTERNAL|MNT_LOCKED);
+	if (mnt->mnt_group_id)
+		set_mnt_shared(mnt);
 
 	atomic_inc(&sb->s_active);
 	mnt->mnt.mnt_idmap = mnt_idmap_get(mnt_idmap(&old->mnt));
@@ -1376,22 +1379,20 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	list_add_tail(&mnt->mnt_instance, &sb->s_mounts);
 	unlock_mount_hash();
 
+	if (flag & CL_PRIVATE)	// we are done with it
+		return mnt;
+
+	if (mnt->mnt_group_id && mnt->mnt_group_id == old->mnt_group_id)
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
@@ -1399,7 +1400,6 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 		if (!list_empty(&old->mnt_expire))
 			list_add(&mnt->mnt_expire, &old->mnt_expire);
 	}
-
 	return mnt;
 
  out_free:

