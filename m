Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E702272396D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236532AbjFFHlM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236402AbjFFHke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3F910C7;
        Tue,  6 Jun 2023 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2SPWfmGJUwFbC3copUvvHjLo5uqBbUzEMBJnYk3hl0s=; b=nthF8Vyi7Ns8iyD57FbeSEz/QL
        WGFS/ZAsryct2y6V9vt7eZ1kYG/2dn8fg5qnRSHaOji8lARcXypF8WpYTLsHv1QaThkdqV5sgSqw3
        3Z46enGoC9IYfJ1xu9fTkv01CE0Cxri8X3HWeAVKsuQJ6+RWZcr6Jw8OMxsxDIPXy1wpRZ8ED+83u
        8fO+xFLWiCaedANquTR7JrSc0Xm9xfXOMDVPMvAvGBtmIolZ0xnX1jKRARNCH+hZtHJF6JNrHttKr
        ZpBP6vY0NeMQB8t/xo81EBphSVlSqODBaKDpn87njZPd07lRHcBGTUVYH2fuIn6oTUOKoEEXf0lAo
        82K/QNgg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RIT-000YeY-1a;
        Tue, 06 Jun 2023 07:40:06 +0000
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
Subject: [PATCH 04/31] cdrom: remove the unused cdrom_close_write release code
Date:   Tue,  6 Jun 2023 09:39:23 +0200
Message-Id: <20230606073950.225178-5-hch@lst.de>
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

cdrom_close_write is empty, and the for_data flag it is keyed off is
never set.  Remove all this clutter.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/cdrom.c | 15 ---------------
 include/linux/cdrom.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 245e5bbb05d41c..08abf1ffede002 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -978,15 +978,6 @@ static void cdrom_dvd_rw_close_write(struct cdrom_device_info *cdi)
 	cdi->media_written = 0;
 }
 
-static int cdrom_close_write(struct cdrom_device_info *cdi)
-{
-#if 0
-	return cdrom_flush_cache(cdi);
-#else
-	return 0;
-#endif
-}
-
 /* badly broken, I know. Is due for a fixup anytime. */
 static void cdrom_count_tracks(struct cdrom_device_info *cdi, tracktype *tracks)
 {
@@ -1282,12 +1273,6 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
 		!(mode & FMODE_NDELAY);
 
-	/*
-	 * flush cache on last write release
-	 */
-	if (CDROM_CAN(CDC_RAM) && !cdi->use_count && cdi->for_data)
-		cdrom_close_write(cdi);
-
 	cdo->release(cdi);
 	if (cdi->use_count == 0) {      /* last process that closes dev*/
 		if (opened_for_data &&
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 4aea8c82d16971..0a5db0b0c958a1 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -61,7 +61,6 @@ struct cdrom_device_info {
 	__u8 last_sense;
 	__u8 media_written;		/* dirty flag, DVD+RW bookkeeping */
 	unsigned short mmc3_profile;	/* current MMC3 profile */
-	int for_data;
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
 	__s64 last_media_change_ms;
-- 
2.39.2

