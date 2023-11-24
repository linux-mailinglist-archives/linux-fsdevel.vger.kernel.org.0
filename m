Return-Path: <linux-fsdevel+bounces-3634-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DB17F6C1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 07:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1A2B211B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30525C148;
	Fri, 24 Nov 2023 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h6uxPVpD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4091BC7;
	Thu, 23 Nov 2023 22:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GcfTuaWVQPCS7puEb1+RQFw6+OE2U6724eCvpTjdznc=; b=h6uxPVpDuMn8zlO3hV+M1TfD4N
	lrjLhg+QKLuvqZBnAJW9KZuR1CbZvpcfkeKGJbLgr8MANiCg8gvVvUSvWei0l5rU5CSFYyWrvE85S
	ZhV96sJqE8gB1bqtk78YiTw4oAVAaLNPom778qwiDEOp6ZlwCQHHudYGh+uSLnOE5rDqvAoLkUHZj
	re5LJx3hgafVZQ3xe50Uiiqpt8b7slXSJazoSz0ObLtQgEaTg+G74WshwJPt7jwyF/x+CRPWuvSFG
	s09YfgZ6ZXBXGktenT8GuXrxGLIUGTBsbHJJWvlMonDm0ffG09wlQ7eLT20GJ2I+R77V6AaJEjTES
	+rHWE8xw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r6PKy-002Q23-0g;
	Fri, 24 Nov 2023 06:06:48 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/20] dcache: remove unnecessary NULL check in dget_dlock()
Date: Fri, 24 Nov 2023 06:06:44 +0000
Message-Id: <20231124060644.576611-20-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124060644.576611-1-viro@zeniv.linux.org.uk>
References: <20231124060553.GA575483@ZenIV>
 <20231124060644.576611-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

From: Vegard Nossum <vegard.nossum@oracle.com>

dget_dlock() requires dentry->d_lock to be held when called, yet
contains a NULL check for dentry.

