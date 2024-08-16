Return-Path: <linux-fsdevel+bounces-26137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D13954DD3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 17:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6497728329E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 15:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0E1C68A2;
	Fri, 16 Aug 2024 15:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPVlavzi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89E51C6895;
	Fri, 16 Aug 2024 15:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822346; cv=none; b=lcIDPxj659LtBiwQtM1Ic3niw8Hjwope8fqLiPB+mX2iFc4XOkEcf1NvrppWITETyjl9OC8Kr2Z48MpICZzMBo2UR8urG8MmIB7NaChKP+fpTRpfsTEWuBJgbOm5HvJ4MuYjWW4AUIFfFnrG5A9F7pzC/DBxWX7E9EY6o3aL/e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822346; c=relaxed/simple;
	bh=2/SyteaEDgLjslhjK5Qrg9vsTkx+4CL4Pn+Rur8QC18=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXJ/sSId0JG/ClTzQwY9F2K3TdiMTCdxbrHJzEkr8NybaA/VELWxka7zMNF3d+i7v8WMtBYZRt7QJ/D+W8nTbHE9l6RGM4g64IC8n5mwfdgBGHpeRPF2hyC9rLE2UNScPpVtWhKXWTPDbc9ae2EHQkLFpF1GUjp8YUDJysm0qJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPVlavzi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E49C4AF0B;
	Fri, 16 Aug 2024 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723822346;
	bh=2/SyteaEDgLjslhjK5Qrg9vsTkx+4CL4Pn+Rur8QC18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tPVlavzii20FYM/2odXn3dc4J0pC/bFkESC3D+bRAYJ60xDKKbQDYU7wLO92oko/9
	 I0igy24KZcT6i753jJI9WxsYUU6D68lkfP9VPCfYKB9F5uUoX7c1EdnvFBs6qCWc+4
	 D+ly54JIrs5pIPKeHAVaFMTESgVSdKBPQBvD45Le70/UO5fD86Y5/6p19KuZnkt8px
	 XF07CnZ9evf7RwPPBLQ4UKPDxTwFwVLHTmmhV5OByZ8TaO3m2MEuHcoHcj7oCGaAHK
	 OqmY+UmluMV9KFtA93H1zXF/fAIGQQwntdR7E/Kym2bSphGLZxNh0c6eYNBAdDv/5U
	 Nq6MGN86ZajLw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1seywB-004K1i-3k;
	Fri, 16 Aug 2024 16:32:23 +0100
Date: Fri, 16 Aug 2024 16:32:22 +0100
Message-ID: <86cym8zdo9.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	akpm@linux-foundation.org,
	aneesh.kumar@kernel.org,
	aneesh.kumar@linux.ibm.com,
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
	szabolcs.nagy@arm.com,
	tglx@linutronix.de,
	will@kernel.org,
	x86@kernel.org,
	kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 07/29] KVM: arm64: Save/restore POE registers
In-Reply-To: <20240816151301.GA138302@e124191.cambridge.arm.com>
References: <20240503130147.1154804-1-joey.gouly@arm.com>
	<20240503130147.1154804-8-joey.gouly@arm.com>
	<86ed6ozfe8.wl-maz@kernel.org>
	<20240816151301.GA138302@e124191.cambridge.arm.com>
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
X-SA-Exim-Rcpt-To: joey.gouly@arm.com, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de, broonie@kernel.org, catalin.marinas@arm.com, christophe.leroy@csgroup.eu, dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com, npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org, szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org, kvmarm@lists.linux.dev
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 16 Aug 2024 16:13:01 +0100,
Joey Gouly <joey.gouly@arm.com> wrote:
> 
> On Fri, Aug 16, 2024 at 03:55:11PM +0100, Marc Zyngier wrote:
> > On Fri, 03 May 2024 14:01:25 +0100,
> > Joey Gouly <joey.gouly@arm.com> wrote:
> > > 
> > > +	if (!kvm_has_feat(kvm, ID_AA64MMFR3_EL1, S1POE, IMP))
> > > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nPOR_EL1 |
> > > +						HFGxTR_EL2_nPOR_EL0);
> > > +
> > 
> > As Broonie pointed out in a separate thread, this cannot work, short
> > of making ID_AA64MMFR3_EL1 writable.
> > 
> > This can be done in a separate patch, but it needs doing as it
> > otherwise breaks migration.
> > 
> > Thanks,
> > 
> > 	M.
> > 
> 
> Looks like it's wrong for PIE currently too, but your patch here fixes that:
> 	https://lore.kernel.org/kvmarm/20240813144738.2048302-11-maz@kernel.org/
> 
> If I basically apply that patch, but only for POE, the conflict can be resolved
> later, or a rebase will fix it up, depending on what goes through first.

If I trust my feature dependency decoder, you need to make both
TCRX and POE writable:

(FEAT_S1POE --> v8Ap8)
(FEAT_S1POE --> FEAT_TCR2)
(FEAT_S1POE --> FEAT_ATS1A)
(FEAT_S1POE --> FEAT_HPDS)
(FEAT_S1POE <-> (AArch64 ID_AA64MMFR3_EL1.S1POE >= 1))
(FEAT_TCR2 --> v8Ap0)
(v8Ap9 --> FEAT_TCR2)
((FEAT_TCR2 && FEAT_AA64EL2) --> FEAT_HCX)
(FEAT_TCR2 <-> (AArch64 ID_AA64MMFR3_EL1.TCRX >= 1))

Feel free to lift part of that patch as you see fit.

	M.

-- 
Without deviation from the norm, progress is not possible.

