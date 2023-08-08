Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF52A774997
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Aug 2023 21:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234375AbjHHT6p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Aug 2023 15:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234263AbjHHT63 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:58:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74A61D45C;
        Tue,  8 Aug 2023 11:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ag0DC0GVA6ZWEFo+6KWBzeM9QEWvQfau0HnuIyRPxDg=; b=wBNIFpZ92lh5UtJct7aTxUWk96
        ahDDuEuWFJq+4Zn0AJsu7/RVh69PqBlhV6tugDciKSVCj3EFXjeWGpEAXOJ/NG2M0eFTvPxQU9CSc
        XOz2eSjNLzd0MtWB+yDjEauFH78iiHc8TSGWTb0gVG7buVFpr4/Cn7DYLJqZDlYRDU8tB3hnUwfmM
        XhDcEKymhAXQuHkt2oqWoflDfkG9ZdVYwNmHDMejua0lc9EvGOglOKcV8XHPf5IpIqMsoe+j8VchW
        ixFg0BOKpFJfE2zCyZtAvPU8MTls08mUAWgDPDXL67v+meZRnBnzLCf3eM3kymJhIqwzSmD31TU8o
        nzvdj4TA==;
Received: from [4.28.11.157] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qTPNK-002vd4-1C;
        Tue, 08 Aug 2023 16:16:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: [PATCH 03/13] xfs: free the mount in ->kill_sb
Date:   Tue,  8 Aug 2023 09:15:50 -0700
Message-Id: <20230808161600.1099516-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808161600.1099516-1-hch@lst.de>
References: <20230808161600.1099516-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As a rule of thumb everything allocated to the fs_context and moved into
the super_block should be freed by ->kill_sb so that the teardown
handling doesn't need to be duplicated between the fill_super error
path and put_super.  Implement a XFS-specific kill_sb method to do that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 128f4a2924d49c..d2f3ae6ba8938b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1143,9 +1143,6 @@ xfs_fs_put_super(
 	xfs_destroy_percpu_counters(mp);
 	xfs_destroy_mount_workqueues(mp);
 	xfs_close_devices(mp);
-
-	sb->s_fs_info = NULL;
-	xfs_mount_free(mp);
 }
 
 static long
@@ -1487,7 +1484,7 @@ xfs_fs_fill_super(
 
 	error = xfs_fs_validate_params(mp);
 	if (error)
-		goto out_free_names;
+		return error;
 
 	sb_min_blocksize(sb, BBSIZE);
 	sb->s_xattr = xfs_xattr_handlers;
@@ -1514,7 +1511,7 @@ xfs_fs_fill_super(
 
 	error = xfs_open_devices(mp);
 	if (error)
-		goto out_free_names;
+		return error;
 
 	error = xfs_init_mount_workqueues(mp);
 	if (error)
@@ -1734,9 +1731,6 @@ xfs_fs_fill_super(
 	xfs_destroy_mount_workqueues(mp);
  out_close_devices:
 	xfs_close_devices(mp);
- out_free_names:
-	sb->s_fs_info = NULL;
-	xfs_mount_free(mp);
 	return error;
 
  out_unmount:
@@ -1999,12 +1993,20 @@ static int xfs_init_fs_context(
 	return 0;
 }
 
+static void
+xfs_kill_sb(
+	struct super_block		*sb)
+{
+	kill_block_super(sb);
+	xfs_mount_free(XFS_M(sb));
+}
+
 static struct file_system_type xfs_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "xfs",
 	.init_fs_context	= xfs_init_fs_context,
 	.parameters		= xfs_fs_parameters,
-	.kill_sb		= kill_block_super,
+	.kill_sb		= xfs_kill_sb,
 	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("xfs");
-- 
2.39.2

