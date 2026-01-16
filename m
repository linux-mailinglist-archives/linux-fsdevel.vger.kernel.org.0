Return-Path: <linux-fsdevel+bounces-74210-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96595D3853F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64421314F2DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5073939AE;
	Fri, 16 Jan 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="IqUdgeb4";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="toJIh6Un"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a10-27.smtp-out.amazonses.com (a10-27.smtp-out.amazonses.com [54.240.10.27])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498B11EB9F2;
	Fri, 16 Jan 2026 19:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590130; cv=none; b=qhzhn6BuS58qwLJjhe6iKuZKQ8DUsmV1/k5sVU1SXDVOZkocEtVS1B6LHEGcQTeM3xWFjUhmGkFCYriL7RXIQMfMMtiFGGOcQakHDVEIOSGu62tul4zak/syWDz/hOAqhlok9yxh3DFlXXuKBZ18bE2a2lKc8DoLEN/2hQ2zGJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590130; c=relaxed/simple;
	bh=jlj1dq6uAqIOUvoj9Pl1OUmkbof7RoapHVmrqlO/1bU=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=hePE/0FQZwtZJTWfPLUL84Q82VpcMhM+n7/0jG6ZKS/pl/nzdd0sPi16XjoFDz0HxEdhdyV3J/fphaYU9gUmsw+vSLNREUKZ3d3O2G8XHmIXw3l0kHquID+U8tm15oqW2M0fGd4E1OVMGSkoI9eGH778X3hjpQY+WR3L62QiNVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=IqUdgeb4; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=toJIh6Un; arc=none smtp.client-ip=54.240.10.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590128;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=jlj1dq6uAqIOUvoj9Pl1OUmkbof7RoapHVmrqlO/1bU=;
	b=IqUdgeb4hA75G3lZBWOUhgquq0ZvcyRErK2R6OUCE3uHGGRYiK72FnCC5PQgdO9M
	Oud2r48gJhV6htCFuIfv4hLuv1b8sqzMP11tzLF2ZKVrLpCZXU3K3XQoIs/RKOd7Ok2
	bMhqOj13OC78sz+X7ZNFF8zm2MktaMc75ulu9N5Q=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590128;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=jlj1dq6uAqIOUvoj9Pl1OUmkbof7RoapHVmrqlO/1bU=;
	b=toJIh6UnOCCEhNO6fNDqjKvnvDj1EDG6v2qVnYJc22cMagMRtqsUb9eN2pytjF8F
	cj9dHuEpIJwoMsI097GNL5vIKagLW5YgzjSLzRqml54AGhIXm+ePq+Tnn3UQBm5J733
	/Hd16HGrtcJwshEikEvBenrbl/uFNjNDThCz9YVo=
Subject: [PATCH V5 05/19] dax: Add dax_operations for use by fs-dax on fsdev
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:02:07 +0000
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
 <20260116185911.1005-6-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAAfWtE=
Thread-Topic: [PATCH V5 05/19] dax: Add dax_operations for use by fs-dax on
 fsdev dax
