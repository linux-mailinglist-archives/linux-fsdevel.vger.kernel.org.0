Return-Path: <linux-fsdevel+bounces-56686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4657B1A9BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76BB9189F191
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759E285078;
	Mon,  4 Aug 2025 19:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="MQJa0xO1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93B233D9E
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Aug 2025 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336734; cv=none; b=Bifc5htBvIEAa+O58HFgqoJg2N/6olkcyeD9UlD5TY1ka/PZa+Akng+X0IFVdE8Wo8Fsp/4SrjABa3ppXuMeeoPHhxDQozAJbP4Yi9XuyuchSzp9AsYUEaZJWk6cdm+tSSj2kOICcDrScz+ppBzq50LOi2/TqjP6ph8cGOzCSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336734; c=relaxed/simple;
	bh=c7rbkNvorHYNUyUvX7St0nzo+pvC88RaUChbhCyQ0yY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=SB7pGIgAjDuJi5lAClXToaQtbm4/tYfjP3vHw+T4PfPasW5u2toW6Lts1UusNsFAnI318J1K32Biex84ezpCQZ/CqhA90//tm2X4MSWZRkK8cMlMng7a86wNczu6c/htvqnJACIzHPHzhvvOInAferScd9g9XHy6aOzZP7HbyR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=MQJa0xO1; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 574JZWN7029065
	for <linux-fsdevel@vger.kernel.org>; Mon, 4 Aug 2025 12:45:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=+vcuCKkE+wWLuNEnWz
	pUPZk0WUYjifJncgMJPAgYp0M=; b=MQJa0xO1XmjXXk2pxMAEtnn5RhuaKMbtla
	9ZQd+QrghU9kUyNTi8jK5RDqSOpGneJ/fetT1aqsAnB5sxL2LN37PAeKvDu+1hjO
	gNLtjUzC8oR67K3TsP6SVdUzrchYOwHaDbE/gxymDLztIp8S5IcAZUSGrMzgzyZQ
	pDrngouU4eyePBJzKfx02g+Rl16EmodqEDf21TEoxPK+wCJPHc1KZfShB7ZVsgf/
	kvPuIiSnw6gWEZiVxbobi1ptsYlMGlrnKOKbqVYcNZLHLrqIq4Lfqxzi+EK8D/4U
	Tc1jM91Wvhh0Q/CVmYvmjdIEi0Nle4WNchnifB/ozeNp+evF69YA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48as6xmey9-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Mon, 04 Aug 2025 12:45:31 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Mon, 4 Aug 2025 19:45:13 +0000
Received: by devgpu013.nha3.facebook.com (Postfix, from userid 199522)
	id C6C1C65C1FC; Mon,  4 Aug 2025 12:44:57 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Mon, 4 Aug 2025 12:44:31 -0700
Subject: [PATCH v4] vfio/pci: print vfio-device syspath to fdinfo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250804-show-fdinfo-v4-1-96b14c5691b3@fb.com>
X-B4-Tracking: v=1; b=H4sIAJ4NkWgC/23OsQ7CIBSF4VdpmMUALbY4+R6mA4V7haHFQIOap
 u8ubWKMieM/nC9nIQmih0TO1UIiZJ98mEo0h4oYp6cbUG9LE8GEZB3jNLnwoGj9hIECcqaMbuv
 OICmLewT0z1279qUxhpHOLoL+Gq1ofowsKKdCScG5BGs4u+BwNGHcPOfTHOJrP5frTf3/I9fF4
 Cdp0eihU4P6GP26rm+VDqTq4wAAAA==
