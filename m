Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7DA3116BF3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfLILKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:09 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60108 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfLILKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0SIxcTNnizfDLHQz53++xEuYFIjeCp8osIlBJPOWYTE=; b=VIA96C1FyhLYQaQdZ8Chrh9MwS
        UtpGOhu4dfaSgSJVPAqFH5ra+s11APUbscF/bt0Ph5MwF9pKiQqnKPZXPUOxAfDR753utZKidtUPJ
        VNWM9/Wil1L0FFWYa5Dwplcgr78pQeM7HHmdU79jTTeDs9V+ZNtoE7SYDw9kL1sWKReWpf+kBq03s
        rZAVtNiJvcFEmgOzZoX9yZZEw3XVvk4ZF8R6WsgiSQnpRg4LuiHNAMSSqVzI470mtxgyL0P3IgWzr
        q6Cx4MWY1vgpiY2Jf0Wdmlf4Ndq4XKxt8gtEoCVInCF09oO++IXMP2iQaDHeKNtwDZsCrDwejuIVb
        T2HGw6Qw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:49838 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvS-0002VX-Do; Mon, 09 Dec 2019 11:10:02 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvR-0004by-Cv; Mon, 09 Dec 2019 11:10:01 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 21/41] fs/adfs: dir: improve update failure handling
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvR-0004by-Cv@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:01 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we update a directory, a number of errors may happen. If we failed
to find the entry to update, we can just release the directory buffers
as normal.

However, if we have some other error, we may have partially updated the
buffers, resulting in an invalid directory. In this case, we need to
discard the buffers to avoid writing the contents back to the media, and
later re-read the directory from the media.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index ff9c921be31c..5e5d344bae7c 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -64,12 +64,8 @@ int adfs_dir_copyto(struct adfs_dir *dir, unsigned int offset, const void *src,
 	return 0;
 }
 
-void adfs_dir_relse(struct adfs_dir *dir)
+static void __adfs_dir_cleanup(struct adfs_dir *dir)
 {
-	unsigned int i;
-
-	for (i = 0; i < dir->nr_buffers; i++)
-		brelse(dir->bhs[i]);
 	dir->nr_buffers = 0;
 
 	if (dir->bhs != dir->bh)
@@ -78,6 +74,26 @@ void adfs_dir_relse(struct adfs_dir *dir)
 	dir->sb = NULL;
 }
 
+void adfs_dir_relse(struct adfs_dir *dir)
+{
+	unsigned int i;
+
+	for (i = 0; i < dir->nr_buffers; i++)
+		brelse(dir->bhs[i]);
+
+	__adfs_dir_cleanup(dir);
+}
+
+static void adfs_dir_forget(struct adfs_dir *dir)
+{
+	unsigned int i;
+
+	for (i = 0; i < dir->nr_buffers; i++)
+		bforget(dir->bhs[i]);
+
+	__adfs_dir_cleanup(dir);
+}
+
 int adfs_dir_read_buffers(struct super_block *sb, u32 indaddr,
 			  unsigned int size, struct adfs_dir *dir)
 {
@@ -288,20 +304,28 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 		goto unlock;
 
 	ret = ops->update(&dir, obj);
+	if (ret)
+		goto forget;
 	up_write(&adfs_dir_rwsem);
 
-	if (ret == 0)
-		adfs_dir_mark_dirty(&dir);
+	adfs_dir_mark_dirty(&dir);
 
-	if (wait) {
-		int err = adfs_dir_sync(&dir);
-		if (!ret)
-			ret = err;
-	}
+	if (wait)
+		ret = adfs_dir_sync(&dir);
 
 	adfs_dir_relse(&dir);
 	return ret;
 
+	/*
+	 * If the updated failed because the entry wasn't found, we can
+	 * just release the buffers. If it was any other error, forget
+	 * the dirtied buffers so they aren't written back to the media.
+	 */
+forget:
+	if (ret == -ENOENT)
+		adfs_dir_relse(&dir);
+	else
+		adfs_dir_forget(&dir);
 unlock:
 	up_write(&adfs_dir_rwsem);
 #endif
-- 
2.20.1

