Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0D116BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbfLILJj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:39 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60068 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbfLILJi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uoV78TcFmk7YxA76M1o68JBPiuuUJTK4mFYD5m7E124=; b=KbiQ/QfA2eLQrdI5Z5X1pzSAOz
        FIMpoN79OjNAZIfW507+MUpYZ38NIgtObnFu5puq7HK5fGi/a51xYW06TyFZ34oxxqXC3g/+WPzKN
        O4n1+U1UZYZU4WmdkInjwqiWFwauoTEOiNjMOJGDWWPEa6qXq4T8QBN05fsdxyzw3UK0LfPaM4qJe
        eG1KRzzFy/9as7YqXllwTjPQIgB+uE/Q8US8C26aoIE6DgwB66TZHjRIPYWenSIooELihW8XpS4pe
        Ph2JSgFknF7VCr7prJ7nMX4W7RTkwVmAJMMAvlbs2jfAoBALwKajSU+TxSPxGF+M7I+VEEusdDRor
        +EUdhv6w==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54068 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuy-0002US-5j; Mon, 09 Dec 2019 11:09:32 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGuw-0004bH-Gq; Mon, 09 Dec 2019 11:09:30 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 15/41] fs/adfs: dir: add generic copy functions
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGuw-0004bH-Gq@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:30 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Directories can span multiple buffers, and we currently open-code
memcpy access to these buffers, including dealing with entries that
are split across multiple buffers.  Such code exists in both
directory format implementations.

Provide common functions to allow data to be copied from/to the
directory buffers as if they were a contiguous set of buffers, and
use them when accessing directories.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  4 ++++
 fs/adfs/dir.c       | 50 ++++++++++++++++++++++++++++++++++++++++
 fs/adfs/dir_f.c     | 56 ++++++++-------------------------------------
 fs/adfs/dir_fplus.c | 47 ++++++++++---------------------------
 4 files changed, 75 insertions(+), 82 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 5f1acee768f5..92cbc4b1d902 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -165,6 +165,10 @@ extern const struct dentry_operations adfs_dentry_operations;
 extern const struct adfs_dir_ops adfs_f_dir_ops;
 extern const struct adfs_dir_ops adfs_fplus_dir_ops;
 
