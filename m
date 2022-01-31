Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F764A49F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 16:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377830AbiAaPOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 10:14:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51968 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377073AbiAaPNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:13:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643642032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNY27SrxhFfcwywq83/THIY3BfDtPTJRz689v8YiT4I=;
        b=MT/UVdjkczb3b2kfvH+QP3lMN2Rsygg7x5FSejNtSiLXUddWO0gtbJvOmHMWPXxx6pOUFW
        OodCC2AJPcElsLwldL9GLrP+mv3GbU3IEjvOa1dSg44gQ9PEbVrpyvKg+1+edUIkf80TZ0
        kSZ4TGzMH7IFRvr8JwIPaW9GJFhiMV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-t4OMMK1zNEC5MGQtsuW1Xw-1; Mon, 31 Jan 2022 10:13:48 -0500
X-MC-Unique: t4OMMK1zNEC5MGQtsuW1Xw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B50351006AA7;
        Mon, 31 Jan 2022 15:13:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8F97970F60;
        Mon, 31 Jan 2022 15:13:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/5] vfs: Add tracepoints for inode_excl_inuse_trylock/unlock
From:   David Howells <dhowells@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        torvalds@linux-foundation.org, linux-unionfs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 31 Jan 2022 15:13:43 +0000
Message-ID: <164364202369.1476539.452557132083658522.stgit@warthog.procyon.org.uk>
In-Reply-To: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
References: <164364196407.1476539.8450117784231043601.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tracepoints for inode_excl_inuse_trylock/unlock() to record successful
and lock, failed lock, successful unlock and unlock when it wasn't locked.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Amir Goldstein <amir73il@gmail.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-unionfs@vger.kernel.org
cc: linux-cachefs@redhat.com
---

 fs/inode.c           |   21 +++++++++++++++++----
 fs/overlayfs/super.c |   10 ++++++----
 include/linux/fs.h   |    9 +++++++--
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 954719f66113..61b93a89853f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -22,6 +22,8 @@
 #include <linux/iversion.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
+#define CREATE_TRACE_POINTS
+#include <trace/events/vfs.h>
 
 /*
  * Inode locking rules:
@@ -2409,11 +2411,14 @@ EXPORT_SYMBOL(current_time);
 /**
  * inode_excl_inuse_trylock - Try to exclusively lock an inode for kernel access
  * @dentry: Reference to the inode to be locked
+ * @o: Private reference for the kernel service
+ * @who: Which kernel service is trying to gain the lock
  *
  * Try to gain exclusive access to an inode for a kernel service, returning
  * true if successful.
  */
-bool inode_excl_inuse_trylock(struct dentry *dentry)
+bool inode_excl_inuse_trylock(struct dentry *dentry, unsigned int o,
+			      enum inode_excl_inuse_by who)
 {
 	struct inode *inode = d_inode(dentry);
 	bool locked = false;
@@ -2421,7 +2426,10 @@ bool inode_excl_inuse_trylock(struct dentry *dentry)
 	spin_lock(&inode->i_lock);
 	if (!(inode->i_state & I_EXCL_INUSE)) {
 		inode->i_state |= I_EXCL_INUSE;
+		trace_inode_excl_inuse_lock(inode, o, who);
 		locked = true;
+	} else {
+		trace_inode_excl_inuse_lock_failed(inode, o, who);
 	}
 	spin_unlock(&inode->i_lock);
 
@@ -2432,18 +2440,23 @@ EXPORT_SYMBOL(inode_excl_inuse_trylock);
 /**
  * inode_excl_inuse_unlock - Unlock exclusive kernel access to an inode
  * @dentry: Reference to the inode to be unlocked
+ * @o: Private reference for the kernel service
  *
  * Drop exclusive access to an inode for a kernel service.  A warning is given
  * if the inode was not marked for exclusive access.
  */
-void inode_excl_inuse_unlock(struct dentry *dentry)
+void inode_excl_inuse_unlock(struct dentry *dentry, unsigned int o)
 {
 	if (dentry) {
 		struct inode *inode = d_inode(dentry);
 
 		spin_lock(&inode->i_lock);
-		WARN_ON(!(inode->i_state & I_EXCL_INUSE));
-		inode->i_state &= ~I_EXCL_INUSE;
+		if (WARN_ON(!(inode->i_state & I_EXCL_INUSE))) {
+			trace_inode_excl_inuse_unlock_bad(inode, o);
+		} else {
+			inode->i_state &= ~I_EXCL_INUSE;
+			trace_inode_excl_inuse_unlock(inode, o);
+		}
 		spin_unlock(&inode->i_lock);
 	}
 }
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 5c3361a2dc7c..6434ae11496d 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -224,10 +224,10 @@ static void ovl_free_fs(struct ovl_fs *ofs)
 	dput(ofs->indexdir);
 	dput(ofs->workdir);
 	if (ofs->workdir_locked)
-		inode_excl_inuse_unlock(ofs->workbasedir);
+		inode_excl_inuse_unlock(ofs->workbasedir, 0);
 	dput(ofs->workbasedir);
 	if (ofs->upperdir_locked)
-		inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root);
+		inode_excl_inuse_unlock(ovl_upper_mnt(ofs)->mnt_root, 0);
 
 	/* Hack!  Reuse ofs->layers as a vfsmount array before freeing it */
 	mounts = (struct vfsmount **) ofs->layers;
@@ -1239,7 +1239,8 @@ static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
 	if (upper_mnt->mnt_sb->s_flags & SB_NOSEC)
 		sb->s_flags |= SB_NOSEC;
 
-	if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root)) {
+	if (inode_excl_inuse_trylock(ovl_upper_mnt(ofs)->mnt_root, 0,
+				     inode_excl_inuse_by_overlayfs)) {
 		ofs->upperdir_locked = true;
 	} else {
 		err = ovl_report_in_use(ofs, "upperdir");
@@ -1499,7 +1500,8 @@ static int ovl_get_workdir(struct super_block *sb, struct ovl_fs *ofs,
 
 	ofs->workbasedir = dget(workpath.dentry);
 
-	if (inode_excl_inuse_trylock(ofs->workbasedir)) {
+	if (inode_excl_inuse_trylock(ofs->workbasedir, 0,
+				     inode_excl_inuse_by_overlayfs)) {
 		ofs->workdir_locked = true;
 	} else {
 		err = ovl_report_in_use(ofs, "workdir");
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 4c15e270f1ac..f461883d66a8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2389,8 +2389,13 @@ static inline bool inode_is_dirtytime_only(struct inode *inode)
 				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
 }
 
-bool inode_excl_inuse_trylock(struct dentry *dentry);
-void inode_excl_inuse_unlock(struct dentry *dentry);
+enum inode_excl_inuse_by {
+	inode_excl_inuse_by_overlayfs,
+};
+
+bool inode_excl_inuse_trylock(struct dentry *dentry, unsigned int o,
+			      enum inode_excl_inuse_by who);
+void inode_excl_inuse_unlock(struct dentry *dentry, unsigned int o);
 
 static inline bool inode_is_excl_inuse(struct dentry *dentry)
 {


