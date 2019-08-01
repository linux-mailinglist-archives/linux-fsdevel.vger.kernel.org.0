Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C926F7E68C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 01:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbfHAXp2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 19:45:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33036 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390419AbfHAXpZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:45:25 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl2-0002MH-Od; Thu, 01 Aug 2019 17:45:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl2-00025R-80; Thu, 01 Aug 2019 17:45:16 -0600
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
Date:   Thu,  1 Aug 2019 17:45:08 -0600
Message-Id: <20190801234514.7941-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801234514.7941-1-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
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
Subject: [PATCH v7 09/14] nvmet-core: don't check the data len for pt-ctrl
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Right now, data_len is calculated before the transfer len after we
parse the command, With passthru interface we allow VUCs (Vendor-Unique
Commands). In order to make the code simple and compact, instead of
assigning the data len or each VUC in the command parse function
just use the transfer len as it is. This may result in error if expected
data_len != transfer_len.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[logang@deltatee.com:
   * added definition of VUC to the commit message and comment
   * use nvmet_req_passthru_ctrl() helper seeing we can't dereference
     subsys->passthru_ctrl if CONFIG_NVME_TARGET_PASSTHRU is not set]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c655f26db3da..1cda94437fbf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -941,7 +941,16 @@ EXPORT_SYMBOL_GPL(nvmet_req_uninit);
 
 void nvmet_req_execute(struct nvmet_req *req)
 {
-	if (unlikely(req->data_len != req->transfer_len)) {
+	/*
+	 * data_len is calculated before the transfer len after we parse
+	 * the command, With passthru interface we allow VUC (Vendor-Unique
+	 * Commands)'s. In order to make the code simple and compact,
+	 * instead of assinging the dala len for each VUC in the command
+	 * parse function just use the transfer len as it is. This may
+	 * result in error if expected data_len != transfer_len.
+	 */
+	if (!(req->sq->ctrl && nvmet_req_passthru_ctrl(req)) &&
+	    unlikely(req->data_len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
 	} else
-- 
2.20.1

