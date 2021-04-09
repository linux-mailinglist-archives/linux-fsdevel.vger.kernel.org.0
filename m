Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2135913F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbhDIBPt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Thu, 8 Apr 2021 21:15:49 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60247 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233215AbhDIBPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:15:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-GmeKLG3_MCeGLw1eRwbRXA-1; Thu, 08 Apr 2021 21:15:32 -0400
X-MC-Unique: GmeKLG3_MCeGLw1eRwbRXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E981005582;
        Fri,  9 Apr 2021 01:15:30 +0000 (UTC)
Received: from mickey.themaw.net (ovpn-116-30.sin2.redhat.com [10.67.116.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9099196E3;
        Fri,  9 Apr 2021 01:15:27 +0000 (UTC)
Subject: [PATCH v3 4/4] kernfs: use i_lock to protect concurrent inode updates
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Brice Goglin <brice.goglin@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Eric Sandeen <sandeen@sandeen.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Fri, 09 Apr 2021 09:15:26 +0800
Message-ID: <161793092633.10062.10058776986521908089.stgit@mickey.themaw.net>
In-Reply-To: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
References: <161793058309.10062.17056551235139961080.stgit@mickey.themaw.net>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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


