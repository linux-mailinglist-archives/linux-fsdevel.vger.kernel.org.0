Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE14A0CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 23:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfH1Vzh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 17:55:37 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46448 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfH1Vyj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:54:39 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35tj-00071c-NH; Wed, 28 Aug 2019 15:54:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35ti-0001Cj-5n; Wed, 28 Aug 2019 15:54:34 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 28 Aug 2019 15:54:17 -0600
Message-Id: <20190828215429.4572-2-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828215429.4572-1-logang@deltatee.com>
References: <20190828215429.4572-1-logang@deltatee.com>
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
Subject: [PATCH v8 01/13] nvme-core: introduce nvme_ctrl_get_by_path()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

nvme_ctrl_get_by_path() is analagous to blkdev_get_by_path() except it
gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
It makes use of filp_open() to open the file and uses the private
data to obtain a pointer to the struct nvme_ctrl. If the fops of the
file do not match, -EINVAL is returned.

The purpose of this function is to support NVMe-OF target passthru.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3d6b7bd6903..776eff8c5ba7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2834,6 +2834,30 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
+{
+	struct nvme_ctrl *ctrl;
+	struct file *f;
+
+	f = filp_open(path, O_RDWR, 0);
+	if (IS_ERR(f))
+		return ERR_CAST(f);
+
+	if (f->f_op != &nvme_dev_fops) {
+		ctrl = ERR_PTR(-EINVAL);
+		goto out_close;
+	}
+
+	ctrl = f->private_data;
+	nvme_get_ctrl(ctrl);
+
+out_close:
+	filp_close(f, NULL);
+
+	return ctrl;
+}
+EXPORT_SYMBOL_GPL(nvme_ctrl_get_by_path);
+
 static ssize_t nvme_sysfs_reset(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2d678fb968c7..42d59445ae6b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -489,6 +489,8 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct block_device_operations nvme_ns_head_ops;
 
+struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.20.1

