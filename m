Return-Path: <linux-fsdevel+bounces-59563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047A9B3AE1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E073A1D76
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07542E3715;
	Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hEQVfV2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8232E7BDA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422495; cv=none; b=eKSJB2xctl56LmJovn07I2dqcX+aRYyu8+qMjNST/i2yD5yNNdFSHgGtlJxKaJzR96Qv6Gc3M1gXTo1IUlL6tgOrOyoTGQXi2fmy5qDB8Kg72Mf0WvlX008ty3Nuw2YlryWy1UBV5i4KddVVgpK+B7SgVi17OuPoYvhbAClSpMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422495; c=relaxed/simple;
	bh=a2GsUePlL3oWRTPp8jkpG5w8Xzaudm0y6pJqVFgpDNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NawjiTC2ghgE9kdubb48OmPJqKXcvNt4S7rdPDzhk07RXD4BzBfVkrRRApKcKgp+B+jlIxudgAsmJ9K+x+uuN+FGEZX9UzvJd4QpjF1vTJa1QM3Zk8U4D2qCoyvLzoaY3FoaJycsk/h0M39VJ7rh86/voRc+xfQKL4/xjto0C0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hEQVfV2N; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IHLnjbaU7daMoXUcboThCXT37WLVnT8EBUPJx+xO2EU=; b=hEQVfV2NMl+lOXgbyx+9BvYk+8
	rbAocSjjGDnBCG38SuN0Gy5RiblHb61basuY7jlZYkk6JOc4smg9Rd0aovwZH82Dh2M959PyjUaw+
	UIROucbO2RHnQIiZWVnT8n80BpUi0llsbNTGMLM0UZj4YGnJPycL+ydkDIcFxXf7QPk3iCz99xqVA
	nYhcguBY/Di/hepxcaiHvaC0GRZvz9AVdUjIPz0JgMr9F1NOAt3eAd4KoEChO2Vx4bllz4iThbjek
	wFSeFZyyw6AU/V+6ARp5fOebhipg3V/1SZVxUR6334tbvZL7b/2QLpCFW7nMFqcVhzoK9+vt1KHfR
	q7Kr7nEg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F26D-1Vau;
	Thu, 28 Aug 2025 23:08:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 34/63] new helper: topmost_overmount()
Date: Fri, 29 Aug 2025 00:07:37 +0100
Message-ID: <20250828230806.3582485-34-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Returns the final (topmost) mount in the chain of overmounts
starting at given mount.  Same locking rules as for any mount
tree traversal - either the spinlock side of mount_lock, or
rcu + sample the seqcount side of mount_lock before the call
and recheck afterwards.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     | 7 +++++++
 fs/namespace.c | 9 +++------
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index ed8c83ba836a..04d0eadc4c10 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -235,4 +235,11 @@ static inline void mnt_notify_add(struct mount *m)
 }
 #endif
 
+static inline struct mount *topmost_overmount(struct mount *m)
+{
+	while (m->overmount)
+		m = m->overmount;
+	return m;
+}
+
 struct mnt_namespace *mnt_ns_from_dentry(struct dentry *dentry);
diff --git a/fs/namespace.c b/fs/namespace.c
index 085877bfaa5e..ebecb03972c5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2696,10 +2696,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				 child->mnt_mountpoint);
 		commit_tree(child);
 		if (q) {
+			struct mount *r = topmost_overmount(child);
 			struct mountpoint *mp = root.mp;
-			struct mount *r = child;
-			while (unlikely(r->overmount))
-				r = r->overmount;
+
 			if (unlikely(shorter) && child != source_mnt)
 				mp = shorter;
 			mnt_change_mountpoint(r, mp, q);
@@ -6171,9 +6170,7 @@ bool current_chrooted(void)
 
 	guard(mount_locked_reader)();
 
-	root = current->nsproxy->mnt_ns->root;
-	while (unlikely(root->overmount))
-		root = root->overmount;
+	root = topmost_overmount(current->nsproxy->mnt_ns->root);
 
 	return fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 }
-- 
2.47.2


