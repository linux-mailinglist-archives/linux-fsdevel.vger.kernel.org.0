Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA94572CB42
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 18:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjFLQQ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 12:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjFLQQY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:16:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E90F9;
        Mon, 12 Jun 2023 09:16:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8C6951FDAF;
        Mon, 12 Jun 2023 16:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686586582; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5IH3uzsP8sQxqgIyhLTxUh87l8HdvBPGeXFQ7kMLlj0=;
        b=RKrKfUhhhZG70fFXXx95JBz6a0xy5ziNx+goBCs7C+GxKz3A2FynRwEaTfuiDg+qzeNjrI
        eTO5qyLWYZl984Cidyb0Yl5JQMc2hvMjYmQonmHEmFMoOCOAfnUbq8Q9ErZ7VW+XP/58kw
        STLyW9pFfsm/3q66059lD72/WQ+9SGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686586582;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5IH3uzsP8sQxqgIyhLTxUh87l8HdvBPGeXFQ7kMLlj0=;
        b=ksTA9LEEu2iLS9EW2asrfylJdN1PHEofRMi3/oSrtEANM54x4CRfQhNghV2dIZ73E3o3aO
        jlBQjght9k0oy0BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7EC941357F;
        Mon, 12 Jun 2023 16:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id muTuHtZEh2SWUAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 12 Jun 2023 16:16:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 187D5A0717; Mon, 12 Jun 2023 18:16:22 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH] block: Add config option to not allow writing to mounted devices
Date:   Mon, 12 Jun 2023 18:16:14 +0200
Message-Id: <20230612161614.10302-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4094; i=jack@suse.cz; h=from:subject; bh=Llty7OKVvopQx6HNpV3t/h+vjruJSy0aW5uJYg2mW28=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkh0S89zoOEYYsPYSIqW6nALg7B4D2N+ua93KlGr76 L52XAu+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIdEvAAKCRCcnaoHP2RA2aQDB/ 0Rxpat/c3ZJS3hSMozPEFl32+4sUWgGvfUdCgFqECT3Qge9hjOMzi9WnQOXcHnLp4AIJ5ZlFdYrzwS YlU8wX3VLbFJn1cKdHBbLf6K+/WOcwkYap2hL9J5esLEdKoK6AjXGMMpnDO7iuaz4N0lS10aC6WuiN ZEensAaRZUQEEF5hccYMSFva79y7gNoAPOqNdwGzqmhwo8Ayef07/bzQy9SJOsYWLU0K9Dq0MDhgD3 Fzh+j2I7Xa4YOUI4k7LrJ8zCwZZpqzcBdAOw5Cft8PI0HIfP2OrjYKbbk9oTEJoyo8CJjfDihavos2 QJSlo4xIiwzxXcceGuCPI5TZxFx5QU
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Writing to mounted devices is dangerous and can lead to filesystem
corruption as well as crashes. Furthermore syzbot comes with more and
more involved examples how to corrupt block device under a mounted
filesystem leading to kernel crashes and reports we can do nothing
about. Add config option to disallow writing to mounted (exclusively
open) block devices. Syzbot can use this option to avoid uninteresting
crashes. Also users whose userspace setup does not need writing to
mounted block devices can set this config option for hardening.

Link: https://lore.kernel.org/all/60788e5d-5c7c-1142-e554-c21d709acfd9@linaro.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/Kconfig             | 12 ++++++++++++
 block/bdev.c              | 10 ++++++++++
 include/linux/blk_types.h |  3 +++
 3 files changed, 25 insertions(+)

FWIW I've tested this and my test VM with ext4 root fs boots fine and fstests
on ext4 seem to be also running fine with BLK_DEV_WRITE_HARDENING enabled.
OTOH my old VM setup which is not using initrd fails to boot with
BLK_DEV_WRITE_HARDENING enabled because fsck cannot open the root device
because the root is already mounted (read-only). Anyway this should be useful
for syzbot (Dmitry indicated interest in this option in the past) and maybe
other well controlled setups.

diff --git a/block/Kconfig b/block/Kconfig
index 86122e459fe0..c44e2238e18d 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -77,6 +77,18 @@ config BLK_DEV_INTEGRITY_T10
 	select CRC_T10DIF
 	select CRC64_ROCKSOFT
 
+config BLK_DEV_WRITE_HARDENING
+	bool "Do not allow writing to mounted devices"
+	help
+	When a block device is mounted, writing to its buffer cache very likely
+	going to cause filesystem corruption. It is also rather easy to crash
+	the kernel in this way since the filesystem has no practical way of
+	detecting these writes to buffer cache and verifying its metadata
+	integrity. Select this option to disallow writing to mounted devices.
+	This should be mostly fine but some filesystems (e.g. ext4) rely on
+	the ability of filesystem tools to write to mounted filesystems to
+	set e.g. UUID or run fsck on the root filesystem in some setups.
+
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
 	select MQ_IOSCHED_DEADLINE
diff --git a/block/bdev.c b/block/bdev.c
index 21c63bfef323..ad01f0a6af0d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -602,6 +602,12 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 	struct gendisk *disk = bdev->bd_disk;
 	int ret;
 
+	if (IS_ENABLED(BLK_DEV_WRITE_HARDENING)) {
+		if (mode & FMODE_EXCL && atomic_read(&bdev->bd_writers) > 0)
+			return -EBUSY;
+		if (mode & FMODE_WRITE && bdev->bd_holders > 0)
+			return -EBUSY;
+	}
 	if (disk->fops->open) {
 		ret = disk->fops->open(bdev, mode);
 		if (ret) {
@@ -617,6 +623,8 @@ static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 		set_init_blocksize(bdev);
 	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
 		bdev_disk_changed(disk, false);
+	if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
+		atomic_inc(&bdev->bd_writers);
 	atomic_inc(&bdev->bd_openers);
 	return 0;
 }
@@ -625,6 +633,8 @@ static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
 {
 	if (atomic_dec_and_test(&bdev->bd_openers))
 		blkdev_flush_mapping(bdev);
+	if (IS_ENABLED(BLK_DEV_WRITE_HARDENING) && mode & FMODE_WRITE)
+		atomic_dec(&bdev->bd_writers);
 	if (bdev->bd_disk->fops->release)
 		bdev->bd_disk->fops->release(bdev->bd_disk, mode);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 740afe80f297..25af3340f316 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -67,6 +67,9 @@ struct block_device {
 	struct partition_meta_info *bd_meta_info;
 #ifdef CONFIG_FAIL_MAKE_REQUEST
 	bool			bd_make_it_fail;
+#endif
+#ifdef CONFIG_BLK_DEV_WRITE_HARDENING
+	atomic_t		bd_writers;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
-- 
2.35.3

