Return-Path: <linux-fsdevel+bounces-52460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BB7AE3483
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84F03B0836
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDE81F03D9;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Jp6HAe2s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD771D86DC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654476; cv=none; b=N6IO57IHp8HDOOLHYUzNLClbq6MBIq2ETaHR5bP4DcUf34yncZSHPGuijk4tqe5jB5kPaGl09iODdwoUNewTHkNXZXiQ4PRkYVGgKPB0xJa+4A/GtJsGimwXusG7DA86GMK3M5e8qpQ3tlZeRb053KT8hfnrs9IRtr3YIpTXP7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654476; c=relaxed/simple;
	bh=56jXBSkoLaoNnCc0ZpCBB3Cl7A49YKu8VToyiDkIQX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCse/KryruuAp2geTJUCVzpRNJdvHI2lsPReI2kBgotu6rjeYYEj9ce40H+ORgO1UimRVFVAPpRy6P3fgcPKeZnI1StP30s09zOfu381J2qgLgpG5Fze2xioux6dHKdj8kNCpnPyKxHRUj8wc/TnTQjDidzUWciXMAdDTpbqoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Jp6HAe2s; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=I26i5zp9a91hxnKJMFs92PNeButVIDZs5e3hqgtPMOA=; b=Jp6HAe2spzcgHZJNwxyIlCu4yq
	7CGbERc1K78LgSLsFrULspN2y4tWur8S2IIdb6Haz3PKrT2XvYPSe6tA0I4nYY7084c78eI7nrwXG
	mrFnhXIjmsNqlJVTHdjt/TujTQFu6PPvkiVc3GmYVC1h10VEfKoS8GKKkmX+/3lNlQOrHUGgNEyxd
	hk5g5PLXpwmre8v5Kdj9fP4CQJ9kUz6u6s8Afq3t8VrtnNPh/kv/DuAkbk/lCoo6V5FjYMlBNxM3B
	QaRVPFPTWXtbissFrxFdUgolxF7ElgVc1U9r+iPWsy3s5AhYio5OB4AUFu779nFnDe+20ObxomRwS
	4wFJOYNQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCR-00000005KsI-2iy3;
	Mon, 23 Jun 2025 04:54:31 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 22/35] attach_recursive_mnt(): get rid of flags entirely
Date: Mon, 23 Jun 2025 05:54:15 +0100
Message-ID: <20250623045428.1271612-22-viro@zeniv.linux.org.uk>
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

move vs. attach is trivially detected as mnt_has_parent(source_mnt)...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index be3bfd99dc46..f9b320975cac 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2562,9 +2562,8 @@ int count_mounts(struct mnt_namespace *ns, struct mount *mnt)
 }
 
 enum mnt_tree_flags_t {
-	MNT_TREE_MOVE = BIT(0),
-	MNT_TREE_BENEATH = BIT(1),
-	MNT_TREE_PROPAGATION = BIT(2),
+	MNT_TREE_BENEATH = BIT(0),
+	MNT_TREE_PROPAGATION = BIT(1),
 };
 
 /**
@@ -2572,7 +2571,6 @@ enum mnt_tree_flags_t {
  * @source_mnt: mount tree to be attached
  * @dest_mnt:   mount that @source_mnt will be mounted on
  * @dest_mp:    the mountpoint @source_mnt will be mounted at
- * @flags:      modify how @source_mnt is supposed to be attached
  *
  *  NOTE: in the table below explains the semantics when a source mount
  *  of a given type is attached to a destination mount of a given type.
@@ -2636,8 +2634,7 @@ enum mnt_tree_flags_t {
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
 				struct mount *dest_mnt,
-				struct mountpoint *dest_mp,
-				enum mnt_tree_flags_t flags)
+				struct mountpoint *dest_mp)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
@@ -2648,7 +2645,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	struct mount *top;
 	struct hlist_node *n;
 	int err = 0;
-	bool moving = flags & MNT_TREE_MOVE;
+	bool moving = mnt_has_parent(source_mnt);
 
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
@@ -2871,7 +2868,7 @@ static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp, 0);
+	return attach_recursive_mnt(mnt, p, mp);
 }
 
 /*
@@ -3613,8 +3610,6 @@ static int do_move_mount(struct path *old_path,
 	p = real_mount(new_path->mnt);
 	parent = old->mnt_parent;
 	attached = mnt_has_parent(old);
-	if (attached)
-		flags |= MNT_TREE_MOVE;
 	old_mp = old->mnt_mp;
 	ns = old->mnt_ns;
 
@@ -3668,7 +3663,6 @@ static int do_move_mount(struct path *old_path,
 
 		err = -EINVAL;
 		p = p->mnt_parent;
-		flags |= MNT_TREE_BENEATH;
 	}
 
 	/*
@@ -3683,7 +3677,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, p, mp, flags);
+	err = attach_recursive_mnt(old, p, mp);
 	if (err)
 		goto out;
 
-- 
2.39.5


