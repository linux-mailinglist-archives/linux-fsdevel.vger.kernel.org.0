Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7AD76CC2C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Aug 2023 13:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjHBL52 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Aug 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbjHBL5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:57:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E7B2D4A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 04:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917E56194C
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Aug 2023 11:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20293C433CD;
        Wed,  2 Aug 2023 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690977441;
        bh=q9qSw+RNPzZufGdgU8orFIE4eD1MUd9HSUafYV+iY+k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=K79MCsnsZhk0vkGg4HX+llYM3WVihSlr3+gU7pezJ8LIyavo5t5Qv8+tY3s243WhI
         LJeCdWcuYzG+9Bpxhe5wM9T3gD+Gszo9l95/NRiKQ8e5Q8CU9dJ82gfBaM5SUfTr8Z
         D0auzQU4K4U0fiP+sCJOtrv4LZ093DX3648lYBf2vxwf9peDD0oFNYIUWJZpcX6GxB
         yOrLe5C3ilxPXNbHaF5FblDMxgsqHySiciGpcxWACplJbxnOowTmAsT5N5/ZqXwvIx
         QBvYB9Ju4F1SDKEFmbYofT/ZJDrevtkval0Tht9cTCPnJOsT9bqTXvln6cyBk68rGq
         p5J9lF3VKKBgg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 02 Aug 2023 13:57:05 +0200
Subject: [PATCH v2 3/4] fs: add vfs_cmd_reconfigure()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230802-vfs-super-exclusive-v2-3-95dc4e41b870@kernel.org>
References: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
In-Reply-To: <20230802-vfs-super-exclusive-v2-0-95dc4e41b870@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2398; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q9qSw+RNPzZufGdgU8orFIE4eD1MUd9HSUafYV+iY+k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSccpm+5eOrqfuO2W7nXXgwVbTgFaPPu9Rf1ZcNWaLaj5dM
 Z+n711HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR2ZMM/+vuGb2odk0Lbpj5wH6+Qo
 59gWeU3Y2WV31/tkba1xaG/GNkuNQc8Lm8+r1tdJ3ufv/vn2TCube5Jx1mrjV7c7/iVNFOJgA=
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

Split the steps to reconfigure a superblock into a tiny helper instead
of open-coding it in the switch.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fsopen.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 1de2b3576958..a69b7c9cc59c 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -242,6 +242,34 @@ static int vfs_cmd_create(struct fs_context *fc)
 	return 0;
 }
 
+static int vfs_cmd_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb;
+	int ret;
+
+	if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
+		return -EBUSY;
+
+	fc->phase = FS_CONTEXT_RECONFIGURING;
+
+	sb = fc->root->d_sb;
+	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
+		fc->phase = FS_CONTEXT_FAILED;
+		return -EPERM;
+	}
+
+	down_write(&sb->s_umount);
+	ret = reconfigure_super(fc);
+	up_write(&sb->s_umount);
+	if (ret) {
+		fc->phase = FS_CONTEXT_FAILED;
+		return ret;
+	}
+
+	vfs_clean_context(fc);
+	return 0;
+}
+
 /*
  * Check the state and apply the configuration.  Note that this function is
  * allowed to 'steal' the value by setting param->xxx to NULL before returning.
@@ -249,7 +277,6 @@ static int vfs_cmd_create(struct fs_context *fc)
 static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 			       struct fs_parameter *param)
 {
-	struct super_block *sb;
 	int ret;
 
 	ret = finish_clean_context(fc);
@@ -259,21 +286,7 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 	case FSCONFIG_CMD_CREATE:
 		return vfs_cmd_create(fc);
 	case FSCONFIG_CMD_RECONFIGURE:
-		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)
-			return -EBUSY;
-		fc->phase = FS_CONTEXT_RECONFIGURING;
-		sb = fc->root->d_sb;
-		if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
-		down_write(&sb->s_umount);
-		ret = reconfigure_super(fc);
-		up_write(&sb->s_umount);
-		if (ret)
-			break;
-		vfs_clean_context(fc);
-		return 0;
+		return vfs_cmd_reconfigure(fc);
 	default:
 		if (fc->phase != FS_CONTEXT_CREATE_PARAMS &&
 		    fc->phase != FS_CONTEXT_RECONF_PARAMS)
@@ -281,8 +294,6 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 
 		return vfs_parse_fs_param(fc, param);
 	}
-	fc->phase = FS_CONTEXT_FAILED;
-	return ret;
 }
 
 /**

-- 
2.34.1

