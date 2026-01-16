Return-Path: <linux-fsdevel+bounces-74206-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6ACD38521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 589EF309353E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344F93A0E98;
	Fri, 16 Jan 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="RwK6zIcH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="YzuRr9Hd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-71.smtp-out.amazonses.com (a11-71.smtp-out.amazonses.com [54.240.11.71])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68436B046;
	Fri, 16 Jan 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589994; cv=none; b=K5tkKRAT9XxP9Tix5E4G8vUFMTzj8scZtm3JyRs3khqCEMwBWiN0zguc6d5An6g3Wa86jBORLSMWvGpBbmg0G3CkcFunz1xb7XBV8JwYl7focOL97IJZnrJvGyPwDmf4kZXGDIOBYCBARV2CsYQFlCqvAJuj0PoBllqR97Vcm+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589994; c=relaxed/simple;
	bh=KcyenChln9/fuCKcPBeAKf8Ht7OlJ9CjcOmXCdebCtY=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=TUOrdqo5EOd0/I9LPFY5hS0HbrYBVdH8/g++VgnN6uLNSYAo2fR/WGvBQfcFV8fqsjHAHxrIknb84FhVRlwfK0FATJn9duzJG9aao6hXxBu9ai2S7esAIzxlfw8k8hO/cRvysUBP2Enz5b0IIBIOgkrKF5sR51eZ/WJcIP1otnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=RwK6zIcH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=YzuRr9Hd; arc=none smtp.client-ip=54.240.11.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768589991;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=KcyenChln9/fuCKcPBeAKf8Ht7OlJ9CjcOmXCdebCtY=;
	b=RwK6zIcHaXZtkQbH3CzbAyBsjaoj54mTSf9g0ksHrDF7Lwjc+ZAFTrs0IhJWULre
	kF2OtXKJhEIcGeXN3DZ8jHxXBMR+bqVNRCWUhRyLk2wUoCn2Vas8skZU2ZDWuI2GPkA
	TA2ibVZmazOJAPjVpU00R+pl56zzCmRKxfxht/tE=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768589991;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=KcyenChln9/fuCKcPBeAKf8Ht7OlJ9CjcOmXCdebCtY=;
	b=YzuRr9Hddn5gJ9Usn8YtSg/v01lbHgRUv9sqBrEdJbJcUK/14RvMLAyW8HaO6q0y
	IKJ+4qBBIm0dvOKjmEcFxBhMnzU88rCwD973QTNNldy2l11kK17IuAqAw34gbMb1IR0
	K/yJg9U1Gx5guIyyqfmiPdhT3Qq3BMi7BBmiBzuE=
Subject: [PATCH V5 01/19] dax: move dax_pgoff_to_phys from [drivers/dax/]
 device.c to bus.c
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
Date: Fri, 16 Jan 2026 18:59:51 +0000
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
 <20260116185911.1005-2-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAALBCg=
Thread-Topic: [PATCH V5 01/19] dax: move dax_pgoff_to_phys from
 [drivers/dax/] device.c to bus.c
X-Wm-Sent-Timestamp: 1768589990
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc82d9f08-bf0e0ac5-c7b1-4419-9547-f3a54bb9a594-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.71

From: John Groves <john@groves.net>=0D=0A=0D=0AThis function will be used=
 by both device.c and fsdev.c, but both are=0D=0Aloadable modules. Moving=
 to bus.c puts it in core and makes it available=0D=0Ato both.=0D=0A=0D=0A=
No code changes - just relocated.=0D=0A=0D=0ASigned-off-by: John Groves <=
john@groves.net>=0D=0A---=0D=0A drivers/dax/bus.c    | 24 +++++++++++++++=
+++++++++=0D=0A drivers/dax/device.c | 23 -----------------------=0D=0A 2=
 files changed, 24 insertions(+), 23 deletions(-)=0D=0A=0D=0Adiff --git a=
/drivers/dax/bus.c b/drivers/dax/bus.c=0D=0Aindex fde29e0ad68b..a73f54eac=
567 100644=0D=0A--- a/drivers/dax/bus.c=0D=0A+++ b/drivers/dax/bus.c=0D=0A=
@@ -1417,6 +1417,30 @@ static const struct device_type dev_dax_type =3D {=
=0D=0A =09.groups =3D dax_attribute_groups,=0D=0A };=0D=0A=20=0D=0A+/* se=
e "strong" declaration in tools/testing/nvdimm/dax-dev.c */=0D=0A+__weak =
phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,=0D=0A=
+=09=09=09      unsigned long size)=0D=0A+{=0D=0A+=09int i;=0D=0A+=0D=0A+=
=09for (i =3D 0; i < dev_dax->nr_range; i++) {=0D=0A+=09=09struct dev_dax=
_range *dax_range =3D &dev_dax->ranges[i];=0D=0A+=09=09struct range *rang=
e =3D &dax_range->range;=0D=0A+=09=09unsigned long long pgoff_end;=0D=0A+=
=09=09phys_addr_t phys;=0D=0A+=0D=0A+=09=09pgoff_end =3D dax_range->pgoff=
 + PHYS_PFN(range_len(range)) - 1;=0D=0A+=09=09if (pgoff < dax_range->pgo=
ff || pgoff > pgoff_end)=0D=0A+=09=09=09continue;=0D=0A+=09=09phys =3D PF=
N_PHYS(pgoff - dax_range->pgoff) + range->start;=0D=0A+=09=09if (phys + s=
ize - 1 <=3D range->end)=0D=0A+=09=09=09return phys;=0D=0A+=09=09break;=0D=
=0A+=09}=0D=0A+=09return -1;=0D=0A+}=0D=0A+EXPORT_SYMBOL_GPL(dax_pgoff_to=
_phys);=0D=0A+=0D=0A static struct dev_dax *__devm_create_dev_dax(struct =
dev_dax_data *data)=0D=0A {=0D=0A =09struct dax_region *dax_region =3D da=
ta->dax_region;=0D=0Adiff --git a/drivers/dax/device.c b/drivers/dax/devi=
ce.c=0D=0Aindex 22999a402e02..132c1d03fd07 100644=0D=0A--- a/drivers/dax/=
device.c=0D=0A+++ b/drivers/dax/device.c=0D=0A@@ -57,29 +57,6 @@ static i=
nt check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,=0D=0A =09=
=09=09   vma->vm_file, func);=0D=0A }=0D=0A=20=0D=0A-/* see "strong" decl=
aration in tools/testing/nvdimm/dax-dev.c */=0D=0A-__weak phys_addr_t dax=
_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,=0D=0A-=09=09unsign=
ed long size)=0D=0A-{=0D=0A-=09int i;=0D=0A-=0D=0A-=09for (i =3D 0; i < d=
ev_dax->nr_range; i++) {=0D=0A-=09=09struct dev_dax_range *dax_range =3D =
&dev_dax->ranges[i];=0D=0A-=09=09struct range *range =3D &dax_range->rang=
e;=0D=0A-=09=09unsigned long long pgoff_end;=0D=0A-=09=09phys_addr_t phys=
;=0D=0A-=0D=0A-=09=09pgoff_end =3D dax_range->pgoff + PHYS_PFN(range_len(=
range)) - 1;=0D=0A-=09=09if (pgoff < dax_range->pgoff || pgoff > pgoff_en=
d)=0D=0A-=09=09=09continue;=0D=0A-=09=09phys =3D PFN_PHYS(pgoff - dax_ran=
ge->pgoff) + range->start;=0D=0A-=09=09if (phys + size - 1 <=3D range->en=
d)=0D=0A-=09=09=09return phys;=0D=0A-=09=09break;=0D=0A-=09}=0D=0A-=09ret=
urn -1;=0D=0A-}=0D=0A-=0D=0A static void dax_set_mapping(struct vm_fault =
*vmf, unsigned long pfn,=0D=0A =09=09=09      unsigned long fault_size)=0D=
=0A {=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

