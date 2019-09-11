Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8869B0161
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfIKQSD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:18:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728974AbfIKQQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 24EE087630;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 03B591001B01;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 288C320BF9; Wed, 11 Sep 2019 12:16:22 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/26] nfs: stash nfs_subversion reference into nfs_mount_info
Date:   Wed, 11 Sep 2019 12:16:03 -0400
Message-Id: <20190911161621.19832-9-smayhew@redhat.com>
In-Reply-To: <20190911161621.19832-1-smayhew@redhat.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

That will allow to get rid of passing those references around in
quite a few places.  Moreover, that will allow to merge xdev and
remote file_system_type.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h  | 1 +
 fs/nfs/namespace.c | 6 +++---
 fs/nfs/nfs4super.c | 1 +
 fs/nfs/super.c     | 1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index eeb54b45875c..0c42cf685d4b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -150,6 +150,7 @@ struct nfs_mount_info {
 	struct nfs_clone_mount *cloned;
 	struct nfs_server *server;
 	struct nfs_fh *mntfh;
+	struct nfs_subversion *nfs_mod;
 };
 
 extern int nfs_mount(struct nfs_mount_request *info);
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 7c78e6956639..0d0587ed7d94 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -233,8 +233,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 		.set_security = nfs_clone_sb_security,
 		.cloned = &mountdata,
 		.mntfh = fh,
+		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
 	};
-	struct nfs_subversion *nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod;
 	struct nfs_server *server;
 	struct vfsmount *mnt;
 	char *page = (char *) __get_free_page(GFP_USER);
@@ -243,8 +243,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	if (page == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	server = nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-						fattr, authflavor);
+	server = mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
+							   fattr, authflavor);
 	if (IS_ERR(server))
 		return ERR_CAST(server);
 
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 91ba1b6741dc..88d83cab8e9b 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -248,6 +248,7 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 		.fill_super = nfs_fill_super,
 		.set_security = nfs_clone_sb_security,
 		.cloned = data,
+		.nfs_mod = &nfs_v4,
 	};
 	struct dentry *res;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 7fc354207347..2a6b4e4b0a2d 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2736,6 +2736,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 		mntroot = ERR_CAST(nfs_mod);
 		goto out;
 	}
+	mount_info.nfs_mod = nfs_mod;
 
 	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, nfs_mod);
 
-- 
2.17.2

