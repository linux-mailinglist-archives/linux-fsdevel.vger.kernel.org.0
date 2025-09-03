Return-Path: <linux-fsdevel+bounces-60076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B87E4B413E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 696561BA1296
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCDB2D8DC4;
	Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="f8O17D5R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F56B2D7DC3
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875347; cv=none; b=jKKPeEt7wkDmJnTT34DkMnYvfOWeSdevHNyOXaRZaPACAMhDR7DDiHvk0RykBy49Z9Wqpt5USiYxWIDbzxgxwSxuBzObn/2tl+tB0cBsUjyuo7DHD8wbAqTAsBj1Dgt6hacmA53i3P0kVN/S2/2t1GX5J/oQviBXwDv24NpuLN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875347; c=relaxed/simple;
	bh=iUi3MLu+bnGQIK/ZWCYcQfreCveqosr7Ibkc8qdhZ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oGXiILXVKr5qkkiP2DJuepBvnJQnfdb2GAyxCKtTVpa6QvNbmTz42O3DCtN0ZgO0wRM1YvE1KolqTYipDMKQipbqHidJu/C02M/5hskIXPyI1ciOadHYp8fqd66giQeJCR3pscBjloB/YSomhCFWIGz0ZV8+GJdEe35AzVUnhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=f8O17D5R; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=afy9+Tt5SlcftT8tbivgr6oDKcbxktG9urarBzr3/mA=; b=f8O17D5R5CIBvcb5CfK19oVAw3
	Xa5lhIcxBcFgBG4frcGoKnTGW1m4VjagDPrqSydt7PZbjt4VnAY1zDmyXqT1hyR58w6LYlgKU+7Ru
	w0MgS9eGE78NazcIuMhUXqLOIeUeCT1VD/4ZPjx6q7EungV69xIZYV1m0hZTpWED/liwnZ9sbKKmB
	9bLpQZthXfKV6m9scLNSWVntenkb1+7UQnSrYQW2U8/uat6kcwBvxOeusTkyrVq695dnbtY+j4TIJ
	ALXsVJnNsiFkVf+ZqxmuOJ2WRVUPvgIPWjBOJrHbRrc3rPmo1s0xge05qiWRGXeA3kbx1cI/IZlia
	OCqk05ZQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX6-0000000ApBT-0l2y;
	Wed, 03 Sep 2025 04:55:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 34/65] new helper: topmost_overmount()
Date: Wed,  3 Sep 2025 05:54:56 +0100
Message-ID: <20250903045537.2579614-35-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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
index b81677a4232f..23ef2e56808b 100644
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
@@ -6173,9 +6172,7 @@ bool current_chrooted(void)
 
 	guard(mount_locked_reader)();
 
-	root = current->nsproxy->mnt_ns->root;
-	while (unlikely(root->overmount))
-		root = root->overmount;
+	root = topmost_overmount(current->nsproxy->mnt_ns->root);
 
 	return fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 }
-- 
2.47.2


