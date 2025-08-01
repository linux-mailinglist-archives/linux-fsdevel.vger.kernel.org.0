Return-Path: <linux-fsdevel+bounces-56534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101DB18851
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 22:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626A57AFF7C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 20:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1F628DB77;
	Fri,  1 Aug 2025 20:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="3vSHthdp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541FC28751A
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 20:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081481; cv=none; b=qKKpF862Sq2ixgx505+N1z5N7kyaJyaO2R91rUjCigulQawPW8fXXIHVs4iipa0n28NAl/QjlQCgRt5RoUCLxMCgTNZPsW36m+SwCBbzK6Rq8XS1JJcfJPNOQTU/JdXyuou/QYMUYh+EgmfBbnF5Ef7wgdohjxgjSixTvlh+aQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081481; c=relaxed/simple;
	bh=xlUOQJI0xX3aYBcyXPghiHPXjSV2N2PF1hyKruz+imM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fV/m5pVX+hHkYMKW/itr0/gM+ffv9anUbaQE9SHwDnrNdM0DHqpYP1XPhJq/teqaoQmnUVNY7cEIXTFXqO9Znl/cOnIwjeOAqLdQhJFCiKVvxy5uAhr3b/cXMQ4HY8Knprw9e+pirfL7FHzInNh6gCQERrzVwc07cgPlTv02u8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=3vSHthdp; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571JmsD3032016
	for <linux-fsdevel@vger.kernel.org>; Fri, 1 Aug 2025 13:51:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=Jb4LS8ieZ/yMT4TW1d
	HPQYW0A8QAnqTZwf9KjQDya2Q=; b=3vSHthdpJebEzHzwWUTidFd1HPt9R9Hipm
	2+Hak+Y5X/SXomoOcgMc3LGCU1mo7kbP/EeJY3AYhCheoFgUSe6Iv3DNviT86/rk
	gl1MQtEhE3vJt1HWouZw132deOgvTkfJqSQpiRRJx5dPHjiPQ5UmLwTfxEzdATXi
	PYp64YbzMgFUKsdcnQFDMmV1Kr0dlM9BtraIb4Im9cZeV9GLAeIxPfpXlJqRYj/k
	NYnW6Y7F7y0S4tXW6w38hdQS8O8QnzF68ce1HJM3biDiW/MWThgWhm5NLKVpVp5Q
	1CuaWsqf9ZW17eAMi7mtfWKnSKt6YqvN9elBAIpAyaAa9nchmZ2g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488rn2mr35-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 13:51:18 -0700 (PDT)
Received: from twshared24438.15.frc2.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 20:51:15 +0000
Received: by devgpu013.nha3.facebook.com (Postfix, from userid 199522)
	id 1BB5D4A4CD7; Fri,  1 Aug 2025 13:51:07 -0700 (PDT)
From: Alex Mastro <amastro@fb.com>
Date: Fri, 1 Aug 2025 13:50:56 -0700
Subject: [PATCH v3] vfio/pci: print vfio-device syspath to fdinfo
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250801-show-fdinfo-v3-1-165dfcab89b9@fb.com>
X-B4-Tracking: v=1; b=H4sIAK8ojWgC/1XMsQ7CIBCA4VdpbvYMRyVtnfoexgHhThgKBkw1a
 fruEhfj+A3/v0HlErnCudug8BprzKmhP3Tggk13xuibQStt1KgIa8gvFB+TZGQhNTk79KMTaMW
 jsMT393a5NkvJCz5DYft7DPr091g1EurJaCLD3pGa5XZ0eYF9/wBbhsvZnQAAAA==
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
X-Proofpoint-ORIG-GUID: bLvhzKaWdgXcXU8nKN7idTiM0bofJ0FA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE2NiBTYWx0ZWRfX7NYBoViRyXiq KOh5k5WIh0mNQgZfy5RcuoBEhB+b4xY5pWwpH5BY0m5hXvlOiB6v3qDkgvSwYDyB1FEkEhTDzUw 3UGao0NpBUN5cgqboGJDIwT1ZoI+dMOoGmQKLsh3H8u1R+wCserpTusWxSiLqtBdnkF5fmeKN1g
 NYXoMKWvtU4jed+L/Ej9/TE+0x1Q8j4xA5gKaCzQ0XDlNkr9lUv5CCAiDx61hLcFqPzz86ZNWM7 zu4Kyetdqj2jgTPD9WfNHVCn+yLpf87G4gTHMdvXvQI2D3e4PjCDRB514Phpz0BvgwAUjO+1lPv WCtIeWh8aH+c6ltlXmEg5CI2iDSETAQyIq8cEh0YLwpVKLb71FXswXnnx3mh95CinDYFgBYcVnc
 r/3BzqqA59Jmw3r6P6u1AIoSm3FZbFcRhkDOysSfMI8wY6SiDf5Gw2zvkNVYvsBmP3gRLA5T
X-Authority-Analysis: v=2.4 cv=HOnDFptv c=1 sm=1 tr=0 ts=688d28c6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=DFnZXp7rDhDadfPsBKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bLvhzKaWdgXcXU8nKN7idTiM0bofJ0FA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_07,2025-08-01_01,2025-03-28_01

Print the PCI device syspath to a vfio device's fdinfo. This enables tools
to query which device is associated with a given vfio device fd.

This results in output like below:

$ cat /proc/"$SOME_PID"/fdinfo/"$VFIO_FD" | grep vfio
vfio-device-syspath: /sys/devices/pci0000:e0/0000:e0:01.1/0000:e1:00.0/0000:e2:05.0/0000:e8:00.0

Signed-off-by: Alex Mastro <amastro@fb.com>
---
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
 include/linux/vfio.h               |  2 ++
 3 files changed, 36 insertions(+)

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
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 707b00772ce1..54076045a44f 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -16,6 +16,7 @@
 #include <linux/cdev.h>
 #include <uapi/linux/vfio.h>
 #include <linux/iova_bitmap.h>
+#include <linux/seq_file.h>
 
 struct kvm;
 struct iommufd_ctx;
@@ -135,6 +136,7 @@ struct vfio_device_ops {
 	void	(*dma_unmap)(struct vfio_device *vdev, u64 iova, u64 length);
 	int	(*device_feature)(struct vfio_device *device, u32 flags,
 				  void __user *arg, size_t argsz);
+	void	(*show_fdinfo)(struct vfio_device *device, struct seq_file *m);
 };
 
 #if IS_ENABLED(CONFIG_IOMMUFD)

---
base-commit: 4518e5a60c7fbf0cdff393c2681db39d77b4f87e
change-id: 20250801-show-fdinfo-ef109ca738cf

Best regards,
-- 
Alex Mastro <amastro@fb.com>


