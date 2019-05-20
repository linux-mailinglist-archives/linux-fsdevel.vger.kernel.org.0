Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEBF23997
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390596AbfETONY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47720 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390094AbfETONY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Is+DzwLvuIsL84U6TcG4XOfBnWjRyuQtkV+Iew7zdvU=; b=0iWrgzWrktJ41u3gEzm97ecAa9
        8FJ86JQnkrMXR1g1xaH7EncAtrGHUQDtov1XZDdtk+3sd5lWC6QikIQQWewYiiQIDfwZip3GNG6b5
        BZvJ9IamPTGnft6pRiDoE/vCjdw4UZEpWuN1qGiB8gACks55kMSSZiBkQNAfJHA6ssj1gLzPQ1JQE
        PIiEIPyBHGJW9DlCzL4SEpYPCJxxAdM5cx/WbPQ2+nYb5BBgLO4pH3RKh6G84Ka4EG+vzJ9zUBZIA
        QTx1FDBJW60XoXluThlSuwwi8/4K8ZOV3Kh5nNHa5xcKpxFTxcgiccbD1/aNhHwa4BHNtOo3WncFg
        y/OtjMeA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:33164 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2W-0003Ap-6A; Mon, 20 May 2019 15:13:20 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2U-0000Ld-VO; Mon, 20 May 2019 15:13:19 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/7] fs/adfs: factor out filename fixup
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2U-0000Ld-VO@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:18 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the filename fixup to adfs_object_fixup() so we only have one
implementation of this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c       | 13 +++++++++++++
 fs/adfs/dir_f.c     | 26 ++++++++++----------------
 fs/adfs/dir_fplus.c |  6 +-----
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 03490f16300d..877d5cffe9e9 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -18,6 +18,19 @@ static DEFINE_RWLOCK(adfs_dir_lock);
 
 void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
 {
+	unsigned int i;
+
+	/*
+	 * RISC OS allows the use of '/' in directory entry names, so we need
+	 * to fix these up.  '/' is typically used for FAT compatibility to
+	 * represent '.', so do the same conversion here.  In any case, '.'
+	 * will never be in a RISC OS name since it is used as the pathname
+	 * separator.
+	 */
+	for (i = 0; i < obj->name_len; i++)
+		if (obj->name[i] == '/')
+			obj->name[i] = '.';
+
 	obj->filetype = -1;
 
 	/*
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 1bab896918ed..033884541a63 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -41,21 +41,6 @@ static inline void adfs_writeval(unsigned char *p, int len, unsigned int val)
 	}
 }
 
-static inline int adfs_readname(char *buf, char *ptr, int maxlen)
-{
-	char *old_buf = buf;
-
-	while ((unsigned char)*ptr >= ' ' && maxlen--) {
-		if (*ptr == '/')
-			*buf++ = '.';
-		else
-			*buf++ = *ptr;
-		ptr++;
-	}
-
-	return buf - old_buf;
-}
-
 #define ror13(v) ((v >> 13) | (v << 19))
 
 #define dir_u8(idx)				\
@@ -210,7 +195,16 @@ static inline void
 adfs_dir2obj(struct adfs_dir *dir, struct object_info *obj,
 	struct adfs_direntry *de)
 {
-	obj->name_len =	adfs_readname(obj->name, de->dirobname, ADFS_F_NAME_LEN);
+	unsigned int name_len;
+
+	for (name_len = 0; name_len < ADFS_F_NAME_LEN; name_len++) {
+		if (de->dirobname[name_len] < ' ')
+			break;
+
+		obj->name[name_len] = de->dirobname[name_len];
+	}
+
+	obj->name_len =	name_len;
 	obj->file_id  = adfs_readval(de->dirinddiscadd, 3);
 	obj->loadaddr = adfs_readval(de->dirload, 4);
 	obj->execaddr = adfs_readval(de->direxec, 4);
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index 308009d00a5b..97b9f28f459b 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -169,7 +169,7 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 		(struct adfs_bigdirheader *) dir->bh_fplus[0]->b_data;
 	struct adfs_bigdirentry bde;
 	unsigned int offset;
-	int i, ret = -ENOENT;
+	int ret = -ENOENT;
 
 	if (dir->pos >= le32_to_cpu(h->bigdirentries))
 		goto out;
@@ -193,10 +193,6 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 	offset += le32_to_cpu(bde.bigdirobnameptr);
 
 	dir_memcpy(dir, offset, obj->name, obj->name_len);
-	for (i = 0; i < obj->name_len; i++)
-		if (obj->name[i] == '/')
-			obj->name[i] = '.';
-
 	adfs_object_fixup(dir, obj);
 
 	dir->pos += 1;
-- 
2.7.4

