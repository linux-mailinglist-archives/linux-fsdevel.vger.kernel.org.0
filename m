Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E323B76CC2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHBL50 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbjHBL5X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:57:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41EF10C1
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:57:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7306194D
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB9EC433C7;
        Wed,  2 Aug 2023 11:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977438;
        bh=XS3PfRJ9EhCxzthB6QwDkaR1eUCY5UjmsNteS7PS6RE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XixLsp4lJFCZCadZAdlgRnEWNGWets/zB0zV5eWU24xjbVqrsUQyWtM73RhSWAEoJ
         kagkYh6vYFfBmXs+6wfF1oh70p4mjK+YdXfUfuvQbLaqXuHw0LijHM42Xp1hZbsTBT
         kPQLwntlPZNWgnXB/Hykx9rZazPsTMIa9JnnT/IJySCZ10V5RLAyitMIHmC8HXTttR
         7Q47JA59+aw5+hMp6/oYqcLpLWbm0mFipczjfPpI861+z3amESXAOzTJtkS38CHX29
         OM/AMM9gyRnztfwmXyHLjMBX41W7kyxKNkxPd/2DlNsfIQzHKENetEqubW9BpJVcb0
         8//PEt2n892jA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 02 Aug 2023 13:57:04 +0200
Subject: [PATCH v2 2/4] fs: add vfs_cmd_create()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-vfs-super-exclusive-v2-2-95dc4e41b870@kernel.org>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XS3PfRJ9EhCxzthB6QwDkaR1eUCY5UjmsNteS7PS6RE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSccpne0v39P8P5uLkzzrOu7zzvLWTld+GgYO+zh357wp7/
 uhnA2lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRVbcYGR7M/XK3QVScL/ZIWk+1jG
 GS+AflSKfDK4N8rFisBbh11zMyNK9wmmfecj1/u32dTLo1c9WLj+ra9r1z7LPOTW3c8WkJCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the steps to create a superblock into a tiny helper. This will
make the next patch easier to follow.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fsopen.c | 51 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index fc9d2d9fd234..1de2b3576958 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -209,6 +209,39 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	return ret;
 }
 
+static int vfs_cmd_create(struct fs_context *fc)
+{
+	struct super_block *sb;
+	int ret;
+
+	if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
+		return -EBUSY;
+
+	if (!mount_capable(fc))
+		return -EPERM;
+
+	fc->phase = FS_CONTEXT_CREATING;
+
+	ret = vfs_get_tree(fc);
+	if (ret) {
+		fc->phase = FS_CONTEXT_FAILED;
+		return ret;
+	}
+
+	sb = fc->root->d_sb;
+	ret = security_sb_kern_mount(sb);
+	if (unlikely(ret)) {
+		fc_drop_locked(fc);
+		fc->phase = FS_CONTEXT_FAILED;
+		return ret;
+	}
+
+	/* vfs_get_tree() callchains will have grabbed @s_umount */
+	up_write(&sb->s_umount);
+	fc->phase = FS_CONTEXT_AWAITING_MOUNT;
+	return 0;
+}
+
 /*
  * Check the state and apply the configuration.  Note that this function is
  * allowed to 'steal' the value by setting param->xxx to NULL before returning.
@@ -224,23 +257,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 		return ret;
 	switch (cmd) {
 	case FSCONFIG_CMD_CREATE:
-		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
-			return -EBUSY;
-		if (!mount_capable(fc))
-			return -EPERM;
-		fc->phase = FS_CONTEXT_CREATING;
-		ret = vfs_get_tree(fc);
-		if (ret)
-			break;
-		sb = fc->root->d_sb;
-		ret = security_sb_kern_mount(sb);
-		if (unlikely(ret)) {
-			fc_drop_locked(fc);
-			break;
-		}
-		up_write(&sb->s_umount);
-		fc->phase = FS_CONTEXT_AWAITING_MOUNT;
-		return 0;
+		return vfs_cmd_create(fc);
 	case FSCONFIG_CMD_RECONFIGURE:
 		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
 			return -EBUSY;

-- 
2.34.1

