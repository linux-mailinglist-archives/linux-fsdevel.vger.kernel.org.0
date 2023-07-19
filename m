Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1044D75931E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjGSKcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSKcf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:32:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53448B7;
        Wed, 19 Jul 2023 03:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6AC561403;
        Wed, 19 Jul 2023 10:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52FB3C433C8;
        Wed, 19 Jul 2023 10:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689762753;
        bh=7FN/ypWIeSgyi8ApBs5nWT0Ilg5XTOBbZrV5mJSJyyw=;
        h=From:Date:Subject:To:Cc:From;
        b=gU6B8Us3VId8tZxebvvzTJzJM7q3OnQU2Qqf+AAOskSJNvYhfAjyelCeUMxfxeVRI
         hfL+kFsplQNhzofFjtjFbzxjljjBcFFylxapxcwKdaNoVluD7wKZfZ/ejI6SNy7AQL
         V4yv4LoN5NKEdVdx+/KDHiXkfQOHQcHV982H6Dpi7M3LGvpfYFHuwiXAo6ugHPUFPG
         B2PvrNsV25UNjtfoe/y3o80Hr7P4Q+A2/AaodCae5bpstGCpQhNL/DhE/THcHg50bI
         GHv/uNoDgWHmZRZte0lmgPeTcVEzO+Vw6rkAnfoxBroX2t6ZXRdEOU/S37CoTwE3ab
         8SDDa24z8Ejcg==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Wed, 19 Jul 2023 06:32:19 -0400
Subject: [PATCH v2] ext4: fix the time handling macros when ext4 is using
 small inodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-ctime-v2-1-869825696d6d@kernel.org>
X-B4-Tracking: v=1; b=H4sIALO7t2QC/13MQQ7CIBCF4as0sxYDtLHUlfcwXTQwtBMVmqEhm
 oa7i126/F9evh0SMmGCa7MDY6ZEMdTQpwbsMoUZBbnaoKVuZa+MsBu9UHjVSTeh6c3goH5XRk/
 vw7mPtRdKW+TPwWb1W/+FrIQSukPth4uzzre3B3LA5znyDGMp5QsHdTpVmwAAAA==
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3364; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7FN/ypWIeSgyi8ApBs5nWT0Ilg5XTOBbZrV5mJSJyyw=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkt7vAzBi+zAX897ZWelbOkdfTYbZ/JT1pd38x6
 FBM1jXNaE+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLe7wAAKCRAADmhBGVaC
 FcmaEACVZiZeW7JHQxuTaGDfaSfR8AN5RMR1wORuY86l+h2mcwkx5BNzygqESBYtJfJ24Q920VT
 hTqcHDQ9xmeNWcY2HScds4u2P/8UIuuAmZtD4jRSvg4d47/N9b1x0wSvo5e1/9h3+1VqlkB6Go9
 32XeYJq/ikipeGc6QMyKpuV/WaTUZIwkimPk6WPFBGx5Kr4vUsrewru4pUtZ0BUbzOHxZpTgQbC
 7CStyhDScgm6TlFXCZF7fYJ89p5nJAIKjHga6oL/EI+3dIIyHmTSLzVed244JTIG40b3AO3IYiM
 ia9314jkxu+ue1Orenewgv4NaerbOFGtdlDe0GgAUGD9dMAe2gxFBC4W4eEDg96yO1oIc71xz8g
 vXwvyXsOMrjwMU9E2apDVh8tn5ntm2zF328t4/gCOtc6dtJ8670FMzKnmJPCeV7zSl8R3cNcOFN
 Q882mK7SI4j5vR8Exa3t755biZ7OamMtOejAjkO3PXLpDlcQVrRiuml2kAbHx4RywpU/1frxL3l
 MhHuaBpDfxPGT1VdQdHCIFsmwKVdF29hz194ZOOxhvpI4DOI6WIvNUGOT69ADn32k3s1xezk1i1
 s3CfOXtQW2iJyn8jXE1KvG17Pz83boHOQQPTI7YRLP6udpcH99gmidZtFdXqStPopdSWcy2CPiB
 wJ5dzr/5j+ouVaw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If ext4 is using small on-disk inodes, then it may not be able to store
fine grained timestamps. It also can't store the i_crtime at all in that
case since that fully lives in the extended part of the inode.

979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
still store the tv_sec field of the i_crtime into the raw_inode, even
when they were small, corrupting adjacent memory.

This fixes those macros to skip setting anything in the raw_inode if the
tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
the raw_inode doesn't support it.

Also, fix a bug in ctime handling during rename. It was updating the
renamed inode's ctime twice rather than the old directory.

Cc: Jan Kara <jack@suse.cz>
Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
Reported-by: Hugh Dickins <hughd@google.com>
Tested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- also fix incorrect ctime update in ext4_rename
---
 fs/ext4/ext4.h  | 17 ++++++++++++-----
 fs/ext4/namei.c |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2af347669db7..1e2259d9967d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -900,8 +900,10 @@ do {										\
 #define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
 	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
 
-#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einode)->xtime)
+#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))			\
+		EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode),		\
+					 raw_inode, (einode)->xtime)
 
 #define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
 	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
@@ -922,9 +924,14 @@ do {										\
 		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
 } while (0)
 
-#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
-do {									       \
-	(einode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode), raw_inode);	\
+#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)				\
+do {										\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime)) 			\
+		(einode)->xtime =						\
+			EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),	\
+						 raw_inode);			\
+	else									\
+		(einode)->xtime = (struct timespec64){0, 0};			\
 } while (0)
 
 #define i_disk_version osd1.linux1.l_i_version
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 07f6d96ebc60..933ad03f4f58 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3957,7 +3957,7 @@ static int ext4_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		ext4_dec_count(new.inode);
 		inode_set_ctime_current(new.inode);
 	}
-	old.dir->i_mtime = inode_set_ctime_current(old.inode);
+	old.dir->i_mtime = inode_set_ctime_current(old.dir);
 	ext4_update_dx_flag(old.dir);
 	if (old.dir_bh) {
 		retval = ext4_rename_dir_finish(handle, &old, new.dir->i_ino);

---
base-commit: c62e19541f8bb39f1f340247f651afe4532243df
change-id: 20230718-ctime-f140dae8789d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

