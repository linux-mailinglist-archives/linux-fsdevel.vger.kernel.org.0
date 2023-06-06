Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30325723957
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjFFHkn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236327AbjFFHk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:40:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03A2E64;
        Tue,  6 Jun 2023 00:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8Adtrrh+HKiESWEIybPbNuKkuJAqdXyvilhbFWCcbK0=; b=SHBX4tb8IIrhdTh2jVhjBc6ERz
        x8bPbd6MZqyVrQobUYkf34x0AXOKumpQIU14VOwyumZoIQDRHbziYHWyKN6POofTjaqVXf5t3FByh
        4r9D/DgUeW03MTaSTMiC0M/G0I/E+vrQCXBdPQDw7VzgjPf0GGzvTVIoSLRi+qrwKJyKbyv2l3CRA
        fwIEY/nfT0l/zCHZg/D2b1OB1mY6Q+1F7vBLxZKmQyGjHmIL4hPlJXwldZdlbwI5BFCdZlfMMn3r1
        QNpOV3w1di/kkZYfpRAFoKJuh17ZrmEUzHTxEFyeT0X4ati7vL7z+oFzk8k5R96//u1mvvhUiw5HZ
        Out4L6mg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RIW-000YhP-1N;
        Tue, 06 Jun 2023 07:40:08 +0000
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
Subject: [PATCH 05/31] cdrom: track if a cdrom_device_info was opened for data
Date:   Tue,  6 Jun 2023 09:39:24 +0200
Message-Id: <20230606073950.225178-6-hch@lst.de>
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

Set a flag when a cdrom_device_info is opened for writing, instead of
trying to figure out this at release time.  This will allow to eventually
remove the mode argument to the ->release block_device_operation as
nothing but the CDROM drivers uses that argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index 0a5db0b0c958a1..385e94732b2cf1 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -64,6 +64,7 @@ struct cdrom_device_info {
 	int (*exit)(struct cdrom_device_info *);
 	int mrw_mode_page;
 	__s64 last_media_change_ms;
+	bool opened_for_data;
 };
 
 struct cdrom_device_ops {
-- 
2.39.2

