Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A150B2B47EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730296AbgKPPAP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbgKPPAN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 10:00:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85461C0613CF;
        Mon, 16 Nov 2020 07:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=YfjTrndpak8c8C7A2Wr6OEv1ltyYeLktzUiwQ2pu+CA=; b=sSbJyd5Z5KD2Jm06fbaragik+M
        U4XXVDpuxMNv4/WjvlIpVZ5hUtJVUjJwX0o6moSI38FP1aoBNjPnqu8o8kZG9K4b+WNesnRErmT0w
        c6uY7DfOfd9C5ydCEyUMR677DxoiIxYLRbGGQfJ2J5j6waIzphSYMTKUR+nE58YtYY8s0sKyBH3Ag
        gi1DVUl5tW1CH54AIrFJbhR7wa+qgoeCULdOKd8s1qQnapCkGCpIt0k3E1/tTPjMNE85mVQKwftyC
        EQD17+/p3VVrTmL/7uawHNQSIdYnwo33SsrBvTjwr6J9LQP9HpQU2Rf1rToCbxKxVr+U/txNCS6he
        amu9O3qQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefz7-0004KI-Jc; Mon, 16 Nov 2020 15:00:02 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 77/78] fs: simplify the get_super_thawed interface
Date:   Mon, 16 Nov 2020 15:58:08 +0100
Message-Id: <20201116145809.410558-78-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Merge get_super_thawed and get_super_exclusive_thawed into a single
function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/quota/quota.c   |  4 ++--
 fs/super.c         | 42 +++++++++++-------------------------------
 include/linux/fs.h |  3 +--
 3 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 9af95c7a0bbe3c..21d43933213965 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -876,9 +876,9 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 	if (IS_ERR(bdev))
 		return ERR_CAST(bdev);
 	if (quotactl_cmd_onoff(cmd))
-		sb = get_super_exclusive_thawed(bdev);
+		sb = get_super_thawed(bdev, true);
 	else if (quotactl_cmd_write(cmd))
-		sb = get_super_thawed(bdev);
+		sb = get_super_thawed(bdev, false);
 	else
 		sb = get_super(bdev);
 	bdput(bdev);
diff --git a/fs/super.c b/fs/super.c
index b327a82bc1946b..50995f8abd1bf1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -789,8 +789,17 @@ struct super_block *get_super(struct block_device *bdev)
 }
 EXPORT_SYMBOL(get_super);
 
-static struct super_block *__get_super_thawed(struct block_device *bdev,
-					      bool excl)
+/**
+ * get_super_thawed - get thawed superblock of a device
+ * @bdev: device to get the superblock for
+ * @excl: lock s_umount exclusive if %true, else shared.
+ *
+ * Scans the superblock list and finds the superblock of the file system mounted
+ * on the device.  The superblock is returned with s_umount held once it is
+ * thawed (or immediately if it was not frozen), or %NULL if no superblock was
+ * found.
+ */
+struct super_block *get_super_thawed(struct block_device *bdev, bool excl)
 {
 	while (1) {
 		struct super_block *s = __get_super(bdev, excl);
@@ -805,37 +814,8 @@ static struct super_block *__get_super_thawed(struct block_device *bdev,
 		put_super(s);
 	}
 }
-
-/**
- *	get_super_thawed - get thawed superblock of a device
- *	@bdev: device to get the superblock for
- *
- *	Scans the superblock list and finds the superblock of the file system
- *	mounted on the device. The superblock is returned once it is thawed
- *	(or immediately if it was not frozen). %NULL is returned if no match
- *	is found.
- */
-struct super_block *get_super_thawed(struct block_device *bdev)
-{
-	return __get_super_thawed(bdev, false);
-}
 EXPORT_SYMBOL(get_super_thawed);
 
-/**
- *	get_super_exclusive_thawed - get thawed superblock of a device
- *	@bdev: device to get the superblock for
- *
- *	Scans the superblock list and finds the superblock of the file system
- *	mounted on the device. The superblock is returned once it is thawed
- *	(or immediately if it was not frozen) and s_umount semaphore is held
- *	in exclusive mode. %NULL is returned if no match is found.
- */
-struct super_block *get_super_exclusive_thawed(struct block_device *bdev)
-{
-	return __get_super_thawed(bdev, true);
-}
-EXPORT_SYMBOL(get_super_exclusive_thawed);
-
 /**
  * get_active_super - get an active reference to the superblock of a device
  * @bdev: device to get the superblock for
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8667d0cdc71e76..d026d177a526bf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3132,8 +3132,7 @@ extern struct file_system_type *get_filesystem(struct file_system_type *fs);
 extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_super(struct block_device *);
-extern struct super_block *get_super_thawed(struct block_device *);
-extern struct super_block *get_super_exclusive_thawed(struct block_device *bdev);
+struct super_block *get_super_thawed(struct block_device *bdev, bool excl);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-- 
2.29.2

