Return-Path: <linux-fsdevel+bounces-74213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024DCD3854C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D7B53074019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25A9348479;
	Fri, 16 Jan 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="hLOXHYQH";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jyzG7539"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-132.smtp-out.amazonses.com (a11-132.smtp-out.amazonses.com [54.240.11.132])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB89A92E;
	Fri, 16 Jan 2026 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768590232; cv=none; b=FfWyjHQ+90V4QsOh4dze8zFCGnE34Jw/OKHMX5iTQJNG5n0MxdmGsxMzTbx+Xi+ehZ30gH6y+5LcA2MnL0UhuA5KoXcf0Ga/ziVM83iQp+Z679ZYTWMgEGH4aFHFuGFZuaOnGR8C4oYUmuMSz03Tfb3g7AYpdGtAgLeON+doj/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768590232; c=relaxed/simple;
	bh=g29XoRu1KtFXVlm54ZglPWVGBdayg5rwEE7d/Ie6Hl0=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=DdwyXn713q7uR6fHq2u14usp7rtwWaz20Y4dr71/TFhXsRWOsc4kY9fAm/tcXcpbxY86xzrDTbER6rCv84qWY4P7Du6AEE9l4ZVl/+IEdz8MA5uLOl03DzJtJsjd3UmefPuD+xuETyN5ROBE7fDxeMX5NZXYu0ceHFumDEqoMT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=hLOXHYQH; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=jyzG7539; arc=none smtp.client-ip=54.240.11.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768590230;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=g29XoRu1KtFXVlm54ZglPWVGBdayg5rwEE7d/Ie6Hl0=;
	b=hLOXHYQHt0DWGuEmyUfExlP2TNPznvFprtrGkiVCB42QQhhkI3/cYiyc/2qiJ52a
	Fmc5dlq6tQwjRcEUmHNDJuPhHW8l37MnmAqeB3HhHQsQ0/vK9BFTMJaq0upezIMcqE+
	QvVXl7Vom8nJ1qyzTTKo4X0ZPJhJgsE6F8vu1v90=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768590230;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=g29XoRu1KtFXVlm54ZglPWVGBdayg5rwEE7d/Ie6Hl0=;
	b=jyzG7539crGZz4UUBoqqXCSem+SHD7X1EetO74zu2gXPdEUuGIX2cbwbXI3G2F9J
	Iftwb4nJXjlb2PbtTUvX8ZTC4wPrI7xZKqTA81tbrgn5yKo273s7uBhpfb2U+cLoukV
	iknXfOBuczOMi2KUZrUmW98QcaRIjhNa4fchPaA0=
Subject: [PATCH V5 08/19] dax: export dax_dev_get()
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
Date: Fri, 16 Jan 2026 19:03:49 +0000
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
 <20260116185911.1005-9-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAAukUo=
Thread-Topic: [PATCH V5 08/19] dax: export dax_dev_get()
X-Wm-Sent-Timestamp: 1768590228
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc83141c8-456ef04c-7071-4f4f-b513-17ea25c4e547-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.132

From: John Groves <john@groves.net>=0D=0A=0D=0Afamfs needs to look up a d=
ax_device by dev_t when resolving fmap=0D=0Aentries that reference charac=
ter dax devices.=0D=0A=0D=0ASigned-off-by: John Groves <john@groves.net>=0D=
=0A---=0D=0A drivers/dax/super.c | 3 ++-=0D=0A include/linux/dax.h | 1 +=0D=
=0A 2 files changed, 3 insertions(+), 1 deletion(-)=0D=0A=0D=0Adiff --git=
 a/drivers/dax/super.c b/drivers/dax/super.c=0D=0Aindex 00c330ef437c..d09=
7561d78db 100644=0D=0A--- a/drivers/dax/super.c=0D=0A+++ b/drivers/dax/su=
per.c=0D=0A@@ -513,7 +513,7 @@ static int dax_set(struct inode *inode, vo=
id *data)=0D=0A =09return 0;=0D=0A }=0D=0A=20=0D=0A-static struct dax_dev=
ice *dax_dev_get(dev_t devt)=0D=0A+struct dax_device *dax_dev_get(dev_t d=
evt)=0D=0A {=0D=0A =09struct dax_device *dax_dev;=0D=0A =09struct inode *=
inode;=0D=0A@@ -536,6 +536,7 @@ static struct dax_device *dax_dev_get(dev=
_t devt)=0D=0A=20=0D=0A =09return dax_dev;=0D=0A }=0D=0A+EXPORT_SYMBOL_GP=
L(dax_dev_get);=0D=0A=20=0D=0A struct dax_device *alloc_dax(void *private=
, const struct dax_operations *ops)=0D=0A {=0D=0Adiff --git a/include/lin=
ux/dax.h b/include/linux/dax.h=0D=0Aindex 6897c5736543..1ef9b03f9671 1006=
44=0D=0A--- a/include/linux/dax.h=0D=0A+++ b/include/linux/dax.h=0D=0A@@ =
-55,6 +55,7 @@ struct dax_device *alloc_dax(void *private, const struct d=
ax_operations *ops);=0D=0A void *dax_holder(struct dax_device *dax_dev);=0D=
=0A void put_dax(struct dax_device *dax_dev);=0D=0A void kill_dax(struct =
dax_device *dax_dev);=0D=0A+struct dax_device *dax_dev_get(dev_t devt);=0D=
=0A void dax_write_cache(struct dax_device *dax_dev, bool wc);=0D=0A bool=
 dax_write_cache_enabled(struct dax_device *dax_dev);=0D=0A bool dax_sync=
hronous(struct dax_device *dax_dev);=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

