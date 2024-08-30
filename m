Return-Path: <linux-fsdevel+bounces-28009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 078E8966086
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3BF1F28D5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A363118F2D5;
	Fri, 30 Aug 2024 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfV/DDyU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A7A1D1312;
	Fri, 30 Aug 2024 11:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725017017; cv=none; b=QQDW/ritHxk+YKlnZZ6iDCvyrMOOX6kBnDHDl/INRh6OkacL611IcOYWjgmxgzu5gRVDKCek7r1zEGGzmVNhLMDa5Tne48e4QkrnA846vpRPdGwFKGWCjugEF4bQ8MgnY5+Hl9VkRYudMfXnelEJidUp3QM67JVf8RbKrPDAliY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725017017; c=relaxed/simple;
	bh=AGgg9f2fB958U4x1s+dxT22RX9ukSLHU6cLpkIryQgg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osVgXKeR321jnhkHbhq7GoRdXunlQCsIrcxawoKYv81LGdF8bsMqUPmx0WlogqjD5jRQLA72psxm8LdLW2ykVx4pIp4cW41e1IK+nV+rJb+d4irIxO7wv3vP94OZYkeddrXz/hjIPoVDVeapo7wsp6XhcJOxL+adWLYJjYzLVFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfV/DDyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0FC4CEC2;
	Fri, 30 Aug 2024 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725017016;
	bh=AGgg9f2fB958U4x1s+dxT22RX9ukSLHU6cLpkIryQgg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FfV/DDyUHB/hVYd02Y6J9oRYH1/FQDQpAGF2WZWZcK1XYRSxlprKai7lONZjR2c7J
	 /Dex9/hW6AiFpZdIUF9XtPRzMSPhOF1ECWz927kRLIpnqj0wlikp1WkW+DBCmg155L
	 2Orx5Q48y0RPWknrfRx6q1K23VADyciCgMyVUQmlAT20BudJ/gQd8HQIJXHwGrZlJb
	 b9qzhlwYnCTjDzmZPNI2NI6zSLm5om4L2755PBZpZaC/Rf0brciIGb01ARqWb8Tpj3
	 gJ/dbjZhda7+5hLd24VnhzQVls4NVre2rek0cry2IffuYxE7oEd3YP+KJWMSUzJT+V
	 74eEWcuUjsKNw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sjzj3-008DQD-JN;
	Fri, 30 Aug 2024 12:23:33 +0100
Date: Fri, 30 Aug 2024 12:23:33 +0100
Message-ID: <86bk1aw8y2.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	nd@arm.com,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
	anshuman.khandual@arm.com,
	bp@alien8.de,
	broonie@kernel.org,
	catalin.marinas@arm.com,
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
Subject: Re: [PATCH v5 08/30] KVM: arm64: make kvm_at() take an OP_AT_*
In-Reply-To: <20240830092527.GB7678@willie-the-truck>
References: <20240822151113.1479789-1-joey.gouly@arm.com>
	<20240822151113.1479789-9-joey.gouly@arm.com>
	<20240830092527.GB7678@willie-the-truck>
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
X-SA-Exim-Rcpt-To: will@kernel.org, joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org, nd@arm.com, akpm@linux-foundation.org, aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com, bp@alien8.de, broonie@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org, skhan@linuxfoundation.org, szabolcs.nagy@arm.com, tglx@linutronix.de, x86@kernel.org, kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 30 Aug 2024 10:25:27 +0100,
Will Deacon <will@kernel.org> wrote:
> 
> On Thu, Aug 22, 2024 at 04:10:51PM +0100, Joey Gouly wrote:
> > To allow using newer instructions that current assemblers don't know about,
> > replace the `at` instruction with the underlying SYS instruction.
> > 
> > Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Oliver Upton <oliver.upton@linux.dev>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/include/asm/kvm_asm.h       | 3 ++-
> >  arch/arm64/kvm/hyp/include/hyp/fault.h | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> > diff --git arch/arm64/include/asm/kvm_asm.h arch/arm64/include/asm/kvm_asm.h
> > index 2181a11b9d92..38d7bfa3966a 100644
> > --- arch/arm64/include/asm/kvm_asm.h
> > +++ arch/arm64/include/asm/kvm_asm.h
> 
> FWIW (mainly for Marc): you seem to be missing the 'a/' and 'b/'
> prefixes here, so my git would't accept the change when I tried to
> apply locally for testing.

Seems like a spurious '--no-prefix' was added at patch formatting
time, That clashes with git-apply's default '-p1', which strips the
first component of the path.

There's probably a way to pass '-p0' to 'git am', but I don't feel
like trawling the git documentation by such a temperature...

	M.

-- 
Without deviation from the norm, progress is not possible.

