Return-Path: <linux-fsdevel+bounces-23508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FAE92D840
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 20:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6041F220A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF9196450;
	Wed, 10 Jul 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvU6NyC6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC381922E3;
	Wed, 10 Jul 2024 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636093; cv=none; b=t3dFtGuevibP4RKuLQDlwtjwGLABy/0ST+gUEdmG10RCm6glaTznrsJX1rthlFI+e4RlU9b0TGwlrZo62kShIrQl4JhzjhKAYWYtx06CW+QGLrHygP+/T4HSfC1xaZKPD6yxEUL3n3rw1yu/AqZbIpHi6DkAypBvG0+zkfpMBeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636093; c=relaxed/simple;
	bh=PbMaBEL1Vn3w0nHRy4gywthrdx0lWu7HFhqULAUjVEQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9Pmxww/HeRA810yWljaQpVrhSzQIQU6nzEGEX6uQjMe6t9919sURYA6HY5cBIzj4sDbvnVHLWTjH5zzgpAlcgNRi0GQzgX0e4wGkYKS2Xcawnwx8fR1WPzo8pEz3uSyMEdQlbT0h3g4F4ZGSwa5Kh74jMuyCcxm+N7G6fG2A1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvU6NyC6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D33C32781;
	Wed, 10 Jul 2024 18:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720636093;
	bh=PbMaBEL1Vn3w0nHRy4gywthrdx0lWu7HFhqULAUjVEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UvU6NyC6n6BlKuA4+lMz9GvmSNdczbL4GlIU1Vlj32L2u2+fGLMjQrSxfNRxSnY0w
	 u+QMzrP0KgOpVekTFJDTqLU8gpZW23h64170xdmE2sQdz/m7dwy52MdnKoey53dJLP
	 R0YLR+tUbDS31gc4Max8kHksKS2N+ybbZqtvM6YsI+TgT0fcZPqhTAKNDuLGGU6b4w
	 QGgcbCBVpzPT/2YJVNh3yJ9MT7u3furVwVKoPSpWQq7fU2V9BAwPyBS+1BYIOLBBjk
	 efnAstd6iMz4rdXX6u0YoSny2uTLWV2AQgD9fxXNp1bkvmtYEI8prMzJpNaBsWYmBn
	 blZJUA488qtFw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sRc30-00BJ5c-7F;
	Wed, 10 Jul 2024 19:28:10 +0100
