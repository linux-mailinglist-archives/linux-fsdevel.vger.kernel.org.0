Return-Path: <linux-fsdevel+bounces-74347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D7D39AF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAF6A3014A0A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932E430F95F;
	Sun, 18 Jan 2026 22:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="kISIX58Q";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ma+iUf5B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-32.smtp-out.amazonses.com (a11-32.smtp-out.amazonses.com [54.240.11.32])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5427F4E7;
	Sun, 18 Jan 2026 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775749; cv=none; b=oEzRHXtC5Acxp6+tY11iDzG3aK6Y4LRgPIAYk5rakmUl6tWKdt4Wbg4HQxKdoGLuDQNYiiMgrwBJPJJsIitKIEFQUfCteT9OpyHq2zBA0opYOLfUnK++G/Ifx++3FTyee/0A0AMF6yeMJz7JEF/9Z7H2d63AFzLoMdLcBJw85ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775749; c=relaxed/simple;
	bh=5fP7NXTPONxO5AJaCYWYjZ+g0d1Sgj1vq484yxg6Jis=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=GsSwKZwPARQEajluF2T71kDZP04MkZVuYvrmfa6Ub3IWygh4m/DdqWNXHeWF+kHjGnx8qUb3VWW9bndA68uSotXbNGoR5+VnrEbYq5o7m1vxUPZXqpzNthDM6roqlGCA5VUq0MR0PhnuaEz3vnfOmkavgkMkhd1C0z75vMj751g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=kISIX58Q; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=ma+iUf5B; arc=none smtp.client-ip=54.240.11.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775746;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=5fP7NXTPONxO5AJaCYWYjZ+g0d1Sgj1vq484yxg6Jis=;
	b=kISIX58QPt/8B6Y168oXeXqni/H1cfSgX79iCMM0PnavR8wZ4ha8LLMZ1RZeiRa+
	gFnmJdrF2qeXEKWTZPQ/CiXEJjweSCbTAfVy7cPbvCxbHlrG9B5igUTsRFK1MwJfHPL
	iqZLiEvtpitei5Io4n/aQ4FsoLbam9SiYPChMh98=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775746;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=5fP7NXTPONxO5AJaCYWYjZ+g0d1Sgj1vq484yxg6Jis=;
	b=ma+iUf5BnpaquugVYeJMiHWJqZ/nyHrcwfvLMFTYhuIE7OV1pw+UmskZI4pxVdu6
	TuN8qnEuGwQXroOCFVaopguKp1l4hDfZ3xlZkrVcHqFWaK0Dpno7SHxM4TGmnSqsfkY
	MhHMqcXuco6HTXgu7hav7fghNx/V2+L8945wz4r0=
Subject: [PATCH V7 3/3] fuse: add famfs DAX fmap support
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
Date: Sun, 18 Jan 2026 22:35:46 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com>
References: 
 <0100019bd33f2761-af1fb233-73d0-4b99-a0c0-d239266aec91-000000@email.amazonses.com> 
 <20260118223539.92799-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMrIByUNHwPnRW2vpOUrHpL2ew==
Thread-Topic: [PATCH V7 3/3] fuse: add famfs DAX fmap support
X-Wm-Sent-Timestamp: 1768775745
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd34002e0-a865e15a-5757-4b28-9dc6-ed8a7a2ee9de-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.32

From: John Groves <john@groves.net>=0D=0A=0D=0AAdd new FUSE operations an=
d capability for famfs DAX file mapping:=0D=0A=0D=0A- FUSE_CAP_DAX_FMAP: =
New capability flag at bit 32 (using want_ext/capable_ext=0D=0A  fields) =
to indicate kernel and userspace support for DAX fmaps=0D=0A=0D=0A- GET_F=
MAP: New operation to retrieve a file map for DAX-mapped files.=0D=0A  Re=
turns a fuse_famfs_fmap_header followed by simple or interleaved=0D=0A  e=
xtent descriptors. The kernel passes the file size as an argument.=0D=0A=0D=
=0A- GET_DAXDEV: New operation to retrieve DAX device info by index.=0D=0A=
  Called when GET_FMAP returns an fmap referencing a previously=0D=0A  un=
