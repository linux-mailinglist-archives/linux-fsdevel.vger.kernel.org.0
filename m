Return-Path: <linux-fsdevel+bounces-74337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 32835D39AA5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41C13003197
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51430FC3D;
	Sun, 18 Jan 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="s7as2lNa";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EzfLOQcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-6.smtp-out.amazonses.com (a11-6.smtp-out.amazonses.com [54.240.11.6])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D741C30F92D;
	Sun, 18 Jan 2026 22:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775597; cv=none; b=JKWri+Cp0RFTmD/g1glQWA0Xy33sa+NVfNKXKacTXgoIPC0CTceI9SYlnfb0lFind19VlcN/lPpYwTMQxrW+7zX8OHlbhT/f+P2yudWtq3qlbv9YerIO3fIsO2G/TFPKL/8JHTIELF1o0zDczkWKmL8X0ET1igofnPABgkkNA38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775597; c=relaxed/simple;
	bh=RT7pL9+CY2K53VkgqSojJnPclIqvQelaJw1PNh2ZCvk=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=lkKb4eVn6I33ihVvo16QmVUJ7NgY2hsa/Q5++xKif2+qQcXqAPxdXT9+DO4Q+ZXTkbGgiZj1ebwO5jiEcSRQTes5RIzzDLOHj79tFM/vXOCQ+uEekWNh8Az/aC2yp63/NeCVL7fbAAxwRvJ0a6j5T7y3pJOPc0ksQjAce575vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=s7as2lNa; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EzfLOQcI; arc=none smtp.client-ip=54.240.11.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775593;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=RT7pL9+CY2K53VkgqSojJnPclIqvQelaJw1PNh2ZCvk=;
	b=s7as2lNavCfBAsYzqnPEQOiEWCjb8fjY+MToeWFStd1xEPNDRhinQKtEljpWWi9d
	QsFOkArTbI4PJFmYK87No+5VAVcTV0aRJVWsBILuZIlOcRHQAZ41vcnZ476nYhkhmB8
	XW2U7qZHXwueAJqUw2hUVGli8uQuWv2ntdPPn7gU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775593;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=RT7pL9+CY2K53VkgqSojJnPclIqvQelaJw1PNh2ZCvk=;
	b=EzfLOQcI2+1Byzoy3XGzvLjHztdN+Qr0xPvobzfTsxhF0X2OA6fKC4M9l5cXJ45l
	DRp46wh9AeR1PiqUfqFhXXIaMKblK1HNwiT0hXvrYu55cVx59nu/KOEgfTyrNznHj2E
	TWfHj5xVm91gDdzOO/Y01hkch/eC5CNqDwk0D4jU=
Subject: [PATCH V7 13/19] famfs_fuse: Create files with famfs fmaps
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
Date: Sun, 18 Jan 2026 22:33:13 +0000
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
 <20260118223307.92562-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAjKiU=
Thread-Topic: [PATCH V7 13/19] famfs_fuse: Create files with famfs fmaps
X-Wm-Sent-Timestamp: 1768775592
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33daee6-f6b270fd-c943-4643-8d21-5621fdef3572-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.6

From: John Groves <john@groves.net>=0D=0A=0D=0AOn completion of GET_FMAP =
message/response, setup the full famfs=0D=0Ametadata such that it's possi=
ble to handle read/write/mmap directly to=0D=0Adax. Note that the devdax_=
iomap plumbing is not in yet...=0D=0A=0D=0A* Add famfs_kfmap.h: in-memory=
 structures for resolving famfs file maps=0D=0A  (fmaps) to dax.=0D=0A* f=
amfs.c: allocate, initialize and free fmaps=0D=0A* inode.c: only allow fa=
mfs mode if the fuse server has CAP_SYS_RAWIO=0D=0A* Update MAINTAINERS f=
or the new file.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=
=0A---=0D=0A MAINTAINERS               |   1 +=0D=0A fs/fuse/famfs.c     =
      | 339 +++++++++++++++++++++++++++++++++++++-=0D=0A fs/fuse/famfs_kf=
