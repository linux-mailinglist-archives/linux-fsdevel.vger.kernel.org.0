Return-Path: <linux-fsdevel+bounces-74208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAB7D38532
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D50F43104124
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A9634CFBE;
	Fri, 16 Jan 2026 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="k3g+a9VB";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="QpfQ5SJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-131.smtp-out.amazonses.com (a11-131.smtp-out.amazonses.com [54.240.11.131])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AAC3A1A5D;
	Fri, 16 Jan 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590069; cv=none; b=rC0EFpbNlF/8ChSXrLykhiTyyc1dhoN6HWBzjHQRd8RqZFnYjbvyxcYXp7d4VCk7j1JIs54Ow1+SiyWgR3OHaAEe86MpfI1fiNLvRR9bzSknf1GNBuGdJxVxnHvDXtGAKeEV88xPlpLLxotiQCsC3LmweP878I+vXmRDc0rGd4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590069; c=relaxed/simple;
	bh=lX+Z3QFgWtUHicQazGNynRU5gFAaeX4SyIhxDgmmdPM=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=Iz7ZJHByal9ADSWQogdi+bhwtPp9ToDZCaJNbemfTElvyaK43JqQDUmMEx8t6LjiBscmew89qClvFanzjtL2nNtg0rzqRDUJxql6guCXRi6YwRSKQw4B3Fm5z8viY2YJxW6LKuLVeqJGU/hZra6naM6QxSUiYFsT7TUcn67Jhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=k3g+a9VB; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=QpfQ5SJC; arc=none smtp.client-ip=54.240.11.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590060;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=lX+Z3QFgWtUHicQazGNynRU5gFAaeX4SyIhxDgmmdPM=;
	b=k3g+a9VBXYBAesGVdU5QyEMvtWic5fMLaxKW2wOpLF5fZeYViGF6keUQWcq0zrnp
	vYGKUz2Ozn/9w4vUZU+ozpSGW+Ni6utCrnFpjL0S919/YFhvX9PfWdzx0gfq/4FINt2
	0wMledXLL1bnim06Nnlu2WfisbdU86a6N+blrfOs=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590060;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=lX+Z3QFgWtUHicQazGNynRU5gFAaeX4SyIhxDgmmdPM=;
	b=QpfQ5SJC+AfWyJJZAxng5EPN/UlT7y870BWMKPhH652FtOK3i0azObZqgvzRa99i
	m/7TkTFxEQ4pgBKUmQ+cCBFiUV+qBnJVtQc2WJaEfcF/GLld6ixARHUKyryE08x8r1Z
	A7+tmVuYJWaHPqFGplIAwwKKGHYN69WEgjEoOtUg=
Subject: [PATCH V5 03/19] dax: add fsdev.c driver for fs-dax on character dax
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:00:59 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116185911.1005-1-john@jagalactic.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116185911.1005-1-john@jagalactic.com> 
 <20260116185911.1005-4-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAAVOSo=
Thread-Topic: [PATCH V5 03/19] dax: add fsdev.c driver for fs-dax on
 character dax
X-Wm-Sent-Timestamp: 1768590058
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc82ea995-a8ef405c-3479-432d-a783-b3653a3e5f38-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.131

From: John Groves <john@groves.net>=0D=0A=0D=0AThe new fsdev driver provi=
des pages/folios initialized compatibly with=0D=0Afsdax - normal rather t=
han devdax-style refcounting, and starting out=0D=0Awith order-0 folios.=0D=
=0A=0D=0AWhen fsdev binds to a daxdev, it is usually (always=3F) switchin=
g from the=0D=0Adevdax mode (device.c), which pre-initializes compound fo=
lios according=0D=0Ato its alignment. Fsdev uses fsdev_clear_folio_state(=
) to switch the=0D=0Afolios into a fsdax-compatible state.=0D=0A=0D=0AA s=
ide effect of this is that raw mmap doesn't (can't=3F) work on an fsdev=0D=
=0Adax instance. Accordingly, The fsdev driver does not provide raw mmap =
-=0D=0Adevices must be put in 'devdax' mode (drivers/dax/device.c) to get=
 raw=0D=0Ammap capability.=0D=0A=0D=0AIn this commit is just the framewor=
