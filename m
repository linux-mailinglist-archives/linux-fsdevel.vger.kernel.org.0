Return-Path: <linux-fsdevel+bounces-26980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF5995D562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A1C283719
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 18:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A206C1917F2;
	Fri, 23 Aug 2024 18:41:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58A18DF81;
	Fri, 23 Aug 2024 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438461; cv=none; b=QVKDp/JkZBB8lXbnHgXLPHprM4/JjPRgpKH6yvhGBvHL1LK5WemH4ShTBwPoli5I8YLpWlOGcFk0zif7uSs5nqVAZc2AcY9Bzp2BlRggTT+4zzKFeeszEIuxxBe1EghBc1ykPLxVfcq3fbHRm4hycZo1VqM3IlRPVoWRDly4gTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438461; c=relaxed/simple;
	bh=ounfh/bXLyxQViCNcAOjTt5R6ApsmH4cEaxiopLxJbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDeHDU8HYPGOOvcO0EMaorX2BsdjwDww6f0ogHvtZC4sWK6MBafkOK6ta3oUAZXQzP2TbzZUk7NQw3tH3uk+BrgiEDzAW2g5h/npynKX67mPita0g+lzASD3WPSRBl9+hGoPqaUjUqRV3EuoD1APpjqHfnMXwvxPfn18+2pSDz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C5C32786;
	Fri, 23 Aug 2024 18:40:54 +0000 (UTC)
Date: Fri, 23 Aug 2024 19:40:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, linux-arm-kernel@lists.infradead.org,
	nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de,
	broonie@kernel.org, christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com, hpa@zytor.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org,
	kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
Message-ID: <ZsjXtE7Kg0LQwNAL@arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823170835.GA1181@willie-the-truck>

On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > +{
> > > > +	if (!system_supports_poe())
> > > > +		return;
> > > > +
> > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > 
> > > nit: typo "chaning".
> > > 
> > > But more substantially, is this just to prevent spurious faults in the
> > > context of a new thread using a stale value for POR_EL0?
> > 
> > Not just prevent faults but enforce the permissions from the new
> > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > here, we can't tell.
> 
> Hmm, I wondered if that was the case. It's a bit weird though, because:
> 
>   - There's a window between switch_mm() and switch_to() where you might
>     reasonably expect to be able to execute uaccess routines

I don't think we can have any uaccess between these two switches (a
uaccess could fault, that's a pretty weird state between these two).

>   - kthread_use_mm() doesn't/can't look at this at all

No, but a kthread would have it's own, most permissive, POR_EL0.

>   - GUP obviously doesn't care
> 
> So what do we actually gain by having the uaccess routines honour this?

I guess where it matters is more like not accidentally faulting because
the previous thread had more restrictive permissions.

-- 
Catalin

