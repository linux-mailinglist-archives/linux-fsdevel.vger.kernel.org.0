Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2817B2E06F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 08:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbgLVHuL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 02:50:11 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:46286 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgLVHuL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 02:50:11 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-ltgZ50APOYGdCz0bgvCKZA-1; Tue, 22 Dec 2020 02:48:49 -0500
X-MC-Unique: ltgZ50APOYGdCz0bgvCKZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1418A15727;
        Tue, 22 Dec 2020 07:48:48 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-49.sin2.redhat.com [10.67.116.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B12B1B466;
        Tue, 22 Dec 2020 07:48:41 +0000 (UTC)
Subject: [PATCH 6/6] kernfs: add a spinlock to kernfs iattrs for inode updates
From:   Ian Kent <raven@themaw.net>
To:     Fox Chen <foxhlchen@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Tue, 22 Dec 2020 15:48:39 +0800
Message-ID: <160862331927.291330.16497188823501358991.stgit@mickey.themaw.net>
In-Reply-To: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
References: <160862320263.291330.9467216031366035418.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=raven@themaw.net
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: themaw.net
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode operations .permission() and .getattr() use the kernfs node
write lock but all that's needed is to keep the rb tree stable while
updating the inode attributes as well as protecting the update itself
against concurrent changes.

And .permission() is called frequently during path walks and can cause
quite a bit of contention between kernfs node opertations and path
walks when the number of concurrant walks is high.

To change kernfs_iop_getattr() and kernfs_iop_permission() to take
the rw sem read lock instead of the write lock an addtional lock is
needed to protect against multiple processes concurrently updating
the inode attributes and link count in kernfs_refresh_inode().

So add a spin lock to the kernfs_iattrs structure to protect these
inode attributes updates and use it in kernfs_refresh_inode().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c           |   11 +++++++----
 fs/kernfs/kernfs-internal.h |    1 +
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index ddaf18198935..f583dde70174 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -55,6 +55,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 	simple_xattrs_init(&kn->iattr->xattrs);
 	atomic_set(&kn->iattr->nr_user_xattrs, 0);
 	atomic_set(&kn->iattr->user_xattr_size, 0);
+	spin_lock_init(&kn->iattr->inode_lock);
 out_unlock:
 	ret = kn->iattr;
 	mutex_unlock(&iattr_mutex);
@@ -171,6 +172,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
 
+	spin_lock(&attrs->inode_lock);
 	inode->i_mode = kn->mode;
 	if (attrs)
 		/*
@@ -181,6 +183,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		set_nlink(inode, kn->dir.subdirs + 2);
+	spin_unlock(&attrs->inode_lock);
 }
 
 int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
@@ -189,9 +192,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +284,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 
 	return generic_permission(inode, mask);
 }
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index a7b0e2074260..184e4424b389 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -29,6 +29,7 @@ struct kernfs_iattrs {
 	struct simple_xattrs	xattrs;
 	atomic_t		nr_user_xattrs;
 	atomic_t		user_xattr_size;
+	spinlock_t		inode_lock;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */


