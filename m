Return-Path: <linux-fsdevel+bounces-74335-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 710E4D39A9F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 255693007C96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC6230FC0F;
	Sun, 18 Jan 2026 22:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="X3SCmJMr";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="WqSzxoD+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-123.smtp-out.amazonses.com (a11-123.smtp-out.amazonses.com [54.240.11.123])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75252836A6;
	Sun, 18 Jan 2026 22:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775580; cv=none; b=WAuJb5WijPU5RRqKqTPU6SHj6+kxYtoqkiaRJ40aRAljImhadfHCgaD/XiC4XO+BmYyURkmHRUwHjD/XloxfGUHC19z8sp4d1wRhlJgpk+qkyLrJzHs0e2zyom6bgTGxa0zWfDCepfAHRos8YUOVNuNJRX+EPG8x0gbNp9zeXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775580; c=relaxed/simple;
	bh=iut77gaxquLysmZmztLRMRZhsWQOMrcw7mV3QknlVLM=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=Ns71NqOK5sJ2Vd13bNOapy6r6OWklZTs26QJTVQJEb5NsmT5rWaMGFf7XPYYlJo4j6TaMPWxSyTdCEnTGqLHl8KZdWTKXwj4K+H/bObbsvCvYIQLcEncvFhqfjEoprD4U8jNKW7Zt0uzFWiAHchEUPRtBqOZyWVAIVnsMlFQA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=X3SCmJMr; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=WqSzxoD+; arc=none smtp.client-ip=54.240.11.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775575;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=iut77gaxquLysmZmztLRMRZhsWQOMrcw7mV3QknlVLM=;
	b=X3SCmJMrPcRhU2FDbqhQqlQ3qKsL//qyeThWPSpWrm2iFkZAypdT88zGxfT2CIr1
	vhTkQWhGYg/+pzPVZ0w+xm5DffLY9chKR/Selq4NiXrtC7rKAopXgfXKs5jAw0HlaGc
	T/eqmO/PneL0FjpLC1eOUGWjmE+m5Bd+gDqndKF0=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775575;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=iut77gaxquLysmZmztLRMRZhsWQOMrcw7mV3QknlVLM=;
	b=WqSzxoD+aUcLyqL7Jms6NdPoW2L+zriEorbdMq69ujhMGHlonQBt3yqzc/RznmsK
	/TiBTu1ggZTuRFLbPx9oQS4KePP1zVPlifdLQHpqHgjinAlDVoq0+yv1Ene7RlbOtG4
	LviOka1DwTiZtSBI0uNRwzs6wCleC2V7Az8XDn9E=
Subject: [PATCH V7 11/19] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
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
Date: Sun, 18 Jan 2026 22:32:55 +0000
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
 <20260118223247.92522-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAgYvU=
Thread-Topic: [PATCH V7 11/19] famfs_fuse: Basic fuse kernel ABI enablement
 for famfs
X-Wm-Sent-Timestamp: 1768775573
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33d6668-75812abd-cb8a-487e-90b9-0fd2b9ad9e89-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.123

From: John Groves <john@groves.net>=0D=0A=0D=0AThis patch starts the kern=
el ABI enablement of famfs in fuse.=0D=0A=0D=0A- Kconfig: Add FUSE_FAMFS_=
DAX config parameter, to control=0D=0A  compilation of famfs within fuse.=
=0D=0A- FUSE_DAX_FMAP flag in INIT request/reply=0D=0A- fuse_conn->famfs_=
iomap (enable famfs-mapped files) to denote a=0D=0A  famfs-enabled connec=
tion=0D=0A=0D=0AReviewed-by: Joanne Koong <joannelkoong@gmail.com>=0D=0AS=
igned-off-by: John Groves <john@groves.net>=0D=0A---=0D=0A fs/fuse/Kconfi=
g           | 14 ++++++++++++++=0D=0A fs/fuse/fuse_i.h          |  3 +++=0D=
=0A fs/fuse/inode.c           |  6 ++++++=0D=0A include/uapi/linux/fuse.h=
 |  5 +++++=0D=0A 4 files changed, 28 insertions(+)=0D=0A=0D=0Adiff --git=
 a/fs/fuse/Kconfig b/fs/fuse/Kconfig=0D=0Aindex 3a4ae632c94a..5ca9fae62c7=
b 100644=0D=0A--- a/fs/fuse/Kconfig=0D=0A+++ b/fs/fuse/Kconfig=0D=0A@@ -7=
6,3 +76,17 @@ config FUSE_IO_URING=0D=0A=20=0D=0A =09  If you want to all=
ow fuse server/client communication through io-uring,=0D=0A =09  answer Y=
=0D=0A+=0D=0A+config FUSE_FAMFS_DAX=0D=0A+=09bool "FUSE support for fs-da=
x filesystems backed by devdax"=0D=0A+=09depends on FUSE_FS=0D=0A+=09depe=
nds on DEV_DAX=0D=0A+=09depends on FS_DAX=0D=0A+=09default FUSE_FS=0D=0A+=
=09help=0D=0A+=09  This enables the fabric-attached memory file system (f=
amfs),=0D=0A+=09  which enables formatting devdax memory as a file system=
=2E Famfs=0D=0A+=09  is primarily intended for scale-out shared access to=
=0D=0A+=09  disaggregated memory.=0D=0A+=0D=0A+=09  To enable famfs or ot=
her fuse/fs-dax file systems, answer Y=0D=0Adiff --git a/fs/fuse/fuse_i.h=
 b/fs/fuse/fuse_i.h=0D=0Aindex 45e108dec771..2839efb219a9 100644=0D=0A---=
 a/fs/fuse/fuse_i.h=0D=0A+++ b/fs/fuse/fuse_i.h=0D=0A@@ -921,6 +921,9 @@ =
