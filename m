Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D36C723A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236654AbjFFHoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236655AbjFFHnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:43:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6591BC0;
        Tue,  6 Jun 2023 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vLDKGJIN4sUAMcx+ss63SchZIFVZL96BaI3AvIUMzr4=; b=Kqz67xYl70ncmp7C+TTho2ZAwh
        yxMVvfTUe4ptMIvjyzv5W3/oGptcu3lODz1GZfs1Dzmfa07wbMjg2x6XNkhPoXVVT8TeEzZ5+vZ85
        v1qggGnWqxY2bsFKIizZ6LsxrrrPNciu1JwJMH/tySvoqXcRfyJlv85UdaK+gMvOpcMhP0h4rkSzj
        dd9SWrGeDfCkJGWmtE8+Nh6i9voVwKacayAFzTn1gmxkmc1YJhF7r0Oan23F9ssgVCUQ9Cg3Op4+o
        gDpWg+ZYjjYuzSCNiQl39lt4KnyhQ9DBoM37xAlqu7P4qY4UvMmUgGNWibsjTk/rgEvj+LqaFZPLH
        vE5IjFEw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RJX-000Zqu-1D;
        Tue, 06 Jun 2023 07:41:11 +0000
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
Subject: [PATCH 24/31] rnbd-srv: replace sess->open_flags with a "bool readonly"
Date:   Tue,  6 Jun 2023 09:39:43 +0200
Message-Id: <20230606073950.225178-25-hch@lst.de>
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

Stop passing the fmode_t around and just use a simple bool to track if
an export is read-only.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c |  3 +--
 drivers/block/rnbd/rnbd-srv.c       | 15 +++++++--------
 drivers/block/rnbd/rnbd-srv.h       |  2 +-
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index d5d9267e1fa5e4..ebd95771c85ec7 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -88,8 +88,7 @@ static ssize_t read_only_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	sess_dev = container_of(kobj, struct rnbd_srv_sess_dev, kobj);
 
-	return sysfs_emit(page, "%d\n",
-			  !(sess_dev->open_flags & FMODE_WRITE));
+	return sysfs_emit(page, "%d\n", sess_dev->readonly);
 }
 
 static struct kobj_attribute rnbd_srv_dev_session_ro_attr =
diff --git a/drivers/block/rnbd/rnbd-srv.c b/drivers/block/rnbd/rnbd-srv.c
index 29d560472d05ba..b680071342b898 100644
--- a/drivers/block/rnbd/rnbd-srv.c
+++ b/drivers/block/rnbd/rnbd-srv.c
@@ -222,7 +222,7 @@ void rnbd_destroy_sess_dev(struct rnbd_srv_sess_dev *sess_dev, bool keep_id)
 	blkdev_put(sess_dev->bdev, NULL);
 	mutex_lock(&sess_dev->dev->lock);
 	list_del(&sess_dev->dev_list);
-	if (sess_dev->open_flags & FMODE_WRITE)
+	if (!sess_dev->readonly)
 		sess_dev->dev->open_write_cnt--;
 	mutex_unlock(&sess_dev->dev->lock);
 
@@ -561,7 +561,7 @@ static void rnbd_srv_fill_msg_open_rsp(struct rnbd_msg_open_rsp *rsp,
 static struct rnbd_srv_sess_dev *
 rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 			      const struct rnbd_msg_open *open_msg,
-			      struct block_device *bdev, fmode_t open_flags,
+			      struct block_device *bdev, bool readonly,
 			      struct rnbd_srv_dev *srv_dev)
 {
 	struct rnbd_srv_sess_dev *sdev = rnbd_sess_dev_alloc(srv_sess);
@@ -576,7 +576,7 @@ rnbd_srv_create_set_sess_dev(struct rnbd_srv_session *srv_sess,
 	sdev->bdev		= bdev;
 	sdev->sess		= srv_sess;
 	sdev->dev		= srv_dev;
-	sdev->open_flags	= open_flags;
+	sdev->readonly		= readonly;
 	sdev->access_mode	= open_msg->access_mode;
 
 	return sdev;
@@ -681,13 +681,12 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 	struct rnbd_srv_sess_dev *srv_sess_dev;
 	const struct rnbd_msg_open *open_msg = msg;
 	struct block_device *bdev;
-	fmode_t open_flags;
+	fmode_t open_flags = FMODE_READ;
 	char *full_path;
 	struct rnbd_msg_open_rsp *rsp = data;
 
 	trace_process_msg_open(srv_sess, open_msg);
 
-	open_flags = FMODE_READ;
 	if (open_msg->access_mode != RNBD_ACCESS_RO)
 		open_flags |= FMODE_WRITE;
 
@@ -736,9 +735,9 @@ static int process_msg_open(struct rnbd_srv_session *srv_sess,
 		goto blkdev_put;
 	}
 
-	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg,
-						     bdev, open_flags,
-						     srv_dev);
+	srv_sess_dev = rnbd_srv_create_set_sess_dev(srv_sess, open_msg, bdev,
+				open_msg->access_mode == RNBD_ACCESS_RO,
+				srv_dev);
 	if (IS_ERR(srv_sess_dev)) {
 		pr_err("Opening device '%s' on session %s failed, creating sess_dev failed, err: %ld\n",
 		       full_path, srv_sess->sessname, PTR_ERR(srv_sess_dev));
diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
index f5962fd31d62e4..76077a9db3dd55 100644
--- a/drivers/block/rnbd/rnbd-srv.h
+++ b/drivers/block/rnbd/rnbd-srv.h
@@ -52,7 +52,7 @@ struct rnbd_srv_sess_dev {
 	struct kobject                  kobj;
 	u32                             device_id;
 	bool				keep_id;
-	fmode_t                         open_flags;
+	bool				readonly;
 	struct kref			kref;
 	struct completion               *destroy_comp;
 	char				pathname[NAME_MAX];
-- 
2.39.2

