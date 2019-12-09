Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F85116BF9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfLILKb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:31 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60144 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILKb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xNXxluxbqsYYAohEe2Bs4+Loh54qhRXDef//uJOSu+I=; b=niqbEJiOFj7AbUlUnTsL8I8d/P
        56bV6lsNRj/vrjwGQ0neFwxn4DcAwMGLkYh64r/6pwINI89hpGWjf0ykCscopeqvURTZuQi3dTzo7
        UbY/s8KQw+gVBLpkKB0HNdybxnqFsITiKnV7PDrp1WSpUeD9oI+b25lAzercuajmcXnKSimR6uAYz
        xIQycvdNiWzohr+Ii2OQnLvdu6p79JRGLEbncHqLFDUi92Dm2ZZJvtXU3tPl6dl/T+YSnqesJ3MAc
        I5qjII8CxY2mYm0t8NR5E71R3JzfZBeC1T3rWjgL0DUSCQScz8jNWXS3vtCv6c0WBzoE4ZMBRa/Tk
        BvXRAr3Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37660 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvr-0002WM-OH; Mon, 09 Dec 2019 11:10:27 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvr-0004cX-2b; Mon, 09 Dec 2019 11:10:27 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 26/41] fs/adfs: newdir: factor out directory format validation
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvr-0004cX-2b@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:27 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have two locations where we validate the new directory format, so
factor this out to a helper.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir_f.c | 48 ++++++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 7e56fcc21303..196706d581bf 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -121,6 +121,21 @@ adfs_dir_checkbyte(const struct adfs_dir *dir)
 	return (dircheck ^ (dircheck >> 8) ^ (dircheck >> 16) ^ (dircheck >> 24)) & 0xff;
 }
 
+static int adfs_f_validate(struct adfs_dir *dir)
+{
+	struct adfs_dirheader *head = dir->dirhead;
+	struct adfs_newdirtail *tail = dir->newtail;
+
+	if (head->startmasseq != tail->endmasseq ||
+	    (memcmp(&head->startname, "Nick", 4) &&
+	     memcmp(&head->startname, "Hugo", 4)) ||
+	    memcmp(&head->startname, &tail->endname, 4) ||
+	    adfs_dir_checkbyte(dir) != tail->dircheckbyte)
+		return -EIO;
+
+	return 0;
+}
+
 /* Read and check that a directory is valid */
 static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 			 unsigned int size, struct adfs_dir *dir)
@@ -142,15 +157,7 @@ static int adfs_dir_read(struct super_block *sb, u32 indaddr,
 	dir->dirhead = bufoff(dir->bh, 0);
 	dir->newtail = bufoff(dir->bh, 2007);
 
-	if (dir->dirhead->startmasseq != dir->newtail->endmasseq ||
-	    memcmp(&dir->dirhead->startname, &dir->newtail->endname, 4))
-		goto bad_dir;
-
-	if (memcmp(&dir->dirhead->startname, "Nick", 4) &&
-	    memcmp(&dir->dirhead->startname, "Hugo", 4))
-		goto bad_dir;
-
-	if (adfs_dir_checkbyte(dir) != dir->newtail->dircheckbyte)
+	if (adfs_f_validate(dir))
 		goto bad_dir;
 
 	return 0;
@@ -327,7 +334,7 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 	ret = adfs_dir_find_entry(dir, obj->indaddr);
 	if (ret < 0) {
 		adfs_error(dir->sb, "unable to locate entry to update");
-		goto out;
+		return ret;
 	}
 
 	__adfs_dir_put(dir, ret, obj);
@@ -344,26 +351,11 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 	 */
 	dir->newtail->dircheckbyte = ret;
 
-#if 1
-	if (dir->dirhead->startmasseq != dir->newtail->endmasseq ||
-	    memcmp(&dir->dirhead->startname, &dir->newtail->endname, 4))
-		goto bad_dir;
-
-	if (memcmp(&dir->dirhead->startname, "Nick", 4) &&
-	    memcmp(&dir->dirhead->startname, "Hugo", 4))
-		goto bad_dir;
+	ret = adfs_f_validate(dir);
+	if (ret)
+		adfs_error(dir->sb, "whoops!  I broke a directory!");
 
-	if (adfs_dir_checkbyte(dir) != dir->newtail->dircheckbyte)
-		goto bad_dir;
-#endif
-	ret = 0;
-out:
 	return ret;
-#if 1
-bad_dir:
-	adfs_error(dir->sb, "whoops!  I broke a directory!");
-	return -EIO;
-#endif
 }
 
 const struct adfs_dir_ops adfs_f_dir_ops = {
-- 
2.20.1

