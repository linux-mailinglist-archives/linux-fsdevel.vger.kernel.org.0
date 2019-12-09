Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7126116BF8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbfLILK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:27 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60138 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILK1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LUz+cAr0Stzh5w9hHVjSPpn0r9OSUIll80xXlRjDBuI=; b=TYkJwxpvMf9MSKucGlP74VzkuW
        X14ncXIeEy9rGPl/3HcjUXeoZ8UNY81T/Nv2Ylo08wBbsuTOfvgxb4+8Y+0cr3xmaku5Hj2/e7QBe
        9zMA9ON0eeY5a9Kkp7Xi67ZwB3SG7J/ptYBzA9Rct5ocSIoAV5U7qzrVwSma22/l/K9c90VFcv5u/
        b9cqsWTWSqAwjvF58fhgdeYfLQHFr07QRzFSnmX7rMwgKvJVzqp13nLeAm4mpEw/achpzVYzJCfIm
        kh9RkHmZUbEZ59Ygqj5kB3kQt6mRlbtJkLRwoCL5qUKeeVMUZEeTVdWGBsjgzJi4gimX2uIQwCCva
        nOLzG5bg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54088 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvn-0002WF-8n; Mon, 09 Dec 2019 11:10:23 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvl-0004cQ-UR; Mon, 09 Dec 2019 11:10:21 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/41] fs/adfs: dir: use pointers to access directory
 head/tails
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvl-0004cQ-UR@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:21 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add and use pointers in the adfs_dir structure to access the directory
head and tail structures, which will always be contiguous in a buffer.
This allows us to avoid memcpy()ing the data in the new directory code,
making it slightly more efficient.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      | 12 ++++++++----
 fs/adfs/dir_f.c     | 42 +++++++++++++++++-------------------------
 fs/adfs/dir_fplus.c | 11 ++++-------
 3 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index cbf33f375e0b..1f431a42e14c 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -26,8 +26,6 @@ static inline u16 adfs_filetype(u32 loadaddr)
 #define ADFS_NDA_PUBLIC_READ	(1 << 5)
 #define ADFS_NDA_PUBLIC_WRITE	(1 << 6)
 
-#include "dir_f.h"
-
 /*
  * adfs file system inode data in memory
  */
@@ -98,8 +96,14 @@ struct adfs_dir {
 	unsigned int		pos;
 	__u32			parent_id;
 
-	struct adfs_dirheader	dirhead;
-	union  adfs_dirtail	dirtail;
+	union {
+		struct adfs_dirheader	*dirhead;
+		struct adfs_bigdirheader *bighead;
+	};
+	union {
+		struct adfs_newdirtail	*newtail;
+		struct adfs_bigdirtail	*bigtail;
+	};
 };
 
 /*
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 2e342871d6df..7e56fcc21303 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -58,7 +58,7 @@ static inline void adfs_writeval(unsigned char *p, int len, unsigned int val)
 #define bufoff(_bh,_idx)			\
 	({ int _buf = _idx >> blocksize_bits;	\
 	   int _off = _idx - (_buf << blocksize_bits);\
-	  (u8 *)(_bh[_buf]->b_data + _off);	\
+	  (void *)(_bh[_buf]->b_data + _off);	\
 	})
 
 /*
@@ -139,18 +139,18 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	if (ret)
 		return ret;
 
-	memcpy(&dir->dirhead, bufoff(dir->bh, 0), sizeof(dir->dirhead));
-	memcpy(&dir->dirtail, bufoff(dir->bh, 2007), sizeof(dir->dirtail));
+	dir->dirhead = bufoff(dir->bh, 0);
+	dir->newtail = bufoff(dir->bh, 2007);
 
-	if (dir->dirhead.startmasseq != dir->dirtail.new.endmasseq ||
-	    memcmp(&dir->dirhead.startname, &dir->dirtail.new.endname, 4))
+	if (dir->dirhead->startmasseq != dir->newtail->endmasseq ||
+	    memcmp(&dir->dirhead->startname, &dir->newtail->endname, 4))
 		goto bad_dir;
 
-	if (memcmp(&dir->dirhead.startname, "Nick", 4) &&
-	    memcmp(&dir->dirhead.startname, "Hugo", 4))
+	if (memcmp(&dir->dirhead->startname, "Nick", 4) &&
+	    memcmp(&dir->dirhead->startname, "Hugo", 4))
 		goto bad_dir;
 
-	if (adfs_dir_checkbyte(dir) != dir->dirtail.new.dircheckbyte)
+	if (adfs_dir_checkbyte(dir) != dir->newtail->dircheckbyte)
 		goto bad_dir;
 
 	return 0;
@@ -275,7 +275,7 @@ static int adfs_f_read(struct super_block *sb, u32 indaddr, unsigned int size,
 	if (ret)
 		adfs_error(sb, "unable to read directory");
 	else
-		dir->parent_id = adfs_readval(dir->dirtail.new.dirparent, 3);
+		dir->parent_id = adfs_readval(dir->newtail->dirparent, 3);
 
 	return ret;
 }
@@ -322,7 +322,6 @@ static int adfs_f_iterate(struct adfs_dir *dir, struct dir_context *ctx)
 static int
 adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 {
-	struct super_block *sb = dir->sb;
 	int ret;
 
 	ret = adfs_dir_find_entry(dir, obj->indaddr);
@@ -336,33 +335,26 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 	/*
 	 * Increment directory sequence number
 	 */
