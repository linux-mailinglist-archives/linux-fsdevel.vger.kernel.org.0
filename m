Return-Path: <linux-fsdevel+bounces-51134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23089AD3007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C81886960
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA07283CA0;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="p5Z0RQ0T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E76281363
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543715; cv=none; b=kRYW4s9nxW36rXrJmpBNgGAN9Sulgqgpg3ktMKQH0UCZTEqMncRzZ1Q9uoJRNlIeqh/t5vNXJtLEw/NbqI9/rd6SScXQrh6BS/OqEfDw5XnHdJcds1AuSqdX5DDlv9GioNbG073Y/VPga5BPRFJJ7bd8HdpkR/NLVUInmvxawyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543715; c=relaxed/simple;
	bh=D4PV83M9ozKHB+bnKL/jfUPT3xbo/p5ZN2FRtKXbE3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKoEgCaqm6jX+P578rIoihlfWLb+UbSu0qn5xeTZsC+bUyCcZX0bueR/ZK3GwApRxb9DcHGBTHP2YsZuwrh7w+I6OciHChTDUc2/Gs2BtRPo80XAUSPnGoOoaONwi9Mc6MKF28sym5+NQbkxuN2G4vwF1Oq5HOacmuCMXPRfOmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=p5Z0RQ0T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RJw43T+Tgf0DnYxDgRTXXrTjMzNKLdQ+d/RV3QG6/RA=; b=p5Z0RQ0TvyexFZDWNJPiwQ6a/2
	ZKzpJmy5/qaSMZO1wFuPH4fPBrIws7Mu1XDyhMp2ROYx446SntmZacoxCIJ+ElhEOf3f/Zpa506dn
	bcRtUfFOjkPr3xxtVQyLBANyy5HQAFPmVn9NSiht7GZDgRY+NWUUZAnzc+x5P0I7yGU71ijz8O5b6
	OE0Bi+JmtrO9c74MyoNrO4tPqAjFQtITDqJKnC529iB76qlp4apBDLJgsfyzIh2WyO1jzOk+C0cBs
	DaJd25tPjI3dK6Ua0FER/71RRK/kp+B3gZf1QUrAF3/eDIis+0snrXFhNGfHSyH89zynU7DyR+2aL
	BrMh0F2Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEx-00000004jNm-2mGt;
	Tue, 10 Jun 2025 08:21:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 18/26] attach_recursive_mnt(): pass destination mount in all cases
Date: Tue, 10 Jun 2025 09:21:40 +0100
Message-ID: <20250610082148.1127550-18-viro@zeniv.linux.org.uk>
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

... and 'beneath' is no longer used there

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0e43301abb91..571916df33fd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2547,7 +2547,7 @@ enum mnt_tree_flags_t {
 /**
  * attach_recursive_mnt - attach a source mount tree
  * @source_mnt: mount tree to be attached
- * @top_mnt:    mount that @source_mnt will be mounted on or mounted beneath
+ * @dest_mnt:   mount that @source_mnt will be mounted on
  * @dest_mp:    the mountpoint @source_mnt will be mounted at
  * @flags:      modify how @source_mnt is supposed to be attached
  *
@@ -2612,18 +2612,18 @@ enum mnt_tree_flags_t {
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
-	struct mount *child, *dest_mnt, *p;
+	struct mount *child, *p;
 	struct hlist_node *n;
 	int err = 0;
-	bool moving = flags & MNT_TREE_MOVE, beneath = flags & MNT_TREE_BENEATH;
+	bool moving = flags & MNT_TREE_MOVE;
 
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
@@ -2640,11 +2640,6 @@ static int attach_recursive_mnt(struct mount *source_mnt,
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
@@ -3644,7 +3639,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, p))
 		goto out;
 
-	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
+	err = attach_recursive_mnt(old, p, mp, flags);
 	if (err)
 		goto out;
 
-- 
2.39.5


