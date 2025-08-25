Return-Path: <linux-fsdevel+bounces-58993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EE0B33C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342F618873BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 10:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464C72D8DCE;
	Mon, 25 Aug 2025 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b="f276yTAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx08-006a4e02.pphosted.com (mx08-006a4e02.pphosted.com [143.55.148.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703022C0F84;
	Mon, 25 Aug 2025 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.148.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117222; cv=none; b=dIrcBxPpZXkFViYJ9/Sl6H7pSZ2l0ehuWFLjQaDDb+9gUdYRvKzwr9SE5QAWbcaaRGUdMNpNm16N6fY/5jOcya9XmyVF5fuSOC6S2t4rz0OWHaGA8987p3k1fXjN6gxO8pDc2shKtGBGF81XTikgb0T23QiwW8zwEEbZ+rTv50U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117222; c=relaxed/simple;
	bh=EOYa/83/mPvbS46RIHex0d0IdkRkDgz6A9nE8p9HOOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OK1fMOlEagTLv6pD8FVPjXchuxedMS3GIDct4D/KHC0sqND/60gKs+ouShJJwJ/+FYKED77cFWdwIXzPsRyGgH9CVAPdtfHuQocPCtCFx8FYHW4Hea/QI7owg9dqLHYrBCd9VSvgCoy4bgnePw4fUeaswg9lyE1OfticgEf+5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es; spf=pass smtp.mailfrom=iram.es; dkim=pass (2048-bit key) header.d=iram.es header.i=@iram.es header.b=f276yTAV; arc=none smtp.client-ip=143.55.148.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iram.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iram.es
Received: from pps.filterd (m0316694.ppops.net [127.0.0.1])
	by m0316694.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 57P6PW3W020069;
	Mon, 25 Aug 2025 12:18:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iram.es; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dkim3; bh=D2RQ
	QU+xVYCIYE9iCJ4jbQxYZO59NkcR2A8V0GUG+Mo=; b=f276yTAVV1SD26/ulkZ2
	ssJY8XTewysYT4tMLHnjnSIBPzgblP8WuCw3pnh/XAa52lQyDLxmxShvX17t1EXs
	AoQda248LCfIMXON/nZwXpeu4+MTA43njmbgfGliPSIcYHT6eGt5tvWcsz+Ebm8/
	4lIyyZv8wrgSbUY90OllDWqU/MTlR6SEhvM2DfGVcewE1Kv7qk7AtlaNhqjqabwW
	IOCDoLYjGRp5sJ9N4qvDQOAd9gPixccJfFHXTLWq+WrJuREyVW1zYVGsiH/zFMSl
	OAyS7jVvPh7W7XrmyRecvqRovk6Azt/V4iwX6CHVY52rTnzQCWQmiOXOKm2ygevf
	nw==
Received: from sim.rediris.es (mta-out04.sim.rediris.es [130.206.24.46])
	by m0316694.ppops.net (PPS) with ESMTPS id 48qs26hbtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Aug 2025 12:18:43 +0200 (MEST)
Received: from sim.rediris.es (localhost.localdomain [127.0.0.1])
	by sim.rediris.es (Postfix) with ESMTPS id 26F1D181FAE;
	Mon, 25 Aug 2025 12:18:42 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by sim.rediris.es (Postfix) with ESMTP id 00B66181FAC;
	Mon, 25 Aug 2025 12:18:41 +0200 (CEST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
 mta-out04.sim.rediris.es
Received: from sim.rediris.es ([127.0.0.1])
 by localhost (mta-out04.sim.rediris.es [127.0.0.1]) (amavis, port 10026)
 with ESMTP id T0a5k0mKOE42; Mon, 25 Aug 2025 12:18:41 +0200 (CEST)
Received: from lt-gp.iram.es (haproxy02.sim.rediris.es [130.206.24.70])
	by sim.rediris.es (Postfix) with ESMTPA id 4570418007C;
	Mon, 25 Aug 2025 12:18:40 +0200 (CEST)
Date: Mon, 25 Aug 2025 12:18:38 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Laight <david.laight.linux@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 10/10] powerpc/uaccess: Implement masked user access
Message-ID: <aKw4frSacjCoruSJ@lt-gp.iram.es>
References: <cover.1755854833.git.christophe.leroy@csgroup.eu>
 <647f1b1db985aec8ec1163bf97688563ae6f9609.1755854833.git.christophe.leroy@csgroup.eu>
 <aKwnMo7UllLZkOcK@lt-gp.iram.es>
 <16679d56-5ee0-469d-a11c-475a45a1c2b9@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16679d56-5ee0-469d-a11c-475a45a1c2b9@csgroup.eu>
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDAxMSBTYWx0ZWRfXyQKmoH9DesXw
 ky5qpDKRbPVEO1j5P6RR/dl92Vu5gG46S+qU0RD2h9TCpiV9lxYjE4Rf4eAAbziJN1WFf5iKIoL
 vwHyFf4hVFUMvanQ6xRm7ygYHGMCvWURJrObfA0zrkO/dAoKD6EpbGdosihHgY3UjjtywmHeIhh
 zadbuk6ri8Bjd//t+fuudKJvFfCA6JbBQ9N+HL1oXH8gyaqcVqF4z95oY0uvqMW92ZBVK+g2n6Z
 F5336k0OeSJ784mGbOt0xTivvX2ToRO8PW2UCuoqsfP7MIu8uTDDGoglgFl+oLkNRfmAFLuzTMV
 j3inHZqHmiMrvZjyNxDRXcurMFxlSzfQPLVCuFgRq2ZkLrTZLm79a044/SvNKtbKXHZ8D77pt49
 kvezQV2k
