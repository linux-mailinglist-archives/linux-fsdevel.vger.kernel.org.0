Return-Path: <linux-fsdevel+bounces-12192-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3166B85CC7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 01:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558AC1C21C26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Feb 2024 00:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5216B1EB37;
	Wed, 21 Feb 2024 00:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="kVxhzXzZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfX4N2Ey"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91560290A;
	Wed, 21 Feb 2024 00:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473691; cv=none; b=JIB6Wuf9wKvtRC36DwUsEgV4gCmAmy8GKAMMFQHLp96Gfi5gsSwp2sLkSfp37TWVPr03a1mvwGAldmtayuTuCorTPQUzWeeYTxZtmU/PulHWNTkvF1hjkl7QL8QCq+LLvilqN5RBMvMdGhLOGHjmd87dKvLylGjtJBtIeacAbxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473691; c=relaxed/simple;
	bh=/I4gRuAY+9yV4WZZCvc9rCWvlis8WNAnHPuOzKKj7MY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FlemGHERTa+d8xJxYyeEICXBo0sCCygiUxpe5F8xbKh/HOScX+MYMzaj4feN6YGyviqfry61EAkR45x0IioDiHvdc4byeHrFAWuD+HOTySGjhx8+lqC7Cdsz5xwMyXDY45okhQWQiwNLKGifFwKJJ9I8otbfrHIWZnoAnWBXJMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=kVxhzXzZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfX4N2Ey; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A501B11400AA;
	Tue, 20 Feb 2024 19:01:28 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Tue, 20 Feb 2024 19:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708473688; x=1708560088; bh=9YTLyG9tb9
	qwHs0SFoTK3ScQB6PlmICQ44TTYCKrC5o=; b=kVxhzXzZmn7hj+6mgFXOVokyav
	lCaLqKumpsulsLXGTvVnxEWUmPgk3beZjUOmln7+VLXatGMfoEHkGsEkCXseHXhT
	7CAGPf29zRfoFCUMLKvyMJfuQ1TkpoCz8BwJMshf4l906Y2p7F7ZolWmbc/dHHM/
	1oNxt2kgjBF+vYAptCL50Hq4SMC7sBpj1hRQXH+MOp7ABWMNIreciEhn8avw4qxE
	Bk+nWlTgFfbS7qyBQhyY/XasWYCaR16B2T8S14I3oo4RydpBS6b3leFwsMvFEfSk
	WzLrWSpVxCqGXi+q2QBTY7xh3eu7G7lpM6DS/cfmsYK+InbUrbfBjJC6CaWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708473688; x=1708560088; bh=9YTLyG9tb9qwHs0SFoTK3ScQB6Pl
	mICQ44TTYCKrC5o=; b=IfX4N2Ey86gmbZjVyn/vLXR0lh1ez+mOvJ4plJ/AMDkA
	hI5xmHgQYZo11XOJJd5JKNaIUiPszr9iZhEpv7k3mBEbSm3LLUCxGam9N+HZje/l
	fglnShnuxVTeOWZmT3i46EGPYvXLNEbx74MydPVYQtzP0nJ1Hk1ESm5Dj624ol2B
	aiFWu6Qm+2WcRPkt13WhtOgCOXLjZ5GhSQrQK1avIUsw4FJ5zo/OT79kcQ6Ucuow
	mWjhEK2zMsHidBZviMomaoXIqfU4CP7ssd+QD3f8kVhcHMLy+9ACgz58kpgVLwsP
	jtStzC+ljyR0cPWscJApHK/fgsMrWHSeMOXKKvlCdQ==
