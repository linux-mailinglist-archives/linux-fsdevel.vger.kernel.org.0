Return-Path: <linux-fsdevel+bounces-28411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB9B96A145
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 16:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26F0BB22A34
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 14:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9AF158DD2;
	Tue,  3 Sep 2024 14:54:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288681422A2;
	Tue,  3 Sep 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375262; cv=none; b=e4b2TZCov5nPlS12Vg1mh2oae+U3Cf7liusRwh7R4kE7ugZj6rjoGr5OincVVl5Kd8QKOakU6l4qLQp+74xC2g380aCpY6PzzJ9IXv3/Vru0ZjU4j0/9YJiXUANIxHooUMBqmT0mUCTYCYMsAGjX/7CobNk9QL834ATcK2H3nxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375262; c=relaxed/simple;
	bh=PFZQ6NWqaKynv8f2IgqmAWzdtFGU8hY07DRimKSgbSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNBIRxDPWDwVEyygyNJ5dq8Uyh194GHZ8iYgJaykQobof2SaT5TQNdZDdZFucsQzSTDJfQvfjY+HlNLzVTw+CBvMxKu3To97VfULSuak/VzWxlEtgO4KlWEdW8RByqUhxTAODVkANWCoo1s94B5R4NrTcINJ59xYRREbBgnnuAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4FE4FEC;
	Tue,  3 Sep 2024 07:54:44 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AF13F66E;
	Tue,  3 Sep 2024 07:54:15 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:54:13 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20240903145413.GB3669886@e124191.cambridge.arm.com>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
 <20240822151113.1479789-7-joey.gouly@arm.com>
 <20240823144531.GH32156@willie-the-truck>
 <Zsi7ovLOfuFdfuuz@arm.com>
 <20240823170835.GA1181@willie-the-truck>
 <ZsjXtE7Kg0LQwNAL@arm.com>
 <20240827113803.GB4318@willie-the-truck>
 <ZtYNGBrcE-j35fpw@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtYNGBrcE-j35fpw@arm.com>

On Mon, Sep 02, 2024 at 08:08:08PM +0100, Catalin Marinas wrote:
> On Tue, Aug 27, 2024 at 12:38:04PM +0100, Will Deacon wrote:
> > On Fri, Aug 23, 2024 at 07:40:52PM +0100, Catalin Marinas wrote:
> > > On Fri, Aug 23, 2024 at 06:08:36PM +0100, Will Deacon wrote:
> > > > On Fri, Aug 23, 2024 at 05:41:06PM +0100, Catalin Marinas wrote:
> > > > > On Fri, Aug 23, 2024 at 03:45:32PM +0100, Will Deacon wrote:
> > > > > > On Thu, Aug 22, 2024 at 04:10:49PM +0100, Joey Gouly wrote:
> > > > > > > +static void permission_overlay_switch(struct task_struct *next)
> > > > > > > +{
> > > > > > > +	if (!system_supports_poe())
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
> > > > > > > +	if (current->thread.por_el0 != next->thread.por_el0) {
> > > > > > > +		write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
> > > > > > > +		/* ISB required for kernel uaccess routines when chaning POR_EL0 */
> > > > > >
> > > > > > nit: typo "chaning".
> > > > > >
> > > > > > But more substantially, is this just to prevent spurious faults in the
> > > > > > context of a new thread using a stale value for POR_EL0?
> > > > >
> > > > > Not just prevent faults but enforce the permissions from the new
> > > > > thread's POR_EL0. The kernel may continue with a uaccess routine from
> > > > > here, we can't tell.
> [...]
> > > > So what do we actually gain by having the uaccess routines honour this?
> > >
> > > I guess where it matters is more like not accidentally faulting because
> > > the previous thread had more restrictive permissions.
> >
> > That's what I wondered initially, but won't the fault handler retry in
> > that case?
>
> Yes, it will retry and this should be fine (I assume you are only
> talking about the dropping ISB in the context switch).
>
> For the case of running with a more permissive stale POR_EL0, arguably it's
> slightly more predictable for the user but, OTOH, some syscalls like
> readv() could be routed through GUP with no checks. As with MTE, we
> don't guarantee uaccesses honour the user permissions.
>
> That said, at some point we should sanitise this path anyway and have a
> single ISB at the end. In the meantime, I'm fine with dropping the ISB
> here.
>

commit 3141fb86bee8d48ae47cab1594dad54f974a8899
Author: Joey Gouly <joey.gouly@arm.com>
Date:   Tue Sep 3 15:47:26 2024 +0100

    fixup! arm64: context switch POR_EL0 register

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index a3a61ecdb165..c224b0955f1a 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -515,11 +515,8 @@ static void permission_overlay_switch(struct task_struct *next)
                return;

        current->thread.por_el0 = read_sysreg_s(SYS_POR_EL0);
-       if (current->thread.por_el0 != next->thread.por_el0) {
+       if (current->thread.por_el0 != next->thread.por_el0)
                write_sysreg_s(next->thread.por_el0, SYS_POR_EL0);
-               /* ISB required for kernel uaccess routines when chaning POR_EL0 */
-               isb();
-       }
 }

 /*

Will, do you want me to re-send the series with this and the permissions diff from the other thread [1],
or you ok with applying them when you pull it in?

Thanks,
Joey

[1] https://lore.kernel.org/all/20240903144823.GA3669886@e124191.cambridge.arm.com/

