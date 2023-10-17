Return-Path: <linux-fsdevel+bounces-567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B067CCEA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 22:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3DC2819CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 20:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF40B2E41E;
	Tue, 17 Oct 2023 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8503A2D055
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 20:48:26 +0000 (UTC)
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AE79F;
	Tue, 17 Oct 2023 13:48:25 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-581b6b93bd1so1541938eaf.1;
        Tue, 17 Oct 2023 13:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697575704; x=1698180504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29C1aI2A2KGCyq9yUe4PdFSu3conZ39y3j9E4Fn9lFo=;
        b=j9LncJK8KKfvkioT8Q21lW79nOTP87JFPP2ux04k12QwwkUYgQauzAKlrpumiLyrUs
         3s3eEnl3zD9gAhXtrDD31CC5g0d6MyMN7ezjBWtPs7rxV0vlsJNDDOQb/igQ+hPp1/zT
         XZKtA9C5xj0JudsjDPxroeqxeoMFD9DrUL0n0kFNT3Dbz4roBuPqM5UmRAC0oKljTi51
         y3A2qKleolR06oY/9+iBLIIC2iLX86p8pOJySbEldtLy4Y3vv7Iz22MbombjFRbsFu2t
         AotsXJkKXg/tSp4e/Wa29aYNuIw5bubPIUzWFiZJsOQiO/rQXMQrAFHnDYHyeyRc/7iF
         taZg==
X-Gm-Message-State: AOJu0Yzo4wk3eyWUJO625J8RqB9ZVHT63Jf5ych9/YkS3ri9LCuGIlVH
	Y6fMJWMwDy36FdihykkkTtk=
X-Google-Smtp-Source: AGHT+IGsmXt7VpkLw0tEtaclHjsoZRsI/bJIG6ugvFa+zQMCcSze01pj0EjA5AExdkd8s3WJ4VSHUg==
X-Received: by 2002:a05:6358:c62a:b0:166:ce95:7122 with SMTP id fd42-20020a056358c62a00b00166ce957122mr3802323rwb.14.1697575704430;
        Tue, 17 Oct 2023 13:48:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:8f02:2919:9600:ac09])
        by smtp.gmail.com with ESMTPSA id fa36-20020a056a002d2400b006b2e07a6235sm1874704pfb.136.2023.10.17.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 13:48:24 -0700 (PDT)
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>,
	Daejun Park <daejun7.park@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 05/14] scsi: core: Query the Block Limits Extension VPD page
Date: Tue, 17 Oct 2023 13:47:13 -0700
Message-ID: <20231017204739.3409052-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017204739.3409052-1-bvanassche@acm.org>
References: <20231017204739.3409052-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Parse the Reduced Stream Control Supported (RSCS) bit from the block
limits extension VPD page. The RSCS bit is defined in SBC-5 r05
(https://www.t10.org/cgi-bin/ac.pl?t=f&f=sbc5r05.pdf).

Reviewed-by: Avri Altman <avri.altman@wdc.com>
Reviewed-by: Daejun Park <daejun7.park@samsung.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c        |  2 ++
 drivers/scsi/scsi_sysfs.c  | 10 ++++++++++
 drivers/scsi/sd.c          | 13 +++++++++++++
 drivers/scsi/sd.h          |  1 +
 include/scsi/scsi_device.h |  1 +
 5 files changed, 27 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d0911bc28663..5ad291770806 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -499,6 +499,8 @@ void scsi_attach_vpd(struct scsi_device *sdev)
 			scsi_update_vpd_page(sdev, 0xb1, &sdev->vpd_pgb1);
 		if (vpd_buf->data[i] == 0xb2)
 			scsi_update_vpd_page(sdev, 0xb2, &sdev->vpd_pgb2);
+		if (vpd_buf->data[i] == 0xb7)
+			scsi_update_vpd_page(sdev, 0xb7, &sdev->vpd_pgb7);
 	}
 	kfree(vpd_buf);
 }
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..93652a786a46 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -449,6 +449,7 @@ static void scsi_device_dev_release(struct device *dev)
 	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
 	struct scsi_vpd *vpd_pg0 = NULL, *vpd_pg89 = NULL;
 	struct scsi_vpd *vpd_pgb0 = NULL, *vpd_pgb1 = NULL, *vpd_pgb2 = NULL;
