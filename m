Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0BE528264
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbfEWQP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:15:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731073AbfEWQP6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:15:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BEAC73001749;
        Thu, 23 May 2019 16:15:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F31668365;
        Thu, 23 May 2019 16:15:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 01/23] saner calling conventions for nfs_fs_mount_common()
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:15:50 +0100
Message-ID: <155862815043.26654.10359128329402412912.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Thu, 23 May 2019 16:15:58 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Allow it to take ERR_PTR() for server and return ERR_CAST() of it in
such case.  All callers used to open-code that...

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/nfs4super.c |   16 +---------------
 fs/nfs/super.c     |   11 ++++-------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 689977e148cb..a392e9454287 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -109,21 +109,12 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 {
 	struct nfs_mount_info *mount_info = info;
 	struct nfs_server *server;
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
 
 	mount_info->set_security = nfs_set_sb_security;
 
 	/* Get a volume representation */
 	server = nfs4_create_server(mount_info, &nfs_v4);
-	if (IS_ERR(server)) {
-		mntroot = ERR_CAST(server);
-		goto out;
-	}
-
-	mntroot = nfs_fs_mount_common(server, flags, dev_name, mount_info, &nfs_v4);
-
-out:
-	return mntroot;
+	return nfs_fs_mount_common(server, flags, dev_name, mount_info, &nfs_v4);
 }
 
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
@@ -279,11 +270,6 @@ nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 
 	/* create a new volume representation */
 	server = nfs4_create_referral_server(mount_info.cloned, mount_info.mntfh);
-	if (IS_ERR(server)) {
-		mntroot = ERR_CAST(server);
-		goto out;
-	}
-
 	mntroot = nfs_fs_mount_common(server, flags, dev_name, &mount_info, &nfs_v4);
 out:
 	nfs_free_fhandle(mount_info.mntfh);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d6c687419a81..e4108e20af0f 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1881,9 +1881,6 @@ struct dentry *nfs_try_mount(int flags, const char *dev_name,
 	else
 		server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 
-	if (IS_ERR(server))
-		return ERR_CAST(server);
-
 	return nfs_fs_mount_common(server, flags, dev_name, mount_info, nfs_mod);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
@@ -2618,6 +2615,9 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 	};
 	int error;
 
+	if (IS_ERR(server))
+		return ERR_CAST(server);
+
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
 
@@ -2766,10 +2766,7 @@ nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 	/* create a new volume representation */
 	server = nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, data->fattr, data->authflavor);
 
-	if (IS_ERR(server))
-		mntroot = ERR_CAST(server);
-	else
-		mntroot = nfs_fs_mount_common(server, flags,
+	mntroot = nfs_fs_mount_common(server, flags,
 				dev_name, &mount_info, nfs_mod);
 
 	dprintk("<-- nfs_xdev_mount() = %ld\n",

