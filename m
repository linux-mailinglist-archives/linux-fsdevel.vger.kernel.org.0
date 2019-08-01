Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 364B57E695
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 01:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390433AbfHAXp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 19:45:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33046 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390423AbfHAXp0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:45:26 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl2-0002MA-Of; Thu, 01 Aug 2019 17:45:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl1-000256-Gy; Thu, 01 Aug 2019 17:45:15 -0600
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
Date:   Thu,  1 Aug 2019 17:45:01 -0600
Message-Id: <20190801234514.7941-3-logang@deltatee.com>
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
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v7 02/14] nvme-core: export existing ctrl and ns interfaces
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

We export existing nvme ctrl and ns management APIs so that target
passthru code can manage the nvme ctrl.

This is a preparation patch for implementing NVMe Over Fabric target
passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 17 +++++++++++------
 drivers/nvme/host/nvme.h |  7 +++++++
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f72334f34a30..4445efb16a84 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -412,10 +412,11 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
+EXPORT_SYMBOL_GPL(nvme_put_ns);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
@@ -1088,7 +1089,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
+struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 		unsigned nsid)
 {
 	struct nvme_id_ns *id;
@@ -1113,6 +1114,7 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	return id;
 }
+EXPORT_SYMBOL_GPL(nvme_identify_ns);
 
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 		unsigned int dword11, void *buffer, size_t buflen, u32 *result)
@@ -1261,8 +1263,8 @@ static u32 nvme_known_admin_effects(u8 opcode)
 	return 0;
 }
 
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-								u8 opcode)
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 opcode)
 {
 	u32 effects = 0;
 
@@ -1291,6 +1293,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	return effects;
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_start);
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
@@ -1305,7 +1308,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 {
 	/*
 	 * Revalidate LBA changes prior to unfreezing. This is necessary to
@@ -1323,6 +1326,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
 		nvme_queue_scan(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_end);
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
@@ -3265,7 +3269,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -3283,6 +3287,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7e827c9e892c..ccd3aff675fb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -436,6 +436,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned int nsid);
+void nvme_put_ns(struct nvme_ns *ns);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
@@ -472,8 +474,13 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 int nvme_get_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 opcode);
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
+		unsigned int nsid);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
-- 
2.20.1

