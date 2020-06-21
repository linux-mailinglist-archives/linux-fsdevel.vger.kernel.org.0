Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8987202841
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 06:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgFUEI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 00:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFUEI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:08:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F52AC061794;
        Sat, 20 Jun 2020 21:08:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so15662355ljb.12;
        Sat, 20 Jun 2020 21:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6IUbkBnWOtZ2ZLtMr58WIx6sB7xLbmM+dOtzNdDwOg=;
        b=nCZL4mVbwD+nhFJxTc8ZL5YV6RtGHwwWwzR7HHkyVAUcsh5kepXNKoOM8AG08z6Gbo
         MYTSUhFED1lpqk3P+GQuSc+Gu6zZ7H6/WF50l3u8GP/Es0f8hhQHGdlqsdsZYeBRYGnJ
         BiNwLAGDTKDx4ZzX/yAVL7QFl/IdaXQRwVf3KAtlXvSTtgKqTx8Pzuy7o2O84Y/c3v8p
         9DbG0Y3b2QASvG88mvNVezZ3YXhFNSMDd/RizPVbEvMrV8zqkiOlE07NURKuXNG5vkNA
         Xl42G9y5+aoiOSTVqtAaYKrjNcps2be0ZXvN0RjAgeWtio/9ZIELKZPacaITPHUD+Ngz
         XmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A6IUbkBnWOtZ2ZLtMr58WIx6sB7xLbmM+dOtzNdDwOg=;
        b=e2CK5A0mFFF1uykjqvgLETAUOHjdl7nV9Ll7oWGJ2sHs0hUY21P1qZlLva62H38W66
         vT+XfqiorRzkJOXiD5Gvdd4592mhu4NDhYvS6cZ2AQAAYiUDhgS7KvbsyrVvOBIH2OS0
         /IxTNWHvlMeG9ulGkCaUxUSaPRoU2KtT1guZMrYi6vb8IKbXN3u4pJJ8jyJ7j6YOpHTX
         f0h9J3E+DA1hvdk2ZVtiBLQoE5PjXP72I9IqhNcfBgze1Wb0ocAmI6+8m+3Z/9mDrQcq
         3sG6T/RnnBqcJAy3cWkOS1s/TTihhHnR30kuMBfFwesBgh7WnooIRvpMlqrjFQ2A2OCZ
         kHgw==
X-Gm-Message-State: AOAM531/h6e/kYr8X/3fuozd6vb09gUt8XJEBs8FYR/4btVAJcvMX41p
        R+0+aQanvaNuo4FjitlfeRGw/mAzbyA=
X-Google-Smtp-Source: ABdhPJzuICxb9jyS9nMxhY9JIkZDwCNjqCfpSj1M0/9uKtVWc5JrHNYw5be9QSWYVNJduCsBU8WzXg==
X-Received: by 2002:a2e:b4eb:: with SMTP id s11mr5522210ljm.452.1592712536564;
        Sat, 20 Jun 2020 21:08:56 -0700 (PDT)
Received: from localhost.localdomain ([178.150.133.249])
        by smtp.gmail.com with ESMTPSA id n25sm1928930lfe.39.2020.06.20.21.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 21:08:55 -0700 (PDT)
From:   Egor Chelak <egor.chelak@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Egor Chelak <egor.chelak@gmail.com>
Subject: [PATCH] isofs: fix High Sierra dirent flag accesses
Date:   Sun, 21 Jun 2020 07:08:17 +0300
Message-Id: <20200621040817.3388-1-egor.chelak@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The flags byte of the dirent was accessed as de->flags[0] in a couple of
places, and not as de->flags[-sbi->s_high_sierra], which is how it's
accessed elsewhere. This caused a bug, where some files on an HSF disc
could be inaccessible.

For context, here is the difference between HSF dirents and ISO dirents:
Offset  | High Sierra | ISO-9660       | struct iso_directory_record
Byte 24 | Flags       | mtime timezone | de->date[6] (de->flags[-1])
Byte 25 | Reserved    | Flags          | de->flags[0]

In a particular HSF disc image that I have, the reserved byte is
arbitrary. Some regular files ended up having the directory bit (0x02)
set in the reserved byte. isofs_normalize_block_and_offset would
interpret that byte as the flags byte, and try to normalize the dirent
as if it was pointing to a directory. Then, when the file is looked up,
its inode gets filled with garbage data (file contents interpreted as
directory entry), making it unreadable.

