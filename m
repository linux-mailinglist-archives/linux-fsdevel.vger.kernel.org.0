Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015C778CF4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236108AbjHKLF6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbjHKLFR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:05:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7AAE54;
        Fri, 11 Aug 2023 04:05:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C71C1F8A3;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691751906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05eBw6LT3aheA6N30/JQ77zGGkCHy8nL7YIEnGTwsqs=;
        b=WjFa0xY+ba3borwBNUUocT+z7JHHPmEeZDYHoM1ukKc40Fq0hoqidU7EgZ8mJPjtwF3cPy
        1ozp8L0yvGUMtbcdXlvCxvVouDmpJFOUUIW/OJmIjhS0ZWLO+UzddyGFFHCGD+8BFQKHsU
        9t0Xtna9cw4jowbl8ROcU1r0smiJ4eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691751906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05eBw6LT3aheA6N30/JQ77zGGkCHy8nL7YIEnGTwsqs=;
        b=NArdNqc0O0GyilcvVE7uhFoLVrKc82sQ3QYNrxLbHrL0shN2IpVjfeA90HBlzVj6G3I9Jd
        4LVdRpjtuxs26QCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DDF1138E3;
        Fri, 11 Aug 2023 11:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KagdD+IV1mRnRQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 11 Aug 2023 11:05:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2EB4FA0792; Fri, 11 Aug 2023 13:05:05 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 19/29] fs: Convert to bdev_open_by_dev()
Date:   Fri, 11 Aug 2023 13:04:50 +0200
Message-Id: <20230811110504.27514-19-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810171429.31759-1-jack@suse.cz>
References: <20230810171429.31759-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2513; i=jack@suse.cz; h=from:subject; bh=1gzMVIideoh+K3PY2AkSqx8nOf6Di6drGzw80ttb91o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBk1hXTm1x8wadUUzym+MpihPmtl4cncp30/dT+oEd4 L23CmWKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZNYV0wAKCRCcnaoHP2RA2Rb2CA CpdzrKF1vp9u5SuFtxVzmjbPF9eNBmYy8Ci6R10+i3ALf6C7Hzebi8IpeiZ3a2X6iJgKjBgpqUn4KB eEjIIg1+Ku1Mx+9Eg94qHXTetwoo9nUldNDb2G5vCMfckwJECNKC0dqJj8KhMWHvHgV2AZoa9KVZHv kj2IWB1jxAdQXNaWhghXGenz+IVZt01dhT43Y/jYuAlsHPMsg5NCtmedJh2mi708n0nikhrzuXcG3V JAELgEFxrKhq1yETRpBMMBSk6G0uvluu/i3m3GSj8BO61ATdBU85YdR0NiNLUvtpxvBD0m+2lMUaA/ BK4dPbqW2iVEVC6iXs+RZN2T59IUtV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert mount code to use bdev_open_by_dev() and propagate the handle
around to bdev_release().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/super.c         | 15 +++++++++------
 include/linux/fs.h |  1 +
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 71fe297a7e90..030e897c2c68 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1270,14 +1270,16 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
 	blk_mode_t mode = sb_open_mode(sb_flags);
+	struct bdev_handle *bdev_handle;
 	struct block_device *bdev;
 
-	bdev = blkdev_get_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
-	if (IS_ERR(bdev)) {
+	bdev_handle = bdev_open_by_dev(sb->s_dev, mode, sb, &fs_holder_ops);
+	if (IS_ERR(bdev_handle)) {
 		if (fc)
 			errorf(fc, "%s: Can't open blockdev", fc->source);
-		return PTR_ERR(bdev);
+		return PTR_ERR(bdev_handle);
 	}
+	bdev = bdev_handle->bdev;
 
 	/*
 	 * This really should be in blkdev_get_by_dev, but right now can't due
@@ -1285,7 +1287,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	 * writable from userspace even for a read-only block device.
 	 */
 	if ((mode & BLK_OPEN_WRITE) && bdev_read_only(bdev)) {
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EACCES;
 	}
 
@@ -1301,10 +1303,11 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
 		if (fc)
 			warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(bdev_handle);
 		return -EBUSY;
 	}
 	spin_lock(&sb_lock);
+	sb->s_bdev_handle = bdev_handle;
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
@@ -1438,7 +1441,7 @@ void kill_block_super(struct super_block *sb)
 	generic_shutdown_super(sb);
 	if (bdev) {
 		sync_blockdev(bdev);
-		blkdev_put(bdev, sb);
+		bdev_release(sb->s_bdev_handle);
 	}
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 234ad85a28b5..a77a20955d91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1187,6 +1187,7 @@ struct super_block {
 	struct hlist_bl_head	s_roots;	/* alternate root dentries for NFS */
 	struct list_head	s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device	*s_bdev;
+	struct bdev_handle	*s_bdev_handle;
 	struct backing_dev_info *s_bdi;
 	struct mtd_info		*s_mtd;
 	struct hlist_node	s_instances;
-- 
2.35.3

