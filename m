Return-Path: <linux-fsdevel+bounces-53281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92451AED2B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFB291895419
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C5421B9F5;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kpBD8kFr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BF17A30B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=W75lQyR5gnhkE+wVo1+wEiYenncT9JbDHYeG0VIMLnOFA81c9+l0V8uX+WfTo2y74ztwB82GZswf+uHi6hUM72469ctldK0iqqz60Zs4xIkXi8TMKIUHMW4AgBdul/r3asFWhVrxTFm5lhwC+oX12sTqU7iuY2GXbSBh/PnlkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=8MDSxBIV0HLze+PmCrrqD8CVXkmZkgTM/GkNRp1ZDMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKLV6V7eDw4uT67sww3g8izbf53+OBPfYeR8TowvykA3vvK/8vyXv4yLSn2ClapVy5JFOmy6A/h3pWSVYOlqxUCHFGBAM+/r9V7PT9aZi8V2RrWJcTAHM2Wmbe8Nf5TRNGTUf9QylJsHyodGx3P18wN6zTpX2cyN/dnhZxlhLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kpBD8kFr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jQkossz0M3HQ7lMBr9I9r1FBbz2B1dezw8nIIekO7bk=; b=kpBD8kFrE+8Z2W6qfZ8ohiiOfA
	SBEhQmh4X8AlZ/XKGOTxn2Ena2eJ4aP2pdyEGbz+dFsuwYUUcF5SqbIgocuFMYLfmqv8YXLLuXc6s
	OafHeoIXgW3pZBM0I+oVzWTJlx6Ucuur59aAGEGxy8SIa++3ydNWLCFLwByokV0R04TTkYIcNHwkg
	Ok2tmvjBjeEDoMPE85d/pANqBtzhqkg2fbb7jdYqZ7rYh3Iq+ar+OCb6daFCPrZhNAl4CuRUwqGdg
	a9ilad92YABFIBl4C+AFwFbkKkywK8G4o4Q1YkKPoNsJfrDKwW8gBc6q4qqIa6Nm13j9x9e4oVI99
	P4207UmA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p2e-14lv;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 40/48] do_make_slave(): choose new master sanely
Date: Mon, 30 Jun 2025 03:52:47 +0100
Message-ID: <20250630025255.1387419-40-viro@zeniv.linux.org.uk>
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

When mount changes propagation type so that it doesn't propagate
events any more (MS_PRIVATE, MS_SLAVE, MS_UNBINDABLE), we need
to make sure that event propagation between other mounts is
unaffected.

We need to make sure that events from peers and master of that mount
(if any) still reach everything that used to be on its ->mnt_slave_list.

If mount has neither peers nor master, we simply need to dissolve
its ->mnt_slave_list and clear ->mnt_master of everything in there.

If mount has peers, we transfer everything in ->mnt_slave_list of
this mount into that of some of those peers (and adjust ->mnt_master
accordingly).

If mount has a master but no peers, we transfer everything in
->mnt_slave_list of this mount into that of its master (adjusting
->mnt_master, etc.).

There are two problems with the current implementation:
	* there's a long-obsolete logics in choosing the peer -
once upon a time it made sense to prefer the peer that had the
same ->mnt_root as our mount, but that had been pointless since
2014 ("smarter propagate_mnt()")
	* the most common caller of that thing is umount_tree()
taking the mounts out of propagation graph.  In that case it's
possible to have ->mnt_slave_list contents moved many times,
since the replacement master is likely to be taken out by the
same umount_tree(), etc.

Take the choice of replacement master into a separate function
(propagation_source()) and teach it to skip the candidates that
are going to be taken out.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 62 +++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 9723f05cda5f..91d10af867bd 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -65,40 +65,45 @@ int get_dominating_id(struct mount *mnt, const struct path *root)
 	return 0;
 }
 
+static inline bool will_be_unmounted(struct mount *m)
+{
+	return m->mnt.mnt_flags & MNT_UMOUNT;
+}
+
+static struct mount *propagation_source(struct mount *mnt)
+{
+	do {
+		struct mount *m;
+		for (m = next_peer(mnt); m != mnt; m = next_peer(m)) {
+			if (!will_be_unmounted(m))
+				return m;
+		}
+		mnt = mnt->mnt_master;
+	} while (mnt && will_be_unmounted(mnt));
+	return mnt;
+}
+
 static int do_make_slave(struct mount *mnt)
 {
-	struct mount *master, *slave_mnt;
+	struct mount *master = propagation_source(mnt);
+	struct mount *slave_mnt;
 
 	if (list_empty(&mnt->mnt_share)) {
 		mnt_release_group_id(mnt);
-		CLEAR_MNT_SHARED(mnt);
-		master = mnt->mnt_master;
-		if (!master) {
-			struct list_head *p = &mnt->mnt_slave_list;
-			while (!list_empty(p)) {
-				slave_mnt = list_first_entry(p,
-						struct mount, mnt_slave);
-				list_del_init(&slave_mnt->mnt_slave);
-				slave_mnt->mnt_master = NULL;
-			}
-			return 0;
-		}
 	} else {
-		struct mount *m;
-		/*
-		 * slave 'mnt' to a peer mount that has the
-		 * same root dentry. If none is available then
-		 * slave it to anything that is available.
-		 */
-		for (m = master = next_peer(mnt); m != mnt; m = next_peer(m)) {
-			if (m->mnt.mnt_root == mnt->mnt.mnt_root) {
-				master = m;
-				break;
-			}
-		}
 		list_del_init(&mnt->mnt_share);
 		mnt->mnt_group_id = 0;
-		CLEAR_MNT_SHARED(mnt);
+	}
+	CLEAR_MNT_SHARED(mnt);
+	if (!master) {
+		struct list_head *p = &mnt->mnt_slave_list;
+		while (!list_empty(p)) {
+			slave_mnt = list_first_entry(p,
+					struct mount, mnt_slave);
+			list_del_init(&slave_mnt->mnt_slave);
+			slave_mnt->mnt_master = NULL;
+		}
+		return 0;
 	}
 	list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
 		slave_mnt->mnt_master = master;
@@ -443,11 +448,6 @@ static inline bool is_candidate(struct mount *m)
 	return m->mnt_t_flags & T_UMOUNT_CANDIDATE;
 }
 
-static inline bool will_be_unmounted(struct mount *m)
-{
-	return m->mnt.mnt_flags & MNT_UMOUNT;
-}
-
 static void umount_one(struct mount *m, struct list_head *to_umount)
 {
 	m->mnt.mnt_flags |= MNT_UMOUNT;
-- 
2.39.5