k, which remaps pages/folios compatibly=0D=0Awith fsdax.=0D=0A=0D=0AEnabl=
ing dax changes:=0D=0A=0D=0A- bus.h: add DAXDRV_FSDEV_TYPE driver type=0D=
=0A- bus.c: allow DAXDRV_FSDEV_TYPE drivers to bind to daxdevs=0D=0A- dax=
=2Eh: prototype inode_dax(), which fsdev needs=0D=0A=0D=0ASuggested-by: D=
an Williams <dan.j.williams@intel.com>=0D=0ASuggested-by: Gregory Price <=
gourry@gourry.net>=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A=
---=0D=0A MAINTAINERS          |   8 ++=0D=0A drivers/dax/Makefile |   6 =
++=0D=0A drivers/dax/bus.c    |   4 +=0D=0A drivers/dax/bus.h    |   1 +=0D=
=0A drivers/dax/fsdev.c  | 242 ++++++++++++++++++++++++++++++++++++++++++=
+=0D=0A fs/dax.c             |   1 +=0D=0A include/linux/dax.h  |   5 +=0D=
=0A 7 files changed, 267 insertions(+)=0D=0A create mode 100644 drivers/d=
ax/fsdev.c=0D=0A=0D=0Adiff --git a/MAINTAINERS b/MAINTAINERS=0D=0Aindex 0=
d044a58cbfe..10aa5120d93f 100644=0D=0A--- a/MAINTAINERS=0D=0A+++ b/MAINTA=
INERS=0D=0A@@ -7188,6 +7188,14 @@ L:=09linux-cxl@vger.kernel.org=0D=0A S:=
=09Supported=0D=0A F:=09drivers/dax/=0D=0A=20=0D=0A+DEVICE DIRECT ACCESS =
(DAX) [fsdev_dax]=0D=0A+M:=09John Groves <jgroves@micron.com>=0D=0A+M:=09=
John Groves <John@Groves.net>=0D=0A+L:=09nvdimm@lists.linux.dev=0D=0A+L:=09=
linux-cxl@vger.kernel.org=0D=0A+S:=09Supported=0D=0A+F:=09drivers/dax/fsd=
ev.c=0D=0A+=0D=0A DEVICE FREQUENCY (DEVFREQ)=0D=0A M:=09MyungJoo Ham <myu=
ngjoo.ham@samsung.com>=0D=0A M:=09Kyungmin Park <kyungmin.park@samsung.co=
m>=0D=0Adiff --git a/drivers/dax/Makefile b/drivers/dax/Makefile=0D=0Aind=
ex 5ed5c39857c8..3bae252fd1bf 100644=0D=0A--- a/drivers/dax/Makefile=0D=0A=
+++ b/drivers/dax/Makefile=0D=0A@@ -5,10 +5,16 @@ obj-$(CONFIG_DEV_DAX_KM=
EM) +=3D kmem.o=0D=0A obj-$(CONFIG_DEV_DAX_PMEM) +=3D dax_pmem.o=0D=0A ob=
j-$(CONFIG_DEV_DAX_CXL) +=3D dax_cxl.o=0D=0A=20=0D=0A+# fsdev_dax: fs-dax=
 compatible devdax driver (needs DEV_DAX and FS_DAX)=0D=0A+ifeq ($(CONFIG=
_FS_DAX),y)=0D=0A+obj-$(CONFIG_DEV_DAX) +=3D fsdev_dax.o=0D=0A+endif=0D=0A=
+=0D=0A dax-y :=3D super.o=0D=0A dax-y +=3D bus.o=0D=0A device_dax-y :=3D=
 device.o=0D=0A dax_pmem-y :=3D pmem.o=0D=0A dax_cxl-y :=3D cxl.o=0D=0A+f=
