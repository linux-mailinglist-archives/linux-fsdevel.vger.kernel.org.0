Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C04AF5EAAB1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Sep 2022 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiIZPYS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Sep 2022 11:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiIZPXs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E48895F3;
        Mon, 26 Sep 2022 07:09:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1E04B80A4A;
        Mon, 26 Sep 2022 14:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30244C4347C;
        Mon, 26 Sep 2022 14:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201359;
        bh=JVmlADhDiJUJvL6l3dFa/4JVMm1HdUvCYu4/Znk0lDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LvqpBd/PVgawMfJ5+jPe58Q03mr9c/O4c0hYUKlFwxOHpvYO3u1iL+BPW8E1a/8kT
         4onex9aJ9O1Aq4NHlEP3Z9+f4xrOmtiQGMjOFOacMi2fCJU8HLRyCW6456QZ5gZSW+
         CVEeZUiuIowwX8olA/JK0xQe99e1PtU+6Gx8adEMOOb+9+XFpDWSST1FqfD+i+GWOD
         gzI1WfCN3dbFC4NKe2H+JqHgG0roFEFuRSIB9XlWD3f7ysPrFot7XklQbmfVQ0D5KO
         1dIMb/wMaQkFycMcdOM1GX9h6Xj5Mbt8xp2MYM69KxB0GCpeN8sOSQJtx8myIC3ZnG
         voRsFrFd4vweQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 14/30] acl: use set acl hook
Date:   Mon, 26 Sep 2022 16:08:11 +0200
Message-Id: <20220926140827.142806-15-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220926140827.142806-1-brauner@kernel.org>
References: <20220926140827.142806-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2269; i=brauner@kernel.org; h=from:subject; bh=JVmlADhDiJUJvL6l3dFa/4JVMm1HdUvCYu4/Znk0lDs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQbbnLIEBLo+L7f7eC8G2yNMQlNedkilgqpRaeLFndUBmTc v7W+o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLuNowMTwqzzU0KpSo1VnK/UJ8ZEL So8TkD6/O/URUNc3Yr/0gUYmSYZ1bi5Hem9Kmy2saF6X6i2WpRv55uLtNKdGuedzSW05UPAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The current way of setting and getting posix acls through the generic
xattr interface is error prone and type unsafe. The vfs needs to
interpret and fixup posix acls before storing or reporting it to
userspace. Various hacks exist to make this work. The code is hard to
understand and difficult to maintain in it's current form. Instead of
making this work by hacking posix acls through xattr handlers we are
building a dedicated posix acl api around the get and set inode
operations. This removes a lot of hackiness and makes the codepaths
easier to maintain. A lot of background can be found in [1].

So far posix acls were passed as a void blob to the security and
integrity modules. Some of them like evm then proceed to interpret the
void pointer and convert it into the kernel internal struct posix acl
representation to perform their integrity checking magic. This is
obviously pretty problematic as that requires knowledge that only the
vfs is guaranteed to have and has lead to various bugs.

Now that we have a proper security hook for setting posix acls that
passes down the posix acls in their appropriate vfs format instead of
hacking it through a void pointer stored in the uapi format make use of
it in the new posix acl api.

Link: https://lore.kernel.org/all/20220801145520.1532837-1-brauner@kernel.org [1]
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---

Notes:
    /* v2 */
    unchanged

 fs/posix_acl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index f19ded0978e5..471d17fa1611 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -24,6 +24,7 @@
 #include <linux/user_namespace.h>
 #include <linux/namei.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/security.h>
 #include <linux/fsnotify.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
@@ -1336,6 +1337,10 @@ int vfs_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (error)
 		goto out_inode_unlock;
 
+	error = security_inode_set_acl(mnt_userns, dentry, acl_name, kacl);
+	if (error)
+		goto out_inode_unlock;
+
 	error = try_break_deleg(inode, &delegated_inode);
 	if (error)
 		goto out_inode_unlock;
-- 
2.34.1

