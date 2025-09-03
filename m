Return-Path: <linux-fsdevel+bounces-60059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFF3B413D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66DD3A8DD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1862D6638;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oYEUUN93"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBE52D5406
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=NKGrwy2UlesEayh+sx74po6P1Z9ANW0os/XjLC/C7TqUjIicpl0KVjTcnKb+Rnrp8es/cwcpl5VD9HqrdWDUcyDLuXnJxyMpRxAsgFIhN6jOxK9akgSlAl4VoTC9X0hxyPYQ4OPmvKPB1D/J1E3+4flm+yJdr3ajJeRuOxkWiCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=i6mHsXysQv8boWetc+D4/Qiu1RZM4yOhfso2NT6j3ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k537nOC4XUoJN7YcN1ClmD+edPC6j7Eg5TUdV3dKScqlJGvK6hrxb/FyMQ9re2QsbpXqF0ZzHgsAXm/d7Xn4fzebRylMoAgPQX4QNuTDql/IpYWK5+nVvgAs3JRWHAeujUE2vyaLw8xeBezu4mENbl/4SiQ+/RaoA1/R8Uob51k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oYEUUN93; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=XvF9KEvQss6v1rjjTON0Gi0bvjUJY+0Q1CEPVWqWZKA=; b=oYEUUN93Dvxr3mj62oaq0It3r0
	z2IIQudUcEcb+isA5vGusNoE3S5hc4ylfyggMLBf4Dc0Isv6Kqq7Gsv7isce9fsmVcAFG5jWuQWyr
	9YzkBR/qSdLQ08b1eloT7RYXsAww+Pc/6Ua45vSNODRu3rwDMjv4KceQhUcC5d5HG7L6Hzmh21uon
	xFDHeTe5M7zn6mbmBvGQhAFseMFCqCvKAznAX7/GnUl9cI/Esy2QdMGXi2DfgDegLaZcyRXEIq5VT
	w2qXhUcmwMn7usLq0hC0BQPve4Nm57VaKXQSGu2WJGXpYFmLIrF0mF6UxAlBJKsnpz+LJui0VRdEn
	z7ItTDGQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap7d-2Z1d;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 15/65] path_is_under(): use guards
Date: Wed,  3 Sep 2025 05:54:36 +0100
Message-ID: <20250903045537.2579614-15-viro@zeniv.linux.org.uk>
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


