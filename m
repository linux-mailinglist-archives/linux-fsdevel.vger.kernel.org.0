Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7E116BFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfLILKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:10:51 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60172 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfLILKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Gg3YheMBIkVIea8U10X5XtddK/xkgIWMNqeiLYonWS4=; b=WkZjNr8CkbXm//Zvr+S7BQBbXo
        4iIxThJ64GnataiTQ5FiqC8C9K0D0+RiJsNnkMRz0vFCvO/2Tkh2aU9gDx4YtqU/zxup5eLFnC6k4
        37hOifqGw7HR4EKvLJs8eQmcxGSvQfaa0fQt8mT1N9QtebAtmazysXFFcwWbUYl/G7A+YdjAAhppZ
        RSQGYh24VO+dIz0AK5LyJPtL3cKRqO1dfju4eN6H7M0Cb7lhGxNT6wEpzheiIDie8Vk+8/SiHMv2P
        rLWGJjBom3LBhuhzV4l8W2hy5/BP9zQJluW4nngIN6/PLTI+5FbQTkPtIpajHcuCCBpLDCKrxGZiB
        hy7/Gf6A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([2001:4d48:ad52:3201:222:68ff:fe15:37dd]:37668 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwC-0002Wo-2r; Mon, 09 Dec 2019 11:10:48 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGwB-0004dF-Hv; Mon, 09 Dec 2019 11:10:47 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 30/41] fs/adfs: newdir: split out directory commit from update
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGwB-0004dF-Hv@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:10:47 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After changing a directory, we need to update the sequence numbers and
calculate the new check byte before the directory is scheduled to be
written back to the media.  Since this needs to happen for any change
to the directory, move this into a separate method.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/adfs.h  |  1 +
 fs/adfs/dir.c   |  4 ++++
 fs/adfs/dir_f.c | 26 +++++++++++++-------------
 3 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/fs/adfs/adfs.h b/fs/adfs/adfs.h
index 1f431a42e14c..c05555252fec 100644
--- a/fs/adfs/adfs.h
+++ b/fs/adfs/adfs.h
@@ -130,6 +130,7 @@ struct adfs_dir_ops {
 	int	(*update)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*create)(struct adfs_dir *dir, struct object_info *obj);
 	int	(*remove)(struct adfs_dir *dir, struct object_info *obj);
+	int	(*commit)(struct adfs_dir *dir);
 };
 
 struct adfs_discmap {
diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 7fda44464121..3d4bbe836fb5 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -293,6 +293,10 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 		goto unlock;
 
 	ret = ops->update(&dir, obj);
+	if (ret)
+		goto forget;
+
+	ret = ops->commit(&dir);
 	if (ret)
 		goto forget;
 	up_write(&adfs_dir_rwsem);
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 36cfadb2b893..30d526fecc3f 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -292,25 +292,24 @@ static int adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 	adfs_obj2dir(&de, obj);
 
 	/* Write the directory entry back to the directory */
-	ret = adfs_dir_copyto(dir, pos, &de, 26);
-	if (ret)
-		return ret;
- 
-	/*
-	 * Increment directory sequence number
-	 */
+	return adfs_dir_copyto(dir, offset, &de, 26);
+}
+
+static int adfs_f_commit(struct adfs_dir *dir)
+{
+	int ret;
+
+	/* Increment directory sequence number */
 	dir->dirhead->startmasseq += 1;
 	dir->newtail->endmasseq += 1;
 
-	ret = adfs_dir_checkbyte(dir);
-	/*
-	 * Update directory check byte
-	 */
-	dir->newtail->dircheckbyte = ret;
+	/* Update directory check byte */
+	dir->newtail->dircheckbyte = adfs_dir_checkbyte(dir);
 
+	/* Make sure the directory still validates correctly */
 	ret = adfs_f_validate(dir);
 	if (ret)
-		adfs_error(dir->sb, "whoops!  I broke a directory!");
+		adfs_msg(dir->sb, KERN_ERR, "error: update broke directory");
 
 	return ret;
 }
@@ -321,4 +320,5 @@ const struct adfs_dir_ops adfs_f_dir_ops = {
 	.setpos		= adfs_f_setpos,
 	.getnext	= adfs_f_getnext,
 	.update		= adfs_f_update,
+	.commit		= adfs_f_commit,
 };
-- 
2.20.1

