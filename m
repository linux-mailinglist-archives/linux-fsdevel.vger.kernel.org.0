Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F0F678E66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 03:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAXCjt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 21:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjAXCj1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 21:39:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8FE39B92;
        Mon, 23 Jan 2023 18:39:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8F15611AD;
        Tue, 24 Jan 2023 02:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B34EC433D2;
        Tue, 24 Jan 2023 02:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674527957;
        bh=R35j7a+A+ua085wQYKH/cW9sDjYEKNr2+kfZb69JhNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjuSU3LLv3roUT4HD9fauR5bsdtCKyfG+axelFxmkk0jDaF0HQ4pmtlJw8rSD74No
         iMEUaZq8iUc4aTdDjrDuloUmHBsRa6P1JL2hFSjqs0JuxiL6omywGX21yM0Lj/X13q
         AcmwBVePcIYTNTWDiCkKpN67hdUfhpmEHRCoo1VAoTYQdtN4GrND6AvnExd7qJX87n
         osdbPjVC2z282cSYLx6pHziImBeqKDwt07VwLtguvFa6R/HRlIDUB9d52pPh28nzlt
         ncrbxibS4n8C5E1O3kanhwWQuVGEyTRTpa+/ojg/g32ILEVLLCojOkjr9ad24NWkYh
         b9fcpNiWFXAvA==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v3 09/11] fix error reporting in v9fs_dir_release
Date:   Tue, 24 Jan 2023 02:38:32 +0000
Message-Id: <20230124023834.106339-10-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230124023834.106339-1-ericvh@kernel.org>
References: <20221218232217.1713283-1-evanhensbergen@icloud.com>
 <20230124023834.106339-1-ericvh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Checking the p9_fid_put value allows us to pass back errors
involved if we end up clunking the fid as part of dir_release.

This can help with more graceful response to errors in writeback
among other things.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/vfs_dir.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index ec831c27a58e..1fc07bb86e6f 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -197,7 +197,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 
 /**
- * v9fs_dir_release - close a directory
+ * v9fs_dir_release - called on a close of a file or directory
  * @inode: inode of the directory
  * @filp: file pointer to a directory
  *
@@ -209,6 +209,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	struct p9_fid *fid;
 	__le32 version;
 	loff_t i_size;
+	int retval = 0;
 
 	fid = filp->private_data;
 	p9_debug(P9_DEBUG_VFS, "inode: %p filp: %p fid: %d\n",
@@ -226,7 +227,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
-		p9_fid_put(fid);
+		retval = p9_fid_put(fid);
 	}
 
 	if ((filp->f_mode & FMODE_WRITE)) {
@@ -237,7 +238,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	} else {
 		fscache_unuse_cookie(v9fs_inode_cookie(v9inode), NULL, NULL);
 	}
-	return 0;
+	return retval;
 }
 
 const struct file_operations v9fs_dir_operations = {
-- 
2.37.2

