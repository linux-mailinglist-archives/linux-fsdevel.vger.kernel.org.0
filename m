Return-Path: <linux-fsdevel+bounces-74338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C56D39AEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96BAB3019BA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A1F31194A;
	Sun, 18 Jan 2026 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="vvkhxprv";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="KgW/L3eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-129.smtp-out.amazonses.com (a11-129.smtp-out.amazonses.com [54.240.11.129])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ADC27F4E7;
	Sun, 18 Jan 2026 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775606; cv=none; b=IuSPxnaT2Mgd+gntsVfAb3eQdj+m/RV4duYSTvN9NA3nsiTgA9+EGvMoLvJ5QNlTqS4bIG0Y57SUpDmK/ja69rn7IJ6dQzbSOKRWAb8oWWy/WLnbZbrMJ+IlnBu+jewUvRScxRtCSCP4GeoyW0VAPTyhEKZH1klYAoB60I3cMt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775606; c=relaxed/simple;
	bh=FxeuEuU/MSWoYTqMay7Zj1P6el9WS+mPTBUB+/7D5VU=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=sbXRBSjU9MjmAKxgt8SMAIZ5hJNqRXI0aZpqcLpz5bi+G1UVRsRkKABq11P3zEN2Y4ABtq/MeGKlVJOqOrUzrjzUPF8La0uWBSB0xBFNJhnBp2JJ842AV7SajZH1aMzQ6Aev27LOmUisyUF0JK65q2xTAPSYWlCPXwikzBWoEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=vvkhxprv; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=KgW/L3eZ; arc=none smtp.client-ip=54.240.11.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775602;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=FxeuEuU/MSWoYTqMay7Zj1P6el9WS+mPTBUB+/7D5VU=;
	b=vvkhxprvEkh+oESRs2RImSKrwEBclzwhiaMDkjnqGA1VZEEjSbrc3Fg8MTGP0xkf
	zYt3Oglc1yny44zgyvfmMb7ruAyv3SwUmNBBWaqCU7U8WTLDOjdhLbd+Vu987G38k+2
	qbzoljnHMAxiimlQbp9hl3jQd/t8X+L+/hpuKngg=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775602;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=FxeuEuU/MSWoYTqMay7Zj1P6el9WS+mPTBUB+/7D5VU=;
	b=KgW/L3eZ9gJsAi/br4ImjpyAI8M6oisLjckYlt3Y6/d4HuRDf4Gy6c4EwAdN84hL
	fCifv5SyfKzXtUJlkJljusb+6Yuv1lDcxBXLnBl1m4ilXT6xcZkFzKBj6oqxGhwSOEO
	x7B7svKg3dcUr/qwx7jrYdpl/ffSkAYc4GpwrdSM=
