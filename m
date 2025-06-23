Return-Path: <linux-fsdevel+bounces-52447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6995AE3475
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9682918906D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17901DF97F;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S9N1Vtgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552DB1C8601
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=egoCLHPGQ2FPVwsiDVCDeIwfYS0lG/7/4R8r5GdeSpNzs0CorycX6/zeOSjdDTrmF0QqxqMTbBKufJAXPuM0VhEOaYHynodOc/eKTVwZajjtNsAwfBNCYWj0P3P7WLKkVXYczUITUMuHeaBXr3jftHpLh0wothGoDM8Irqw1P3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=mp2XNP4plG7t1WN5Qui/z/qmCPp9Y8ulmb5BlzHCTLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5I/Oaya/x1+v6SpODh1ErFemlLdZ5QX6JwFQlxuLZFX7Jr77ZsZz6lMXp4JtAzCyMrb/PPXFrhoJttHB5etCPFD/sQ/cbNhY04/vQgqwdQ6hDjcO6L+QiH3G8rYT+91Af0NRu8Zqhfvnft5ytSadmBNqugjrei5VH1rzXK5D3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S9N1Vtgr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bjnjJyIbTX/oBrwzibLmdMHG/cHKrmaXatF2V69vd+0=; b=S9N1VtgrA2goksH6qlA69vxJfB
	U1fq+gXrAnLRbVQ95bNw/3jfkOIh1Jl+HxuGlGoz33Aq/GqafyQKF5mVj9tywmLi8hIuUmQn0UQxv
	JV8dRSA3TlP60hg8oMD0mrNI4xp6CSGZTlkfViaQuqM5hjjH5L4aLa0XIIfcRl22XP9swv3rGPUMs
	MBNnH3aSHi9AEqShHVbTrldCiDcDSfMkmDswT62xUbCbUndtSwowZT2LNLJ13vW30+MXbHRpOMC3k
	bHVU22vs1sBi/Rteb6+Qv7hTTS00eTWWfv3te34mUS/i5SvquW87GEa47/KibHT8NzLutaz4S2G0I
	YkhfpjCA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005Kpv-34Nt;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 13/35] __attach_mnt(): lose the second argument
Date: Mon, 23 Jun 2025 05:54:06 +0100
Message-ID: <20250623045428.1271612-13-viro@zeniv.linux.org.uk>
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

It's always ->mnt_parent of the first one.  What the function does is
making a mount (with already set parent and mountpoint) visible - in
mount hash and in the parent's list of children.

IOW, it takes the existing rootwards linkage and sets the matching
crownwards linkage.

Renamed to make_visible(), while we are at it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fb15bd04333a..9ac9a82d2aee 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1079,8 +1079,9 @@ void mnt_set_mountpoint(struct mount *mnt,
 	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
 }
 
-static void __attach_mnt(struct mount *mnt, struct mount *parent)
+static void make_visible(struct mount *mnt)
 {
+	struct mount *parent = mnt->mnt_parent;
 	if (unlikely(mnt->mnt_mountpoint == parent->mnt.mnt_root))
 		parent->overmount = mnt;
 	hlist_add_head_rcu(&mnt->mnt_hash,
@@ -1098,7 +1099,7 @@ static void __attach_mnt(struct mount *mnt, struct mount *parent)
  * Mount @mnt at @mp on @parent. Then attach @mnt
  * to @parent's child mount list and to @mount_hashtable.
  *
- * Note, when __attach_mnt() is called @mnt->mnt_parent already points
+ * Note, when make_visible() is called @mnt->mnt_parent already points
  * to the correct parent.
  *
  * Context: This function expects namespace_lock() and lock_mount_hash()
@@ -1108,7 +1109,7 @@ static void attach_mnt(struct mount *mnt, struct mount *parent,
 		       struct mountpoint *mp)
 {
 	mnt_set_mountpoint(parent, mp, mnt);
-	__attach_mnt(mnt, mnt->mnt_parent);
+	make_visible(mnt);
 }
 
 void mnt_change_mountpoint(struct mount *parent, struct mountpoint *mp, struct mount *mnt)
@@ -1182,7 +1183,7 @@ static void commit_tree(struct mount *mnt)
 	n->nr_mounts += n->pending_mounts;
 	n->pending_mounts = 0;
 
-	__attach_mnt(mnt, parent);
+	make_visible(mnt);
 	touch_mnt_namespace(n);
 }
 
@@ -2679,7 +2680,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
 			mnt_change_mountpoint(top, smp, top_mnt);
-		__attach_mnt(source_mnt, source_mnt->mnt_parent);
+		make_visible(source_mnt);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
 	} else {
-- 
2.39.5