X-Proofpoint-GUID: gpjt9l5GPC7skcU5Z664_moW2gPMxUzU
X-Authority-Analysis: v=2.4 cv=GqFC+l1C c=1 sm=1 tr=0 ts=68ac3883 cx=c_pps
 a=Kke4r4mcy+kRAsMtzpf9hg==:117 a=Kke4r4mcy+kRAsMtzpf9hg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=_EeEMxcBAAAA:8 a=LQ9UBoVtz5yYhqZLJvEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gpjt9l5GPC7skcU5Z664_moW2gPMxUzU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=salida_notspam policy=salida score=0
 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508240011

On Mon, Aug 25, 2025 at 11:40:48AM +0200, Christophe Leroy wrote:
> Hi Gabriel,
>=20
> Le 25/08/2025 =C3=A0 11:04, Gabriel Paubert a =C3=A9crit=C2=A0:
> > [Vous ne recevez pas souvent de courriers de paubert@iram.es. D?couvr=
ez pourquoi ceci est important ? https://urldefense.com/v3/__https://aka.=
ms/LearnAboutSenderIdentification__;!!D9dNQwwGXtA!QUcSIXoDBBj9wAtcyQ-z3nP=
EAj-RnJpPgYwjOeb6LZWLejdLzq4uYsPMecQuK5Qy3147APjCNc-hcXGT71XuBh1AJI2M$  ]
> >=20
> > Hi Christophe,
> >=20
> > On Fri, Aug 22, 2025 at 11:58:06AM +0200, Christophe Leroy wrote:
> > > Masked user access avoids the address/size verification by access_o=
k().
> > > Allthough its main purpose is to skip the speculation in the
> > > verification of user address and size hence avoid the need of spec
> > > mitigation, it also has the advantage of reducing the amount of
> > > instructions required so it even benefits to platforms that don't
> > > need speculation mitigation, especially when the size of the copy i=
s
> > > not know at build time.
> > >=20
> > > So implement masked user access on powerpc. The only requirement is
> > > to have memory gap that faults between the top user space and the
> > > real start of kernel area.
> > >=20
> > > On 64 bits platforms the address space is divided that way:
> > >=20
> > >        0xffffffffffffffff      +------------------+
> > >                                |                  |
> > >                                |   kernel space   |
> > >                                |                  |
> > >        0xc000000000000000      +------------------+  <=3D=3D PAGE_O=
FFSET
> > >                                |//////////////////|
> > >                                |//////////////////|
> > >        0x8000000000000000      |//////////////////|
> > >                                |//////////////////|
> > >                                |//////////////////|
> > >        0x0010000000000000      +------------------+  <=3D=3D TASK_S=
IZE_MAX
> > >                                |                  |
> > >                                |    user space    |
> > >                                |                  |
> > >        0x0000000000000000      +------------------+
> > >=20
> > > Kernel is always above 0x8000000000000000 and user always
> > > below, with a gap in-between. It leads to a 4 instructions sequence=
:
> > >=20
> > >    80: 7c 69 1b 78     mr      r9,r3
> > >    84: 7c 63 fe 76     sradi   r3,r3,63
> > >    88: 7d 29 18 78     andc    r9,r9,r3
> > >    8c: 79 23 00 4c     rldimi  r3,r9,0,1
> > >=20
> > > This sequence leaves r3 unmodified when it is below 0x8000000000000=
000
> > > and clamps it to 0x8000000000000000 if it is above.
> > >=20
> >=20
> > This comment looks wrong: the second instruction converts r3 to a
> > replicated sign bit of the address ((addr>0)?0:-1) if treating the
> > address as signed. After that the code only modifies the MSB of r3. S=
o I
> > don't see how r3 could be unchanged from the original value...
>=20
> Unless I'm missing something, the above rldimi leaves the MSB of r3
> unmodified and replaces all other bits by the same in r9.
>=20
> This is the code generated by GCC for the following:
>=20
> 	unsigned long mask =3D (unsigned long)((long)addr >> 63);
>=20
> 	addr =3D ((addr & ~mask) & (~0UL >> 1)) | (mask & (1UL << 63));
>=20
>=20
> >=20
> > OTOH, I believe the following 3 instructions sequence would work,
> > input address (a) in r3, scratch value (tmp) in r9, both intptr_t:
> >=20
> >          sradi r9,r3,63  ; tmp =3D (a >=3D 0) ? 0L : -1L;
> >          andc r3,r3,r9   ; a =3D a & ~tmp; (equivalently a =3D (a >=3D=
 0) ? a : 0)
> >          rldimi r3,r9,0,1 ; copy MSB of tmp to MSB of a
> >=20
> > But maybe I goofed...
> >=20
>=20
> From my understanding of rldimi, your proposed code would:
> - Keep r3 unmodified when it is above 0x8000000000000000
> - Set r3 to 0x7fffffffffffffff when it is below 0x8000000000000000
>=20
> Extract of ppc64 ABI:
>=20
> rldimi RA,RS,SH,MB
>=20
> The contents of register RS are rotated 64 left SH bits.
> A mask is generated having 1-bits from bit MB
> through bit 63=E2=88=92 SH and 0-bits elsewhere. The rotated
> data are inserted into register RA under control of the
> generated mask.

Sorry, you are right, I got the polarity of the mask reversed in my
head.


Once again I may goof, but I believe that the following sequence
would work:

	sradi r9,r3,63
	andc r3,r3,r9
	rldimi r3,r9,63,0  ; insert LSB of r9 into MSB of R3

Cheers,
Gabriel
 


