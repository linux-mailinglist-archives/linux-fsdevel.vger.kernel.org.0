Return-Path: <linux-fsdevel+bounces-74223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF44D38583
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1B7D318A51F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7C13A0E8A;
	Fri, 16 Jan 2026 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="Zp/cMApc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="oQtwxDwl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-131.smtp-out.amazonses.com (a11-131.smtp-out.amazonses.com [54.240.11.131])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583AE2FC037;
	Fri, 16 Jan 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590541; cv=none; b=lx6U/kSu8A9S38Iqv9ZyZk/WqDBAZJxZgfzc6tvoebV7eoRE3e5kne6vYe8oN1DtFQ92CwpqwrPo9KnEQNGUj4CAJUVRefZ+8jW1zvrFQTzNP3nUScqdKL0qKIjZZh6aHxihG6+sRyZj0C45YoYLdd8wjtlnnWwqa30Ds99OmnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590541; c=relaxed/simple;
	bh=3btkgLOiD4Z3UmOAEca8Kmka5701UXn2uWsse5/Uqw4=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=JBX5rYoXCYhyqpAFumOYgRilDxKgt2Pfupn0aXRg4URFnap6p0jwpCbNyTj4xF+5yJsXJxHw47dOoKsuCtfPdQ+XdLxXEmTZ3kG5Tj6X5Gpap8M7vaHJF6KBHCVF1t/km7GOAwgQbqYmDtimHSFS3hBb/v14cv6po0XxO/lut8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=Zp/cMApc; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=oQtwxDwl; arc=none smtp.client-ip=54.240.11.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590538;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=3btkgLOiD4Z3UmOAEca8Kmka5701UXn2uWsse5/Uqw4=;
	b=Zp/cMApcGuj39NaFlLD9v/w81oImbrobj8MlroUaymBRETZa9TnFu6qM213dkMVt
	GYOCn/rQoztFYRTZDqS4ZKprC5kxNZHkYL8j414fJui0/eOfMeIrcb8q7yptVfSKbRK
	zKN+Epj4bpcYuRIMwv0oFPpYl6y2Q/+wr8utuTgk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590538;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=3btkgLOiD4Z3UmOAEca8Kmka5701UXn2uWsse5/Uqw4=;
	b=oQtwxDwlczBV0EZIULf6eln5hOiF5Fj7mb1KL+z9JJPBqdgDEYAJIg+gpa2SMy0o
	9jfnVktxtmpLkhQSZ4WByGkUE2jwQEAGILAgd6fLBcVmUhF1KIN+eXwqwYCe+5TxRUO
	cfyolGZBeyH8yjACYZLqwv6ZppZCyevP/cdwqbRE=
Subject: [PATCH V5 17/19] famfs_fuse: Add DAX address_space_operations with
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 19:08:58 +0000
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
 <20260116185911.1005-18-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAABcg8c=
Thread-Topic: [PATCH V5 17/19] famfs_fuse: Add DAX address_space_operations
 with noop_dirty_folio
X-Wm-Sent-Timestamp: 1768590537
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc835f5e2-fd75b329-1210-4649-be51-8031bf9ecf07-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.131

From: John Groves <John@Groves.net>=0D=0A=0D=0AFamfs is memory-backed; th=
ere is no place to write back to, and no=0D=0Areason to mark pages dirty =
at all.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=0A---=0D=
=0A fs/fuse/famfs.c | 11 +++++++++++=0D=0A 1 file changed, 11 insertions(=
+)=0D=0A=0D=0Adiff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c=0D=0Aindex e=
e3526175b6b..f98e358ea489 100644=0D=0A--- a/fs/fuse/famfs.c=0D=0A+++ b/fs=
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
****************/=0D=0A=20=0D=0A /*=0D=0A@@ -625,6 +635,7 @@ famfs_file_i=
nit_dax(=0D=0A =09=09}=0D=0A =09=09i_size_write(inode, meta->file_size);=0D=
=0A =09=09inode->i_flags |=3D S_DAX;=0D=0A+=09=09inode->i_data.a_ops =3D =
&famfs_dax_aops;=0D=0A =09}=0D=0A  unlock_out:=0D=0A =09inode_unlock(inod=
e);=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

