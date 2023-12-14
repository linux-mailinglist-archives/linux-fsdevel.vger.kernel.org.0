Return-Path: <linux-fsdevel+bounces-6149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F7C813BC9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 21:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2BCF2837B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 20:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD8C6E595;
	Thu, 14 Dec 2023 20:42:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA983FE27;
	Thu, 14 Dec 2023 20:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d35dc7e1bbso18585515ad.1;
        Thu, 14 Dec 2023 12:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702586543; x=1703191343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YL4JpXg+7aZ8VFMlENsPTAhR/w0OMGmrTl+lQ70Zyg=;
        b=F1eO5kGZpcObgDqaDG59/Zv37am6TKkQw9gH+Xf8PfJQWZb45MSxQKZovDCCfjz86e
         YOdgYrRCOqp9ulRdl0mvsariCxQa+H+dWHDHRl34ShHN5LhKapjOwHg0Lgz3hwJaQuey
         o5wiuCvmiF3rcdaHG0PHZ5I8KIpycfI3HUk/Q92IAYIQ6HlS+0lAA+vq9CIsXe72XEjP
         xqFamjJjX77JGG89KfbwQ84kcmzoGiB8nC/KVX5pPf80U9UEuTYG8OeqD89tfL8H0fCa
         zWvsHui/3JCVyBBKmJXltpHkywCQLFi/wb71ULVKhsP0fSO4Kg/omQImw2nS+tcydcy0
         88nA==
X-Gm-Message-State: AOJu0YxObb3+Fpz7wZIIKgX7UQ/qf6eJy/4SXzyTKZO5PcT+Dm797kco
	IFtAQWVWTSWIelA0nIKKuJk=
X-Google-Smtp-Source: AGHT+IGwv70EN2l+tQrTMjAet6CFD/+NvFJ1puUosxXOl8TWBVnfNCVuI2M/Nk3VpCuDta+KqGoJGQ==
X-Received: by 2002:a17:903:120e:b0:1d3:2a94:cb53 with SMTP id l14-20020a170903120e00b001d32a94cb53mr7105456plh.5.1702586543051;
        Thu, 14 Dec 2023 12:42:23 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:bae8:452d:2e24:5984])
        by smtp.gmail.com with ESMTPSA id z21-20020a170902ee1500b001d340c71ccasm5091640plb.275.2023.12.14.12.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 12:42:22 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Avri Altman <avri.altman@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v6 10/20] scsi: core: Query the Block Limits Extension VPD page
Date: Thu, 14 Dec 2023 12:40:43 -0800
Message-ID: <20231214204119.3670625-11-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231214204119.3670625-1-bvanassche@acm.org>
References: <20231214204119.3670625-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 76d369343c7a..74cc3369dd8d 100644
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
index 530918cbfce2..56c4310a741b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3103,6 +3103,18 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
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
@@ -3457,6 +3469,7 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		if (scsi_device_supports_vpd(sdp)) {
 			sd_read_block_provisioning(sdkp);
 			sd_read_block_limits(sdkp);
+			sd_read_block_limits_ext(sdkp);
 			sd_read_block_characteristics(sdkp);
 			sd_zbc_read_zones(sdkp, buffer);
 			sd_read_cpr(sdkp);
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..e4539122f2a2 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -151,6 +151,7 @@ struct scsi_disk {
 	unsigned	urswrz : 1;
 	unsigned	security : 1;
 	unsigned	ignore_medium_access_errors : 1;
+	bool		rscs : 1; /* reduced stream control support */
 };
 #define to_scsi_disk(obj) container_of(obj, struct scsi_disk, disk_dev)
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 10480eb582b2..a1588f3965f9 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -153,6 +153,7 @@ struct scsi_device {
 	struct scsi_vpd __rcu *vpd_pgb0;
 	struct scsi_vpd __rcu *vpd_pgb1;
 	struct scsi_vpd __rcu *vpd_pgb2;
+	struct scsi_vpd __rcu *vpd_pgb7;
 
 	struct scsi_target      *sdev_target;
 