X-ME-Sender: <xms:WD3VZQY6Bt9JwdpkP2gdeWwWDIaiRCE6BYsvT7NTdMiW6m5CXZ12tA>
    <xme:WD3VZbY0RoegcGWJdpK5YRE2v37hCGXCfiLEoc82yxqlVhXvN4ybgwJ6NUrue-Mh9
    spMHo73-LSXrb7aiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuthgv
    fhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeefudejvdejuddvjeejudekgfeikeevveevleeitddvtedujeeg
    jeejgfeugfeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WD3VZa9NaA9rm6BP5Sz3r3usECMEVZfLYAY4bn_4-i2iT26yvWOsGA>
    <xmx:WD3VZaq5a-kshur8EUIMhhgx37GIBhmBNiR3dXM-XVlEhQPoTts4ng>
    <xmx:WD3VZbqNqPzGbDf_ZVNsCgnyVdNX1rShVxuTNmcNSjDnqG6CpTtnRg>
    <xmx:WD3VZVvHBC--GNUwYN0A_9wnJyGaq_E4BqiUg9gutmtkbRANVqacOw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id DCD61170009E; Tue, 20 Feb 2024 19:01:27 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <063acc75-ea1d-4dd3-aecb-e5c8884005db@app.fastmail.com>
In-Reply-To: <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
 <22a53b78-10d7-4a5a-a01e-b2f3a8c22e94@app.fastmail.com>
 <4c7bdf8fde9cc45174f10b9221fa58ffb450b755.camel@intel.com>
 <20240220185714.GO4163@brightrain.aerifal.cx>
 <9fc9c45ff6e14df80ad023e66ff7a978bd4ec91c.camel@intel.com>
Date: Tue, 20 Feb 2024 18:59:58 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Rich Felker" <dalias@libc.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "Suzuki K Poulose" <suzuki.poulose@arm.com>,
 "Szabolcs Nagy" <Szabolcs.Nagy@arm.com>,
 "musl@lists.openwall.com" <musl@lists.openwall.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "Mark Brown" <broonie@kernel.org>,
 "Oliver Upton" <oliver.upton@linux.dev>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, debug <debug@rivosinc.com>,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "shuah@kernel.org" <shuah@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
 "Marc Zyngier" <maz@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
 "Florian Weimer" <fweimer@redhat.com>,
 "Kees Cook" <keescook@chromium.org>, "James Morse" <james.morse@arm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Will Deacon" <will@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Thiago Jung Bauermann" <thiago.bauermann@linaro.org>,
 "H.J. Lu" <hjl.tools@gmail.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Ard Biesheuvel" <ardb@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [musl] Re: [PATCH v8 00/38] arm64/gcs: Provide support for GCS in
 userspace
Content-Type: text/plain

On Tue, Feb 20, 2024, at 6:30 PM, Edgecombe, Rick P wrote:
> On Tue, 2024-02-20 at 13:57 -0500, Rich Felker wrote:
>> On Tue, Feb 20, 2024 at 06:41:05PM +0000, Edgecombe, Rick P wrote:
>> > Hmm, could the shadow stack underflow onto the real stack then? Not
>> > sure how bad that is. INCSSP (incrementing the SSP register on x86)
>> > loops are not rare so it seems like something that could happen.
>> 
>> Shadow stack underflow should fault on attempt to access
>> non-shadow-stack memory as shadow-stack, no?
>
> Maybe I'm misunderstanding. I thought the proposal included allowing
> shadow stack access to convert normal address ranges to shadow stack,
> and normal writes to convert shadow stack to normal.

Ideally for riscv only writes would cause conversion, an incssp underflow
which performs shadow stack reads would be able to fault early.

For arm, since a syscall is needed anyway to set up the token in a new
shadow stack region, it would make sense for conversion from non-shadow
to shadow usage to never be automatic.

>> > 
>> > Won't this prevent catching stack overflows when they happen? An
>> > overflow will just turn the shadow stack into normal stack and only
>> > get
>> > detected when the shadow stack unwinds?
>> 
>> I don't think that's as big a problem as it sounds like. It might
>> make
>> pinpointing the spot at which things went wrong take a little bit
>> more
>> work, but it should not admit any wrong-execution.
>
> Right, it's a point about debugging. I'm just trying to analyze the
> pros and cons and not calling it a showstopper.

