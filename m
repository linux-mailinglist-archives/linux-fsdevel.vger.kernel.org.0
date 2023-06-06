Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00802723A13
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236710AbjFFHob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbjFFHnS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:43:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DBA19B3;
        Tue,  6 Jun 2023 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vHcX3S2sl+pGbOZrjHP9HcCBLAMHPQWl4gmV2z7KfHE=; b=drZ4wkQYmFnx901jMqvpeF3nQb
        5HYtfg7uUF6T0B2uem0mk7dHK6xJniRJRL+5zNPve8bw2exu+F4p14xF22QmJ20JGMKDCPEjWndq0
        fJsbbAkGTGGw1A+KXJlyH1Xg2WeumA3swMkzKOevMFuEgHORynqNWfXIKzrl0i6/uIyBjc1N+dfwr
        LObaDZT6tdF4Q+yNxdmbzauEwxdrQYJ0aT3yzCSteCnEmXVpf29wG7j0ZCfavTC4LlfEa7AaBxoEZ
        wOm7285ab9Y7SUMBmmEKGFf3TmKtHerGb+VQh0jYnPsKQDSf3pEA0ainVbBKGrvpcQb657LIr6dM8
        3UcOq7xg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJR-000Zlq-1O;
        Tue, 06 Jun 2023 07:41:05 +0000
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
Subject: [PATCH 22/31] nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool
Date:   Tue,  6 Jun 2023 09:39:41 +0200
Message-Id: <20230606073950.225178-23-hch@lst.de>
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

Instead of passing a fmode_t and only checking it fo0r FMODE_WRITE, pass
a bool open_for_write to prepare for callers that won't have the fmode_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/ioctl.c | 62 +++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 81c5c9e3847747..8bf09047348ee9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -14,7 +14,7 @@ enum {
 };
 
 static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
-		unsigned int flags, fmode_t mode)
+		unsigned int flags, bool open_for_write)
 {
 	u32 effects;
 
@@ -80,7 +80,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * writing.
 	 */
 	if (nvme_is_write(c) || (effects & NVME_CMD_EFFECTS_LBCC))
-		return mode & FMODE_WRITE;
+		return open_for_write;
 	return true;
 }
 
@@ -337,7 +337,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct nvme_passthru_cmd __user *ucmd, unsigned int flags,
-		fmode_t mode)
+		bool open_for_write)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
@@ -365,7 +365,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, 0, mode))
+	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -385,7 +385,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		struct nvme_passthru_cmd64 __user *ucmd, unsigned int flags,
-		fmode_t mode)
+		bool open_for_write)
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
@@ -412,7 +412,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
 	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
-	if (!nvme_cmd_allowed(ns, &c, flags, mode))
+	if (!nvme_cmd_allowed(ns, &c, flags, open_for_write))
 		return -EACCES;
 
 	if (cmd.timeout_ms)
@@ -583,7 +583,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.cdw14 = cpu_to_le32(READ_ONCE(cmd->cdw14));
 	c.common.cdw15 = cpu_to_le32(READ_ONCE(cmd->cdw15));
 
-	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode))
+	if (!nvme_cmd_allowed(ns, &c, 0, ioucmd->file->f_mode & FMODE_WRITE))
 		return -EACCES;
 
 	d.metadata = READ_ONCE(cmd->metadata);
@@ -649,13 +649,13 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 }
 
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
-		void __user *argp, fmode_t mode)
+		void __user *argp, bool open_for_write)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, mode);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, mode);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	default:
 		return sed_ioctl(ctrl->opal_dev, cmd, argp);
 	}
