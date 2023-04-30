Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E2D6F28B6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 14:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbjD3MNX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 08:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjD3MNK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:13:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD2D19A2;
        Sun, 30 Apr 2023 05:13:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74C4760B47;
        Sun, 30 Apr 2023 12:13:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F16C433D2;
        Sun, 30 Apr 2023 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682856787;
        bh=YZo0radRhw7c6WXwv3dQGDwj2+t/0O6Bwt6ngQV31VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OngSO29Px5ZBkh+HrtlyPFLfng0bS7J00AAx0ZhFXDvoW7Qkwfugo2IucklKNXgNL
         J/d4hHKQbwHDP7Z1blmdC4DEAcuqWWQMjyYu2aDt4T7Gm6CdQg3sRyl/Ls0pnC8UyH
         t0OCm0yzRtTMsmGXN0gNhhEwVknFBpbFXynIi1MABneqBUJGcGYvXAVmJk4VdQzfpC
         S71vfEy1w8CWopylITsZzebtb07iXRih+jy87quRrwMEpz9k2sGXjjxK50F01huqEY
         A7HgZxJzdsSGK/1TSEfI9EaJ6oIaW3MbIteyokELFzlGIcp4hAQiiIelq5s7HqfX78
         Irf0D7fzXSnlA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>,
        syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, willy@infradead.org,
        dchinner@redhat.com, akpm@linux-foundation.org, jlayton@kernel.org,
        gargaditya08@live.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 2/2] fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()
Date:   Sun, 30 Apr 2023 08:12:58 -0400
Message-Id: <20230430121301.3197608-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230430121301.3197608-1-sashal@kernel.org>
References: <20230430121301.3197608-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 81b21c0f0138ff5a499eafc3eb0578ad2a99622c ]

syzbot is hitting WARN_ON() in hfsplus_cat_{read,write}_inode(), for
crafted filesystem image can contain bogus length. There conditions are
not kernel bugs that can justify kernel to panic.

Reported-by: syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=e2787430e752a92b8750
Reported-by: syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=4913dca2ea6e4d43f3f1
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Message-Id: <15308173-5252-d6a3-ae3b-e96d46cb6f41@I-love.SAKURA.ne.jp>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/inode.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index abb91f5fae921..b21660475ac1c 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -511,7 +511,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	if (type == HFSPLUS_FOLDER) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_folder));
+		if (fd->entrylength < sizeof(struct hfsplus_cat_folder)) {
+			pr_err("bad catalog folder entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		hfsplus_get_perms(inode, &folder->permissions, 1);
@@ -531,7 +535,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 	} else if (type == HFSPLUS_FILE) {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		WARN_ON(fd->entrylength < sizeof(struct hfsplus_cat_file));
+		if (fd->entrylength < sizeof(struct hfsplus_cat_file)) {
+			pr_err("bad catalog file entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_file));
 
@@ -562,6 +570,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
 	}
+out:
 	return res;
 }
 
@@ -570,6 +579,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int res = 0;
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -588,7 +598,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	if (S_ISDIR(main_inode->i_mode)) {
 		struct hfsplus_cat_folder *folder = &entry.folder;
 
-		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_folder));
+		if (fd.entrylength < sizeof(struct hfsplus_cat_folder)) {
+			pr_err("bad catalog folder entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_folder));
 		/* simple node checks? */
@@ -613,7 +627,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	} else {
 		struct hfsplus_cat_file *file = &entry.file;
 
-		WARN_ON(fd.entrylength < sizeof(struct hfsplus_cat_file));
+		if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
+			pr_err("bad catalog file entry\n");
+			res = -EIO;
+			goto out;
+		}
 		hfs_bnode_read(fd.bnode, &entry, fd.entryoffset,
 					sizeof(struct hfsplus_cat_file));
 		hfsplus_inode_write_fork(inode, &file->data_fork);
@@ -634,7 +652,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
-	return 0;
+	return res;
 }
 
 int hfsplus_fileattr_get(struct dentry *dentry, struct fileattr *fa)
-- 
2.39.2