map.h     |  67 ++++++++=0D=0A fs/fuse/fuse_i.h          |   8 +-=0D=0A f=
s/fuse/inode.c           |  19 ++-=0D=0A include/uapi/linux/fuse.h |  56 =
+++++++=0D=0A 6 files changed, 480 insertions(+), 10 deletions(-)=0D=0A c=
reate mode 100644 fs/fuse/famfs_kfmap.h=0D=0A=0D=0Adiff --git a/MAINTAINE=
RS b/MAINTAINERS=0D=0Aindex e3d0aa5eb361..6f8a7c813c2f 100644=0D=0A--- a/=
MAINTAINERS=0D=0A+++ b/MAINTAINERS=0D=0A@@ -10386,6 +10386,7 @@ L:=09linu=
x-cxl@vger.kernel.org=0D=0A L:=09linux-fsdevel@vger.kernel.org=0D=0A S:=09=
Supported=0D=0A F:=09fs/fuse/famfs.c=0D=0A+F:=09fs/fuse/famfs_kfmap.h=0D=0A=
=20=0D=0A FUTEX SUBSYSTEM=0D=0A M:=09Thomas Gleixner <tglx@kernel.org>=0D=
=0Adiff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c=0D=0Aindex 615819cc922d=
=2E.a9728e11f1dd 100644=0D=0A--- a/fs/fuse/famfs.c=0D=0A+++ b/fs/fuse/fam=
fs.c=0D=0A@@ -18,9 +18,339 @@=0D=0A #include <linux/namei.h>=0D=0A #inclu=
de <linux/string.h>=0D=0A=20=0D=0A+#include "famfs_kfmap.h"=0D=0A #includ=
e "fuse_i.h"=0D=0A=20=0D=0A=20=0D=0A+/***********************************=
****************************************/=0D=0A+=0D=0A+void __famfs_meta_=
free(void *famfs_meta)=0D=0A+{=0D=0A+=09struct famfs_file_meta *fmap =3D =
famfs_meta;=0D=0A+=0D=0A+=09if (!fmap)=0D=0A+=09=09return;=0D=0A+=0D=0A+=09=
switch (fmap->fm_extent_type) {=0D=0A+=09case SIMPLE_DAX_EXTENT:=0D=0A+=09=
=09kfree(fmap->se);=0D=0A+=09=09break;=0D=0A+=09case INTERLEAVED_EXTENT:=0D=
=0A+=09=09if (fmap->ie) {=0D=0A+=09=09=09for (int i =3D 0; i < fmap->fm_n=
iext; i++)=0D=0A+=09=09=09=09kfree(fmap->ie[i].ie_strips);=0D=0A+=09=09}=0D=
=0A+=09=09kfree(fmap->ie);=0D=0A+=09=09break;=0D=0A+=09default:=0D=0A+=09=
=09pr_err("%s: invalid fmap type\n", __func__);=0D=0A+=09=09break;=0D=0A+=
=09}=0D=0A+=0D=0A+=09kfree(fmap);=0D=0A+}=0D=0A+DEFINE_FREE(__famfs_meta_=
free, void *, if (_T) __famfs_meta_free(_T))=0D=0A+=0D=0A+static int=0D=0A=
+famfs_check_ext_alignment(struct famfs_meta_simple_ext *se)=0D=0A+{=0D=0A=
+=09int errs =3D 0;=0D=0A+=0D=0A+=09if (se->dev_index !=3D 0)=0D=0A+=09=09=
errs++;=0D=0A+=0D=0A+=09/* TODO: pass in alignment so we can support the =
other page sizes */=0D=0A+=09if (!IS_ALIGNED(se->ext_offset, PMD_SIZE))=0D=
=0A+=09=09errs++;=0D=0A+=0D=0A+=09if (!IS_ALIGNED(se->ext_len, PMD_SIZE))=
=0D=0A+=09=09errs++;=0D=0A+=0D=0A+=09return errs;=0D=0A+}=0D=0A+=0D=0A+/*=
*=0D=0A+ * famfs_fuse_meta_alloc() - Allocate famfs file metadata=0D=0A+ =
* @fmap_buf:  fmap buffer from fuse server=0D=0A+ * @fmap_buf_size: size =
of fmap buffer=0D=0A+ * @metap:         pointer where 'struct famfs_file_=
meta' is returned=0D=0A+ *=0D=0A+ * Returns: 0=3Dsuccess=0D=0A+ *        =
  -errno=3Dfailure=0D=0A+ */=0D=0A+static int=0D=0A+famfs_fuse_meta_alloc=
