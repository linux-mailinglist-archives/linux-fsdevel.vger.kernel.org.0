Return-Path: <linux-fsdevel+bounces-52468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD77AE348A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD23188AAE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FBE1F4C87;
	Mon, 23 Jun 2025 04:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ndt6Kq2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEEE1E2847
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654477; cv=none; b=E3ULnje2oHiKanWE8S3WDoFiqlJw81jwHjFYqLC/4jH+NXl9yOo9bZYpE1ERJLSX5sL9yIdgg4l49H7JDgfAPf9qXaX5ks3VaVn0iVNoSuUEMm+tfrZlVMSmQg3ejWiZg+fGQSRuCSp5GN2RyiT5+9qie3FuaROwXUXrwHz/Ds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654477; c=relaxed/simple;
	bh=GmXCTMoHFa+YiKQ9vd/mdTzUTKnCLG0euj7hFikT0m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPdDLl7Vi5nFoAVsFyZ/fEmyiU0ji8VnL+vrGG8N/LZotZr07t++PYxZdFviQgm24IxBS/MsNo8m5+V9fmyE6oORLdWOMcZC2ZO8GojZqocQesiN4IXn94t72grLpRmKdRHEa5QjNBPN5aZdLJ4MONSs5thu0wxdSSROvG8qN80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ndt6Kq2u; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QgfgOxtPN3HG+nT+TkjtQs8zqPkp+QzMvs5QERadcQs=; b=Ndt6Kq2uyIHfNMC/yNvuc7tY/U
	/TaPiqXgKsfBYpZpnoTLEj8UklBhVDMZcqh+jaQh02oMtmKgwQ8k8bWJlJFOKKCEgGWq5okxYMryQ
	WgjhSLm2R8KZazg572ZyUAie6rZvNKVGUPlO83FhkptmzotdIxxM6SmWUPmwib50ZNCTdrpMPDWuu
	x6Za0JcrCdzQ2+2iCkCKhI8Vw9wBfa2BVNZ7KEFFAn7Qxr+2FECTMk8c6S1eUF2TQgWCbVbcUwNiT
	klwSsCjVTo/S70EDRSZcRNWNwB86EeDNfZKqk9/I/gYbfV3y1jBFc/Cdrb/dv58R6X2qhrMeBu0A9
	fhTdIKCw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCT-00000005Kup-3hH6;
	Mon, 23 Jun 2025 04:54:33 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 34/35] propagate_mnt(): get rid of globals
Date: Mon, 23 Jun 2025 05:54:27 +0100
Message-ID: <20250623045428.1271612-34-viro@zeniv.linux.org.uk>
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

TBH, I'm not sure it makes the things better, but...

Fixed a stale comment, while we are at it - propagate_mnt() does *not*
use ->mnt_list for linkage and it does not attach the secondaries to
the original - they go into the caller-supplied list.  It had gone
stale before the entire thing got merged into the tree...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 61 +++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index b54f7ca8cff5..dacb7f515eed 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -214,25 +214,28 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 	}
 }
 
-/* all accesses are serialized by namespace_sem */
-static struct mount *last_dest, *first_source, *last_source;
-static struct hlist_head *list;
+struct propagate_mnt_context {
+	struct mountpoint *dest_mp;
+	struct hlist_head *list;
+	struct mount *last_dest, *source, *last_source;
+};
 
-static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
+static int propagate_one(struct mount *m, struct propagate_mnt_context *ctx)
 {
-	struct mount *child;
+	struct mount *last_source = ctx->last_source;
+	struct mount *copy;
 	int type;
 	/* skip ones added by this propagate_mnt() */
 	if (IS_MNT_NEW(m))
 		return 0;
 	/* skip if mountpoint isn't visible in m */
-	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
+	if (!is_subdir(ctx->dest_mp->m_dentry, m->mnt.mnt_root))
 		return 0;
 	/* skip if m is in the anon_ns */
 	if (is_anon_ns(m->mnt_ns))
 		return 0;
 
-	if (peers(m, last_dest)) {
+	if (peers(m, ctx->last_dest)) {
 		type = CL_MAKE_SHARED;
 	} else {
 		struct mount *n, *p;
@@ -244,7 +247,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 		}
 		do {
 			struct mount *parent = last_source->mnt_parent;
-			if (peers(last_source, first_source))
+			if (peers(last_source, ctx->source))
 				break;
 			done = parent->mnt_master == p;
 			if (done && peers(n, parent))
@@ -258,18 +261,18 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 			type |= CL_MAKE_SHARED;
 	}
 		
-	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
-	if (IS_ERR(child))
-		return PTR_ERR(child);
+	copy = copy_tree(last_source, last_source->mnt.mnt_root, type);
+	if (IS_ERR(copy))
+		return PTR_ERR(copy);
 	read_seqlock_excl(&mount_lock);
-	mnt_set_mountpoint(m, dest_mp, child);
+	mnt_set_mountpoint(m, ctx->dest_mp, copy);
 	read_sequnlock_excl(&mount_lock);
 	if (m->mnt_master)
 		SET_MNT_MARK(m->mnt_master);
-	last_dest = m;
-	last_source = child;
-	hlist_add_head(&child->mnt_hash, list);
-	return count_mounts(m->mnt_ns, child);
+	ctx->last_dest = m;
+	ctx->last_source = copy;
+	hlist_add_head(&copy->mnt_hash, ctx->list);
+	return count_mounts(m->mnt_ns, copy);
 }
 
 /*
@@ -277,35 +280,33 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
  * dentry 'dest_dentry'. And propagate that mount to
  * all the peer and slave mounts of 'dest_mnt'.
  * Link all the new mounts into a propagation tree headed at
- * source_mnt. Also link all the new mounts using ->mnt_list
- * headed at source_mnt's ->mnt_list
+ * source_mnt.  Roots of all copies placed into 'tree_list',
+ * linked by ->mnt_hash.
  *
  * @dest_mnt: destination mount.
  * @dest_dentry: destination dentry.
  * @source_mnt: source mount.
- * @tree_list : list of heads of trees to be attached.
+ * @tree_list : list of trees to be attached.
  */
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		    struct mount *source_mnt, struct hlist_head *tree_list)
 {
 	struct mount *m, *n;
 	int ret = 0;
+	struct propagate_mnt_context ctx = {
+		.source = source_mnt,
+		.dest_mp = dest_mp,
+		.list = tree_list,
+		.last_source = source_mnt,
+		.last_dest = dest_mnt,
+	};
 
-	/*
-	 * we don't want to bother passing tons of arguments to
-	 * propagate_one(); everything is serialized by namespace_sem,
-	 * so globals will do just fine.
-	 */
-	last_dest = dest_mnt;
-	first_source = source_mnt;
-	last_source = source_mnt;
-	list = tree_list;
 	if (dest_mnt->mnt_master)
 		SET_MNT_MARK(dest_mnt->mnt_master);
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
-		ret = propagate_one(n, dest_mp);
+		ret = propagate_one(n, &ctx);
 		if (ret)
 			goto out;
 	}
@@ -316,7 +317,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		/* everything in that slave group */
 		n = m;
 		do {
-			ret = propagate_one(n, dest_mp);
+			ret = propagate_one(n, &ctx);
 			if (ret)
 				goto out;
 			n = next_peer(n);
-- 
2.39.5


