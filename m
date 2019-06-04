Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 222AC3495A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfFDNt4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:49:56 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40252 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbfFDNt4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:49:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L0gKPI9NTb1mzm2z3jQRJ90sq0Px64LbmPxCes2CFzY=; b=i5IZLycI6rJTmmt0Iy9g5mJRFA
        W4wjbOYv1LGkNquy3AIWqDlWn1OXV/HZ5U3Tr16PFy3DDwEgGi5yyZ50gWHRd+bH9/ktkGVmEn139
        E/xapYqXFaEjVm4cSxAYAIG0PLDj3FaARxW86pavCi7P8VwD/w6jxorpIsCeQYrbaTppv7Z/U6jXA
        BYU/P1Hdlo15cJ86C8qtF3tDnZEKr/kyGEsY8A9kpJKse+xsu/owCcrxo/wwPuxuxVVwG6oeMyJeP
        UFWvEh7yOK5LD1OsPE08dL1S72cvQnsWbcMIvyvAcCPzG/DyjwkEwQ6kwp+7Y6PDvcnlUy0snQC6k
        x5LIXmnQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:34314 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9p3-0001bS-94; Tue, 04 Jun 2019 14:49:53 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9p2-00084y-DX; Tue, 04 Jun 2019 14:49:52 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/12] fs/adfs: clean up error message printing
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9p2-00084y-DX@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:49:52 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overhaul our message printing:

- provide a consistent way to print messages:
  - filesystem corruption should be reported via adfs_error()
  - everything else should use adfs_msg()
- clean up the error message printing when mounting a filesystem
- fix the messages printed by the big directory format code to only
  use adfs_error() when there is filesystem corruption, otherwise
  use adfs_msg().

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  1 +
 fs/adfs/dir_fplus.c | 18 ++++++++----------
 fs/adfs/super.c     | 45 +++++++++++++++++++++++++++++----------------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 1c31861aa115..1e8865588a59 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -142,6 +142,7 @@ __printf(3, 4)
 void __adfs_error(struct super_block *sb, const char *function,
 		  const char *fmt, ...);
 #define adfs_error(sb, fmt...) __adfs_error(sb, __func__, fmt)
+void adfs_msg(struct super_block *sb, const char *pfx, const char *fmt, ...);
 
 /* super.c */
 
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 12ab34dad815..02c54d85e77f 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -39,17 +39,15 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	h = (struct adfs_bigdirheader *)dir->bh_fplus[0]->b_data;
 	size = le32_to_cpu(h->bigdirsize);
 	if (size != sz) {
-		printk(KERN_WARNING "adfs: adfs_fplus_read:"
-					" directory header size %X\n"
-					" does not match directory size %X\n",
-					size, sz);
+		adfs_msg(sb, KERN_WARNING,
+			 "directory header size %X does not match directory size %X",
+			 size, sz);
 	}
 
 	if (h->bigdirversion[0] != 0 || h->bigdirversion[1] != 0 ||
 	    h->bigdirversion[2] != 0 || size & 2047 ||
 	    h->bigdirstartname != cpu_to_le32(BIGDIRSTARTNAME)) {
-		printk(KERN_WARNING "adfs: dir object %X has"
-					" malformed dir header\n", id);
+		adfs_error(sb, "dir %06x has malformed header", id);
 		goto out;
 	}
 
@@ -60,9 +58,10 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 			kcalloc(size, sizeof(struct buffer_head *),
 				GFP_KERNEL);
 		if (!bh_fplus) {
+			adfs_msg(sb, KERN_ERR,
+				 "not enough memory for dir object %X (%d blocks)",
+				 id, size);
 			ret = -ENOMEM;
-			adfs_error(sb, "not enough memory for"
-					" dir object %X (%d blocks)", id, size);
 			goto out;
 		}
 		dir->bh_fplus = bh_fplus;
