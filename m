Return-Path: <linux-fsdevel+bounces-58951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEE3B33596
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C7E1B23D9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F6128641E;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bNEHxK3X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A02272E61
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097046; cv=none; b=cVDf3KLpNMX0kV0vZb8k1J/FGMtv0oWwnlnLrM5g8WP+9dsofANj/6i8esP6qwNAIB5BBITOKVhx7tJpK+NrZEFsmoeL5WiQ19xTc1aM6RjDdfBVpFHbSjZClOIIjTgNd3LTT5C0i8z4kyJ7vxTU3OpiAatoB6Yci/mg7w54Vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097046; c=relaxed/simple;
	bh=3ekp/p2YaBXToMxhgtwMUrJs3+Tim1xxlXSVp3DznZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLGmMq31uojUPjGtsKDeHNN+1myx3tNS7sQ1uKy3ZAQvifvuC8PwW6IJheM5k464N8z0Dr3W5tH8OKQm0t3aFXyz11SKInivEs+wns0q4I/5+YZNputMZ7zuuBpg0KsrLLc1aLqJzXJ+/OTKRlthYvl79oBEmYH9MBbAdGQeVIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bNEHxK3X; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4IlXKN5WGQxWb8/OUjinOKCIaJ5jcEloNw672kecbRI=; b=bNEHxK3XVE9vreuns9I23fOjV2
	3+6D6th14ErSZJ0VXJWvXBtnX/wUo2WFYT1Rj9TWVF8/A00/FDcIodvJYaCjTyq4jZUyCvnGohi7L
	fhzXnKqlqH9iS7jdI8HbWb6C2heQ/JIaXA6Xl2MaZHgYk6azgAFGtGa/1NVz9jXUaeOwAI4f1h5Vs
	3bsU5mJdK4JI8IddWXSf739DjNWtdPPsGkgHwneFqX5F8MtQWNuMrgmETAWEr7MT19/Q/irEU0BM2
	bwErtHxChcFj/13mL5F3iINJwtpTjvQFxiTboDdRFsqsIbr4cOIVXJfl7YnbTx/sfg8XbNkdHg+GS
	y8Rrg2gA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3q-00000006TFv-0979;
	Mon, 25 Aug 2025 04:44:02 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 50/52] umount_tree(): take all victims out of propagation graph at once
Date: Mon, 25 Aug 2025 05:43:53 +0100
Message-ID: <20250825044355.1541941-50-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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
index d8554742b1c0..82cab5459ec7 100644
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


