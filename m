Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AB105830
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 18:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfKURNw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 12:13:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:54298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727197AbfKURNp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 12:13:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11510B2A1;
        Thu, 21 Nov 2019 17:13:44 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 10/10] scsi: sr: wait for the medium to become ready
Date:   Thu, 21 Nov 2019 18:13:17 +0100
Message-Id: <c0c769f470be6a91b80fbd92658a3012a7225455.1574355709.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574355709.git.msuchanek@suse.de>
References: <cover.1574355709.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the autoclose function provided by cdrom driver to wait for drive to
close in open_finish, and attempt to open once more after the door
closes.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
v3: use function call rather than IOCTL
v4: fix reference leak on -ENXIO
---
 drivers/scsi/sr.c | 54 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 07c319494bf4..41ddf08b4c7b 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -522,29 +522,58 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	return ret;
 }
 
-static int sr_block_open(struct block_device *bdev, fmode_t mode)
+static int __sr_block_open(struct block_device *bdev, fmode_t mode)
 {
-	struct scsi_cd *cd;
-	struct scsi_device *sdev;
-	int ret = -ENXIO;
-
-	cd = scsi_cd_get(bdev->bd_disk);
-	if (!cd)
-		goto out;
+	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
+	int ret;
 
-	sdev = cd->device;
-	scsi_autopm_get_device(sdev);
 	check_disk_change(bdev);
 
 	mutex_lock(&sr_mutex);
 	ret = cdrom_open(&cd->cdi, bdev, mode);
 	mutex_unlock(&sr_mutex);
 
+	return ret;
+}
+
+static int sr_block_open(struct block_device *bdev, fmode_t mode)
+{
+	struct scsi_cd *cd = scsi_cd_get(bdev->bd_disk);
+	struct scsi_device *sdev;
+	int ret;
+
+	if (!cd)
+		return -ENXIO;
+
+	sdev = cd->device;
+	scsi_autopm_get_device(sdev);
+	ret = __sr_block_open(bdev, mode);
 	scsi_autopm_put_device(sdev);
-	if (ret)
+
+	if ((ret == -ERESTARTSYS) || (ret == -ENXIO))
 		scsi_cd_put(cd);
 
-out:
+	return ret;
+}
+
+static int sr_block_open_finish(struct block_device *bdev, fmode_t mode,
+				int ret)
+{
+	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
+
+	/* wait for drive to get ready */
+	if ((ret == -ENOMEDIUM) && !(mode & FMODE_NDELAY)) {
+		struct scsi_device *sdev = cd->device;
+		/*
+		 * Cannot use sr_block_ioctl because it locks sr_mutex blocking
+		 * out any processes trying to access the drive
+		 */
+		scsi_autopm_get_device(sdev);
+		cdrom_autoclose(&cd->cdi);
+		ret = __sr_block_open(bdev, mode);
+		scsi_autopm_put_device(sdev);
+	}
+
 	return ret;
 }
 
@@ -640,6 +669,7 @@ static const struct block_device_operations sr_bdops =
 {
 	.owner		= THIS_MODULE,
 	.open		= sr_block_open,
+	.open_finish	= sr_block_open_finish,
 	.release	= sr_block_release,
 	.ioctl		= sr_block_ioctl,
 	.check_events	= sr_block_check_events,
-- 
2.23.0

