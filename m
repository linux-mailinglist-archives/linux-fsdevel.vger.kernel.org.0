Return-Path: <linux-fsdevel+bounces-52464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD80AE3485
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7AF16D45E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0411F30B2;
	Mon, 23 Jun 2025 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hLEcako6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DA71E25F9
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654477; cv=none; b=FRRGGChSoB+zGfmoifsKz0oNaD1VhyjP32ugYyEAsuqUam7QIkFX+/EixC1pTVc7x0eNmJpSurJGjzVN8AtAN+Lw7qj1trurm+V7RfM9qlM4Mcka3JqOMrAQwCi2//RpDqZy/z4i8kpVw8bWkbFBiR4fb6BMRDE8Fu8t3bcrpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654477; c=relaxed/simple;
	bh=lZO8e/QRQijgt0FrcnVfdvxUksAfJqaU94SIq5IxPXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9SIKRIViNg4IFkUzRF2J5gaJzXWu6ppiV8MUhDgpcK2AqjGSgtqb8TAX8Jf1zxZ9hrnv0bHvLomTd1qnx71wjOULeKspyYSqRAJAdCBrMAgdMtpe0wBp2jf6AOmyT+9pQ5W8lpDZ7G1juJuI4Rey/GlLnvvYseyYHa0IUS1Ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hLEcako6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O28xYFF7goNIgHJrBIay72NMxhrrFi9uQofrXwg7cDg=; b=hLEcako6/qq291axBZJvzHFv2l
	xuhgpbNdKbdM7JIR2nVCBgwUVpFt/oZJMW+yyX/ow2Sg2eTaI5gQrXyGBEYBt4Kqj/P2Py/3J2sTl
	mnaIZ17DL/1fsxE2bR69iyWuYgI23VGGdJY6XA2Cd07czWNsR5kCLmrd4nr5q9VSOq4Wat/lQFqzx
	7jqHBLKYsfwSf21q244FC7WFw/W7PdTFCYGbSrJ0l3aVfFOhw0ciKV9IcTRXWvwTe5mAb54BbxoXG
	+A9HX1vuIQYTHu2WKUjhfPVwza7UUZDfheB+GEAeKNuYVTEF6xrlSDweJLGwhkSK1EpBEEweEDIh4
	4fIWrcLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005Kug-3QnO;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 33/35] propagate_one(): get rid of dest_master
Date: Mon, 23 Jun 2025 05:54:26 +0100
Message-ID: <20250623045428.1271612-33-viro@zeniv.linux.org.uk>
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

propagate_mnt() takes the subtree we are about to attach and creates
its copies, setting the propagation between those.  Each copy is cloned
either from the original or from one of the already created copies.
The tricky part is choosing the right copy to serve as a master when we
are starting a new peer group.

The algorithm for doing that selection puts temporary marks on the masters
of mountpoints that already got a copy created for them; since the initial
peer group might have no master at all, we need to special-case that when
looking for the mark.  Currently we do that by memorizing the master of
original peer group.  It works, but we get yet another piece of data to
pass from propagate_mnt() to propagate_one().

Alternative is to mark the master of original peer group if not NULL,
turning the check into "master is not NULL or it is marked".  Less data
to pass around and memory safety is more obvious that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 0ae14f7f754f..b54f7ca8cff5 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -215,7 +215,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 }
 
 /* all accesses are serialized by namespace_sem */
-static struct mount *last_dest, *first_source, *last_source, *dest_master;
+static struct mount *last_dest, *first_source, *last_source;
 static struct hlist_head *list;
 
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
@@ -239,7 +239,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 		bool done;
 		for (n = m; ; n = p) {
 			p = n->mnt_master;
-			if (p == dest_master || IS_MNT_MARKED(p))
+			if (!p || IS_MNT_MARKED(p))
 				break;
 		}
 		do {
@@ -264,7 +264,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	read_seqlock_excl(&mount_lock);
 	mnt_set_mountpoint(m, dest_mp, child);
 	read_sequnlock_excl(&mount_lock);
-	if (m->mnt_master != dest_master)
+	if (m->mnt_master)
 		SET_MNT_MARK(m->mnt_master);
 	last_dest = m;
 	last_source = child;
@@ -300,7 +300,8 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	first_source = source_mnt;
 	last_source = source_mnt;
 	list = tree_list;
-	dest_master = dest_mnt->mnt_master;
+	if (dest_mnt->mnt_master)
+		SET_MNT_MARK(dest_mnt->mnt_master);
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
@@ -324,9 +325,11 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 out:
 	hlist_for_each_entry(n, tree_list, mnt_hash) {
 		m = n->mnt_parent;
-		if (m->mnt_master != dest_mnt->mnt_master)
+		if (m->mnt_master)
 			CLEAR_MNT_MARK(m->mnt_master);
 	}
+	if (dest_mnt->mnt_master)
+		CLEAR_MNT_MARK(dest_mnt->mnt_master);
 	return ret;
 }
 
-- 
2.39.5