(=0D=0A+=09void *fmap_buf,=0D=0A+=09size_t fmap_buf_size,=0D=0A+=09struct=
 famfs_file_meta **metap)=0D=0A+{=0D=0A+=09struct famfs_file_meta *meta _=
_free(__famfs_meta_free) =3D NULL;=0D=0A+=09struct fuse_famfs_fmap_header=
 *fmh;=0D=0A+=09size_t extent_total =3D 0;=0D=0A+=09size_t next_offset =3D=
 0;=0D=0A+=09int errs =3D 0;=0D=0A+=09int i, j;=0D=0A+=0D=0A+=09fmh =3D f=
map_buf;=0D=0A+=0D=0A+=09/* Move past fmh in fmap_buf */=0D=0A+=09next_of=
fset +=3D sizeof(*fmh);=0D=0A+=09if (next_offset > fmap_buf_size) {=0D=0A=
+=09=09pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",=0D=0A+=09=
=09       __func__, __LINE__, next_offset, fmap_buf_size);=0D=0A+=09=09re=
turn -EINVAL;=0D=0A+=09}=0D=0A+=0D=0A+=09if (fmh->nextents < 1) {=0D=0A+=09=
=09pr_err("%s: nextents %d < 1\n", __func__, fmh->nextents);=0D=0A+=09=09=
return -EINVAL;=0D=0A+=09}=0D=0A+=0D=0A+=09if (fmh->nextents > FUSE_FAMFS=
_MAX_EXTENTS) {=0D=0A+=09=09pr_err("%s: nextents %d > max (%d) 1\n",=0D=0A=
+=09=09       __func__, fmh->nextents, FUSE_FAMFS_MAX_EXTENTS);=0D=0A+=09=
=09return -E2BIG;=0D=0A+=09}=0D=0A+=0D=0A+=09meta =3D kzalloc(sizeof(*met=
a), GFP_KERNEL);=0D=0A+=09if (!meta)=0D=0A+=09=09return -ENOMEM;=0D=0A+=0D=
=0A+=09meta->error =3D false;=0D=0A+=09meta->file_type =3D fmh->file_type=
;=0D=0A+=09meta->file_size =3D fmh->file_size;=0D=0A+=09meta->fm_extent_t=
ype =3D fmh->ext_type;=0D=0A+=0D=0A+=09switch (fmh->ext_type) {=0D=0A+=09=
case FUSE_FAMFS_EXT_SIMPLE: {=0D=0A+=09=09struct fuse_famfs_simple_ext *s=
e_in;=0D=0A+=0D=0A+=09=09se_in =3D fmap_buf + next_offset;=0D=0A+=0D=0A+=09=
=09/* Move past simple extents */=0D=0A+=09=09next_offset +=3D fmh->nexte=
nts * sizeof(*se_in);=0D=0A+=09=09if (next_offset > fmap_buf_size) {=0D=0A=
+=09=09=09pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",=0D=0A=
+=09=09=09       __func__, __LINE__, next_offset, fmap_buf_size);=0D=0A+=09=
=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A+=0D=0A+=09=09meta->fm_nextents =
=3D fmh->nextents;=0D=0A+=0D=0A+=09=09meta->se =3D kcalloc(meta->fm_nexte=
nts, sizeof(*(meta->se)),=0D=0A+=09=09=09=09   GFP_KERNEL);=0D=0A+=09=09i=
f (!meta->se)=0D=0A+=09=09=09return -ENOMEM;=0D=0A+=0D=0A+=09=09if ((meta=
->fm_nextents > FUSE_FAMFS_MAX_EXTENTS) ||=0D=0A+=09=09    (meta->fm_next=
ents < 1))=0D=0A+=09=09=09return -EINVAL;=0D=0A+=0D=0A+=09=09for (i =3D 0=
; i < fmh->nextents; i++) {=0D=0A+=09=09=09meta->se[i].dev_index  =3D se_=
in[i].se_devindex;=0D=0A+=09=09=09meta->se[i].ext_offset =3D se_in[i].se_=
offset;=0D=0A+=09=09=09meta->se[i].ext_len    =3D se_in[i].se_len;=0D=0A+=
=0D=0A+=09=09=09/* Record bitmap of referenced daxdev indices */=0D=0A+=09=
=09=09meta->dev_bitmap |=3D (1 << meta->se[i].dev_index);=0D=0A+=0D=0A+=09=
=09=09errs +=3D famfs_check_ext_alignment(&meta->se[i]);=0D=0A+=0D=0A+=09=
=09=09extent_total +=3D meta->se[i].ext_len;=0D=0A+=09=09}=0D=0A+=09=09br=
eak;=0D=0A+=09}=0D=0A+=0D=0A+=09case FUSE_FAMFS_EXT_INTERLEAVE: {=0D=0A+=09=
=09s64 size_remainder =3D meta->file_size;=0D=0A+=09=09struct fuse_famfs_=
iext *ie_in;=0D=0A+=09=09int niext =3D fmh->nextents;=0D=0A+=0D=0A+=09=09=
meta->fm_niext =3D niext;=0D=0A+=0D=0A+=09=09/* Allocate interleaved exte=
nt */=0D=0A+=09=09meta->ie =3D kcalloc(niext, sizeof(*(meta->ie)), GFP_KE=
RNEL);=0D=0A+=09=09if (!meta->ie)=0D=0A+=09=09=09return -ENOMEM;=0D=0A+=0D=
=0A+=09=09/*=0D=0A+=09=09 * Each interleaved extent has a simple extent l=
ist of strips.=0D=0A+=09=09 * Outer loop is over separate interleaved ext=
ents=0D=0A+=09=09 */=0D=0A+=09=09for (i =3D 0; i < niext; i++) {=0D=0A+=09=
=09=09u64 nstrips;=0D=0A+=09=09=09struct fuse_famfs_simple_ext *sie_in;=0D=
=0A+=0D=0A+=09=09=09/* ie_in =3D one interleaved extent in fmap_buf */=0D=
=0A+=09=09=09ie_in =3D fmap_buf + next_offset;=0D=0A+=0D=0A+=09=09=09/* M=
ove past one interleaved extent header in fmap_buf */=0D=0A+=09=09=09next=
_offset +=3D sizeof(*ie_in);=0D=0A+=09=09=09if (next_offset > fmap_buf_si=
ze) {=0D=0A+=09=09=09=09pr_err("%s:%d: fmap_buf underflow offset/size %ld=
/%ld\n",=0D=0A+=09=09=09=09       __func__, __LINE__, next_offset,=0D=0A+=
=09=09=09=09       fmap_buf_size);=0D=0A+=09=09=09=09return -EINVAL;=0D=0A=
+=09=09=09}=0D=0A+=0D=0A+=09=09=09if (!IS_ALIGNED(ie_in->ie_chunk_size, P=
MD_SIZE)) {=0D=0A+=09=09=09=09pr_err("%s: chunk_size %lld not PMD-aligned=
\n",=0D=0A+=09=09=09=09       __func__, meta->ie[i].fie_chunk_size);=0D=0A=
+=09=09=09=09return -EINVAL;=0D=0A+=09=09=09}=0D=0A+=0D=0A+=09=09=09if (i=
e_in->ie_nbytes =3D=3D 0) {=0D=0A+=09=09=09=09pr_err("%s: zero-length int=
erleave!\n",=0D=0A+=09=09=09=09       __func__);=0D=0A+=09=09=09=09return=
 -EINVAL;=0D=0A+=09=09=09}=0D=0A+=0D=0A+=09=09=09nstrips =3D ie_in->ie_ns=
trips;=0D=0A+=09=09=09meta->ie[i].fie_chunk_size =3D ie_in->ie_chunk_size=
;=0D=0A+=09=09=09meta->ie[i].fie_nstrips    =3D ie_in->ie_nstrips;=0D=0A+=
=09=09=09meta->ie[i].fie_nbytes     =3D ie_in->ie_nbytes;=0D=0A+=0D=0A+=09=
=09=09/* sie_in =3D the strip extents in fmap_buf */=0D=0A+=09=09=09sie_i=
n =3D fmap_buf + next_offset;=0D=0A+=0D=0A+=09=09=09/* Move past strip ex=
tents in fmap_buf */=0D=0A+=09=09=09next_offset +=3D nstrips * sizeof(*si=
e_in);=0D=0A+=09=09=09if (next_offset > fmap_buf_size) {=0D=0A+=09=09=09=09=
pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",=0D=0A+=09=09=09=
=09       __func__, __LINE__, next_offset,=0D=0A+=09=09=09=09       fmap_=
buf_size);=0D=0A+=09=09=09=09return -EINVAL;=0D=0A+=09=09=09}=0D=0A+=0D=0A=
+=09=09=09if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips < 1)) {=0D=0A=
+=09=09=09=09pr_err("%s: invalid nstrips=3D%lld (max=3D%d)\n",=0D=0A+=09=09=
=09=09       __func__, nstrips,=0D=0A+=09=09=09=09       FUSE_FAMFS_MAX_S=
TRIPS);=0D=0A+=09=09=09=09errs++;=0D=0A+=09=09=09}=0D=0A+=0D=0A+=09=09=09=
/* Allocate strip extent array */=0D=0A+=09=09=09meta->ie[i].ie_strips =3D=
=0D=0A+=09=09=09=09kcalloc(ie_in->ie_nstrips,=0D=0A+=09=09=09=09=09sizeof=
(meta->ie[i].ie_strips[0]),=0D=0A+=09=09=09=09=09GFP_KERNEL);=0D=0A+=09=09=
=09if (!meta->ie[i].ie_strips)=0D=0A+=09=09=09=09return -ENOMEM;=0D=0A+=0D=
=0A+=09=09=09/* Inner loop is over strips */=0D=0A+=09=09=09for (j =3D 0;=
 j < nstrips; j++) {=0D=0A+=09=09=09=09struct famfs_meta_simple_ext *stri=
ps_out;=0D=0A+=09=09=09=09u64 devindex =3D sie_in[j].se_devindex;=0D=0A+=09=
=09=09=09u64 offset   =3D sie_in[j].se_offset;=0D=0A+=09=09=09=09u64 len =
     =3D sie_in[j].se_len;=0D=0A+=0D=0A+=09=09=09=09strips_out =3D meta->=
ie[i].ie_strips;=0D=0A+=09=09=09=09strips_out[j].dev_index  =3D devindex;=
=0D=0A+=09=09=09=09strips_out[j].ext_offset =3D offset;=0D=0A+=09=09=09=09=
strips_out[j].ext_len    =3D len;=0D=0A+=0D=0A+=09=09=09=09/* Record bitm=
ap of referenced daxdev indices */=0D=0A+=09=09=09=09meta->dev_bitmap |=3D=
 (1 << devindex);=0D=0A+=0D=0A+=09=09=09=09extent_total +=3D len;=0D=0A+=09=
=09=09=09errs +=3D famfs_check_ext_alignment(&strips_out[j]);=0D=0A+=09=09=
=09=09size_remainder -=3D len;=0D=0A+=09=09=09}=0D=0A+=09=09}=0D=0A+=0D=0A=
+=09=09if (size_remainder > 0) {=0D=0A+=09=09=09/* Sum of interleaved ext=
ent sizes is less than file size! */=0D=0A+=09=09=09pr_err("%s: size_rema=
inder %lld (0x%llx)\n",=0D=0A+=09=09=09       __func__, size_remainder, s=
ize_remainder);=0D=0A+=09=09=09return -EINVAL;=0D=0A+=09=09}=0D=0A+=09=09=
break;=0D=0A+=09}=0D=0A+=0D=0A+=09default:=0D=0A+=09=09pr_err("%s: invali=
d ext_type %d\n", __func__, fmh->ext_type);=0D=0A+=09=09return -EINVAL;=0D=
=0A+=09}=0D=0A+=0D=0A+=09if (errs > 0) {=0D=0A+=09=09pr_err("%s: %d align=
ment errors found\n", __func__, errs);=0D=0A+=09=09return -EINVAL;=0D=0A+=
=09}=0D=0A+=0D=0A+=09/* More sanity checks */=0D=0A+=09if (extent_total <=
 meta->file_size) {=0D=0A+=09=09pr_err("%s: file size %ld larger than map=
 size %ld\n",=0D=0A+=09=09       __func__, meta->file_size, extent_total)=
;=0D=0A+=09=09return -EINVAL;=0D=0A+=09}=0D=0A+=0D=0A+=09if (cmpxchg(meta=
p, NULL, meta) !=3D NULL) {=0D=0A+=09=09pr_debug("%s: fmap race detected\=
n", __func__);=0D=0A+=09=09return 0; /* fmap already installed */=0D=0A+=09=
}=0D=0A+=09meta =3D NULL; /* disarm __free() - the meta struct was consum=
ed */=0D=0A+=0D=0A+=09return 0;=0D=0A+}=0D=0A+=0D=0A+/**=0D=0A+ * famfs_f=
ile_init_dax() - init famfs dax file metadata=0D=0A+ *=0D=0A+ * @fm:     =
   fuse_mount=0D=0A+ * @inode:     the inode=0D=0A+ * @fmap_buf:  fmap re=
sponse message=0D=0A+ * @fmap_size: Size of the fmap message=0D=0A+ *=0D=0A=
+ * Initialize famfs metadata for a file, based on the contents of the GE=
T_FMAP=0D=0A+ * response=0D=0A+ *=0D=0A+ * Return: 0=3Dsuccess=0D=0A+ *  =
        -errno=3Dfailure=0D=0A+ */=0D=0A+int=0D=0A+famfs_file_init_dax(=0D=
=0A+=09struct fuse_mount *fm,=0D=0A+=09struct inode *inode,=0D=0A+=09void=
 *fmap_buf,=0D=0A+=09size_t fmap_size)=0D=0A+{=0D=0A+=09struct fuse_inode=
 *fi =3D get_fuse_inode(inode);=0D=0A+=09struct famfs_file_meta *meta =3D=
 NULL;=0D=0A+=09int rc;=0D=0A+=0D=0A+=09if (fi->famfs_meta) {=0D=0A+=09=09=
pr_notice("%s: i_no=3D%ld fmap_size=3D%ld ALREADY INITIALIZED\n",=0D=0A+=09=
=09=09  __func__,=0D=0A+=09=09=09  inode->i_ino, fmap_size);=0D=0A+=09=09=
return 0;=0D=0A+=09}=0D=0A+=0D=0A+=09rc =3D famfs_fuse_meta_alloc(fmap_bu=
f, fmap_size, &meta);=0D=0A+=09if (rc)=0D=0A+=09=09goto errout;=0D=0A+=0D=
=0A+=09/* Publish the famfs metadata on fi->famfs_meta */=0D=0A+=09inode_=
lock(inode);=0D=0A+=0D=0A+=09if (famfs_meta_set(fi, meta) =3D=3D NULL) {=0D=
=0A+=09=09i_size_write(inode, meta->file_size);=0D=0A+=09=09inode->i_flag=
s |=3D S_DAX;=0D=0A+=09} else {=0D=0A+=09=09pr_debug("%s: file already ha=
d metadata\n", __func__);=0D=0A+=09=09__famfs_meta_free(meta);=0D=0A+=09=09=
/* rc is 0 - the file is valid */=0D=0A+=09}=0D=0A+=0D=0A+=09inode_unlock=
(inode);=0D=0A+=09return 0;=0D=0A+=0D=0A+errout:=0D=0A+=09if (rc)=0D=0A+=09=
=09__famfs_meta_free(meta);=0D=0A+=0D=0A+=09return rc;=0D=0A+}=0D=0A+=0D=0A=
 #define FMAP_BUFSIZE PAGE_SIZE=0D=0A=20=0D=0A int=0D=0A@@ -64,11 +394,8 =
@@ fuse_get_fmap(struct fuse_mount *fm, struct inode *inode)=0D=0A =09}=0D=
=0A =09fmap_size =3D rc;=0D=0A=20=0D=0A-=09/* We retrieved the "fmap" (th=
e file's map to memory), but=0D=0A-=09 * we haven't used it yet. A call t=
o famfs_file_init_dax() will be added=0D=0A-=09 * here in a subsequent pa=
tch, when we add the ability to attach=0D=0A-=09 * fmaps to files.=0D=0A-=
=09 */=0D=0A+=09/* Convert fmap into in-memory format and hang from inode=
 */=0D=0A+=09rc =3D famfs_file_init_dax(fm, inode, fmap_buf, fmap_size);=0D=
=0A=20=0D=0A-=09return 0;=0D=0A+=09return rc;=0D=0A }=0D=0Adiff --git a/f=
s/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h=0D=0Anew file mode 100644=0D=
=0Aindex 000000000000..18ab22bcc5a1=0D=0A--- /dev/null=0D=0A+++ b/fs/fuse=
/famfs_kfmap.h=0D=0A@@ -0,0 +1,67 @@=0D=0A+/* SPDX-License-Identifier: GP=
L-2.0 */=0D=0A+/*=0D=0A+ * famfs - dax file system for shared fabric-atta=
ched memory=0D=0A+ *=0D=0A+ * Copyright 2023-2026 Micron Technology, Inc.=
=0D=0A+ */=0D=0A+#ifndef FAMFS_KFMAP_H=0D=0A+#define FAMFS_KFMAP_H=0D=0A+=
=0D=0A+/*=0D=0A+ * The structures below are the in-memory metadata format=
 for famfs files.=0D=0A+ * Metadata retrieved via the GET_FMAP response i=
s converted to this format=0D=0A+ * for use in resolving file mapping fau=
lts.=0D=0A+ *=0D=0A+ * The GET_FMAP response contains the same informatio=
n, but in a more=0D=0A+ * message-and-versioning-friendly format. Those s=
tructs can be found in the=0D=0A+ * famfs section of include/uapi/linux/f=
use.h (aka fuse_kernel.h in libfuse)=0D=0A+ */=0D=0A+=0D=0A+enum famfs_fi=
le_type {=0D=0A+=09FAMFS_REG,=0D=0A+=09FAMFS_SUPERBLOCK,=0D=0A+=09FAMFS_L=
OG,=0D=0A+};=0D=0A+=0D=0A+/* We anticipate the possibility of supporting =
additional types of extents */=0D=0A+enum famfs_extent_type {=0D=0A+=09SI=
MPLE_DAX_EXTENT,=0D=0A+=09INTERLEAVED_EXTENT,=0D=0A+=09INVALID_EXTENT_TYP=
E,=0D=0A+};=0D=0A+=0D=0A+struct famfs_meta_simple_ext {=0D=0A+=09u64 dev_=
index;=0D=0A+=09u64 ext_offset;=0D=0A+=09u64 ext_len;=0D=0A+};=0D=0A+=0D=0A=
+struct famfs_meta_interleaved_ext {=0D=0A+=09u64 fie_nstrips;=0D=0A+=09u=
64 fie_chunk_size;=0D=0A+=09u64 fie_nbytes;=0D=0A+=09struct famfs_meta_si=
mple_ext *ie_strips;=0D=0A+};=0D=0A+=0D=0A+/*=0D=0A+ * Each famfs dax fil=
e has this hanging from its fuse_inode->famfs_meta=0D=0A+ */=0D=0A+struct=
 famfs_file_meta {=0D=0A+=09bool                   error;=0D=0A+=09enum f=
amfs_file_type   file_type;=0D=0A+=09size_t                 file_size;=0D=
=0A+=09enum famfs_extent_type fm_extent_type;=0D=0A+=09u64 dev_bitmap; /*=
 bitmap of referenced daxdevs by index */=0D=0A+=09union {=0D=0A+=09=09st=
ruct {=0D=0A+=09=09=09size_t         fm_nextents;=0D=0A+=09=09=09struct f=
amfs_meta_simple_ext  *se;=0D=0A+=09=09};=0D=0A+=09=09struct {=0D=0A+=09=09=
=09size_t         fm_niext;=0D=0A+=09=09=09struct famfs_meta_interleaved_=
ext *ie;=0D=0A+=09=09};=0D=0A+=09};=0D=0A+};=0D=0A+=0D=0A+#endif /* FAMFS=
_KFMAP_H */=0D=0Adiff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h=0D=0Ain=
dex b66b5ca0bc11..dbfec5b9c6e1 100644=0D=0A--- a/fs/fuse/fuse_i.h=0D=0A++=
+ b/fs/fuse/fuse_i.h=0D=0A@@ -1642,6 +1642,9 @@ extern void fuse_sysctl_u=
nregister(void);=0D=0A /* famfs.c */=0D=0A=20=0D=0A #if IS_ENABLED(CONFIG=
_FUSE_FAMFS_DAX)=0D=0A+int famfs_file_init_dax(struct fuse_mount *fm,=0D=0A=
+=09=09=09struct inode *inode, void *fmap_buf,=0D=0A+=09=09=09size_t fmap=
_size);=0D=0A void __famfs_meta_free(void *map);=0D=0A=20=0D=0A /* Set fi=
->famfs_meta =3D NULL regardless of prior value */=0D=0A@@ -1659,7 +1662,=
10 @@ static inline struct fuse_backing *famfs_meta_set(struct fuse_inode=
 *fi,=0D=0A=20=0D=0A static inline void famfs_meta_free(struct fuse_inode=
 *fi)=0D=0A {=0D=0A-=09famfs_meta_set(fi, NULL);=0D=0A+=09if (fi->famfs_m=
eta !=3D NULL) {=0D=0A+=09=09__famfs_meta_free(fi->famfs_meta);=0D=0A+=09=
=09famfs_meta_set(fi, NULL);=0D=0A+=09}=0D=0A }=0D=0A=20=0D=0A static inl=
ine int fuse_file_famfs(struct fuse_inode *fi)=0D=0Adiff --git a/fs/fuse/=
inode.c b/fs/fuse/inode.c=0D=0Aindex f2d742d723dc..b9933d0fbb9f 100644=0D=
=0A--- a/fs/fuse/inode.c=0D=0A+++ b/fs/fuse/inode.c=0D=0A@@ -1464,8 +1464=
,21 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_=
args *args,=0D=0A =09=09=09=09timeout =3D arg->request_timeout;=0D=0A=20=0D=
=0A =09=09=09if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&=0D=0A-=09=09=09    =
flags & FUSE_DAX_FMAP)=0D=0A-=09=09=09=09fc->famfs_iomap =3D 1;=0D=0A+=09=
=09=09    flags & FUSE_DAX_FMAP) {=0D=0A+=09=09=09=09/* famfs_iomap is on=
ly allowed if the fuse=0D=0A+=09=09=09=09 * server has CAP_SYS_RAWIO. Thi=
s was checked=0D=0A+=09=09=09=09 * in fuse_send_init, and FUSE_DAX_IOMAP =
was=0D=0A+=09=09=09=09 * set in in_flags if so. Only allow enablement=0D=0A=
+=09=09=09=09 * if we find it there. This function is=0D=0A+=09=09=09=09 =
* normally not running in fuse server context,=0D=0A+=09=09=09=09 * so we=
 can't do the capability check here...=0D=0A+=09=09=09=09 */=0D=0A+=09=09=
=09=09u64 in_flags =3D ((u64)ia->in.flags2 << 32)=0D=0A+=09=09=09=09=09=09=
| ia->in.flags;=0D=0A+=0D=0A+=09=09=09=09if (in_flags & FUSE_DAX_FMAP)=0D=
=0A+=09=09=09=09=09fc->famfs_iomap =3D 1;=0D=0A+=09=09=09}=0D=0A =09=09} =
else {=0D=0A =09=09=09ra_pages =3D fc->max_read / PAGE_SIZE;=0D=0A =09=09=
=09fc->no_lock =3D 1;=0D=0A@@ -1527,7 +1540,7 @@ static struct fuse_init_=
args *fuse_new_init(struct fuse_mount *fm)=0D=0A =09=09flags |=3D FUSE_SU=
BMOUNTS;=0D=0A =09if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))=0D=0A =09=09fl=
ags |=3D FUSE_PASSTHROUGH;=0D=0A-=09if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)=
)=0D=0A+=09if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) && capable(CAP_SYS_RAWIO=
))=0D=0A =09=09flags |=3D FUSE_DAX_FMAP;=0D=0A=20=0D=0A =09/*=0D=0Adiff -=
-git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h=0D=0Aindex 9=
eff9083d3b5..cf678bebbfe0 100644=0D=0A--- a/include/uapi/linux/fuse.h=0D=0A=
+++ b/include/uapi/linux/fuse.h=0D=0A@@ -243,6 +243,13 @@=0D=0A  *=0D=0A =
 *  7.46=0D=0A  *  - Add FUSE_DAX_FMAP capability - ability to handle in-=
kernel fsdax maps=0D=0A+ *  - Add the following structures for the GET_FM=
AP message reply components:=0D=0A+ *    - struct fuse_famfs_simple_ext=0D=
=0A+ *    - struct fuse_famfs_iext=0D=0A+ *    - struct fuse_famfs_fmap_h=
eader=0D=0A+ *  - Add the following enumerated types=0D=0A+ *    - enum f=
use_famfs_file_type=0D=0A+ *    - enum famfs_ext_type=0D=0A  */=0D=0A=20=0D=
=0A #ifndef _LINUX_FUSE_H=0D=0A@@ -1318,6 +1325,55 @@ struct fuse_uring_c=
md_req {=0D=0A=20=0D=0A /* Famfs fmap message components */=0D=0A=20=0D=0A=
+#define FAMFS_FMAP_VERSION 1=0D=0A+=0D=0A #define FAMFS_FMAP_MAX 32768 /=
* Largest supported fmap message */=0D=0A+#define FUSE_FAMFS_MAX_EXTENTS =
32=0D=0A+#define FUSE_FAMFS_MAX_STRIPS 32=0D=0A+=0D=0A+enum fuse_famfs_fi=
le_type {=0D=0A+=09FUSE_FAMFS_FILE_REG,=0D=0A+=09FUSE_FAMFS_FILE_SUPERBLO=
CK,=0D=0A+=09FUSE_FAMFS_FILE_LOG,=0D=0A+};=0D=0A+=0D=0A+enum famfs_ext_ty=
pe {=0D=0A+=09FUSE_FAMFS_EXT_SIMPLE =3D 0,=0D=0A+=09FUSE_FAMFS_EXT_INTERL=
EAVE =3D 1,=0D=0A+};=0D=0A+=0D=0A+struct fuse_famfs_simple_ext {=0D=0A+=09=
uint32_t se_devindex;=0D=0A+=09uint32_t reserved;=0D=0A+=09uint64_t se_of=
fset;=0D=0A+=09uint64_t se_len;=0D=0A+};=0D=0A+=0D=0A+struct fuse_famfs_i=
ext { /* Interleaved extent */=0D=0A+=09uint32_t ie_nstrips;=0D=0A+=09uin=
t32_t ie_chunk_size;=0D=0A+=09uint64_t ie_nbytes; /* Total bytes for this=
 interleaved_ext;=0D=0A+=09=09=09     * sum of strips may be more=0D=0A+=09=
=09=09     */=0D=0A+=09uint64_t reserved;=0D=0A+};=0D=0A+=0D=0A+struct fu=
se_famfs_fmap_header {=0D=0A+=09uint8_t file_type; /* enum famfs_file_typ=
e */=0D=0A+=09uint8_t reserved;=0D=0A+=09uint16_t fmap_version;=0D=0A+=09=
uint32_t ext_type; /* enum famfs_log_ext_type */=0D=0A+=09uint32_t nexten=
ts;=0D=0A+=09uint32_t reserved0;=0D=0A+=09uint64_t file_size;=0D=0A+=09ui=
nt64_t reserved1;=0D=0A+};=0D=0A+=0D=0A+static inline int32_t fmap_msg_mi=
n_size(void)=0D=0A+{=0D=0A+=09/* Smallest fmap message is a header plus o=
ne simple extent */=0D=0A+=09return (sizeof(struct fuse_famfs_fmap_header=
)=0D=0A+=09=09+ sizeof(struct fuse_famfs_simple_ext));=0D=0A+}=0D=0A=20=0D=
=0A #endif /* _LINUX_FUSE_H */=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

