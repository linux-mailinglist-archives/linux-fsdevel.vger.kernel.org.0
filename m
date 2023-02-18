Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2B769B705
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Feb 2023 01:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjBRAoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 19:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBRAoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 19:44:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1C3B21A;
        Fri, 17 Feb 2023 16:43:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8907620AA;
        Sat, 18 Feb 2023 00:34:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8D0C433A0;
        Sat, 18 Feb 2023 00:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676680443;
        bh=nMiGIejp8egMtRxiDVnE9HTGeqlIR/0m0XbHmw05N0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JyAPiwayh+ahtkxPDlCeK7rK+JUasC7BwIhvdjEuJhjHIYVnxqfM2wATkuMr0ZAIZ
         YSNB8lijKrih19gWPp32j8lOYicYvyUbLGyYi8b5XoijJiA3+Vin2rtaO1tJdV5OQb
         YJAr3fDCRLKsT360UgqC7Gxy+zlVuThPw2uLjCAzP9S3RzY6zJ/v9QwsB7hYN8yj4U
         JTXQPgvYlhcjzVWOzYXDKQ+zef2mRPa13qwrhZM8GlOUN9GrET9ZUTaRSszMOMO+Qq
         xMnjHtPnfV3kyzh0iF8/k/YiezbHtJlLwOPN2HfvZtXY1/CwMLsvzwKT0lmglvUSKN
         fdvTZXscyjCzg==
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        rminnich@gmail.com, lucho@ionkov.net
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux_oss@crudebyte.com, Eric Van Hensbergen <ericvh@kernel.org>
Subject: [PATCH v4 09/11] fs/9p: fix error reporting in v9fs_dir_release
Date:   Sat, 18 Feb 2023 00:33:21 +0000
Message-Id: <20230218003323.2322580-10-ericvh@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230218003323.2322580-1-ericvh@kernel.org>
References: <20230124023834.106339-1-ericvh@kernel.org>
 <20230218003323.2322580-1-ericvh@kernel.org>
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
index bd31593437f3..44918c60357f 100644
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
@@ -220,7 +221,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 		spin_lock(&inode->i_lock);
 		hlist_del(&fid->ilist);
 		spin_unlock(&inode->i_lock);
-		p9_fid_put(fid);
+		retval = p9_fid_put(fid);
 	}
 
 	if ((filp->f_mode & FMODE_WRITE)) {
@@ -231,7 +232,7 @@ int v9fs_dir_release(struct inode *inode, struct file *filp)
 	} else {
 		fscache_unuse_cookie(v9fs_inode_cookie(v9inode), NULL, NULL);
 	}
-	return 0;
+	return retval;
 }
 
 const struct file_operations v9fs_dir_operations = {
-- 
2.37.2

