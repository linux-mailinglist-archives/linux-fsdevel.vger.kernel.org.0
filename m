Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87696F28D3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 30 Apr 2023 14:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjD3MOx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 30 Apr 2023 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbjD3MO1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 30 Apr 2023 08:14:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD9E35A9;
        Sun, 30 Apr 2023 05:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291B361358;
        Sun, 30 Apr 2023 12:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2494AC433EF;
        Sun, 30 Apr 2023 12:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682856831;
        bh=6oshVciF23uQHCikDHNmKnGQsl2XchcwdwEeZTu0m3Y=;
        h=From:To:Cc:Subject:Date:From;
        b=gRLYYP8TjNVj60BaMA/mtfRupit9Wf4tOMFGHSKOnpcNo/yJ56nNn7zOBGtdx3J+G
         YvJYbUsXZoTXAn7PzWaVxPfJSW+gyU9EZG0tYi8yw9vOyTZ7RjB5Oa0ALS3SZfZZmh
         GixypqYr9CoEmk20YJOdj52bGvDMURvjzXcV/OIbtgbECrTwVYjMQVzIE39luRRPVS
         KpKcZG/GzMru8LzjPqygx80amC98OFCjyrCUx1flK8NeyyQlKPC2Gwmr2LdumzC/jX
         jt8TmGVIM5B3yw3ydqz8EYMs6kxUEmMuKR9XWBrj+asAXh2QwxJw/ZOAIR9dnJcgZq
         Tb6FjchS/c5lg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+e2787430e752a92b8750@syzkaller.appspotmail.com>,
        syzbot <syzbot+4913dca2ea6e4d43f3f1@syzkaller.appspotmail.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Christian Brauner <brauner@kernel.org>,
        Sasha Levin <sashal@kernel.org>, willy@infradead.org,
        dchinner@redhat.com, jlayton@kernel.org, akpm@linux-foundation.org,
        gargaditya08@live.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14] fs: hfsplus: remove WARN_ON() from hfsplus_cat_{read,write}_inode()
Date:   Sun, 30 Apr 2023 08:13:46 -0400
Message-Id: <20230430121348.3197920-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
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
index ccb2a94c2032a..4924a489c8ac0 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -488,7 +488,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
@@ -508,7 +512,11 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
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
 
@@ -539,6 +547,7 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		pr_err("bad catalog entry used to create inode\n");
 		res = -EIO;
 	}
+out:
 	return res;
 }
 
@@ -547,6 +556,7 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	struct inode *main_inode = inode;
 	struct hfs_find_data fd;
 	hfsplus_cat_entry entry;
+	int res = 0;
 
 	if (HFSPLUS_IS_RSRC(inode))
 		main_inode = HFSPLUS_I(inode)->rsrc_inode;
@@ -565,7 +575,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -590,7 +604,11 @@ int hfsplus_cat_write_inode(struct inode *inode)
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
@@ -611,5 +629,5 @@ int hfsplus_cat_write_inode(struct inode *inode)
 	set_bit(HFSPLUS_I_CAT_DIRTY, &HFSPLUS_I(inode)->flags);
 out:
 	hfs_find_exit(&fd);
-	return 0;
+	return res;
 }
-- 
2.39.2

