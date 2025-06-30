Return-Path: <linux-fsdevel+bounces-53256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B94AED297
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF37E16F564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3107E1E25E3;
	Mon, 30 Jun 2025 02:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="mXzJL+Fh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0FA19924D
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251980; cv=none; b=PLWr1goeAg4USCO0PxBH5vICYpsDg0xLKLViCbUOz0j1fMp8rdThwPaeDB4+1BmQIde4DsRLcBsmntdD8WxHJ26HP9q57zmxedRAQh5VeaY7hia/58jiT4JdbG96t/5xA4nadA91KcI/8YHQRRtZ3JlJJKgXg6DH0bSK1Kpy0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251980; c=relaxed/simple;
	bh=j79aQKcOKq9q3nbAIZFpfHWe6TgHWB0UR3FS2XS9EAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=du+fgWddNkIo0Z4uE08qVH1DirQGUPFklVOAverT9PGrGCRha0PNSrr9wnujJgUss+1dfk0ZC+3Z2ZPa9DCYC2hF65O2yP/3m59na/2aK161gPXIKQ2HjqehDaLi3tBe7m+Y+9gm55BhKP6Kpa2xZ4rFdtEoMCcWsuOFWMiF20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=mXzJL+Fh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0PA37CblAVANSYq5/5bedvVhpzd0j3N37EvT2fvvJvE=; b=mXzJL+FhY27stBK6kVG1JBG4kg
	fjGJpO1TEIXQtV1m9pJ/XbJcqGPDSeRfWl55ZvRQ9+QtARfcpfBtnfTnR9TqlPh3BF6DuCSSd1Xth
	WxPPLV6sR5o/QDWOnOY+BX0wc037wGo0pK2J9kn+O05uDJePFgXgt+gvRvkkUKJngAoxmXdreTWU+
	jC/0zMHz+hx5R5GOJharPYdPMeFZ3MSORZmKX5jpzK1qC3IBlhbNe4x6e/3UYE6tf4zdxnUP+3wMS
	XlC9orWOjw0ReA5XryW9rRSn8yyF3rlw36YZ0T17PEYSEqdyeJ3I0ZHTorM6VeHZYvnrPqxw8LCoQ
	48GQlooQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005oyO-3yvX;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 17/48] make commit_tree() usable in same-namespace move case
Date: Mon, 30 Jun 2025 03:52:24 +0100
Message-ID: <20250630025255.1387419-17-viro@zeniv.linux.org.uk>
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
index f64895d47d70..937c2a1825f2 100644
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


