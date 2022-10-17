Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF4600BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbiJQKG2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 06:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJQKG0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 06:06:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB80F264BD;
        Mon, 17 Oct 2022 03:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B63B61006;
        Mon, 17 Oct 2022 10:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 655A4C433D6;
        Mon, 17 Oct 2022 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666001181;
        bh=K9xtmWZfIP2K0cO3w9V0vlfpixeGnd8zXoBBapuiFMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eDMaRECbAe5wUm5KL+V3o510aIaaG8jlDlRPPTZZutuCQWcqzYLw1RYLCYJwMJmMP
         GHAk6NbckB8Mq++MmdfD5FvjYUstm/duL7jg2cDpzs6aPyySlwkdmofDKy5zTO4Vwb
         YqQZmCM47NLspu1TIHGOzI621TZ6woAidjcyPgVEr/NWr8Yg2rCJPahTBHCrvnFICC
         58dBFwepuJil+Ooa4Uwyvskg9V9eAmDoMAQ9xTJI9utCzG2EWXM9Fzgf9fBXCBlEbH
         Zp48IKWLHUhgs9wFKtqu49PCiq7sPfhdIYRxBHZJzZe9/9CN7tG9UgHiHZy9JCtl1t
         NRlSjiKknPZOQ==
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
Subject: [PATCH v3 2/5] attr: add setattr_should_drop_sgid()
Date:   Mon, 17 Oct 2022 12:05:57 +0200
Message-Id: <20221017100600.70269-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221017100600.70269-1-brauner@kernel.org>
References: <20221017100600.70269-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2929; i=brauner@kernel.org; h=from:subject; bh=K9xtmWZfIP2K0cO3w9V0vlfpixeGnd8zXoBBapuiFMo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST7avz2O7n+5tUOHkvX7h3t03Y6v5p9eXuL7JuXMh6bos6E 5Zund5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkdRTDP50NedPthc88Ov9l55T0VA a+j6ZMc0TdnmR570g/7FogtoGR4YPxyvg36uKPQ00SDZPMF7zzrrzqYvb0UWAU42FjVRV2FgA=
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

 fs/attr.c     | 26 ++++++++++++++++++++++++++
 fs/internal.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/fs/attr.c b/fs/attr.c
index 8bc2edd6bd3c..3d03ceb332e5 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -39,6 +39,32 @@ static int setattr_drop_sgid(struct user_namespace *mnt_userns,
 	return ATTR_KILL_SGID;
 }
 
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
+	return setattr_drop_sgid(mnt_userns, inode,
+				 i_gid_into_vfsgid(mnt_userns, inode));
+}
+
 /**
  * chown_ok - verify permissions to chown inode
  * @mnt_userns:	user namespace of the mount @inode was found from
diff --git a/fs/internal.h b/fs/internal.h
index 6f0386b34fae..988e123d3885 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -234,3 +234,5 @@ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		struct xattr_ctx *ctx);
 
 ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+int setattr_should_drop_sgid(struct user_namespace *mnt_userns,
+			     const struct inode *inode);
-- 
2.34.1

