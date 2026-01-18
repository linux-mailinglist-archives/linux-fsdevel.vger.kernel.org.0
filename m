Return-Path: <linux-fsdevel+bounces-74342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580E7D39AD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0906F301004B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655BB30EF83;
	Sun, 18 Jan 2026 22:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="LPH+Sz8O";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="bR1GhHMY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-122.smtp-out.amazonses.com (a11-122.smtp-out.amazonses.com [54.240.11.122])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066829E114;
	Sun, 18 Jan 2026 22:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775661; cv=none; b=hlUepHmkf8ROB++BfbinZeyccBLBytR1uGyLG4ErDEl4Je5IIDGR+jXaEuiLYwlfPkx+F2OgzRI+tjru7Le5Ru4xM1WkvrTWEFGPXi9qGp8JfUWGCZpmb2xs9axnu6qBFcyfBaLKRNUyQTPC9SO42rhAWBQiJ5/BD3ru25QEOTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775661; c=relaxed/simple;
	bh=YRGFsJnyxdmTr12v27dnqv3BRWIpNMemeiBnTXYKI4o=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=ohP++soiYXS2ukgIp16baKmCXH4JnqyG+aEUqSBSrJjaEj/+0M+GqmHFhIXLlwKcQVop+p0bzhVOsZXxd8/8CFNevz23AZ5EzekCSFbbOsYbw+N5HJVGjvL1S1+pTZKRETGuATuxcpxxGSOD6KrTVH28VT3hKouvv0kwpKU5is8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=LPH+Sz8O; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=bR1GhHMY; arc=none smtp.client-ip=54.240.11.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775658;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=YRGFsJnyxdmTr12v27dnqv3BRWIpNMemeiBnTXYKI4o=;
	b=LPH+Sz8OFq0b4KyVp+K0hpaM62PS7rnxjm3KMUVJ7MUmvHatwDb+M+DjoJNWJNKP
	CJYL+uKhnzHV2ywCG0qkVscmwBfprwbUpA5R9gWrR3cLwbk08fmUm94CGZ7joC7IAYv
	32qrd+MRJVPcMnlPXaJqR0Z+kxRkB6wxLOe2Tx4g=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775658;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=YRGFsJnyxdmTr12v27dnqv3BRWIpNMemeiBnTXYKI4o=;
	b=bR1GhHMYsDNqKjtTsC1MIxCgH5ZZc8QlfihKYiX3hNAivCRzbiu2fdaJ6MjNThHG
	eAuVHWNA4hEWgiDzONEFoNfC/9btrRKxwD2dbvlrcjbbztxHhPz5Cq0wNv6npjYhx84
	NNFveHLDRLOg/o1kxQ4yx/6Jc0gPwd3od8w48tQY=
Subject: [PATCH V7 18/19] famfs_fuse: Add famfs fmap metadata documentation
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
Date: Sun, 18 Jan 2026 22:34:18 +0000
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
 <20260118223409.92668-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAszXk=
Thread-Topic: [PATCH V7 18/19] famfs_fuse: Add famfs fmap metadata
 documentation
X-Wm-Sent-Timestamp: 1768775657
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33eab0d-e982dfea-fdc0-4f02-b60f-9d4897fdcb7d-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.122

