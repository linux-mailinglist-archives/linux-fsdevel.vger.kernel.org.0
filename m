Return-Path: <linux-fsdevel+bounces-74336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA67AD39AA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C25653001006
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDB827FD5D;
	Sun, 18 Jan 2026 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="q8UXHyMR";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="EHc+Aetj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-127.smtp-out.amazonses.com (a11-127.smtp-out.amazonses.com [54.240.11.127])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33030E844;
	Sun, 18 Jan 2026 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775590; cv=none; b=i/DpPmS3HYdymOGOOFEMbbOnDNvcWCayPgZaqQZ5FrNmVtFWqiMBth8Iyj7Y7y1TFiLx1sgu/xM08GeicNeq4q7YhFqY+qvVYHx2andThoVRZClIx6JxylTHROswXrRB/zJgTAhkPelKZqvin/shneCcyjgJI04WDsT5hoeqt8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775590; c=relaxed/simple;
	bh=s+m19nkQ3J292a+QcGgJ/r7J1IlcnI//UbTfCBhDN8E=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=RyckXTbbjbWMXHNozd2kzyvpGiyJdsQgSMMtlMlZuP7sKRzHWDzD7DZvUchQUMtUUzI5c2nkg9tojpv/lX/7AogGc0ahMpyxZFHBfKjx5MRwTmKYaby3PJUJOHzBE6R4UoIUzBSfnv+h6YoAPqLMdVAkT2q5Fsn03tkVxFh/250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=q8UXHyMR; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=EHc+Aetj; arc=none smtp.client-ip=54.240.11.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775584;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=s+m19nkQ3J292a+QcGgJ/r7J1IlcnI//UbTfCBhDN8E=;
	b=q8UXHyMRT/ovGdzMnOluTg4GRqnVOU6AKwBc86g4RhZtEDGSwNmXJqJQC2UKBQb6
	QWRrw5UBf8UYLmMeMHzesWULAJs8Qq0McGlf3Xoe91GbqwJKezspUYPQDsCGge/KOWd
	qQoKN+UPBM3Cg8oL7D28UKJsf+rFwgrByum6WjMA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775584;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=s+m19nkQ3J292a+QcGgJ/r7J1IlcnI//UbTfCBhDN8E=;
	b=EHc+AetjbAYIXLOQAF7gzUJs4zNkL3MJIr21zlKAAvaSreppYsJ2iEyrsCdGLsOs
	j2N+tdHHQW6GZZ4kmhQ1iX6Idy5QHx+G+c2j/oXUaYqrevCeOnpWxY8sfrZPBWeeWZh
	XVXP6Ryc5sVvIznDy3tYUc6nIy/WyjbD5T8Ts3fE=
Subject: [PATCH V7 12/19] famfs_fuse: Plumb the GET_FMAP message/response
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
Date: Sun, 18 Jan 2026 22:33:04 +0000
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
 <20260118223257.92539-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAhzv8=
Thread-Topic: [PATCH V7 12/19] famfs_fuse: Plumb the GET_FMAP message/response
X-Wm-Sent-Timestamp: 1768775583
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33d8b0a-05af2fc2-66c2-45e7-9091-42ca2efa6780-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.127

From: John Groves <john@groves.net>=0D=0A=0D=0AUpon completion of an OPEN=
, if we're in famfs-mode we do a GET_FMAP to=0D=0Aretrieve and cache up t=
he file-to-dax map in the kernel. If this=0D=0Asucceeds, read/write/mmap =
are resolved direct-to-dax with no upcalls.=0D=0A=0D=0ASigned-off-by: Joh=
n Groves <john@groves.net>=0D=0A---=0D=0A MAINTAINERS               |  8 =
+++++=0D=0A fs/fuse/Makefile          |  1 +=0D=0A fs/fuse/famfs.c       =
    | 74 +++++++++++++++++++++++++++++++++++++++=0D=0A fs/fuse/file.c    =
        | 14 +++++++-=0D=0A fs/fuse/fuse_i.h          | 70 ++++++++++++++=
+++++++++++++++++++---=0D=0A fs/fuse/inode.c           |  8 ++++-=0D=0A f=
s/fuse/iomode.c          |  2 +-=0D=0A include/uapi/linux/fuse.h |  7 +++=
+=0D=0A 8 files changed, 176 insertions(+), 8 deletions(-)=0D=0A create m=
ode 100644 fs/fuse/famfs.c=0D=0A=0D=0Adiff --git a/MAINTAINERS b/MAINTAIN=
ERS=0D=0Aindex 10aa5120d93f..e3d0aa5eb361 100644=0D=0A--- a/MAINTAINERS=0D=
=0A+++ b/MAINTAINERS=0D=0A@@ -10379,6 +10379,14 @@ F:=09fs/fuse/=0D=0A F:=
=09include/uapi/linux/fuse.h=0D=0A F:=09tools/testing/selftests/filesyste=
ms/fuse/=0D=0A=20=0D=0A+FUSE [FAMFS Fabric-Attached Memory File System]=0D=
=0A+M:=09John Groves <jgroves@micron.com>=0D=0A+M:=09John Groves <John@Gr=
oves.net>=0D=0A+L:=09linux-cxl@vger.kernel.org=0D=0A+L:=09linux-fsdevel@v=
ger.kernel.org=0D=0A+S:=09Supported=0D=0A+F:=09fs/fuse/famfs.c=0D=0A+=0D=0A=
 FUTEX SUBSYSTEM=0D=0A M:=09Thomas Gleixner <tglx@kernel.org>=0D=0A M:=09=
