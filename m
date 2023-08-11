Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD1B778B01
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 12:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjHKKJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 06:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbjHKKJe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:09:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266993A92;
        Fri, 11 Aug 2023 03:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/3mbalPz9mWKW7oe8+rjeqpDnnAIwNVoPvEAXzlOmEA=; b=Kf0RESes2SiwxcuhMUwkC1tu/v
        j57mzaPUQPBQ7b7q/sMXcM1MGS5/6YmCDQb61sx4euJkFn2+q0Xoo3oMoMsHwS5hvZmscyu8MmZrR
        /xHy/ii6KMuk/xo0tgVYh4xLy5Q95qX65RiajMsGHI3FnoIx92eqnLXLR11rYFf54jSV/J4hnjUZC
        /PoNo3rx7uOSrIBL+rG8hOmVbE5w6SOVONf4lGLv45WAGDA0dSOvWZBVU0NsM09bD1Jo1myLaf47k
        1HGTBLAhzumDV20VF//EZRTKnEY3dLY9gBVYtm5b04D0B2bRjyIMZL6GdE41RQKWbD9/jMwMCKq0g
        WWJcEvwA==;
Received: from [88.128.92.63] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUP4a-00A5fP-0Y;
        Fri, 11 Aug 2023 10:08:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Denis Efremov <efremov@linux.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Darrick J . Wong" <djwong@kernel.org>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-s390@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/17] btrfs: use the super_block as holder when mounting file systems
Date:   Fri, 11 Aug 2023 12:08:17 +0200
Message-Id: <20230811100828.1897174-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811100828.1897174-1-hch@lst.de>
References: <20230811100828.1897174-1-hch@lst.de>
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

The file system type is not a very useful holder as it doesn't allow us
to go back to the actual file system instance.  Pass the super_block
instead which is useful when passed back to the file system driver.

This matches what is done for all other block device based file systems.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/btrfs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 1079a0f541790d..0f7c402fb40349 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -69,8 +69,6 @@ static const struct super_operations btrfs_super_ops;
  * requested by subvol=/path. That way the callchain is straightforward and we
  * don't have to play tricks with the mount options and recursive calls to
  * btrfs_mount.
- *
- * The new btrfs_root_fs_type also servers as a tag for the bdev_holder.
  */
 static struct file_system_type btrfs_fs_type;
 static struct file_system_type btrfs_root_fs_type;
@@ -1503,8 +1501,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 		struct btrfs_fs_devices *fs_devices = fs_info->fs_devices;
 
 		mutex_lock(&uuid_mutex);
-		error = btrfs_open_devices(fs_devices, sb_open_mode(flags),
-					   fs_type);
+		error = btrfs_open_devices(fs_devices, sb_open_mode(flags), s);
 		mutex_unlock(&uuid_mutex);
 		if (error)
 			goto error_deactivate;
@@ -1518,7 +1515,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 			 fs_devices->latest_dev->bdev);
 		shrinker_debugfs_rename(&s->s_shrink, "sb-%s:%s", fs_type->name,
 					s->s_id);
-		btrfs_sb(s)->bdev_holder = fs_type;
+		btrfs_sb(s)->bdev_holder = s;
 		error = btrfs_fill_super(s, fs_devices, data);
 	}
 	if (!error)
-- 
2.39.2

