Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295F97239FB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjFFHnY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjFFHmP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:42:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E5E64;
        Tue,  6 Jun 2023 00:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=3oobpK0I71CFipYMnkLmr3dHEuRlArP1BTxUWt63+Iw=; b=Rb34amWhb/J6SdllZhBnBaIpWi
        KUt+llcgkwzWM92BIcNAp4ExNHPt6bTYyfe/HqtT+Ygyoea+7dphS6ckMDqefBW7ntbmRuCsblhZ2
        rloc+oUH88AGQ+iodSYQ7eLa1MOg5M9txYsRdbvm1La+vPcrGGlqDQ+rWO8cuVaET8LMBVg+djeEF
        avLlFkj7kG2Uk5mJ7YH/MDePsleY3BuwgsUumfaNe23QpIgicon+pLWS+IcOoUHSnYryjKpqIy+96
        gJYLNRQg/Bny+ZvZXVAarVf9oqqRFURrR6k4cooGuNfT5pQygIZFluIL+Ggt7S86QXjZe5Z5z53Bf
        9R2jcXuQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJH-000Zcn-32;
        Tue, 06 Jun 2023 07:40:56 +0000
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
Subject: [PATCH 19/31] scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool
Date:   Tue,  6 Jun 2023 09:39:38 +0200
Message-Id: <20230606073950.225178-20-hch@lst.de>
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

Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
a bool open_for_write to prepare for callers that won't have the fmode_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_bsg.c   | 2 +-
 drivers/scsi/scsi_ioctl.c | 8 ++++----
 drivers/scsi/sg.c         | 2 +-
 include/scsi/scsi_ioctl.h | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 96ee35256a168f..12431f35f861e1 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -42,7 +42,7 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	if (copy_from_user(scmd->cmnd, uptr64(hdr->request), scmd->cmd_len))
 		goto out_put_request;
 	ret = -EPERM;
-	if (!scsi_cmd_allowed(scmd->cmnd, mode))
+	if (!scsi_cmd_allowed(scmd->cmnd, mode & FMODE_WRITE))
 		goto out_put_request;
 
 	ret = 0;
diff --git a/drivers/scsi/scsi_ioctl.c b/drivers/scsi/scsi_ioctl.c
index e3b31d32b6a92e..dda5468ca97f90 100644
--- a/drivers/scsi/scsi_ioctl.c
+++ b/drivers/scsi/scsi_ioctl.c
@@ -248,7 +248,7 @@ static int scsi_send_start_stop(struct scsi_device *sdev, int data)
  * Only a subset of commands are allowed for unprivileged users. Commands used
  * to format the media, update the firmware, etc. are not permitted.
  */
-bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode)
+bool scsi_cmd_allowed(unsigned char *cmd, bool open_for_write)
 {
 	/* root can do any command. */
 	if (capable(CAP_SYS_RAWIO))
@@ -338,7 +338,7 @@ bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode)
 	case GPCMD_SET_READ_AHEAD:
 	/* ZBC */
 	case ZBC_OUT:
-		return (mode & FMODE_WRITE);
+		return open_for_write;
 	default:
 		return false;
 	}
@@ -354,7 +354,7 @@ static int scsi_fill_sghdr_rq(struct scsi_device *sdev, struct request *rq,
 		return -EMSGSIZE;
 	if (copy_from_user(scmd->cmnd, hdr->cmdp, hdr->cmd_len))
 		return -EFAULT;
-	if (!scsi_cmd_allowed(scmd->cmnd, mode))
+	if (!scsi_cmd_allowed(scmd->cmnd, mode & FMODE_WRITE))
 		return -EPERM;
 	scmd->cmd_len = hdr->cmd_len;
 
@@ -554,7 +554,7 @@ static int sg_scsi_ioctl(struct request_queue *q, fmode_t mode,
 		goto error;
 
 	err = -EPERM;
-	if (!scsi_cmd_allowed(scmd->cmnd, mode))
+	if (!scsi_cmd_allowed(scmd->cmnd, mode & FMODE_WRITE))
 		goto error;
 
 	/* default.  possible overridden later */
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 037f8c98a6d364..e49ea693d0b656 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -237,7 +237,7 @@ static int sg_allow_access(struct file *filp, unsigned char *cmd)
 
 	if (sfp->parentdp->device->type == TYPE_SCANNER)
 		return 0;
-	if (!scsi_cmd_allowed(cmd, filp->f_mode))
+	if (!scsi_cmd_allowed(cmd, filp->f_mode & FMODE_WRITE))
 		return -EPERM;
 	return 0;
 }
diff --git a/include/scsi/scsi_ioctl.h b/include/scsi/scsi_ioctl.h
index beac64e38b8746..914201a8cb947c 100644
--- a/include/scsi/scsi_ioctl.h
+++ b/include/scsi/scsi_ioctl.h
@@ -49,7 +49,7 @@ int scsi_ioctl(struct scsi_device *sdev, fmode_t mode, int cmd,
 		void __user *arg);
 int get_sg_io_hdr(struct sg_io_hdr *hdr, const void __user *argp);
 int put_sg_io_hdr(const struct sg_io_hdr *hdr, void __user *argp);
-bool scsi_cmd_allowed(unsigned char *cmd, fmode_t mode);
+bool scsi_cmd_allowed(unsigned char *cmd, bool open_for_write);
 
 #endif /* __KERNEL__ */
 #endif /* _SCSI_IOCTL_H */
-- 
2.39.2

