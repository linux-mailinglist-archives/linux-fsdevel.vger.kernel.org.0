Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 252273495D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFDNuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:03 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40260 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o5h1OkdKWsq2yfl/iKGYQEqeM4oxfXsMPXJGRdy1oKw=; b=gmbENgg6eMAao/+M91B4Rw0LnP
        IHu2h9DX3TS+ago3RcADJVq7QKuX4eDAssltxsDYxhBCTUyHCtXvY64FWTlBMM5nr1RUnUVNN/fkS
        lKLmuKDNVHj73iVtxc8mgO5wHCBDvCxCLUlSoq66Q1EjphaTnweDNmuxRw5CEUizaMM1tTtsbkoep
        6JR+YJ2+V+QFtIlyVug1qPeDyU4XdMgsUYcE9gXVAzlPcHVx3zALGtJI91eUMy2EOZqik+n7nJt95
        Elf+oR3n/ik1HB0a8bQGUnAynqB10KRfZtbPO56IvKqTBlINySxu+CI9Z7GEW30xPz0UFcheiEZOa
        c2JIyCWg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:34316 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9p8-0001bZ-Op; Tue, 04 Jun 2019 14:49:58 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9p7-000855-Qe; Tue, 04 Jun 2019 14:49:58 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] fs/adfs: clean up indirect disc addresses and fragment
 IDs
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9p7-000855-Qe@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:57 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use a variety of different names for the indirect disc address of
the current object, use a variety of different types, and print it in
a variety of different ways. Bring some consistency to this by naming
it "indaddr", use u32 or __u32 as the type since it fits in 32-bits,
and always print it with %06x (with no leading hex prefix.)

When printing it was a directory identifer, use "dir %06x" otherwise
use "object %06x".

