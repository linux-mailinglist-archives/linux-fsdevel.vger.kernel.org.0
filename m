Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBB6B9222
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 12:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjCNLw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 07:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCNLwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:52:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA129F23D;
        Tue, 14 Mar 2023 04:51:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64D4DB81900;
        Tue, 14 Mar 2023 11:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE65C433EF;
        Tue, 14 Mar 2023 11:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678794684;
        bh=KZjiynn5m0OMtAoxPlZVjdQJtzScY7f9adPldMxlz+M=;
        h=From:Date:Subject:To:Cc:From;
        b=ns1xQ9b5Mfc3NQEP31O/YjorwVBpZl6w2O/OcmPN5EbzRmhtz/6F8g2zKJxeLh7iP
         1mUr46A0MxL8tnUU2N8TBH3pCgUjv75wBx5JCUtL1SEzyfoCIZaT+fNLCJRDyR/P1i
         hqqtwtuPWCbZNFh4G2JxTyHz/iMP4Cw6Ii3HmHmIzOrr8ZuhiIHqzLMoUebBdEu5ze
         6lP5hJGi53W3tkULxzl14U1xrnoSPxE46RyB8ibgzj25/MC/UQYxbaAMNSs85E7iTo
         OA/IBzPdOvPN8qMiIeH/e4tt52K455+GKtJ/2FlUW7QlX72VXDhehphVtdQCYXUpfU
         ZEKL46E5X75HA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 14 Mar 2023 12:51:10 +0100
Subject: [PATCH v2] nfs: use vfs setgid helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230313-fs-nfs-setgid-v2-1-9a59f436cfc0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAK1fEGQC/3WNwQ6CMBBEf4Xs2ZpusUQ8+R+GQwtbaNRCdgnRE
 P7dwt3DHN5MJm8FIY4kcCtWYFqixDFlMKcC2sGlnlTsMoPRptQlliqISjlCcx87Vdn6gtqh9sZ
 C/ngnpDy71A776+1kJt6HiSnEzyF6NJmHKPPI38O74N7+UyyoUFmPwdm6Dnit7k/iRK/zyD002
 7b9APugEoDEAAAA
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.13-dev-2eb1a
X-Developer-Signature: v=1; a=openpgp-sha256; l=3199; i=brauner@kernel.org;
 h=from:subject:message-id; bh=KZjiynn5m0OMtAoxPlZVjdQJtzScY7f9adPldMxlz+M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQIxO98GHhtVbyDisOXgwdPJ/ZNljiX8FP88xHreo3lXr/S
 +9jfdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk9AbDH67TIpck2VsWGvBOYdlYZv
 rhg0+36XrbLkb/O56/Tj+yusTIcIjboSapOEY1P8n5oPWaLqv6K9bHr2mmnJ5x1Jf/VXwaGwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've aligned setgid behavior over multiple kernel releases. The details
can be found in the following two merge messages:
cf619f891971 ("Merge tag 'fs.ovl.setgid.v6.2')
426b4ca2d6a5 ("Merge tag 'fs.setgid.v6.0')
Consistent setgid stripping behavior is now encapsulated in the
setattr_should_drop_sgid() helper which is used by all filesystems that
strip setgid bits outside of vfs proper. Switch nfs to rely on this
helper as well. Without this patch the setgid stripping tests in
xfstests will fail.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Christoph Hellwig <hch@lst.de>:
  * Export setattr_should_sgid() so it actually can be used by filesystems
- Link to v1: https://lore.kernel.org/r/20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org
---
 fs/attr.c          | 1 +
 fs/internal.h      | 2 --
 fs/nfs/inode.c     | 4 +---
 include/linux/fs.h | 2 ++
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index aca9ff7aed33..d60dc1edb526 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -47,6 +47,7 @@ int setattr_should_drop_sgid(struct mnt_idmap *idmap,
 		return ATTR_KILL_SGID;
 	return 0;
 }
+EXPORT_SYMBOL(setattr_should_drop_sgid);
 
 /**
  * setattr_should_drop_suidgid - determine whether the set{g,u}id bit needs to
diff --git a/fs/internal.h b/fs/internal.h
index dc4eb91a577a..ab36ed8fa41c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -259,8 +259,6 @@ ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *po
 /*
  * fs/attr.c
  */
-int setattr_should_drop_sgid(struct mnt_idmap *idmap,
-			     const struct inode *inode);
 struct mnt_idmap *alloc_mnt_idmap(struct user_namespace *mnt_userns);
 struct mnt_idmap *mnt_idmap_get(struct mnt_idmap *idmap);
 void mnt_idmap_put(struct mnt_idmap *idmap);
diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 222a28320e1c..97a76706fd54 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -717,9 +717,7 @@ void nfs_setattr_update_inode(struct inode *inode, struct iattr *attr,
 		if ((attr->ia_valid & ATTR_KILL_SUID) != 0 &&
 		    inode->i_mode & S_ISUID)
 			inode->i_mode &= ~S_ISUID;
-		if ((attr->ia_valid & ATTR_KILL_SGID) != 0 &&
-		    (inode->i_mode & (S_ISGID | S_IXGRP)) ==
-		     (S_ISGID | S_IXGRP))
+		if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))
 			inode->i_mode &= ~S_ISGID;
 		if ((attr->ia_valid & ATTR_MODE) != 0) {
 			int mode = attr->ia_mode & S_IALLUGO;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..af95b64fc810 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2675,6 +2675,8 @@ extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
 extern int setattr_should_drop_suidgid(struct mnt_idmap *, struct inode *);
 extern int file_remove_privs(struct file *);
+int setattr_should_drop_sgid(struct mnt_idmap *idmap,
+			     const struct inode *inode);
 
 /*
  * This must be used for allocating filesystems specific inodes to set

---
base-commit: eeac8ede17557680855031c6f305ece2378af326
change-id: 20230313-fs-nfs-setgid-659410a10b25

