Return-Path: <linux-fsdevel+bounces-5059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4643F807B73
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 23:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F39BE28202C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2474185E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 22:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="KXPVFxta";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PucXOgcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-174.smtp-out.amazonses.com (a11-174.smtp-out.amazonses.com [54.240.11.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED47D6D;
	Wed,  6 Dec 2023 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1701896584;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=3Q5/A0Rd3CgihBhNW5grEfqtjbDmPir4IkbjKQgNInM=;
	b=KXPVFxta7vhCgeXkmZQ+qigNotTZEQUyDLmqB+GlSIS7sHS7VzIrtYx39QLC1PrM
	ve2rplv2ZZRysJMvCOcKnX3qjaK3L7CieZxTOtUsN5cL1DDb2ExsbxM8sWNgk9kXmyU
	3iCoAUdRE2rl3HMtcpm2Igx+VGdE2ODclbKC20io=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1701896584;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=3Q5/A0Rd3CgihBhNW5grEfqtjbDmPir4IkbjKQgNInM=;
	b=PucXOgcbSeDkw5vQ+ndmP/azC6dLZp8uJEMsdTzGkYznh31AOjgV83CH7TGiZ2hC
	MHzkx19HcIPBFsU9jyDEnp6l3BgdIYQx33sR3NunXewzdSUVmhEdqUUa+wOAPp0UNIz
	mTAuVeM9VLsQ1Gh4moO63gJH6r5Qst+aLvw18bzc=
Subject: [PATCH RFC 3/4] dev_dax_iomap: Add dax_operations to /dev/dax struct
 dax_device
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <john@jagalactic.com>
Cc: =?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Wed, 6 Dec 2023 21:03:04 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231206210252.52107-1-john@jagalactic.com>
References: <20231206210252.52107-1-john@jagalactic.com> 
 <20231206210252.52107-4-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHaKIeW9Nsmb4x1TnOasHllAnJBRAAAAOOt
Thread-Topic: [PATCH RFC 3/4] dev_dax_iomap: Add dax_operations to /dev/dax
 struct dax_device
X-Wm-Sent-Timestamp: 1701896583
X-Original-Mailer: git-send-email 2.39.3 (Apple Git-145)
Message-ID: <0100018c40f0fe2d-584bc0df-f14c-49f0-ab82-b918d9e0cc72-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.12.06-54.240.11.174

From: John Groves <john@groves.net>=0D=0A=0D=0AThis is the primary conten=
t of this rfc. Notes about this commit:=0D=0A=0D=0A* These methods are ba=
sed somewhat loosely on pmem_dax_ops from=0D=0A  drivers/nvdimm/pmem.c=0D=
=0A=0D=0A* dev_dax_direct_access() is physaddr based=0D=0A=0D=0A* dev_dax=
_direct_access() works for mmap, but fails dax_copy_to_iter()=0D=0A  on p=
osix read=0D=0A=0D=0A* dev_dax_recovery_write()  and dev_dax_zero_page_ra=
nge() have not been=0D=0A  tested yet. I'm looking for suggestions as to =
how to test those.=0D=0A=0D=0AI'm hoping somebody (Dan=3F) can point the =
way to getting this working=0D=0Awith posix I/O. Does this need to go the=
 memremap route=3F=0D=0A=0D=0AThanks,=0D=0AJohn=0D=0A---=0D=0A drivers/da=
x/bus.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++=0D=0A 1 file=
 changed, 105 insertions(+)=0D=0A=0D=0Adiff --git a/drivers/dax/bus.c b/d=
rivers/dax/bus.c=0D=0Aindex 1b55fd7aabaf..8f8c2991c7c2 100644=0D=0A--- a/=
drivers/dax/bus.c=0D=0A+++ b/drivers/dax/bus.c=0D=0A@@ -10,6 +10,12 @@=0D=
=0A #include "dax-private.h"=0D=0A #include "bus.h"=0D=0A=20=0D=0A+#if IS=
_ENABLED(CONFIG_DEV_DAX_IOMAP)=0D=0A+#include <linux/backing-dev.h>=0D=0A=
+#include <linux/pfn_t.h>=0D=0A+#include <linux/range.h>=0D=0A+#endif=0D=0A=
+=0D=0A static DEFINE_MUTEX(dax_bus_lock);=0D=0A=20=0D=0A #define DAX_NAM=
E_LEN 30=0D=0A@@ -1374,6 +1380,100 @@ phys_addr_t dax_pgoff_to_phys(struc=
t dev_dax *dev_dax, pgoff_t pgoff,=0D=0A }=0D=0A=20=0D=0A=20=0D=0A+/* the=
 phys address approach */=0D=0A+long __dev_dax_direct_access(struct dax_d=
evice *dax_dev, pgoff_t pgoff,=0D=0A+=09=09=09     long nr_pages, enum da=
x_access_mode mode, void **kaddr,=0D=0A+=09=09=09     pfn_t *pfn)=0D=0A+{=
=0D=0A+=09struct dev_dax *dev_dax =3D dax_get_private(dax_dev);=0D=0A+=09=
size_t size =3D nr_pages << PAGE_SHIFT;=0D=0A+=09size_t offset =3D pgoff =
<< PAGE_SHIFT;=0D=0A+=09long range_remainder =3D 0;=0D=0A+=09phys_addr_t =
phys;=0D=0A+=09int i;=0D=0A+=0D=0A+=09/*=0D=0A+=09 * pmem hides dax range=
s by mapping  to a contiguous=0D=0A+=09 * pmem->virt_addr =3D devm_mremap=
_pages() (in pem_attach_disk()).=0D=0A+=09 * Is it legal to avoid the vma=
p overhead (and resource consumption) and just return=0D=0A+=09 * a (pote=
ntially partial) phys range=3F This function does this, returning the=0D=0A=
+=09 * phys_addr with the length truncated if necessary to the range rema=
inder=0D=0A+=09 */=0D=0A+=09phys =3D dax_pgoff_to_phys(dev_dax, pgoff, nr=
_pages << PAGE_SHIFT);=0D=0A+=0D=0A+=09if (kaddr)=0D=0A+=09=09*kaddr =3D =
(void *)phys;=0D=0A+=0D=0A+=09if (pfn)=0D=0A+=09=09*pfn =3D phys_to_pfn_t=
(phys, PFN_DEV|PFN_MAP); /* are flags correct=3F */=0D=0A+=0D=0A+=09/*=0D=
=0A+=09 * If dax_pgoff_to_phys() also returned the range remainder (range=
_len - range_offset)=0D=0A+=09 * this loop would not be necessary=0D=0A+=09=
 */=0D=0A+=09for (i =3D 0; i < dev_dax->nr_range; i++) {=0D=0A+=09=09size=
_t rlen =3D range_len(&(dev_dax->ranges[i].range));=0D=0A+=0D=0A+=09=09if=
 (offset < rlen) {=0D=0A+=09=09=09range_remainder =3D rlen - offset;=0D=0A=
+=09=09=09break;=0D=0A+=09=09}=0D=0A+=09=09offset -=3D rlen;=0D=0A+=09}=0D=
=0A+=0D=0A+=09/*=0D=0A+=09 * Return length valid at phys. Hoping callers =
can deal with len < entire_dax_device=0D=0A+=09 * (or < npages). This ret=
urns the remaining length in the applicable dax region.=0D=0A+=09 */=0D=0A=
+=09return PHYS_PFN(min_t(size_t, range_remainder, size));=0D=0A+}=0D=0A+=
=0D=0A+static int dev_dax_zero_page_range(struct dax_device *dax_dev, pgo=
ff_t pgoff,=0D=0A+=09=09=09=09    size_t nr_pages)=0D=0A+{=0D=0A+=09long =
resid =3D nr_pages << PAGE_SHIFT;=0D=0A+=09long offset =3D pgoff << PAGE_=
SHIFT;=0D=0A+=0D=0A+=09/* Break into one write per dax region */=0D=0A+=09=
while (resid > 0) {=0D=0A+=09=09void *kaddr;=0D=0A+=09=09pgoff_t poff =3D=
 offset >> PAGE_SHIFT;=0D=0A+=09=09long len =3D __dev_dax_direct_access(d=
ax_dev, poff,=0D=0A+=09=09=09=09=09=09   nr_pages, DAX_ACCESS, &kaddr, NU=
LL);=0D=0A+=09=09len =3D min_t(long, len, PAGE_SIZE);=0D=0A+=09=09write_d=
ax(kaddr, ZERO_PAGE(0), offset, len);=0D=0A+=0D=0A+=09=09offset +=3D len;=
=0D=0A+=09=09resid  -=3D len;=0D=0A+=09}=0D=0A+=09return 0;=0D=0A+}=0D=0A=
+=0D=0A+static long dev_dax_direct_access(struct dax_device *dax_dev,=0D=0A=
+=09=09pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,=0D=0A+=09=
=09void **kaddr, pfn_t *pfn)=0D=0A+{=0D=0A+=09return __dev_dax_direct_acc=
ess(dax_dev, pgoff, nr_pages, mode, kaddr, pfn);=0D=0A+}=0D=0A+=0D=0A+sta=
tic size_t dev_dax_recovery_write(struct dax_device *dax_dev, pgoff_t pgo=
ff,=0D=0A+=09=09void *addr, size_t bytes, struct iov_iter *i)=0D=0A+{=0D=0A=
+=09size_t len, off;=0D=0A+=0D=0A+=09off =3D offset_in_page(addr);=0D=0A+=
=09len =3D PFN_PHYS(PFN_UP(off + bytes));=0D=0A+=0D=0A+=09return _copy_fr=
om_iter_flushcache(addr, bytes, i);=0D=0A+}=0D=0A+=0D=0A+static const str=
uct dax_operations dev_dax_ops =3D {=0D=0A+=09.direct_access =3D dev_dax_=
direct_access,=0D=0A+=09.zero_page_range =3D dev_dax_zero_page_range,=0D=0A=
+=09.recovery_write =3D dev_dax_recovery_write,=0D=0A+};=0D=0A+#endif /* =
IS_ENABLED(CONFIG_DEV_DAX_IOMAP) */=0D=0A+=0D=0A struct dev_dax *devm_cre=
ate_dev_dax(struct dev_dax_data *data)=0D=0A {=0D=0A =09struct dax_region=
 *dax_region =3D data->dax_region;=0D=0A@@ -1429,11 +1529,16 @@ struct de=
v_dax *devm_create_dev_dax(struct dev_dax_data *data)=0D=0A =09=09}=0D=0A=
 =09}=0D=0A=20=0D=0A+#if IS_ENABLED(CONFIG_DEV_DAX_IOMAP)=0D=0A+=09/* hol=
der_ops currently populated separately in a slightly hacky way */=0D=0A+=09=
dax_dev =3D alloc_dax(dev_dax, &dev_dax_ops);=0D=0A+#else=0D=0A =09/*=0D=0A=
 =09 * No dax_operations since there is no access to this device outside =
of=0D=0A =09 * mmap of the resulting character device.=0D=0A =09 */=0D=0A=
 =09dax_dev =3D alloc_dax(dev_dax, NULL);=0D=0A+#endif=0D=0A =09if (IS_ER=
R(dax_dev)) {=0D=0A =09=09rc =3D PTR_ERR(dax_dev);=0D=0A =09=09goto err_a=
lloc_dax;=0D=0A--=20=0D=0A2.40.1=0D=0A=0D=0A

