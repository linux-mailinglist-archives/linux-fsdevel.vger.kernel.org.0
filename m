Return-Path: <linux-fsdevel+bounces-26130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D33954D37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 16:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 341162897AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 14:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219261C37B9;
	Fri, 16 Aug 2024 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeF+YsDn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF91BE25A;
	Fri, 16 Aug 2024 14:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723819924; cv=none; b=taLGIpD/2cO1KUpixPmRyb5f0h3nWdRsSGNRVgjbbKYq/7DlmKw3YWq/UdlrcVKPwkvq3ku255zt91IsRNy7walpHfrbC6y9KFeyXAYs16GTIY/j/UcHM9tH/C873WtUXn3jBHZeu5kYectEz95jX34AjvL2WtM2MWvgcuujzOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723819924; c=relaxed/simple;
	bh=aCsAMYNwuNLSPVHVux3H7Fr1gU8Y/2OHAz58FNdjFh4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTlocXFzinosb+wsNAbQEewIxmWveFZGEfrGiJj015JQukUWz7Hxaj8g/+i/g4h+RM2tL4YL/cMVNHpTlBibq+7PkoYAsC4DftVlfMksVcxBUJHHZm03vqd4Q3tLI2Bjw+3P7EiIERsRd5JjSEIYncRjR5zpKLqdkc0on8fjVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeF+YsDn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69DBC32782;
	Fri, 16 Aug 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723819923;
	bh=aCsAMYNwuNLSPVHVux3H7Fr1gU8Y/2OHAz58FNdjFh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BeF+YsDnIob191w0ZGxINOu0jYhGxn63hEvhpdwFa5jW6Ni9L1j5zNVOpziP8Me0j
	 VdJs4rtfVWtbONAJ2r0/x3uS1uJZc2XPYoBcdPMqJrUCV+x88lcdwCaKqSzjILyxCl
	 pPqLCIIfO0T4TVHG0cB1VAhMSqMnUKLz0cQF1rYeVUgRmF3ySFmVl5HH9P3APi/JdA
	 OGvydVVsY9YgrNN5+mf6fbDIFAeE2+9CGNMViKsCCCrgA8yjKVqwuBgIuodAtGnMB+
	 bJ1HDN0++jB7l7MXDZDd5l+5rR7YSeKr9kXUadrtaZSXP/sile1fdjzQVOwoK02sNK
	 pOQwo0zbUdYjg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1seyJ7-004JCN-Lr;
	Fri, 16 Aug 2024 15:52:01 +0100
Date: Fri, 16 Aug 2024 15:52:00 +0100
Message-ID: <86frr4zfjj.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
	Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	joey.gouly@arm.com
Subject: Re: [PATCH v10 14/40] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <8c1e8fb6-0152-42f7-ab6d-93f6fe70b4aa@sirena.org.uk>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
	<20240801-arm64-gcs-v10-14-699e2bd2190b@kernel.org>
	<86h6bkzh8o.wl-maz@kernel.org>
	<8c1e8fb6-0152-42f7-ab6d-93f6fe70b4aa@sirena.org.uk>
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
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, joey.gouly@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 16 Aug 2024 15:40:33 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Fri, Aug 16, 2024 at 03:15:19PM +0100, Marc Zyngier wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > +	{ SYS_DESC(SYS_GCSCR_EL1), NULL, reset_val, GCSCR_EL1, 0 },
> > > +	{ SYS_DESC(SYS_GCSPR_EL1), NULL, reset_unknown, GCSPR_EL1 },
> > > +	{ SYS_DESC(SYS_GCSCRE0_EL1), NULL, reset_val, GCSCRE0_EL1, 0 },
> 
> > Global visibility for these registers? Why should we expose them to
> > userspace if the feature is neither present nor configured?
> 
> ...
> 
> > > +	if (!kvm_has_feat(kvm, ID_AA64PFR1_EL1, GCS, IMP))
> > > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> > > +						HFGxTR_EL2_nGCS_EL1);
> 
> > How can this work if you don't handle ID_AA64PFR_EL1 being written to?
> > You are exposing GCS to all guests without giving the VMM an
> > opportunity to turn it off. This breaks A->B->A migration, which is
> > not acceptable.
> 
> This was done based on your positive review of the POE series which
> follows the same pattern:
> 
>    https://lore.kernel.org/linux-arm-kernel/20240503130147.1154804-8-joey.gouly@arm.com/
>    https://lore.kernel.org/linux-arm-kernel/864jagmxn7.wl-maz@kernel.org/
> 
> in which you didn't note any concerns about the handling for the
> sysregs.
> 
> If your decisions have changed then you'll need to withdraw your review
> there, I'd figured that given the current incompleteness of the
> writability conversions and there being a bunch of existing registers
> exposed unconditionally you'd decided to defer until some more general
> cleanup of the situation.

Thanks for pointing out that I missed this crucial detail in the POE
series. I'll immediately go and point that out.

	M.

-- 
Without deviation from the norm, progress is not possible.

