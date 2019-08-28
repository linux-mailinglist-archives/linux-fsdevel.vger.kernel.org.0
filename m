Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E64A0CE6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 23:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfH1Vyl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 17:54:41 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46460 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfH1Vyk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:54:40 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35tj-00071e-NN; Wed, 28 Aug 2019 15:54:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35ti-0001Cp-CH; Wed, 28 Aug 2019 15:54:34 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 28 Aug 2019 15:54:19 -0600
Message-Id: <20190828215429.4572-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828215429.4572-1-logang@deltatee.com>
References: <20190828215429.4572-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v8 03/13] nvmet: add return value to  nvmet_add_async_event()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Change the return value for nvmet_add_async_event().

This change is needed for the target passthru code which will
submit async events on namespaces changes and can fail the command
should adding the event fail (on -ENOMEM).

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[logang@deltatee.com:
 * fleshed out commit message
 * change to using int as a return type instead of bool
]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/core.c  | 6 ++++--
 drivers/nvme/target/nvmet.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3a67e244e568..d6dcb86d8be7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -173,14 +173,14 @@ static void nvmet_async_event_work(struct work_struct *work)
 	}
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
 
 	aen = kmalloc(sizeof(*aen), GFP_KERNEL);
 	if (!aen)
-		return;
+		return -ENOMEM;
 
 	aen->event_type = event_type;
 	aen->event_info = event_info;
@@ -191,6 +191,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	mutex_unlock(&ctrl->lock);
 
 	schedule_work(&ctrl->async_event_work);
+
+	return 0;
 }
 
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c51f8dd01dc4..3d313a6452cc 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -441,7 +441,7 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
 void nvmet_subsys_disc_changed(struct nvmet_subsys *subsys,
 		struct nvmet_host *host);
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+int nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page);
 
 #define NVMET_QUEUE_SIZE	1024
-- 
2.20.1

