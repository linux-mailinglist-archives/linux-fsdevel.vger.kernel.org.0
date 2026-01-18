Return-Path: <linux-fsdevel+bounces-74331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A45D39A99
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEDB8300CCD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE030DD1E;
	Sun, 18 Jan 2026 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="i4fxSOJF";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Uh0BJ6kf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a48-178.smtp-out.amazonses.com (a48-178.smtp-out.amazonses.com [54.240.48.178])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B1DB640;
	Sun, 18 Jan 2026 22:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.48.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775535; cv=none; b=qYfoeywN83BUPfHpRvH21A73VEzsgWYnW5AVPk6mMVpSTNEdXCg6J3ai6H/27Mypdw8NyFS7QK+EGJrX3FcYzMedEMq72GkRTDvsf1jkErm0ynIPtCLbNE4ml1UH1CATqSXs8geq82mze26wdBWQzNAsVlY6WBdixEBdLjhcnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775535; c=relaxed/simple;
	bh=y6NAlP81GLOk95ew+ly4J44rwUvZJcbu3CaI+NQVWTQ=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=IwHkgbYesdRMeIhlHHAKJKNhnltaGxiEbrkq6IE9TakVPIz5Sd/xytUzzAhX6ttwSA0D2FEizXzS+75tZ4JVxcLXg/tZ7xmQwiprMKszS3Wyu1M9ngKjDnFs/esa6TUQM0NEODwOd4lC2Zg3X712lXwDoNkHkWVKk32nMGd1Ij8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=i4fxSOJF; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Uh0BJ6kf; arc=none smtp.client-ip=54.240.48.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775533;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=y6NAlP81GLOk95ew+ly4J44rwUvZJcbu3CaI+NQVWTQ=;
	b=i4fxSOJFMVEXpk+rV39TucPnHlhe91p5QTIoTQIIhSI1iaUoNGMEJKkF8ncmS5Ay
	I0ASgokC8uvdX5l8icShWHNZX1RURW/w2tYG+ofcufJkSlrgp7yOPER+p9WVOY4kpRI
	6cdxk7HZ21aDbK3o22I8S3zOoWXoueGoXp2Wsgps=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775533;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=y6NAlP81GLOk95ew+ly4J44rwUvZJcbu3CaI+NQVWTQ=;
	b=Uh0BJ6kfMPB8lchmbAZOQ/TO513tJDN5LbvfLoyO9oSbfVD50CHToMcLP2yHSD3Q
	sDTawyIvVoRHYNwLcmoVpPh2d/84tDcT+RNQfwHO+wmjEfLzadh6p1UN3gsVx2Ll08H
	3fC1XBfmGXRlOc/8Dc4ihlZH5/BJ6L2leYVMfR40=
Subject: [PATCH V7 07/19] dax: Add fs_dax_get() func to prepare dax for
 fs-dax usage
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
Date: Sun, 18 Jan 2026 22:32:12 +0000
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
 <20260118223206.92430-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAaHto=
Thread-Topic: [PATCH V7 07/19] dax: Add fs_dax_get() func to prepare dax for
 fs-dax usage
X-Wm-Sent-Timestamp: 1768775531
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33cc18d-83012e03-8214-45a4-91cf-c8b598cd4535-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.48.178

From: John Groves <john@groves.net>=0D=0A=0D=0AThe fs_dax_get() function =
should be called by fs-dax file systems after=0D=0Aopening a fsdev dax de=
vice. This adds holder_operations, which provides=0D=0Aa memory failure c=
allback path and effects exclusivity between callers=0D=0Aof fs_dax_get()=
=2E=0D=0A=0D=0Afs_dax_get() is specific to fsdev_dax, so it checks the dr=
iver type=0D=0A(which required touching bus.[ch]). fs_dax_get() fails if =
fsdev_dax is=0D=0Anot bound to the memory.=0D=0A=0D=0AThis function serve=
s the same role as fs_dax_get_by_bdev(), which dax=0D=0Afile systems call=
 after opening the pmem block device.=0D=0A=0D=0AThis can't be located in=
 fsdev.c because struct dax_device is opaque=0D=0Athere.=0D=0A=0D=0AThis =
will be called by fs/fuse/famfs.c in a subsequent commit.=0D=0A=0D=0ASign=
ed-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A drivers/dax/bus.c=
   |  2 --=0D=0A drivers/dax/bus.h   |  2 ++=0D=0A drivers/dax/super.c | =
