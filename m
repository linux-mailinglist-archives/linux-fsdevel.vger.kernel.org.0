Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF23A7BCE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFOK3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 06:29:12 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:50397 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231502AbhFOK3J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:29:09 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-Gbio79eZMvWDgwUpOqPafQ-1; Tue, 15 Jun 2021 06:27:01 -0400
X-MC-Unique: Gbio79eZMvWDgwUpOqPafQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77575801B19;
        Tue, 15 Jun 2021 10:26:59 +0000 (UTC)
Received: from web.messagingengine.com (ovpn-116-40.sin2.redhat.com [10.67.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B4E42620DE;
        Tue, 15 Jun 2021 10:26:52 +0000 (UTC)
Subject: [PATCH v7 5/6] kernfs: use i_lock to protect concurrent inode updates
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
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 15 Jun 2021 18:26:51 +0800
Message-ID: <162375281122.232295.10249364226595161380.stgit@web.messagingengine.com>
In-Reply-To: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
References: <162375263398.232295.14755578426619198534.stgit@web.messagingengine.com>
User-Agent: StGit/0.23
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
write lock but all that's needed is the read lock to protect against
partial updates of these kernfs node fields which are all done under
the write lock.

And .permission() is called frequently during path walks and can cause
quite a bit of contention between kernfs node operations and path
walks when the number of concurrent walks is high.

To change kernfs_iop_getattr() and kernfs_iop_permission() to take
the rw sem read lock instead of the write lock an additional lock is
needed to protect against multiple processes concurrently updating
the inode attributes and link count in kernfs_refresh_inode().

The inode i_lock seems like the sensible thing to use to protect these
inode attribute updates so use it in kernfs_refresh_inode().

The last hunk in the patch, applied to kernfs_fill_super(), is possibly
not needed but taking the lock was present originally. I prefer to
continue to take it to protect against a partial update of the source
kernfs fields during the call to kernfs_refresh_inode() made by
kernfs_get_inode().

Signed-off-by: Ian Kent <raven@themaw.net>
Reviewed-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/inode.c |   18 ++++++++++++------
 fs/kernfs/mount.c |    4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3b01e9e61f14e..6592938511909 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -191,11 +191,13 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
-
 	generic_fillattr(&init_user_ns, inode, stat);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
+
 	return 0;
 }
 
@@ -278,17 +280,21 @@ int kernfs_iop_permission(struct user_namespace *mnt_userns,
 			  struct inode *inode, int mask)
 {
 	struct kernfs_node *kn;
+	int ret;
 
 	if (mask & MAY_NOT_BLOCK)
 		return -ECHILD;
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	spin_lock(&inode->i_lock);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	ret = generic_permission(&init_user_ns, inode, mask);
+	spin_unlock(&inode->i_lock);
+	up_read(&kernfs_rwsem);
 
-	return generic_permission(&init_user_ns, inode, mask);
+	return ret;
 }
 
 int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
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


