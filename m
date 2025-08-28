Return-Path: <linux-fsdevel+bounces-59574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF127B3AE2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945E6583EEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD352FC874;
	Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bJeiK1Za"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C652F3625
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422497; cv=none; b=YAJ3+Smi5g1gbqS0bBO49g3GeFjR2SyPO4IRRisvSLtMNZamEYmEvQh8wXgCUUTfINwiR4ZQ3tE1uRkh6GaCdUUU9fsFIWFQJJ4fDr9Yk57VB+HXOLOB3t6AxOlTZJAruOniCBfvbPCXiQg0joGwhIU5F4X/whqiQL0jKyyvHX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422497; c=relaxed/simple;
	bh=lZB5kiLrDPqCjyyiACbBIqhaAcWlizbp4DGzbxQnkqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKcOPjofLWddxGh/tfS0s/50OnN4dJfaBNH8+yiQdQgSFo0LtOYDT+mls43KGi4yT+BKlSrtVAULHAQzy+IKiXFHS0cfMCqV6FAL1VxlSU+6JOy3BLxy8CGt74FVT37Vhp4TAeFJW3pY8Z2VQPNmPDy/jL5lvzPtkbi5Uc2pXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bJeiK1Za; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+RIPUKskIWwWB92n0j6nijl7/TJ/3skO6zNkHA1e/XY=; b=bJeiK1ZafKD1hkHJy/W5yA0mI6
	cdcUFZJsXgA2dx3qh7G7HVl5KvVVbfS5Rzks8uT3JTqK0c0Tmo0PpZv02asAAARzmDvXSLaf3LuaY
	Iv/932dn+Sfp7fjBGzv7oWyzxeOXMS9wTgYrD6fEPnJzdXDicZxFggBQ4YKtQzWk1Aus6XDK2U/Qa
	7j1f8axR58hess8r2ufrcYm0xbyIy29lo6MRimilCcsImRglawwhpB1qUsLj3vjVqI1ju0saQLnjL
	0ABi8XAGiDxSkPmby22n2LuSxRwQ4wcJl4gqzaBuR6BlTkvEe6jpWJdgnreQ20MRs+K7L5Lg5VURv
	eSu0p4Mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj4-0000000F29O-08ak;
	Thu, 28 Aug 2025 23:08:14 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 51/63] umount_tree(): take all victims out of propagation graph at once
Date: Fri, 29 Aug 2025 00:07:54 +0100
Message-ID: <20250828230806.3582485-51-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c |  3 ++-
 fs/pnode.c     | 67 +++++++++++++++++++++++++++++++++++++++-----------
 fs/pnode.h     |  1 +
 3 files changed, 55 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b290e2b3bcfb..de9a88f45dc1 100644
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


