Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14CD928282
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfEWQRF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:17:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24858 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730899AbfEWQRF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:17:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DCCA181111;
        Thu, 23 May 2019 16:17:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7415F17CFB;
        Thu, 23 May 2019 16:17:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 08/23] nfs: stash nfs_subversion reference into
 nfs_mount_info
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:17:02 +0100
Message-ID: <155862822265.26654.2410384551874971260.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 16:17:04 +0000 (UTC)
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

 fs/nfs/internal.h  |    1 +
 fs/nfs/namespace.c |    6 +++---
 fs/nfs/nfs4super.c |    1 +
 fs/nfs/super.c     |    1 +
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 496a0e03f2b2..62af450bb91a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -149,6 +149,7 @@ struct nfs_mount_info {
 	struct nfs_clone_mount *cloned;
 	struct nfs_server *server;
 	struct nfs_fh *mntfh;
+	struct nfs_subversion *nfs_mod;
 };
 
 extern int nfs_mount(struct nfs_mount_request *info);
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index 9622575682da..476f4c0d5542 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -232,8 +232,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 		.set_security = nfs_clone_sb_security,
 		.cloned = &mountdata,
 		.mntfh = fh,
+		.nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod,
 	};
-	struct nfs_subversion *nfs_mod = NFS_SB(sb)->nfs_client->cl_nfs_mod;
 	struct nfs_server *server;
 	struct vfsmount *mnt;
 	char *page = (char *) __get_free_page(GFP_USER);
@@ -242,8 +242,8 @@ struct vfsmount *nfs_do_submount(struct dentry *dentry, struct nfs_fh *fh,
 	if (page == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	server = nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
-						fattr, authflavor);
+	server = mount_info.nfs_mod->rpc_ops->clone_server(NFS_SB(sb), fh,
+							   fattr, authflavor);
 	if (IS_ERR(server))
 		return ERR_CAST(server);
 
diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 1710df8240fb..25253c235fba 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -247,6 +247,7 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 		.fill_super = nfs_fill_super,
 		.set_security = nfs_clone_sb_security,
 		.cloned = data,
+		.nfs_mod = &nfs_v4,
 	};
 	struct dentry *res;
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index f0a8f1da394b..c76b4fe73fab 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2713,6 +2713,7 @@ struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 		mntroot = ERR_CAST(nfs_mod);
 		goto out;
 	}
+	mount_info.nfs_mod = nfs_mod;
 
 	mntroot = nfs_mod->rpc_ops->try_mount(flags, dev_name, &mount_info, nfs_mod);
 