An audit of all calls to dget_dlock() shows that it is never called
with a NULL pointer (as spin_lock()/spin_unlock() would crash in these
cases):

  $ git grep -W '\<dget_dlock\>'

  arch/powerpc/platforms/cell/spufs/inode.c-              spin_lock(&dentry->d_lock);
  arch/powerpc/platforms/cell/spufs/inode.c-              if (simple_positive(dentry)) {
  arch/powerpc/platforms/cell/spufs/inode.c:                      dget_dlock(dentry);

  fs/autofs/expire.c-             spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
  fs/autofs/expire.c-             if (simple_positive(child)) {
  fs/autofs/expire.c:                     dget_dlock(child);

  fs/autofs/root.c:                       dget_dlock(active);
  fs/autofs/root.c-                       spin_unlock(&active->d_lock);

  fs/autofs/root.c:                       dget_dlock(expiring);
  fs/autofs/root.c-                       spin_unlock(&expiring->d_lock);

  fs/ceph/dir.c-          if (!spin_trylock(&dentry->d_lock))
  fs/ceph/dir.c-                  continue;
  [...]
  fs/ceph/dir.c:                          dget_dlock(dentry);

  fs/ceph/mds_client.c-           spin_lock(&alias->d_lock);
  [...]
  fs/ceph/mds_client.c:                   dn = dget_dlock(alias);

  fs/configfs/inode.c-            spin_lock(&dentry->d_lock);
  fs/configfs/inode.c-            if (simple_positive(dentry)) {
  fs/configfs/inode.c:                    dget_dlock(dentry);

  fs/libfs.c:                             found = dget_dlock(d);
  fs/libfs.c-                     spin_unlock(&d->d_lock);

  fs/libfs.c:             found = dget_dlock(child);
  fs/libfs.c-     spin_unlock(&child->d_lock);

  fs/libfs.c:                             child = dget_dlock(d);
  fs/libfs.c-                     spin_unlock(&d->d_lock);

  fs/ocfs2/dcache.c:                      dget_dlock(dentry);
  fs/ocfs2/dcache.c-                      spin_unlock(&dentry->d_lock);

  include/linux/dcache.h:static inline struct dentry *dget_dlock(struct dentry *dentry)

After taking out the NULL check, dget_dlock() becomes almost identical
to __dget_dlock(); the only difference is that dget_dlock() returns the
dentry that was passed in. These are static inline helpers, so we can
rely on the compiler to discard unused return values. We can therefore
also remove __dget_dlock() and replace calls to it by dget_dlock().

Also fix up and improve the kerneldoc comments while we're at it.

Al Viro pointed out that we can also clean up some of the callers to
make use of the returned value and provided a bit more info for the
kerneldoc.

While preparing v2 I also noticed that the tabs used in the kerneldoc
comments were causing the kerneldoc to get parsed incorrectly so I also
fixed this up (including for d_unhashed, which is otherwise unrelated).

Testing: x86 defconfig build + boot; make htmldocs for the kerneldoc
warning. objdump shows there are code generation changes.

Link: https://lore.kernel.org/all/20231022164520.915013-1-vegard.nossum@oracle.com/
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: Nick Piggin <npiggin@kernel.dk>
Cc: Waiman Long <Waiman.Long@hp.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c            | 16 ++++------------
 include/linux/dcache.h | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 64d8c1d36acb..e771977992ae 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -877,12 +877,6 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 	spin_unlock(&dentry->d_lock);
 }
 
-/* This must be called with d_lock held */
-static inline void __dget_dlock(struct dentry *dentry)
-{
-	dentry->d_lockref.count++;
-}
-
 struct dentry *dget_parent(struct dentry *dentry)
 {
 	int gotref;
@@ -964,7 +958,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
 		spin_lock(&alias->d_lock);
  		if (!d_unhashed(alias)) {
-			__dget_dlock(alias);
+			dget_dlock(alias);
 			spin_unlock(&alias->d_lock);
 			return alias;
 		}
@@ -1569,8 +1563,7 @@ static enum d_walk_ret find_submount(void *_data, struct dentry *dentry)
 {
 	struct dentry **victim = _data;
 	if (d_mountpoint(dentry)) {
-		__dget_dlock(dentry);
-		*victim = dentry;
+		*victim = dget_dlock(dentry);
 		return D_WALK_QUIT;
 	}
 	return D_WALK_CONTINUE;
@@ -1715,8 +1708,7 @@ struct dentry *d_alloc(struct dentry * parent, const struct qstr *name)
 	 * don't need child lock because it is not subject
 	 * to concurrency here
 	 */
-	__dget_dlock(parent);
-	dentry->d_parent = parent;
+	dentry->d_parent = dget_dlock(parent);
 	hlist_add_head(&dentry->d_sib, &parent->d_children);
 	spin_unlock(&parent->d_lock);
 
@@ -2681,7 +2673,7 @@ struct dentry *d_exact_alias(struct dentry *entry, struct inode *inode)
 			spin_unlock(&alias->d_lock);
 			alias = NULL;
 		} else {
-			__dget_dlock(alias);
+			dget_dlock(alias);
 			__d_rehash(alias);
 			spin_unlock(&alias->d_lock);
 		}
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 48b393545ec2..1666c387861f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -287,20 +287,40 @@ extern char *dentry_path(const struct dentry *, char *, int);
 /* Allocation counts.. */
 
 /**
- *	dget, dget_dlock -	get a reference to a dentry
- *	@dentry: dentry to get a reference to
+ * dget_dlock -	get a reference to a dentry
+ * @dentry: dentry to get a reference to
  *
- *	Given a dentry or %NULL pointer increment the reference count
- *	if appropriate and return the dentry. A dentry will not be 
- *	destroyed when it has references.
+ * Given a live dentry, increment the reference count and return the dentry.
+ * Caller must hold @dentry->d_lock.  Making sure that dentry is alive is
+ * caller's resonsibility.  There are many conditions sufficient to guarantee
+ * that; e.g. anything with non-negative refcount is alive, so's anything
+ * hashed, anything positive, anyone's parent, etc.
  */
 static inline struct dentry *dget_dlock(struct dentry *dentry)
 {
-	if (dentry)
-		dentry->d_lockref.count++;
+	dentry->d_lockref.count++;
 	return dentry;
 }
 
+
+/**
+ * dget - get a reference to a dentry
+ * @dentry: dentry to get a reference to
+ *
+ * Given a dentry or %NULL pointer increment the reference count
+ * if appropriate and return the dentry.  A dentry will not be
+ * destroyed when it has references.  Conversely, a dentry with
+ * no references can disappear for any number of reasons, starting
+ * with memory pressure.  In other words, that primitive is
+ * used to clone an existing reference; using it on something with
+ * zero refcount is a bug.
+ *
+ * NOTE: it will spin if @dentry->d_lock is held.  From the deadlock
+ * avoidance point of view it is equivalent to spin_lock()/increment
+ * refcount/spin_unlock(), so calling it under @dentry->d_lock is
+ * always a bug; so's calling it under ->d_lock on any of its descendents.
+ *
+ */
 static inline struct dentry *dget(struct dentry *dentry)
 {
 	if (dentry)
@@ -311,12 +331,11 @@ static inline struct dentry *dget(struct dentry *dentry)
 extern struct dentry *dget_parent(struct dentry *dentry);
 
 /**
- *	d_unhashed -	is dentry hashed
- *	@dentry: entry to check
+ * d_unhashed - is dentry hashed
+ * @dentry: entry to check
  *
- *	Returns true if the dentry passed is not currently hashed.
+ * Returns true if the dentry passed is not currently hashed.
  */
- 
 static inline int d_unhashed(const struct dentry *dentry)
 {
 	return hlist_bl_unhashed(&dentry->d_hash);
-- 
2.39.2


