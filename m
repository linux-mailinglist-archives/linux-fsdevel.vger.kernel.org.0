Return-Path: <linux-fsdevel+bounces-34599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9343E9C6AA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 165D5B22C83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2823418A6C4;
	Wed, 13 Nov 2024 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="P1vUpNNN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6F185955
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 08:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487033; cv=none; b=Dc7ANuloN/KW2P6Ij2P12jzWFxmuouHWRoXYEmSDGXYFvKEtQ8mu0aTTUYZJVIkIN/V6ZMfxuQEGkLP42y2RTTQcHGIIQgNQTRVEC1AruEz9FifHyQ2whaaZsW5jSCPvhT4QUgiHEbMMABnGp3Zpa90fvsdccMdiqsujkHtjMg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487033; c=relaxed/simple;
	bh=+n5mkf6ewji1xLQObaB67MBCsfFix98cW+i43x1+xBQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cqSi75/zg8T0RFhHJhOO8Nz1V20BlaETRafiswIJ+xz+a2F4RULIMS+a+9vqLJtmFyrIfKTEJSOQ4IaN8O0aj9s0mTa+Y6MJgaFjM/6M4Y9kIk80MiYqltt2WymtP8i14/OachRT7OqZzkDCHQMhvDJF9QHA7FBQgqSEE+vxV4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=P1vUpNNN; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9c+QMjucCNR1+cmEP5futdaVPW76iv6bA48yEkio5hI=;
	t=1731487032; x=1732696632; b=P1vUpNNNMcwNzz9N6ts2paQ9zcyVxtK0tnzJCqjDxQSKLcU
	dtvXBf8CGfyNxD1QjKwSRp3EpotVfy56Sb7NcESxz2bv8pVZLQjuZPMsMYHnfoKdqhLX5ZscfXyLJ
	p6yOXsqcMW6LBfWbcHtUDEm02xZR/D/8O2/AkiYV7BFFL0g2etCfQrwffg+mIl87W91WyM63vZgct
	rPvgLx53vFHXThNKeuAI3Itas8rxG7CYVF59NtfkPVI2b2BdnD6DEz8KECW9/p3kOOn8vEpN644Ee
	GpGYGpNU6iXb/I+hKm0AYryFXcDxlgcQXgeL8hZqe4Qz3TMBDpXCE5asFh+NY34g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tB8s1-00000003mOe-1rzZ;
	Wed, 13 Nov 2024 09:37:02 +0100
Message-ID: <f262fb8364037899322b63906b525b13dc4546c2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com,  ebiederm@xmission.com, kees@kernel.org,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
Date: Wed, 13 Nov 2024 09:36:58 +0100
In-Reply-To: <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	 <m2pln0f6mm.wl-thehajime@gmail.com>
	 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
	 <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

(sorry, fat-fingered that)

On Wed, 2024-11-13 at 09:36 +0100, Johannes Berg wrote:
> On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
> >=20
> > > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) &&=
 !MMU)
> > > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTE=
NSA) && !MMU)
> > > >=20
> > > > s/UML/X86/?
> > >=20
> > > I guess the fdpic loader can be used to X86, but this patchset only
> > > adds UML to be able to select it.  I intended to add UML into nommu
> > > family.
> >=20
> > While currently x86-nommu is supported for UML only, this is really
> > x86-specific. I still hope UML will get support for other architectures
> > one day, at which point a dependency on UML here will become wrong...
> >=20
>=20
> X86 isn't set for UML, X64_32 and X64_64 are though.
>=20
> Given that the no-MMU UM support even is 64-bit only, that probably
> should then really be (UML && X86_64).
>=20
> But it already has !MMU, so can't be selected otherwise, and it seems
> that non-X86 UML=20

... would require far more changes in all kinds of places, so not sure
I'd be too concerned about it here.

johannes

