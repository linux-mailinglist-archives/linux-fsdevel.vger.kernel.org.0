Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A867E28276
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfEWQQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 12:16:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730918AbfEWQQ3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 12:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97526821D1;
        Thu, 23 May 2019 16:16:29 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-142.rdu2.redhat.com [10.10.121.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1ECD81001F5B;
        Thu, 23 May 2019 16:16:27 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 04/23] nfs: fold nfs4_remote_fs_type and
 nfs4_remote_referral_fs_type
From:   David Howells <dhowells@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 23 May 2019 17:16:27 +0100
Message-ID: <155862818734.26654.3150141109818847701.stgit@warthog.procyon.org.uk>
In-Reply-To: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
References: <155862813755.26654.563679411147031501.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 16:16:29 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

They are identical now.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/nfs/nfs4super.c |   26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index 71a970ca3fb7..5d02925e3567 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -21,8 +21,6 @@ static struct dentry *nfs4_remote_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data);
 static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data);
-static struct dentry *nfs4_remote_referral_mount(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *raw_data);
 
 static struct file_system_type nfs4_remote_fs_type = {
 	.owner		= THIS_MODULE,
@@ -32,14 +30,6 @@ static struct file_system_type nfs4_remote_fs_type = {
 	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
 };
 
-static struct file_system_type nfs4_remote_referral_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "nfs4",
-	.mount		= nfs4_remote_referral_mount,
-	.kill_sb	= nfs_kill_super,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE|FS_BINARY_MOUNTDATA,
-};
-
 struct file_system_type nfs4_referral_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "nfs4",
@@ -110,8 +100,7 @@ nfs4_remote_mount(struct file_system_type *fs_type, int flags,
 	return nfs_fs_mount_common(flags, dev_name, info, &nfs_v4);
 }
 
-static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
-					  struct nfs_server *server, int flags,
+static struct vfsmount *nfs_do_root_mount(struct nfs_server *server, int flags,
 					  struct nfs_mount_info *info,
 					  const char *hostname)
 {
@@ -134,7 +123,7 @@ static struct vfsmount *nfs_do_root_mount(struct file_system_type *fs_type,
 	else
 		snprintf(root_devname, len, "%s:/", hostname);
 	info->server = server;
-	root_mnt = vfs_kern_mount(fs_type, flags, root_devname, info);
+	root_mnt = vfs_kern_mount(&nfs4_remote_fs_type, flags, root_devname, info);
 	if (info->server)
 		nfs_free_server(info->server);
 	info->server = NULL;
@@ -244,7 +233,7 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 
 	export_path = data->nfs_server.export_path;
 	data->nfs_server.export_path = "/";
-	root_mnt = nfs_do_root_mount(&nfs4_remote_fs_type,
+	root_mnt = nfs_do_root_mount(
 			nfs4_create_server(mount_info, &nfs_v4),
 			flags, mount_info,
 			data->nfs_server.hostname);
@@ -258,13 +247,6 @@ struct dentry *nfs4_try_mount(int flags, const char *dev_name,
 	return res;
 }
 
-static struct dentry *
-nfs4_remote_referral_mount(struct file_system_type *fs_type, int flags,
-			   const char *dev_name, void *raw_data)
-{
-	return nfs_fs_mount_common(flags, dev_name, raw_data, &nfs_v4);
-}
-
 /*
  * Create an NFS4 server record on referral traversal
  */
@@ -289,7 +271,7 @@ static struct dentry *nfs4_referral_mount(struct file_system_type *fs_type,
 
 	export_path = data->mnt_path;
 	data->mnt_path = "/";
-	root_mnt = nfs_do_root_mount(&nfs4_remote_referral_fs_type,
+	root_mnt = nfs_do_root_mount(
 			nfs4_create_referral_server(mount_info.cloned,
 						    mount_info.mntfh),
 			flags, &mount_info, data->hostname);