X-Wm-Sent-Timestamp: 1768590126
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc82fb2e6-9ef40000-6f8f-4e22-9fe6-03f919bbf557-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.10.27

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
te.h |  1 +=0D=0A drivers/dax/fsdev.c       | 80 ++++++++++++++++++++++++=
+++++++++++++++=0D=0A 2 files changed, 81 insertions(+)=0D=0A=0D=0Adiff -=
-git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h=0D=0Aindex f=
3cf0a664f1b..164dd5b9d933 100644=0D=0A--- a/drivers/dax/dax-private.h=0D=0A=
+++ b/drivers/dax/dax-private.h=0D=0A@@ -86,6 +86,7 @@ struct dev_dax {=0D=
=0A =09struct dax_region *region;=0D=0A =09struct dax_device *dax_dev;=0D=
=0A =09void *virt_addr;=0D=0A+=09u64 cached_size;=0D=0A =09unsigned int a=
lign;=0D=0A =09int target_node;=0D=0A =09bool dyn_id;=0D=0Adiff --git a/d=
rivers/dax/fsdev.c b/drivers/dax/fsdev.c=0D=0Aindex 72f78f606e06..f58c88d=
e7a4d 100644=0D=0A--- a/drivers/dax/fsdev.c=0D=0A+++ b/drivers/dax/fsdev.=
c=0D=0A@@ -28,6 +28,81 @@=0D=0A  * - No mmap support - all access is thro=
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
ff_to_phys(dev_dax, pgoff, nr_pages << PAGE_SHIFT);=0D=0A+=0D=0A+=09if (k=
addr)=0D=0A+=09=09*kaddr =3D virt_addr;=0D=0A+=0D=0A+=09local_pfn =3D PHY=
S_PFN(phys);=0D=0A+=09if (pfn)=0D=0A+=09=09*pfn =3D local_pfn;=0D=0A+=0D=0A=
+=09/*=0D=0A+=09 * Use cached_size which was computed at probe time. The =
size cannot=0D=0A+=09 * change while the driver is bound (resize returns =
-EBUSY).=0D=0A+=09 */=0D=0A+=09return PHYS_PFN(min(size, dev_dax->cached_=
size - offset));=0D=0A+}=0D=0A+=0D=0A+static int fsdev_dax_zero_page_rang=
e(struct dax_device *dax_dev,=0D=0A+=09=09=09pgoff_t pgoff, size_t nr_pag=
es)=0D=0A+{=0D=0A+=09void *kaddr;=0D=0A+=0D=0A+=09WARN_ONCE(nr_pages > 1,=
 "%s: nr_pages > 1\n", __func__);=0D=0A+=09__fsdev_dax_direct_access(dax_=
dev, pgoff, 1, DAX_ACCESS, &kaddr, NULL);=0D=0A+=09fsdev_write_dax(kaddr,=
 ZERO_PAGE(0), 0, PAGE_SIZE);=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A+sta=
tic long fsdev_dax_direct_access(struct dax_device *dax_dev,=0D=0A+=09=09=
  pgoff_t pgoff, long nr_pages, enum dax_access_mode mode,=0D=0A+=09=09  =
void **kaddr, unsigned long *pfn)=0D=0A+{=0D=0A+=09return __fsdev_dax_dir=
ect_access(dax_dev, pgoff, nr_pages, mode,=0D=0A+=09=09=09=09=09 kaddr, p=
fn);=0D=0A+}=0D=0A+=0D=0A+static size_t fsdev_dax_recovery_write(struct d=
ax_device *dax_dev, pgoff_t pgoff,=0D=0A+=09=09void *addr, size_t bytes, =
struct iov_iter *i)=0D=0A+{=0D=0A+=09return _copy_from_iter_flushcache(ad=
dr, bytes, i);=0D=0A+}=0D=0A+=0D=0A+static const struct dax_operations de=
v_dax_ops =3D {=0D=0A+=09.direct_access =3D fsdev_dax_direct_access,=0D=0A=
+=09.zero_page_range =3D fsdev_dax_zero_page_range,=0D=0A+=09.recovery_wr=
ite =3D fsdev_dax_recovery_write,=0D=0A+};=0D=0A=20=0D=0A static void fsd=
ev_cdev_del(void *cdev)=0D=0A {=0D=0A@@ -163,6 +238,11 @@ static int fsde=
v_dax_probe(struct dev_dax *dev_dax)=0D=0A =09=09}=0D=0A =09}=0D=0A=20=0D=
=0A+=09/* Cache size now; it cannot change while driver is bound */=0D=0A=
+=09dev_dax->cached_size =3D 0;=0D=0A+=09for (i =3D 0; i < dev_dax->nr_ra=
nge; i++)=0D=0A+=09=09dev_dax->cached_size +=3D range_len(&dev_dax->range=
s[i].range);=0D=0A+=0D=0A =09/*=0D=0A =09 * FS-DAX compatible mode: Use M=
EMORY_DEVICE_FS_DAX type and=0D=0A =09 * do NOT set vmemmap_shift. This l=
eaves folios at order-0,=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

