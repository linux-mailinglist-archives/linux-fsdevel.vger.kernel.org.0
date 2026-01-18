Return-Path: <linux-fsdevel+bounces-74326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E46D39A8E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1579E3003483
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04F530C345;
	Sun, 18 Jan 2026 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="QNnQm2pW";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="q1BQO26v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-173.smtp-out.amazonses.com (a11-173.smtp-out.amazonses.com [54.240.11.173])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E6630E0F0;
	Sun, 18 Jan 2026 22:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775484; cv=none; b=WF6oSRweGxQnNRCVgDjEDdhGfOWRrkxUBV7h4IPQ4zZy4W2bvULym/zva/giKt6wrHkIrtwaFnsjdVbW9qL9olrDfB3dPw1gyirEqKpvB95vXF1fe8l9GiQPqX/8zNwxPT2CUmNX9Ra/2kVcuftknrTWZvwScJ+HdE+2/JKuPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775484; c=relaxed/simple;
	bh=BxCet11pPH89v/J5qkugNl3EtstX72uczW2ujDlPr78=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=EvSGjzZJs0QXV2ObrLNaaiJpU587JCuD+b06wnal/qnb6Wd7R9GGamwMxOY6FHb0DdY3Gwf2WHPchv7KlImotIiMUOaAprEkz6m+zNZny6c/2/WzR82PIYOz9kPI0TRKWU7HL0PL46hfh1xGR1AVkYdNzdG1r7IcJYlhHXFQVl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=QNnQm2pW; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=q1BQO26v; arc=none smtp.client-ip=54.240.11.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775480;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=BxCet11pPH89v/J5qkugNl3EtstX72uczW2ujDlPr78=;
	b=QNnQm2pWzYQnTN0tXn6HEwI37V+S35ABoICpQo/FreZYL9OqdCeVVD5I81jjritD
	HfSJPuuuZia2r8W1Xtrz4N7lCuul3yE2qqddEzYa/zeMWLQ/tFPmnIklT6m4dQiFmXs
	pBeK5h4wvhRQTw0RhzjAR9B+HqOG9tjsVHutHOhQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775480;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=BxCet11pPH89v/J5qkugNl3EtstX72uczW2ujDlPr78=;
	b=q1BQO26vv8/fTIHcGLHlOmjMfiVojsf5PAumYaHFfh+hzxC0MpW+uk7aHcauSjeY
	2xgYBtlUuITAHWFAefjolDuzC6XsMTCOBMfPriZO4rUhAwZbbOBxmOb548awqBDZlgG
	W0s0pCAZWJqgQUf544ob2N+B2ujuoJHLb5dy3yZo=
Subject: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
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
	=?UTF-8?Q?Jonathan_Cameron?= <jonathan.cameron@huawei.com>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:31:20 +0000
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
 <20260118223110.92320-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwlAAASWns=
Thread-Topic: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
X-Wm-Sent-Timestamp: 1768775479
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.173

From: John Groves <John@Groves.net>=0D=0A=0D=0ABoth fs/dax.c:dax_folio_pu=
t() and drivers/dax/fsdev.c:=0D=0Afsdev_clear_folio_state() (the latter c=
oming in the next commit after this=0D=0Aone) contain nearly identical co=
de to reset a compound DAX folio back to=0D=0Aorder-0 pages. Factor this =
out into a shared helper function.=0D=0A=0D=0AThe new dax_folio_reset_ord=
er() function:=0D=0A- Clears the folio's mapping and share count=0D=0A- R=
esets compound folio state via folio_reset_order()=0D=0A- Clears PageHead=
 and compound_head for each sub-page=0D=0A- Restores the pgmap pointer fo=