Do the same for fragment IDs and the parent indirect disc addresses.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      | 22 +++++++++++-----------
 fs/adfs/dir.c       |  9 +++++----
 fs/adfs/dir_f.c     | 37 ++++++++++++++++---------------------
 fs/adfs/dir_fplus.c |  2 +-
 fs/adfs/inode.c     |  4 ++--
 fs/adfs/map.c       | 14 +++++---------
 fs/adfs/super.c     |  2 +-
 7 files changed, 41 insertions(+), 49 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 1e8865588a59..9eb9bea1cef2 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -24,7 +24,7 @@
  */
 struct adfs_inode_info {
 	loff_t		mmu_private;
-	unsigned long	parent_id;	/* object id of parent		*/
+	__u32		parent_id;	/* parent indirect disc address	*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
 	unsigned int	filetype;	/* RISC OS file type		*/
@@ -86,7 +86,7 @@ struct adfs_dir {
 	struct buffer_head	**bh_fplus;
 
 	unsigned int		pos;
-	unsigned int		parent_id;
+	__u32			parent_id;
 
 	struct adfs_dirheader	dirhead;
 	union  adfs_dirtail	dirtail;
@@ -98,7 +98,7 @@ struct adfs_dir {
 #define ADFS_MAX_NAME_LEN	(256 + 4) /* +4 for ,xyz hex filetype suffix */
 struct object_info {
 	__u32		parent_id;		/* parent object id	*/
-	__u32		file_id;		/* object id		*/
+	__u32		indaddr;		/* indirect disc addr	*/
 	__u32		loadaddr;		/* load address		*/
 	__u32		execaddr;		/* execution address	*/
 	__u32		size;			/* size			*/
@@ -111,7 +111,8 @@ struct object_info {
 };
 
 struct adfs_dir_ops {
-	int	(*read)(struct super_block *sb, unsigned int id, unsigned int sz, struct adfs_dir *dir);
+	int	(*read)(struct super_block *sb, unsigned int indaddr,
+			unsigned int size, struct adfs_dir *dir);
 	int	(*setpos)(struct adfs_dir *dir, unsigned int fpos);
 	int	(*getnext)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*update)(struct adfs_dir *dir, struct object_info *obj);
@@ -134,7 +135,7 @@ int adfs_write_inode(struct inode *inode, struct writeback_control *wbc);
 int adfs_notify_change(struct dentry *dentry, struct iattr *attr);
 
 /* map.c */
-extern int adfs_map_lookup(struct super_block *sb, unsigned int frag_id, unsigned int offset);
+int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset);
 extern unsigned int adfs_map_free(struct super_block *sb);
 
 /* Misc */
@@ -180,18 +181,17 @@ static inline __u32 signed_asl(__u32 val, signed int shift)
  *
  * The root directory ID should always be looked up in the map [3.4]
  */
-static inline int
-__adfs_block_map(struct super_block *sb, unsigned int object_id,
-		 unsigned int block)
+static inline int __adfs_block_map(struct super_block *sb, u32 indaddr,
+				   unsigned int block)
 {
-	if (object_id & 255) {
+	if (indaddr & 255) {
 		unsigned int off;
 
-		off = (object_id & 255) - 1;
+		off = (indaddr & 255) - 1;
 		block += off << ADFS_SB(sb)->s_log2sharesize;
 	}
 
-	return adfs_map_lookup(sb, object_id >> 8, block);
+	return adfs_map_lookup(sb, indaddr >> 8, block);
 }
 
 /* Return the disc record from the map */
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index fe39310c1a0a..01ffd47c7461 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -95,7 +95,7 @@ adfs_readdir(struct file *file, struct dir_context *ctx)
 		goto unlock_out;
 	while (ops->getnext(&dir, &obj) == 0) {
 		if (!dir_emit(ctx, obj.name, obj.name_len,
-			    obj.file_id, DT_UNKNOWN))
+			      obj.indaddr, DT_UNKNOWN))
 			break;
 		ctx->pos++;
 	}
@@ -116,8 +116,8 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	const struct adfs_dir_ops *ops = ADFS_SB(sb)->s_dir;
 	struct adfs_dir dir;
 
-	printk(KERN_INFO "adfs_dir_update: object %06X in dir %06X\n",
-		 obj->file_id, obj->parent_id);
+	printk(KERN_INFO "adfs_dir_update: object %06x in dir %06x\n",
+		 obj->indaddr, obj->parent_id);
 
 	if (!ops->update) {
 		ret = -EINVAL;
@@ -181,7 +181,8 @@ static int adfs_dir_lookup_byname(struct inode *inode, const struct qstr *qstr,
 		goto out;
 
 	if (ADFS_I(inode)->parent_id != dir.parent_id) {
-		adfs_error(sb, "parent directory changed under me! (%lx but got %x)\n",
+		adfs_error(sb,
+			   "parent directory changed under me! (%06x but got %06x)\n",
 			   ADFS_I(inode)->parent_id, dir.parent_id);
 		ret = -EIO;
 		goto free_out;
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 811f36aaa700..1eb82a4de655 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -120,12 +120,9 @@ adfs_dir_checkbyte(const struct adfs_dir *dir)
 	return (dircheck ^ (dircheck >> 8) ^ (dircheck >> 16) ^ (dircheck >> 24)) & 0xff;
 }
 
-/*
- * Read and check that a directory is valid
- */
-static int
-adfs_dir_read(struct super_block *sb, unsigned long object_id,
-	      unsigned int size, struct adfs_dir *dir)
+/* Read and check that a directory is valid */
+static int adfs_dir_read(struct super_block *sb, u32 indaddr,
+			 unsigned int size, struct adfs_dir *dir)
 {
 	const unsigned int blocksize_bits = sb->s_blocksize_bits;
 	int blk = 0;
@@ -145,10 +142,10 @@ adfs_dir_read(struct super_block *sb, unsigned long object_id,
 	for (blk = 0; blk < size; blk++) {
 		int phys;
 
-		phys = __adfs_block_map(sb, object_id, blk);
+		phys = __adfs_block_map(sb, indaddr, blk);
 		if (!phys) {
-			adfs_error(sb, "dir object %lX has a hole at offset %d",
-				   object_id, blk);
+			adfs_error(sb, "dir %06x has a hole at offset %d",
+				   indaddr, blk);
 			goto release_buffers;
 		}
 
@@ -176,8 +173,7 @@ adfs_dir_read(struct super_block *sb, unsigned long object_id,
 	return 0;
 
 bad_dir:
-	adfs_error(sb, "corrupted directory fragment %lX",
-		   object_id);
+	adfs_error(sb, "dir %06x is corrupted", indaddr);
 release_buffers:
 	for (blk -= 1; blk >= 0; blk -= 1)
 		brelse(dir->bh[blk]);
@@ -204,7 +200,7 @@ adfs_dir2obj(struct adfs_dir *dir, struct object_info *obj,
 	}
 
 	obj->name_len =	name_len;
-	obj->file_id  = adfs_readval(de->dirinddiscadd, 3);
+	obj->indaddr  = adfs_readval(de->dirinddiscadd, 3);
 	obj->loadaddr = adfs_readval(de->dirload, 4);
 	obj->execaddr = adfs_readval(de->direxec, 4);
 	obj->size     = adfs_readval(de->dirlen,  4);
@@ -219,7 +215,7 @@ adfs_dir2obj(struct adfs_dir *dir, struct object_info *obj,
 static inline void
 adfs_obj2dir(struct adfs_direntry *de, struct object_info *obj)
 {
-	adfs_writeval(de->dirinddiscadd, 3, obj->file_id);
+	adfs_writeval(de->dirinddiscadd, 3, obj->indaddr);
 	adfs_writeval(de->dirload, 4, obj->loadaddr);
 	adfs_writeval(de->direxec, 4, obj->execaddr);
 	adfs_writeval(de->dirlen,  4, obj->size);
@@ -305,8 +301,7 @@ __adfs_dir_put(struct adfs_dir *dir, int pos, struct object_info *obj)
  * the caller is responsible for holding the necessary
  * locks.
  */
-static int
-adfs_dir_find_entry(struct adfs_dir *dir, unsigned long object_id)
+static int adfs_dir_find_entry(struct adfs_dir *dir, u32 indaddr)
 {
 	int pos, ret;
 
@@ -318,7 +313,7 @@ adfs_dir_find_entry(struct adfs_dir *dir, unsigned long object_id)
 		if (!__adfs_dir_get(dir, pos, &obj))
 			break;
 
-		if (obj.file_id == object_id) {
+		if (obj.indaddr == indaddr) {
 			ret = pos;
 			break;
 		}
@@ -327,15 +322,15 @@ adfs_dir_find_entry(struct adfs_dir *dir, unsigned long object_id)
 	return ret;
 }
 
-static int
-adfs_f_read(struct super_block *sb, unsigned int id, unsigned int sz, struct adfs_dir *dir)
+static int adfs_f_read(struct super_block *sb, u32 indaddr, unsigned int size,
+		       struct adfs_dir *dir)
 {
 	int ret;
 
-	if (sz != ADFS_NEWDIR_SIZE)
+	if (size != ADFS_NEWDIR_SIZE)
 		return -EIO;
 
-	ret = adfs_dir_read(sb, id, sz, dir);
+	ret = adfs_dir_read(sb, indaddr, size, dir);
 	if (ret)
 		adfs_error(sb, "unable to read directory");
 	else
@@ -372,7 +367,7 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 	struct super_block *sb = dir->sb;
 	int ret, i;
 
-	ret = adfs_dir_find_entry(dir, obj->file_id);
+	ret = adfs_dir_find_entry(dir, obj->indaddr);
 	if (ret < 0) {
 		adfs_error(dir->sb, "unable to locate entry to update");
 		goto out;
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 02c54d85e77f..973282fc4758 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -180,7 +180,7 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	obj->loadaddr = le32_to_cpu(bde.bigdirload);
 	obj->execaddr = le32_to_cpu(bde.bigdirexec);
 	obj->size     = le32_to_cpu(bde.bigdirlen);
-	obj->file_id  = le32_to_cpu(bde.bigdirindaddr);
+	obj->indaddr  = le32_to_cpu(bde.bigdirindaddr);
 	obj->attr     = le32_to_cpu(bde.bigdirattr);
 	obj->name_len = le32_to_cpu(bde.bigdirobnamelen);
 
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 66621e96f9af..5f5af660b02e 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -250,7 +250,7 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 
 	inode->i_uid	 = ADFS_SB(sb)->s_uid;
 	inode->i_gid	 = ADFS_SB(sb)->s_gid;
-	inode->i_ino	 = obj->file_id;
+	inode->i_ino	 = obj->indaddr;
 	inode->i_size	 = obj->size;
 	set_nlink(inode, 2);
 	inode->i_blocks	 = (inode->i_size + sb->s_blocksize - 1) >>
@@ -358,7 +358,7 @@ int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	struct object_info obj;
 	int ret;
 
-	obj.file_id	= inode->i_ino;
+	obj.indaddr	= inode->i_ino;
 	obj.name_len	= 0;
 	obj.parent_id	= ADFS_I(inode)->parent_id;
 	obj.loadaddr	= ADFS_I(inode)->loadaddr;
diff --git a/fs/adfs/map.c b/fs/adfs/map.c
index 5f2d9d775305..e8f70f7c384e 100644
--- a/fs/adfs/map.c
+++ b/fs/adfs/map.c
@@ -66,9 +66,8 @@ static DEFINE_RWLOCK(adfs_map_lock);
  * output of:
  *  gcc -D__KERNEL__ -O2 -I../../include -o - -S map.c
  */
-static int
-lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
-	    const unsigned int frag_id, unsigned int *offset)
+static int lookup_zone(const struct adfs_discmap *dm, const unsigned int idlen,
+		       const u32 frag_id, unsigned int *offset)
 {
 	const unsigned int mapsize = dm->dm_endbit;
 	const u32 idmask = (1 << idlen) - 1;
@@ -187,9 +186,8 @@ scan_free_map(struct adfs_sb_info *asb, struct adfs_discmap *dm)
 	return 0;
 }
 
-static int
-scan_map(struct adfs_sb_info *asb, unsigned int zone,
-	 const unsigned int frag_id, unsigned int mapoff)
+static int scan_map(struct adfs_sb_info *asb, unsigned int zone,
+		    const u32 frag_id, unsigned int mapoff)
 {
 	const unsigned int idlen = asb->s_idlen;
 	struct adfs_discmap *dm, *dm_end;
@@ -243,9 +241,7 @@ adfs_map_free(struct super_block *sb)
 	return signed_asl(total, asb->s_map2blk);
 }
 
-int
-adfs_map_lookup(struct super_block *sb, unsigned int frag_id,
-		unsigned int offset)
+int adfs_map_lookup(struct super_block *sb, u32 frag_id, unsigned int offset)
 {
 	struct adfs_sb_info *asb = ADFS_SB(sb);
 	unsigned int zone, mapoff;
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 6087d263cb4d..0beaecd7be3b 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -468,7 +468,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	dr = adfs_map_discrecord(asb->s_map);
 
-	root_obj.parent_id = root_obj.file_id = le32_to_cpu(dr->root);
+	root_obj.parent_id = root_obj.indaddr = le32_to_cpu(dr->root);
 	root_obj.name_len  = 0;
 	/* Set root object date as 01 Jan 1987 00:00:00 */
 	root_obj.loadaddr  = 0xfff0003f;
-- 
2.7.4

