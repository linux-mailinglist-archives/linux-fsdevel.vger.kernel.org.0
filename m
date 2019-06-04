Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF9934965
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2019 15:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFDNu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jun 2019 09:50:29 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:40298 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727463AbfFDNu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fv5YPHpx7o4M73F9pIYJ+qmjR3X2okmwWLT2TQtGKRE=; b=BLPROduzZZq7nTFM3lDIsiMC/L
        cB2b9P1kkf/7CxmM4+hf8DpZOqwcAtJUo9juCLlq/ApgTg8enhKgXgm1KUfiJNTJ4TSacWuEBfWql
        Rb3okImH3eMLia3UvKV8QNWWi3qo19lJGBL7cYgIAcsk2eXwvj9jqRI0FKBpiRZ/6AIgmVn/75Yta
        8LW73qMtTHzegcMc6sXGGQIWgCStqDKg3uJio13A0YperA448DHkiaxY5TE09+g7SySZAnN4CrGkE
        XlLzNe4vL5To6GpPht/LgIMrUWs2uUeIyQitIg1HrFUffJprPlerhYLJHIvYZ8DDo7cG04hOwmPw7
        SAUxWRtg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:34840 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pZ-0001cd-Gl; Tue, 04 Jun 2019 14:50:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hY9pY-00085f-Fj; Tue, 04 Jun 2019 14:50:24 +0100
In-Reply-To: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
References: <20190604111943.GA15281@rmk-PC.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/12] fs/adfs: add time stamp and file type helpers
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hY9pY-00085f-Fj@rmk-PC.armlinux.org.uk>
Date:   Tue, 04 Jun 2019 14:50:24 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add some helpers to check whether the inode has a time stamp and file
type, and to parse the file type from the load address.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  | 29 +++++++++++++++++++----------
 fs/adfs/dir.c   | 16 +++++-----------
 fs/adfs/inode.c |  8 +++-----
 fs/adfs/super.c |  1 -
 4 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 9eb9bea1cef2..b7e844d2f321 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -9,6 +9,15 @@
 #define ADFS_BAD_FRAG		 1
 #define ADFS_ROOT_FRAG		 2
 
+#define ADFS_FILETYPE_NONE	((u16)~0)
+
+/* RISC OS 12-bit filetype is stored in load_address[19:8] */
+static inline u16 adfs_filetype(u32 loadaddr)
+{
+	return (loadaddr & 0xfff00000) == 0xfff00000 ?
+	       (loadaddr >> 8) & 0xfff : ADFS_FILETYPE_NONE;
+}
+
 #define ADFS_NDA_OWNER_READ	(1 << 0)
 #define ADFS_NDA_OWNER_WRITE	(1 << 1)
 #define ADFS_NDA_LOCKED		(1 << 2)
@@ -27,12 +36,20 @@ struct adfs_inode_info {
 	__u32		parent_id;	/* parent indirect disc address	*/
 	__u32		loadaddr;	/* RISC OS load address		*/
 	__u32		execaddr;	/* RISC OS exec address		*/
-	unsigned int	filetype;	/* RISC OS file type		*/
 	unsigned int	attr;		/* RISC OS permissions		*/
-	unsigned int	stamped:1;	/* RISC OS file has date/time	*/
 	struct inode vfs_inode;
 };
 
+static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
+{
+	return container_of(inode, struct adfs_inode_info, vfs_inode);
+}
+
+static inline bool adfs_inode_is_stamped(struct inode *inode)
+{
+	return (ADFS_I(inode)->loadaddr & 0xfff00000) == 0xfff00000;
+}
+
 /*
  * Forward-declare this
  */
@@ -68,11 +85,6 @@ static inline struct adfs_sb_info *ADFS_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
-static inline struct adfs_inode_info *ADFS_I(struct inode *inode)
-{
-	return container_of(inode, struct adfs_inode_info, vfs_inode);
-}
-
 /*
  * Directory handling
  */
