Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB54393D2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 08:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhE1GgP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 02:36:15 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:47267 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234070AbhE1GgK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 02:36:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-IjXKAfTwPtuLZXkY2JvE8g-1; Fri, 28 May 2021 02:34:32 -0400
X-MC-Unique: IjXKAfTwPtuLZXkY2JvE8g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 245FDFC99;
        Fri, 28 May 2021 06:34:31 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-22.sin2.redhat.com [10.67.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18215C290;
        Fri, 28 May 2021 06:34:27 +0000 (UTC)
Subject: [REPOST PATCH v4 4/5] kernfs: use i_lock to protect concurrent inode
 updates
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Eric Sandeen <sandeen@sandeen.net>, Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 28 May 2021 14:34:26 +0800
Message-ID: <162218366632.34379.11311748209082333016.stgit@web.messagingengine.com>
In-Reply-To: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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
quite a bit of contention between kernfs node operations and path
walks when the number of concurrent walks is high.

To change kernfs_iop_getattr() and kernfs_iop_permission() to take
the rw sem read lock instead of the write lock an additional lock is
needed to protect against multiple processes concurrently updating
the inode attributes and link count in kernfs_refresh_inode().

The inode i_lock seems like the sensible thing to use to protect these
inode attribute updates so use it in kernfs_refresh_inode().

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c |   10 ++++++----
 fs/kernfs/mount.c |    4 ++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3b01e9e61f14e..6728ecd81eb37 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -172,6 +172,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	struct kernfs_iattrs *attrs = kn->iattr;
 
+	spin_lock(&inode->i_lock);
 	inode->i_mode = kn->mode;
 	if (attrs)
 		/*
@@ -182,6 +183,7 @@ static void kernfs_refresh_inode(struct kernfs_node *kn, struct inode *inode)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		set_nlink(inode, kn->dir.subdirs + 2);
+	spin_unlock(&inode->i_lock);
 }
 
 int kernfs_iop_getattr(struct user_namespace *mnt_userns,
@@ -191,9 +193,9 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	return 0;
@@ -284,9 +286,9 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 
 	return generic_permission(&init_user_ns, inode, mask);
 }
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index baa4155ba2edf..f2f909d09f522 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -255,9 +255,9 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	sb->s_shrink.seeks = 0;
 
 	/* get root inode, initialize and unlock it */
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
 	inode = kernfs_get_inode(sb, info->root->kn);
-	up_write(&kernfs_rwsem);
+	up_read(&kernfs_rwsem);
 	if (!inode) {
 		pr_debug("kernfs: could not get root inode\n");
 		return -ENOMEM;