@@ -93,8 +92,7 @@ adfs_fplus_read(struct super_block *sb, unsigned int id, unsigned int sz, struct
 	if (t->bigdirendname != cpu_to_le32(BIGDIRENDNAME) ||
 	    t->bigdirendmasseq != h->startmasseq ||
 	    t->reserved[0] != 0 || t->reserved[1] != 0) {
-		printk(KERN_WARNING "adfs: dir object %X has "
-					"malformed dir end\n", id);
+		adfs_error(sb, "dir %06x has malformed tail", id);
 		goto out;
 	}
 
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index f35db5d64c17..6087d263cb4d 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -38,6 +38,18 @@ void __adfs_error(struct super_block *sb, const char *function, const char *fmt,
 	va_end(args);
 }
 
+void adfs_msg(struct super_block *sb, const char *pfx, const char *fmt, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	printk("%sADFS-fs (%s): %pV\n", pfx, sb->s_id, &vaf);
+	va_end(args);
+}
+
 static int adfs_checkdiscrecord(struct adfs_discrecord *dr)
 {
 	int i;
@@ -203,8 +215,9 @@ static int parse_options(struct super_block *sb, char *options)
 			asb->s_ftsuffix = option;
 			break;
 		default:
-			printk("ADFS-fs: unrecognised mount option \"%s\" "
-					"or missing value\n", p);
+			adfs_msg(sb, KERN_ERR,
+				 "unrecognised mount option \"%s\" or missing value",
+				 p);
 			return -EINVAL;
 		}
 	}
@@ -383,7 +396,7 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb_set_blocksize(sb, BLOCK_SIZE);
 	if (!(bh = sb_bread(sb, ADFS_DISCRECORD / BLOCK_SIZE))) {
-		adfs_error(sb, "unable to read superblock");
+		adfs_msg(sb, KERN_ERR, "error: unable to read superblock");
 		ret = -EIO;
 		goto error;
 	}
@@ -391,11 +404,8 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	b_data = bh->b_data + (ADFS_DISCRECORD % BLOCK_SIZE);
 
 	if (adfs_checkbblk(b_data)) {
-		if (!silent)
-			printk("VFS: Can't find an adfs filesystem on dev "
-				"%s.\n", sb->s_id);
 		ret = -EINVAL;
-		goto error_free_bh;
+		goto error_badfs;
 	}
 
 	dr = (struct adfs_discrecord *)(b_data + ADFS_DR_OFFSET);
@@ -404,33 +414,31 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	 * Do some sanity checks on the ADFS disc record
 	 */
 	if (adfs_checkdiscrecord(dr)) {
-		if (!silent)
-			printk("VPS: Can't find an adfs filesystem on dev "
-				"%s.\n", sb->s_id);
 		ret = -EINVAL;
-		goto error_free_bh;
+		goto error_badfs;
 	}
 
 	brelse(bh);
 	if (sb_set_blocksize(sb, 1 << dr->log2secsize)) {
 		bh = sb_bread(sb, ADFS_DISCRECORD / sb->s_blocksize);
 		if (!bh) {
-			adfs_error(sb, "couldn't read superblock on "
-				"2nd try.");
+			adfs_msg(sb, KERN_ERR,
+				 "error: couldn't read superblock on 2nd try.");
 			ret = -EIO;
 			goto error;
 		}
 		b_data = bh->b_data + (ADFS_DISCRECORD % sb->s_blocksize);
 		if (adfs_checkbblk(b_data)) {
-			adfs_error(sb, "disc record mismatch, very weird!");
+			adfs_msg(sb, KERN_ERR,
+				 "error: disc record mismatch, very weird!");
 			ret = -EINVAL;
 			goto error_free_bh;
 		}
 		dr = (struct adfs_discrecord *)(b_data + ADFS_DR_OFFSET);
 	} else {
 		if (!silent)
-			printk(KERN_ERR "VFS: Unsupported blocksize on dev "
-				"%s.\n", sb->s_id);
+			adfs_msg(sb, KERN_ERR,
+				 "error: unsupported blocksize");
 		ret = -EINVAL;
 		goto error;
 	}
@@ -503,6 +511,11 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	}
 	return 0;
 
+error_badfs:
+	if (!silent)
+		adfs_msg(sb, KERN_ERR,
+			 "error: can't find an ADFS filesystem on dev %s.",
+			 sb->s_id);
 error_free_bh:
 	brelse(bh);
 error:
-- 
2.7.4

