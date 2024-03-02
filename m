Return-Path: <linux-fsdevel+bounces-13369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F52186F0C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 16:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CB128383B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 15:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3701D17C71;
	Sat,  2 Mar 2024 15:03:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from port70.net (port70.net [81.7.13.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7488713FFA;
	Sat,  2 Mar 2024 15:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.7.13.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709391795; cv=none; b=AMYLg8N/4qrCqPw9ORGMPbZKu1LN5Sj6BdazhNyb8woUDMZAxjiSGspc+v8Ui5RMNu2eaLVacXZ2tLjjPjQqXlyMefomQ8Xw6+cuV1pk4Ut+2CirNqFKLMNypLKrk0898DM233sZizazGYmzwPN1393SOHfw9oXfc8Y9s3JemcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709391795; c=relaxed/simple;
	bh=F+Ft9ySflUOsjYRoTJD/SuxsOSEZzbIMaYW9w/glpJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0bMNapnZQa0/quYl7TDYybdZwf7CKj/0H0By6h7DqP9XawkWoSR+aIAMtq+XjSHGR1rjjEv7UbIHlii3pDBhvTZ+9nv5StBR3EHYqegB8MTHSfmLOJ6yzI5bt7hKDvjcTu39UnB1emDFSOJCsxwqSL1njDZSzUwlJnIcGug/gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net; spf=pass smtp.mailfrom=port70.net; arc=none smtp.client-ip=81.7.13.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=port70.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=port70.net
Received: by port70.net (Postfix, from userid 1002)
	id 691CEABEC0C7; Sat,  2 Mar 2024 15:57:02 +0100 (CET)
Date: Sat, 2 Mar 2024 15:57:02 +0100
From: Szabolcs Nagy <nsz@port70.net>
To: Mark Brown <broonie@kernel.org>
Cc: "dalias@libc.org" <dalias@libc.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS
 in userspace
Message-ID: <20240302145702.GD1884416@port70.net>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
	"dalias@libc.org" <dalias@libc.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"thiago.bauermann@linaro.org" <thiago.bauermann@linaro.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"sorear@fastmail.com" <sorear@fastmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
 <20240220235415.GP4163@brightrain.aerifal.cx>
 <a57d6c7eada4b9a7c35addbc8556f5b53a0c3e6f.camel@intel.com>
 <20240221012736.GQ4163@brightrain.aerifal.cx>
 <d18f060d-37ac-48b1-9f67-a5c5db79b34e@sirena.org.uk>
 <20240221145800.GR4163@brightrain.aerifal.cx>
 <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3809e8-61b2-4341-a868-292ba6e64e8a@sirena.org.uk>

* Mark Brown <broonie@kernel.org> [2024-02-21 17:36:12 +0000]:

> On Wed, Feb 21, 2024 at 09:58:01AM -0500, dalias@libc.org wrote:
> > On Wed, Feb 21, 2024 at 01:53:10PM +0000, Mark Brown wrote:
> > > On Tue, Feb 20, 2024 at 08:27:37PM -0500, dalias@libc.org wrote:
> > > > On Wed, Feb 21, 2024 at 12:35:48AM +0000, Edgecombe, Rick P wrote:
> 
> > > > > (INCSSP, RSTORSSP, etc). These are a collection of instructions that
> > > > > allow limited control of the SSP. When shadow stack gets disabled,
> > > > > these suddenly turn into #UD generating instructions. So any other
> > > > > threads executing those instructions when shadow stack got disabled
> > > > > would be in for a nasty surprise.
> 
> > > > This is the kernel's problem if that's happening. It should be
> > > > trapping these and returning immediately like a NOP if shadow stack
> > > > has been disabled, not generating SIGILL.
> 
> > > I'm not sure that's going to work out well, all it takes is some code
> > > that's looking at the shadow stack and expecting something to happen as
> > > a result of the instructions it's executing and we run into trouble.  A
> 
> > I said NOP but there's no reason it strictly needs to be a NOP. It
> > could instead do something reasonable to convey the state of racing
> > with shadow stack being disabled.
> 
> This feels like it's getting complicated and I fear it may be an uphill
> struggle to get such code merged, at least for arm64.  My instinct is

the aarch64 behaviour is already nop
for gcs instructions when gcs is disabled.
the isa was designed so async disable is
possible.

only x86 linux would have to emulate this.

> that it's going to be much more robust and generally tractable to let
> things run to some suitable synchronisation point and then disable
> there, but if we're going to do that then userspace can hopefully
> arrange to do the disabling itself through the standard disable
> interface anyway.  Presumably it'll want to notice things being disabled
> at some point anyway?  TBH that's been how all the prior proposals for
> process wide disable I've seen were done.



