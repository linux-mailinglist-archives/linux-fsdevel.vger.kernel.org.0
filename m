Return-Path: <linux-fsdevel+bounces-53260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164D4AED29F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964E818952EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCB71F582F;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bVyN9y2W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7F19CC28
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251981; cv=none; b=S47LbphDkC0TcnsO4dkjwDZ2mcm9aUjOMj6VxwO4FScR2jQUE7tm8eWHxHK6VB2RbSzgx0iVrt0jxbkS2XyJX7uC0eX05gy0S8PWUoCJcO8TE98HU4b6fkt2AJ0VsINGzBmhcmA1Boh+lAAaMSbqUccCAUIF42KXbUAYO/Fvr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251981; c=relaxed/simple;
	bh=6So6AiLdCkuDlklRGnnH0xAi5kKvJbe7wirufZoaAcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu9EwHjeaScgasFK+IAYWOsHaZ5QIoX00QaXQABRLBfQqCCYcEG6pneDdr8vOpFqIbs0F+e4VQiTb8nzaSjIYv7k0pRJTb7sNaZ37hI502hNG20Z+NelXIVHQaJPkBI/PIOHdNB1ZjKBRpx71rSQ5CwRJ9H/iN/hLoXQKd6TVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bVyN9y2W; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yvmqGWpYOpga2UsXj4vOmcS8ixk0Jt+7cNuIGb69o3Q=; b=bVyN9y2Wlm0IPWYkTJ0Pt9onGr
	1Z8wC1siwACgo73hEsByVRvUaKgPF3sKY19PRkqg+AiK0i9KJhnW+pPjgNBlVdOsztNqTxO8eYjzM
	G5833Ghf2whWyeWaACKBA04y3lUjEFU65rkTzkXV/wnVF0H/mfpV+nwrlGJxUcw30+Z1sb4i43jhS
	lM7FVxmpxi0RmQGkuUVclnZl8BT0FB63lP4fSolGfErLXh2W1mBbAyXRCv0Zicm+O+oo9F+bpa5A/
	yh+pPKP2P+XOH5Y6lgZkOT8r4dQwKl+VlgE8aGBfvFYRByAeaT52W8pt6cdm00VAWjy1A+OTgpoQp
	K2PLU39w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005ozG-19W5;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 19/48] attach_recursive_mnt(): pass destination mount in all cases
Date: Mon, 30 Jun 2025 03:52:26 +0100
Message-ID: <20250630025255.1387419-19-viro@zeniv.linux.org.uk>
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

... and 'beneath' is no longer used there

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b8d07df4aa5..449e66436b4f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2570,7 +2570,7 @@ enum mnt_tree_flags_t {
 /**
  * attach_recursive_mnt - attach a source mount tree
  * @source_mnt: mount tree to be attached
- * @top_mnt:    mount that @source_mnt will be mounted on or mounted beneath
+ * @dest_mnt:   mount that @source_mnt will be mounted on
  * @dest_mp:    the mountpoint @source_mnt will be mounted at
  * @flags:      modify how @source_mnt is supposed to be attached
  *
@@ -2635,20 +2635,20 @@ enum mnt_tree_flags_t {
  *         Otherwise a negative error code is returned.
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
-				struct mount *top_mnt,
+				struct mount *dest_mnt,
 				struct mountpoint *dest_mp,
 				enum mnt_tree_flags_t flags)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	HLIST_HEAD(tree_list);
-	struct mnt_namespace *ns = top_mnt->mnt_ns;
+	struct mnt_namespace *ns = dest_mnt->mnt_ns;
 	struct mountpoint *smp;
 	struct mountpoint *shorter = NULL;
-	struct mount *child, *dest_mnt, *p;
+	struct mount *child, *p;
 	struct mount *top;
 	struct hlist_node *n;
 	int err = 0;
-	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
+	bool moving = flags & MNT_TREE_MOVE;
 
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
@@ -2669,11 +2669,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			goto out;
 	}
 
-	if (beneath)
-		dest_mnt = top_mnt->mnt_parent;
-	else
-		dest_mnt = top_mnt;
-
 	if (IS_MNT_SHARED(dest_mnt)) {
 		err = invent_group_ids(source_mnt, true);
 		if (err)
@@ -3688,7 +3683,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
+	err = attach_recursive_mnt(old, p, mp, flags);
 	if (err)
 		goto out;
 
-- 
2.39.5


