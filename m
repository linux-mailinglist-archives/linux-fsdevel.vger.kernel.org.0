Return-Path: <linux-fsdevel+bounces-74329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C97D39AA6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94BEA30321CE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EB430F530;
	Sun, 18 Jan 2026 22:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="FhwmHyId";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fnWK4cEz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a8-18.smtp-out.amazonses.com (a8-18.smtp-out.amazonses.com [54.240.8.18])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760E2836A6;
	Sun, 18 Jan 2026 22:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775517; cv=none; b=aoyps6yPj2N0c8BhjxJWbV+3xVVC4VmLW46b455Y5Nc6ONReqZ1rDJqOKka+WjDKn8AauKvY6inworRrT2n+rLDYEd7w7tsuMe5SO1Rp2FuVXEfpsVCrmQm+QuPGoPmUXuT1DzNc54ZI2EP+MXGFO59/+ODZIzszz3W8AIwIb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775517; c=relaxed/simple;
	bh=4T3dwqGolXKRL4ofvR33TvVfJtWXt4xos2lXBhwHP0g=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=LOQAyP08vcowYSWagauMQ9QbzqK51HWMUyBCocmQoGM4ZcJi60wo6dBNTld1beI2Lz4qYx436O6MTb+L+rrZ0IGSl3Dt60u5ah1YdyYPju7ex8naAK2Ev1y91hWpuGgcmuA1XsYbNdfeoy4EECGTTkSrIeomk6r8LNEBjwSWHUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=FhwmHyId; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=fnWK4cEz; arc=none smtp.client-ip=54.240.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775514;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=4T3dwqGolXKRL4ofvR33TvVfJtWXt4xos2lXBhwHP0g=;
	b=FhwmHyIdAF3Tk49ay5iTGZnQWY/LFMk5TCgw5jS2+S28pvM0AWtOR6crOX5N3Opo
	7JvpQulSzKpuoicIxwAm61jYig5CLZWSCE/BZKKBz2IneUDunlfy37BNhAHbUMzNHup
	hj1Zoca6tYyiEOXUa4+v7/Y10gpuV/EnWVkp0Hpg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775514;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=4T3dwqGolXKRL4ofvR33TvVfJtWXt4xos2lXBhwHP0g=;
	b=fnWK4cEz/3ZGlfhhfRQzVlBUlUGNXhd0A2xSP8e0F8Cxst9lrA7tqnRFVlr1BwkN
	w/+rpCb1jRBPHMtF5ooifnUUSl7ziCMYDnXw3S55lSY2Cl5pFN8zFyXs+rydSuNmFHD
	o+juX+PXL3AcBA3WvK5Dk+MyPbBa/5sun9SCpyS8=
Subject: [PATCH V7 05/19] dax: Add dax_operations for use by fs-dax on fsdev
 dax
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:31:54 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
References: 
 <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com> 
 <20260118223147.92389-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAXYL0=
Thread-Topic: [PATCH V7 05/19] dax: Add dax_operations for use by fs-dax on
 fsdev dax
X-Wm-Sent-Timestamp: 1768775513
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33c798b-b40d52e8-b393-4a54-9cc2-f30ee62b566f-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.8.18

From: John Groves <John@Groves.net>=0D=0A=0D=0Afsdev: Add dax_operations =
for use by famfs=0D=0A=0D=0A- These methods are based on pmem_dax_ops fro=
m drivers/nvdimm/pmem.c=0D=0A- fsdev_dax_direct_access() returns the hpa,=
 pfn and kva. The kva was=0D=0A  newly stored as dev_dax->virt_addr by de=
v_dax_probe().=0D=0A- The hpa/pfn are used for mmap (dax_iomap_fault()), =
and the kva is used=0D=0A  for read/write (dax_iomap_rw())=0D=0A- fsdev_d=
ax_recovery_write() and dev_dax_zero_page_range() have not been=0D=0A  te=
sted yet. I'm looking for suggestions as to how to test those.=0D=0A- dax=
-private.h: add dev_dax->cached_size, which fsdev needs to=0D=0A  remembe=
r. The dev_dax size cannot change while a driver is bound=0D=0A  (dev_dax=
_resize returns -EBUSY if dev->driver is set). Caching the size=0D=0A  at=
 probe time allows fsdev's direct_access path can use it without=0D=0A  a=
