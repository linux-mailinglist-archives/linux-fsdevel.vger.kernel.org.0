Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1A73266F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Feb 2021 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhBZSdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Feb 2021 13:33:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:52786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230360AbhBZSdd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Feb 2021 13:33:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 795F6AFF5;
        Fri, 26 Feb 2021 18:32:51 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 57c09077;
        Fri, 26 Feb 2021 18:33:58 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, linux-kernel@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: [RFC PATCH] fuse: Clear SGID bit when setting mode in setacl
Date:   Fri, 26 Feb 2021 18:33:57 +0000
Message-Id: <20210226183357.28467-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Setting file permissions with POSIX ACLs (setxattr) isn't clearing the
setgid bit.  This seems to be CVE-2016-7097, detected by running fstest
generic/375 in virtiofs.  Unfortunately, when the fix for this CVE landed
in the kernel with commit 073931017b49 ("posix_acl: Clear SGID bit when
setting file permissions"), FUSE didn't had ACLs support yet.

Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
 fs/fuse/acl.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index f529075a2ce8..1b273277c1c9 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -54,7 +54,9 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	const char *name;
+	umode_t mode = inode->i_mode;
 	int ret;
+	bool update_mode = false;
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -62,11 +64,18 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	if (!fc->posix_acl || fc->no_setxattr)
 		return -EOPNOTSUPP;
 
-	if (type == ACL_TYPE_ACCESS)
+	if (type == ACL_TYPE_ACCESS) {
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
-	else if (type == ACL_TYPE_DEFAULT)
+		if (acl) {
+			ret = posix_acl_update_mode(inode, &mode, &acl);
+			if (ret)
+				return ret;
+			if (inode->i_mode != mode)
+				update_mode = true;
+		}
+	} else if (type == ACL_TYPE_DEFAULT) {
 		name = XATTR_NAME_POSIX_ACL_DEFAULT;
-	else
+	} else
 		return -EINVAL;
 
 	if (acl) {
@@ -98,6 +107,20 @@ int fuse_set_acl(struct inode *inode, struct posix_acl *acl, int type)
 	} else {
 		ret = fuse_removexattr(inode, name);
 	}
+	if (!ret && update_mode) {
+		struct dentry *entry;
+		struct iattr attr;
+
+		entry = d_find_alias(inode);
+		if (entry) {
+			memset(&attr, 0, sizeof(attr));
+			attr.ia_valid = ATTR_MODE | ATTR_CTIME;
+			attr.ia_mode = mode;
+			attr.ia_ctime = current_time(inode);
+			ret = fuse_do_setattr(entry, &attr, NULL);
+			dput(entry);
+		}
+	}
 	forget_all_cached_acls(inode);
 	fuse_invalidate_attr(inode);
 
