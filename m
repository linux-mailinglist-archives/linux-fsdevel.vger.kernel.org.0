Return-Path: <linux-fsdevel+bounces-58932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A2EB33573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD4F7A71F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CA283FE1;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fjIe9XaH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E7022A4EE
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=np0tPsG7g0UGELkgWPih7PMIpgOrkj1LYnSuTGgf4/7AJZEq6haaelaowblAeTwzVX/NvOplxtiEw4tLX/wsHmGgYYHueNvQt0Xidgh/aR7BfCaEr/jOFv6mKcnSndvqGVtE63MKMp2hY6JBKhQHEmXbSRKgDrpoi8rN6+0yuLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=rUUhv76sTCzDKkRXOFD5h5TedzF8r2WYvJy7r2m4al0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoVVkuHBOxlvD9qv4qv+ZKBCzaZoSN1s4/yZfhk13IU5xczMrFg7J//csa8/7qLdXfPZWhjmbvsuJQB0XHHXYPt52CjtTGGEAFm8+jRqfY7kUrJd3qioIc8vlpgLqHTxZZGQ/quFzY1fkIDu+jISw1mrhPZRKV9uu6naR3GAsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=fjIe9XaH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZwbN4EOslmqmmdS373dT6Lp2PgkSNMJLAqH9LTgfJWM=; b=fjIe9XaHeQxQH1QAb4FOwvsncU
	Y0aV4IVrHquFnGm4LNq/xODvOxNPLTTTIpIIcgvGUSEwK8wfJNRM4hCgV/p3XOXcVjJ+mzZ+lfYbV
	ZyYaUEzr9qQ18RWbup33ocZnYH468GCakZB8Gz5nQNmXgfbcx8ek5IDmAmCGOkNCJKXjwv7T14i1G
	EBstcbbfSMwNH+9I5BCiskWFSVZ+hZj/B2EjyUu7EnzF7SswoqiMvC6/jOxeBk9Ii+Bsg1Y/ViypC
	KyX+x0Dv4vEbhMkSoY5KAyvP/HH8qtK7y520rrNJafLro8h1MRcH5vw2C53Aud1cEPBCduqN733Zr
	aEHQzz9Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TCl-1mE1;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 30/52] graft_tree(), attach_recursive_mnt() - pass pinned_mountpoint
Date: Mon, 25 Aug 2025 05:43:33 +0100
Message-ID: <20250825044355.1541941-30-viro@zeniv.linux.org.uk>
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

parent and mountpoint always come from the same struct pinned_mountpoint
now.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 06c672127aee..9ffdbb093f57 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2613,10 +2613,11 @@ enum mnt_tree_flags_t {
  *         Otherwise a negative error code is returned.
  */
 static int attach_recursive_mnt(struct mount *source_mnt,
-				struct mount *dest_mnt,
-				struct mountpoint *dest_mp)
+				const struct pinned_mountpoint *dest)
 {
 	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
+	struct mount *dest_mnt = dest->parent;
+	struct mountpoint *dest_mp = dest->mp;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
 	struct pinned_mountpoint root = {};
@@ -2864,16 +2865,16 @@ static inline void unlock_mount(struct pinned_mountpoint *m)
 	struct pinned_mountpoint mp __cleanup(unlock_mount) = {}; \
 	lock_mount_exact((path), &mp)
 
-static int graft_tree(struct mount *mnt, struct mount *p, struct mountpoint *mp)
+static int graft_tree(struct mount *mnt, const struct pinned_mountpoint *mp)
 {
 	if (mnt->mnt.mnt_sb->s_flags & SB_NOUSER)
 		return -EINVAL;
 
-	if (d_is_dir(mp->m_dentry) !=
+	if (d_is_dir(mp->mp->m_dentry) !=
 	      d_is_dir(mnt->mnt.mnt_root))
 		return -ENOTDIR;
 
-	return attach_recursive_mnt(mnt, p, mp);
+	return attach_recursive_mnt(mnt, mp);
 }
 
 static int may_change_propagation(const struct mount *m)
@@ -3055,7 +3056,7 @@ static int do_loopback(struct path *path, const char *old_name,
 	if (IS_ERR(mnt))
 		return PTR_ERR(mnt);
 
-	err = graft_tree(mnt, mp.parent, mp.mp);
+	err = graft_tree(mnt, &mp);
 	if (err) {
 		lock_mount_hash();
 		umount_tree(mnt, UMOUNT_SYNC);
@@ -3634,7 +3635,7 @@ static int do_move_mount(struct path *old_path,
 	if (mount_is_ancestor(old, mp.parent))
 		return -ELOOP;
 
-	return attach_recursive_mnt(old, mp.parent, mp.mp);
+	return attach_recursive_mnt(old, &mp);
 }
 
 static int do_move_mount_old(struct path *path, const char *old_name)
@@ -3685,7 +3686,7 @@ static int do_add_mount(struct mount *newmnt, const struct pinned_mountpoint *mp
 		return -EINVAL;
 
 	newmnt->mnt.mnt_flags = mnt_flags;
-	return graft_tree(newmnt, parent, mp->mp);
+	return graft_tree(newmnt, mp);
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags);
-- 
2.47.2


