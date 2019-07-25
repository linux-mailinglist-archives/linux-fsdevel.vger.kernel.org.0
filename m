Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3175588
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 19:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390995AbfGYRXv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 13:23:51 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39680 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390913AbfGYRXv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:23:51 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSw-0001Jl-MH; Thu, 25 Jul 2019 11:23:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hqhSw-0001no-Gu; Thu, 25 Jul 2019 11:23:42 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 25 Jul 2019 11:23:35 -0600
Message-Id: <20190725172335.6825-17-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190725172335.6825-1-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v6 16/16] nvmet-passthru: support block accounting
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Support block disk accounting by setting the RQF_IO_STAT flag
and gendisk in the request.

After this change, IO counts will be reflected correctly in
/proc/diskstats for drives being used by passthru.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/io-cmd-passthru.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index aefdd534cb4a..0a3f1249341a 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -439,6 +439,9 @@ static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
 	if (unlikely(IS_ERR(rq)))
 		return rq;
 
+	if (blk_queue_io_stat(q) && cmd->common.opcode != nvme_cmd_flush)
+		rq->rq_flags |= RQF_IO_STAT;
+
 	if (req->sg_cnt) {
 		ret = nvmet_passthru_map_sg(req, rq);
 		if (unlikely(ret)) {
@@ -503,7 +506,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 
 	rq->end_io_data = req;
 	if (req->sq->qid != 0) {
-		blk_execute_rq_nowait(rq->q, NULL, rq, 0,
+		blk_execute_rq_nowait(rq->q, ns->disk, rq, 0,
 				      nvmet_passthru_req_done);
 	} else {
 		req->p.rq = rq;
-- 
2.20.1

