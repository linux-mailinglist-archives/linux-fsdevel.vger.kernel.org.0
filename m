Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDEE2FC03B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 20:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbhASTcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 14:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729533AbhASTZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:25:40 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935DFC061574;
        Tue, 19 Jan 2021 11:25:00 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 77F22AA2; Tue, 19 Jan 2021 14:24:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 77F22AA2
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/3] nfs: use change attribute for NFS re-exports
Date:   Tue, 19 Jan 2021 14:24:55 -0500
Message-Id: <1611084297-27352-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611084297-27352-1-git-send-email-bfields@redhat.com>
References: <1611084297-27352-1-git-send-email-bfields@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

When exporting NFS, we may as well use the real change attribute
returned by the original server instead of faking up a change attribute
from the ctime.

Note we can't do that by setting I_VERSION--that would also turn on the
logic in iversion.h which treats the lower bit specially, and that
doesn't make sense for NFS.

So instead we define a new export operation for filesystems like NFS
that want to manage the change attribute themselves.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfs/export.c          | 18 ++++++++++++++++++
 fs/nfsd/nfsfh.h          |  5 ++++-
 include/linux/exportfs.h |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/export.c b/fs/nfs/export.c
index 7412bb164fa7..f2b34cfe286c 100644
--- a/fs/nfs/export.c
+++ b/fs/nfs/export.c
@@ -167,10 +167,28 @@ nfs_get_parent(struct dentry *dentry)
 	return parent;
 }
 
+static u64 nfs_fetch_iversion(struct inode *inode)
+{
+	struct nfs_server *server = NFS_SERVER(inode);
+
+	/* Is this the right call?: */
+	nfs_revalidate_inode(server, inode);
+	/*
+	 * Also, note we're ignoring any returned error.  That seems to be
+	 * the practice for cache consistency information elsewhere in
+	 * the server, but I'm not sure why.
+	 */
+	if (server->nfs_client->rpc_ops->version >= 4)
+		return inode_peek_iversion_raw(inode);
+	else
+		return time_to_chattr(&inode->i_ctime);
+}
+
 const struct export_operations nfs_export_ops = {
 	.encode_fh = nfs_encode_fh,
 	.fh_to_dentry = nfs_fh_to_dentry,
 	.get_parent = nfs_get_parent,
+	.fetch_iversion = nfs_fetch_iversion,
 	.flags = EXPORT_OP_NOWCC|EXPORT_OP_NOSUBTREECHK|
 		EXPORT_OP_CLOSE_BEFORE_UNLINK|EXPORT_OP_REMOTE_FS|
 		EXPORT_OP_NOATOMIC_ATTR,
diff --git a/fs/nfsd/nfsfh.h b/fs/nfsd/nfsfh.h
index cb20c2cd3469..f58933519f38 100644
--- a/fs/nfsd/nfsfh.h
+++ b/fs/nfsd/nfsfh.h
@@ -12,6 +12,7 @@
 #include <linux/sunrpc/svc.h>
 #include <uapi/linux/nfsd/nfsfh.h>
 #include <linux/iversion.h>
+#include <linux/exportfs.h>
 
 static inline __u32 ino_t_to_u32(ino_t ino)
 {
@@ -264,7 +265,9 @@ fh_clear_wcc(struct svc_fh *fhp)
 static inline u64 nfsd4_change_attribute(struct kstat *stat,
 					 struct inode *inode)
 {
-	if (IS_I_VERSION(inode)) {
+	if (inode->i_sb->s_export_op->fetch_iversion)
+		return inode->i_sb->s_export_op->fetch_iversion(inode);
+	else if (IS_I_VERSION(inode)) {
 		u64 chattr;
 
 		chattr =  stat->ctime.tv_sec;
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 9f4d4bcbf251..fe848901fcc3 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -213,6 +213,7 @@ struct export_operations {
 			  bool write, u32 *device_generation);
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
 			     int nr_iomaps, struct iattr *iattr);
+	u64 (*fetch_iversion)(struct inode *);
 #define	EXPORT_OP_NOWCC			(0x1) /* don't collect v3 wcc data */
 #define	EXPORT_OP_NOSUBTREECHK		(0x2) /* no subtree checking */
 #define	EXPORT_OP_CLOSE_BEFORE_UNLINK	(0x4) /* close files before unlink */
-- 
2.29.2

