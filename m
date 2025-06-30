Return-Path: <linux-fsdevel+bounces-53273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52437AED2A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FA0B1659EB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C52620E70B;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hvJrne1/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD75C1C245C
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251983; cv=none; b=hkhLLsfpmDJghJ2uMlLKwBSe5W1RoZ/X8IChkww92oaq5LnBBy9rRCIJNfQFRZ7EbYyv+KLRHiNpM/HMmKnvV9Xc180a8gIxvR44YyjA0SUg/asE9VUo6T4NEvseLsM79IJXPtKwPIFyJScIhhxVfm5rLOck8v5t39bs5piFhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251983; c=relaxed/simple;
	bh=21iUINBF4/FEF5jQfuxDBlebXAr2ocCypT2a0vxbkBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHmlq2jNh2dusXNE76ArATAC6+xVfuK6Q1DtZMqxr2NPsLDXe9/ievD0NH/WC2GAKkD3FcgdD/GdzGwTcO/s8m9DBkdHQl/iifq6twG+fvus0aTxn37nO3HIhR0+MRcUN9TfT2q+mEzonI9FsRSCT7zYfZmdO7EOD51QbJBsqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hvJrne1/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5cszqhRC6nL81JIrRVCYPalwwQ391Qc1uKdzGQWfDvQ=; b=hvJrne1/dd1NifTVowQn1iUgav
	+G+6L7+WGoyQP7YdxRccAODE3K22Pjw2/wOF/w9ctg4PgDDdvIrZjd5BpnxlLMMHJGFED/owQWuBe
	jxPPgoZ7RtVK9VNbnINQmCLiTTUZATUjo0PQo6WwtyjMsVuA6vXUeOiPG2IKuijOjfDAStOJzHiaI
	HlmksF2nnu5cF6GLV02bAIkl5cEtb1ysJg3u0KyRA2viKeeujkT0/98SfmWMB9mAhv9jLCB625Gg9
	rAjSEh8C7AYqmMr3UsC6boZ0AjP8kxfbBkh8AhtXeD+lUcGFXVP/vPIw/uKvOpyJnMfST23eG5bPH
	KEaEdY3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4df-00000005p1j-0L5w;
	Mon, 30 Jun 2025 02:52:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 34/48] propagate_one(): fold into the sole caller
Date: Mon, 30 Jun 2025 03:52:41 +0100
Message-ID: <20250630025255.1387419-34-viro@zeniv.linux.org.uk>
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

mechanical expansion; will be cleaned up on the next step

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 57 ++++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 32 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 94de8aad4da5..aeaec24f7456 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -257,35 +257,6 @@ static struct mount *find_master(struct mount *m,
 	return last_copy;
 }
 
-static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
-{
-	struct mount *child;
-	int type;
-
-	if (peers(m, last_dest)) {
-		type = CL_MAKE_SHARED;
-	} else {
-		last_source = find_master(m, last_source, first_source);
-		type = CL_SLAVE;
-		/* beginning of peer group among the slaves? */
-		if (IS_MNT_SHARED(m))
-			type |= CL_MAKE_SHARED;
-	}
-		
-	child = copy_tree(last_source, last_source->mnt.mnt_root, type);
-	if (IS_ERR(child))
-		return PTR_ERR(child);
-	read_seqlock_excl(&mount_lock);
-	mnt_set_mountpoint(m, dest_mp, child);
-	read_sequnlock_excl(&mount_lock);
-	if (m->mnt_master)
-		SET_MNT_MARK(m->mnt_master);
-	last_dest = m;
-	last_source = child;
-	hlist_add_head(&child->mnt_hash, list);
-	return count_mounts(m->mnt_ns, child);
-}
-
 /*
  * mount 'source_mnt' under the destination 'dest_mnt' at
  * dentry 'dest_dentry'. And propagate that mount to
@@ -302,8 +273,8 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		    struct mount *source_mnt, struct hlist_head *tree_list)
 {
-	struct mount *m, *n;
-	int err = 0;
+	struct mount *m, *n, *child;
+	int err = 0, type;
 
 	/*
 	 * we don't want to bother passing tons of arguments to
@@ -329,7 +300,29 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 		do {
 			if (!need_secondary(n, dest_mp))
 				continue;
-			err = propagate_one(n, dest_mp);
+			if (peers(n, last_dest)) {
+				type = CL_MAKE_SHARED;
+			} else {
+				last_source = find_master(n, last_source, first_source);
+				type = CL_SLAVE;
+				/* beginning of peer group among the slaves? */
+				if (IS_MNT_SHARED(n))
+					type |= CL_MAKE_SHARED;
+			}
+			child = copy_tree(last_source, last_source->mnt.mnt_root, type);
+			if (IS_ERR(child)) {
+				err = PTR_ERR(child);
+				break;
+			}
+			read_seqlock_excl(&mount_lock);
+			mnt_set_mountpoint(n, dest_mp, child);
+			read_sequnlock_excl(&mount_lock);
+			if (n->mnt_master)
+				SET_MNT_MARK(n->mnt_master);
+			last_dest = n;
+			last_source = child;
+			hlist_add_head(&child->mnt_hash, list);
+			err = count_mounts(n->mnt_ns, child);
 			if (err)
 				break;
 		} while ((n = next_peer(n)) != m);
-- 
2.39.5


