Return-Path: <linux-fsdevel+bounces-25922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E32951DF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9767A1C21844
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B81B3F17;
	Wed, 14 Aug 2024 15:03:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7531B3745;
	Wed, 14 Aug 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647834; cv=none; b=kXQSG8jywpE/+3Bj63sfOQRo0ywWBhTueJS5hdL37+gK3ezBR4s24+w4DC7CTEXy+Ob1NfQcQzz+vSeavQdoqFBrMV0KMxNBS3OaTVJgb2mVcTZmGTKNwRK/LP38VUg76ngHps3NUMss4dYBOkKH9Tqlf+zFFilHr4IerYQilZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647834; c=relaxed/simple;
	bh=siu8KpDoN20y20VOLFZmKnaCcTW4RPxpPg9rC0A+0Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yzv8r2VDOpmDdvOh+f29nMV8yqfXS1gdhawnF9hOcrSxmvRFIJGqPKi8yS4SCMcFd7SCO/QWMgZfWsBw/ehy5CQmCUikr3U788956JJ/KFEAJWRw03pPf1FEjr1TJotuEE4/gZjVqMYlVlQFQOG9LJCG9DvZRkH9X17juabK0QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727D4C4AF0A;
	Wed, 14 Aug 2024 15:03:49 +0000 (UTC)
Date: Wed, 14 Aug 2024 16:03:47 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org, aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org,
	christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com,
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, maz@kernel.org, mingo@redhat.com,
	mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com,
	oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com,
	tglx@linutronix.de, will@kernel.org, x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 18/29] arm64: add POE signal support
Message-ID: <ZrzHU9et8L_0Tv_B@arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-19-joey.gouly@arm.com>
 <ZqJ2knGETfS4nfEA@e133380.arm.com>
 <20240801155441.GB841837@e124191.cambridge.arm.com>
 <Zqu2VYELikM5LFY/@e133380.arm.com>
 <20240806103532.GA1986436@e124191.cambridge.arm.com>
 <20240806143103.GB2017741@e124191.cambridge.arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806143103.GB2017741@e124191.cambridge.arm.com>

Hi Joey,

On Tue, Aug 06, 2024 at 03:31:03PM +0100, Joey Gouly wrote:
> diff --git arch/arm64/kernel/signal.c arch/arm64/kernel/signal.c
> index 561986947530..ca7d4e0be275 100644
> --- arch/arm64/kernel/signal.c
> +++ arch/arm64/kernel/signal.c
> @@ -1024,7 +1025,10 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
>                         return err;
>         }
>  
> -       if (system_supports_poe()) {
> +       if (system_supports_poe() &&
> +                       (add_all ||
> +                        mm_pkey_allocation_map(current->mm) != 0x1 ||
> +                        read_sysreg_s(SYS_POR_EL0) != POR_EL0_INIT)) {
>                 err = sigframe_alloc(user, &user->poe_offset,
>                                      sizeof(struct poe_context));
>                 if (err)
> 
> 
> That is, we only save the POR_EL0 value if any pkeys have been allocated (other
> than pkey 0) *or* if POR_EL0 is a non-default value.

I had a chat with Dave as well on this and, in principle, we don't want
to add stuff to the signal frame unnecessarily, especially for old
binaries that have no clue of pkeys. OTOH, it looks like too complicated
for just 16 bytes. Also POR_EL0 all RWX is a valid combination, I don't
think we should exclude it.

If no pkey has been allocated, I guess we could skip this and it also
matches the x86 description of the PKRU being guaranteed to be preserved
only for the allocated keys. Do we reserve pkey 0 for arm64? I thought
that's only an x86 thing to emulate execute-only mappings.

Another corner case would be the signal handler doing a pkey_alloc() and
willing to populate POR_EL0 on sigreturn. It will have to find room in
the signal handler, though I don't think that's a problem.

-- 
Catalin

