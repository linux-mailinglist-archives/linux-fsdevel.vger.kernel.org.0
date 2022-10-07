Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0963E5F7971
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 16:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJGOGN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 10:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiJGOGL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:06:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED9120BC8;
        Fri,  7 Oct 2022 07:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41F39B82359;
        Fri,  7 Oct 2022 14:06:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E03C433D7;
        Fri,  7 Oct 2022 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665151568;
        bh=uogDr668k63KhIyS4HWwJyKFgJNpEyczMKBCCBM3DjY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hqt+HYa058hbqIa2xyA5zuQrWIyvNhlogteKmJh6AkSs/ZI37joS8OQQNeP2DlvZM
         OmJvczEDwGVLTv6NeLGFdw+bNFTsoETau+ize/e3EchOgJSBiOU2wH3FBaKCuurMGj
         CnENXFV7vmKUWcRmL9ZhQR+PpxsOmGw+aJttDnZmYemJ3B3JZVFX0inEzLtxyu0qb1
         9tJpn0MCwv99xprsuN8ByzjRdkhyWnlj34pL8InfHb/Hl7QasA53YYwb4d0PNM2mD1
         UcBSvFE39jy43LnnrHYYYkeRpPHYF4kXBrQ838bpM0kYx9TfoGOZk015MhPnFo7Prg
         3+HHGbfH93UZg==
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
Subject: [PATCH v2 2/5] attr: add should_remove_sgid()
Date:   Fri,  7 Oct 2022 16:05:40 +0200
Message-Id: <20221007140543.1039983-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221007140543.1039983-1-brauner@kernel.org>
References: <20221007140543.1039983-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2656; i=brauner@kernel.org; h=from:subject; bh=uogDr668k63KhIyS4HWwJyKFgJNpEyczMKBCCBM3DjY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ7GBlsL5u73+NIfFXUBB37ED+Gnws5HS++29q8e2bnB961 GjrCHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZcpiRYdIewf4V/i2GE9b1iK2//s 44qCr4yKklrdHuMZNtzp3x3MXwiymw9Z5qdutNxv/5yQnb88S1Ms/xNZ3Oy/P7MevXP90tDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
should_remove_sgid(). The function retains the old behavior where we
remove the S_ISGID bit unconditionally when S_IXGRP is set but also when
it isn't set and the caller is neither in the group of the inode nor
privileged over the inode.

We will use this helper both in write operation permission removal such
as file_remove_privs() as well as in ownership change operations.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    Dave Chinner <dchinner@redhat.com>:
    - Use easier to follow logic in the new helper.

 fs/attr.c     | 27 +++++++++++++++++++++++++++
 fs/internal.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index b1cff6f5b715..d0bb1dae425e 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -39,6 +39,33 @@ static bool setattr_drop_sgid(struct user_namespace *mnt_userns,
 	return true;
 }
 
+/**
+ * should_remove_sgid - determine whether the setgid bit needs to be removed
+ * @mnt_userns:	User namespace of the mount the inode was created from
+ * @inode: inode to check
+ *
+ * This function determines whether the setgid bit needs to be removed.
+ * We retain backwards compatibility and require setgid bit to be removed
+ * unconditionally if S_IXGRP is set. Otherwise we have the exact same
+ * requirements as setattr_prepare() and setattr_copy().
+ *
+ * Return: ATTR_KILL_SGID if setgid bit needs to be removed, 0 otherwise.
+ */
+int should_remove_sgid(struct user_namespace *mnt_userns,
+		       const struct inode *inode)
+{
+	umode_t mode = inode->i_mode;
+
+	if (!(mode & S_ISGID))
+		return 0;
+	if (mode & S_IXGRP)
+		return ATTR_KILL_SGID;
+	if (setattr_drop_sgid(mnt_userns, inode,
+			      i_gid_into_vfsgid(mnt_userns, inode)))
+		return ATTR_KILL_SGID;
+	return 0;
+}
+
 /**
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..9d165ab65a2a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -221,3 +221,5 @@ ssize_t do_getxattr(struct user_namespace *mnt_userns,
 int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
 int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
+int should_remove_sgid(struct user_namespace *mnt_userns,
+		       const struct inode *inode);
-- 
2.34.1

