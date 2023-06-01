Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081A719781
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjFAJqc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFAJqL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:46:11 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB05F1A8;
        Thu,  1 Jun 2023 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ly1OH3STszGSSSQ6fRDIkHpi8u8Y0rhOG+JcBsmb7/Y=; b=fd3FBkPdowM60v6h3B3JoyFAcY
        30S8x2OzFvmBaPz+De47fm4gRR+nEgpZed1MGolzmEeyEvPbSp5dEF0hF2nFQ2MYYMmUThDxTJaZ+
        Is3EBXoteNbs4J8uI6V7Cr3o7ZzoGQmuMQb8voMgpr3sfL5uJEGnAq4PWRfTKGXPPYfI1jqH2M98m
        nsj2rIVf8ewnTum1HV/As37yPDmKEx3NEtfWSTcYVRvqv2w05AMruHAkGNbq8KWfJeoq8zsMeBwQ0
        pML3uDdg9OTURI4cX2QDNQvMU341f/1BYPSPCLhMo/IegO4iJDnipJyD3Y5hZWn8CoXzJVeJSGhuc
        KsLw/r2w==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4esf-002m9r-08;
        Thu, 01 Jun 2023 09:46:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 12/16] xfs: wire up sops->shutdown
Date:   Thu,  1 Jun 2023 11:44:55 +0200
Message-Id: <20230601094459.1350643-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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