To: Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet
	<corbet@lwn.net>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Keith Busch <kbusch@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <kvm@vger.kernel.org>,
        Alex Mastro
	<amastro@fb.com>
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: 6o6XZ-zNVBZmx6yj9sRbu4b1hY8YbLVM
X-Proofpoint-GUID: 6o6XZ-zNVBZmx6yj9sRbu4b1hY8YbLVM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDExNiBTYWx0ZWRfXzVi8TMX6TW// gvxHuZg3dWnt1c83kja701ZqyuSRPQuRz8x2u8klxGVFhYTxXpqBjyGbUhE8GdlTFOEfxdg/et4 IBCJfbt8yNlnVIvJkucOH3U+/STTXUvSTagjSXSJXjmKvllXpfU0f78+8CGQe/CVeoq1TQ4Xo5C
 8bS0mC+IPOKIbOFSQjYFTXzCni7us5QGVU2zxRI4d2cIqM3cnvmSVPcNytO3Zx7B1byZu0moPNA EUqbDHl0V4MJUta5DelmceTmyz93YvYFI9lL4F9iDHFEi2voSuq66SF6jNSkv297ZppKn+VfWi+ 3jH1FzQYCIzePP94SZCyHRrhGJ4JQTqT93Jj8lQkLoEdMOg6cAQNFnZG1IU4XY6SDL8ohiAyBoM
 Je8D8KcJicfRfHB8BRxPrPciBgqElh4GpR0hgBJVD480cuS4gqbAn0U1WPthfPFJ7hyjN+KZ
X-Authority-Analysis: v=2.4 cv=Tc2WtQQh c=1 sm=1 tr=0 ts=68910ddc cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=MILNgg9B0xYF0ryEdecA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_08,2025-08-04_01,2025-03-28_01

Print the PCI device syspath to a vfio device's fdinfo. This enables tools
to query which device is associated with a given vfio device fd.

This results in output like below:

$ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0

Signed-off-by: Alex Mastro <amastro@fb.com>
---
Changes in v4:
- Remove changes to vfio.h
- Link to v3: https://lore.kernel.org/r/20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com
Changes in v3:
- Remove changes to vfio_pci.c
- Add section to Documentation/filesystems/proc.rst
- Link to v2: https://lore.kernel.org/all/20250724-show-fdinfo-v2-1-2952115edc10@fb.com
Changes in v2:
- Instead of PCI bdf, print the fully-qualified syspath (prefixed by
  /sys) to fdinfo.
- Rename the field to "vfio-device-syspath". The term "syspath" was
  chosen for consistency e.g. libudev's usage of the term.
- Link to v1: https://lore.kernel.org/r/20250623-vfio-fdinfo-v1-1-c9cec65a2922@fb.com
---
 Documentation/filesystems/proc.rst | 14 ++++++++++++++
 drivers/vfio/vfio_main.c           | 20 ++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2a17865dfe39..fc5ed3117834 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2162,6 +2162,20 @@ DMA Buffer files
 where 'size' is the size of the DMA buffer in bytes. 'count' is the file count of
 the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
 
+VFIO Device files
+~~~~~~~~~~~~~~~~
+
+::
+
+	pos:    0
+	flags:  02000002
+	mnt_id: 17
+	ino:    5122
+	vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0
+
+where 'vfio-device-syspath' is the sysfs path corresponding to the VFIO device
+file.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
index 1fd261efc582..37a39cee10ed 100644
--- a/drivers/vfio/vfio_main.c
+++ b/drivers/vfio/vfio_main.c
@@ -28,6 +28,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/rwsem.h>
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/string.h>
@@ -1354,6 +1355,22 @@ static int vfio_device_fops_mmap(struct file *filep, struct vm_area_struct *vma)
 	return device->ops->mmap(device, vma);
 }
 
+#ifdef CONFIG_PROC_FS
+static void vfio_device_show_fdinfo(struct seq_file *m, struct file *filep)
+{
+	char *path;
+	struct vfio_device_file *df = filep->private_data;
+	struct vfio_device *device = df->device;
+
+	path = kobject_get_path(&device->dev->kobj, GFP_KERNEL);
+	if (!path)
+		return;
+
+	seq_printf(m, "vfio-device-syspath: /sys%s\n", path);
+	kfree(path);
+}
+#endif
+
 const struct file_operations vfio_device_fops = {
 	.owner		= THIS_MODULE,
 	.open		= vfio_device_fops_cdev_open,
@@ -1363,6 +1380,9 @@ const struct file_operations vfio_device_fops = {
 	.unlocked_ioctl	= vfio_device_fops_unl_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.mmap		= vfio_device_fops_mmap,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= vfio_device_show_fdinfo,
+#endif
 };
 
 static struct vfio_device *vfio_device_from_file(struct file *file)

---
base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
change-id: 20250801-show-fdinfo-ef109ca738cf

Best regards,
-- 
Alex Mastro <amastro@fb.com>