Ingo Molnar <mingo@redhat.com>=0D=0Adiff --git a/fs/fuse/Makefile b/fs/fu=
se/Makefile=0D=0Aindex 22ad9538dfc4..3f8dcc8cbbd0 100644=0D=0A--- a/fs/fu=
se/Makefile=0D=0A+++ b/fs/fuse/Makefile=0D=0A@@ -17,5 +17,6 @@ fuse-$(CON=
FIG_FUSE_DAX) +=3D dax.o=0D=0A fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passt=
hrough.o backing.o=0D=0A fuse-$(CONFIG_SYSCTL) +=3D sysctl.o=0D=0A fuse-$=
(CONFIG_FUSE_IO_URING) +=3D dev_uring.o=0D=0A+fuse-$(CONFIG_FUSE_FAMFS_DA=
X) +=3D famfs.o=0D=0A=20=0D=0A virtiofs-y :=3D virtio_fs.o=0D=0Adiff --gi=
t a/fs/fuse/famfs.c b/fs/fuse/famfs.c=0D=0Anew file mode 100644=0D=0Ainde=
x 000000000000..615819cc922d=0D=0A--- /dev/null=0D=0A+++ b/fs/fuse/famfs.=
c=0D=0A@@ -0,0 +1,74 @@=0D=0A+// SPDX-License-Identifier: GPL-2.0=0D=0A+/=
*=0D=0A+ * famfs - dax file system for shared fabric-attached memory=0D=0A=
+ *=0D=0A+ * Copyright 2023-2026 Micron Technology, Inc.=0D=0A+ *=0D=0A+ =
* This file system, originally based on ramfs the dax support from xfs,=0D=
=0A+ * is intended to allow multiple host systems to mount a common file =
system=0D=0A+ * view of dax files that map to shared memory.=0D=0A+ */=0D=
=0A+=0D=0A+#include <linux/cleanup.h>=0D=0A+#include <linux/fs.h>=0D=0A+#=
include <linux/mm.h>=0D=0A+#include <linux/dax.h>=0D=0A+#include <linux/i=
omap.h>=0D=0A+#include <linux/path.h>=0D=0A+#include <linux/namei.h>=0D=0A=
+#include <linux/string.h>=0D=0A+=0D=0A+#include "fuse_i.h"=0D=0A+=0D=0A+=
=0D=0A+#define FMAP_BUFSIZE PAGE_SIZE=0D=0A+=0D=0A+int=0D=0A+fuse_get_fma=
p(struct fuse_mount *fm, struct inode *inode)=0D=0A+{=0D=0A+=09void *fmap=
_buf __free(kfree) =3D NULL;=0D=0A+=09struct fuse_inode *fi =3D get_fuse_=
inode(inode);=0D=0A+=09size_t fmap_bufsize =3D FMAP_BUFSIZE;=0D=0A+=09u64=
 nodeid =3D get_node_id(inode);=0D=0A+=09ssize_t fmap_size;=0D=0A+=09int =
rc;=0D=0A+=0D=0A+=09FUSE_ARGS(args);=0D=0A+=0D=0A+=09/* Don't retrieve if=
 we already have the famfs metadata */=0D=0A+=09if (fi->famfs_meta)=0D=0A=
+=09=09return 0;=0D=0A+=0D=0A+=09fmap_buf =3D kzalloc(FMAP_BUFSIZE, GFP_K=
ERNEL);=0D=0A+=09if (!fmap_buf)=0D=0A+=09=09return -EIO;=0D=0A+=0D=0A+=09=
args.opcode =3D FUSE_GET_FMAP;=0D=0A+=09args.nodeid =3D nodeid;=0D=0A+=0D=
=0A+=09/* Variable-sized output buffer=0D=0A+=09 * this causes fuse_simpl=
e_request() to return the size of the=0D=0A+=09 * output payload=0D=0A+=09=
 */=0D=0A+=09args.out_argvar =3D true;=0D=0A+=09args.out_numargs =3D 1;=0D=
=0A+=09args.out_args[0].size =3D fmap_bufsize;=0D=0A+=09args.out_args[0].=
value =3D fmap_buf;=0D=0A+=0D=0A+=09/* Send GET_FMAP command */=0D=0A+=09=
rc =3D fuse_simple_request(fm, &args);=0D=0A+=09if (rc < 0) {=0D=0A+=09=09=
pr_err("%s: err=3D%d from fuse_simple_request()\n",=0D=0A+=09=09       __=
func__, rc);=0D=0A+=09=09return rc;=0D=0A+=09}=0D=0A+=09fmap_size =3D rc;=
=0D=0A+=0D=0A+=09/* We retrieved the "fmap" (the file's map to memory), b=
ut=0D=0A+=09 * we haven't used it yet. A call to famfs_file_init_dax() wi=
ll be added=0D=0A+=09 * here in a subsequent patch, when we add the abili=
ty to attach=0D=0A+=09 * fmaps to files.=0D=0A+=09 */=0D=0A+=0D=0A+=09ret=
urn 0;=0D=0A+}=0D=0Adiff --git a/fs/fuse/file.c b/fs/fuse/file.c=0D=0Aind=
ex 093569033ed1..1f64bf68b5ee 100644=0D=0A--- a/fs/fuse/file.c=0D=0A+++ b=
/fs/fuse/file.c=0D=0A@@ -277,6 +277,16 @@ static int fuse_open(struct ino=
de *inode, struct file *file)=0D=0A =09err =3D fuse_do_open(fm, get_node_=
id(inode), file, false);=0D=0A =09if (!err) {=0D=0A =09=09ff =3D file->pr=
ivate_data;=0D=0A+=0D=0A+=09=09if ((fm->fc->famfs_iomap) && (S_ISREG(inod=
e->i_mode))) {=0D=0A+=09=09=09/* Get the famfs fmap - failure is fatal */=
=0D=0A+=09=09=09err =3D fuse_get_fmap(fm, inode);=0D=0A+=09=09=09if (err)=
 {=0D=0A+=09=09=09=09fuse_sync_release(fi, ff, file->f_flags);=0D=0A+=09=09=
=09=09goto out_nowrite;=0D=0A+=09=09=09}=0D=0A+=09=09}=0D=0A+=0D=0A =09=09=
err =3D fuse_finish_open(inode, file);=0D=0A =09=09if (err)=0D=0A =09=09=09=
fuse_sync_release(fi, ff, file->f_flags);=0D=0A@@ -284,12 +294,14 @@ stat=
ic int fuse_open(struct inode *inode, struct file *file)=0D=0A =09=09=09f=
use_truncate_update_attr(inode, file);=0D=0A =09}=0D=0A=20=0D=0A+out_nowr=
ite:=0D=0A =09if (is_wb_truncate || dax_truncate)=0D=0A =09=09fuse_releas=
e_nowrite(inode);=0D=0A =09if (!err) {=0D=0A =09=09if (is_truncate)=0D=0A=
 =09=09=09truncate_pagecache(inode, 0);=0D=0A-=09=09else if (!(ff->open_f=
lags & FOPEN_KEEP_CACHE))=0D=0A+=09=09else if (!(ff->open_flags & FOPEN_K=
EEP_CACHE) &&=0D=0A+=09=09=09 !fuse_file_famfs(fi))=0D=0A =09=09=09invali=
date_inode_pages2(inode->i_mapping);=0D=0A =09}=0D=0A =09if (dax_truncate=
)=0D=0Adiff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h=0D=0Aindex 2839ef=
b219a9..b66b5ca0bc11 100644=0D=0A--- a/fs/fuse/fuse_i.h=0D=0A+++ b/fs/fus=
e/fuse_i.h=0D=0A@@ -223,6 +223,14 @@ struct fuse_inode {=0D=0A =09 * so p=
reserve the blocksize specified by the server.=0D=0A =09 */=0D=0A =09u8 c=
ached_i_blkbits;=0D=0A+=0D=0A+#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)=0D=0A=
+=09/* Pointer to the file's famfs metadata. Primary content is the=0D=0A=
+=09 * in-memory version of the fmap - the map from file's offset range=0D=
=0A+=09 * to DAX memory=0D=0A+=09 */=0D=0A+=09void *famfs_meta;=0D=0A+#en=
dif=0D=0A };=0D=0A=20=0D=0A /** FUSE inode state bits */=0D=0A@@ -1511,11=
 +1519,8 @@ void fuse_free_conn(struct fuse_conn *fc);=0D=0A=20=0D=0A /* =
dax.c */=0D=0A=20=0D=0A-static inline bool fuse_file_famfs(struct fuse_in=
ode *fuse_inode) /* Will be superseded */=0D=0A-{=0D=0A-=09(void)fuse_ino=
de;=0D=0A-=09return false;=0D=0A-}=0D=0A+static inline int fuse_file_famf=
s(struct fuse_inode *fi); /* forward */=0D=0A+=0D=0A #define FUSE_IS_VIRT=
IO_DAX(fuse_inode) (IS_ENABLED(CONFIG_FUSE_DAX)=09\=0D=0A =09=09=09=09=09=
&& IS_DAX(&fuse_inode->inode)  \=0D=0A =09=09=09=09=09&& !fuse_file_famfs=
(fuse_inode))=0D=0A@@ -1634,4 +1639,59 @@ extern void fuse_sysctl_unregis=
ter(void);=0D=0A #define fuse_sysctl_unregister()=09do { } while (0)=0D=0A=
 #endif /* CONFIG_SYSCTL */=0D=0A=20=0D=0A+/* famfs.c */=0D=0A+=0D=0A+#if=
 IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)=0D=0A+void __famfs_meta_free(void *map=
);=0D=0A+=0D=0A+/* Set fi->famfs_meta =3D NULL regardless of prior value =
*/=0D=0A+static inline void famfs_meta_init(struct fuse_inode *fi)=0D=0A+=
{=0D=0A+=09fi->famfs_meta =3D NULL;=0D=0A+}=0D=0A+=0D=0A+/* Set fi->famfs=
_meta iff the current value is NULL */=0D=0A+static inline struct fuse_ba=
cking *famfs_meta_set(struct fuse_inode *fi,=0D=0A+=09=09=09=09=09=09  vo=
id *meta)=0D=0A+{=0D=0A+=09return cmpxchg(&fi->famfs_meta, NULL, meta);=0D=
=0A+}=0D=0A+=0D=0A+static inline void famfs_meta_free(struct fuse_inode *=
fi)=0D=0A+{=0D=0A+=09famfs_meta_set(fi, NULL);=0D=0A+}=0D=0A+=0D=0A+stati=
c inline int fuse_file_famfs(struct fuse_inode *fi)=0D=0A+{=0D=0A+=09retu=
rn (READ_ONCE(fi->famfs_meta) !=3D NULL);=0D=0A+}=0D=0A+=0D=0A+int fuse_g=
et_fmap(struct fuse_mount *fm, struct inode *inode);=0D=0A+=0D=0A+#else /=
* !CONFIG_FUSE_FAMFS_DAX */=0D=0A+=0D=0A+static inline struct fuse_backin=
g *famfs_meta_set(struct fuse_inode *fi,=0D=0A+=09=09=09=09=09=09  void *=
meta)=0D=0A+{=0D=0A+=09return NULL;=0D=0A+}=0D=0A+=0D=0A+static inline vo=
id famfs_meta_free(struct fuse_inode *fi)=0D=0A+{=0D=0A+}=0D=0A+=0D=0A+st=
atic inline int fuse_file_famfs(struct fuse_inode *fi)=0D=0A+{=0D=0A+=09r=
eturn 0;=0D=0A+}=0D=0A+=0D=0A+static inline int=0D=0A+fuse_get_fmap(struc=
t fuse_mount *fm, struct inode *inode)=0D=0A+{=0D=0A+=09return 0;=0D=0A+}=
=0D=0A+=0D=0A+#endif /* CONFIG_FUSE_FAMFS_DAX */=0D=0A+=0D=0A #endif /* _=
FS_FUSE_I_H */=0D=0Adiff --git a/fs/fuse/inode.c b/fs/fuse/inode.c=0D=0Ai=
ndex acabf92a11f8..f2d742d723dc 100644=0D=0A--- a/fs/fuse/inode.c=0D=0A++=
+ b/fs/fuse/inode.c=0D=0A@@ -120,6 +120,9 @@ static struct inode *fuse_al=
loc_inode(struct super_block *sb)=0D=0A =09if (IS_ENABLED(CONFIG_FUSE_PAS=
STHROUGH))=0D=0A =09=09fuse_inode_backing_set(fi, NULL);=0D=0A=20=0D=0A+=09=
if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))=0D=0A+=09=09famfs_meta_set(fi, NUL=
L);=0D=0A+=0D=0A =09return &fi->inode;=0D=0A=20=0D=0A out_free_forget:=0D=
=0A@@ -141,6 +144,9 @@ static void fuse_free_inode(struct inode *inode)=0D=
=0A =09if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))=0D=0A =09=09fuse_backing_=
put(fuse_inode_backing(fi));=0D=0A=20=0D=0A+=09if (S_ISREG(inode->i_mode)=
 && fuse_file_famfs(fi))=0D=0A+=09=09famfs_meta_free(fi);=0D=0A+=0D=0A =09=
