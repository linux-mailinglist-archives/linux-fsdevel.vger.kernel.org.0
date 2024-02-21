Return-Path: <linux-fsdevel+bounces-12305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE46385E603
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 19:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42DF71F290C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5885649;
	Wed, 21 Feb 2024 18:30:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535607F7E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Feb 2024 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708540242; cv=none; b=I+803l7H/uZMhws/L3AqFXI503Z26ufgWXulBjUkWv6fRWodUv7yen8tobO9Ud0WrlYpl8U0UHKgxm7PCVyhZJwo8elgZd7cYrtJm9aAG/1q8aLPSo9Fru6ULcrv92DBdIYDIdsdSB5JiiqH3xSmV/ePgoT+8J1k1WLC7r5Z3dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708540242; c=relaxed/simple;
	bh=IQ9Hdi1C0K5tEBHBjujZgoxD3cUlRqBGyMd80ICd2vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScifNbx9nBpRBvtCXsTZCS+5QW1D+saboyXiuOvxxXvA1/V3ykUuIV5GJkrBaHueE5vi2EsvkfW8NHYI4rcAP0zR0RYp8o6dYlP9KsLHo8hIXGMTmhAEes3sCY5IP6p71YC977b+5+VPI2kD9/Ju+sP+vGRH+TU035K3fCVjVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Wed, 21 Feb 2024 13:30:55 -0500
From: "dalias@libc.org" <dalias@libc.org>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
	"Szabolcs.Nagy@arm.com" <Szabolcs.Nagy@arm.com>,
	"musl@lists.openwall.com" <musl@lists.openwall.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"corbet@lwn.net" <corbet@lwn.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"shuah@kernel.org" <shuah@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>, "maz@kernel.org" <maz@kernel.org>,
	"oleg@redhat.com" <oleg@redhat.com>,
	"fweimer@redhat.com" <fweimer@redhat.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	"will@kernel.org" <will@kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"hjl.tools@gmail.com" <hjl.tools@gmail.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240221183055.GT4163@brightrain.aerifal.cx>
References: <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
 <20240221175717.GS4163@brightrain.aerifal.cx>
 <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4a54297767eb098d903404cbe8860d655d79bed.camel@intel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Feb 21, 2024 at 06:12:30PM +0000, Edgecombe, Rick P wrote:
> On Wed, 2024-02-21 at 12:57 -0500, dalias@libc.org wrote:
> > > This feels like it's getting complicated and I fear it may be an
> > > uphill
> > > struggle to get such code merged, at least for arm64.  My instinct
> > > is
> > > that it's going to be much more robust and generally tractable to
> > > let
> > > things run to some suitable synchronisation point and then disable
> > > there, but if we're going to do that then userspace can hopefully
> > > arrange to do the disabling itself through the standard disable
> > > interface anyway.  Presumably it'll want to notice things being
> > > disabled
> > > at some point anyway?  TBH that's been how all the prior proposals
> > > for
> > > process wide disable I've seen were done.
> > 
> > If it's possible to disable per-thread rather than per-process, some
> > things are easier. Disabling on account of using alt stacks only
> > needs
> > to be done on the threads using those stacks. However, for dlopen
> > purposes you need a way to disable shadow stack for the whole
> > process.
> > Initially this is only needed for the thread that called dlopen, but
> > it needs to have propagated to any thread that synchronizes with
> > completion of the call to dlopen by the time that synchronization
> > occurs, and since that synchronization can happen in lots of
> > different
> > ways that are purely userspace (thanks to futexes being userspace in
> > the uncontended case), I don't see any way to make it work without
> > extremely invasive, high-cost checks.
> 
> For glibc's use, we talked about a couple of options.
> 1. A mode to start suppressing the #UD's from the shadow stack
> instructions
> 2. A mode to start suppressing #CPs (the exception that happens when
> the shadow stack doesn't match). So the shadow stack instructions
> continue to operate normally, but if the shadow stack gets mismatched
> due to lack of support, the ret is emulated. It probably is safer (but
> still not perfect), but the performance penalty of emulating every RET
> after things get screwed up would be a significant down side. There
> also needs to be clean handling of shadow stack #PFs.
> 3. Per-thread locking that is used around all shadow stack operations
> that could be sensitive to disabling. This could be maybe exposed to
> apps in case they want to use shadow stack instructions manually. Then
> during dlopen() it waits until it can cleanly disable shadow stack for
> each thread. In each critical sections there are checks for whether
> shadow stack is still enabled.
> 
> 3 is the cleanest and safest I think, and it was thought it might not
> need kernel help, due to a scheme Florian had to direct signals to
> specific threads. It's my preference at this point.

The operations where the shadow stack has to be processed need to be
executable from async-signal context, so this imposes a requirement to
block all signals around the lock. This makes all longjmps a heavy,
multi-syscall operation rather than O(1) userspace operation. I do not
think this is an acceptable implementation, especially when there are
clearly superior alternatives without that cost or invasiveness.

> 1 and 2 are POCed here, if you are interested:
> https://github.com/rpedgeco/linux/commits/shstk_suppress_rfc/

I'm not clear why 2 (suppression of #CP) is desirable at all. If
shadow stack is being disabled, it should just be disabled, with
minimal fault handling to paper over any racing operations at the
moment it's disabled. Leaving it on with extreme slowness to make it
not actually do anything does not seem useful.

Is there some way folks have in mind to use option 2 to lazily disable
shadow stack once the first SS-incompatible code is executed, when
execution is then known not to be in the middle of a SS-critical
section, instead of doing it right away? I don't see how this could
work, since the SS-incompatible code could be running from a signal
handler that interrupted an SS-critical section.

> > If folks on the kernel side are not going to be amenable to doing the
> > things that are easy for the kernel to make it work without breaking
> > compatibility with existing interfaces, but that are impossible or
> > near-impossible for userspace to do, this seems like a dead-end. And
> > I
> > suspect an operation to "disable shadow stack, but without making
> > threads still in SS-critical sections crash" is going to be
> > necessary..
> 
> I think we have to work through all the alternative before we can
> accuse the kernel of not being amenable. Is there something that you
> would like to see out of this conversation that is not happening?

No, I was just interpreting "uphill battle". I really do not want to
engage in an uphill battle for the sake of making it practical to
support something that was never my goal to begin with. If I'm
misreading this, or if others are willing to put the effort into that
"battle", I'd be happy to be mistaken about "not amenable".

Rich

