Return-Path: <linux-fsdevel+bounces-53259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87644AED29A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E60ED1888E9E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A31E1F4CA4;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mTEAouAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E7F19C560
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251981; cv=none; b=I0tMMluWmuogY5DCcTH5rp1YhcGdQd3FMIFX1Xaa3p3wFCAkJD+0GZ40XCvyyscqxUzSvzdQ7NXnWbtEa7ATswTfuFupzBcJqCO9a2/soKAnDhPmY519+2Z/Yop5x2yf0jno9k/2MbpW+4EKVO3b9H3BxEJIgIGNxXnjqDMrcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251981; c=relaxed/simple;
	bh=ooUK3nXW3HHloapkIpwsk5O2+FG4qIeovv+hduLwYnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hziQVTReB9TLfng5dBTRjVrEOZkZtWOVW5+pNGRgWiLN34ku4LCuNazAjpEtidKu7H/npVVezy4JqjZn5x+ArAJsGrS1mmeGdmJB0ERB+KFzZyq0PfnMB7Dniv1AZg7J69lHL7s0d4UAF04OYC2wjhKZktHuz5gRk4fAKnug/k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mTEAouAa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=woPM57fIwY7BjEjIQ5oZNvUk4/rXb9NqFCzXkLBpl4k=; b=mTEAouAaaGn36nDgFEMutJ3Io2
	r4uO4CLFJOVLGvo9tQ0ctkvzGT66qAr4o/5tGT1m8dg7g76vl1qh/4PKm9+mZ3Aofchm3xsOHcedn
	VUpTIXxVAcJVqlZxfxToAdhnpdKGeZCVt/+lhRVhC6ITMc0OIsP6fHsDenml27UsqbFp0Ky8pHE11
	Eup9oIqEkJegn4U6K4wrl0IXi7p9WAx8ypctRcauuvRKVgqLQcBIJBKCjVTsWuVw9/MFWgoiozREF
	80g56rHA/btQonU+ISNrHNFFSQlZHh1OB21hJbSnSMUpWmbC35uA4RoantEYIBy9SE/a1g6hEFYMN
	sET3easw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005ozq-23Wa;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 20/48] attach_recursive_mnt(): get rid of flags entirely
Date: Mon, 30 Jun 2025 03:52:27 +0100
Message-ID: <20250630025255.1387419-20-viro@zeniv.linux.org.uk>
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

move vs. attach is trivially detected as mnt_has_parent(source_mnt)...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 449e66436b4f..adb37f06ba68 100644
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