Date: Wed, 10 Jul 2024 19:28:09 +0100
Message-ID: <86ttgx2jba.wl-maz@kernel.org>
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
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 13/39] KVM: arm64: Manage GCS registers for guests
In-Reply-To: <Zo7B_sRyUyxv7xmO@finisterre.sirena.org.uk>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
	<20240625-arm64-gcs-v9-13-0f634469b8f0@kernel.org>
	<86v81d2s5t.wl-maz@kernel.org>
	<Zo7B_sRyUyxv7xmO@finisterre.sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/29.3
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 10 Jul 2024 18:16:46 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Wed, Jul 10, 2024 at 04:17:02PM +0100, Marc Zyngier wrote:
> > Mark Brown <broonie@kernel.org> wrote:
> 
> > > +	if (ctxt_has_gcs(ctxt)) {
> 
> > Since this is conditioned on S1PIE, it should be only be evaluated
> > when PIE is enabled in the guest.
> 
> So make ctxt_has_gcs() embed a check of ctxt_has_s1pie()?

No. I mean nest the whole thing *under* the check for S1PIE.

> 
> > > +		ctxt_sys_reg(ctxt, GCSPR_EL1)	= read_sysreg_el1(SYS_GCSPR);
> > > +		ctxt_sys_reg(ctxt, GCSCR_EL1)	= read_sysreg_el1(SYS_GCSCR);
> > > +		ctxt_sys_reg(ctxt, GCSCRE0_EL1)	= read_sysreg_s(SYS_GCSCRE0_EL1);
> 
> > Why is this part of the EL1 context? It clearly only matters to EL0
> > execution, so it could be switched in load/put on nVHE as well. And
> > actually, given that the whole thing is strictly for userspace, why do
> > we switch *anything* eagerly at all?
> 
> GCS can also be used independently at EL1 (and EL2 for that matter),
> it's not purely for userspace even though this series only implements
> use in userspace.  GCSPR_EL1 and GCSCR_EL1 control the use of GCS at
> EL1, not EL0, and the guest might be using GCS at EL1 even if the host
> doesn't.
>
> GCSCRE0_EL1 is for EL0 though, it ended up here mainly because it's an
> _EL1 register and we are already context switching PIRE0_EL1 in the EL1
> functions so it seemed consistent to follow the same approach for GCS.
> The _el1 and _user save/restore functions are called from the same place
> for both VHE and nVHE so the practical impact of the placement should be
> minimal AFAICT.  Unlike PIRE0_EL1 GCSCRE0_EL1 only has an impact for
> code runnning at EL0 so I can move it to the _user functions.

Exactly. That's where it belongs, because we never execute EL0 while a
vcpu is loaded. On the contrary, we can make use of a uaccess helper
while a vcpu is loaded, and that makes a hell of a difference.

And it makes a difference because it would allow the loading of
EL0-specific context differently. We had this at some point, and it
was a reasonable optimisation that we lost. I'm keen on bringing it
back.

> 
> TBH I'm not following your comments about switching eagerly too here at
> all, where would you expect to see the switching done?  You've said
> something along these lines before which prompted me to send a patch to
> only save the S1PIE registers if they'd been written to which you were
> quite reasonably not happy with given the extra traps it would cause:
> 
>    https://lore.kernel.org/r/20240301-kvm-arm64-defer-regs-v1-1-401e3de92e97@kernel.org
> 
> but I'm at a loss as to how to make things less eager otherwise.
>
> > > @@ -2306,7 +2323,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
> > >  		   ID_AA64PFR0_EL1_GIC |
> > >  		   ID_AA64PFR0_EL1_AdvSIMD |
> > >  		   ID_AA64PFR0_EL1_FP), },
> > > -	ID_SANITISED(ID_AA64PFR1_EL1),
> > > +	ID_WRITABLE(ID_AA64PFR1_EL1, ~(ID_AA64PFR1_EL1_RES0 |
> > > +				       ID_AA64PFR1_EL1_BT)),
> 
> > I don't know what you're trying to do here, but that's not right. If
> > you want to make this register writable, here's the shopping list:
> 
> > https://lore.kernel.org/all/87ikxsi0v9.wl-maz@kernel.org/
> 
> Yes, trying to make things writable.  I do see we need to exclude more
> bits there and I'm not clear why I excluded BTI, looks like I forgot to
> add a TODO comment at some point and finish that off.  Sorry about that.
> 
> In the linked mail you say you want to see all fields explicitly
> handled, could you be more direct about what such explicit handling

This emails enumerate, point after point, everything that needs to be
done. I really cannot be clearer or more direct. This email is the
clearer I can be, short of writing the code myself. And I have decided
not to do it for once, unless I really need to. And as it turns out, I
don't.

> would look like?  I see a number of examples in the existing code like:
> 
> 	ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),

This is clear: Everything is writable, and there are no bits here that
are otherwise conditional or unsupported.

> 
> 	ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),

Same thing.

> 	ID_WRITABLE(ID_AA64ISAR1_EL1, ~(ID_AA64ISAR1_EL1_GPI |
> 					ID_AA64ISAR1_EL1_GPA |
> 					ID_AA64ISAR1_EL1_API |
> 					ID_AA64ISAR1_EL1_APA)),

This one needs fixing because of LS64, and I have an in-progress
series for it.

> which look to my eye very similar to the above, they do not visibliy
> explictly enumerate every field in the registers and given that there's
> a single mask specified it's not clear how that would look.  If
> ID_WRITABLE() took separate read/write masks and combined them it'd be
> more obvious but it's just not written that way.

I don't really see what it would buy us, but never mind.

	M.

-- 
Without deviation from the norm, progress is not possible.