cquiring dax_dev_rwsem (which isn't exported anyway).=0D=0A=0D=0ASigned-o=
ff-by: John Groves <john@groves.net>=0D=0A---=0D=0A drivers/dax/dax-priva=
te.h |  1 +=0D=0A drivers/dax/fsdev.c       | 85 ++++++++++++++++++++++++=
+++++++++++++++=0D=0A 2 files changed, 86 insertions(+)=0D=0A=0D=0Adiff -=
-git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h=0D=0Aindex 4=
ae4d829d3ee..092f4ae024ea 100644=0D=0A--- a/drivers/dax/dax-private.h=0D=0A=
+++ b/drivers/dax/dax-private.h=0D=0A@@ -83,6 +83,7 @@ struct dev_dax {=0D=
=0A =09struct dax_region *region;=0D=0A =09struct dax_device *dax_dev;=0D=
=0A =09void *virt_addr;=0D=0A+=09u64 cached_size;=0D=0A =09unsigned int a=
lign;=0D=0A =09int target_node;=0D=0A =09bool dyn_id;=0D=0Adiff --git a/d=
rivers/dax/fsdev.c b/drivers/dax/fsdev.c=0D=0Aindex 72f78f606e06..5d17ad3=
9227f 100644=0D=0A--- a/drivers/dax/fsdev.c=0D=0A+++ b/drivers/dax/fsdev.=
c=0D=0A@@ -28,6 +28,86 @@=0D=0A  * - No mmap support - all access is thro=
ugh fs-dax/iomap=0D=0A  */=0D=0A=20=0D=0A+static void fsdev_write_dax(voi=
d *pmem_addr, struct page *page,=0D=0A+=09=09unsigned int off, unsigned i=
nt len)=0D=0A+{=0D=0A+=09while (len) {=0D=0A+=09=09void *mem =3D kmap_loc=
al_page(page);=0D=0A+=09=09unsigned int chunk =3D min_t(unsigned int, len=
, PAGE_SIZE - off);=0D=0A+=0D=0A+=09=09memcpy_flushcache(pmem_addr, mem +=
 off, chunk);=0D=0A+=09=09kunmap_local(mem);=0D=0A+=09=09len -=3D chunk;=0D=
=0A+=09=09off =3D 0;=0D=0A+=09=09page++;=0D=0A+=09=09pmem_addr +=3D chunk=
;=0D=0A+=09}=0D=0A+}=0D=0A+=0D=0A+static long __fsdev_dax_direct_access(s=
truct dax_device *dax_dev, pgoff_t pgoff,=0D=0A+=09=09=09long nr_pages, e=
num dax_access_mode mode, void **kaddr,=0D=0A+=09=09=09unsigned long *pfn=
)=0D=0A+{=0D=0A+=09struct dev_dax *dev_dax =3D dax_get_private(dax_dev);=0D=
=0A+=09size_t size =3D nr_pages << PAGE_SHIFT;=0D=0A+=09size_t offset =3D=
 pgoff << PAGE_SHIFT;=0D=0A+=09void *virt_addr =3D dev_dax->virt_addr + o=
ffset;=0D=0A+=09phys_addr_t phys;=0D=0A+=09unsigned long local_pfn;=0D=0A=
+=0D=0A+=09WARN_ON(!dev_dax->virt_addr);=0D=0A+=0D=0A+=09phys =3D dax_pgo=
ff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);=0D=0A+=09if (phys =3D=
=3D -1) {=0D=0A+=09=09dev_dbg(&dev_dax->dev,=0D=0A+=09=09=09"pgoff (%#lx)=
 out of range\n", pgoff);=0D=0A+=09=09return -ERANGE;=0D=0A+=09}=0D=0A+=0D=
=0A+=09if (kaddr)=0D=0A+=09=09*kaddr =3D virt_addr;=0D=0A+=0D=0A+=09local=
_pfn =3D PHYS_PFN(phys);=0D=0A+=09if (pfn)=0D=0A+=09=09*pfn =3D local_pfn=
;=0D=0A+=0D=0A+=09/*=0D=0A+=09 * Use cached_size which was computed at pr=
obe time. The size cannot=0D=0A+=09 * change while the driver is bound (r=
esize returns -EBUSY).=0D=0A+=09 */=0D=0A+=09return PHYS_PFN(min(size, de=
v_dax->cached_size - offset));=0D=0A+}=0D=0A+=0D=0A+static int fsdev_dax_=
zero_page_range(struct dax_device *dax_dev,=0D=0A+=09=09=09pgoff_t pgoff,=
 size_t nr_pages)=0D=0A+{=0D=0A+=09void *kaddr;=0D=0A+=0D=0A+=09WARN_ONCE=
(nr_pages > 1, "%s: nr_pages > 1\n", __func__);=0D=0A+=09__fsdev_dax_dire=
ct_access(dax_dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);=0D=0A+=09fsdev_wr=
ite_dax(kaddr, ZERO_PAGE(0), 0, PAGE_SIZE);=0D=0A+=09return 0;=0D=0A+}=0D=
=0A+=0D=0A+static long fsdev_dax_direct_access(struct dax_device *dax_dev=
,=0D=0A+=09=09  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,=0D=
=0A+=09=09  void **kaddr, unsigned long *pfn)=0D=0A+{=0D=0A+=09return __f=
sdev_dax_direct_access(dax_dev, pgoff, nr_pages, mode,=0D=0A+=09=09=09=09=
=09 kaddr, pfn);=0D=0A+}=0D=0A+=0D=0A+static size_t fsdev_dax_recovery_wr=
ite(struct dax_device *dax_dev, pgoff_t pgoff,=0D=0A+=09=09void *addr, si=
ze_t bytes, struct iov_iter *i)=0D=0A+{=0D=0A+=09return _copy_from_iter_f=
lushcache(addr, bytes, i);=0D=0A+}=0D=0A+=0D=0A+static const struct dax_o=
perations dev_dax_ops =3D {=0D=0A+=09.direct_access =3D fsdev_dax_direct_=
access,=0D=0A+=09.zero_page_range =3D fsdev_dax_zero_page_range,=0D=0A+=09=
=2Erecovery_write =3D fsdev_dax_recovery_write,=0D=0A+};=0D=0A=20=0D=0A s=
tatic void fsdev_cdev_del(void *cdev)=0D=0A {=0D=0A@@ -163,6 +243,11 @@ s=
tatic int fsdev_dax_probe(struct dev_dax *dev_dax)=0D=0A =09=09}=0D=0A =09=
}=0D=0A=20=0D=0A+=09/* Cache size now; it cannot change while driver is b=
ound */=0D=0A+=09dev_dax->cached_size =3D 0;=0D=0A+=09for (i =3D 0; i < d=
ev_dax->nr_range; i++)=0D=0A+=09=09dev_dax->cached_size +=3D range_len(&d=
ev_dax->ranges[i].range);=0D=0A+=0D=0A =09/*=0D=0A =09 * FS-DAX compatibl=
e mode: Use MEMORY_DEVICE_FS_DAX type and=0D=0A =09 * do NOT set vmemmap_=
shift. This leaves folios at order-0,=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