+	struct scsi_vpd *vpd_pgb7 = NULL;
 	unsigned long flags;
 
 	might_sleep();
@@ -494,6 +495,8 @@ static void scsi_device_dev_release(struct device *dev)
 				       lockdep_is_held(&sdev->inquiry_mutex));
 	vpd_pgb2 = rcu_replace_pointer(sdev->vpd_pgb2, vpd_pgb2,
 				       lockdep_is_held(&sdev->inquiry_mutex));
+	vpd_pgb7 = rcu_replace_pointer(sdev->vpd_pgb7, vpd_pgb7,
+				       lockdep_is_held(&sdev->inquiry_mutex));
 	mutex_unlock(&sdev->inquiry_mutex);
 
 	if (vpd_pg0)
@@ -510,6 +513,8 @@ static void scsi_device_dev_release(struct device *dev)
 		kfree_rcu(vpd_pgb1, rcu);
 	if (vpd_pgb2)
 		kfree_rcu(vpd_pgb2, rcu);
+	if (vpd_pgb7)
+		kfree_rcu(vpd_pgb7, rcu);
 	kfree(sdev->inquiry);
 	kfree(sdev);
 
@@ -921,6 +926,7 @@ sdev_vpd_pg_attr(pg89);
 sdev_vpd_pg_attr(pgb0);
 sdev_vpd_pg_attr(pgb1);
 sdev_vpd_pg_attr(pgb2);
+sdev_vpd_pg_attr(pgb7);
 sdev_vpd_pg_attr(pg0);
 
 static ssize_t show_inquiry(struct file *filep, struct kobject *kobj,
@@ -1295,6 +1301,9 @@ static umode_t scsi_sdev_bin_attr_is_visible(struct kobject *kobj,
 	if (attr == &dev_attr_vpd_pgb2 && !sdev->vpd_pgb2)
 		return 0;
 
+	if (attr == &dev_attr_vpd_pgb7 && !sdev->vpd_pgb7)
+		return 0;
+
 	return S_IRUGO;
 }
 
@@ -1347,6 +1356,7 @@ static struct bin_attribute *scsi_sdev_bin_attrs[] = {
 	&dev_attr_vpd_pgb0,
 	&dev_attr_vpd_pgb1,
 	&dev_attr_vpd_pgb2,
+	&dev_attr_vpd_pgb7,
 	&dev_attr_inquiry,
 	NULL
 };
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index c92a317ba547..879edbc1a065 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3019,6 +3019,18 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 	rcu_read_unlock();
 }
 
+/* Parse the Block Limits Extension VPD page (0xb7) */
+static void sd_read_block_limits_ext(struct scsi_disk *sdkp)
+{
+	struct scsi_vpd *vpd;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdkp->device->vpd_pgb7);
+	if (vpd && vpd->len >= 2)
+		sdkp->rscs = vpd->data[5] & 1;
+	rcu_read_unlock();
+}
+
 /**
  * sd_read_block_characteristics - Query block dev. characteristics
  * @sdkp: disk to query
@@ -3373,6 +3385,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
+			sd_read_block_limits_ext(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
 			sd_read_cpr(sdkp);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 5eea762f84d1..84685168b6e0 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -150,6 +150,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	bool		rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index b9230b6add04..2dd96ae101e1 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -153,6 +153,7 @@ struct scsi_device {
 	struct scsi_vpd __rcu *vpd_pgb0;
 	struct scsi_vpd __rcu *vpd_pgb1;
 	struct scsi_vpd __rcu *vpd_pgb2;
+	struct scsi_vpd __rcu *vpd_pgb7;
 
 	struct scsi_target      *sdev_target;
 

