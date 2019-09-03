Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5FCBA74CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 22:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfICUcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 16:32:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43240 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbfICUcR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 16:32:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EE388980E4;
        Tue,  3 Sep 2019 20:32:16 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-121-35.rdu2.redhat.com [10.10.121.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCABB5D6B2;
        Tue,  3 Sep 2019 20:32:15 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 6161D203E6; Tue,  3 Sep 2019 16:32:15 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/26] saner calling conventions for nfs_fs_mount_common()
Date:   Tue,  3 Sep 2019 16:31:50 -0400
Message-Id: <20190903203215.9157-2-smayhew@redhat.com>
In-Reply-To: <20190903203215.9157-1-smayhew@redhat.com>
References: <20190903203215.9157-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 03 Sep 2019 20:32:16 +0000 (UTC)
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
 fs/nfs/nfs4super.c | 16 +---------------
 fs/nfs/super.c     | 11 ++++-------
 2 files changed, 5 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 04c57066a11a..baece9857bcf 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -110,21 +110,12 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
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
@@ -280,11 +271,6 @@ nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 
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
index 703f595dce90..467d7a636f0b 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1903,9 +1903,6 @@ struct dentry *nfs_try_mount(int flags, const char *dev_name,
 	else
 		server = nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 
-	if (IS_ERR(server))
-		return ERR_CAST(server);
-
 	return nfs_fs_mount_common(server, flags, dev_name, mount_info, nfs_mod);
 }
 EXPORT_SYMBOL_GPL(nfs_try_mount);
@@ -2641,6 +2638,9 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 	};
 	int error;
 
+	if (IS_ERR(server))
+		return ERR_CAST(server);
+
 	if (server->flags & NFS_MOUNT_UNSHARED)
 		compare_super = NULL;
 
@@ -2789,10 +2789,7 @@ nfs_xdev_mount(struct file_system_type *fs_type, int flags,
 	/* create a new volume representation */
 	server = nfs_mod->rpc_ops->clone_server(NFS_SB(data->sb), data->fh, data->fattr, data->authflavor);
 
-	if (IS_ERR(server))
-		mntroot = ERR_CAST(server);
-	else
-		mntroot = nfs_fs_mount_common(server, flags,
+	mntroot = nfs_fs_mount_common(server, flags,
 				dev_name, &mount_info, nfs_mod);
 
 	dprintk("<-- nfs_xdev_mount() = %ld\n",
-- 
2.17.2

