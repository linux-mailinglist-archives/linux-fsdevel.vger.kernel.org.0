Return-Path: <linux-fsdevel+bounces-26371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9F958A92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E69928C85F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C27C192B84;
	Tue, 20 Aug 2024 14:59:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCD1922FA;
	Tue, 20 Aug 2024 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165969; cv=none; b=NGqNE1nvCGxGy0odgj6vNPwPkRroptFAxogfzDH3ttXsJu1psezxxnGaSxDG24QMQl+NacMyAYRR61yA5RHK+Jvk+uVrlhaeIrx7nUQmVC6s2b0lbHS+Yz3d6y+4aSohFI8Tt3NhqOHYcO34LJzvsxkpVT7roJN/3dX2ycknTDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165969; c=relaxed/simple;
	bh=fFyycMNcHqQKpVsT6qjvKb11en2SqC7MqG20NMYTK+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/u7yPzp5CZ8h8uRhRW1L4rxdv9MVmmnuyGR9cjaSXLtYOIh1AIPabLK0DiGSzK4DumJl8ePal85Zor/2JkLoeeHZyfwrDcEc7HQbAJjwm8xLGMzVSLFWsCkYXsGizqrSTd2vFxiQBLGN5uu6iN9o4ghH9DvQUfQr1KIsWUp8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA71FC4AF0F;
	Tue, 20 Aug 2024 14:59:23 +0000 (UTC)
Date: Tue, 20 Aug 2024 15:59:21 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Shuah Khan <shuah@kernel.org>,
	"Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>,
	Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Florian Weimer <fweimer@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Ross Burton <ross.burton@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v10 13/40] arm64/mm: Map pages for guarded control stack
Message-ID: <ZsSvSeE303LGtk4b@arm.com>
References: <20240801-arm64-gcs-v10-0-699e2bd2190b@kernel.org>
 <20240801-arm64-gcs-v10-13-699e2bd2190b@kernel.org>
 <ZsMMDNIp6Pkfbg1e@arm.com>
 <d43f8036-cc06-430c-9e9e-b938037fc64c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d43f8036-cc06-430c-9e9e-b938037fc64c@sirena.org.uk>

On Mon, Aug 19, 2024 at 05:33:24PM +0100, Mark Brown wrote:
> On Mon, Aug 19, 2024 at 10:10:36AM +0100, Catalin Marinas wrote:
> > On Thu, Aug 01, 2024 at 01:06:40PM +0100, Mark Brown wrote:
> > > +	if (system_supports_gcs() && (vm_flags & VM_SHADOW_STACK)) {
> > > +		/*
> > > +		 * An executable GCS isn't a good idea, and the mm
> > > +		 * core can't cope with a shared GCS.
> > > +		 */
> > > +		if (vm_flags & (VM_EXEC | VM_ARM64_BTI | VM_SHARED))
> > > +			return false;
> > > +	}
> 
> > I wonder whether we should clear VM_MAYEXEC early on during the vma
> > creation. This way the mprotect() case will be handled in the core code.
> > At a quick look, do_mmap() seems to always set VM_MAYEXEC but discard it
> > for non-executable file mmap. Last time I looked (when doing MTE) there
> > wasn't a way for the arch code to clear specific VM_* flags, only to
> > validate them. But I think we should just clear VM_MAYEXEC and also
> > return an error for VM_EXEC in the core do_mmap() if VM_SHADOW_STACK. It
> > would cover the other architectures doing shadow stacks.
> 
> Yes, I think adding something generic would make sense here.  That feels
> like a cleanup which could be split out?

It can be done separately. It doesn't look like x86 has such checks.
Adding it generically would be a slight ABI tightening but I doubt it
matters, no sane software would use an executable shadow stack.

> > Regarding VM_SHARED, how do we even end up with this via the
> > map_shadow_stack() syscall? I can't see how one can pass MAP_SHARED to
> > do_mmap() on this path. I'm fine with a VM_WARN_ON() if you want the
> > check (and there's no way a user can trigger it).
> 
> It's just a defenesive programming thing, I'm not aware of any way in
> which it should be possible to trigger this.
> 
> > Is there any arch restriction with setting BTI and GCS? It doesn't make
> > sense but curious if it matters. We block the exec permission anyway
> > (unless the BTI pages moved to PIE as well, I don't remember).
> 
> As you say BTI should be meaningless for a non-executable page like GCS,
> I'm not aware of any way in which it matters.  BTI is separate to PIE.

My thoughts were whether we can get rid of this hunk entirely by
handling it in the core code. We'd allow BTI if one wants such useless
combination but clear VM_MAYEXEC in the core code (and ignore VM_SHARED
since you can't set it anyway).

-- 
Catalin

