Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6146C76B581
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjHANKL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 09:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjHANKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:10:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB02E9
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 06:10:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 021406159C
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 13:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08BAC433C7;
        Tue,  1 Aug 2023 13:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690895404;
        bh=6Q8lhFvDOVIXoL1/isoX2znCnQ5Jcq/pxYv64+grYik=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gE4I9ph6RWQ4t6mg9dNeZhZ66dKBYKAjskBqA50lVFDdLdOJD4HwWlyUiaSc9onih
         MPTBbkUhG6DkrCm+5xNsrkKXEm1/fZoYgVnzpp9iNjsVbskeRgWJ1HmZWPtcAn/rFF
         wYZvXTHcrzEE5zfDQnKouoQLuy3eo+VQqIhOLt9p74Z5HqIUttdPukIeh33q7rxWNw
         m8jfJITFviWwZ+C1pffM/jDdYpFCspKIopCc3vLTFB1Rs89BE8hKK6CrsdicmgOLrR
         /ujU4qZ7puJ6VfWbGNJ5eMu79BMb89Pp4vt1KDcuzX9gldMb2G3j4uufxcF2tj6hL3
         5dt+IJzvqd2Ow==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 01 Aug 2023 15:09:01 +0200
Subject: [PATCH RFC 2/3] fs: add vfs_cmd_create()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-vfs-super-exclusive-v1-2-1a587e56c9f3@kernel.org>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
In-Reply-To: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6Q8lhFvDOVIXoL1/isoX2znCnQ5Jcq/pxYv64+grYik=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaScZFG7uM5YP8Z2ncWECQ8k02Lj14vNXOLEXK6vPGnXpIpT
 znMsOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZy8igjw+uClqSp0zSKOLV4vx0td+
 578q/0j+wtl4L2pFOPHOcstmf4yfglL6XgVYgHg8mdjo+vZ9w6HGyhU7V1bYxiHaufg5AbBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the steps to create a superblock into a tiny helper. This will
make the next patch easier to follow.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fsopen.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index fc9d2d9fd234..af2ff05dcee5 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -209,6 +209,36 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
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
+	if (ret)
+		return ret;
+
+	sb = fc->root->d_sb;
+	ret = security_sb_kern_mount(sb);
+	if (unlikely(ret)) {
+		fc_drop_locked(fc);
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
@@ -224,22 +254,9 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 		return ret;
 	switch (cmd) {
 	case FSCONFIG_CMD_CREATE:
-		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
-			return -EBUSY;
-		if (!mount_capable(fc))
-			return -EPERM;
-		fc->phase = FS_CONTEXT_CREATING;
-		ret = vfs_get_tree(fc);
+		ret = vfs_cmd_create(fc);
 		if (ret)
 			break;
-		sb = fc->root->d_sb;
-		ret = security_sb_kern_mount(sb);
-		if (unlikely(ret)) {
-			fc_drop_locked(fc);
-			break;
-		}
-		up_write(&sb->s_umount);
-		fc->phase = FS_CONTEXT_AWAITING_MOUNT;
 		return 0;
 	case FSCONFIG_CMD_RECONFIGURE:
 		if (fc->phase != FS_CONTEXT_RECONF_PARAMS)

-- 
2.34.1