Signed-off-by: Egor Chelak <egor.chelak@gmail.com>
---
 fs/isofs/dir.c    | 6 ++++--
 fs/isofs/export.c | 6 +++++-
 fs/isofs/isofs.h  | 5 +++--
 fs/isofs/namei.c  | 3 ++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/isofs/dir.c b/fs/isofs/dir.c
index f0fe641893a5..5171dbbcda81 100644
--- a/fs/isofs/dir.c
+++ b/fs/isofs/dir.c
@@ -50,6 +50,7 @@ int isofs_name_translate(struct iso_directory_record *de, char *new, struct inod
 int get_acorn_filename(struct iso_directory_record *de,
 			    char *retname, struct inode *inode)
 {
+	struct isofs_sb_info *sbi = ISOFS_SB(inode->i_sb);
 	int std;
 	unsigned char *chr;
 	int retnamlen = isofs_name_translate(de, retname, inode);
@@ -66,7 +67,7 @@ int get_acorn_filename(struct iso_directory_record *de,
 		return retnamlen;
 	if ((*retname == '_') && ((chr[19] & 1) == 1))
 		*retname = '!';
-	if (((de->flags[0] & 2) == 0) && (chr[13] == 0xff)
+	if (((de->flags[-sbi->s_high_sierra] & 2) == 0) && (chr[13] == 0xff)
 		&& ((chr[12] & 0xf0) == 0xf0)) {
 		retname[retnamlen] = ',';
 		sprintf(retname+retnamlen+1, "%3.3x",
@@ -158,7 +159,8 @@ static int do_isofs_readdir(struct inode *inode, struct file *file,
 		if (first_de) {
 			isofs_normalize_block_and_offset(de,
 							&block_saved,
-							&offset_saved);
+							&offset_saved,
+							sbi->s_high_sierra);
 			inode_number = isofs_get_ino(block_saved,
 							offset_saved, bufbits);
 		}
diff --git a/fs/isofs/export.c b/fs/isofs/export.c
index 35768a63fb1d..8a8aa442ab82 100644
--- a/fs/isofs/export.c
+++ b/fs/isofs/export.c
@@ -50,6 +50,7 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 	struct iso_directory_record *de = NULL;
 	struct buffer_head * bh = NULL;
 	struct dentry *rv = NULL;
+	struct isofs_sb_info *sbi = ISOFS_SB(child_inode->i_sb);
 
 	/* "child" must always be a directory. */
 	if (!S_ISDIR(child_inode->i_mode)) {
@@ -97,7 +98,10 @@ static struct dentry *isofs_export_get_parent(struct dentry *child)
 	}
 
 	/* Normalize */
-	isofs_normalize_block_and_offset(de, &parent_block, &parent_offset);
+	isofs_normalize_block_and_offset(de,
+					 &parent_block,
+					 &parent_offset,
+					 sbi->s_high_sierra);
 
 	rv = d_obtain_alias(isofs_iget(child_inode->i_sb, parent_block,
 				     parent_offset));
diff --git a/fs/isofs/isofs.h b/fs/isofs/isofs.h
index 055ec6c586f7..5c3b8f065a9a 100644
--- a/fs/isofs/isofs.h
+++ b/fs/isofs/isofs.h
@@ -186,10 +186,11 @@ static inline unsigned long isofs_get_ino(unsigned long block,
 static inline void
 isofs_normalize_block_and_offset(struct iso_directory_record* de,
 				 unsigned long *block,
-				 unsigned long *offset)
+				 unsigned long *offset,
+				 int high_sierra)
 {
 	/* Only directories are normalized. */
-	if (de->flags[0] & 2) {
+	if (de->flags[-high_sierra] & 2) {
 		*offset = 0;
 		*block = (unsigned long)isonum_733(de->extent)
 			+ (unsigned long)isonum_711(de->ext_attr_length);
diff --git a/fs/isofs/namei.c b/fs/isofs/namei.c
index cac468f04820..d732964755f4 100644
--- a/fs/isofs/namei.c
+++ b/fs/isofs/namei.c
@@ -138,7 +138,8 @@ isofs_find_entry(struct inode *dir, struct dentry *dentry,
 		if (match) {
 			isofs_normalize_block_and_offset(de,
 							 &block_saved,
-							 &offset_saved);
+							 &offset_saved,
+							 sbi->s_high_sierra);
 			*block_rv = block_saved;
 			*offset_rv = offset_saved;
 			brelse(bh);
-- 
2.27.0