r each resulting order-0 folio=0D=0A- Returns the original folio order (f=
or callers that need to advance by=0D=0A  that many pages)=0D=0A=0D=0AThi=
s simplifies fsdev_clear_folio_state() from ~50 lines to ~15 lines while=0D=
=0Amaintaining the same functionality in both call sites.=0D=0A=0D=0ASugg=
ested-by: Jonathan Cameron <jonathan.cameron@huawei.com>=0D=0ASigned-off-=
by: John Groves <john@groves.net>=0D=0A---=0D=0A fs/dax.c | 60 ++++++++++=
+++++++++++++++++++++++++++++-----------------=0D=0A 1 file changed, 42 i=
nsertions(+), 18 deletions(-)=0D=0A=0D=0Adiff --git a/fs/dax.c b/fs/dax.c=
=0D=0Aindex 289e6254aa30..7d7bbfb32c41 100644=0D=0A--- a/fs/dax.c=0D=0A++=
+ b/fs/dax.c=0D=0A@@ -378,6 +378,45 @@ static void dax_folio_make_shared(=
struct folio *folio)=0D=0A =09folio->share =3D 1;=0D=0A }=0D=0A=20=0D=0A+=
/**=0D=0A+ * dax_folio_reset_order - Reset a compound DAX folio to order-=
0 pages=0D=0A+ * @folio: The folio to reset=0D=0A+ *=0D=0A+ * Splits a co=
mpound folio back into individual order-0 pages,=0D=0A+ * clearing compou=
nd state and restoring pgmap pointers.=0D=0A+ *=0D=0A+ * Returns: the ori=
ginal folio order (0 if already order-0)=0D=0A+ */=0D=0A+int dax_folio_re=
set_order(struct folio *folio)=0D=0A+{=0D=0A+=09struct dev_pagemap *pgmap=
 =3D page_pgmap(&folio->page);=0D=0A+=09int order =3D folio_order(folio);=
=0D=0A+=09int i;=0D=0A+=0D=0A+=09folio->mapping =3D NULL;=0D=0A+=09folio-=
>share =3D 0;=0D=0A+=0D=0A+=09if (!order) {=0D=0A+=09=09folio->pgmap =3D =
pgmap;=0D=0A+=09=09return 0;=0D=0A+=09}=0D=0A+=0D=0A+=09folio_reset_order=
(folio);=0D=0A+=0D=0A+=09for (i =3D 0; i < (1UL << order); i++) {=0D=0A+=09=
=09struct page *page =3D folio_page(folio, i);=0D=0A+=09=09struct folio *=
f =3D (struct folio *)page;=0D=0A+=0D=0A+=09=09ClearPageHead(page);=0D=0A=
+=09=09clear_compound_head(page);=0D=0A+=09=09f->mapping =3D NULL;=0D=0A+=
=09=09f->share =3D 0;=0D=0A+=09=09f->pgmap =3D pgmap;=0D=0A+=09}=0D=0A+=0D=
=0A+=09return order;=0D=0A+}=0D=0A+=0D=0A static inline unsigned long dax=
_folio_put(struct folio *folio)=0D=0A {=0D=0A =09unsigned long ref;=0D=0A=
@@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct fo=
lio *folio)=0D=0A =09if (ref)=0D=0A =09=09return ref;=0D=0A=20=0D=0A-=09f=
olio->mapping =3D NULL;=0D=0A-=09order =3D folio_order(folio);=0D=0A-=09i=
f (!order)=0D=0A-=09=09return 0;=0D=0A-=09folio_reset_order(folio);=0D=0A=
+=09order =3D dax_folio_reset_order(folio);=0D=0A=20=0D=0A+=09/* Debug ch=
eck: verify refcounts are zero for all sub-folios */=0D=0A =09for (i =3D =
0; i < (1UL << order); i++) {=0D=0A-=09=09struct dev_pagemap *pgmap =3D p=
age_pgmap(&folio->page);=0D=0A =09=09struct page *page =3D folio_page(fol=
io, i);=0D=0A-=09=09struct folio *new_folio =3D (struct folio *)page;=0D=0A=
=20=0D=0A-=09=09ClearPageHead(page);=0D=0A-=09=09clear_compound_head(page=
);=0D=0A-=0D=0A-=09=09new_folio->mapping =3D NULL;=0D=0A-=09=09/*=0D=0A-=09=
=09 * Reset pgmap which was over-written by=0D=0A-=09=09 * prep_compound_=
page().=0D=0A-=09=09 */=0D=0A-=09=09new_folio->pgmap =3D pgmap;=0D=0A-=09=
=09new_folio->share =3D 0;=0D=0A-=09=09WARN_ON_ONCE(folio_ref_count(new_f=
olio));=0D=0A+=09=09WARN_ON_ONCE(folio_ref_count((struct folio *)page));=0D=
=0A =09}=0D=0A=20=0D=0A =09return ref;=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A=

