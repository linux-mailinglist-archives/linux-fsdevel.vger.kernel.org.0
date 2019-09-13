Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465F7B1D8E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfIMMT7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 08:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729449AbfIMMRu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:17:50 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE0A283F45;
        Fri, 13 Sep 2019 12:17:49 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-122-52.rdu2.redhat.com [10.10.122.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D00761001959;
        Fri, 13 Sep 2019 12:17:49 +0000 (UTC)
Received: by coeurl.usersys.redhat.com (Postfix, from userid 1000)
        id D2EA420C3B; Fri, 13 Sep 2019 08:17:48 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     anna.schumaker@netapp.com, trond.myklebust@hammerspace.com
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/26] nfs: unexport nfs_fs_mount_common()
Date:   Fri, 13 Sep 2019 08:17:33 -0400
Message-Id: <20190913121748.25391-12-smayhew@redhat.com>
In-Reply-To: <20190913121748.25391-1-smayhew@redhat.com>
References: <20190913121748.25391-1-smayhew@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 13 Sep 2019 12:17:50 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Make it static, even.  And remove a stale extern of (long-gone)
nfs_xdev_mount_common() from internal.h, while we are at it.

Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/nfs/internal.h | 3 ---
 fs/nfs/super.c    | 5 +++--
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index ac3478827a83..207d1574e246 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -404,10 +404,7 @@ bool nfs_auth_info_match(const struct nfs_auth_info *, rpc_authflavor_t);
 struct dentry *nfs_try_mount(int, const char *, struct nfs_mount_info *);
 int nfs_set_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
 int nfs_clone_sb_security(struct super_block *, struct dentry *, struct nfs_mount_info *);
-struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
 struct dentry *nfs_fs_mount(struct file_system_type *, int, const char *, void *);
-struct dentry * nfs_xdev_mount_common(struct file_system_type *, int,
-		const char *, struct nfs_mount_info *);
 void nfs_kill_super(struct super_block *);
 void nfs_fill_super(struct super_block *, struct nfs_mount_info *);
 void nfs_clone_super(struct super_block *, struct nfs_mount_info *);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index d80992d2b6fe..c3ee83c17f07 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1893,6 +1893,8 @@ static struct nfs_server *nfs_try_mount_request(struct nfs_mount_info *mount_inf
 	return nfs_mod->rpc_ops->create_server(mount_info, nfs_mod);
 }
 
+static struct dentry *nfs_fs_mount_common(int, const char *, struct nfs_mount_info *);
+
 struct dentry *nfs_try_mount(int flags, const char *dev_name,
 			     struct nfs_mount_info *mount_info)
 {
@@ -2623,7 +2625,7 @@ int nfs_clone_sb_security(struct super_block *s, struct dentry *mntroot,
 }
 EXPORT_SYMBOL_GPL(nfs_clone_sb_security);
 
-struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
+static struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 				   struct nfs_mount_info *mount_info)
 {
 	struct super_block *s;
@@ -2705,7 +2707,6 @@ struct dentry *nfs_fs_mount_common(int flags, const char *dev_name,
 	deactivate_locked_super(s);
 	goto out;
 }
-EXPORT_SYMBOL_GPL(nfs_fs_mount_common);
 
 struct dentry *nfs_fs_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *raw_data)
-- 
2.17.2

