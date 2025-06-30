Return-Path: <linux-fsdevel+bounces-53252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527DCAED292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200313B5109
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3FC1DED77;
	Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JSemzJrY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5718DF9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=HesIbNJkrtKGeTAQ5F+A8lUTmIiY5DmCsSrvHawtdFeDweCOHphWrOBwRZDJkUxcu7j3CYff4Iix7fweYT3LP2nJGKHQeyg9m6sw8p2l8Miy4YHexyTrz6wEdRuU/9oox4khjmHQxPF/27xp9vqhicCuIh1DJomL9DpPjnfs7Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=SDV2AXwWgQkPNHc8MaemAFxNktSUIyosu58qyk+EKHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kcrDOa66OnfUYD+yp8cYw9q2WSN8o+NVVm8y16x2GIzjCHdv6VI+xbVol/6W84VhW2z80XqD9w4IcM401BMfcqF/OKp9C/5velYABOSMkeBBWxhFTdshRFAm4d3vE+z2wrzXUe4WZtW4lEN4Dypm9hucO3nVWiy9u2L0SHysMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JSemzJrY; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bURmi5cXZqBhqjgXWSLWDdRtzdP4QqH8Ns29W32upNc=; b=JSemzJrYibXQuksiey1tbvGPm8
	hS2Q6+Gb3GcYs9mbjGIxgErYJrIhI+bGXpKn28r1bD3pIix1MU/udSpRVFBfOuPj8/y2IHgLstPIE
	5Vp/SXRvppNbjlZovn/cJVgbKHXmIAvQ8zd8T9ctCHKYm3G2loLTb8vSt4j3EnpV3xjpFMdreBjur
	QMZ9ARAmqgEaniW2PNAeC8OCTCTi74q+M0Nt7Rirt8ulmQE3H/hNGlFEKrnUK4069sXSbHmyAnkG/
	J+VSZGGG0MOomlIjJhxDpzOduW1zIy1KmvtANwAghsnK9xU6g38Z3tN3akIUZKIBDxCLU6RHPJnXw
	EcB6fy+w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005owo-1VH8;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 11/48] __attach_mnt(): lose the second argument
Date: Mon, 30 Jun 2025 03:52:18 +0100
Message-ID: <20250630025255.1387419-11-viro@zeniv.linux.org.uk>
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
index 151d5f3360b9..75d45d0b615c 100644
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