It's certainly undesirable, so I'd like to have both mechanisms available
(shadow stacks in ordinary memory to support several problematic APIs,
and in dedicated mappings with guard pages otherwise).

>> > 
>> > Shadow stacks currently have automatic guard gaps to try to prevent
>> > one
>> > thread from overflowing onto another thread's shadow stack. This
>> > would
>> > somewhat opens that up, as the stack guard gaps are usually
>> > maintained
>> > by userspace for new threads. It would have to be thought through
>> > if
>> > these could still be enforced with checking at additional spots.
>> 
>> I would think the existing guard pages would already do that if a
>> thread's shadow stack is contiguous with its own data stack.
>
> The difference is that the kernel provides the guard gaps, where this
> would rely on userspace to do it. It is not a showstopper either.
>
> I think my biggest question on this is how does it change the
> capability for two threads to share a shadow stack. It might require
> some special rules around the syscall that writes restore tokens. So
> I'm not sure. It probably needs a POC.

I'm not quite understanding what the property you're looking for here is.

>> From the musl side, I have always looked at the entirely of shadow
>> stack stuff with very heavy skepticism, and anything that breaks
>> existing interface contracts, introduced places where apps can get
>> auto-killed because a late resource allocation fails, or requires
>> applications to code around the existence of something that should be
>> an implementation detail, is a non-starter. To even consider shadow
>> stack support, it must truely be fully non-breaking.
>
> The manual assembly stack switching and JIT code in the apps needs to
> be updated. I don't think there is a way around it.

Naturally.  If an application uses nonportable functionality like JIT
and inline assembly, it's fine (within reason) for those nonportable
components to need changes for shadow stack support.

The objective of this proposal is to allow applications that do _not_
use inline assembly but rather only C APIs defined in POSIX.1-2004 to
execute correctly in an environment where shadow stacks are enabled
by default.

> I agree though that the late allocation failures are not great. Mark is
> working on clone3 support which should allow moving the shadow stack
> allocation to happen in userspace with the normal stack. Even for riscv
> though, doesn't it need to update a new register in stack switching?
>
> BTW, x86 shadow stack has a mode where the shadow stack is writable
> with a special instruction (WRSS). It enables the SSP to be set
> arbitrarily by writing restore tokens. We discussed this as an option
> to make the existing longjmp() and signal stuff work more transparently
> for glibc.
>
>> 
>> > > _Without_ doing this, sigaltstack cannot be used to recover from
>> > > stack
>> > > overflows if the shadow stack limit is reached first, and
>> > > makecontext
>> > > cannot be supported without memory leaks and unreportable error
>> > > conditions.
>> > 
>> > FWIW, I think the makecontext() shadow stack leaking is a bad idea.
>> > I
>> > would prefer the existing makecontext() interface just didn't
>> > support
>> > shadow stack, rather than the leaking solution glibc does today.
>> 
>> AIUI the proposal by Stefan makes it non-leaking because it's just
>> using normal memory that reverts to normal usage on any
>> non-shadow-stack access.
>> 
>
> Right, but does it break any existing apps anyway (because of small
> ucontext stack sizes)?

Possibly, but that's what SIGSTKSZ/MINSIGSTKSZ is for.  This is already
variable on several platforms due to variable-length vector extensions.

> BTW, when I talk about "not supporting" I don't mean the app should
> crash. I mean it should instead run normally, just without shadow stack
> enabled. Not sure if that was clear. Since shadow stack is not
> essential for an application to function, it is only security hardening
> on top.

I appreciate that.  How far can we go in that direction?  If we can
automatically disable shadow stacks on any call to makecontext, sigaltstack,
or pthread_attr_setstack without causing other threads to crash if they were
in the middle of shadow stack maintenance we can probably simplify this
proposal, although I need to think more about what's possible.

> Although determining if an application supports shadow stack has turned
> out to be difficult in practice. Handling dlopen() is especially hard.

How so?  Is the hard part figuring out if you need to do something, or
doing it?

-s

