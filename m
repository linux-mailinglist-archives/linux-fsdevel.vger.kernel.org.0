Return-Path: <linux-fsdevel+bounces-57598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CFCB23C8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 01:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51A8A56792D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19F2E5B01;
	Tue, 12 Aug 2025 23:53:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAE2D8375;
	Tue, 12 Aug 2025 23:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755042784; cv=none; b=eX373CJkVVShnR6DqTpS/T04FEIEKW4pTFkI8QiMDH/PsDnVZ0f3ITTG3JZy7GWb1zndCDT0mJz0ELksU7Dzc/AHwuXEMa0tVgFBUMrDG8lQaR/fV+G4vd2olEf1Ad2vTn60CigyNJ3NDLFu8/o3r1Hf/MqpttboAvBFrOkV4mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755042784; c=relaxed/simple;
	bh=Ws9vdrtNTe7GKpziIopOHzn03qCiXQiZM2MeU+FDdAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb1QfPXbiNNaMf8PW8EvvnSKNuUkipKOncn4xZU+iUK55zIMSHEfw13oqC3LQR3Cj4uPkhIdN0sBPu6u2EmiKzlvAnF4I1JMgAy9uL9SwGPlvAUSo4Kq+wm57YY2UdQgl1tK4NSUJor1ht7pIEOSZMXjwZhGymMFM+OF9ViVK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ulynL-005Y20-C5;
	Tue, 12 Aug 2025 23:52:45 +0000
From: NeilBrown <neil@brown.name>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Xiubo Li <xiubli@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Steve French <sfrench@samba.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-afs@lists.infradead.org,
	netfs@lists.linux.dev,
	ceph-devel@vger.kernel.org,
	ecryptfs@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] VFS: introduce dentry_lookup_continue()
Date: Tue, 12 Aug 2025 12:25:07 +1000
Message-ID: <20250812235228.3072318-5-neil@brown.name>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250812235228.3072318-1-neil@brown.name>
References: <20250812235228.3072318-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few callers operate on a dentry which they already have - unlike the
normal case where a lookup proceeds an operation.

For these callers dentry_lookup_continue() is provided where other
callers would use dentry_lookup().  The call will fail if, after the
lock was gained, the child is no longer a child of the given parent.

There are a couple of callers that want to lock a dentry in whatever
its current parent is.  For these a NULL parent can be passed, in which
case ->d_parent is used.  In this case the call cannot fail.

The idea behind the name is that the actual lookup occurred some time
ago, and now we are continuing with an operation on the dentry.

When the operation completes done_dentry_lookup() must be called.  An
extra reference is taken when the dentry_lookup_continue() call succeeds
and will be dropped by done_dentry_lookup().

This will be used in smb/server, ecryptfs, and overlayfs, each of which
have their own lock_parent() or parent_lock() or similar; and a few
other places which lock the parent but don't check if the parent is
still correct (often because rename isn't supported so parent cannot be
incorrect).

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c            | 39 +++++++++++++++++++++++++++++++++++++++
 include/linux/namei.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 7af9b464886a..df21b6fa5a0e 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1874,6 +1874,45 @@ struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 }
 EXPORT_SYMBOL(dentry_lookup_killable);
 
+/**
+ * dentry_lookup_continue: lock a dentry if it is still in the given parent, prior to dir ops
+ * @child: the dentry to lock
+ * @parent: the dentry of the assumed parent
+ *
+ * The child is locked - currently by taking i_rwsem on the parent - to
+ * prepare for create/remove operations.  If the given parent is not
+ * %NULL and is no longer the parent of the dentry after the lock is
+ * gained, the lock is released and the call fails (returns
+ * ERR_PTR(-EINVAL).
+ *
+ * On success a reference to the child is taken and returned.  The lock
+ * and reference must both be dropped by done_dentry_lookup() after the
+ * operation completes.
+ */
+struct dentry *dentry_lookup_continue(struct dentry *child,
+				      struct dentry *parent)
+{
+	struct dentry *p = parent;
+
+again:
+	if (!parent)
+		p = dget_parent(child);
+	inode_lock_nested(d_inode(p), I_MUTEX_PARENT);
+	if (child->d_parent != p) {
+		inode_unlock(d_inode(p));
+		if (!parent) {
+			dput(p);
+			goto again;
+		}
+		return ERR_PTR(-EINVAL);
+	}
+	if (!parent)
+		dput(p);
+	/* get the child to balance with done_dentry_lookup() which puts it. */
+	return dget(child);
+}
+EXPORT_SYMBOL(dentry_lookup_continue);
+
 /**
  * done_dentry_lookup - finish a lookup used for create/delete
  * @dentry:  the target dentry
diff --git a/include/linux/namei.h b/include/linux/namei.h
index facb5852afa9..67eef91603cc 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -88,6 +88,8 @@ struct dentry *dentry_lookup_killable(struct mnt_idmap *idmap,
 				      unsigned int lookup_flags);
 struct dentry *dentry_lookup_noperm(struct qstr *name, struct dentry *base,
 				      unsigned int lookup_flags);
+struct dentry *dentry_lookup_continue(struct dentry *child,
+				      struct dentry *parent);
 void done_dentry_lookup(struct dentry *dentry);
 /* no_free_ptr() must not be used here - use dget() */
 DEFINE_FREE(dentry_lookup, struct dentry *, if (_T) done_dentry_lookup(_T))
-- 
2.50.0.107.gf914562f5916.dirty


