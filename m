Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A70B28273
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfEWQQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:16:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730918AbfEWQQW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:16:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A390821F3;
        Thu, 23 May 2019 16:16:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37648600C1;
        Thu, 23 May 2019 16:16:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 03/23] nfs: lift setting mount_info from nfs4_remote{,
 _referral}_mount
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:16:17 +0100
Message-ID: <155862817738.26654.16583027208956953428.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 16:16:22 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Do that (fhandle allocation, setting struct server up) in
nfs4_referral_mount() and nfs4_try_mount() resp. and pass the
server and pointer to mount_info into nfs_do_root_mount() so that
nfs4_remote_referral_mount()/nfs_remote_mount() could be merged.

Since we are moving stuff from ->mount() instances to the points
prior to vfs_kern_mount() that would trigger those, we need to
make sure that do_nfs_root_mount() will do the corresponding
cleanup itself if it doesn't trigger those ->mount() instances.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/nfs4super.c |   67 +++++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index a962042972fa..71a970ca3fb7 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -107,32 +107,37 @@ static struct dentry *
 nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 		  const char *dev_name, void *info)
 {
-	struct nfs_mount_info *mount_info = info;
-
-	mount_info->set_security = nfs_set_sb_security;
-
-	/* Get a volume representation */
-	mount_info->server = nfs4_create_server(mount_info, &nfs_v4);
-	return nfs_fs_mount_common(flags, dev_name, mount_info, &nfs_v4);
+	return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
 
 static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
-		int flags, void *data, const char *hostname)
+					  struct nfs_server *server, int flags,
+					  struct nfs_mount_info *info,
+					  const char *hostname)
 {
 	struct vfsmount *root_mnt;
 	char *root_devname;
 	size_t len;
 
+	if (IS_ERR(server))
+		return ERR_CAST(server);
+
 	len = strlen(hostname) + 5;
 	root_devname = kmalloc(len, GFP_KERNEL);
-	if (root_devname == NULL)
+	if (root_devname == NULL) {
+		nfs_free_server(server);
 		return ERR_PTR(-ENOMEM);
+	}
 	/* Does hostname needs to be enclosed in brackets? */
 	if (strchr(hostname, ':'))
 		snprintf(root_devname, len, "[%s]:/", hostname);
 	else
 		snprintf(root_devname, len, "%s:/", hostname);
-	root_mnt = vfs_kern_mount(fs_type, flags, root_devname, data);
+	info->server = server;
+	root_mnt = vfs_kern_mount(fs_type, flags, root_devname, info);
+	if (info->server)
+		nfs_free_server(info->server);
+	info->server = NULL;
 	kfree(root_devname);
 	return root_mnt;
 }
@@ -233,11 +238,15 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 	struct dentry *res;
 	struct nfs_parsed_mount_data *data = mount_info->parsed;
 
+	mount_info->set_security = nfs_set_sb_security;
+
 	dfprintk(MOUNT, "--> nfs4_try_mount()\n");
 
 	export_path = data->nfs_server.export_path;
 	data->nfs_server.export_path = "/";
-	root_mnt = nfs_do_root_mount(&nfs4_remote_fs_type, flags, mount_info,
+	root_mnt = nfs_do_root_mount(&nfs4_remote_fs_type,
+			nfs4_create_server(mount_info, &nfs_v4),
+			flags, mount_info,
 			data->nfs_server.hostname);
 	data->nfs_server.export_path = export_path;
 
@@ -253,25 +262,7 @@ static struct dentry *
 nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
 			   const char *dev_name, void *raw_data)
 {
-	struct nfs_mount_info mount_info = {
-		.fill_super = nfs_fill_super,
-		.set_security = nfs_clone_sb_security,
-		.cloned = raw_data,
-	};
-	struct dentry *mntroot = ERR_PTR(-ENOMEM);
-
-	dprintk("--> nfs4_referral_get_sb()\n");
-
-	mount_info.mntfh = nfs_alloc_fhandle();
-	if (mount_info.cloned == NULL || mount_info.mntfh == NULL)
-		goto out;
-
-	/* create a new volume representation */
-	mount_info.server = nfs4_create_referral_server(mount_info.cloned, mount_info.mntfh);
-	mntroot = nfs_fs_mount_common(flags, dev_name, &mount_info, &nfs_v4);
-out:
-	nfs_free_fhandle(mount_info.mntfh);
-	return mntroot;
+	return nfs_fs_mount_common(flags, dev_name, raw_data, &nfs_v4);
 }
 
 /*
@@ -281,23 +272,35 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 		int flags, const char *dev_name, void *raw_data)
 {
 	struct nfs_clone_mount *data = raw_data;
+	struct nfs_mount_info mount_info = {
+		.fill_super = nfs_fill_super,
+		.set_security = nfs_clone_sb_security,
+		.cloned = data,
+	};
 	char *export_path;
 	struct vfsmount *root_mnt;
 	struct dentry *res;
 
 	dprintk("--> nfs4_referral_mount()\n");
 
+	mount_info.mntfh = nfs_alloc_fhandle();
+	if (!mount_info.mntfh)
+		return ERR_PTR(-ENOMEM);
+
 	export_path = data->mnt_path;
 	data->mnt_path = "/";
-
 	root_mnt = nfs_do_root_mount(&nfs4_remote_referral_fs_type,
-			flags, data, data->hostname);
+			nfs4_create_referral_server(mount_info.cloned,
+						    mount_info.mntfh),
+			flags, &mount_info, data->hostname);
 	data->mnt_path = export_path;
 
 	res = nfs_follow_remote_path(root_mnt, export_path);
 	dprintk("<-- nfs4_referral_mount() = %d%s\n",
 		PTR_ERR_OR_ZERO(res),
 		IS_ERR(res) ? " [error]" : "");
+
+	nfs_free_fhandle(mount_info.mntfh);
 	return res;
 }
 

