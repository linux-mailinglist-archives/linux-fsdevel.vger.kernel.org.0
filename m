Return-Path: <linux-fsdevel+bounces-74221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896DD3857A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7FF3184773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20C25EF9C;
	Fri, 16 Jan 2026 19:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="n9TyfT9L";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="PsC3DXt9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-78.smtp-out.amazonses.com (a11-78.smtp-out.amazonses.com [54.240.11.78])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2295720FAAB;
	Fri, 16 Jan 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590506; cv=none; b=Lo9P2suPZngbX5Zih+VHEwOPW07R/olFDP7ebgc4iTvkowUivnjMkpDRFtBGC4VD3XxMseWe4UCZsssdYgZHHUBQbGi9OaX8e1TZ8TzxLq0EimZ4zpDY/DlUG+j17hGfHRXBwIn3hGrAidnOn1UI5vDdxHNf5P+rEWMyD8ruJZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590506; c=relaxed/simple;
	bh=HM58FM1bLvPI+YxR+6oOEZGiKc7o2DZYq1NWb78LvGc=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=s+ufVQMLrZxPNZfHay7qBsJnNQfbfVGFBYjPAkGwFlrwRrkzKuLRjkp+/Yt8id9NGRXAFX3fNLDL62Akb5rZaC+W6zZAYLTIK5ITAC4u7FenJtRIrsC1DUB5r6c/Vi3oPietWKWVdVxDVbIqKX+JsTkBxZo3oX1jVD+TLINrV/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=n9TyfT9L; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=PsC3DXt9; arc=none smtp.client-ip=54.240.11.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590504;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=HM58FM1bLvPI+YxR+6oOEZGiKc7o2DZYq1NWb78LvGc=;
	b=n9TyfT9LyUN4QbnJ6orvmh2wxF+UKPWemSkDLNDv8MepmHPeGMND1aVSpiwC5S4b
	cV5T0qHuV+RGAMXrOtwWqAxzwG2nX4k79R0EIiNjBqr6HLW8/IK4nuadIJjkhVfKFgL
	/hh59ZmfTUMp5T+ndKkhnYBk3zP8Ns8ybyPVZeWg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590504;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=HM58FM1bLvPI+YxR+6oOEZGiKc7o2DZYq1NWb78LvGc=;
	b=PsC3DXt9uqTXfClFqI2M81YSBcr+wuddGimwY48TAIU04zCKiT8F0yBf8vizFm57
	aQTYGPOJ6f/vAGra5MPpSTpkBm9HkVjriTL1wyVbByJ6kbdOFCai+7pz4ijiC7yXQeB
	Wtzu4W715GJTBOmQjlvBZi3xuG7DBvSa2xvTKck0=
Subject: [PATCH V5 16/19] famfs_fuse: Add holder_operations for dax
 notify_failure()
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
Date: Fri, 16 Jan 2026 19:08:24 +0000
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
 <20260116185911.1005-17-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAABXaoo=
Thread-Topic: [PATCH V5 16/19] famfs_fuse: Add holder_operations for dax
 notify_failure()
X-Wm-Sent-Timestamp: 1768590502
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc835703c-109f7e16-c589-4b9a-9851-fc36e5dc07bb-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.78

From: John Groves <john@groves.net>=0D=0A=0D=0AMemory errors are at least=
 somewhat more likely on disaggregated memory=0D=0Athan on-board memory. =
This commit registers to be notified by fsdev_dax=0D=0Ain the event that =
a memory failure is detected.=0D=0A=0D=0AWhen a file access resolves to a=
 daxdev with memory errors, it will fail=0D=0Awith an appropriate error.=0D=
=0A=0D=0AIf a daxdev failed fs_dax_get(), we set dd->dax_err. If a daxdev=
 called=0D=0Aour notify_failure(), set dd->error. When any of the above h=
appens, set=0D=0A(file)->error and stop allowing access.=0D=0A=0D=0AIn ge=
neral, the recovery from memory errors is to unmount the file=0D=0Asystem=
 and re-initialize the memory, but there may be usable degraded=0D=0Amode=
