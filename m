Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3355620224B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jun 2020 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFTHQ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 03:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgFTHQx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 03:16:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4CDC06174E;
        Sat, 20 Jun 2020 00:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=koI155aGDcIf4Rh+gSo69u1fzRFomV+Z7ORwaw0YDLc=; b=DOpBH2+vY8kxUf+lcCx4xeLpTf
        H2LNChA9+4uA6Durrl69QKQjZfQN7Zw6zi89cWcXO3WRKNfV2pPavBSBKUt6/ol9i/Ztli+XlOfq+
        RTePmOqqImazUlm3SsqSvbaszxmhDB1zp6W2x1yQt2/Hz4I2R9DaiDLfriajFF/7hJ1Nu6hqRlGOn
        bGppq3IF80wvOQ43afOuT76OtBWCumq0VfeLvN3YvVVw9C6oiOB0OQfScuo9BmDYL8N6cuwOxZ6rX
        V3lzRFy0AyqUHVGGR0lC4fq6XNqRr4H2X+xaY/4Dfrn+MTJ3h57hNNCfL4mPCWEB+iFOwICBaBqJT
        c0Q1/mIw==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmXk9-0003qp-M1; Sat, 20 Jun 2020 07:16:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] tty/sysrq: emergency_thaw_all does not depend on CONFIG_BLOCK
Date:   Sat, 20 Jun 2020 09:16:35 +0200
Message-Id: <20200620071644.463185-2-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620071644.463185-1-hch@lst.de>
References: <20200620071644.463185-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can also thaw non-block file systems.  Remove the CONFIG_BLOCK in
sysrq.c after making the prototype available unconditionally.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/tty/sysrq.c | 2 --
 include/linux/fs.h  | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 7c95afa905a083..a8e39b2cdd5526 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -403,7 +403,6 @@ static const struct sysrq_key_op sysrq_moom_op = {
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
 
-#ifdef CONFIG_BLOCK
 static void sysrq_handle_thaw(int key)
 {
 	emergency_thaw_all();
@@ -414,7 +413,6 @@ static const struct sysrq_key_op sysrq_thaw_op = {
 	.action_msg	= "Emergency Thaw of all frozen filesystems",
 	.enable_mask	= SYSRQ_ENABLE_SIGNAL,
 };
-#endif
 
 static void sysrq_handle_kill(int key)
 {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3f881a892ea746..7f40dbafbf6d49 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2593,7 +2593,6 @@ extern void invalidate_bdev(struct block_device *);
 extern void iterate_bdevs(void (*)(struct block_device *, void *), void *);
 extern int sync_blockdev(struct block_device *bdev);
 extern struct super_block *freeze_bdev(struct block_device *);
-extern void emergency_thaw_all(void);
 extern void emergency_thaw_bdev(struct super_block *sb);
 extern int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 extern int fsync_bdev(struct block_device *);
@@ -2633,6 +2632,7 @@ static inline bool sb_is_blkdev_sb(struct super_block *sb)
 	return false;
 }
 #endif
+void emergency_thaw_all(void);
 extern int sync_filesystem(struct super_block *);
 extern const struct file_operations def_blk_fops;
 extern const struct file_operations def_chr_fops;
-- 
2.26.2

