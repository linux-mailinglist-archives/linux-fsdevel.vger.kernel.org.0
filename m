Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9951B3006F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbhAVPR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbhAVPQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:16:38 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113C8C061788
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:15:51 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA1-0004Bv-H8; Fri, 22 Jan 2021 16:15:41 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA0-0003qt-RM; Fri, 22 Jan 2021 16:15:40 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 4/8] ubifs: do not ubifs_inode() on potentially NULL pointer
Date:   Fri, 22 Jan 2021 16:15:32 +0100
Message-Id: <20210122151536.7982-5-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122151536.7982-1-s.hauer@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

new_inode() may return NULL, so only derefence the return inode when
non NULL. This is merely a cleanup as calling ubifs_inode() on a NULL
pointer doesn't do any harm, only using the return value would.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 9a6b8660425a..cc1d7f5085ab 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -82,10 +82,10 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
 	bool encrypted = false;
 
 	inode = new_inode(c->vfs_sb);
-	ui = ubifs_inode(inode);
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
+	ui = ubifs_inode(inode);
 	/*
 	 * Set 'S_NOCMTIME' to prevent VFS form updating [mc]time of inodes and
 	 * marking them dirty in file write path (see 'file_update_time()').
-- 
2.20.1