58 ++++++++++++++++++++++++++++++++++++++++++++-=0D=0A include/linux/dax.=
h | 20 ++++++++++------=0D=0A 4 files changed, 72 insertions(+), 10 delet=
ions(-)=0D=0A=0D=0Adiff --git a/drivers/dax/bus.c b/drivers/dax/bus.c=0D=0A=
index e79daf825b52..01402d5103ef 100644=0D=0A--- a/drivers/dax/bus.c=0D=0A=
+++ b/drivers/dax/bus.c=0D=0A@@ -39,8 +39,6 @@ static int dax_bus_uevent(=
const struct device *dev, struct kobj_uevent_env *env)=0D=0A =09return ad=
d_uevent_var(env, "MODALIAS=3D" DAX_DEVICE_MODALIAS_FMT, 0);=0D=0A }=0D=0A=
=20=0D=0A-#define to_dax_drv(__drv)=09container_of_const(__drv, struct da=
x_device_driver, drv)=0D=0A-=0D=0A static struct dax_id *__dax_match_id(c=
onst struct dax_device_driver *dax_drv,=0D=0A =09=09const char *dev_name)=
=0D=0A {=0D=0Adiff --git a/drivers/dax/bus.h b/drivers/dax/bus.h=0D=0Aind=
ex 880bdf7e72d7..dc6f112ac4a4 100644=0D=0A--- a/drivers/dax/bus.h=0D=0A++=
+ b/drivers/dax/bus.h=0D=0A@@ -42,6 +42,8 @@ struct dax_device_driver {=0D=
=0A =09void (*remove)(struct dev_dax *dev);=0D=0A };=0D=0A=20=0D=0A+#defi=
ne to_dax_drv(__drv) container_of_const(__drv, struct dax_device_driver, =
drv)=0D=0A+=0D=0A int __dax_driver_register(struct dax_device_driver *dax=
_drv,=0D=0A =09=09struct module *module, const char *mod_name);=0D=0A #de=
fine dax_driver_register(driver) \=0D=0Adiff --git a/drivers/dax/super.c =
b/drivers/dax/super.c=0D=0Aindex ba0b4cd18a77..00c330ef437c 100644=0D=0A-=
-- a/drivers/dax/super.c=0D=0A+++ b/drivers/dax/super.c=0D=0A@@ -14,6 +14=
,7 @@=0D=0A #include <linux/fs.h>=0D=0A #include <linux/cacheinfo.h>=0D=0A=
 #include "dax-private.h"=0D=0A+#include "bus.h"=0D=0A=20=0D=0A /**=0D=0A=
  * struct dax_device - anchor object for dax services=0D=0A@@ -111,6 +11=
2,10 @@ struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev, =
u64 *start_off,=0D=0A }=0D=0A EXPORT_SYMBOL_GPL(fs_dax_get_by_bdev);=0D=0A=
=20=0D=0A+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */=0D=0A+=0D=0A+#if IS_=
ENABLED(CONFIG_FS_DAX)=0D=0A+=0D=0A void fs_put_dax(struct dax_device *da=
x_dev, void *holder)=0D=0A {=0D=0A =09if (dax_dev && holder &&=0D=0A@@ -1=
19,7 +124,58 @@ void fs_put_dax(struct dax_device *dax_dev, void *holder)=
=0D=0A =09put_dax(dax_dev);=0D=0A }=0D=0A EXPORT_SYMBOL_GPL(fs_put_dax);=0D=
=0A-#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */=0D=0A+=0D=0A+/**=0D=0A+ * =
fs_dax_get() - get ownership of a devdax via holder/holder_ops=0D=0A+ *=0D=
=0A+ * fs-dax file systems call this function to prepare to use a devdax =
device for=0D=0A+ * fsdax. This is like fs_dax_get_by_bdev(), but the cal=
ler already has struct=0D=0A+ * dev_dax (and there is no bdev). The holde=
r makes this exclusive.=0D=0A+ *=0D=0A+ * @dax_dev: dev to be prepared fo=
r fs-dax usage=0D=0A+ * @holder: filesystem or mapped device inside the d=
ax_device=0D=0A+ * @hops: operations for the inner holder=0D=0A+ *=0D=0A+=
 * Returns: 0 on success, <0 on failure=0D=0A+ */=0D=0A+int fs_dax_get(st=
ruct dax_device *dax_dev, void *holder,=0D=0A+=09const struct dax_holder_=
operations *hops)=0D=0A+{=0D=0A+=09struct dev_dax *dev_dax;=0D=0A+=09stru=
ct dax_device_driver *dax_drv;=0D=0A+=09int id;=0D=0A+=0D=0A+=09id =3D da=
x_read_lock();=0D=0A+=09if (!dax_dev || !dax_alive(dax_dev) || !igrab(&da=
x_dev->inode)) {=0D=0A+=09=09dax_read_unlock(id);=0D=0A+=09=09return -ENO=
DEV;=0D=0A+=09}=0D=0A+=09dax_read_unlock(id);=0D=0A+=0D=0A+=09/* Verify t=
he device is bound to fsdev_dax driver */=0D=0A+=09dev_dax =3D dax_get_pr=
ivate(dax_dev);=0D=0A+=09if (!dev_dax || !dev_dax->dev.driver) {=0D=0A+=09=
=09iput(&dax_dev->inode);=0D=0A+=09=09return -ENODEV;=0D=0A+=09}=0D=0A+=0D=
=0A+=09dax_drv =3D to_dax_drv(dev_dax->dev.driver);=0D=0A+=09if (dax_drv-=
>type !=3D DAXDRV_FSDEV_TYPE) {=0D=0A+=09=09iput(&dax_dev->inode);=0D=0A+=
=09=09return -EOPNOTSUPP;=0D=0A+=09}=0D=0A+=0D=0A+=09if (cmpxchg(&dax_dev=
->holder_data, NULL, holder)) {=0D=0A+=09=09iput(&dax_dev->inode);=0D=0A+=
=09=09return -EBUSY;=0D=0A+=09}=0D=0A+=0D=0A+=09dax_dev->holder_ops =3D h=
ops;=0D=0A+=0D=0A+=09return 0;=0D=0A+}=0D=0A+EXPORT_SYMBOL_GPL(fs_dax_get=
);=0D=0A+#endif /* CONFIG_FS_DAX */=0D=0A=20=0D=0A enum dax_device_flags =
{=0D=0A =09/* !alive + rcu grace period =3D=3D no new operations / mappin=
gs */=0D=0Adiff --git a/include/linux/dax.h b/include/linux/dax.h=0D=0Ain=
dex 5aaaca135737..6897c5736543 100644=0D=0A--- a/include/linux/dax.h=0D=0A=
+++ b/include/linux/dax.h=0D=0A@@ -52,9 +52,6 @@ struct dax_holder_operat=
ions {=0D=0A #if IS_ENABLED(CONFIG_DAX)=0D=0A struct dax_device *alloc_da=
x(void *private, const struct dax_operations *ops);=0D=0A=20=0D=0A-#if IS=
_ENABLED(CONFIG_DEV_DAX_FS)=0D=0A-struct dax_device *inode_dax(struct ino=
de *inode);=0D=0A-#endif=0D=0A void *dax_holder(struct dax_device *dax_de=
v);=0D=0A void put_dax(struct dax_device *dax_dev);=0D=0A void kill_dax(s=
truct dax_device *dax_dev);=0D=0A@@ -134,7 +131,6 @@ int dax_add_host(str=
uct dax_device *dax_dev, struct gendisk *disk);=0D=0A void dax_remove_hos=
t(struct gendisk *disk);=0D=0A struct dax_device *fs_dax_get_by_bdev(stru=
ct block_device *bdev, u64 *start_off,=0D=0A =09=09void *holder, const st=
ruct dax_holder_operations *ops);=0D=0A-void fs_put_dax(struct dax_device=
 *dax_dev, void *holder);=0D=0A #else=0D=0A static inline int dax_add_hos=
t(struct dax_device *dax_dev, struct gendisk *disk)=0D=0A {=0D=0A@@ -149,=
12 +145,13 @@ static inline struct dax_device *fs_dax_get_by_bdev(struct =
block_device *bdev,=0D=0A {=0D=0A =09return NULL;=0D=0A }=0D=0A-static in=
line void fs_put_dax(struct dax_device *dax_dev, void *holder)=0D=0A-{=0D=
=0A-}=0D=0A #endif /* CONFIG_BLOCK && CONFIG_FS_DAX */=0D=0A=20=0D=0A #if=
 IS_ENABLED(CONFIG_FS_DAX)=0D=0A+void fs_put_dax(struct dax_device *dax_d=
ev, void *holder);=0D=0A+int fs_dax_get(struct dax_device *dax_dev, void =
*holder,=0D=0A+=09       const struct dax_holder_operations *hops);=0D=0A=
+struct dax_device *inode_dax(struct inode *inode);=0D=0A int dax_writeba=
ck_mapping_range(struct address_space *mapping,=0D=0A =09=09struct dax_de=
vice *dax_dev, struct writeback_control *wbc);=0D=0A int dax_folio_reset_=
order(struct folio *folio);=0D=0A@@ -168,6 +165,15 @@ dax_entry_t dax_loc=
k_mapping_entry(struct address_space *mapping,=0D=0A void dax_unlock_mapp=
ing_entry(struct address_space *mapping,=0D=0A =09=09unsigned long index,=
 dax_entry_t cookie);=0D=0A #else=0D=0A+static inline void fs_put_dax(str=
uct dax_device *dax_dev, void *holder)=0D=0A+{=0D=0A+}=0D=0A+=0D=0A+stati=
c inline int fs_dax_get(struct dax_device *dax_dev, void *holder,=0D=0A+=09=
=09=09     const struct dax_holder_operations *hops)=0D=0A+{=0D=0A+=09ret=
urn -EOPNOTSUPP;=0D=0A+}=0D=0A static inline struct page *dax_layout_busy=
_page(struct address_space *mapping)=0D=0A {=0D=0A =09return NULL;=0D=0A-=
-=20=0D=0A2.52.0=0D=0A=0D=0A

