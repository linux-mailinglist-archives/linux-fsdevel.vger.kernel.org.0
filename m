Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 300E923996
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 16:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390495AbfETONW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 10:13:22 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:47714 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390094AbfETONW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 10:13:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IBZQ718yaSzpLTFYqFOqG3uwpcR0uN8Ys9by252OO1g=; b=TRLlCmXsOMAWrVwx+qlydGBawM
        IiZ6zVw54wtcLnu31w1k3JoMh5GANsjVNaQWKelXvxxcH1LDrkcJFiYqIf/LRy5Lc5NdiIB5djJeh
        wuH3mOU3wc9JhpCbiRYraD8rdgsOJiaHvhUu8INyS36fEkjBVVKj69/DD8ck2Gz6zGgSeFDJQJvz8
        iQIQeZ7z960epHtt05qjOHrexgVZvNfxD5YpSjk8Ytt1OrvV/lXT3qE9E9726tCxX0eBXgWMYubx2
        tKrpUaq2WJSlXtljNGea3eGatN4N9Lgjsys5d8mzdWEotMDYhAQXyp0/fiH/9dD5TMXI0kFDASXU5
        gPtL5bqQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:42592 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2R-0003AH-5F; Mon, 20 May 2019 15:13:15 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1hSj2P-0000LW-RM; Mon, 20 May 2019 15:13:13 +0100
In-Reply-To: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
References: <20190520141227.krqowhs3yg7hpige@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/7] fs/adfs: factor out object fixups
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1hSj2P-0000LW-RM@rmk-PC.armlinux.org.uk>
Date:   Mon, 20 May 2019 15:13:13 +0100
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the directory object fixups, which parse the filetype and
optionally apply the filetype suffix to the filename.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h      |  1 +
 fs/adfs/dir.c       | 21 +++++++++++++++++++++
 fs/adfs/dir_f.c     | 17 +----------------
 fs/adfs/dir_fplus.c | 18 +-----------------
 4 files changed, 24 insertions(+), 33 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index c76db75f02aa..1097bee65fa9 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -172,6 +172,7 @@ extern const struct dentry_operations adfs_dentry_operations;
 extern const struct adfs_dir_ops adfs_f_dir_ops;
 extern const struct adfs_dir_ops adfs_fplus_dir_ops;
 
+void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj);
 extern int adfs_dir_update(struct super_block *sb, struct object_info *obj,
 			   int wait);
 
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index be4b4f950500..03490f16300d 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -16,6 +16,27 @@
  */
 static DEFINE_RWLOCK(adfs_dir_lock);
 
+void adfs_object_fixup(struct adfs_dir *dir, struct object_info *obj)
+{
+	obj->filetype = -1;
+
+	/*
+	 * object is a file and is filetyped and timestamped?
+	 * RISC OS 12-bit filetype is stored in load_address[19:8]
+	 */
+	if ((0 == (obj->attr & ADFS_NDA_DIRECTORY)) &&
+	    (0xfff00000 == (0xfff00000 & obj->loadaddr))) {
+		obj->filetype = (__u16) ((0x000fff00 & obj->loadaddr) >> 8);
+
+		/* optionally append the ,xyz hex filetype suffix */
+		if (ADFS_SB(dir->sb)->s_ftsuffix)
+			obj->name_len +=
+				append_filetype_suffix(
+					&obj->name[obj->name_len],
+					obj->filetype);
+	}
+}
+
 static int
 adfs_readdir(struct file *file, struct dir_context *ctx)
 {
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 0fbfd0b04ae0..1bab896918ed 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -216,23 +216,8 @@ adfs_dir2obj(struct adfs_dir *dir, struct object_info *obj,
 	obj->execaddr = adfs_readval(de->direxec, 4);
 	obj->size     = adfs_readval(de->dirlen,  4);
 	obj->attr     = de->newdiratts;
-	obj->filetype = -1;
 
-	/*
-	 * object is a file and is filetyped and timestamped?
-	 * RISC OS 12-bit filetype is stored in load_address[19:8]
-	 */
-	if ((0 == (obj->attr & ADFS_NDA_DIRECTORY)) &&
-		(0xfff00000 == (0xfff00000 & obj->loadaddr))) {
-		obj->filetype = (__u16) ((0x000fff00 & obj->loadaddr) >> 8);
-
-		/* optionally append the ,xyz hex filetype suffix */
-		if (ADFS_SB(dir->sb)->s_ftsuffix)
-			obj->name_len +=
-				append_filetype_suffix(
-					&obj->name[obj->name_len],
-					obj->filetype);
-	}
+	adfs_object_fixup(dir, obj);
 }
 
 /*
diff --git a/fs/adfs/dir_fplus.c b/fs/adfs/dir_fplus.c
index c92cfb638c18..308009d00a5b 100644
--- a/fs/adfs/dir_fplus.c
+++ b/fs/adfs/dir_fplus.c
@@ -197,23 +197,7 @@ adfs_fplus_getnext(struct adfs_dir *dir, struct object_info *obj)
 		if (obj->name[i] == '/')
 			obj->name[i] = '.';
 
-	obj->filetype = -1;
-
-	/*
-	 * object is a file and is filetyped and timestamped?
-	 * RISC OS 12-bit filetype is stored in load_address[19:8]
-	 */
-	if ((0 == (obj->attr & ADFS_NDA_DIRECTORY)) &&
-		(0xfff00000 == (0xfff00000 & obj->loadaddr))) {
-		obj->filetype = (__u16) ((0x000fff00 & obj->loadaddr) >> 8);
-
-		/* optionally append the ,xyz hex filetype suffix */
-		if (ADFS_SB(dir->sb)->s_ftsuffix)
-			obj->name_len +=
-				append_filetype_suffix(
-					&obj->name[obj->name_len],
-					obj->filetype);
-	}
+	adfs_object_fixup(dir, obj);
 
 	dir->pos += 1;
 	ret = 0;
-- 
2.7.4

