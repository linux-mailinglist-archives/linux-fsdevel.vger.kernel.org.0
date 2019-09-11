Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26526B014F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 18:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfIKQRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 12:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47270 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbfIKQQX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 12:16:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2EE8CC057EC0;
        Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 016EF19C70;
        Wed, 11 Sep 2019 16:16:22 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id 1BD7420B53; Wed, 11 Sep 2019 12:16:22 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/26] nfs4: fold nfs_do_root_mount/nfs_follow_remote_path
Date:   Wed, 11 Sep 2019 12:16:01 -0400
Message-Id: <20190911161621.19832-7-smayhew@redhat.com>
In-Reply-To: <20190911161621.19832-1-smayhew@redhat.com>
References: <20190911161621.19832-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 11 Sep 2019 16:16:23 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/nfs4super.c | 88 +++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 51 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index a0b66f98f6ba..91ba1b6741dc 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -101,37 +101,6 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 	return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
 
-static struct vfsmount *nfs_do_root_mount(struct nfs_server *server, int flags,
-					  struct nfs_mount_info *info,
-					  const char *hostname)
-{
-	struct vfsmount *root_mnt;
-	char *root_devname;
-	size_t len;
-
-	if (IS_ERR(server))
-		return ERR_CAST(server);
-
-	len = strlen(hostname) + 5;
-	root_devname = kmalloc(len, GFP_KERNEL);
-	if (root_devname == NULL) {
-		nfs_free_server(server);
-		return ERR_PTR(-ENOMEM);
-	}
-	/* Does hostname needs to be enclosed in brackets? */
-	if (strchr(hostname, ':'))
-		snprintf(root_devname, len, "[%s]:/", hostname);
-	else
-		snprintf(root_devname, len, "%s:/", hostname);
-	info->server = server;
-	root_mnt = vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, info);
-	if (info->server)
-		nfs_free_server(info->server);
-	info->server = NULL;
-	kfree(root_devname);
-	return root_mnt;
-}
-
 struct nfs_referral_count {
 	struct list_head list;
 	const struct task_struct *task;
@@ -198,11 +167,38 @@ static void nfs_referral_loop_unprotect(void)
 	kfree(p);
 }
 
-static struct dentry *nfs_follow_remote_path(struct vfsmount *root_mnt,
-		const char *export_path)
+static struct dentry *do_nfs4_mount(struct nfs_server *server, int flags,
+				    struct nfs_mount_info *info,
+				    const char *hostname,
+				    const char *export_path)
 {
+	struct vfsmount *root_mnt;
 	struct dentry *dentry;
+	char *root_devname;
 	int err;
+	size_t len;
+
+	if (IS_ERR(server))
+		return ERR_CAST(server);
+
+	len = strlen(hostname) + 5;
+	root_devname = kmalloc(len, GFP_KERNEL);
+	if (root_devname == NULL) {
+		nfs_free_server(server);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* Does hostname needs to be enclosed in brackets? */
+	if (strchr(hostname, ':'))
+		snprintf(root_devname, len, "[%s]:/", hostname);
+	else
+		snprintf(root_devname, len, "%s:/", hostname);
+	info->server = server;
+	root_mnt = vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, info);
+	if (info->server)
+		nfs_free_server(info->server);
+	info->server = NULL;
+	kfree(root_devname);
 
 	if (IS_ERR(root_mnt))
 		return ERR_CAST(root_mnt);
@@ -223,22 +219,17 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 			      struct nfs_mount_info *mount_info,
 			      struct nfs_subversion *nfs_mod)
 {
-	char *export_path;
-	struct vfsmount *root_mnt;
-	struct dentry *res;
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
+	struct dentry *res;
 
 	mount_info->set_security = nfs_set_sb_security;
 
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
-	export_path = data->nfs_server.export_path;
-	root_mnt = nfs_do_root_mount(
-			nfs4_create_server(mount_info, &nfs_v4),
-			flags, mount_info,
-			data->nfs_server.hostname);
-
-	res = nfs_follow_remote_path(root_mnt, export_path);
+	res = do_nfs4_mount(nfs4_create_server(mount_info, &nfs_v4),
+			    flags, mount_info,
+			    data->nfs_server.hostname,
+			    data->nfs_server.export_path);
 
 	dfprintk(MOUNT, "<-- nfs4_try_mount() = %d%s\n",
 		 PTR_ERR_OR_ZERO(res),
@@ -258,8 +249,6 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 		.set_security = nfs_clone_sb_security,
 		.cloned = data,
 	};
-	char *export_path;
-	struct vfsmount *root_mnt;
 	struct dentry *res;
 
 	dprintk("--> nfs4_referral_mount()\n");
@@ -268,13 +257,10 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 	if (!mount_info.mntfh)
 		return ERR_PTR(-ENOMEM);
 
-	export_path = data->mnt_path;
-	root_mnt = nfs_do_root_mount(
-			nfs4_create_referral_server(mount_info.cloned,
-						    mount_info.mntfh),
-			flags, &mount_info, data->hostname);
+	res = do_nfs4_mount(nfs4_create_referral_server(mount_info.cloned,
+							mount_info.mntfh),
+			    flags, &mount_info, data->hostname, data->mnt_path);
 
-	res = nfs_follow_remote_path(root_mnt, export_path);
 	dprintk("<-- nfs4_referral_mount() = %d%s\n",
 		PTR_ERR_OR_ZERO(res),
 		IS_ERR(res) ? " [error]" : "");
-- 
2.17.2