sdev_dax-y :=3D fsdev.o=0D=0A=20=0D=0A obj-y +=3D hmem/=0D=0Adiff --git a=
/drivers/dax/bus.c b/drivers/dax/bus.c=0D=0Aindex a73f54eac567..e79daf825=
b52 100644=0D=0A--- a/drivers/dax/bus.c=0D=0A+++ b/drivers/dax/bus.c=0D=0A=
@@ -81,6 +81,10 @@ static int dax_match_type(const struct dax_device_driv=
er *dax_drv, struct device=0D=0A =09    !IS_ENABLED(CONFIG_DEV_DAX_KMEM))=
=0D=0A =09=09return 1;=0D=0A=20=0D=0A+=09/* fsdev driver can also bind to=
 device-type dax devices */=0D=0A+=09if (dax_drv->type =3D=3D DAXDRV_FSDE=
V_TYPE && type =3D=3D DAXDRV_DEVICE_TYPE)=0D=0A+=09=09return 1;=0D=0A+=0D=
=0A =09return 0;=0D=0A }=0D=0A=20=0D=0Adiff --git a/drivers/dax/bus.h b/d=
rivers/dax/bus.h=0D=0Aindex cbbf64443098..880bdf7e72d7 100644=0D=0A--- a/=
drivers/dax/bus.h=0D=0A+++ b/drivers/dax/bus.h=0D=0A@@ -31,6 +31,7 @@ str=
uct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);=0D=0A enum d=
ax_driver_type {=0D=0A =09DAXDRV_KMEM_TYPE,=0D=0A =09DAXDRV_DEVICE_TYPE,=0D=
=0A+=09DAXDRV_FSDEV_TYPE,=0D=0A };=0D=0A=20=0D=0A struct dax_device_drive=
r {=0D=0Adiff --git a/drivers/dax/fsdev.c b/drivers/dax/fsdev.c=0D=0Anew =
file mode 100644=0D=0Aindex 000000000000..29b7345f65b1=0D=0A--- /dev/null=
=0D=0A+++ b/drivers/dax/fsdev.c=0D=0A@@ -0,0 +1,242 @@=0D=0A+// SPDX-Lice=
nse-Identifier: GPL-2.0=0D=0A+/* Copyright(c) 2026 Micron Technology, Inc=
=2E */=0D=0A+#include <linux/memremap.h>=0D=0A+#include <linux/pagemap.h>=
=0D=0A+#include <linux/module.h>=0D=0A+#include <linux/device.h>=0D=0A+#i=
nclude <linux/cdev.h>=0D=0A+#include <linux/slab.h>=0D=0A+#include <linux=
/dax.h>=0D=0A+#include <linux/uio.h>=0D=0A+#include <linux/fs.h>=0D=0A+#i=
nclude <linux/mm.h>=0D=0A+#include "dax-private.h"=0D=0A+#include "bus.h"=
=0D=0A+=0D=0A+/*=0D=0A+ * FS-DAX compatible devdax driver=0D=0A+ *=0D=0A+=
 * Unlike drivers/dax/device.c which pre-initializes compound folios base=
d=0D=0A+ * on device alignment (via vmemmap_shift), this driver leaves fo=
lios=0D=0A+ * uninitialized similar to pmem. This allows fs-dax filesyste=
ms like famfs=0D=0A+ * to work without needing special handling for pre-i=
nitialized folios.=0D=0A+ *=0D=0A+ * Key differences from device.c:=0D=0A=
+ * - pgmap type is MEMORY_DEVICE_FS_DAX (not MEMORY_DEVICE_GENERIC)=0D=0A=
+ * - vmemmap_shift is NOT set (folios remain order-0)=0D=0A+ * - fs-dax =
can dynamically create compound folios as needed=0D=0A+ * - No mmap suppo=
rt - all access is through fs-dax/iomap=0D=0A+ */=0D=0A+=0D=0A+=0D=0A+sta=
tic void fsdev_cdev_del(void *cdev)=0D=0A+{=0D=0A+=09cdev_del(cdev);=0D=0A=
+}=0D=0A+=0D=0A+static void fsdev_kill(void *dev_dax)=0D=0A+{=0D=0A+=09ki=
ll_dev_dax(dev_dax);=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A+ * Page map operations=
 for FS-DAX mode=0D=0A+ * Similar to fsdax_pagemap_ops in drivers/nvdimm/=
pmem.c=0D=0A+ *=0D=0A+ * Note: folio_free callback is not needed for MEMO=
RY_DEVICE_FS_DAX.=0D=0A+ * The core mm code in free_zone_device_folio() h=
andles the wake_up_var()=0D=0A+ * directly for this memory type.=0D=0A+ *=
/=0D=0A+static int fsdev_pagemap_memory_failure(struct dev_pagemap *pgmap=
,=0D=0A+=09=09unsigned long pfn, unsigned long nr_pages, int mf_flags)=0D=
=0A+{=0D=0A+=09struct dev_dax *dev_dax =3D pgmap->owner;=0D=0A+=09u64 off=
set =3D PFN_PHYS(pfn) - dev_dax->ranges[0].range.start;=0D=0A+=09u64 len =
=3D nr_pages << PAGE_SHIFT;=0D=0A+=0D=0A+=09return dax_holder_notify_fail=
ure(dev_dax->dax_dev, offset,=0D=0A+=09=09=09=09=09 len, mf_flags);=0D=0A=
+}=0D=0A+=0D=0A+static const struct dev_pagemap_ops fsdev_pagemap_ops =3D=
 {=0D=0A+=09.memory_failure=09=09=3D fsdev_pagemap_memory_failure,=0D=0A+=
};=0D=0A+=0D=0A+/*=0D=0A+ * Clear any stale folio state from pages in the=
 given range.=0D=0A+ * This is necessary because device_dax pre-initializ=
es compound folios=0D=0A+ * based on vmemmap_shift, and that state may pe=
rsist after driver unbind.=0D=0A+ * Since fsdev_dax uses MEMORY_DEVICE_FS=
_DAX without vmemmap_shift, fs-dax=0D=0A+ * expects to find clean order-0=
 folios that it can build into compound=0D=0A+ * folios on demand.=0D=0A+=
 *=0D=0A+ * At probe time, no filesystem should be mounted yet, so all ma=
ppings=0D=0A+ * are stale and must be cleared along with compound state.=0D=
=0A+ */=0D=0A+static void fsdev_clear_folio_state(struct dev_dax *dev_dax=
)=0D=0A+{=0D=0A+=09for (int i =3D 0; i < dev_dax->nr_range; i++) {=0D=0A+=
=09=09struct range *range =3D &dev_dax->ranges[i].range;=0D=0A+=09=09unsi=
gned long pfn =3D PHYS_PFN(range->start);=0D=0A+=09=09unsigned long end_p=
fn =3D PHYS_PFN(range->end) + 1;=0D=0A+=0D=0A+=09=09while (pfn < end_pfn)=
 {=0D=0A+=09=09=09struct folio *folio =3D pfn_folio(pfn);=0D=0A+=09=09=09=
int order =3D dax_folio_reset_order(folio);=0D=0A+=0D=0A+=09=09=09pfn +=3D=
 1UL << order;=0D=0A+=09=09}=0D=0A+=09}=0D=0A+}=0D=0A+=0D=0A+static int f=
sdev_open(struct inode *inode, struct file *filp)=0D=0A+{=0D=0A+=09struct=
 dax_device *dax_dev =3D inode_dax(inode);=0D=0A+=09struct dev_dax *dev_d=
ax =3D dax_get_private(dax_dev);=0D=0A+=0D=0A+=09filp->private_data =3D d=
ev_dax;=0D=0A+=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A+static int fsdev_r=
elease(struct inode *inode, struct file *filp)=0D=0A+{=0D=0A+=09return 0;=
=0D=0A+}=0D=0A+=0D=0A+static const struct file_operations fsdev_fops =3D =
{=0D=0A+=09.llseek =3D noop_llseek,=0D=0A+=09.owner =3D THIS_MODULE,=0D=0A=
+=09.open =3D fsdev_open,=0D=0A+=09.release =3D fsdev_release,=0D=0A+};=0D=
=0A+=0D=0A+static int fsdev_dax_probe(struct dev_dax *dev_dax)=0D=0A+{=0D=
=0A+=09struct dax_device *dax_dev =3D dev_dax->dax_dev;=0D=0A+=09struct d=
evice *dev =3D &dev_dax->dev;=0D=0A+=09struct dev_pagemap *pgmap;=0D=0A+=09=
u64 data_offset =3D 0;=0D=0A+=09struct inode *inode;=0D=0A+=09struct cdev=
 *cdev;=0D=0A+=09void *addr;=0D=0A+=09int rc, i;=0D=0A+=0D=0A+=09if (stat=
ic_dev_dax(dev_dax))  {=0D=0A+=09=09if (dev_dax->nr_range > 1) {=0D=0A+=09=
=09=09dev_warn(dev, "static pgmap / multi-range device conflict\n");=0D=0A=
+=09=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09pgmap =3D dev_=
dax->pgmap;=0D=0A+=09} else {=0D=0A+=09=09size_t pgmap_size;=0D=0A+=0D=0A=
+=09=09if (dev_dax->pgmap) {=0D=0A+=09=09=09dev_warn(dev, "dynamic-dax wi=
th pre-populated page map\n");=0D=0A+=09=09=09return -EINVAL;=0D=0A+=09=09=
}=0D=0A+=0D=0A+=09=09pgmap_size =3D struct_size(pgmap, ranges, dev_dax->n=
r_range - 1);=0D=0A+=09=09pgmap =3D devm_kzalloc(dev, pgmap_size,  GFP_KE=
RNEL);=0D=0A+=09=09if (!pgmap)=0D=0A+=09=09=09return -ENOMEM;=0D=0A+=0D=0A=
+=09=09pgmap->nr_range =3D dev_dax->nr_range;=0D=0A+=09=09dev_dax->pgmap =
=3D pgmap;=0D=0A+=0D=0A+=09=09for (i =3D 0; i < dev_dax->nr_range; i++) {=
=0D=0A+=09=09=09struct range *range =3D &dev_dax->ranges[i].range;=0D=0A+=
=0D=0A+=09=09=09pgmap->ranges[i] =3D *range;=0D=0A+=09=09}=0D=0A+=09}=0D=0A=
+=0D=0A+=09for (i =3D 0; i < dev_dax->nr_range; i++) {=0D=0A+=09=09struct=
 range *range =3D &dev_dax->ranges[i].range;=0D=0A+=0D=0A+=09=09if (!devm=
_request_mem_region(dev, range->start,=0D=0A+=09=09=09=09=09range_len(ran=
ge), dev_name(dev))) {=0D=0A+=09=09=09dev_warn(dev, "mapping%d: %#llx-%#l=
lx could not reserve range\n",=0D=0A+=09=09=09=09 i, range->start, range-=
>end);=0D=0A+=09=09=09return -EBUSY;=0D=0A+=09=09}=0D=0A+=09}=0D=0A+=0D=0A=
+=09/*=0D=0A+=09 * FS-DAX compatible mode: Use MEMORY_DEVICE_FS_DAX type =
and=0D=0A+=09 * do NOT set vmemmap_shift. This leaves folios at order-0,=0D=
=0A+=09 * allowing fs-dax to dynamically create compound folios as needed=
=0D=0A+=09 * (similar to pmem behavior).=0D=0A+=09 */=0D=0A+=09pgmap->typ=
e =3D MEMORY_DEVICE_FS_DAX;=0D=0A+=09pgmap->ops =3D &fsdev_pagemap_ops;=0D=
=0A+=09pgmap->owner =3D dev_dax;=0D=0A+=0D=0A+=09/*=0D=0A+=09 * CRITICAL =
DIFFERENCE from device.c:=0D=0A+=09 * We do NOT set vmemmap_shift here, e=
ven if align > PAGE_SIZE.=0D=0A+=09 * This ensures folios remain order-0 =
and are compatible with=0D=0A+=09 * fs-dax's folio management.=0D=0A+=09 =
*/=0D=0A+=0D=0A+=09addr =3D devm_memremap_pages(dev, pgmap);=0D=0A+=09if =
(IS_ERR(addr))=0D=0A+=09=09return PTR_ERR(addr);=0D=0A+=0D=0A+=09/*=0D=0A=
+=09 * Clear any stale compound folio state left over from a previous=0D=0A=
+=09 * driver (e.g., device_dax with vmemmap_shift).=0D=0A+=09 */=0D=0A+=09=
fsdev_clear_folio_state(dev_dax);=0D=0A+=0D=0A+=09/* Detect whether the d=
ata is at a non-zero offset into the memory */=0D=0A+=09if (pgmap->range.=
start !=3D dev_dax->ranges[0].range.start) {=0D=0A+=09=09u64 phys =3D dev=
_dax->ranges[0].range.start;=0D=0A+=09=09u64 pgmap_phys =3D dev_dax->pgma=
p[0].range.start;=0D=0A+=0D=0A+=09=09if (!WARN_ON(pgmap_phys > phys))=0D=0A=
+=09=09=09data_offset =3D phys - pgmap_phys;=0D=0A+=0D=0A+=09=09pr_debug(=
"%s: offset detected phys=3D%llx pgmap_phys=3D%llx offset=3D%llx\n",=0D=0A=
+=09=09       __func__, phys, pgmap_phys, data_offset);=0D=0A+=09}=0D=0A+=
=0D=0A+=09inode =3D dax_inode(dax_dev);=0D=0A+=09cdev =3D inode->i_cdev;=0D=
=0A+=09cdev_init(cdev, &fsdev_fops);=0D=0A+=09cdev->owner =3D dev->driver=
->owner;=0D=0A+=09cdev_set_parent(cdev, &dev->kobj);=0D=0A+=09rc =3D cdev=
_add(cdev, dev->devt, 1);=0D=0A+=09if (rc)=0D=0A+=09=09return rc;=0D=0A+=0D=
=0A+=09rc =3D devm_add_action_or_reset(dev, fsdev_cdev_del, cdev);=0D=0A+=
=09if (rc)=0D=0A+=09=09return rc;=0D=0A+=0D=0A+=09run_dax(dax_dev);=0D=0A=
+=09return devm_add_action_or_reset(dev, fsdev_kill, dev_dax);=0D=0A+}=0D=
=0A+=0D=0A+static struct dax_device_driver fsdev_dax_driver =3D {=0D=0A+=09=
=2Eprobe =3D fsdev_dax_probe,=0D=0A+=09.type =3D DAXDRV_FSDEV_TYPE,=0D=0A=
+};=0D=0A+=0D=0A+static int __init dax_init(void)=0D=0A+{=0D=0A+=09return=
 dax_driver_register(&fsdev_dax_driver);=0D=0A+}=0D=0A+=0D=0A+static void=
 __exit dax_exit(void)=0D=0A+{=0D=0A+=09dax_driver_unregister(&fsdev_dax_=
driver);=0D=0A+}=0D=0A+=0D=0A+MODULE_AUTHOR("John Groves");=0D=0A+MODULE_=
DESCRIPTION("FS-DAX Device: fs-dax compatible devdax driver");=0D=0A+MODU=
LE_LICENSE("GPL");=0D=0A+module_init(dax_init);=0D=0A+module_exit(dax_exi=
t);=0D=0A+MODULE_ALIAS_DAX_DEVICE(0);=0D=0Adiff --git a/fs/dax.c b/fs/dax=
=2Ec=0D=0Aindex 7d7bbfb32c41..85a4b428e72b 100644=0D=0A--- a/fs/dax.c=0D=0A=
+++ b/fs/dax.c=0D=0A@@ -416,6 +416,7 @@ int dax_folio_reset_order(struct =
folio *folio)=0D=0A=20=0D=0A =09return order;=0D=0A }=0D=0A+EXPORT_SYMBOL=
_GPL(dax_folio_reset_order);=0D=0A=20=0D=0A static inline unsigned long d=
ax_folio_put(struct folio *folio)=0D=0A {=0D=0Adiff --git a/include/linux=
/dax.h b/include/linux/dax.h=0D=0Aindex 9d624f4d9df6..fe1315135fdd 100644=
=0D=0A--- a/include/linux/dax.h=0D=0A+++ b/include/linux/dax.h=0D=0A@@ -5=
1,6 +51,10 @@ struct dax_holder_operations {=0D=0A=20=0D=0A #if IS_ENABLE=
D(CONFIG_DAX)=0D=0A struct dax_device *alloc_dax(void *private, const str=
uct dax_operations *ops);=0D=0A+=0D=0A+#if IS_ENABLED(CONFIG_DEV_DAX_FS)=0D=
=0A+struct dax_device *inode_dax(struct inode *inode);=0D=0A+#endif=0D=0A=
 void *dax_holder(struct dax_device *dax_dev);=0D=0A void put_dax(struct =
dax_device *dax_dev);=0D=0A void kill_dax(struct dax_device *dax_dev);=0D=
=0A@@ -153,6 +157,7 @@ static inline void fs_put_dax(struct dax_device *d=
ax_dev, void *holder)=0D=0A #if IS_ENABLED(CONFIG_FS_DAX)=0D=0A int dax_w=
riteback_mapping_range(struct address_space *mapping,=0D=0A =09=09struct =
dax_device *dax_dev, struct writeback_control *wbc);=0D=0A+int dax_folio_=
reset_order(struct folio *folio);=0D=0A=20=0D=0A struct page *dax_layout_=
busy_page(struct address_space *mapping);=0D=0A struct page *dax_layout_b=
usy_page_range(struct address_space *mapping, loff_t start, loff_t end);=0D=
=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

