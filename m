Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C17239E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236367AbjFFHnJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjFFHlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:41:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40C1E79;
        Tue,  6 Jun 2023 00:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=R/taWYn/VrvQVP7vJekvmlkcZ3skKwwlLMp5HGMR5SQ=; b=zg6tGoNyOaOlC2ng1tcChxTDEU
        LdAZ4j1dxKst+JUHQ7DfSAnPcWCIcboHQ0f+ymC6ACmj4ou4JBddjNg/SNyZd8k6IZzymPXRmHYkc
        pJv2J67DSIdPO9e3djSugFbPGi4YBMT7AyNMl/pwqstPo/nsGaKJVRejuqbjtppr1BlfDcK3sQzUd
        yeJMpsetPbMhB1CbT2g+jKQ6Qcga2qnvsXabnR7Lo6V4uWhybFuvVpwBsQX0aZX6C7Xiys/5yYwyz
        PJx+kGGfEsHhO3Tk20F7UdXeu120UGnUS2YrhImUjFIHlVJp9Ya5Xlta4wlVLfHhIt50MyGbWuODg
        vQRWVfQg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJB-000ZUg-1x;
        Tue, 06 Jun 2023 07:40:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 17/31] block: add a sb_open_mode helper
Date:   Tue,  6 Jun 2023 09:39:36 +0200
Message-Id: <20230606073950.225178-18-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a helper to return the open flags for blkdev_get_by* for passed in
super block flags instead of open coding the logic in many places.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c       |  5 +----
 fs/nilfs2/super.c      |  7 ++-----
 fs/super.c             | 15 ++++-----------
 include/linux/blkdev.h |  7 +++++++
 4 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1a2ee9407f5414..fd02b92e39106a 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1440,12 +1440,9 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	struct btrfs_fs_devices *fs_devices = NULL;
 	struct btrfs_fs_info *fs_info = NULL;
 	void *new_sec_opts = NULL;
-	fmode_t mode = FMODE_READ;
+	fmode_t mode = sb_open_mode(flags);
 	int error = 0;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
 	if (data) {
 		error = security_sb_eat_lsm_opts(data, &new_sec_opts);
 		if (error)
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 61d5e79a5e81df..a41fd84d4e28ab 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -1278,14 +1278,11 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
 {
 	struct nilfs_super_data sd;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	struct dentry *root_dentry;
 	int err, s_new = false;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
-	sd.bdev = blkdev_get_by_path(dev_name, mode, fs_type, NULL);
+	sd.bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
+				     NULL);
 	if (IS_ERR(sd.bdev))
 		return ERR_CAST(sd.bdev);
 
diff --git a/fs/super.c b/fs/super.c
index 8563794a8bc462..dc7f328398339d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1255,17 +1255,13 @@ int get_tree_bdev(struct fs_context *fc,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	int error = 0;
 
-	if (!(fc->sb_flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
 	if (!fc->source)
 		return invalf(fc, "No source specified");
 
-	bdev = blkdev_get_by_path(fc->source, mode, fc->fs_type,
-				  &fs_holder_ops);
+	bdev = blkdev_get_by_path(fc->source, sb_open_mode(fc->sb_flags),
+				  fc->fs_type, &fs_holder_ops);
 	if (IS_ERR(bdev)) {
 		errorf(fc, "%s: Can't open blockdev", fc->source);
 		return PTR_ERR(bdev);
@@ -1344,13 +1340,10 @@ struct dentry *mount_bdev(struct file_system_type *fs_type,
 {
 	struct block_device *bdev;
 	struct super_block *s;
-	fmode_t mode = FMODE_READ;
 	int error = 0;
 
-	if (!(flags & SB_RDONLY))
-		mode |= FMODE_WRITE;
-
-	bdev = blkdev_get_by_path(dev_name, mode, fs_type, &fs_holder_ops);
+	bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
+				  &fs_holder_ops);
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5b99796f12c11..97803603902076 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1473,6 +1473,13 @@ struct blk_holder_ops {
 	void (*mark_dead)(struct block_device *bdev);
 };
 
+/*
+ * Return the correct open flags for blkdev_get_by_* for super block flags
+ * as stored in sb->s_flags.
+ */
+#define sb_open_mode(flags) \
+	(FMODE_READ | (((flags) & SB_RDONLY) ? 0 : FMODE_WRITE))
+
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder,
 		const struct blk_holder_ops *hops);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
-- 
2.39.2

