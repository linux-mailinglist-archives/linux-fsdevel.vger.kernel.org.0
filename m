Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287C2707911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 06:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjEREYY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 00:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjEREYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 00:24:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C1A3AB3;
        Wed, 17 May 2023 21:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ThbWYfYk7B780y22tMwJAJL1g5xJXhLXVyKXoVcV7tE=; b=xFIKhh0W04lefAgHJIB5vFst+R
        DNhXMDabrspBqnCA+jNtFDcenKsiZSGiPiUcqP7pNh4ygI+zGAABfJl1uvmCPrZs+R1qT17tYoJJA
        YibBBg/PzGktLkmi/4sxyZI8JfXm0HjnGmTMDXfG2Xx4qISoHTLihG9PxRzh2xsaqIGgL0sAIxo6h
        kE2NGgNxuRpcwqR/6M3iazA8ami2UPeg6iw0H33A72QhPXG9qkt5Uc+ZkoZj2Ol4kvGPFIEZekSvF
        anEzSU4jOGbLYBFY8b0kD7kk8/zBILm2REw3dtrBmV/8kLy0iSdROsq8CXtBITqhPJTkOLNyC6uYg
        2cG1OuQw==;
Received: from [2001:4bb8:188:3dd5:c90:b13:29fb:f2b9] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pzVBE-00BqT4-05;
        Thu, 18 May 2023 04:23:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 12/13] xfs: wire up sops->shutdown
Date:   Thu, 18 May 2023 06:23:21 +0200
Message-Id: <20230518042323.663189-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518042323.663189-1-hch@lst.de>
References: <20230518042323.663189-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Wire up the shutdown method to shut down the file system when the
underlying block device is marked dead.  Add a new message to
clearly distinguish this shutdown reason from other shutdowns.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_fsops.c | 3 +++
 fs/xfs/xfs_mount.h | 4 +++-
 fs/xfs/xfs_super.c | 8 ++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_fsops.c b/fs/xfs/xfs_fsops.c
index 13851c0d640bc8..9ebb8333a30800 100644
--- a/fs/xfs/xfs_fsops.c
+++ b/fs/xfs/xfs_fsops.c
@@ -534,6 +534,9 @@ xfs_do_force_shutdown(
 	} else if (flags & SHUTDOWN_CORRUPT_ONDISK) {
 		tag = XFS_PTAG_SHUTDOWN_CORRUPT;
 		why = "Corruption of on-disk metadata";
+	} else if (flags & SHUTDOWN_DEVICE_REMOVED) {
+		tag = XFS_PTAG_SHUTDOWN_IOERROR;
+		why = "Block device removal";
 	} else {
 		tag = XFS_PTAG_SHUTDOWN_IOERROR;
 		why = "Metadata I/O Error";
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index aaaf5ec13492d2..429a5e12c1036e 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -457,12 +457,14 @@ void xfs_do_force_shutdown(struct xfs_mount *mp, uint32_t flags, char *fname,
 #define SHUTDOWN_FORCE_UMOUNT	(1u << 2) /* shutdown from a forced unmount */
 #define SHUTDOWN_CORRUPT_INCORE	(1u << 3) /* corrupt in-memory structures */
 #define SHUTDOWN_CORRUPT_ONDISK	(1u << 4)  /* corrupt metadata on device */
+#define SHUTDOWN_DEVICE_REMOVED	(1u << 5) /* device removed underneath us */
 
 #define XFS_SHUTDOWN_STRINGS \
 	{ SHUTDOWN_META_IO_ERROR,	"metadata_io" }, \
 	{ SHUTDOWN_LOG_IO_ERROR,	"log_io" }, \
 	{ SHUTDOWN_FORCE_UMOUNT,	"force_umount" }, \
-	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }
+	{ SHUTDOWN_CORRUPT_INCORE,	"corruption" }, \
+	{ SHUTDOWN_DEVICE_REMOVED,	"device_removed" }
 
 /*
  * Flags for xfs_mountfs
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5684c538eb76dc..eb469b8f9a0497 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1159,6 +1159,13 @@ xfs_fs_free_cached_objects(
 	return xfs_reclaim_inodes_nr(XFS_M(sb), sc->nr_to_scan);
 }
 
+static void
+xfs_fs_shutdown(
+	struct super_block	*sb)
+{
+	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
+}
+
 static const struct super_operations xfs_super_operations = {
 	.alloc_inode		= xfs_fs_alloc_inode,
 	.destroy_inode		= xfs_fs_destroy_inode,
@@ -1172,6 +1179,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
+	.shutdown		= xfs_fs_shutdown,
 };
 
 static int
-- 
2.39.2

