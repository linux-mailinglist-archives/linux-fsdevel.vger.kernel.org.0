Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B06816A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbjA3Qm1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 11:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjA3QmT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:42:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974FB42DF0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 08:42:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FCB1B81333
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jan 2023 16:42:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8662C4339B;
        Mon, 30 Jan 2023 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675096935;
        bh=Bg5E6No4TK445z5ftFeOCpYOQbjP6wiAoF3MHt1p/Sc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cXXeGMYJRtw5+3OtnQLBvV7zN6XgJW9SG2Rln0q8wwBiWGjuHh07TupyuPXrmn+QL
         BjUCK6SS20eKdjKLflG94MweHXfrsAkhy0oMYQjlTBqPG85lxOeHB1n7RwD9yx3mIQ
         SmcYNFbOKAsPd7OVoeXSfRVmfTi0z9XbOovH9pKn2sgApZbQr9Ug+/YFM9WMPbU/GX
         45i+4ZjRAUD2IWcfEENx5V5FzWxJfBic8DlpLr46Zf6TTvEK4X8gPbKDTuOiqVhrOS
         PF2/QGS1G88GWtvj9KeRmJHJ5Klb6aWcFUJJ+VSmHpqFg01f+tqDftFn7PBBGISoSb
         Qb6WOe6cTng2g==
From:   Christian Brauner <brauner@kernel.org>
Date:   Mon, 30 Jan 2023 17:42:00 +0100
Subject: [PATCH v2 4/8] xattr: remove unused argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v2-4-214cfb88bb56@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v2-0-214cfb88bb56@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Bg5E6No4TK445z5ftFeOCpYOQbjP6wiAoF3MHt1p/Sc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRf/xwn7LjewI3RvOS7apxy7JJV+R9S5whO/7C9sWzlzXx3
 g2rzjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInMK2ZkmOCyq4qJ6dfej3yTWyzvpP
 Kw1T9exHfOe9rSssLZE9aF2TIyLN7kw3ds4703Sb6rfD0TREz+/NvGuN3yZPdXudClK4p1eQE=
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

his helpers is really just used to check for user.* xattr support so
don't make it pointlessly generic.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v2:
- Patch unchanged.
---
 fs/nfsd/nfs4xdr.c     |  3 +--
 fs/xattr.c            | 10 ++++------
 include/linux/xattr.h |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97edb32be77f..79814cfe8bcf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3442,8 +3442,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		err = xattr_supported_namespace(d_inode(dentry),
-						XATTR_USER_PREFIX);
+		err = xattr_supports_user_prefix(d_inode(dentry));
 		*p++ = cpu_to_be32(err == 0);
 	}
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 0e8ce76cb76a..9de2f211ee6e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -159,11 +159,10 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
  * Look for any handler that deals with the specified namespace.
  */
 int
-xattr_supported_namespace(struct inode *inode, const char *prefix)
+xattr_supports_user_prefix(struct inode *inode)
 {
 	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
 	const struct xattr_handler *handler;
-	size_t preflen;
 
 	if (!(inode->i_opflags & IOP_XATTR)) {
 		if (unlikely(is_bad_inode(inode)))
@@ -171,16 +170,15 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 		return -EOPNOTSUPP;
 	}
 
-	preflen = strlen(prefix);
-
 	for_each_xattr_handler(handlers, handler) {
-		if (!strncmp(xattr_prefix(handler), prefix, preflen))
+		if (!strncmp(xattr_prefix(handler), XATTR_USER_PREFIX,
+			     XATTR_USER_PREFIX_LEN))
 			return 0;
 	}
 
 	return -EOPNOTSUPP;
 }
-EXPORT_SYMBOL(xattr_supported_namespace);
+EXPORT_SYMBOL(xattr_supports_user_prefix);
 
 int
 __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 91d5b9de933a..de3f507397fb 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -94,7 +94,7 @@ int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, const char *name,
 		       char **xattr_value, size_t size, gfp_t flags);
 
-int xattr_supported_namespace(struct inode *inode, const char *prefix);
+int xattr_supports_user_prefix(struct inode *inode);
 
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {

-- 
2.34.1

