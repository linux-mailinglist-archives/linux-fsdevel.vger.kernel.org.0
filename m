Return-Path: <linux-fsdevel+bounces-60044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62DB413BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB37188BAD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026B2D5416;
	Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="npmE2NZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978B28726D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875341; cv=none; b=UaPnOddYKHQg1DtHSvJEnrXkrYRtkT2xTJNRACuwdnMWZHxx9G//MDMqZvxcMVftp1suWeNi3QEipefvuUQ4er7DymsSTRGXtu41yThpPtrMzBTHo5n5zYBs2IKU6CeuVKhBjdTj5lO65YbVotYhUoKd7ZJDxANqhbFsbK+4/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875341; c=relaxed/simple;
	bh=YN+sKSTJwhy8QI9tiegPGF2G8T5ZC+EVzrCMpMm/IJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M30V9el56wPXYGj7fkZjERfKADfSheQu/coGl978PGysCKZoVIg56+/Yulqi53C/bVtlJ64BnsgVEm14S++UsP27uwRncOZGrRcApcMesDm1F14ovCCJv6p+kTtRpM5Qq96JYQrHwu7kB+294SK66b3FLfOfky+9b+m2+Fx55Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=npmE2NZr; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H2xml+0S5NMK4Cobv1ItTBbEZTlEzN1SBUZ6HJxgRzs=; b=npmE2NZrIVhfpFT8O70pmlHFRA
	dX1WuBBMsAwoIV3l5LgI/OwlxZjPUv9Q5ev2hUbPwzZ+/zXKG6Q7XwbwTsPmjbidwndvoIIrZABpW
	xY/IFqhgNP+hCcPQtjv+/1jPAahn86ZDt0Z0ORHVvKLynx3Kvi8feVEnLZSN1XNcE9VtIUNWqhK8o
	2kec+aQd/0V43mL1YkVF+e6ueLKmw7NeKT2NWAmQEB5E/6zbBlVX652LNphd3+UWm830XKL+9fRd7
	CGspVb1GEpMn20XoVw1S7AwbPxF/tckYubD/rXaMhpg+UVM68mudAiKFcV26+qCG1FEjk4bmy6neq
	J1OPC9bg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfWz-0000000Ap4w-2kOM;
	Wed, 03 Sep 2025 04:55:37 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 01/65] fs/namespace.c: fix the namespace_sem guard mess
Date: Wed,  3 Sep 2025 05:54:22 +0100
Message-ID: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045432.GH39973@ZenIV>
References: <20250903045432.GH39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

If anything, namespace_lock should be DEFINE_LOCK_GUARD_0, not DEFINE_GUARD.
That way we
	* do not need to feed it a bogus argument
	* do not get gcc trying to compare an address of static in
file variable with -4097 - and, if we are unlucky, trying to keep
it in a register, with spills and all such.

The same problems apply to grabbing namespace_sem shared.

Rename it to namespace_excl, add namespace_shared, convert the existing users:

    guard(namespace_lock, &namespace_sem) => guard(namespace_excl)()
    guard(rwsem_read, &namespace_sem) => guard(namespace_shared)()
    scoped_guard(namespace_lock, &namespace_sem) => scoped_guard(namespace_excl)
    scoped_guard(rwsem_read, &namespace_sem) => scoped_guard(namespace_shared)

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index ae6d1312b184..fcea65587ff9 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -82,6 +82,12 @@ static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
 static struct mnt_namespace *emptied_ns; /* protected by namespace_sem */
 static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 
+static inline void namespace_lock(void);
+static void namespace_unlock(void);
+DEFINE_LOCK_GUARD_0(namespace_excl, namespace_lock(), namespace_unlock())
+DEFINE_LOCK_GUARD_0(namespace_shared, down_read(&namespace_sem),
+				      up_read(&namespace_sem))
+
 #ifdef CONFIG_FSNOTIFY
 LIST_HEAD(notify_list); /* protected by namespace_sem */
 #endif
@@ -1776,8 +1782,6 @@ static inline void namespace_lock(void)
 	down_write(&namespace_sem);
 }
 
-DEFINE_GUARD(namespace_lock, struct rw_semaphore *, namespace_lock(), namespace_unlock())
-
 enum umount_tree_flags {
 	UMOUNT_SYNC = 1,
 	UMOUNT_PROPAGATE = 2,
@@ -2306,7 +2310,7 @@ struct path *collect_paths(const struct path *path,
 	struct path *res = prealloc, *to_free = NULL;
 	unsigned n = 0;
 
-	guard(rwsem_read)(&namespace_sem);
+	guard(namespace_shared)();
 
 	if (!check_mnt(root))
 		return ERR_PTR(-EINVAL);
@@ -2361,7 +2365,7 @@ void dissolve_on_fput(struct vfsmount *mnt)
 			return;
 	}
 
-	scoped_guard(namespace_lock, &namespace_sem) {
+	scoped_guard(namespace_excl) {
 		if (!anon_ns_root(m))
 			return;
 
@@ -2435,7 +2439,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	struct mount *old_mnt = real_mount(path->mnt);
 	struct mount *new_mnt;
 
-	guard(rwsem_read)(&namespace_sem);
+	guard(namespace_shared)();
 
 	if (IS_MNT_UNBINDABLE(old_mnt))
 		return ERR_PTR(-EINVAL);
@@ -5957,7 +5961,7 @@ SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,
 	if (ret)
 		return ret;
 
-	scoped_guard(rwsem_read, &namespace_sem)
+	scoped_guard(namespace_shared)
 		ret = do_statmount(ks, kreq.mnt_id, kreq.mnt_ns_id, ns);
 
 	if (!ret)
@@ -6079,7 +6083,7 @@ SYSCALL_DEFINE4(listmount, const struct mnt_id_req __user *, req,
 	 * We only need to guard against mount topology changes as
 	 * listmount() doesn't care about any mount properties.
 	 */
-	scoped_guard(rwsem_read, &namespace_sem)
+	scoped_guard(namespace_shared)
 		ret = do_listmount(ns, kreq.mnt_id, last_mnt_id, kmnt_ids,
 				   nr_mnt_ids, (flags & LISTMOUNT_REVERSE));
 	if (ret <= 0)
-- 
2.47.2


