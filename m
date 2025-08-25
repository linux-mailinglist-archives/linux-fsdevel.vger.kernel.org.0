Return-Path: <linux-fsdevel+bounces-58945-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5660AB3358B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741731751E3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B5C2853F9;
	Mon, 25 Aug 2025 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QC9a1247"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9782827C84E
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097045; cv=none; b=ZFBehg1yfwQeSVL9ZLvUcKaqOGosk8l+mWoHPrlHgulFfmKqCKifz6bvcaLL85sJ/PLCzj8wm4UX91HvAtXM7nd6hZremYhlw2jTShjVFmWrEXABZDIwQQH/+GHc4PD08KUlWHo9yjbDmKaVXx6IuxRzZGsZxdC1Pm+UXedcvKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097045; c=relaxed/simple;
	bh=JMffEIfSeskW40XB/TG0BRy+TlLYR6mJS01RYscA8/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8Fk88vaJW7rFQZRF2DBk+fUwlwX3KMXTl43C9U5uRhLKQD6iXhBGy+IVqaxsAiMaLvRlL6OwwUubqEIjddwJPuTTjmHkgbyWKv6/JtQBErqPHJCOS67BkpZ9QNojp74vaAnaS+9oYb31hlyfI+81ZVZDk3tgpoRnnRmldlk7FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QC9a1247; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xjPmjbKgYtdisXQZ6x86+aFhJvOmDdwevoIK2oP/w1E=; b=QC9a1247DjUmiv7/u9xCO+8pV+
	lFYMY+EG/C/YlFYm0EboKiLHZlRZoCVDmVLlzvoe5ZQLBgkz29SC8+F3t+3rxK00ZKw/jv+YXzK7K
	mcucPqV3kPRKKprbfOpEhe6lxjdtPu+pfSEz/5yQPNMZRnxfwZpJa+P5HC3mSWIucohmjseDUL1Rp
	X/bf7zcQGpKYuCqeA4Wp42JQVN0q6HuiuuqRYDX1CoYLr8ZQdfmHkcFcOC+gSrxpcCDlL2QowJt9m
	Ms3T0PQzS0vOGrqWVQ7l6cnfqzwxzcBLAoozrHTHk/dEh4G3VamZ8WVGz3kUneRNU1jBWFQEyrLmG
	BBFGUnpw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TDD-3cY8;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 33/52] new helper: topmost_overmount()
Date: Mon, 25 Aug 2025 05:43:36 +0100
Message-ID: <20250825044355.1541941-33-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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
index 7d51763fc76c..93eba16e42b6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2697,10 +2697,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
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
@@ -6178,9 +6177,7 @@ bool current_chrooted(void)
 
 	guard(mount_locked_reader)();
 
-	root = current->nsproxy->mnt_ns->root;
-	while (unlikely(root->overmount))
-		root = root->overmount;
+	root = topmost_overmount(current->nsproxy->mnt_ns->root);
 
 	return fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 }
-- 
2.47.2


