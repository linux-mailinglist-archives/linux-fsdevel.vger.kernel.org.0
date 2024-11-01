Return-Path: <linux-fsdevel+bounces-33506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BEF9B9ADF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 23:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F310F1F222F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A261E7678;
	Fri,  1 Nov 2024 22:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEhrLwqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFA156C72;
	Fri,  1 Nov 2024 22:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730500763; cv=none; b=aSPBla3LBiCUnCmNsYqneMTQggvYEtWSSyhuNJ8ns8UiRdDEP0YbraMKdmCGD27YoplBReAPlh5LwuIoAOS5J+AkHs9Z5G3gGV7N+Ar9lnuSd6RQeVW7N+xGkkvRIitYu7plNNAKlxvZiZKdZvSVqlubPuvtGfE5Hx6C2NV5cPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730500763; c=relaxed/simple;
	bh=JkmskpWLroWyTPtf1p/0xaay+Zwr1MUY5lzV+zGUd1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE7/IZVlx4yRuFrmPQCWRQquTkmZ4oL8PAn/ItY4niaHc4wQ9yP8EjwYqYv4bS8OcRbFOIUL96YLbMCPWWoXjMROoZ6cUa3ets6oyhTSsHe3iiu7zkQmJL5YL3agu7f+8VFItkhnJFQSdFusORNMjsL93B7Ighuos4FZzvFccsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEhrLwqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072F5C4CECD;
	Fri,  1 Nov 2024 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730500762;
	bh=JkmskpWLroWyTPtf1p/0xaay+Zwr1MUY5lzV+zGUd1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEhrLwqByhfLvAU785JeArYUuInGTqkBsGV3r3plSQ8zSbQAV6fT+ET7wqEU5o5VA
	 ct7o/GLXp2+/PbBbP1QN334NceDAeGev8dTIyBaNpZxzb6p0AY8Znr3vdNOeI/f1LS
	 Oz+QIM7HGR+hvpLC20DDRetymBXJYfjj9VRTn08bKEm2t1Lp6PcPDnGni1/dN9RbXN
	 p7KckOVoTXBme68zzAN3mCqqDK4u2art9j+inl0K6gITEYx7xgvFhacdYnCRnIbsBt
	 biEVrtmlNKtzEwdNtS8V93i5t980S16YKJxmXvG9T5lwJBZeTTueW1wQdfH3d51/xM
	 meKMFv06sf29g==
Date: Fri, 1 Nov 2024 22:39:15 +0000
From: Mark Brown <broonie@kernel.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "debug@rivosinc.com" <debug@rivosinc.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "arnd@arndb.de" <arnd@arndb.de>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC/RFT v2 2/2] kernel: converge common shadow stack flow
 agnostic to arch
Message-ID: <7f392b4e-9970-42d4-8204-2aa967a5375d@sirena.org.uk>
References: <20241016-shstk_converge-v2-0-c41536eb5c3b@rivosinc.com>
 <20241016-shstk_converge-v2-2-c41536eb5c3b@rivosinc.com>
 <7109dfcc6df5a610dcfe35a77bb7a84f8932485b.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H7fCiCztkNSvBJxu"
Content-Disposition: inline
In-Reply-To: <7109dfcc6df5a610dcfe35a77bb7a84f8932485b.camel@intel.com>
X-Cookie: We read to say that we have read.


--H7fCiCztkNSvBJxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2024 at 09:50:27PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-10-16 at 14:57 -0700, Deepak Gupta wrote:

> > - * The maximum distance INCSSP can move the SSP is 2040 bytes, before
> > - * it would read the memory. Therefore a single page gap will be enough
> > - * to prevent any operation from shifting the SSP to an adjacent stack,
> > - * since it would have to land in the gap at least once, causing a
> > - * fault.

> I want to take a deeper look at this series once I can apply and test it, but
> can we maybe make this comment more generic and keep it? I think it is similar
> reasoning for arm (?), is there anything situation like this for risc-v? Or
> rather, why does risc-v have the guard gaps?

Yes, for arm64 you can only move the pointer in single frames so a
single page is enough.

--H7fCiCztkNSvBJxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmclWJIACgkQJNaLcl1U
h9BbbAf/YCyway5BCg6C3KzepN1gz5b37UP2Bq3e+NcpcYbuR6W4n/objROMTtBc
nsknhZwTf6tIRzlmJyJPi4i0IEVsBXMgH7oe77yvZ2z2Cgw7ZUteK3gGiYV3Z/Si
XYIheFf3VcavqebwBiuSkBicYRUmpDtw41KHXjjh51KKCAM7j/fYp+ZCxJsvZINl
VruJKtOVl/tyQ+BzFtRlWP/HJ8V3Lyc3bpHM7AMvAihfuOPKFgj/XGi591VRumor
jil6i2Q2KioyFq7NMIWn40QQn5ewJNrNyvK2JK3Jj/Uf8EcQIsNlhPVUFSGMt34c
MYRZ/U8CCx/7KkbjeOjuelYwP+ayMQ==
=h97G
-----END PGP SIGNATURE-----

--H7fCiCztkNSvBJxu--