kmem_cache_free(fuse_inode_cachep, fi);=0D=0A }=0D=0A=20=0D=0A@@ -162,7 +=
168,7 @@ static void fuse_evict_inode(struct inode *inode)=0D=0A =09/* Wi=
ll write inode on close/munmap and in all other dirtiers */=0D=0A =09WARN=
_ON(inode_state_read_once(inode) & I_DIRTY_INODE);=0D=0A=20=0D=0A-=09if (=
FUSE_IS_VIRTIO_DAX(fi))=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_=
famfs(fi))=0D=0A =09=09dax_break_layout_final(inode);=0D=0A=20=0D=0A =09t=
runcate_inode_pages_final(&inode->i_data);=0D=0Adiff --git a/fs/fuse/iomo=
de.c b/fs/fuse/iomode.c=0D=0Aindex 31ee7f3304c6..948148316ef0 100644=0D=0A=
--- a/fs/fuse/iomode.c=0D=0A+++ b/fs/fuse/iomode.c=0D=0A@@ -203,7 +203,7 =
@@ int fuse_file_io_open(struct file *file, struct inode *inode)=0D=0A =09=
 * io modes are not relevant with DAX and with server that does not=0D=0A=
 =09 * implement open.=0D=0A =09 */=0D=0A-=09if (FUSE_IS_VIRTIO_DAX(fi) |=
| !ff->args)=0D=0A+=09if (FUSE_IS_VIRTIO_DAX(fi) || fuse_file_famfs(fi) |=
| !ff->args)=0D=0A =09=09return 0;=0D=0A=20=0D=0A =09/*=0D=0Adiff --git a=
/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h=0D=0Aindex 25686f0=
88e6a..9eff9083d3b5 100644=0D=0A--- a/include/uapi/linux/fuse.h=0D=0A+++ =
b/include/uapi/linux/fuse.h=0D=0A@@ -669,6 +669,9 @@ enum fuse_opcode {=0D=
=0A =09FUSE_STATX=09=09=3D 52,=0D=0A =09FUSE_COPY_FILE_RANGE_64=09=3D 53,=
=0D=0A=20=0D=0A+=09/* Famfs / devdax opcodes */=0D=0A+=09FUSE_GET_FMAP   =
        =3D 54,=0D=0A+=0D=0A =09/* CUSE specific operations */=0D=0A =09C=
USE_INIT=09=09=3D 4096,=0D=0A=20=0D=0A@@ -1313,4 +1316,8 @@ struct fuse_u=
ring_cmd_req {=0D=0A =09uint8_t padding[6];=0D=0A };=0D=0A=20=0D=0A+/* Fa=
mfs fmap message components */=0D=0A+=0D=0A+#define FAMFS_FMAP_MAX 32768 =
/* Largest supported fmap message */=0D=0A+=0D=0A #endif /* _LINUX_FUSE_H=
 */=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

