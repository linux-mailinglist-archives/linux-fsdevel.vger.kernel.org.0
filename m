Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704B3129B98
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 23:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfLWW4N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 17:56:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49739 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727072AbfLWW4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:56:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577141769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jqpmf7hQ+PQiGEtZK47/PMHEWUmQlrFIk294J3iPG3M=;
        b=CPI3uT0U9f/yLJ8Gtst+kFcjYOAP7xaF4n178JtRgZQRqnbysO4FBW0XDwNsKmpWG8Tsgq
        u30oTay5PoxfmOx5icBCiK6vtVnBjmC8DqOpP4v/SEu/PBDgzeJG6GjlT3mKycS7MPc2zA
        qIp9k3lka3fx19+6fakgjrny39vwtyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-7wSF-REIMnyRq5dNXy_yRg-1; Mon, 23 Dec 2019 17:56:08 -0500
X-MC-Unique: 7wSF-REIMnyRq5dNXy_yRg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EC64801E74;
        Mon, 23 Dec 2019 22:56:07 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-13.rdu2.redhat.com [10.10.112.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B16C60BE2;
        Mon, 23 Dec 2019 22:56:06 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 5/9] block: Add support functions for persistent durable name
Date:   Mon, 23 Dec 2019 16:55:54 -0600
Message-Id: <20191223225558.19242-6-tasleson@redhat.com>
In-Reply-To: <20191223225558.19242-1-tasleson@redhat.com>
References: <20191223225558.19242-1-tasleson@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add functions to retrieve and build durable name string into supplied
buffer for functions that log using struct device and struct scsi_device.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 drivers/base/core.c        | 24 ++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c    | 20 ++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c  |  1 +
 include/linux/device.h     |  2 ++
 include/scsi/scsi_device.h |  3 +++
 5 files changed, 50 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 7bd9cd366d41..93cc1c45e9d3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2009,6 +2009,30 @@ int dev_set_name(struct device *dev, const char *f=
mt, ...)
 }
 EXPORT_SYMBOL_GPL(dev_set_name);
=20
+/**
+ * dev_durable_name - Write "DURABLE_NAME"=3D<durable name> in buffer
+ * @dev: device
+ * @buffer: character buffer to write results
+ * @len: length of buffer
+ * @return Number of bytes written to buffer
+ */
+int dev_durable_name(const struct device *dev, char *buffer, size_t len)
+{
+	int tmp, dlen;
+
+	if (dev->type && dev->type->durable_name) {
+		tmp =3D snprintf(buffer, len, "DURABLE_NAME=3D");
+		if (tmp < len) {
+			dlen =3D dev->type->durable_name(dev, buffer + tmp,
+							len - tmp);
+			if (dlen > 0 && ((dlen + tmp) < len))
+				return dlen + tmp;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_durable_name);
+
 /**
  * device_to_dev_kobj - select a /sys/dev/ directory for the device
  * @dev: device
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 91c007d26c1e..f22e59253d9d 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3120,3 +3120,23 @@ int scsi_vpd_tpg_id(struct scsi_device *sdev, int =
*rel_id)
 	return group_id;
 }
 EXPORT_SYMBOL(scsi_vpd_tpg_id);
+
+int dev_to_scsi_durable_name(const struct device *dev, char *buf, size_t=
 len)
+{
+	return scsi_durable_name(to_scsi_device(dev), buf, len);
+}
+EXPORT_SYMBOL(dev_to_scsi_durable_name);
+
+int scsi_durable_name(struct scsi_device *sdev, char *buf, size_t len)
+{
+	int vpd_len =3D 0;
+
+	vpd_len =3D scsi_vpd_lun_id(sdev, buf, len);
+	if (vpd_len > 0 && vpd_len < len)
+		vpd_len =3D strim_dupe(buf) + 1;
+	else
+		vpd_len =3D 0;
+
+	return vpd_len;
+}
+EXPORT_SYMBOL(scsi_durable_name);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 6d7362e7367e..ee5b8197916f 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1560,6 +1560,7 @@ static struct device_type scsi_dev_type =3D {
 	.name =3D		"scsi_device",
 	.release =3D	scsi_device_dev_release,
 	.groups =3D	scsi_sdev_attr_groups,
+	.durable_name =3D dev_to_scsi_durable_name,
 };
=20
 void scsi_sysfs_device_initialize(struct scsi_device *sdev)
diff --git a/include/linux/device.h b/include/linux/device.h
index dd4ac8db5f57..566f6be6ee0d 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1350,6 +1350,8 @@ static inline const char *dev_name(const struct dev=
ice *dev)
 extern __printf(2, 3)
 int dev_set_name(struct device *dev, const char *name, ...);
=20
+int dev_durable_name(const struct device *d, char *buffer, size_t len);
+
 #ifdef CONFIG_NUMA
 static inline int dev_to_node(struct device *dev)
 {
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 202f4d6a4342..1cb35e10f54a 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -455,6 +455,9 @@ extern void sdev_disable_disk_events(struct scsi_devi=
ce *sdev);
 extern void sdev_enable_disk_events(struct scsi_device *sdev);
 extern int scsi_vpd_lun_id(struct scsi_device *, char *, size_t);
 extern int scsi_vpd_tpg_id(struct scsi_device *, int *);
+extern int dev_to_scsi_durable_name(const struct device *dev, char *buf,
+					size_t len);
+extern int scsi_durable_name(struct scsi_device *sdev, char *buf, size_t=
 len);
=20
 #ifdef CONFIG_PM
 extern int scsi_autopm_get_device(struct scsi_device *);
--=20
2.21.0