known DAX device.=0D=0A=0D=0AThese operations enable FUSE filesystems to =
provide direct access=0D=0Amappings to persistent memory, allowing the ke=
rnel to map files=0D=0Adirectly to DAX devices without page cache interme=
diation.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=
=0D=0A include/fuse_common.h   |  5 +++++=0D=0A include/fuse_lowlevel.h |=
 37 +++++++++++++++++++++++++++++++++++++=0D=0A lib/fuse_lowlevel.c     |=
 31 ++++++++++++++++++++++++++++++-=0D=0A patch/maintainers.txt   |  0=0D=
=0A 4 files changed, 72 insertions(+), 1 deletion(-)=0D=0A create mode 10=
0644 patch/maintainers.txt=0D=0A=0D=0Adiff --git a/include/fuse_common.h =
b/include/fuse_common.h=0D=0Aindex 041188e..23b24e8 100644=0D=0A--- a/inc=
lude/fuse_common.h=0D=0A+++ b/include/fuse_common.h=0D=0A@@ -512,6 +512,1=
1 @@ struct fuse_loop_config_v1 {=0D=0A  */=0D=0A #define FUSE_CAP_OVER_I=
O_URING (1UL << 31)=0D=0A=20=0D=0A+/**=0D=0A+ * handle files that use fam=
fs dax fmaps=0D=0A+ */=0D=0A+#define FUSE_CAP_DAX_FMAP (1UL << 32)=0D=0A+=
=0D=0A /**=0D=0A  * Ioctl flags=0D=0A  *=0D=0Adiff --git a/include/fuse_l=
owlevel.h b/include/fuse_lowlevel.h=0D=0Aindex 016f831..a94436a 100644=0D=
=0A--- a/include/fuse_lowlevel.h=0D=0A+++ b/include/fuse_lowlevel.h=0D=0A=
@@ -1341,6 +1341,43 @@ struct fuse_lowlevel_ops {=0D=0A =09 */=0D=0A =09v=
oid (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,=0D=0A =09=
=09      struct fuse_file_info *fi);=0D=0A+=0D=0A+=09/**=0D=0A+=09 * Get =
a famfs/devdax/fsdax fmap=0D=0A+=09 *=0D=0A+=09 * Retrieve a file map (ak=
a fmap) for a previously looked-up file.=0D=0A+=09 * The fmap is serializ=
ed into the buffer, anchored by=0D=0A+=09 * struct fuse_famfs_fmap_header=
, followed by one or more=0D=0A+=09 * structs fuse_famfs_simple_ext, or f=
use_famfs_iext (which itself=0D=0A+=09 * is followed by one or more fuse_=
famfs_simple_ext...=0D=0A+=09 *=0D=0A+=09 * Valid replies:=0D=0A+=09 *   =
 fuse_reply_buf  (TODO: variable-size reply)=0D=0A+=09 *    fuse_reply_er=
r=0D=0A+=09 *=0D=0A+=09 * @param req request handle=0D=0A+=09 * @param in=
o the inode number=0D=0A+=09 */=0D=0A+=09void (*get_fmap) (fuse_req_t req=
, fuse_ino_t ino, size_t size);=0D=0A+=0D=0A+=09/**=0D=0A+=09 * Get a dax=
dev by index=0D=0A+=09 *=0D=0A+=09 * Retrieve info on a daxdev by index. =
This will be called any time=0D=0A+=09 * GET_FMAP has returned a file map=
 that references a previously=0D=0A+=09 * unused daxdev. struct famfs_sim=
ple_ext, which is used for all=0D=0A+=09 * resolutions to daxdev offsets,=
 references daxdevs by index.=0D=0A+=09 * In user space we maintain a mas=
ter list of all referenced daxdevs=0D=0A+=09 * by index, which is queried=
 by get_daxdev.=0D=0A+=09 *=0D=0A+=09 * Valid replies:=0D=0A+=09 *    fus=
e_reply_buf=0D=0A+=09 *    fuse_reply_err=0D=0A+=09 *=0D=0A+=09 * @param =
req request handle=0D=0A+=09 * @param ino the index of the daxdev=0D=0A+=09=
 */=0D=0A+=09void (*get_daxdev) (fuse_req_t req, int daxdev_index);=0D=0A=
 };=0D=0A=20=0D=0A /**=0D=0Adiff --git a/lib/fuse_lowlevel.c b/lib/fuse_l=
owlevel.c=0D=0Aindex 0cde3d4..ac78233 100644=0D=0A--- a/lib/fuse_lowlevel=
=2Ec=0D=0A+++ b/lib/fuse_lowlevel.c=0D=0A@@ -2769,7 +2769,8 @@ _do_init(f=
use_req_t req, const fuse_ino_t nodeid, const void *op_in,=0D=0A =09=09=09=
se->conn.capable_ext |=3D FUSE_CAP_NO_EXPORT_SUPPORT;=0D=0A =09=09if (ina=
rgflags & FUSE_OVER_IO_URING)=0D=0A =09=09=09se->conn.capable_ext |=3D FU=
SE_CAP_OVER_IO_URING;=0D=0A-=0D=0A+=09=09if (inargflags & FUSE_DAX_FMAP)=0D=
=0A+=09=09=09se->conn.capable_ext |=3D FUSE_CAP_DAX_FMAP;=0D=0A =09} else=
 {=0D=0A =09=09se->conn.max_readahead =3D 0;=0D=0A =09}=0D=0A@@ -2932,6 +=
2933,8 @@ _do_init(fuse_req_t req, const fuse_ino_t nodeid, const void *o=
p_in,=0D=0A =09=09outargflags |=3D FUSE_REQUEST_TIMEOUT;=0D=0A =09=09outa=
rg.request_timeout =3D se->conn.request_timeout;=0D=0A =09}=0D=0A+=09if (=
se->conn.want_ext & FUSE_CAP_DAX_FMAP)=0D=0A+=09=09outargflags |=3D FUSE_=
DAX_FMAP;=0D=0A=20=0D=0A =09outarg.max_readahead =3D se->conn.max_readahe=
ad;=0D=0A =09outarg.max_write =3D se->conn.max_write;=0D=0A@@ -3035,6 +30=
38,30 @@ static void do_destroy(fuse_req_t req, fuse_ino_t nodeid, const =
void *inarg)=0D=0A =09_do_destroy(req, nodeid, inarg, NULL);=0D=0A }=0D=0A=
=20=0D=0A+static void=0D=0A+do_get_fmap(fuse_req_t req, fuse_ino_t nodeid=
, const void *inarg)=0D=0A+{=0D=0A+=09struct fuse_session *se =3D req->se=
;=0D=0A+=09struct fuse_getxattr_in *arg =3D (struct fuse_getxattr_in *) i=
narg;=0D=0A+=0D=0A+=09if (se->op.get_fmap)=0D=0A+=09=09se->op.get_fmap(re=
q, nodeid, arg->size);=0D=0A+=09else=0D=0A+=09=09fuse_reply_err(req, -EOP=
NOTSUPP);=0D=0A+}=0D=0A+=0D=0A+static void=0D=0A+do_get_daxdev(fuse_req_t=
 req, fuse_ino_t nodeid, const void *inarg)=0D=0A+{=0D=0A+=09struct fuse_=
session *se =3D req->se;=0D=0A+=09(void)inarg;=0D=0A+=0D=0A+=09if (se->op=
=2Eget_daxdev)=0D=0A+=09=09se->op.get_daxdev(req, nodeid); /* Use nodeid =
as daxdev_index */=0D=0A+=09else=0D=0A+=09=09fuse_reply_err(req, -EOPNOTS=
UPP);=0D=0A+}=0D=0A+=0D=0A static void list_del_nreq(struct fuse_notify_r=
eq *nreq)=0D=0A {=0D=0A =09struct fuse_notify_req *prev =3D nreq->prev;=0D=
=0A@@ -3470,6 +3497,8 @@ static struct {=0D=0A =09[FUSE_LSEEK]=09   =3D {=
 do_lseek,       "LSEEK"=09     },=0D=0A =09[FUSE_STATX]=09   =3D { do_st=
atx,       "STATX"=09     },=0D=0A =09[CUSE_INIT]=09   =3D { cuse_lowleve=
l_init, "CUSE_INIT"   },=0D=0A+=09[FUSE_GET_FMAP]=09   =3D { do_get_fmap,=
 "GET_FMAP"       },=0D=0A+=09[FUSE_GET_DAXDEV]  =3D { do_get_daxdev, "GE=
T_DAXDEV"   },=0D=0A };=0D=0A=20=0D=0A static struct {=0D=0Adiff --git a/=
patch/maintainers.txt b/patch/maintainers.txt=0D=0Anew file mode 100644=0D=
=0Aindex 0000000..e69de29=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