-	dir->bh[0]->b_data[0] += 1;
-	dir->bh[dir->nr_buffers - 1]->b_data[sb->s_blocksize - 6] += 1;
+	dir->dirhead->startmasseq += 1;
+	dir->newtail->endmasseq += 1;
 
 	ret = adfs_dir_checkbyte(dir);
 	/*
 	 * Update directory check byte
 	 */
-	dir->bh[dir->nr_buffers - 1]->b_data[sb->s_blocksize - 1] = ret;
+	dir->newtail->dircheckbyte = ret;
 
 #if 1
-	{
-	const unsigned int blocksize_bits = sb->s_blocksize_bits;
-
-	memcpy(&dir->dirhead, bufoff(dir->bh, 0), sizeof(dir->dirhead));
-	memcpy(&dir->dirtail, bufoff(dir->bh, 2007), sizeof(dir->dirtail));
-
-	if (dir->dirhead.startmasseq != dir->dirtail.new.endmasseq ||
-	    memcmp(&dir->dirhead.startname, &dir->dirtail.new.endname, 4))
+	if (dir->dirhead->startmasseq != dir->newtail->endmasseq ||
+	    memcmp(&dir->dirhead->startname, &dir->newtail->endname, 4))
 		goto bad_dir;
 
-	if (memcmp(&dir->dirhead.startname, "Nick", 4) &&
-	    memcmp(&dir->dirhead.startname, "Hugo", 4))
+	if (memcmp(&dir->dirhead->startname, "Nick", 4) &&
+	    memcmp(&dir->dirhead->startname, "Hugo", 4))
 		goto bad_dir;
 
-	if (adfs_dir_checkbyte(dir) != dir->dirtail.new.dircheckbyte)
+	if (adfs_dir_checkbyte(dir) != dir->newtail->dircheckbyte)
 		goto bad_dir;
-	}
 #endif
 	ret = 0;
 out:
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index edcbaa94ecb9..6f2dbcf6819b 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -20,7 +20,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 	if (ret)
 		return ret;
 
-	h = (struct adfs_bigdirheader *)dir->bhs[0]->b_data;
+	dir->bighead = h = (void *)dir->bhs[0]->b_data;
 	dirsize = le32_to_cpu(h->bigdirsize);
 	if (dirsize != size) {
 		adfs_msg(sb, KERN_WARNING,
@@ -40,7 +40,7 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 	if (ret)
 		return ret;
 
-	t = (struct adfs_bigdirtail *)
+	dir->bigtail = t = (struct adfs_bigdirtail *)
 		(dir->bhs[dir->nr_buffers - 1]->b_data + (sb->s_blocksize - 8));
 
 	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
@@ -62,11 +62,9 @@ static int adfs_fplus_read(struct super_block *sb, u32 indaddr,
 static int
 adfs_fplus_setpos(struct adfs_dir *dir, unsigned int fpos)
 {
-	struct adfs_bigdirheader *h =
-		(struct adfs_bigdirheader *) dir->bhs[0]->b_data;
 	int ret = -ENOENT;
 
-	if (fpos <= le32_to_cpu(h->bigdirentries)) {
+	if (fpos <= le32_to_cpu(dir->bighead->bigdirentries)) {
 		dir->pos = fpos;
 		ret = 0;
 	}
@@ -77,8 +75,7 @@ adfs_fplus_setpos(struct adfs_dir *dir, unsigned int fpos)
 static int
 adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 {
-	struct adfs_bigdirheader *h =
-		(struct adfs_bigdirheader *) dir->bhs[0]->b_data;
+	struct adfs_bigdirheader *h = dir->bighead;
 	struct adfs_bigdirentry bde;
 	unsigned int offset;
 	int ret;
-- 
2.20.1