struct fuse_conn {=0D=0A =09/* Is synchronous FUSE_INIT allowed=3F */=0D=0A=
 =09unsigned int sync_init:1;=0D=0A=20=0D=0A+=09/* dev_dax_iomap support =
for famfs */=0D=0A+=09unsigned int famfs_iomap:1;=0D=0A+=0D=0A =09/* Use =
io_uring for communication */=0D=0A =09unsigned int io_uring;=0D=0A=20=0D=
=0Adiff --git a/fs/fuse/inode.c b/fs/fuse/inode.c=0D=0Aindex ed667920997f=
=2E.acabf92a11f8 100644=0D=0A--- a/fs/fuse/inode.c=0D=0A+++ b/fs/fuse/ino=
de.c=0D=0A@@ -1456,6 +1456,10 @@ static void process_init_reply(struct fu=
se_mount *fm, struct fuse_args *args,=0D=0A=20=0D=0A =09=09=09if (flags &=
 FUSE_REQUEST_TIMEOUT)=0D=0A =09=09=09=09timeout =3D arg->request_timeout=
;=0D=0A+=0D=0A+=09=09=09if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&=0D=0A+=09=
=09=09    flags & FUSE_DAX_FMAP)=0D=0A+=09=09=09=09fc->famfs_iomap =3D 1;=
=0D=0A =09=09} else {=0D=0A =09=09=09ra_pages =3D fc->max_read / PAGE_SIZ=
E;=0D=0A =09=09=09fc->no_lock =3D 1;=0D=0A@@ -1517,6 +1521,8 @@ static st=
ruct fuse_init_args *fuse_new_init(struct fuse_mount *fm)=0D=0A =09=09fla=
gs |=3D FUSE_SUBMOUNTS;=0D=0A =09if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))=
=0D=0A =09=09flags |=3D FUSE_PASSTHROUGH;=0D=0A+=09if (IS_ENABLED(CONFIG_=
FUSE_FAMFS_DAX))=0D=0A+=09=09flags |=3D FUSE_DAX_FMAP;=0D=0A=20=0D=0A =09=
/*=0D=0A =09 * This is just an information flag for fuse server. No need =
to check=0D=0Adiff --git a/include/uapi/linux/fuse.h b/include/uapi/linux=
/fuse.h=0D=0Aindex c13e1f9a2f12..25686f088e6a 100644=0D=0A--- a/include/u=
api/linux/fuse.h=0D=0A+++ b/include/uapi/linux/fuse.h=0D=0A@@ -240,6 +240=
,9 @@=0D=0A  *  - add FUSE_COPY_FILE_RANGE_64=0D=0A  *  - add struct fuse=
_copy_file_range_out=0D=0A  *  - add FUSE_NOTIFY_PRUNE=0D=0A+ *=0D=0A+ * =
 7.46=0D=0A+ *  - Add FUSE_DAX_FMAP capability - ability to handle in-ker=
nel fsdax maps=0D=0A  */=0D=0A=20=0D=0A #ifndef _LINUX_FUSE_H=0D=0A@@ -44=
8,6 +451,7 @@ struct fuse_file_lock {=0D=0A  * FUSE_OVER_IO_URING: Indica=
te that client supports io-uring=0D=0A  * FUSE_REQUEST_TIMEOUT: kernel su=
pports timing out requests.=0D=0A  *=09=09=09 init_out.request_timeout co=
ntains the timeout (in secs)=0D=0A+ * FUSE_DAX_FMAP: kernel supports dev_=
dax_iomap (aka famfs) fmaps=0D=0A  */=0D=0A #define FUSE_ASYNC_READ=09=09=
(1 << 0)=0D=0A #define FUSE_POSIX_LOCKS=09(1 << 1)=0D=0A@@ -495,6 +499,7 =
@@ struct fuse_file_lock {=0D=0A #define FUSE_ALLOW_IDMAP=09(1ULL << 40)=0D=
=0A #define FUSE_OVER_IO_URING=09(1ULL << 41)=0D=0A #define FUSE_REQUEST_=
TIMEOUT=09(1ULL << 42)=0D=0A+#define FUSE_DAX_FMAP=09=09(1ULL << 43)=0D=0A=
=20=0D=0A /**=0D=0A  * CUSE INIT request/reply flags=0D=0A--=20=0D=0A2.52=
=2E0=0D=0A=0D=0A

