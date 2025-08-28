Return-Path: <linux-fsdevel+bounces-59557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3E8B3AE1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F221B22092
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D96C2F39DA;
	Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="gpVEw/c3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F323A2D0C9D
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422494; cv=none; b=GF8cKLUkCWaK9akFBF0yatj+ljgeGDX6e+4y5pIZWxflaVisShx+mMg/laRS0WyfoVpuLcD2iBMyUjSzPPuPJpdO8jjc3/p5vuS99BsH9HkTdkMgZAcDuCQ4HEqh4XMfpEhjoQ2e6nXkWzOH+yOUwAhXvk4m8ufkKLsLiOI4YnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422494; c=relaxed/simple;
	bh=i6mHsXysQv8boWetc+D4/Qiu1RZM4yOhfso2NT6j3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGVX0ANw3V0DK4V6t5GtYezP9W87Nm0SH22Gz0HyL5wbntqAdsi8QNvWHWfn+V22IrpM735Q2mzDkozUNe/mqJ0g+RXaLqijU7HgCJbBW6s2Rnr5RKjVNLZAnnuGihtiwAhqzJlc9pDKptkQOkSWAl+WA3m/bVs7rYa/xeS+OkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=gpVEw/c3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XvF9KEvQss6v1rjjTON0Gi0bvjUJY+0Q1CEPVWqWZKA=; b=gpVEw/c3AywqbTHbvQVlHXevlr
	7OmFH2MhGRNxWi3P6PNS5cVRsfVNMSxurgBXnJHm2VSPt2BxwmvfN0G/NaqL/7FzeMdfe03hlUHl+
	JGQBRaGG+gowL+F0BpM/h7rrcAhD0VCfkE2rjEHxzs0Ro9cd3M2lgwFdrOAq4oBTOvwozv0lxR2Qy
	WOIEYfK/nzs0zVm0uMKT9GEvf1pU84OKXdXaCVyzNCmgHp4B6Jb1/iRZ6JiJ+Bn9FlrjHT2bBzCzx
	EEXUyhEheSuGivwrpX8R2UtSPOCtBgYwPUOvobraqKnryx1KR7tCFggl/tcxdsBJr3Qpej1+g7/gQ
	eQTvM84g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22o-1wt8;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 15/63] path_is_under(): use guards
Date: Fri, 29 Aug 2025 00:07:18 +0100
Message-ID: <20250828230806.3582485-15-viro@zeniv.linux.org.uk>
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

... and document that locking requirements for is_path_reachable().
There is one questionable caller in do_listmount() where we are not
holding mount_lock *and* might not have the first argument mounted.
However, in that case it will immediately return true without having
to look at the ancestors.  Might be cleaner to move the check into
non-LSTM_ROOT case which it really belongs in - there the check is
not always true and is_mounted() is guaranteed.

Document the locking environments for is_path_reachable() callers:
	get_peer_under_root()
	get_dominating_id()
	do_statmount()
	do_listmount()

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 fs/pnode.c     |  3 ++-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index db25c81d7f68..6aabf0045389 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4592,7 +4592,7 @@ SYSCALL_DEFINE5(move_mount,
 /*
  * Return true if path is reachable from root
  *
- * namespace_sem or mount_lock is held
+ * locks: mount_locked_reader || namespace_shared && is_mounted(mnt)
  */
 bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
 			 const struct path *root)
@@ -4606,11 +4606,8 @@ bool is_path_reachable(struct mount *mnt, struct dentry *dentry,
 
 bool path_is_under(const struct path *path1, const struct path *path2)
 {
-	bool res;
-	read_seqlock_excl(&mount_lock);
-	res = is_path_reachable(real_mount(path1->mnt), path1->dentry, path2);
-	read_sequnlock_excl(&mount_lock);
-	return res;
+	guard(mount_locked_reader)();
+	return is_path_reachable(real_mount(path1->mnt), path1->dentry, path2);
 }
 EXPORT_SYMBOL(path_is_under);
 
@@ -5689,6 +5686,7 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 			     STATMOUNT_MNT_UIDMAP | \
 			     STATMOUNT_MNT_GIDMAP)
 
+/* locks: namespace_shared */
 static int do_statmount(struct kstatmount *s, u64 mnt_id, u64 mnt_ns_id,
 			struct mnt_namespace *ns)
 {
@@ -5949,6 +5947,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	return ret;
 }
 
+/* locks: namespace_shared */
 static ssize_t do_listmount(struct mnt_namespace *ns, u64 mnt_parent_id,
 			    u64 last_mnt_id, u64 *mnt_ids, size_t nr_mnt_ids,
 			    bool reverse)
diff --git a/fs/pnode.c b/fs/pnode.c
index 0702d45d856d..edaf9d9d0eaf 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -29,6 +29,7 @@ static inline struct mount *next_slave(struct mount *p)
 	return hlist_entry(p->mnt_slave.next, struct mount, mnt_slave);
 }
 
+/* locks: namespace_shared && is_mounted(mnt) */
 static struct mount *get_peer_under_root(struct mount *mnt,
 					 struct mnt_namespace *ns,
 					 const struct path *root)
@@ -50,7 +51,7 @@ static struct mount *get_peer_under_root(struct mount *mnt,
  * Get ID of closest dominating peer group having a representative
  * under the given root.
  *
- * Caller must hold namespace_sem
+ * locks: namespace_shared
  */
 int get_dominating_id(struct mount *mnt, const struct path *root)
 {
-- 
2.47.2


