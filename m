Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F717E689
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2019 01:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390425AbfHAXp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Aug 2019 19:45:26 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33018 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388733AbfHAXpZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Aug 2019 19:45:25 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl2-0002MG-On; Thu, 01 Aug 2019 17:45:24 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1htKl2-00025O-4D; Thu, 01 Aug 2019 17:45:16 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu,  1 Aug 2019 17:45:07 -0600
Message-Id: <20190801234514.7941-9-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190801234514.7941-1-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v7 08/14] nvmet-core: allow one host per passthru-ctrl
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch rejects any new connection to the passthru-ctrl if this
controller is already connected to a different host. At the time of
allocating the controller we check if the subsys associated with
the passthru ctrl is already connected to a host and reject it
if the hostnqn differs.

Connections from the same host (by hostnqn) are supported to allow
for multipath.

[chaitanya.kulkarni@wdc.com: based conceptually on a similar patch but
  different implementation]
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/core.c            |  4 ++++
 drivers/nvme/target/io-cmd-passthru.c | 31 +++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h           |  7 ++++++
 3 files changed, 42 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2e75968af7f4..c655f26db3da 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1278,6 +1278,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
+	ret = nvmet_passthru_alloc_ctrl(subsys, hostnqn);
+	if (ret)
+		goto out_free_sqs;
+
 	ret = ida_simple_get(&cntlid_ida,
 			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
 			     GFP_KERNEL);
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index b199785500ad..06a919283cc5 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -104,6 +104,37 @@ void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 	mutex_unlock(&subsys->lock);
 }
 
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+			      const char *hostnqn)
+{
+	struct nvmet_ctrl *ctrl;
+
+	/*
+	 * Check here if this subsystem is already connected to the passthru
+	 * ctrl. We allow only one host to connect to a given passthru
+	 * subsystem.
+	 */
+	int rc = 0;
+
+	mutex_lock(&subsys->lock);
+
+	if (!subsys->passthru_ctrl)
+		goto out;
+
+	if (list_empty(&subsys->ctrls))
+		goto out;
+
+	ctrl = list_first_entry(&subsys->ctrls, struct nvmet_ctrl,
+				subsys_entry);
+
+	if (strcmp(hostnqn, ctrl->hostnqn))
+		rc = -ENODEV;
+
+out:
+	mutex_unlock(&subsys->lock);
+	return rc;
+}
+
 static void nvmet_passthru_req_complete(struct nvmet_req *req,
 		struct request *rq, u16 status)
 {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index aff4db03269d..6436cb990905 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -513,6 +513,8 @@ void nvmet_passthru_destroy(void);
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
 void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
+int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+			      const char *hostnqn);
 u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
 
 static inline
@@ -536,6 +538,11 @@ static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
 static inline void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys)
 {
 }
+static inline int nvmet_passthru_alloc_ctrl(struct nvmet_subsys *subsys,
+					    const char *hostnqn)
+{
+	return 0;
+}
 static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
 {
 	return 0;
-- 
2.20.1

