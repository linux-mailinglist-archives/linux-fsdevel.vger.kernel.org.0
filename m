Return-Path: <linux-fsdevel+bounces-53280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9799FAED2AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BA70169B69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4189221B9F0;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nCpbSsXn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F0199931
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=AhNAFKUNm0KUNIvLeRUOTp1qYcXg3ik/4CbDnJ2qnOGYW9veLlwnaotohfVZO1fzmAfkDcKb3E60d/Iekp3rpCRdlohSgtk50S0/wN8qksan5vjyrH6JbOL2j1WK+0Z1bzYL0IIrVypAIj5kYmRiNWIhavmKE2snQYPqRNYp12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=0eOdnCkScdVkFEwZSNyA12x++pRcmyieOR8/PBr2pxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrmdoJQhBABJW/6PfT8qg6S3mzp8gdX9uzzk+uCX1MoZwveEMSpD9O4Yx5Mu85H4Qj8lLgcx1emMPEn+ImtWjQYYwGt7NuE24xZ0e50+1MyZc8rkScVOgiI5v6y1hHiyhXZRywBdpsm7G/Jb9WpbRjG2Odp4IbosIg1WVdIgv/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nCpbSsXn; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tvuzBPzKSCSpOrLCi6ZJx5i2KMYLDkC8M207euYmEKM=; b=nCpbSsXnosZd1r5fSZKWkGxU6a
	SqKAKkx0+WMk22n6D9CEzz08eFGkYXFe7Br9a1ra3cm2G7bsOeu7cXuMNNA7Eu3xowzn3hXohJgX5
	G78dQmSzCbFZajuicF4n1WMr7ANre61/TXdFttiKPHFBHUp8SdcM9rpNrfZDqBjMonDFq4zEP5RRy
	w9h9Ieg0+NIf+D8xRWuyX40BOecQc7cOIZEWIFP517ahMizV+76I58gPdyVGXo5wyHR2aDLKNMJsX
	eTpiRiEPbtcEKzE7AXcNPTwncnY8k62PiTDKz1p5HhyXxOSYZoYlhwu5fwtnlNqJhNuZWn4Qt4qMr
	MeW7f6nw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dd-00000005oym-0PWD;
	Mon, 30 Jun 2025 02:52:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 18/48] attach_recursive_mnt(): unify the mnt_change_mountpoint() logics
Date: Mon, 30 Jun 2025 03:52:25 +0100
Message-ID: <20250630025255.1387419-18-viro@zeniv.linux.org.uk>
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

The logics used for tucking under existing mount differs for original
and copies; copies do a mount hash lookup to see if mountpoint to be is
already overmounted, while the original is told explicitly.

But the same logics that is used for copies works for the original,
at which point the only place where we get very close to eliminating
the need of passing 'beneath' flag to attach_recursive_mnt().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 937c2a1825f2..9b8d07df4aa5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2643,7 +2643,7 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = top_mnt->mnt_ns;
 	struct mountpoint *smp;
-	struct mountpoint *secondary = NULL;
+	struct mountpoint *shorter = NULL;
 	struct mount *child, *dest_mnt, *p;
 	struct mount *top;
 	struct hlist_node *n;
@@ -2655,14 +2655,12 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	 * mounted beneath mounts on the same mountpoint.
 	 */
 	for (top = source_mnt; unlikely(top->overmount); top = top->overmount) {
-		if (!secondary && is_mnt_ns_file(top->mnt.mnt_root))
-			secondary = top->mnt_mp;
+		if (!shorter && is_mnt_ns_file(top->mnt.mnt_root))
+			shorter = top->mnt_mp;
 	}
 	smp = get_mountpoint(top->mnt.mnt_root);
 	if (IS_ERR(smp))
 		return PTR_ERR(smp);
-	if (!secondary)
-		secondary = smp;
 
 	/* Is there space to add these mounts to the mount namespace? */
 	if (!moving) {
@@ -2706,9 +2704,14 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	}
 
 	mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-	if (beneath)
-		mnt_change_mountpoint(top, smp, top_mnt);
-	commit_tree(source_mnt);
+	/*
+	 * Now the original copy is in the same state as the secondaries -
+	 * its root attached to mountpoint, but not hashed and all mounts
+	 * in it are either in our namespace or in no namespace at all.
+	 * Add the original to the list of copies and deal with the
+	 * rest of work for all of them uniformly.
+	 */
+	hlist_add_head(&source_mnt->mnt_hash, &tree_list);
 
 	hlist_for_each_entry_safe(child, n, &tree_list, mnt_hash) {
 		struct mount *q;
@@ -2719,10 +2722,13 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 		q = __lookup_mnt(&child->mnt_parent->mnt,
 				 child->mnt_mountpoint);
 		if (q) {
+			struct mountpoint *mp = smp;
 			struct mount *r = child;
 			while (unlikely(r->overmount))
 				r = r->overmount;
-			mnt_change_mountpoint(r, secondary, q);
+			if (unlikely(shorter) && child != source_mnt)
+				mp = shorter;
+			mnt_change_mountpoint(r, mp, q);
 		}
 		commit_tree(child);
 	}
-- 
2.39.5


