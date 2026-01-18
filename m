Return-Path: <linux-fsdevel+bounces-74341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5E0D39ACF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6C17301AB24
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD42C310782;
	Sun, 18 Jan 2026 22:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="YE2zk8EE";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="DJf53HV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a10-70.smtp-out.amazonses.com (a10-70.smtp-out.amazonses.com [54.240.10.70])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B271730FF3A;
	Sun, 18 Jan 2026 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.10.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775635; cv=none; b=S8yKjw3XW7pTS1Q1FohArvhuYUYYgpQIFxDN4cw4vX4QYroDYBch+7hNWb/iZSHXNaS6Eb12pTKsI+GDscxaoenXglrBA9jlv8xNN3Ok020aH9tWVHOpuePwKYHy+tesaL355CDGcXUhtSkcjNIaJJBsEz00OmBnssJ/K3x3PCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775635; c=relaxed/simple;
	bh=ySpgkpgRt+qLan6FpCdY27RlOBhHRiGz4zqME5nBEtw=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=rXEp+5nyG1UX3wTLIEJ45qu/HaKN+BrekfRflbW+3JvpsNk07HLu8Y6PPX4vY7mH3CQcaaL4fwFGwxHNFK7Wzdkhqa9hvoWOMgOKIAGggufL5SUf4/9msXdpdr+4xxGj26z8FfxLqqAP5jRhzzKj+9Hy3dyD9Xksh0+EiK415kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=YE2zk8EE; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=DJf53HV3; arc=none smtp.client-ip=54.240.10.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775632;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=ySpgkpgRt+qLan6FpCdY27RlOBhHRiGz4zqME5nBEtw=;
	b=YE2zk8EEK83a75xy3T1iTVlMwDK16PtwkORLus+j61RjVe8eH/rhzQ8zLjiFVWe4
	vwOeplepvk2oNq+Nx+YWxJUNDN067rZ/z6X2DjIC8/XIy/cIx87hKXc6uxgD98jLHkj
	iCi4eT8a5MTafr6Byky2nwJNk0JqnImZVcnmUWmo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775632;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=ySpgkpgRt+qLan6FpCdY27RlOBhHRiGz4zqME5nBEtw=;
	b=DJf53HV30yNl+zHc11x6tzrlCKH49ZpnHk9zkPb5TFJ+XBJRR/0/c8QUTOWca5IH
	hEgTAf2QEE6gjxFQ7Yn8YoFMKk1xLSkfe6KtDgfTdGjHUqAyiNqQ5kDbY/jEwASSWYu
	PAq+bu56AXOE4IT4y5Enlmr8kDwmLmg3DYiUKwdU=
Subject: [PATCH V7 17/19] famfs_fuse: Add DAX address_space_operations with
 noop_dirty_folio
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
Date: Sun, 18 Jan 2026 22:33:51 +0000
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
 <20260118223344.92651-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAAo2KI=
Thread-Topic: [PATCH V7 17/19] famfs_fuse: Add DAX address_space_operations
 with noop_dirty_folio
X-Wm-Sent-Timestamp: 1768775630
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33e43bf-bb49e98f-284c-475b-a027-13c7271f67bf-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.10.70

From: John Groves <John@Groves.net>=0D=0A=0D=0AFamfs is memory-backed; th=
ere is no place to write back to, and no=0D=0Areason to mark pages dirty =
at all.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=
=0A fs/fuse/famfs.c | 11 +++++++++++=0D=0A 1 file changed, 11 insertions(=
+)=0D=0A=0D=0Adiff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c=0D=0Aindex b=
38e92d8f381..90325bd14354 100644=0D=0A--- a/fs/fuse/famfs.c=0D=0A+++ b/fs=
/fuse/famfs.c=0D=0A@@ -14,6 +14,7 @@=0D=0A #include <linux/mm.h>=0D=0A #i=
nclude <linux/dax.h>=0D=0A #include <linux/iomap.h>=0D=0A+#include <linux=
/pagemap.h>=0D=0A #include <linux/path.h>=0D=0A #include <linux/namei.h>=0D=
=0A #include <linux/string.h>=0D=0A@@ -39,6 +40,15 @@ static const struct=
 dax_holder_operations famfs_fuse_dax_holder_ops =3D {=0D=0A =09.notify_f=
ailure=09=09=3D famfs_dax_notify_failure,=0D=0A };=0D=0A=20=0D=0A+/*=0D=0A=
+ * DAX address_space_operations for famfs.=0D=0A+ * famfs doesn't need d=
irty tracking - writes go directly to=0D=0A+ * memory with no writeback r=
equired.=0D=0A+ */=0D=0A+static const struct address_space_operations fam=
fs_dax_aops =3D {=0D=0A+=09.dirty_folio=09=3D noop_dirty_folio,=0D=0A+};=0D=
=0A+=0D=0A /*************************************************************=
****************/=0D=0A=20=0D=0A /*=0D=0A@@ -627,6 +637,7 @@ famfs_file_i=
nit_dax(=0D=0A =09if (famfs_meta_set(fi, meta) =3D=3D NULL) {=0D=0A =09=09=
i_size_write(inode, meta->file_size);=0D=0A =09=09inode->i_flags |=3D S_D=
AX;=0D=0A+=09=09inode->i_data.a_ops =3D &famfs_dax_aops;=0D=0A =09} else =
{=0D=0A =09=09pr_debug("%s: file already had metadata\n", __func__);=0D=0A=
 =09=09__famfs_meta_free(meta);=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