@@ -680,14 +680,14 @@ struct nvme_user_io32 {
 #endif /* COMPAT_FOR_U64_ALIGNMENT */
 
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
-		void __user *argp, unsigned int flags, fmode_t mode)
+		void __user *argp, unsigned int flags, bool open_for_write)
 {
 	switch (cmd) {
 	case NVME_IOCTL_ID:
 		force_successful_syscall_return();
 		return ns->head->ns_id;
 	case NVME_IOCTL_IO_CMD:
-		return nvme_user_cmd(ns->ctrl, ns, argp, flags, mode);
+		return nvme_user_cmd(ns->ctrl, ns, argp, flags, open_for_write);
 	/*
 	 * struct nvme_user_io can have different padding on some 32-bit ABIs.
 	 * Just accept the compat version as all fields that are used are the
@@ -702,7 +702,8 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		flags |= NVME_IOCTL_VEC;
 		fallthrough;
 	case NVME_IOCTL_IO64_CMD:
-		return nvme_user_cmd64(ns->ctrl, ns, argp, flags, mode);
+		return nvme_user_cmd64(ns->ctrl, ns, argp, flags,
+				       open_for_write);
 	default:
 		return -ENOTTY;
 	}
@@ -712,6 +713,7 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns = bdev->bd_disk->private_data;
+	bool open_for_write = mode & FMODE_WRITE;
 	void __user *argp = (void __user *)arg;
 	unsigned int flags = 0;
 
@@ -719,19 +721,20 @@ int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		flags |= NVME_IOCTL_PARTITION;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
-	return nvme_ns_ioctl(ns, cmd, argp, flags, mode);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	return nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
 }
 
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns *ns =
 		container_of(file_inode(file)->i_cdev, struct nvme_ns, cdev);
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	void __user *argp = (void __user *)arg;
 
 	if (is_ctrl_ioctl(cmd))
-		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, file->f_mode);
-	return nvme_ns_ioctl(ns, cmd, argp, 0, file->f_mode);
+		return nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
+	return nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
 }
 
 static int nvme_uring_cmd_checks(unsigned int issue_flags)
@@ -800,7 +803,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 #ifdef CONFIG_NVME_MULTIPATH
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
-		fmode_t mode)
+		bool open_for_write)
 	__releases(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -808,7 +811,7 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 
 	nvme_get_ctrl(ns->ctrl);
 	srcu_read_unlock(&head->srcu, srcu_idx);
-	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, mode);
+	ret = nvme_ctrl_ioctl(ns->ctrl, cmd, argp, open_for_write);
 
 	nvme_put_ctrl(ctrl);
 	return ret;
@@ -818,6 +821,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	bool open_for_write = mode & FMODE_WRITE;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
@@ -838,9 +842,9 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 	 */
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-					mode);
+					       open_for_write);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, flags, mode);
+	ret = nvme_ns_ioctl(ns, cmd, argp, flags, open_for_write);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -849,6 +853,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
 		container_of(cdev, struct nvme_ns_head, cdev);
@@ -863,9 +868,9 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 
 	if (is_ctrl_ioctl(cmd))
 		return nvme_ns_head_ctrl_ioctl(ns, cmd, argp, head, srcu_idx,
-				file->f_mode);
+				open_for_write);
 
-	ret = nvme_ns_ioctl(ns, cmd, argp, 0, file->f_mode);
+	ret = nvme_ns_ioctl(ns, cmd, argp, 0, open_for_write);
 out_unlock:
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
@@ -940,7 +945,7 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 }
 
 static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
-		fmode_t mode)
+		bool open_for_write)
 {
 	struct nvme_ns *ns;
 	int ret;
@@ -964,7 +969,7 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 	kref_get(&ns->kref);
 	up_read(&ctrl->namespaces_rwsem);
 
-	ret = nvme_user_cmd(ctrl, ns, argp, 0, mode);
+	ret = nvme_user_cmd(ctrl, ns, argp, 0, open_for_write);
 	nvme_put_ns(ns);
 	return ret;
 
@@ -976,16 +981,17 @@ static int nvme_dev_user_cmd(struct nvme_ctrl *ctrl, void __user *argp,
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct nvme_ctrl *ctrl = file->private_data;
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
-		return nvme_user_cmd(ctrl, NULL, argp, 0, file->f_mode);
+		return nvme_user_cmd(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_ADMIN64_CMD:
-		return nvme_user_cmd64(ctrl, NULL, argp, 0, file->f_mode);
+		return nvme_user_cmd64(ctrl, NULL, argp, 0, open_for_write);
 	case NVME_IOCTL_IO_CMD:
-		return nvme_dev_user_cmd(ctrl, argp, file->f_mode);
+		return nvme_dev_user_cmd(ctrl, argp, open_for_write);
 	case NVME_IOCTL_RESET:
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
-- 
2.39.2

