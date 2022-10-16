Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848560017F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Oct 2022 19:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJPRBD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Oct 2022 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJPRBC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Oct 2022 13:01:02 -0400
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB67831EC4
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Oct 2022 10:00:55 -0700 (PDT)
Received: from localhost.localdomain (lfbn-tou-1-1359-241.w90-89.abo.wanadoo.fr [90.89.169.241])
        by mail.nightmared.fr (Postfix) with ESMTPSA id 67B2D10809AB;
        Sun, 16 Oct 2022 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
        s=docker; t=1665939654;
        bh=rFuWgWDJKl7wKLx6gi6Yjs/HLUNqC+F5W1fg2LDaI08=;
        h=From:To:Cc:Subject:Date;
        b=OQlTis/MwJ5XHf3DzPZYpj9JSjk/V+Q/+6TnDUBgBqB1VvpMyovQgj5XQOooKSWej
         UBpRbDmfAZJEqv+rRXoD8vXp0eBXuJehpaDUk1YwsXh2gIEnilQIwj5HWB++oLnm5L
         Wr/0u9hzDEMjTXiFpH+Pk+wGFWiz1HqShf58/OptpM8oWSbhc8OwTAs2AWiU8WiEh9
         6epFgHGatpv43TdIAJjk0ztONN8UFBZdT4RQW6FWajl+HhUSQz8AkcAw21cq1YbGfW
         H1p6u5N34QSn8jFDdViLP4JsKb8JOHYldrkZ4/df1rQ+IRKAXSmRIle+UNawCTDG8u
         dW7KNVbDRgZ3g==
From:   Simon Thoby <work.viveris@nightmared.fr>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Simon Thoby <work.viveris@nightmared.fr>,
        CONZELMANN Francois <Francois.CONZELMANN@viveris.fr>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: enable unprivileged mounts for fuseblk
Date:   Sun, 16 Oct 2022 19:00:46 +0200
Message-Id: <20221016170046.171936-1-work.viveris@nightmared.fr>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 4ad769f3c346ec3d458e255548dec26ca5284cf6 ("fuse: Allow fully
unprivileged mounts") enabled mounting filesystems with the 'fuse' type for
any user with CAP_SYS_ADMIN inside their respective user namespace, but did
not do so for the 'fuseblk' filesystem type.

Some FUSE filesystems implementations - like ntfs-3g - prefer using
'fuseblk' over 'fuse', which imply unprivileged users could not use these
tools - in their "out-of-the-box" configuration, as these tools can always
be patched to use the 'fuse' filesystem type to circumvent the problem.

Enable unprivileged mounts for the 'fuseblk' type, thus uniformizing the
behavior of the two FUSE filesystem types.

Signed-off-by: Simon Thoby <work.viveris@nightmared.fr>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 6b3beda16c1b..d17f87531dc8 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1839,7 +1839,7 @@ static struct file_system_type fuseblk_fs_type = {
 	.init_fs_context = fuse_init_fs_context,
 	.parameters	= fuse_fs_parameters,
 	.kill_sb	= fuse_kill_sb_blk,
-	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE,
+	.fs_flags	= FS_REQUIRES_DEV | FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
 };
 MODULE_ALIAS_FS("fuseblk");
 

base-commit: 472c7791cc2b48010af3ce61ce76edbaa26500d2
-- 
2.38.0

