Return-Path: <linux-fsdevel+bounces-28602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2525496C4DF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 19:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCA2A1F25905
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645AC1E0B83;
	Wed,  4 Sep 2024 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKlqsYDL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC143152;
	Wed,  4 Sep 2024 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469529; cv=none; b=fNtjL8OhhNUb/pjq3OqKPjV/QVQwDH7DKXOB/JOEK3qsHhqdVPLgpch/DX9Z5vZd4DHeZGr/gASaA6rplH+UGOT10BzD+/eCP1Lmf7hlxedALJdssR3CGP1XF1UT5tuuRPWgvf0a/Q72QoGBdjjPJQw7Cfouk4Waj/oEG4mlmnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469529; c=relaxed/simple;
	bh=0gw45QxN3fNUQlIV0l0iCm8GEARvkwPgJdU3FZfLCE4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+KYAIllFAcHPAsYLhHCZcfofc+x21Sa3ZtTe3GbTFe2+I0MTba2OCzcv2ip0fqNLhmyS9G9W2x0feH5RYV9quA3iGjZvv4lYmwuFX38nYA0Hn6ea1f6oU7OA2eR1n4HYonECAy8jWl5nL1Oh35o+z5tEzSblCx7IvTDQVWA+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKlqsYDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40408C4CEC5;
	Wed,  4 Sep 2024 17:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725469529;
	bh=0gw45QxN3fNUQlIV0l0iCm8GEARvkwPgJdU3FZfLCE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qKlqsYDLXHs0iW3ETzrWnTRx/FFUL3jDSU4JY29c9EYYGmqlPmyUvUnkw7/SWH2G3
	 VdNQNSRW6//Mm1pBsOORRXDfmjRazMqR1R/JqgZ2Zss1tL4l5Y7tLElrzXRanury9D
	 CeiQfmDFIxVzSo3roysBXKD6LYAXHzaV1WfP4ykVbE+8snaRnTD70u0d4y9cmZgNqB
	 LJYwhAn+SIMVfd0rHI3ly9q54Fa9Fcp/5aK0UtTYmnIHcRcr+pxha1T+d4XjGGGB2N
	 J6QtFp1RDFErkjMpK/FgI4UTUf/i9lpDKzMpYNBold6zhiVaRdpsn8KF7CHLvC0vq2
	 y5vpwwebK2gwA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sltRe-009hKx-M3;
	Wed, 04 Sep 2024 18:05:26 +0100
Date: Wed, 04 Sep 2024 18:05:26 +0100
Message-ID: <86plpjuz6x.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	mingo@redhat.com,
	mpe@ellerman.id.au,
	naveen.n.rao@linux.ibm.com,
	npiggin@gmail.com,
	oliver.upton@linux.dev,
	shuah@kernel.org,
	skhan@linuxfoundation.org,
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	x86@kernel.org,
	kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 06/30] arm64: context switch POR_EL0 register
In-Reply-To: <20240904161758.GA14323@willie-the-truck>
References: <Zsi7ovLOfuFdfuuz@arm.com>
	<20240823170835.GA1181@willie-the-truck>
	<ZsjXtE7Kg0LQwNAL@arm.com>
	<20240827113803.GB4318@willie-the-truck>
	<ZtYNGBrcE-j35fpw@arm.com>
	<20240903145413.GB3669886@e124191.cambridge.arm.com>
	<20240904102254.GA13280@willie-the-truck>
	<20240904113221.GA3891700@e124191.cambridge.arm.com>
	<20240904114301.GA13550@willie-the-truck>
	<20240904125503.GA3901671@e124191.cambridge.arm.com>
	<20240904161758.GA14323@willie-the-truck>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.4
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: will@kernel.org, joey.gouly@arm.com, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, broonie@kernel.org, christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org, szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 04 Sep 2024 17:17:58 +0100,
Will Deacon <will@kernel.org> wrote:
> 
> On Wed, Sep 04, 2024 at 01:55:03PM +0100, Joey Gouly wrote:
> > On Wed, Sep 04, 2024 at 12:43:02PM +0100, Will Deacon wrote:
> > > Right, there's quite a lot I need to do:
> > > 
> > > - Uncorrupt your patches
> > > - Fix the conflict in the kvm selftests
> > > - Drop the unnecessary ISBs
> > > - Fix the ESR checking
> > > - Fix the el2_setup labels
> > > - Reorder the patches
> > > - Drop the patch that is already in kvmarm
> > > 
> > > Working on it...
> > 
> > Sorry! I'm happy to rebase onto some arm64 branch if that will help, just let me know.
> 
> Please have a look at for-next/poe (also merged into for-next/core and
> for-kernelci) and let me know what I got wrong!
> 
> For Marc: I reordered the series so the KVM bits (and deps) are all the
> beginning, should you need them. The branch is based on a merge of the
> shared branch you created previously.

I just had a quick check, and while there is a small conflict with
kvmarm/next, it is extremely minor (small clash in the vcpu_sysreg,
for which the resolving order doesn't matter), and not worth dragging
additional patches in the shared branch.

However, if KVM's own S1PIE series [1] ends up being merged (which I'd
really like), I will definitely have to pull the prefix in, as this is
a bit more involved conflict wise.

Thanks,

	M.

[1] http://lore.kernel.org/all/20240903153834.1909472-1-maz@kernel.org

-- 
Without deviation from the norm, progress is not possible.

