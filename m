Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D160C116BED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 12:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLILJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 06:09:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60086 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfLILJt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:09:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=66Km2+1DfrQ0VzGAXyxLEOuXVp1AQ+kdtSeKtiW2ajo=; b=oa4nkz2JOeMnTWX2CWDmL/TQij
        I1K7C/5BckrPfiTIOmUKxTCmgiwxrDpWe+IhN7Uk1OBW61mxVvPs7S1ABfzwmV/XUjWRWGakvngoI
        rdi7mkXZsvU9UIEj8gxzF2ADFuv/bH/F8RXNubVCBB+UcLA5ISUvpi0pNo4Vz2MiwTSDwHfmr14nJ
        2T6OxgUmcwQdmXbYXRLpN9Xmey+InZOSH3TtiaO3T6JtEkJ1XJDlJ1XUJmZ7/bdsniCVi5tJubfkt
        9U660Zd1a0uj8D1CBqEIO2J3rp/8iWZ2nWe+WUH32JdQzffdHzunQ8RRaiWBA2e3YSOakHR/SyLdj
        2Ri50vFQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54074 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvC-0002V5-Kp; Mon, 09 Dec 2019 11:09:46 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1ieGvB-0004bc-TC; Mon, 09 Dec 2019 11:09:45 +0000
In-Reply-To: <20191209110731.GD25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
From:   Russell King <rmk+kernel@armlinux.org.uk>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/41] fs/adfs: dir: add helper to mark directory buffers
 dirty
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1ieGvB-0004bc-TC@rmk-PC.armlinux.org.uk>
Date:   Mon, 09 Dec 2019 11:09:45 +0000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a helper for marking directory buffers dirty so they get
written back to disk.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 fs/adfs/dir.c   | 12 ++++++++++++
 fs/adfs/dir_f.c |  5 +----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/adfs/dir.c b/fs/adfs/dir.c
index 882377e86041..e8aafc65d545 100644
--- a/fs/adfs/dir.c
+++ b/fs/adfs/dir.c
@@ -157,6 +157,15 @@ static int adfs_dir_read_inode(struct super_block *sb, struct inode *inode,
 	return ret;
 }
 
+static void adfs_dir_mark_dirty(struct adfs_dir *dir)
+{
+	unsigned int i;
+
+	/* Mark the buffers dirty */
+	for (i = 0; i < dir->nr_buffers; i++)
+		mark_buffer_dirty(dir->bhs[i]);
+}
+
 static int adfs_dir_sync(struct adfs_dir *dir)
 {
 	int err = 0;
@@ -280,6 +289,9 @@ adfs_dir_update(struct super_block *sb, struct object_info *obj, int wait)
 	ret = ops->update(&dir, obj);
 	write_unlock(&adfs_dir_lock);
 
+	if (ret == 0)
+		adfs_dir_mark_dirty(&dir);
+
 	if (wait) {
 		int err = adfs_dir_sync(&dir);
 		if (!ret)
diff --git a/fs/adfs/dir_f.c b/fs/adfs/dir_f.c
index 027ee714f42b..682df46d8d33 100644
--- a/fs/adfs/dir_f.c
+++ b/fs/adfs/dir_f.c
@@ -306,7 +306,7 @@ static int
 adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 {
 	struct super_block *sb = dir->sb;
-	int ret, i;
+	int ret;
 
 	ret = adfs_dir_find_entry(dir, obj->indaddr);
 	if (ret < 0) {
@@ -347,9 +347,6 @@ adfs_f_update(struct adfs_dir *dir, struct object_info *obj)
 		goto bad_dir;
 	}
 #endif
-	for (i = dir->nr_buffers - 1; i >= 0; i--)
-		mark_buffer_dirty(dir->bh[i]);
-
 	ret = 0;
 out:
 	return ret;
-- 
2.20.1