s of operation - particularly in the future when famfs supports=0D=0Afile=
 systems backed by more than one daxdev. In those cases,=0D=0Aaccessing d=
ata that is on a working daxdev can still work.=0D=0A=0D=0AFor now, retur=
n errors for any file that has encountered a memory or dax=0D=0Aerror.=0D=
=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A fs/f=
use/famfs.c       | 110 +++++++++++++++++++++++++++++++++++++++---=0D=0A =
fs/fuse/famfs_kfmap.h |   3 +-=0D=0A 2 files changed, 105 insertions(+), =
8 deletions(-)=0D=0A=0D=0Adiff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c=0D=
=0Aindex 2de70aef1df8..ee3526175b6b 100644=0D=0A--- a/fs/fuse/famfs.c=0D=0A=
+++ b/fs/fuse/famfs.c=0D=0A@@ -21,6 +21,26 @@=0D=0A #include "famfs_kfmap=
=2Eh"=0D=0A #include "fuse_i.h"=0D=0A=20=0D=0A+static void famfs_set_daxd=
ev_err(=0D=0A+=09struct fuse_conn *fc, struct dax_device *dax_devp);=0D=0A=
+=0D=0A+static int=0D=0A+famfs_dax_notify_failure(struct dax_device *dax_=
devp, u64 offset,=0D=0A+=09=09=09u64 len, int mf_flags)=0D=0A+{=0D=0A+=09=
struct fuse_conn *fc =3D dax_holder(dax_devp);=0D=0A+=0D=0A+=09famfs_set_=
daxdev_err(fc, dax_devp);=0D=0A+=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A+=
static const struct dax_holder_operations famfs_fuse_dax_holder_ops =3D {=
=0D=0A+=09.notify_failure=09=09=3D famfs_dax_notify_failure,=0D=0A+};=0D=0A=
+=0D=0A+/****************************************************************=
*************/=0D=0A+=0D=0A /*=0D=0A  * famfs_teardown()=0D=0A  *=0D=0A@@=
 -47,9 +67,12 @@ famfs_teardown(struct fuse_conn *fc)=0D=0A =09=09if (!dd=
->valid)=0D=0A =09=09=09continue;=0D=0A=20=0D=0A-=09=09/* Release referen=
ce from dax_dev_get() */=0D=0A-=09=09if (dd->devp)=0D=0A+=09=09/* Only ca=
ll fs_put_dax if fs_dax_get succeeded */=0D=0A+=09=09if (dd->devp) {=0D=0A=
+=09=09=09if (!dd->dax_err)=0D=0A+=09=09=09=09fs_put_dax(dd->devp, fc);=0D=
=0A =09=09=09put_dax(dd->devp);=0D=0A+=09=09}=0D=0A=20=0D=0A =09=09kfree(=
dd->name);=0D=0A =09}=0D=0A@@ -170,6 +193,17 @@ famfs_fuse_get_daxdev(str=
uct fuse_mount *fm, const u64 index)=0D=0A =09=09if (!daxdev->name)=0D=0A=
 =09=09=09return -ENOMEM;=0D=0A=20=0D=0A+=09=09rc =3D fs_dax_get(daxdev->=
devp, fc, &famfs_fuse_dax_holder_ops);=0D=0A+=09=09if (rc) {=0D=0A+=09=09=
=09/* If fs_dax_get() fails, we don't attempt recovery;=0D=0A+=09=09=09 *=
 We mark the daxdev valid with dax_err=0D=0A+=09=09=09 */=0D=0A+=09=09=09=
daxdev->dax_err =3D 1;=0D=0A+=09=09=09pr_err("%s: fs_dax_get(%lld) failed=
\n",=0D=0A+=09=09=09       __func__, (u64)daxdev->devno);=0D=0A+=09=09=09=
return -EBUSY;=0D=0A+=09=09}=0D=0A+=0D=0A =09=09wmb(); /* All other field=
s must be visible before valid */=0D=0A =09=09daxdev->valid =3D 1;=0D=0A =
=09}=0D=0A@@ -245,6 +279,36 @@ famfs_update_daxdev_table(=0D=0A =09return=
 0;=0D=0A }=0D=0A=20=0D=0A+static void=0D=0A+famfs_set_daxdev_err(=0D=0A+=
=09struct fuse_conn *fc,=0D=0A+=09struct dax_device *dax_devp)=0D=0A+{=0D=
=0A+=09int i;=0D=0A+=0D=0A+=09/* Gotta search the list by dax_devp;=0D=0A=
+=09 * read lock because we're not adding or removing daxdev entries=0D=0A=
+=09 */=0D=0A+=09scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {=0D=0A=
+=09=09for (i =3D 0; i < fc->dax_devlist->nslots; i++) {=0D=0A+=09=09=09i=
f (fc->dax_devlist->devlist[i].valid) {=0D=0A+=09=09=09=09struct famfs_da=
xdev *dd;=0D=0A+=0D=0A+=09=09=09=09dd =3D &fc->dax_devlist->devlist[i];=0D=
=0A+=09=09=09=09if (dd->devp !=3D dax_devp)=0D=0A+=09=09=09=09=09continue=
;=0D=0A+=0D=0A+=09=09=09=09dd->error =3D true;=0D=0A+=0D=0A+=09=09=09=09p=
r_err("%s: memory error on daxdev %s (%d)\n",=0D=0A+=09=09=09=09       __=
func__, dd->name, i);=0D=0A+=09=09=09=09return;=0D=0A+=09=09=09}=0D=0A+=09=
=09}=0D=0A+=09}=0D=0A+=09pr_err("%s: memory err on unrecognized daxdev\n"=
, __func__);=0D=0A+}=0D=0A+=0D=0A /**************************************=
*************************************/=0D=0A=20=0D=0A void __famfs_meta_f=
ree(void *famfs_meta)=0D=0A@@ -583,6 +647,26 @@ famfs_file_init_dax(=0D=0A=
=20=0D=0A static int famfs_file_bad(struct inode *inode);=0D=0A=20=0D=0A+=
static int famfs_dax_err(struct famfs_daxdev *dd)=0D=0A+{=0D=0A+=09if (!d=
d->valid) {=0D=0A+=09=09pr_err("%s: daxdev=3D%s invalid\n",=0D=0A+=09=09 =
      __func__, dd->name);=0D=0A+=09=09return -EIO;=0D=0A+=09}=0D=0A+=09i=
f (dd->dax_err) {=0D=0A+=09=09pr_err("%s: daxdev=3D%s dax_err\n",=0D=0A+=09=
=09       __func__, dd->name);=0D=0A+=09=09return -EIO;=0D=0A+=09}=0D=0A+=
=09if (dd->error) {=0D=0A+=09=09pr_err("%s: daxdev=3D%s memory error\n",=0D=
=0A+=09=09       __func__, dd->name);=0D=0A+=09=09return -EHWPOISON;=0D=0A=
+=09}=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A static int=0D=0A famfs_inte=
rleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,=0D=0A =
=09=09=09 loff_t file_offset, off_t len, unsigned int flags)=0D=0A@@ -617=
,6 +701,7 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, stru=
ct iomap *iomap,=0D=0A=20=0D=0A =09=09/* Is the data is in this striped e=
xtent=3F */=0D=0A =09=09if (local_offset < ext_size) {=0D=0A+=09=09=09str=
uct famfs_daxdev *dd;=0D=0A =09=09=09u64 chunk_num       =3D local_offset=
 / chunk_size;=0D=0A =09=09=09u64 chunk_offset    =3D local_offset % chun=
k_size;=0D=0A =09=09=09u64 chunk_remainder =3D chunk_size - chunk_offset;=
=0D=0A@@ -625,6 +710,7 @@ famfs_interleave_fileofs_to_daxofs(struct inode=
 *inode, struct iomap *iomap,=0D=0A =09=09=09u64 strip_offset    =3D chun=
k_offset + (stripe_num * chunk_size);=0D=0A =09=09=09u64 strip_dax_ofs =3D=
 fei->ie_strips[strip_num].ext_offset;=0D=0A =09=09=09u64 strip_devidx =3D=
 fei->ie_strips[strip_num].dev_index;=0D=0A+=09=09=09int rc;=0D=0A=20=0D=0A=
 =09=09=09if (strip_devidx >=3D fc->dax_devlist->nslots) {=0D=0A =09=09=09=
=09pr_err("%s: strip_devidx %llu >=3D nslots %d\n",=0D=0A@@ -639,6 +725,1=
5 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap=
 *iomap,=0D=0A =09=09=09=09goto err_out;=0D=0A =09=09=09}=0D=0A=20=0D=0A+=
=09=09=09dd =3D &fc->dax_devlist->devlist[strip_devidx];=0D=0A+=0D=0A+=09=
=09=09rc =3D famfs_dax_err(dd);=0D=0A+=09=09=09if (rc) {=0D=0A+=09=09=09=09=
/* Shut down access to this file */=0D=0A+=09=09=09=09meta->error =3D tru=
e;=0D=0A+=09=09=09=09return rc;=0D=0A+=09=09=09}=0D=0A+=0D=0A =09=09=09io=
map->addr    =3D strip_dax_ofs + strip_offset;=0D=0A =09=09=09iomap->offs=
et  =3D file_offset;=0D=0A =09=09=09iomap->length  =3D min_t(loff_t, len,=
 chunk_remainder);=0D=0A@@ -736,6 +831,7 @@ famfs_fileofs_to_daxofs(struc=
t inode *inode, struct iomap *iomap,=0D=0A =09=09if (local_offset < dax_e=
xt_len) {=0D=0A =09=09=09loff_t ext_len_remainder =3D dax_ext_len - local=
_offset;=0D=0A =09=09=09struct famfs_daxdev *dd;=0D=0A+=09=09=09int rc;=0D=
=0A=20=0D=0A =09=09=09if (daxdev_idx >=3D fc->dax_devlist->nslots) {=0D=0A=
 =09=09=09=09pr_err("%s: daxdev_idx %llu >=3D nslots %d\n",=0D=0A@@ -746,=
11 +842,11 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *=
iomap,=0D=0A=20=0D=0A =09=09=09dd =3D &fc->dax_devlist->devlist[daxdev_id=
x];=0D=0A=20=0D=0A-=09=09=09if (!dd->valid || dd->error) {=0D=0A-=09=09=09=
=09pr_err("%s: daxdev=3D%lld %s\n", __func__,=0D=0A-=09=09=09=09       da=
xdev_idx,=0D=0A-=09=09=09=09       dd->valid =3F "error" : "invalid");=0D=
=0A-=09=09=09=09goto err_out;=0D=0A+=09=09=09rc =3D famfs_dax_err(dd);=0D=
=0A+=09=09=09if (rc) {=0D=0A+=09=09=09=09/* Shut down access to this file=
 */=0D=0A+=09=09=09=09meta->error =3D true;=0D=0A+=09=09=09=09return rc;=0D=
=0A =09=09=09}=0D=0A=20=0D=0A =09=09=09/*=0D=0Adiff --git a/fs/fuse/famfs=
_kfmap.h b/fs/fuse/famfs_kfmap.h=0D=0Aindex eb9f70b5cb81..0fff841f5a9e 10=
0644=0D=0A--- a/fs/fuse/famfs_kfmap.h=0D=0A+++ b/fs/fuse/famfs_kfmap.h=0D=
=0A@@ -73,7 +73,8 @@ struct famfs_file_meta {=0D=0A struct famfs_daxdev {=
=0D=0A =09/* Include dev uuid=3F */=0D=0A =09bool valid;=0D=0A-=09bool er=
ror;=0D=0A+=09bool error; /* Dax has reported a memory error (probably po=
ison) */=0D=0A+=09bool dax_err; /* fs_dax_get() failed */=0D=0A =09dev_t =
devno;=0D=0A =09struct dax_device *devp;=0D=0A =09char *name;=0D=0A--=20=0D=
=0A2.52.0=0D=0A=0D=0A

