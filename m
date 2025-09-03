Return-Path: <linux-fsdevel+bounces-60094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEEDB413F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701CA545DB0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A3C2D5410;
	Wed,  3 Sep 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EXCwsAqY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE02D8DCF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875350; cv=none; b=C3HY87jTdKYjGcKChR22AJ7lXjHxDBcsQRJ+c+WfBrxygJr0BtDJjkO8OXUhZ1rYDJXgdqJeMsqVyKxiSy3hZYJkBGqTrRmBjJT3ZwFdjwymOZyNKHFRHd/3v3IbWuLyhvaHX6XQyZ/p8xGrdcHImJEKNXpkDzR4iDVpp/SgFGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875350; c=relaxed/simple;
	bh=yUGElSr8ez0QjSXsoRhnHF6vXW4XwuDVE8PdgaiCGbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhZgOF9rUMrENFOrB01SaEETRoXigN9eJp/fXMSub5FHE0dOBvVMk71H/cOQK+2OxXVsUVUtRgyX5xRonXbLnLIQEqdX6uTSgSeVBBe4sSNOPdYPiLh8GUN9yBQ0CMaBt7ovDi10iTNPEjgmopZitf0OpZgPn4HaNEkpeRG030g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EXCwsAqY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Fbc+vRVigUpUatWHxufQA8pTmMakoKNtKuC1GkUEL4E=; b=EXCwsAqY3s3RNFcjMKJV1tThAA
	qVint/qihlUHGqCo5ywcqohFbxpH1HQhmyIot4nPi4PuMHN9aynme8V/FO9YRMOphjPs9nnxfYmCX
	w3ztLmyKNkCqSOhCRxNMyQk89PuDYYatJFFBNKTUBeFTUgE3BAzSbI2Nr/ffbeK9xSH74KNjL1EOK
	49mpSvY4JCTcj2VGM5jcqSyeH2Q8xYBVRaTi3/IJ8YOKCXjvjAFgz+6KTZONSBYbRDmRECXDhNar7
	uCv8RwLE9lH3qhVBkEotFZjGZT9SJgFwImJ2ZO3Kd655O4yR0TPtBdrN9dY318OQqqH5c3tOTLplE
	Wbi4owTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX9-0000000ApEo-0EH9;
	Wed, 03 Sep 2025 04:55:47 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 51/65] umount_tree(): take all victims out of propagation graph at once
Date: Wed,  3 Sep 2025 05:55:13 +0100
Message-ID: <20250903045537.2579614-52-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

For each removed mount we need to calculate where the slaves will end up.
To avoid duplicating that work, do it for all mounts to be removed
at once, taking the mounts themselves out of propagation graph as
we go, then do all transfers; the duplicate work on finding destinations
is avoided since if we run into a mount that already had destination found,
we don't need to trace the rest of the way.  That's guaranteed
O(removed mounts) for finding destinations and removing from propagation
graph and O(surviving mounts that have master removed) for transfers.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c |  3 ++-
 fs/pnode.c     | 67 +++++++++++++++++++++++++++++++++++++++-----------
 fs/pnode.h     |  1 +
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f977438b4d6e..0900fd7456a9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1846,6 +1846,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 	if (how & UMOUNT_PROPAGATE)
 		propagate_umount(&tmp_list);
 
+	bulk_make_private(&tmp_list);
+
 	while (!list_empty(&tmp_list)) {
 		struct mnt_namespace *ns;
 		bool disconnect;
@@ -1870,7 +1872,6 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 				umount_mnt(p);
 			}
 		}
-		change_mnt_propagation(p, MS_PRIVATE);
 		if (disconnect)
 			hlist_add_head(&p->mnt_umount, &unmounted);
 
diff --git a/fs/pnode.c b/fs/pnode.c
index edaf9d9d0eaf..5d91c3e58d2a 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -71,19 +71,6 @@ static inline bool will_be_unmounted(struct mount *m)
 	return m->mnt.mnt_flags & MNT_UMOUNT;
 }
 
-static struct mount *propagation_source(struct mount *mnt)
-{
-	do {
-		struct mount *m;
-		for (m = next_peer(mnt); m != mnt; m = next_peer(m)) {
-			if (!will_be_unmounted(m))
-				return m;
-		}
-		mnt = mnt->mnt_master;
-	} while (mnt && will_be_unmounted(mnt));
-	return mnt;
-}
-
 static void transfer_propagation(struct mount *mnt, struct mount *to)
 {
 	struct hlist_node *p = NULL, *n;
@@ -112,11 +99,10 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		return;
 	}
 	if (IS_MNT_SHARED(mnt)) {
-		if (type == MS_SLAVE || !hlist_empty(&mnt->mnt_slave_list))
-			m = propagation_source(mnt);
 		if (list_empty(&mnt->mnt_share)) {
 			mnt_release_group_id(mnt);
 		} else {
+			m = next_peer(mnt);
 			list_del_init(&mnt->mnt_share);
 			mnt->mnt_group_id = 0;
 		}
@@ -137,6 +123,57 @@ void change_mnt_propagation(struct mount *mnt, int type)
 	}
 }
 
+static struct mount *trace_transfers(struct mount *m)
+{
+	while (1) {
+		struct mount *next = next_peer(m);
+
+		if (next != m) {
+			list_del_init(&m->mnt_share);
+			m->mnt_group_id = 0;
+			m->mnt_master = next;
+		} else {
+			if (IS_MNT_SHARED(m))
+				mnt_release_group_id(m);
+			next = m->mnt_master;
+		}
+		hlist_del_init(&m->mnt_slave);
+		CLEAR_MNT_SHARED(m);
+		SET_MNT_MARK(m);
+
+		if (!next || !will_be_unmounted(next))
+			return next;
+		if (IS_MNT_MARKED(next))
+			return next->mnt_master;
+		m = next;
+	}
+}
+
+static void set_destinations(struct mount *m, struct mount *master)
+{
+	struct mount *next;
+
+	while ((next = m->mnt_master) != master) {
+		m->mnt_master = master;
+		m = next;
+	}
+}
+
+void bulk_make_private(struct list_head *set)
+{
+	struct mount *m;
+
+	list_for_each_entry(m, set, mnt_list)
+		if (!IS_MNT_MARKED(m))
+			set_destinations(m, trace_transfers(m));
+
+	list_for_each_entry(m, set, mnt_list) {
+		transfer_propagation(m, m->mnt_master);
+		m->mnt_master = NULL;
+		CLEAR_MNT_MARK(m);
+	}
+}
+
 static struct mount *__propagation_next(struct mount *m,
 					 struct mount *origin)
 {
diff --git a/fs/pnode.h b/fs/pnode.h
index 00ab153e3e9d..b029db225f33 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -42,6 +42,7 @@ static inline bool peers(const struct mount *m1, const struct mount *m2)
 }
 
 void change_mnt_propagation(struct mount *, int);
+void bulk_make_private(struct list_head *);
 int propagate_mnt(struct mount *, struct mountpoint *, struct mount *,
 		struct hlist_head *);
 void propagate_umount(struct list_head *);
-- 
2.47.2


