Return-Path: <linux-fsdevel+bounces-23311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8492A87C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 19:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C8E282382
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 17:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FAC14D443;
	Mon,  8 Jul 2024 17:53:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC0614D28B;
	Mon,  8 Jul 2024 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461205; cv=none; b=sj8ytUYxLgZ3h8CziwofGksd/N+dI3BHZGf7Py/pWI+EwJ2CJq5V0rCAwUFfm0n3WIyyO97T2gg3vpYEBQFCehejhbW+b48etMYxiiR6MjJuEh1CQ/lN2HQFJtsOkk8fgfezVcVQlbn2cHtRYpxjOgGyu6ZBAz5ZX/DYNJbzlUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461205; c=relaxed/simple;
	bh=NrAuU7/qwUsU2CR3H2Sdo7BSKytY/z+C5vPmWZWycK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pe0W6Umx9vhfl4TR1QzGm3sEeNVEq0rCeqwk1yMKVL655xnMQbiKgwLGs8S/rH+v+PuU4M1YkiETzaojpKMv3oIvn5nHkMkPJaCuJssMh2dsTLA0gZKiu8bZSZgkH+ymlQnOmV1Bf9B8J0Owdtj2DG3LPK+nfVgVqEImKPL8bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD02C116B1;
	Mon,  8 Jul 2024 17:53:20 +0000 (UTC)
Date: Mon, 8 Jul 2024 18:53:18 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Florian Weimer <fweimer@redhat.com>, Joey Gouly <joey.gouly@arm.com>,
	dave.hansen@linux.intel.com, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	christophe.leroy@csgroup.eu, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, tglx@linutronix.de,
	will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
Message-ID: <ZownjvHbPI1anfpM@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com>
 <ZlnlQ/avUAuSum5R@arm.com>
 <20240531152138.GA1805682@e124191.cambridge.arm.com>
 <Zln6ckvyktar8r0n@arm.com>
 <87a5jj4rhw.fsf@oldenburg.str.redhat.com>
 <ZnBNd51hVlaPTvn8@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnBNd51hVlaPTvn8@arm.com>

Hi Szabolcs,

On Mon, Jun 17, 2024 at 03:51:35PM +0100, Szabolcs Nagy wrote:
> The 06/17/2024 15:40, Florian Weimer wrote:
> > >> A user can still set it by interacting with the register directly, but I guess
> > >> we want something for the glibc interface..
> > >> 
> > >> Dave, any thoughts here?
> > >
> > > adding Florian too, since i found an old thread of his that tried
> > > to add separate PKEY_DISABLE_READ and PKEY_DISABLE_EXECUTE, but
> > > it did not seem to end up upstream. (this makes more sense to me
> > > as libc api than the weird disable access semantics)
> > 
> > I still think it makes sense to have a full complenent of PKEY_* flags
> > complementing the PROT_* flags, in a somewhat abstract fashion for
> > pkey_alloc only.  The internal protection mask register encoding will
> > differ from architecture to architecture, but the abstract glibc
> > functions pkey_set and pkey_get could use them (if we are a bit
> > careful).
> 
> to me it makes sense to have abstract
> 
> PKEY_DISABLE_READ
> PKEY_DISABLE_WRITE
> PKEY_DISABLE_EXECUTE
> PKEY_DISABLE_ACCESS
> 
> where access is handled like
> 
> if (flags&PKEY_DISABLE_ACCESS)
> 	flags |= PKEY_DISABLE_READ|PKEY_DISABLE_WRITE;
> disable_read = flags&PKEY_DISABLE_READ;
> disable_write = flags&PKEY_DISABLE_WRITE;
> disable_exec = flags&PKEY_DISABLE_EXECUTE;
> 
> if there are unsupported combinations like
> disable_read&&!disable_write then those are rejected
> by pkey_alloc and pkey_set.
> 
> this allows portable use of pkey apis.
> (the flags could be target specific, but don't have to be)

On powerpc, PKEY_DISABLE_ACCESS also disables execution. AFAICT, the
kernel doesn't define a PKEY_DISABLE_READ, only PKEY_DISABLE_ACCESS so
for powerpc there's no way to to set an execute-only permission via this
interface. I wouldn't like to diverge from powerpc.

However, does it matter much? That's only for the initial setup, the
user can then change the permissions directly via the sysreg. So maybe
we don't need all those combinations upfront. A PKEY_DISABLE_EXECUTE
together with the full PKEY_DISABLE_ACCESS would probably suffice.

Give that on x86 the PKEY_ACCESS_MASK will have to stay as
PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE, we'll probably do the same as
powerpc and define an arm64 specific PKEY_DISABLE_EXECUTE with the
corresponding PKEY_ACCESS_MASK including it. We can generalise the masks
with some ARCH_HAS_PKEY_DISABLE_EXECUTE but it's probably more hassle
than just defining the arm64 PKEY_DISABLE_EXECUTE.

I assume you'd like PKEY_DISABLE_EXECUTE to be part of this series,
otherwise changing PKEY_ACCESS_MASK later will cause potential ABI
issues.

-- 
Catalin

