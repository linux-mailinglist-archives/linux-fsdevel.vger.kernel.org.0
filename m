Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E779A601271
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiJQPJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 11:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiJQPIz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 11:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94C209B1;
        Mon, 17 Oct 2022 08:08:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67EDC60F8C;
        Mon, 17 Oct 2022 15:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3966BC433D7;
        Mon, 17 Oct 2022 15:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666019312;
        bh=cIYSo0yTz/F7YYNSgf0AVAvCPiy1ti841YYm0RO2PnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EisvWo3F8diDk4v20F3A+6hkvxohHZG8LtEMiXwxsNAXUVJYxYRkm2OfaTxKx2+eF
         oRAKQ64YtMPJhoJKbEz7fIKCgZ3c0fMQt8l/pCTy836RjgZcWRRbfPp7FuuP6pi5SB
         plXPSzq/7eNfWzERBOUuudlbmmvAs+UE/zlo/t01bkl8c4GwLJvwYvBeBYfFLaTf15
         qPanKSiEdYICPmLnDBiwONn4+/Mv772sb+RuCEFknagYan3A7Dw+Ncz47YfEVp0qZ7
         pkm41nI1jfB3vjYA6iqCAwbdV2Uu/OC5ypXecdVqMivu0VjCUQHzcWIcG1cg/nBUEc
         QI73UuF2PYxtg==
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 3/6] attr: add setattr_should_drop_sgid()
Date:   Mon, 17 Oct 2022 17:06:36 +0200
Message-Id: <20221017150640.112577-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017150640.112577-1-brauner@kernel.org>
References: <20221017150640.112577-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3062; i=brauner@kernel.org; h=from:subject; bh=cIYSo0yTz/F7YYNSgf0AVAvCPiy1ti841YYm0RO2PnU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST75ufcEgxQXHPHMn+LTX3f+mui/75Z1DW56+gcmOp12/72 xDi2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkkijP8Fb+hLzjjy/nciFkvrm+7q+ aZuT4qp3Wjpyez6A7ZkEV3ShgZ9i+an6nO6Tx579KI7b/Wcu2c9vnYlmo5D7405hU14pLT2QA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current setgid stripping logic during write and ownership change
operations is inconsistent and strewn over multiple places. In order to
consolidate it and make more consistent we'll add a new helper
setattr_should_drop_sgid(). The function retains the old behavior where
we remove the S_ISGID bit unconditionally when S_IXGRP is set but also
when it isn't set and the caller is neither in the group of the inode
nor privileged over the inode.

We will use this helper both in write operation permission removal such
as file_remove_privs() as well as in ownership change operations.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Dave Chinner <dchinner@redhat.com>:
    - Use easier to follow logic in the new helper.
    
    /* v3 */
    Amir Goldstein <amir73il@gmail.com>:
    - Rename helper from should_remove_sgid() to setattr_should_drop_sgid() to
      better indicate its semantics.
    - Return setattr_should_drop_sgid() directly now that it returns ATTR_KILL_SGID
      instead of a boolean.
    
    /* v4 */
    Amir Goldstein <amir73il@gmail.com>:
    - Add a section comment for fs/attr.c into fs/internal.h to be consistent with
      the rest.

 fs/attr.c     | 28 ++++++++++++++++++++++++++++
 fs/internal.h |  6 ++++++
 2 files changed, 34 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index e508b3caae76..085322536127 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -20,6 +20,34 @@
 
 #include "internal.h"
 
+/**
+ * setattr_should_drop_sgid - determine whether the setgid bit needs to be
+ *                            removed
+ * @mnt_userns:	user namespace of the mount @inode was found from
+ * @inode:	inode to check
+ *
+ * This function determines whether the setgid bit needs to be removed.
+ * We retain backwards compatibility and require setgid bit to be removed
+ * unconditionally if S_IXGRP is set. Otherwise we have the exact same
+ * requirements as setattr_prepare() and setattr_copy().
+ *
+ * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
+ */
+int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+			     const struct inode *inode)
+{
+	umode_t mode = inode->i_mode;
+
+	if (!(mode & S_ISGID))
+		return 0;
+	if (mode & S_IXGRP)
+		return ATTR_KILL_SGID;
+	if (!in_group_or_capable(mnt_userns, inode,
+				 i_gid_into_vfsgid(mnt_userns, inode)))
+		return ATTR_KILL_SGID;
+	return 0;
+}
+
 /*
  * The logic we want is
  *
diff --git a/fs/internal.h b/fs/internal.h
index 1de39bbc9ddd..771b0468d70c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -236,3 +236,9 @@ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 
 ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+
+/*
+ * fs/attr.c
+ */
+int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+			     const struct inode *inode);
-- 
2.34.1

