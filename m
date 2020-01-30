Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ADF14E014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2020 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgA3Rkg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jan 2020 12:40:36 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:42072 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727338AbgA3Rkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jan 2020 12:40:36 -0500
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 63F0B2E0B08;
        Thu, 30 Jan 2020 20:40:33 +0300 (MSK)
Received: from sas2-3e4aeb094591.qloud-c.yandex.net (sas2-3e4aeb094591.qloud-c.yandex.net [2a02:6b8:c08:7192:0:640:3e4a:eb09])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id mqW3b6Lca6-eWTaaVO9;
        Thu, 30 Jan 2020 20:40:33 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1580406033; bh=/got7Z3qycrqTTk+tiv1bc/LrUiuOOA3UhP7opTXETI=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=dHlID4FtgEDazo+UrDlW3Koz7evl3q653aJxElIXv4TNyZfOxozsreA6mfmkH4Juz
         iiNkEzwZT2TFR4SRtf7vYOIxpwnyvRinO8e3nosaSyNvlwhSRVbP5SjXDFF6h5MknB
         psJborghT2T9wr/GJeW79EHMiExIN8baJjexx8QM=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by sas2-3e4aeb094591.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id xaTvSgbfYz-eWWaMrmA;
        Thu, 30 Jan 2020 20:40:32 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH v2 1/2] vfs: add non-blocking mode for function
 find_inode_nowait()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Thu, 30 Jan 2020 20:40:32 +0300
Message-ID: <158040603214.1879.6549790415691475804.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently concurrent inode lookup by number does not scale well because
inode hash table is protected with single spinlock. Someday inode hash
will become searchable under RCU (see linked patchset by David Howells).

For now main user of this function: ext4_update_other_inodes_time()
could live with optimistic non-blocking try-lock/try-find semantics.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Link: https://lore.kernel.org/lkml/158031264567.6836.126132376018905207.stgit@buzz/T/#m83e4432ea81bc6c0ec0d1cca87e97bd89ff671d9
Link: https://lore.kernel.org/lkml/155620449631.4720.8762546550728087460.stgit@warthog.procyon.org.uk/ (RCU)
---
 fs/ext4/inode.c    |    2 +-
 fs/f2fs/node.c     |    2 +-
 fs/inode.c         |    9 +++++++--
 include/linux/fs.h |    2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 629a25d999f0..9512eb771820 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4865,7 +4865,7 @@ static void ext4_update_other_inodes_time(struct super_block *sb,
 		if (ino == orig_ino)
 			continue;
 		oi.raw_inode = (struct ext4_inode *) buf;
-		(void) find_inode_nowait(sb, ino, other_inode_match, &oi);
+		(void)find_inode_nowait(sb, ino, other_inode_match, &oi, false);
 	}
 }
 
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3314a0f3405e..1b8515e4f451 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1793,7 +1793,7 @@ static bool flush_dirty_inode(struct page *page)
 	struct inode *inode;
 	nid_t ino = ino_of_node(page);
 
-	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL);
+	inode = find_inode_nowait(sbi->sb, ino, f2fs_match_ino, NULL, false);
 	if (!inode)
 		return false;
 
diff --git a/fs/inode.c b/fs/inode.c
index ea15c6d9f274..6e52ee027b88 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1411,6 +1411,7 @@ EXPORT_SYMBOL(ilookup);
  * @hashval:	hash value (usually inode number) to search for
  * @match:	callback used for comparisons between inodes
  * @data:	opaque data pointer to pass to @match
+ * @nonblock:	if true do not wait for lock and fail with EAGAIN
  *
  * Search for the inode specified by @hashval and @data in the inode
  * cache, where the helper function @match will return 0 if the inode
@@ -1432,13 +1433,17 @@ struct inode *find_inode_nowait(struct super_block *sb,
 				unsigned long hashval,
 				int (*match)(struct inode *, unsigned long,
 					     void *),
-				void *data)
+				void *data, bool nonblock)
 {
 	struct hlist_head *head = inode_hashtable + hash(sb, hashval);
 	struct inode *inode, *ret_inode = NULL;
 	int mval;
 
-	spin_lock(&inode_hash_lock);
+	if (!nonblock)
+		spin_lock(&inode_hash_lock);
+	else if (!spin_trylock(&inode_hash_lock))
+		return ERR_PTR(-EAGAIN);
+
 	hlist_for_each_entry(inode, head, i_hash) {
 		if (inode->i_sb != sb)
 			continue;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 40be2ccb87f3..8eef77dbf0af 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3039,7 +3039,7 @@ extern struct inode *find_inode_nowait(struct super_block *,
 				       unsigned long,
 				       int (*match)(struct inode *,
 						    unsigned long, void *),
-				       void *data);
+				       void *data, bool nonblock);
 extern int insert_inode_locked4(struct inode *, unsigned long, int (*test)(struct inode *, void *), void *);
 extern int insert_inode_locked(struct inode *);
 #ifdef CONFIG_DEBUG_LOCK_ALLOC

