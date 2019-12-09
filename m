Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B116BFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfLILKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:46 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60162 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=S/nXzkPEvi4jGHo/2KRu0YGy9uWdlZHfs3icwHjzwM4=; b=QWxwjcdAIHJbhxJHOgxWedFOVq
        RM6p6PrT6YA1k+DzHXArlxSrffOB6LV61g8k6aiEV+N0BHcp72vkPTffAUuD+kOZHZdnE6W4r+WSJ
        7hOpetzVB/twZLY6c/En+mcFJDKAogtNbOH5aWkwDBUii4E3saUlQJr26YWcK1eXjmAxzkZDhGKHU
        VTVU2rMd+AlHfMWfMl6UfSakCAGjaOTm6PZVscu/6ve7AbDlwscriJVUwD2sh8U/Fn+0N4SN8hhaU
        6roaGmEvJVRRofTNRV6zTGYyobuRJVEJSnd6VwpqoF/lL27ne5qhj4nqPyh9llwsREYz2XgHVrhQu
        9oKyxqaA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54096 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGw6-0002Wh-V1; Mon, 09 Dec 2019 11:10:43 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGw6-0004d8-Et; Mon, 09 Dec 2019 11:10:42 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 29/41] fs/adfs: newdir: clean up adfs_f_update()
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGw6-0004d8-Et@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:42 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__adfs_dir_put() and adfs_dir_find_entry() are only called from
adfs_f_update(), so move them into this function, removing some
unnecessary entry copying by doing so.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_f.c | 73 ++++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 49 deletions(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index dbb4f1ef7bb7..36cfadb2b893 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -229,46 +229,6 @@ __adfs_dir_get(struct adfs_dir *dir, int pos, struct object_info *obj)
 	return 0;
 }
 
-static int
-__adfs_dir_put(struct adfs_dir *dir, int pos, struct object_info *obj)
-{
-	struct adfs_direntry de;
-	int ret;
-
-	ret = adfs_dir_copyfrom(&de, dir, pos, 26);
-	if (ret)
-		return ret;
-
-	adfs_obj2dir(&de, obj);
-
-	return adfs_dir_copyto(dir, pos, &de, 26);
-}
-
-/*
- * the caller is responsible for holding the necessary
- * locks.
- */
-static int adfs_dir_find_entry(struct adfs_dir *dir, u32 indaddr)
-{
-	int pos, ret;
-
-	ret = -ENOENT;
-
-	for (pos = 5; pos < ADFS_NUM_DIR_ENTRIES * 26 + 5; pos += 26) {
-		struct object_info obj;
-
-		if (!__adfs_dir_get(dir, pos, &obj))
-			break;
-
-		if (obj.indaddr == indaddr) {
-			ret = pos;
-			break;
-		}
-	}
-
-	return ret;
-}
-
 static int
 adfs_f_setpos(struct adfs_dir *dir, unsigned int fpos)
 {
@@ -308,18 +268,33 @@ static int adfs_f_iterate(struct adfs_dir *dir, struct dir_context *ctx)
 	return 0;
 }
 
-static int
-adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
+static int adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 {
-	int ret;
+	struct adfs_direntry de;
+	int offset, ret;
 
-	ret = adfs_dir_find_entry(dir, obj->indaddr);
-	if (ret < 0) {
-		adfs_error(dir->sb, "unable to locate entry to update");
-		return ret;
-	}
+	offset = 5 - (int)sizeof(de);
+
+	do {
+		offset += sizeof(de);
+		ret = adfs_dir_copyfrom(&de, dir, offset, sizeof(de));
+		if (ret) {
+			adfs_error(dir->sb, "error reading directory entry");
+			return -ENOENT;
+		}
+		if (!de.dirobname[0]) {
+			adfs_error(dir->sb, "unable to locate entry to update");
+			return -ENOENT;
+		}
+	} while (adfs_readval(de.dirinddiscadd, 3) != obj->indaddr);
+
+	/* Update the directory entry with the new object state */
+	adfs_obj2dir(&de, obj);
 
-	__adfs_dir_put(dir, ret, obj);
+	/* Write the directory entry back to the directory */
+	ret = adfs_dir_copyto(dir, pos, &de, 26);
+	if (ret)
+		return ret;
  
 	/*
 	 * Increment directory sequence number
-- 
2.20.1

