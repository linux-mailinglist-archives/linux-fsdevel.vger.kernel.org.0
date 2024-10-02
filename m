Return-Path: <linux-fsdevel+bounces-30776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE74198E377
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 21:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D40EB23FB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 19:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DDC215F7C;
	Wed,  2 Oct 2024 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDyp8qd2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A63718AE4;
	Wed,  2 Oct 2024 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897373; cv=none; b=g2jQdYFC9GaTu94KVR33UstNlT+pdpWO0KKYSrR4uAyW9zay4612iW389PdyBOnw8faoTygUARW2njvS7Ohhet4hLS2H1u+KfS8/1ArcPAbpZKBT2FUSkWKjqqCCe+2iYcRIxOX6sIvNig6kHPjPyzauqZr0KJQ75HYLqfF33jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897373; c=relaxed/simple;
	bh=8oiK5IU7Qhw1ttezR2j18nH046N1hl/vjVmhxTcZaFY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GElZw0GaqiiZVz6kxyg8sXCUjhX6J0ZOMQgYQquuI0gaGVchdhwxmFgJgNzFtMENb/BKi5iezgj1o9ne+2nGZMVkuv8g8VKPdsedF5rNlC00nEJKrpDOWY6t6dhLXp0ICuGJYVi6uobJ6uAR5N1kXLyd+OINa8Pnuc91Pf5By7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDyp8qd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E90C4CEC2;
	Wed,  2 Oct 2024 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727897372;
	bh=8oiK5IU7Qhw1ttezR2j18nH046N1hl/vjVmhxTcZaFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sDyp8qd2iGUJbVxlIon1SZp0FoCrNFapbJG6H1XLZJstGoks821loMKlBgRtxS2pt
	 FRMpM8u13XP2/wZpMtv0JlrO0jXiITzPaCiB72pKFeO+VvHW3+f1LgmulYoBNWB+Wc
	 q5Ob/UPjxZeQZLg/1xo3xEkj9k47VllAkXb8ds4i7xTjY8QOSXI1pIQRZQc4ZAl7ol
	 IrbDPhKzw5eOK+NaxfsunNLGLprzo+1j5t5Q0Sqmp/TzkTjPB9+Td2DEYrencPTYwG
	 WkLUopQgg8gRDgGEaIYV6F8k4PHvmdqIkrvNGMYQZCkTapZ70VoT52gNc1EMmKbZGi
	 pJC9UA2ziOg9w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=goblin-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1sw52P-00H99U-5J;
	Wed, 02 Oct 2024 20:29:29 +0100
Date: Wed, 02 Oct 2024 20:29:28 +0100
Message-ID: <868qv6717r.wl-maz@kernel.org>
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
	David Spickett <david.spickett@arm.com>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v13 16/40] KVM: arm64: Manage GCS access and registers for guests
In-Reply-To: <37fbc082-6bda-46e3-9ee7-9240b41f26fd@sirena.org.uk>
References: <20241001-arm64-gcs-v13-0-222b78d87eee@kernel.org>
	<20241001-arm64-gcs-v13-16-222b78d87eee@kernel.org>
	<86bk0373nq.wl-maz@kernel.org>
	<86a5fm7b4i.wl-maz@kernel.org>
	<37fbc082-6bda-46e3-9ee7-9240b41f26fd@sirena.org.uk>
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
X-SA-Exim-Rcpt-To: broonie@kernel.org, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, akpm@linux-foundation.org, oliver.upton@linux.dev, james.morse@arm.com, suzuki.poulose@arm.com, arnd@arndb.de, oleg@redhat.com, ebiederm@xmission.com, shuah@kernel.org, rick.p.edgecombe@intel.com, debug@rivosinc.com, ardb@kernel.org, Szabolcs.Nagy@arm.com, kees@kernel.org, hjl.tools@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, fweimer@redhat.com, brauner@kernel.org, thiago.bauermann@linaro.org, ross.burton@arm.com, david.spickett@arm.com, yury.khrustalev@arm.com, wilco.dijkstra@arm.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Wed, 02 Oct 2024 19:24:12 +0100,
Mark Brown <broonie@kernel.org> wrote:
> 
> [1  <text/plain; us-ascii (7bit)>]
> On Wed, Oct 02, 2024 at 04:55:25PM +0100, Marc Zyngier wrote:
> > Marc Zyngier <maz@kernel.org> wrote:
> 
> > > > +	if (!kvm_has_gcs(kvm))
> > > > +		kvm->arch.fgu[HFGxTR_GROUP] |= (HFGxTR_EL2_nGCS_EL0 |
> > > > +						HFGxTR_EL2_nGCS_EL1);
> 
> > > Why are you still allowing the GCS instructions when GCS isn't
> > > enabled?
> 
> > Scratch that, they are NOPs when GCS isn't enabled, so there shouldn't
> > be any need for extra traps.
> 
> They are, though really they should UNDEF if GCS isn't there (which I
> had thought was what you were referencing here).  Equally we only have
> traps for a subset of GCS instructions and it's not like there aren't a
> whole bunch of untrappable extensions anyway so it's not clear it's
> worth the effort just for that.

If the encodings UNDEF when GCS is not implemented (i.e. they are not
in the NOP space), then all trapable instructions should absolutely
UNDEF (and yes, it is worth the effort, even if it is only to
demonstrate that the architecture is sub-par).

So I expect the next version to handle traps for GCSPUSHX, GCSPOPX,
GCSPUSHM, GCSSTR and GCSSTTR when GCS isn't enabled.

I'm also pretty sure this is missing some form of sanitisation for
PSTATE.EXLOCK, and looking at the pseudocode, you seem to be missing
the handling of that bit on exception injection.

	M.

-- 
Without deviation from the norm, progress is not possible.

