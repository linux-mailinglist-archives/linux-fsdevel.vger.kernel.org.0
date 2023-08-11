Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BC67787DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 09:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjHKHMZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 03:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjHKHMY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 03:12:24 -0400
X-Greylist: delayed 100029 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 00:12:22 PDT
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4C271B;
        Fri, 11 Aug 2023 00:12:22 -0700 (PDT)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4RMZjr6fxLz7VH8K;
        Fri, 11 Aug 2023 15:12:16 +0800 (CST)
Received: (from root@localhost)
        by mse-fl2.zte.com.cn id 37B7CIwo078462;
        Fri, 11 Aug 2023 15:12:18 +0800 (+08)
        (envelope-from ruan.meisi@zte.com.cn)
Message-Id: <202308110712.37B7CIwo078462@mse-fl2.zte.com.cn>
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 37B6iwPA052147;
        Fri, 11 Aug 2023 14:44:58 +0800 (+08)
        (envelope-from ruan.meisi@zte.com.cn)
Received: from mapi (szxlzmapp05[null])
        by mapi (Zmail) with MAPI id mid14;
        Fri, 11 Aug 2023 14:45:00 +0800 (CST)
Date:   Fri, 11 Aug 2023 14:45:00 +0800 (CST)
X-Zmail-TransId: 2b0764d5d8ec586-a4a37
X-Mailer: Zmail v1.0
In-Reply-To: <CAJfpegtjQxPd-nncaf+7pvowSJHx+2mLgOZBJuCLXetnSCuqog@mail.gmail.com>
References: 202308100325.37A3P8fF000898@mse-db.zte.com.cn,CAJfpegtjQxPd-nncaf+7pvowSJHx+2mLgOZBJuCLXetnSCuqog@mail.gmail.com
Mime-Version: 1.0
From:   <ruan.meisi@zte.com.cn>
To:     <miklos@szeredi.hu>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?wqBbUEFUQ0hdIG5sb29rdXAgbWlzc2luZyBkZWNyZW1lbnQgaW4gZnVzZV9kaXJlbnRwbHVzX2xpbms=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 37B7CIwo078462
X-MSS:  AUDITRELEASE@mse-fl2.zte.com.cn
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64D5DF50.001/4RMZjr6fxLz7VH8K
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From 53aad83672123dbe01bcef9f9026becc4e93ee9f Mon Sep 17 00:00:00 2001
From: ruanmeisi <ruan.meisi@zte.com.cn>
Date: Tue, 25 Apr 2023 19:13:54 +0800
Subject: [PATCH] nlookup missing decrement in fuse_direntplus_link

During our debugging of glusterfs, we found an Assertion
failed error: inode_lookup >= nlookup, which was caused by the
nlookup value in the kernel being greater than that in the FUSE
file system.The issue was introduced by fuse_direntplus_link,
where in the function, fuse_iget increments nlookup, and if
d_splice_alias returns failure, fuse_direntplus_link returns
failure without decrementing nlookup
https://github.com/gluster/glusterfs/pull/4081

Signed-off-by: ruanmeisi <ruan.meisi@zte.com.cn>
---
 fs/fuse/readdir.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..b3d498163f97 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -243,8 +243,16 @@ static int fuse_direntplus_link(struct file *file,
 			dput(dentry);
 			dentry = alias;
 		}
-		if (IS_ERR(dentry))
+		if (IS_ERR(dentry)) {
+			if (!IS_ERR(inode)) {
+				struct fuse_inode *fi = get_fuse_inode(inode);
+
+				spin_lock(&fi->lock);
+				fi->nlookup--;
+				spin_unlock(&fi->lock);
+			}
 			return PTR_ERR(dentry);
+		}
 	}
 	if (fc->readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
-- 
2.27.0
