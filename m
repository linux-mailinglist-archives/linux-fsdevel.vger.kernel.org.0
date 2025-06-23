Return-Path: <linux-fsdevel+bounces-52451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA237AE347B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF2B189057F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D691C8612;
	Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bPzvKwNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16C51D514E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654474; cv=none; b=t+nk8md8MO3Apdk4RBzduFFPv8xtX4OGkgVc93Gx0fI/6nU+JGO6gKkenJ4MPDmb6a80Gk/duR8pssyO8/5m70g8eII9QAjhgmKq0+6Loktqp86ajuGjL6hBUbfGKpivtdcsy3rBQnson9cKrrZO7PjRpLxhQgqnpiEUfEKu07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654474; c=relaxed/simple;
	bh=DxulllJ0PrtuWV3bhNdxOrG+0rTbAxRsJSXOJI0K1lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS0b4XbMcM8svk9MfgByA9DSMEYm7jWlMuXwn/u/KiyaUzryAsY2L8zKHGKYrBTZqNIlDK7Wqvh4UxRd7SchdPOAnA2Mdv3PTr0w5QhAz5aXIIlZMQEtK1R2nBT2wXqc0KYhoSKzUPkZQEvtWZJ3h3XXgb6u0VDZMd9Y7F4Vse4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bPzvKwNx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O7JA4CXA8jZbnroRCvYYXoatJBhd3XGZ16/CfqQppoo=; b=bPzvKwNxJYVA8koF3DvFjCZus5
	Vb6DEH+PdL1OK5usza1OCkZ4GVigPN9RhrhmdT9dU01QMN8mp3G7sNmMeWQEITs0+Ji+zA3vuE9sN
	o/LBoCP3ZSzofRTbQFxStLuMfGoxT0hB+G0wNKLKEWarqJKS/aHXmx78I07OSYN2xzO8DSUk2FsWO
	fgpaVLIDVLExQKUI2wLkYRNW35QYPWP6AbqdaMY8iGi75whF4GK9jnOQyq61U0o2urhMfwRm/OhoF
	YDjw0+lwtaKM4qVBZw+DN/zVHYWoVJs9buNdTjL7bd+uBRbHhwVi7NC3Ebpqx4N1wfw2iRSP8iWQF
	I3T0VRnQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCQ-00000005KrV-3nqu;
	Mon, 23 Jun 2025 04:54:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 19/35] make commit_tree() usable in same-namespace move case
Date: Mon, 23 Jun 2025 05:54:12 +0100
Message-ID: <20250623045428.1271612-19-viro@zeniv.linux.org.uk>
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

Once attach_recursive_mnt() has created all copies of original subtree,
it needs to put them in place(s).

Steps needed for those are slightly different:
	1) in 'move' case, original copy doesn't need any rbtree
manipulations (everything's already in the same namespace where it will
be), but it needs to be detached from the current location
	2) in 'attach' case, original may be in anon namespace; if it is,
all those mounts need to removed from their current namespace before
insertion into the target one
	3) additional copies have a couple of extra twists - in case
of cross-userns propagation we need to lock everything other the root of
subtree and in case when we end up inserting under an existing mount,
that mount needs to be found (for original copy we have it explicitly
passed by the caller).

Quite a bit of that can be unified; as the first step, make commit_tree()
helper (inserting mounts into namespace, hashing the root of subtree
and marking the namespace as updated) usable in all cases; (2) and (3)
are already using it and for (1) we only need to make the insertion of
mounts into namespace conditional.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d99c05f7031f..a73f16926830 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1172,15 +1172,17 @@ static void commit_tree(struct mount *mnt)
 
 	BUG_ON(parent == mnt);
 
-	list_add_tail(&head, &mnt->mnt_list);
-	while (!list_empty(&head)) {
-		m = list_first_entry(&head, typeof(*m), mnt_list);
-		list_del(&m->mnt_list);
+	if (!mnt_ns_attached(mnt)) {
+		list_add_tail(&head, &mnt->mnt_list);
+		while (!list_empty(&head)) {
+			m = list_first_entry(&head, typeof(*m), mnt_list);
+			list_del(&m->mnt_list);
 
-		mnt_add_to_ns(n, m);
+			mnt_add_to_ns(n, m);
+		}
+		n->nr_mounts += n->pending_mounts;
+		n->pending_mounts = 0;
 	}
-	n->nr_mounts += n->pending_mounts;
-	n->pending_mounts = 0;
 
 	make_visible(mnt);
 	touch_mnt_namespace(n);
@@ -2691,12 +2693,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 	if (moving) {
 		unhash_mnt(source_mnt);
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		if (beneath)
-			mnt_change_mountpoint(top, smp, top_mnt);
-		make_visible(source_mnt);
 		mnt_notify_add(source_mnt);
-		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
 		if (source_mnt->mnt_ns) {
 			LIST_HEAD(head);
@@ -2706,12 +2703,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				move_from_ns(p, &head);
 			list_del_init(&head);
 		}
-		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		if (beneath)
-			mnt_change_mountpoint(top, smp, top_mnt);
-		commit_tree(source_mnt);
 	}
 
+	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+	if (beneath)
+		mnt_change_mountpoint(top, smp, top_mnt);
+	commit_tree(source_mnt);
+
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
 		hlist_del_init(&child->mnt_hash);
-- 
2.39.5


