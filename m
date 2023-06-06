Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65A3723A06
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjFFHn2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236529AbjFFHmQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:42:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED8EE52;
        Tue,  6 Jun 2023 00:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2otnM+h2q2Vr05Ue513L8XbjCWF6SyivDzhbZWcxM4w=; b=SNHo0P3hNkB9JCEe3Vz/VUk+6o
        y7j1336pgqmqWJHypVwNt8FNedqR3cWQTlNKpEzWh5tNLWhBWd7xR271tMevkEcfVBgDkoD78/8y2
        NcU8M9mYpNWdcZOo+POMetj1B2RpQe70qwCvirnpr/LVOjVuCcUH9SaxGCHp1GETxrnqYLSlIb5I0
        XaKlasI/s0W/vSw0zoqnsyzBjGVJoFt683+Id7wtj/N+WveQlE0pmOuAp9uiOBqYTKcJpKSI3Lrem
        cy/b+vh9jNYbOKTFu4uOj+WodBBXfaGU+gMS/AFIvZMffALdVvmv7BgQWjN9Gtw/OijYEjyPqCcUN
        EFeqD9eg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJO-000ZjC-14;
        Tue, 06 Jun 2023 07:41:02 +0000
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
Subject: [PATCH 21/31] scsi: replace the fmode_t argument to ->sg_io_fn with a simple bool
Date:   Tue,  6 Jun 2023 09:39:40 +0200
Message-Id: <20230606073950.225178-22-hch@lst.de>
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
 block/bsg-lib.c         | 2 +-
 block/bsg.c             | 8 +++++---
 drivers/scsi/scsi_bsg.c | 4 ++--
 include/linux/bsg.h     | 2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 435c32373cd68f..b3acdbdb6e7ea8 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -26,7 +26,7 @@ struct bsg_set {
 };
 
 static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
-		fmode_t mode, unsigned int timeout)
+		bool open_for_write, unsigned int timeout)
 {
 	struct bsg_job *job;
 	struct request *rq;
diff --git a/block/bsg.c b/block/bsg.c
index 7eca43f33d7ff8..bec4027842b31e 100644
--- a/block/bsg.c
+++ b/block/bsg.c
@@ -54,7 +54,8 @@ static unsigned int bsg_timeout(struct bsg_device *bd, struct sg_io_v4 *hdr)
 	return max_t(unsigned int, timeout, BLK_MIN_SG_TIMEOUT);
 }
 
-static int bsg_sg_io(struct bsg_device *bd, fmode_t mode, void __user *uarg)
+static int bsg_sg_io(struct bsg_device *bd, bool open_for_write,
+		     void __user *uarg)
 {
 	struct sg_io_v4 hdr;
 	int ret;
@@ -63,7 +64,8 @@ static int bsg_sg_io(struct bsg_device *bd, fmode_t mode, void __user *uarg)
 		return -EFAULT;
 	if (hdr.guard != 'Q')
 		return -EINVAL;
-	ret = bd->sg_io_fn(bd->queue, &hdr, mode, bsg_timeout(bd, &hdr));
+	ret = bd->sg_io_fn(bd->queue, &hdr, open_for_write,
+			   bsg_timeout(bd, &hdr));
 	if (!ret && copy_to_user(uarg, &hdr, sizeof(hdr)))
 		return -EFAULT;
 	return ret;
@@ -146,7 +148,7 @@ static long bsg_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case SG_EMULATED_HOST:
 		return put_user(1, intp);
 	case SG_IO:
-		return bsg_sg_io(bd, file->f_mode, uarg);
+		return bsg_sg_io(bd, file->f_mode & FMODE_WRITE, uarg);
 	case SCSI_IOCTL_SEND_COMMAND:
 		pr_warn_ratelimited("%s: calling unsupported SCSI_IOCTL_SEND_COMMAND\n",
 				current->comm);
diff --git a/drivers/scsi/scsi_bsg.c b/drivers/scsi/scsi_bsg.c
index 12431f35f861e1..a9a9ec086a7e3f 100644
--- a/drivers/scsi/scsi_bsg.c
+++ b/drivers/scsi/scsi_bsg.c
@@ -10,7 +10,7 @@
 #define uptr64(val) ((void __user *)(uintptr_t)(val))
 
 static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
-		fmode_t mode, unsigned int timeout)
+		bool open_for_write, unsigned int timeout)
 {
 	struct scsi_cmnd *scmd;
 	struct request *rq;
@@ -42,7 +42,7 @@ static int scsi_bsg_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	if (copy_from_user(scmd->cmnd, uptr64(hdr->request), scmd->cmd_len))
 		goto out_put_request;
 	ret = -EPERM;
-	if (!scsi_cmd_allowed(scmd->cmnd, mode & FMODE_WRITE))
+	if (!scsi_cmd_allowed(scmd->cmnd, open_for_write))
 		goto out_put_request;
 
 	ret = 0;
diff --git a/include/linux/bsg.h b/include/linux/bsg.h
index 1ac81c809da9b3..ee2df73edf83f8 100644
--- a/include/linux/bsg.h
+++ b/include/linux/bsg.h
@@ -9,7 +9,7 @@ struct device;
 struct request_queue;
 
 typedef int (bsg_sg_io_fn)(struct request_queue *, struct sg_io_v4 *hdr,
-		fmode_t mode, unsigned int timeout);
+		bool open_for_write, unsigned int timeout);
 
 struct bsg_device *bsg_register_queue(struct request_queue *q,
 		struct device *parent, const char *name,
-- 
2.39.2

