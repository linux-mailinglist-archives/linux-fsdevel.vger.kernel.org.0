Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF1B727E45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbjFHLGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 07:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjFHLFJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58942D60;
        Thu,  8 Jun 2023 04:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=D+1s3WT+5DpsHw6D0N73ilbFCvVf0P+vhIMd+8ZE9LA=; b=40Te1n4Dyq79Fvl8DiG/4q/bRo
        VTK3fXaSnaNNg1uOs526jLkNTpHwlbTJt5jmBxhgZxaikDudUl5mm+mGUQuUPzTI+l3GxVc9KxxXn
        M0u9wkYFM1nlyleudq0pRlJRKmHm0M/ldAYGoysH/K2SaONPz05psQK0kO5bzoQgK4WqStI0m6KqL
        7jJzBJE4GL4xkU2KnLRRgd3OeBmywzsBlmlcWFhtymotB+hEmhzNWDG6W9CXpPMrNHdrxWxBOjdWm
        w7NtmU2XUqlRvQQJZZu/4nEZCVfDMTNSJR0uNM+71E6h4npceh/JitURnDS2n4/7TzJnLyOygUh2S
        mv3c6bbg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q7DQj-0092O2-23;
        Thu, 08 Jun 2023 11:03:49 +0000
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
        linux-pm@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/30] scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool
Date:   Thu,  8 Jun 2023 13:02:46 +0200
Message-Id: <20230608110258.189493-19-hch@lst.de>
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

Instead of passing a fmode_t and only checking it for FMODE_WRITE, pass
a bool open_for_write to prepare for callers that won't have the fmode_t.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
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

