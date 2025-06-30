Return-Path: <linux-fsdevel+bounces-53286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3FAED2B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CF5816AC69
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F09921D5BC;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UJ8aQwFy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DF1E0E08
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251985; cv=none; b=AGkDfXbcpNIbDlYG+sTftMk7+pdJhTfOWYth1ECyAs+jqqFoJs7BnzEOTffogNfXYvAgn+2WZTu19sxqaMw10499mJXCJ98HjVTBVaAYjJwlzTMHAsGGbYD4N91qxjjOP38zMJyi9j/EpEXfDP/BcOWJ3/ZSjCckfFWivIctadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251985; c=relaxed/simple;
	bh=5BjYzSVZCQlx+ZWUiEHPm8DhrRvdhKwQYO/pIQlof/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvPithQUDHOpS0LzuChYsSuBfPDqhXqZ5rT4bE0jrd+mJShW9yxnh8nMZD6rOA+mKtFn2e0UpWmF0SFEkDqYduFuAuA8M2x3pqSERmQPjxNqreP+RSYRTKaTHFuxtQ2w02yNDTxnuZWqSZIAnSnRFQs2KVhtwR69RgQlPpAzn2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UJ8aQwFy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OYt7mcIc9EXR8dJlspoyhaQ62sZ1p4A2GH4z8QvIZ/w=; b=UJ8aQwFyubIfsKwwAbf9pJvdiY
	ad3U9+MdJcIldZ9SaPqT6uEVcm6HyC4Q3b29XKlNKdO5MegdsnBf7/TP936yriTVXkEUc7jIl/FxY
	1YjHtKaRN5bP8jgABHRUSiVnAp5izvAihj6duJevj8u2vV83Nt4cEb54+bhJoHwlgG7DVrYExsvce
	iVtqfcEcNoMARjLuk8f1cHL1t1DfR4SMuLk1DWpcVR19+mExIOfL3W36tadU9FgEvocGBCpUlz3Ze
	0t9L4kldI1C8ow4+SdOKCIHxRwuwdK9uXVLoKGN8cD2lVHBEWmGL78tn7zdb7iRqf79I5H0JhDARf
	qEBNjlqg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dh-00000005p4h-0Fn4;
	Mon, 30 Jun 2025 02:53:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 46/48] get rid of CL_SHARE_TO_SLAVE
Date: Mon, 30 Jun 2025 03:52:53 +0100
Message-ID: <20250630025255.1387419-46-viro@zeniv.linux.org.uk>
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

the only difference between it and CL_SLAVE is in this predicate
in clone_mnt():
	if ((flag & CL_SLAVE) ||
	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
However, in case of CL_SHARED_TO_SLAVE we have not allocated any
mount group ids since the time we'd grabbed namespace_sem, so
IS_MNT_SHARED() is equivalent to non-zero ->mnt_group_id.  And
in case of CL_SLAVE old has come either from the original tree,
which had ->mnt_group_id allocated for all nodes or from result
of sequence of CL_MAKE_SHARED or CL_MAKE_SHARED|CL_SLAVE copies,
ultimately going back to the original tree.  In both cases we are
guaranteed that old->mnt_group_id will be non-zero.

In other words, the predicate is always equal to
	(flags & (CL_SLAVE | CL_SHARED_TO_SLAVE)) && old->mnt_group_id
and with that replacement CL_SLAVE and CL_SHARED_TO_SLAVE have exact
same behaviour.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 7 +++----
 fs/pnode.h     | 1 -
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 85db0de5fb53..ca36c4a6a143 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1309,7 +1309,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	mnt->mnt.mnt_flags = READ_ONCE(old->mnt.mnt_flags) &
 			     ~MNT_INTERNAL_FLAGS;
 
-	if (flag & (CL_SLAVE | CL_PRIVATE | CL_SHARED_TO_SLAVE))
+	if (flag & (CL_SLAVE | CL_PRIVATE))
 		mnt->mnt_group_id = 0; /* not a peer of original */
 	else
 		mnt->mnt_group_id = old->mnt_group_id;
@@ -1340,8 +1340,7 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 	if (peers(mnt, old))
 		list_add(&mnt->mnt_share, &old->mnt_share);
 
-	if ((flag & CL_SLAVE) ||
-	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
+	if ((flag & CL_SLAVE) && old->mnt_group_id) {
 		hlist_add_head(&mnt->mnt_slave, &old->mnt_slave_list);
 		mnt->mnt_master = old;
 	} else if (IS_MNT_SLAVE(old)) {
@@ -4228,7 +4227,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	/* First pass: copy the tree topology */
 	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
-		copy_flags |= CL_SHARED_TO_SLAVE;
+		copy_flags |= CL_SLAVE;
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		namespace_unlock();
diff --git a/fs/pnode.h b/fs/pnode.h
index 507e30e7a420..00ab153e3e9d 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -25,7 +25,6 @@
 #define CL_COPY_UNBINDABLE	0x04
 #define CL_MAKE_SHARED 		0x08
 #define CL_PRIVATE 		0x10
-#define CL_SHARED_TO_SLAVE	0x20
 #define CL_COPY_MNT_NS_FILE	0x40
 
 /*
-- 
2.39.5


