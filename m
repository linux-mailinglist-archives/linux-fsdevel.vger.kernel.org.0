Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F41727DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbjFHLDp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbjFHLDf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:03:35 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157910FB;
        Thu,  8 Jun 2023 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2YKg/eBeG7k8nyypHzoUOIcGXCrUmN8sX6dr3VGobXE=; b=Napi92pVYXA9Kd9qbxDMHzX/oO
        qQIawIE2huf2CzL0FRlgVf8ANR9fNOL8VnA9aKO3f+32pJtsG14xXvwLTIoBdLJlOsqtyakSrP0dC
        bStESUw+/6WeL+Owawosge7/1ywBsJkWLGtACUok6qNYw/kF2lycFigMZiEPT1SRK20hgltadGibH
        1JuH+aRe0oLl4MuD7pGyAtcboP3p+Z/U9WhDVOzwqJm7hlw07ZCPeIKakwPmV6MROTmyQAFK4A/Hd
        zcS+LWzz9h+PFLJ6Wn6d4J25a95+kPeIIpyKnUvLzWB4smboEZl4GRLfq9cdAqh/2ApC6vZnT5dcB
        Bvo/G9PA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DQB-0091io-11;
        Thu, 08 Jun 2023 11:03:15 +0000
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
Subject: [PATCH 05/30] cdrom: track if a cdrom_device_info was opened for data
Date:   Thu,  8 Jun 2023 13:02:33 +0200
Message-Id: <20230608110258.189493-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
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

Set a flag when a cdrom_device_info is opened for writing, instead of
trying to figure out this at release time.  This will allow to eventually
remove the mode argument to the ->release block_device_operation as
nothing but the CDROM drivers uses that argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 12 +++++-------
 include/linux/cdrom.h |  1 +
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 08abf1ffede002..adebac1bd210d9 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1172,6 +1172,7 @@ int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode)
 			ret = 0;
 			cdi->media_written = 0;
 		}
+		cdi->opened_for_data = true;
 	}
 
 	if (ret)
@@ -1252,7 +1253,6 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
-	int opened_for_data;
 
 	cd_dbg(CD_CLOSE, "entering cdrom_release\n");
 
@@ -1270,14 +1270,12 @@ void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
 		}
 	}
 
-	opened_for_data = !(cdi->options & CDO_USE_FFLAGS) ||
-		!(mode & FMODE_NDELAY);
-
 	cdo->release(cdi);
-	if (cdi->use_count == 0) {      /* last process that closes dev*/
-		if (opened_for_data &&
-		    cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
+
+	if (cdi->use_count == 0 && cdi->opened_for_data) {
+		if (cdi->options & CDO_AUTO_EJECT && CDROM_CAN(CDC_OPEN_TRAY))
 			cdo->tray_move(cdi, 1);
+		cdi->opened_for_data = false;
 	}
 }
 EXPORT_SYMBOL(cdrom_release);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index 0a5db0b0c958a1..adcc9f2beb2653 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -63,6 +63,7 @@ struct cdrom_device_info {
 	unsigned short mmc3_profile;	/* current MMC3 profile */
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
+	bool opened_for_data;
 	__s64 last_media_change_ms;
 };
 
-- 
2.39.2