@@ -105,9 +117,6 @@ struct object_info {
 	__u8		attr;			/* RISC OS attributes	*/
 	unsigned int	name_len;		/* name length		*/
 	char		name[ADFS_MAX_NAME_LEN];/* file name		*/
-
-	/* RISC OS file type (12-bit: derived from loadaddr) */
-	__u16		filetype;
 };
 
 struct adfs_dir_ops {
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 01ffd47c7461..77503d12f7ee 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -38,20 +38,14 @@ void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 	if (obj->name_len <= 2 && dots == obj->name_len)
 		obj->name[0] = '^';
 
-	obj->filetype = -1;
-
 	/*
-	 * object is a file and is filetyped and timestamped?
-	 * RISC OS 12-bit filetype is stored in load_address[19:8]
+	 * If the object is a file, and the user requested the ,xyz hex
+	 * filetype suffix to the name, check the filetype and append.
 	 */
-	if ((0 == (obj->attr & ADFS_NDA_DIRECTORY)) &&
-	    (0xfff00000 == (0xfff00000 & obj->loadaddr))) {
-		obj->filetype = (__u16) ((0x000fff00 & obj->loadaddr) >> 8);
-
-		/* optionally append the ,xyz hex filetype suffix */
-		if (ADFS_SB(dir->sb)->s_ftsuffix) {
-			__u16 filetype = obj->filetype;
+	if (!(obj->attr & ADFS_NDA_DIRECTORY) && ADFS_SB(dir->sb)->s_ftsuffix) {
+		u16 filetype = adfs_filetype(obj->loadaddr);
 
+		if (filetype != ADFS_FILETYPE_NONE) {
 			obj->name[obj->name_len++] = ',';
 			obj->name[obj->name_len++] = hex_asc_lo(filetype >> 8);
 			obj->name[obj->name_len++] = hex_asc_lo(filetype >> 4);
diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index 5f5af660b02e..d61c7453a4c3 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -97,7 +97,7 @@ adfs_atts2mode(struct super_block *sb, struct inode *inode)
 		return S_IFDIR | S_IXUGO | mode;
 	}
 
-	switch (ADFS_I(inode)->filetype) {
+	switch (adfs_filetype(ADFS_I(inode)->loadaddr)) {
 	case 0xfc0:	/* LinkFS */
 		return S_IFLNK|S_IRWXUGO;
 
@@ -177,7 +177,7 @@ adfs_adfs2unix_time(struct timespec64 *tv, struct inode *inode)
 							2208988800000000000LL;
 	s64 nsec;
 
-	if (ADFS_I(inode)->stamped == 0)
+	if (!adfs_inode_is_stamped(inode))
 		goto cur_time;
 
 	high = ADFS_I(inode)->loadaddr & 0xFF; /* top 8 bits of timestamp */
@@ -216,7 +216,7 @@ adfs_unix2adfs_time(struct inode *inode, unsigned int secs)
 {
 	unsigned int high, low;
 
-	if (ADFS_I(inode)->stamped) {
+	if (adfs_inode_is_stamped(inode)) {
 		/* convert 32-bit seconds to 40-bit centi-seconds */
 		low  = (secs & 255) * 100;
 		high = (secs / 256) * 100 + (low >> 8) + 0x336e996a;
@@ -266,8 +266,6 @@ adfs_iget(struct super_block *sb, struct object_info *obj)
 	ADFS_I(inode)->loadaddr  = obj->loadaddr;
 	ADFS_I(inode)->execaddr  = obj->execaddr;
 	ADFS_I(inode)->attr      = obj->attr;
-	ADFS_I(inode)->filetype  = obj->filetype;
-	ADFS_I(inode)->stamped   = ((obj->loadaddr & 0xfff00000) == 0xfff00000);
 
 	inode->i_mode	 = adfs_atts2mode(sb, inode);
 	adfs_adfs2unix_time(&inode->i_mtime, inode);
diff --git a/fs/adfs/super.c b/fs/adfs/super.c
index 4529f53b1708..b71476f6e564 100644
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -496,7 +496,6 @@ static int adfs_fill_super(struct super_block *sb, void *data, int silent)
 	root_obj.size	   = ADFS_NEWDIR_SIZE;
 	root_obj.attr	   = ADFS_NDA_DIRECTORY   | ADFS_NDA_OWNER_READ |
 			     ADFS_NDA_OWNER_WRITE | ADFS_NDA_PUBLIC_READ;
-	root_obj.filetype  = -1;
 
 	/*
 	 * If this is a F+ disk with variable length directories,
-- 
2.7.4