Subject: [PATCH V7 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
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
Date: Sun, 18 Jan 2026 22:33:22 +0000
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
 <20260118223316.92580-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAkg4E=
Thread-Topic: [PATCH V7 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
X-Wm-Sent-Timestamp: 1768775601
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33dd1f9-3e016d01-fe3b-4be0-a8d0-f566cd5e2c07-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.129

From: John Groves <john@groves.net>=0D=0A=0D=0A- The new GET_DAXDEV messa=
ge/response is added=0D=0A- The famfs.c:famfs_teardown() function is adde=
d as a primary teardown=0D=0A  function for famfs.=0D=0A- The command it =
triggered by the update_daxdev_table() call, if there=0D=0A  are any daxd=
evs in the subject fmap that are not represented in the=0D=0A  daxdev_tab=
le yet.=0D=0A- fs/namei.c: export may_open_dev()=0D=0A=0D=0ASigned-off-by=
: John Groves <john@groves.net>=0D=0A---=0D=0A fs/fuse/famfs.c           =
| 230 +++++++++++++++++++++++++++++++++++++-=0D=0A fs/fuse/famfs_kfmap.h =
    |  26 +++++=0D=0A fs/fuse/fuse_i.h          |  19 ++++=0D=0A fs/fuse/=
inode.c           |   7 +-=0D=0A fs/namei.c                |   1 +=0D=0A =
include/uapi/linux/fuse.h |  20 ++++=0D=0A 6 files changed, 301 insertion=
s(+), 2 deletions(-)=0D=0A=0D=0Adiff --git a/fs/fuse/famfs.c b/fs/fuse/fa=
mfs.c=0D=0Aindex a9728e11f1dd..7aa2eb2e99bf 100644=0D=0A--- a/fs/fuse/fam=
fs.c=0D=0A+++ b/fs/fuse/famfs.c=0D=0A@@ -21,6 +21,231 @@=0D=0A #include "=
famfs_kfmap.h"=0D=0A #include "fuse_i.h"=0D=0A=20=0D=0A+/*=0D=0A+ * famfs=
_teardown()=0D=0A+ *=0D=0A+ * Deallocate famfs metadata for a fuse_conn=0D=
=0A+ */=0D=0A+void=0D=0A+famfs_teardown(struct fuse_conn *fc)=0D=0A+{=0D=0A=
+=09struct famfs_dax_devlist *devlist =3D fc->dax_devlist;=0D=0A+=09int i=
;=0D=0A+=0D=0A+=09fc->dax_devlist =3D NULL;=0D=0A+=0D=0A+=09if (!devlist)=
=0D=0A+=09=09return;=0D=0A+=0D=0A+=09if (!devlist->devlist)=0D=0A+=09=09g=
oto out;=0D=0A+=0D=0A+=09/* Close & release all the daxdevs in our table =
*/=0D=0A+=09for (i =3D 0; i < devlist->nslots; i++) {=0D=0A+=09=09struct =
famfs_daxdev *dd =3D &devlist->devlist[i];=0D=0A+=0D=0A+=09=09if (!dd->va=
lid)=0D=0A+=09=09=09continue;=0D=0A+=0D=0A+=09=09/* Release reference fro=
m dax_dev_get() */=0D=0A+=09=09if (dd->devp)=0D=0A+=09=09=09put_dax(dd->d=
evp);=0D=0A+=0D=0A+=09=09kfree(dd->name);=0D=0A+=09}=0D=0A+=09kfree(devli=
st->devlist);=0D=0A+=0D=0A+out:=0D=0A+=09kfree(devlist);=0D=0A+}=0D=0A+=0D=
=0A+static int=0D=0A+famfs_verify_daxdev(const char *pathname, dev_t *dev=
no)=0D=0A+{=0D=0A+=09struct inode *inode;=0D=0A+=09struct path path;=0D=0A=
+=09int err;=0D=0A+=0D=0A+=09if (!pathname || !*pathname)=0D=0A+=09=09ret=
urn -EINVAL;=0D=0A+=0D=0A+=09err =3D kern_path(pathname, LOOKUP_FOLLOW, &=
path);=0D=0A+=09if (err)=0D=0A+=09=09return err;=0D=0A+=0D=0A+=09inode =3D=
 d_backing_inode(path.dentry);=0D=0A+=09if (!S_ISCHR(inode->i_mode)) {=0D=
=0A+=09=09err =3D -EINVAL;=0D=0A+=09=09goto out_path_put;=0D=0A+=09}=0D=0A=
+=0D=0A+=09if (!may_open_dev(&path)) { /* had to export this */=0D=0A+=09=
=09err =3D -EACCES;=0D=0A+=09=09goto out_path_put;=0D=0A+=09}=0D=0A+=0D=0A=
+=09*devno =3D inode->i_rdev;=0D=0A+=0D=0A+out_path_put:=0D=0A+=09path_pu=
t(&path);=0D=0A+=09return err;=0D=0A+}=0D=0A+=0D=0A+/**=0D=0A+ * famfs_fu=
se_get_daxdev() - Retrieve info for a DAX device from fuse server=0D=0A+ =
*=0D=0A+ * Send a GET_DAXDEV message to the fuse server to retrieve info =
on a=0D=0A+ * dax device.=0D=0A+ *=0D=0A+ * @fm:     fuse_mount=0D=0A+ * =
@index:  the index of the dax device; daxdevs are referred to by index=0D=
=0A+ *          in fmaps, and the server resolves the index to a particul=
ar daxdev=0D=0A+ *=0D=0A+ * Returns: 0=3Dsuccess=0D=0A+ *          -errno=
=3Dfailure=0D=0A+ */=0D=0A+static int=0D=0A+famfs_fuse_get_daxdev(struct =
fuse_mount *fm, const u64 index)=0D=0A+{=0D=0A+=09struct fuse_daxdev_out =
daxdev_out =3D { 0 };=0D=0A+=09struct fuse_conn *fc =3D fm->fc;=0D=0A+=09=
struct famfs_daxdev *daxdev;=0D=0A+=09int rc;=0D=0A+=0D=0A+=09FUSE_ARGS(a=
rgs);=0D=0A+=0D=0A+=09/* Store the daxdev in our table */=0D=0A+=09if (in=
dex >=3D fc->dax_devlist->nslots) {=0D=0A+=09=09pr_err("%s: index(%lld) >=
 nslots(%d)\n",=0D=0A+=09=09       __func__, index, fc->dax_devlist->nslo=
ts);=0D=0A+=09=09return -EINVAL;=0D=0A+=09}=0D=0A+=0D=0A+=09args.opcode =3D=
 FUSE_GET_DAXDEV;=0D=0A+=09args.nodeid =3D index;=0D=0A+=0D=0A+=09args.in=
_numargs =3D 0;=0D=0A+=0D=0A+=09args.out_numargs =3D 1;=0D=0A+=09args.out=
_args[0].size =3D sizeof(daxdev_out);=0D=0A+=09args.out_args[0].value =3D=
 &daxdev_out;=0D=0A+=0D=0A+=09/* Send GET_DAXDEV command */=0D=0A+=09rc =3D=
 fuse_simple_request(fm, &args);=0D=0A+=09if (rc) {=0D=0A+=09=09pr_err("%=
s: rc=3D%d from fuse_simple_request()\n",=0D=0A+=09=09       __func__, rc=
);=0D=0A+=09=09/* Error will be that the payload is smaller than FMAP_BUF=
SIZE,=0D=0A+=09=09 * which is the max we can handle. Empty payload handle=
d below.=0D=0A+=09=09 */=0D=0A+=09=09return rc;=0D=0A+=09}=0D=0A+=0D=0A+=09=
scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {=0D=0A+=09=09daxdev =3D=
 &fc->dax_devlist->devlist[index];=0D=0A+=0D=0A+=09=09/* Abort if daxdev =
is now valid (races are possible here) */=0D=0A+=09=09if (daxdev->valid) =
{=0D=0A+=09=09=09pr_debug("%s: daxdev already known\n", __func__);=0D=0A+=
=09=09=09return 0;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09/* Verify dev is vali=
d and can be opened and gets the devno */=0D=0A+=09=09rc =3D famfs_verify=
_daxdev(daxdev_out.name, &daxdev->devno);=0D=0A+=09=09if (rc) {=0D=0A+=09=
=09=09pr_err("%s: rc=3D%d from famfs_verify_daxdev()\n",=0D=0A+=09=09=09 =
      __func__, rc);=0D=0A+=09=09=09return rc;=0D=0A+=09=09}=0D=0A+=0D=0A=
+=09=09daxdev->name =3D kstrdup(daxdev_out.name, GFP_KERNEL);=0D=0A+=09=09=
if (!daxdev->name)=0D=0A+=09=09=09return -ENOMEM;=0D=0A+=0D=0A+=09=09/* T=
his will fail if it's not a dax device */=0D=0A+=09=09daxdev->devp =3D da=
x_dev_get(daxdev->devno);=0D=0A+=09=09if (!daxdev->devp) {=0D=0A+=09=09=09=
pr_warn("%s: device %s not found or not dax\n",=0D=0A+=09=09=09=09__func_=
_, daxdev_out.name);=0D=0A+=09=09=09kfree(daxdev->name);=0D=0A+=09=09=09d=
axdev->name =3D NULL;=0D=0A+=09=09=09return -ENODEV;=0D=0A+=09=09}=0D=0A+=
=0D=0A+=09=09wmb(); /* All other fields must be visible before valid */=0D=
=0A+=09=09daxdev->valid =3D 1;=0D=0A+=09}=0D=0A+=0D=0A+=09return 0;=0D=0A=
+}=0D=0A+=0D=0A+/**=0D=0A+ * famfs_update_daxdev_table() - Update the dax=
dev table=0D=0A+ * @fm:   fuse_mount=0D=0A+ * @meta: famfs_file_meta, in-=
memory format, built from a GET_FMAP response=0D=0A+ *=0D=0A+ * This func=
tion is called for each new file fmap, to verify whether all=0D=0A+ * ref=
erenced daxdevs are already known (i.e. in the table). Any daxdev=0D=0A+ =
* indices referenced in @meta but not in the table will be retrieved via=0D=
=0A+ * famfs_fuse_get_daxdev() and added to the table=0D=0A+ *=0D=0A+ * R=
eturn: 0=3Dsuccess=0D=0A+ *         -errno=3Dfailure=0D=0A+ */=0D=0A+stat=
ic int=0D=0A+famfs_update_daxdev_table(=0D=0A+=09struct fuse_mount *fm,=0D=
=0A+=09const struct famfs_file_meta *meta)=0D=0A+{=0D=0A+=09struct famfs_=
dax_devlist *local_devlist;=0D=0A+=09struct fuse_conn *fc =3D fm->fc;=0D=0A=
+=09int indices_to_fetch[MAX_DAXDEVS];=0D=0A+=09int n_to_fetch =3D 0;=0D=0A=
+=09int err;=0D=0A+=0D=0A+=09/* First time through we will need to alloca=
te the dax_devlist */=0D=0A+=09if (!fc->dax_devlist) {=0D=0A+=09=09local_=
devlist =3D kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);=0D=0A+=09=09=
if (!local_devlist)=0D=0A+=09=09=09return -ENOMEM;=0D=0A+=0D=0A+=09=09loc=
al_devlist->nslots =3D MAX_DAXDEVS;=0D=0A+=0D=0A+=09=09local_devlist->dev=
list =3D kcalloc(MAX_DAXDEVS,=0D=0A+=09=09=09=09=09=09 sizeof(struct famf=
s_daxdev),=0D=0A+=09=09=09=09=09=09 GFP_KERNEL);=0D=0A+=09=09if (!local_d=
evlist->devlist) {=0D=0A+=09=09=09kfree(local_devlist);=0D=0A+=09=09=09re=
turn -ENOMEM;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09/* We don't need famfs_dev=
list_sem here because we use cmpxchg */=0D=0A+=09=09if (cmpxchg(&fc->dax_=
devlist, NULL, local_devlist) !=3D NULL) {=0D=0A+=09=09=09kfree(local_dev=
list->devlist);=0D=0A+=09=09=09kfree(local_devlist); /* another thread be=
at us to it */=0D=0A+=09=09}=0D=0A+=09}=0D=0A+=0D=0A+=09/* Collect indice=
s that need fetching while holding read lock */=0D=0A+=09scoped_guard(rws=
em_read, &fc->famfs_devlist_sem) {=0D=0A+=09=09unsigned long i;=0D=0A+=0D=
=0A+=09=09for_each_set_bit(i, (unsigned long *)&meta->dev_bitmap, MAX_DAX=
DEVS) {=0D=0A+=09=09=09if (!(fc->dax_devlist->devlist[i].valid))=0D=0A+=09=
=09=09=09indices_to_fetch[n_to_fetch++] =3D i;=0D=0A+=09=09}=0D=0A+=09}=0D=
=0A+=0D=0A+=09/* Fetch needed daxdevs outside the read lock */=0D=0A+=09f=
or (int j =3D 0; j < n_to_fetch; j++) {=0D=0A+=09=09err =3D famfs_fuse_ge=
t_daxdev(fm, indices_to_fetch[j]);=0D=0A+=09=09if (err)=0D=0A+=09=09=09pr=
_err("%s: failed to get daxdev=3D%d\n",=0D=0A+=09=09=09       __func__, i=
ndices_to_fetch[j]);=0D=0A+=09}=0D=0A+=0D=0A+=09return 0;=0D=0A+}=0D=0A=20=
=0D=0A /*****************************************************************=
**********/=0D=0A=20=0D=0A@@ -184,7 +409,7 @@ famfs_fuse_meta_alloc(=0D=0A=
 =09=09=09/* ie_in =3D one interleaved extent in fmap_buf */=0D=0A =09=09=
=09ie_in =3D fmap_buf + next_offset;=0D=0A=20=0D=0A-=09=09=09/* Move past=
 one interleaved extent header in fmap_buf */=0D=0A+=09=09=09/* Move past=
 1 interleaved extent header in fmap_buf */=0D=0A =09=09=09next_offset +=3D=
 sizeof(*ie_in);=0D=0A =09=09=09if (next_offset > fmap_buf_size) {=0D=0A =
=09=09=09=09pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",=0D=0A=
@@ -329,6 +554,9 @@ famfs_file_init_dax(=0D=0A =09if (rc)=0D=0A =09=09got=
o errout;=0D=0A=20=0D=0A+=09/* Make sure this fmap doesn't reference any =
unknown daxdevs */=0D=0A+=09famfs_update_daxdev_table(fm, meta);=0D=0A+=0D=
=0A =09/* Publish the famfs metadata on fi->famfs_meta */=0D=0A =09inode_=
lock(inode);=0D=0A=20=0D=0Adiff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/f=
amfs_kfmap.h=0D=0Aindex 18ab22bcc5a1..eb9f70b5cb81 100644=0D=0A--- a/fs/f=
use/famfs_kfmap.h=0D=0A+++ b/fs/fuse/famfs_kfmap.h=0D=0A@@ -64,4 +64,30 @=
@ struct famfs_file_meta {=0D=0A =09};=0D=0A };=0D=0A=20=0D=0A+/*=0D=0A+ =
* famfs_daxdev - tracking struct for a daxdev within a famfs file system=0D=
=0A+ *=0D=0A+ * This is the in-memory daxdev metadata that is populated b=
y parsing=0D=0A+ * the responses to GET_FMAP messages=0D=0A+ */=0D=0A+str=
uct famfs_daxdev {=0D=0A+=09/* Include dev uuid=3F */=0D=0A+=09bool valid=
;=0D=0A+=09bool error;=0D=0A+=09dev_t devno;=0D=0A+=09struct dax_device *=
devp;=0D=0A+=09char *name;=0D=0A+};=0D=0A+=0D=0A+#define MAX_DAXDEVS 24=0D=
=0A+=0D=0A+/*=0D=0A+ * famfs_dax_devlist - list of famfs_daxdev's=0D=0A+ =
*/=0D=0A+struct famfs_dax_devlist {=0D=0A+=09int nslots;=0D=0A+=09int nde=
vs;=0D=0A+=09struct famfs_daxdev *devlist;=0D=0A+};=0D=0A+=0D=0A #endif /=
* FAMFS_KFMAP_H */=0D=0Adiff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h=0D=
=0Aindex dbfec5b9c6e1..83e24cee994b 100644=0D=0A--- a/fs/fuse/fuse_i.h=0D=
=0A+++ b/fs/fuse/fuse_i.h=0D=0A@@ -1006,6 +1006,11 @@ struct fuse_conn {=0D=
=0A =09=09/* Request timeout (in jiffies). 0 =3D no timeout */=0D=0A =09=09=
unsigned int req_timeout;=0D=0A =09} timeout;=0D=0A+=0D=0A+#if IS_ENABLED=
(CONFIG_FUSE_FAMFS_DAX)=0D=0A+=09struct rw_semaphore famfs_devlist_sem;=0D=
=0A+=09struct famfs_dax_devlist *dax_devlist;=0D=0A+#endif=0D=0A };=0D=0A=
=20=0D=0A /*=0D=0A@@ -1647,6 +1652,8 @@ int famfs_file_init_dax(struct fu=
se_mount *fm,=0D=0A =09=09=09size_t fmap_size);=0D=0A void __famfs_meta_f=
ree(void *map);=0D=0A=20=0D=0A+void famfs_teardown(struct fuse_conn *fc);=
=0D=0A+=0D=0A /* Set fi->famfs_meta =3D NULL regardless of prior value */=
=0D=0A static inline void famfs_meta_init(struct fuse_inode *fi)=0D=0A {=0D=
=0A@@ -1668,6 +1675,11 @@ static inline void famfs_meta_free(struct fuse_=
inode *fi)=0D=0A =09}=0D=0A }=0D=0A=20=0D=0A+static inline void famfs_ini=
t_devlist_sem(struct fuse_conn *fc)=0D=0A+{=0D=0A+=09init_rwsem(&fc->famf=
s_devlist_sem);=0D=0A+}=0D=0A+=0D=0A static inline int fuse_file_famfs(st=
ruct fuse_inode *fi)=0D=0A {=0D=0A =09return (READ_ONCE(fi->famfs_meta) !=
=3D NULL);=0D=0A@@ -1677,6 +1689,9 @@ int fuse_get_fmap(struct fuse_mount=
 *fm, struct inode *inode);=0D=0A=20=0D=0A #else /* !CONFIG_FUSE_FAMFS_DA=
X */=0D=0A=20=0D=0A+static inline void famfs_teardown(struct fuse_conn *f=
c)=0D=0A+{=0D=0A+}=0D=0A static inline struct fuse_backing *famfs_meta_se=
t(struct fuse_inode *fi,=0D=0A =09=09=09=09=09=09  void *meta)=0D=0A {=0D=
=0A@@ -1687,6 +1702,10 @@ static inline void famfs_meta_free(struct fuse_=
inode *fi)=0D=0A {=0D=0A }=0D=0A=20=0D=0A+static inline void famfs_init_d=
evlist_sem(struct fuse_conn *fc)=0D=0A+{=0D=0A+}=0D=0A+=0D=0A static inli=
ne int fuse_file_famfs(struct fuse_inode *fi)=0D=0A {=0D=0A =09return 0;=0D=
=0Adiff --git a/fs/fuse/inode.c b/fs/fuse/inode.c=0D=0Aindex b9933d0fbb9f=
=2E.c5c7f2aeda3f 100644=0D=0A--- a/fs/fuse/inode.c=0D=0A+++ b/fs/fuse/ino=
de.c=0D=0A@@ -1047,6 +1047,9 @@ void fuse_conn_put(struct fuse_conn *fc)=0D=
=0A =09=09WARN_ON(atomic_read(&bucket->count) !=3D 1);=0D=0A =09=09kfree(=
bucket);=0D=0A =09}=0D=0A+=09if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))=0D=0A=
+=09=09famfs_teardown(fc);=0D=0A+=0D=0A =09if (IS_ENABLED(CONFIG_FUSE_PAS=
STHROUGH))=0D=0A =09=09fuse_backing_files_free(fc);=0D=0A =09call_rcu(&fc=
->rcu, delayed_release);=0D=0A@@ -1476,8 +1479,10 @@ static void process_=
init_reply(struct fuse_mount *fm, struct fuse_args *args,=0D=0A =09=09=09=
=09u64 in_flags =3D ((u64)ia->in.flags2 << 32)=0D=0A =09=09=09=09=09=09| =
ia->in.flags;=0D=0A=20=0D=0A-=09=09=09=09if (in_flags & FUSE_DAX_FMAP)=0D=
=0A+=09=09=09=09if (in_flags & FUSE_DAX_FMAP) {=0D=0A+=09=09=09=09=09famf=
s_init_devlist_sem(fc);=0D=0A =09=09=09=09=09fc->famfs_iomap =3D 1;=0D=0A=
+=09=09=09=09}=0D=0A =09=09=09}=0D=0A =09=09} else {=0D=0A =09=09=09ra_pa=
ges =3D fc->max_read / PAGE_SIZE;=0D=0Adiff --git a/fs/namei.c b/fs/namei=
=2Ec=0D=0Aindex cf16b6822dd3..99ac58975394 100644=0D=0A--- a/fs/namei.c=0D=
=0A+++ b/fs/namei.c=0D=0A@@ -4171,6 +4171,7 @@ bool may_open_dev(const st=
ruct path *path)=0D=0A =09return !(path->mnt->mnt_flags & MNT_NODEV) &&=0D=
=0A =09=09!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);=0D=0A }=0D=0A+EXPO=
RT_SYMBOL(may_open_dev);=0D=0A=20=0D=0A static int may_open(struct mnt_id=
map *idmap, const struct path *path,=0D=0A =09=09    int acc_mode, int fl=
ag)=0D=0Adiff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse=
=2Eh=0D=0Aindex cf678bebbfe0..1b82895108be 100644=0D=0A--- a/include/uapi=
/linux/fuse.h=0D=0A+++ b/include/uapi/linux/fuse.h=0D=0A@@ -247,6 +247,9 =
@@=0D=0A  *    - struct fuse_famfs_simple_ext=0D=0A  *    - struct fuse_f=
amfs_iext=0D=0A  *    - struct fuse_famfs_fmap_header=0D=0A+ *  - Add the=
 following structs for the GET_DAXDEV message and reply=0D=0A+ *    - str=
uct fuse_get_daxdev_in=0D=0A+ *    - struct fuse_get_daxdev_out=0D=0A  * =
 - Add the following enumerated types=0D=0A  *    - enum fuse_famfs_file_=
type=0D=0A  *    - enum famfs_ext_type=0D=0A@@ -678,6 +681,7 @@ enum fuse=
_opcode {=0D=0A=20=0D=0A =09/* Famfs / devdax opcodes */=0D=0A =09FUSE_GE=
T_FMAP           =3D 54,=0D=0A+=09FUSE_GET_DAXDEV         =3D 55,=0D=0A=20=
=0D=0A =09/* CUSE specific operations */=0D=0A =09CUSE_INIT=09=09=3D 4096=
,=0D=0A@@ -1369,6 +1373,22 @@ struct fuse_famfs_fmap_header {=0D=0A =09ui=
nt64_t reserved1;=0D=0A };=0D=0A=20=0D=0A+struct fuse_get_daxdev_in {=0D=0A=
+=09uint32_t        daxdev_num;=0D=0A+};=0D=0A+=0D=0A+#define DAXDEV_NAME=
_MAX 256=0D=0A+=0D=0A+/* fuse_daxdev_out has enough space for a uuid if w=
e need it */=0D=0A+struct fuse_daxdev_out {=0D=0A+=09uint16_t index;=0D=0A=
+=09uint16_t reserved;=0D=0A+=09uint32_t reserved2;=0D=0A+=09uint64_t res=
erved3;=0D=0A+=09uint64_t reserved4;=0D=0A+=09char name[DAXDEV_NAME_MAX];=
=0D=0A+};=0D=0A+=0D=0A static inline int32_t fmap_msg_min_size(void)=0D=0A=
 {=0D=0A =09/* Smallest fmap message is a header plus one simple extent *=
/=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