+int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir, unsigned int offset,
+		      size_t len);
+int adfs_dir_copyto(struct adfs_dir *dir, unsigned int offset, const void *src,
+		    size_t len);
 void adfs_dir_relse(struct adfs_dir *dir);
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj);
 extern int adfs_dir_update(struct super_block *sb, struct object_info *obj,
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 16a2639d3ca5..3c303074aa5e 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -14,6 +14,56 @@
  */
 static DEFINE_RWLOCK(adfs_dir_lock);
 
+int adfs_dir_copyfrom(void *dst, struct adfs_dir *dir, unsigned int offset,
+		      size_t len)
+{
+	struct super_block *sb = dir->sb;
+	unsigned int index, remain;
+
+	index = offset >> sb->s_blocksize_bits;
+	offset &= sb->s_blocksize - 1;
+	remain = sb->s_blocksize - offset;
+	if (index + (remain < len) >= dir->nr_buffers)
+		return -EINVAL;
+
+	if (remain < len) {
+		memcpy(dst, dir->bhs[index]->b_data + offset, remain);
+		dst += remain;
+		len -= remain;
+		index += 1;
+		offset = 0;
+	}
+
+	memcpy(dst, dir->bhs[index]->b_data + offset, len);
+
+	return 0;
+}
+
+int adfs_dir_copyto(struct adfs_dir *dir, unsigned int offset, const void *src,
+		    size_t len)
+{
+	struct super_block *sb = dir->sb;
+	unsigned int index, remain;
+
+	index = offset >> sb->s_blocksize_bits;
+	offset &= sb->s_blocksize - 1;
+	remain = sb->s_blocksize - offset;
+	if (index + (remain < len) >= dir->nr_buffers)
+		return -EINVAL;
+
+	if (remain < len) {
+		memcpy(dir->bhs[index]->b_data + offset, src, remain);
+		src += remain;
+		len -= remain;
+		index += 1;
+		offset = 0;
+	}
+
+	memcpy(dir->bhs[index]->b_data + offset, src, len);
+
+	return 0;
+}
+
 void adfs_dir_relse(struct adfs_dir *dir)
 {
 	unsigned int i;
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 80ac261b9ec4..3c3b423577d2 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -224,24 +224,12 @@ adfs_obj2dir(struct adfs_direntry *de, struct object_info *obj)
 static int
 __adfs_dir_get(struct adfs_dir *dir, int pos, struct object_info *obj)
 {
-	struct super_block *sb = dir->sb;
 	struct adfs_direntry de;
-	int thissize, buffer, offset;
-
-	buffer = pos >> sb->s_blocksize_bits;
-
-	if (buffer > dir->nr_buffers)
-		return -EINVAL;
-
-	offset = pos & (sb->s_blocksize - 1);
-	thissize = sb->s_blocksize - offset;
-	if (thissize > 26)
-		thissize = 26;
+	int ret;
 
-	memcpy(&de, dir->bh[buffer]->b_data + offset, thissize);
-	if (thissize != 26)
-		memcpy(((char *)&de) + thissize, dir->bh[buffer + 1]->b_data,
-		       26 - thissize);
+	ret = adfs_dir_copyfrom(&de, dir, pos, 26);
+	if (ret)
+		return ret;
 
 	if (!de.dirobname[0])
 		return -ENOENT;
@@ -254,42 +242,16 @@ __adfs_dir_get(struct adfs_dir *dir, int pos, struct object_info *obj)
 static int
 __adfs_dir_put(struct adfs_dir *dir, int pos, struct object_info *obj)
 {
-	struct super_block *sb = dir->sb;
 	struct adfs_direntry de;
-	int thissize, buffer, offset;
-
-	buffer = pos >> sb->s_blocksize_bits;
-
-	if (buffer > dir->nr_buffers)
-		return -EINVAL;
-
-	offset = pos & (sb->s_blocksize - 1);
-	thissize = sb->s_blocksize - offset;
-	if (thissize > 26)
-		thissize = 26;
+	int ret;
 
-	/*
-	 * Get the entry in total
-	 */
-	memcpy(&de, dir->bh[buffer]->b_data + offset, thissize);
-	if (thissize != 26)
-		memcpy(((char *)&de) + thissize, dir->bh[buffer + 1]->b_data,
-		       26 - thissize);
+	ret = adfs_dir_copyfrom(&de, dir, pos, 26);
+	if (ret)
+		return ret;
 
-	/*
-	 * update it
-	 */
 	adfs_obj2dir(&de, obj);
 
-	/*
-	 * Put the new entry back
-	 */
-	memcpy(dir->bh[buffer]->b_data + offset, &de, thissize);
-	if (thissize != 26)
-		memcpy(dir->bh[buffer + 1]->b_data, ((char *)&de) + thissize,
-		       26 - thissize);
-
-	return 0;
+	return adfs_dir_copyto(dir, pos, &de, 26);
 }
 
 /*
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 1196c8962feb..6a07c0dfcc93 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -112,34 +112,6 @@ adfs_fplus_setpos(struct adfs_dir *dir, unsigned int fpos)
 	return ret;
 }
 
-static void
-dir_memcpy(struct adfs_dir *dir, unsigned int offset, void *to, int len)
-{
-	struct super_block *sb = dir->sb;
-	unsigned int buffer, partial, remainder;
-
-	buffer = offset >> sb->s_blocksize_bits;
-	offset &= sb->s_blocksize - 1;
-
-	partial = sb->s_blocksize - offset;
-
-	if (partial >= len)
-		memcpy(to, dir->bhs[buffer]->b_data + offset, len);
-	else {
-		char *c = (char *)to;
-
-		remainder = len - partial;
-
-		memcpy(c,
-			dir->bhs[buffer]->b_data + offset,
-			partial);
-
-		memcpy(c + partial,
-			dir->bhs[buffer + 1]->b_data,
-			remainder);
-	}
-}
-
 static int
 adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 {
@@ -147,16 +119,19 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 		(struct adfs_bigdirheader *) dir->bhs[0]->b_data;
 	struct adfs_bigdirentry bde;
 	unsigned int offset;
-	int ret = -ENOENT;
+	int ret;
 
 	if (dir->pos >= le32_to_cpu(h->bigdirentries))
-		goto out;
+		return -ENOENT;
 
 	offset = offsetof(struct adfs_bigdirheader, bigdirname);
 	offset += ((le32_to_cpu(h->bigdirnamelen) + 4) & ~3);
 	offset += dir->pos * sizeof(struct adfs_bigdirentry);
 
-	dir_memcpy(dir, offset, &bde, sizeof(struct adfs_bigdirentry));
+	ret = adfs_dir_copyfrom(&bde, dir, offset,
+				sizeof(struct adfs_bigdirentry));
+	if (ret)
+		return ret;
 
 	obj->loadaddr = le32_to_cpu(bde.bigdirload);
 	obj->execaddr = le32_to_cpu(bde.bigdirexec);
@@ -170,13 +145,15 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	offset += le32_to_cpu(h->bigdirentries) * sizeof(struct adfs_bigdirentry);
 	offset += le32_to_cpu(bde.bigdirobnameptr);
 
-	dir_memcpy(dir, offset, obj->name, obj->name_len);
+	ret = adfs_dir_copyfrom(obj->name, dir, offset, obj->name_len);
+	if (ret)
+		return ret;
+
 	adfs_object_fixup(dir, obj);
 
 	dir->pos += 1;
-	ret = 0;
-out:
-	return ret;
+
+	return 0;
 }
 
 const struct adfs_dir_ops adfs_fplus_dir_ops = {
-- 
2.20.1