From: John Groves <John@Groves.net>=0D=0A=0D=0AThis describes the fmap me=
tadata - both simple and interleaved=0D=0A=0D=0ASigned-off-by: John Grove=
s <john@groves.net>=0D=0A---=0D=0A fs/fuse/famfs_kfmap.h | 73 +++++++++++=
++++++++++++++++++++++++++++++++=0D=0A 1 file changed, 73 insertions(+)=0D=
=0A=0D=0Adiff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h=0D=0A=
index 0fff841f5a9e..970ad802b492 100644=0D=0A--- a/fs/fuse/famfs_kfmap.h=0D=
=0A+++ b/fs/fuse/famfs_kfmap.h=0D=0A@@ -7,6 +7,79 @@=0D=0A #ifndef FAMFS_=
KFMAP_H=0D=0A #define FAMFS_KFMAP_H=0D=0A=20=0D=0A+/* KABI version 43 (ak=
a v2) fmap structures=0D=0A+ *=0D=0A+ * The location of the memory backin=
g for a famfs file is described by=0D=0A+ * the response to the GET_FMAP =
fuse message (defined in=0D=0A+ * include/uapi/linux/fuse.h=0D=0A+ *=0D=0A=
+ * There are currently two extent formats: Simple and Interleaved.=0D=0A=
+ *=0D=0A+ * Simple extents are just (devindex, offset, length) tuples, w=
here devindex=0D=0A+ * references a devdax device that must be retrievabl=
e via the GET_DAXDEV=0D=0A+ * message/response.=0D=0A+ *=0D=0A+ * The ext=
ent list size must be >=3D file_size.=0D=0A+ *=0D=0A+ * Interleaved exten=
ts merit some additional explanation. Interleaved=0D=0A+ * extents stripe=
 data across a collection of strips. Each strip is a=0D=0A+ * contiguous =
allocation from a single devdax device - and is described by=0D=0A+ * a s=
imple_extent structure.=0D=0A+ *=0D=0A+ * Interleaved_extent example:=0D=0A=
+ *   ie_nstrips =3D 4=0D=0A+ *   ie_chunk_size =3D 2MiB=0D=0A+ *   ie_nb=
ytes =3D 24MiB=0D=0A+ *=0D=0A+ * =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=90=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=90=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90=0D=0A+ * =E2=
=94=82Chunk =3D 0   =E2=94=82Chunk =3D 1   =E2=94=82Chunk =3D 2   =E2=94=82=
Chunk =3D 3   =E2=94=82=0D=0A+ * =E2=94=82Strip =3D 0   =E2=94=82Strip =3D=
 1   =E2=94=82Strip =3D 2   =E2=94=82Strip =3D 3   =E2=94=82=0D=0A+ * =E2=
=94=82Stripe =3D 0  =E2=94=82Stripe =3D 0  =E2=94=82Stripe =3D 0  =E2=94=82=
Stripe =3D 0  =E2=94=82=0D=0A+ * =E2=94=82            =E2=94=82          =
  =E2=94=82            =E2=94=82            =E2=94=82=0D=0A+ * =E2=94=94=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=98=0D=0A+ * =E2=94=82Chunk =3D 4   =E2=94=82Chunk =3D 5   =E2=
=94=82Chunk =3D 6   =E2=94=82Chunk =3D 7   =E2=94=82=0D=0A+ * =E2=94=82St=
rip =3D 0   =E2=94=82Strip =3D 1   =E2=94=82Strip =3D 2   =E2=94=82Strip =
=3D 3   =E2=94=82=0D=0A+ * =E2=94=82Stripe =3D 1  =E2=94=82Stripe =3D 1  =
=E2=94=82Stripe =3D 1  =E2=94=82Stripe =3D 1  =E2=94=82=0D=0A+ * =E2=94=82=
            =E2=94=82            =E2=94=82            =E2=94=82          =
  =E2=94=82=0D=0A+ * =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=0D=0A+ * =E2=94=82Chunk =
=3D 8   =E2=94=82Chunk =3D 9   =E2=94=82Chunk =3D 10  =E2=94=82Chunk =3D =
11  =E2=94=82=0D=0A+ * =E2=94=82Strip =3D 0   =E2=94=82Strip =3D 1   =E2=94=
=82Strip =3D 2   =E2=94=82Strip =3D 3   =E2=94=82=0D=0A+ * =E2=94=82Strip=
e =3D 2  =E2=94=82Stripe =3D 2  =E2=94=82Stripe =3D 2  =E2=94=82Stripe =3D=
 2  =E2=94=82=0D=0A+ * =E2=94=82            =E2=94=82            =E2=94=82=
            =E2=94=82            =E2=94=82=0D=0A+ * =E2=94=94=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=98=0D=0A+ *=0D=0A+ * * Data is laid out across chunks in chunk # orde=
r=0D=0A+ * * Columns are strips=0D=0A+ * * Strips are contiguous devdax e=
xtents, normally each coming from a=0D=0A+ *   different memory device=0D=
=0A+ * * Rows are stripes=0D=0A+ * * The number of chunks is (int)((file_=
size + chunk_size - 1) / chunk_size)=0D=0A+ *   (and obviously the last c=
hunk could be partial)=0D=0A+ * * The stripe_size =3D (nstrips * chunk_si=
ze)=0D=0A+ * * chunk_num(offset) =3D offset / chunk_size    //integer div=
ision=0D=0A+ * * strip_num(offset) =3D chunk_num(offset) % nchunks=0D=0A+=
 * * stripe_num(offset) =3D offset / stripe_size  //integer division=0D=0A=
+ * * ...You get the idea - see the code for more details...=0D=0A+ *=0D=0A=
+ * Some concrete examples from the layout above:=0D=0A+ * * Offset 0 in =
the file is offset 0 in chunk 0, which is offset 0 in=0D=0A+ *   strip 0=0D=
=0A+ * * Offset 4MiB in the file is offset 0 in chunk 2, which is offset =
0 in=0D=0A+ *   strip 2=0D=0A+ * * Offset 15MiB in the file is offset 1Mi=
B in chunk 7, which is offset=0D=0A+ *   3MiB in strip 3=0D=0A+ *=0D=0A+ =
* Notes about this metadata format:=0D=0A+ *=0D=0A+ * * For various reaso=
ns, chunk_size must be a multiple of the applicable=0D=0A+ *   PAGE_SIZE=0D=
=0A+ * * Since chunk_size and nstrips are constant within an interleaved_=
extent,=0D=0A+ *   resolving a file offset to a strip offset within a sin=
gle=0D=0A+ *   interleaved_ext is order 1.=0D=0A+ * * If nstrips=3D=3D1, =
a list of interleaved_ext structures degenerates to a=0D=0A+ *   regular =
extent list (albeit with some wasted struct space).=0D=0A+ */=0D=0A+=0D=0A=
 /*=0D=0A  * The structures below are the in-memory metadata format for f=
amfs files.=0D=0A  * Metadata retrieved via the GET_FMAP response is conv=
erted to this format=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

