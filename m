Return-Path: <linux-fsdevel+bounces-23922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1413B934DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2FF28446B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7A913D25E;
	Thu, 18 Jul 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="C7n/fsLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [83.166.143.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33E713B2BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jul 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308631; cv=none; b=Z6cKAFTcMpNLrbOpyyb7FBw27DJYT0TbmryOnTeJd9VqJQusslANCaYiYte/Ivt+b53csREavrBBtR/OcfBtGFawsTlnSL4Des1ybqnBVV//bL+wXeflsnChWk7wzrjKbUE81Z+sL9MAh6OSy2voOR0et5NluClcNUbhy7Cm+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308631; c=relaxed/simple;
	bh=vzEdr3ycJfPBFuAUbXy72gucPqjCh1T03b9cqnKa+wA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLAyf2qMdoI1hJgoJMiy2gciFOTUUr0sGymHELZd9VkGIxybGi8HWSY6I7Xge22BrAZ5ZjRG0hYm2KCFZmKO3/KYKrEIE2GYQXAWnGFYYtcVFCU15GuWIgoRkXLvziTKUlP6jU6o+hbc8Eyd4qm6sECV5X78uMSn+BAOwCZFY8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=C7n/fsLC; arc=none smtp.client-ip=83.166.143.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WPtGQ639tz15Zh;
	Thu, 18 Jul 2024 15:01:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1721307662;
	bh=J24gp/Tp+9NM++IYFDcqaj0N2v5BGnej6oy8lU/5sw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7n/fsLCXTFXltwZ1jGk3kecdyC/zCrKKhYxRxBTeZ+f2tsrgj6wW/TzwffEGmAPv
	 38V/YcgossEECJrZBE9VgA/fbA8Fh69lMbhP/jgmG2ablHuxRqNjO3s7+Mf7+FddHX
	 KKfHtfykVPehp7FRDKHLTvkOo+09t8+BiOo6l5Uk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WPtGJ5Tdwz1wY;
	Thu, 18 Jul 2024 15:00:56 +0200 (CEST)
Date: Thu, 18 Jul 2024 15:00:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Boris Lukashev <rageltman@sempervictus.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
Message-ID: <20240718.joh4Ohgol5ah@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
 <20240709.AhJ7oTh1biej@digikod.net>
 <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
 <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
 <E608EDB8-72E8-4791-AC9B-8FF9AC753FBE@sempervictus.com>
 <20240716.shaliZ2chohj@digikod.net>
 <CAFUG7CfqAV0vzuFf_WL+wedeRzAfOyRGVWRVhfNBxS3FU78Tig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFUG7CfqAV0vzuFf_WL+wedeRzAfOyRGVWRVhfNBxS3FU78Tig@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Jul 17, 2024 at 01:59:22PM -0400, Boris Lukashev wrote:
> Apologies, sent from phone so plain-text wasn't flying.
> To elaborate a bit on the quick commentary there - i'm the happy
> camper behind most of the SSL shells, SSH stuff, AWS shells, and so on
> in Metasploit. So please take the following with a grain of
> tinfoil-hat salt as i'm well aware that there is no perfect defense
> against these things which covers all bases while permitting any level
> of sane operation in a general-purpose linux system (also work w/
> GrapheneOS which is a far more suitable context for this sort of
> thing). Having loosely followed the discussion thread, my offsec-brain
> $0.02 are:
> 
> Shells are the provenance of the post-exploitation world - it's what
> we want to get as a result of the exploit succeeding. So i think we
> want to keep clear delineation between exploit and post-exp mitigation
> as they're actually separate concerns of the killchain.

Indeed.  The goal of this patch series is to control executable code, so
mostly to make exploitation more difficult. When an attacker can execute
code (e.g. with ROP), execution control is already bypassed.

> 1. Command shells tend to differentiate from interpreted or binary
> execution environments in their use of POSIX file descriptor
> primitives such as pipes. How those are marshalled, chained, and
> maintained (in a loop or whatever, hiding args, etc) are the only real
> IOCs available at this tier for interdiction as observation of data
> flow through the pipes is too onerous and complex.

I agree. Only files can reliably be inspected.

> Target systems vary
> in the post-exp surfaces exposed (/dev/tcp for example) with the
> mechanics of that exposure necessitating adaptation of marshalling,
> chaining, and maintenance to fit the environment; but the basic
> premise of what forms a command shell cannot be mitigated without
> breaking POSIX mechanics themselves - offsec devs are no different
> from anyone else, we want our code to utilize architectural primitives
> instead of undefined behavior for longevity and ecosystem
> persistence/relevance.
> 2. The conversation about interpreted languages is probably a dead-end
> unless you want to neuter the interpreter - check out Spencer
> McIntyre's work re Python meterpreter or HDs/mine/etc on the PHP side.
> The stagers, loaded contexts, execution patterns, etc are all
> trivially modified to avoid detection (private versions not submitted
> for free ripping by lazy commercial entities to the FOSS ecosystem,
> yet). Dynamic code loading of interpreted languages is trivial and
> requires no syscalls, just text/serialized IL/etc. The complexity of
> loaded context available permits much more advanced functionality than
> we get in most basic command interpreter shells - <advanced evasions
> go here before doing something that'll get you caught> sort of thing.

Right, if attackers can bring their own code (or even do ROP), it
doesn't matter what it interprets, its arbitrary code execution.

> 3. Lastly, binary payloads such as Mettle have their own advantages re
> portability, skipping over libc, etc but need to be "harnessed-in"
> from say a command-injection exploit via memfd or similar. We haven't
> published our memfd stagers while the relevant sysctl gets adopted
> more widely, but we've had them for a long time (meaning real bad guys
> have as well) and have other ways to get binary content into
> executable memory or make memory containing it executable
> (to-the-gills Grsec/PaX systems notwithstanding). IMO, interdiction of
> the harnessed injection from a command context is the last time when
> anything of use can be done at this layer unless we're sure that we
> can trace all related and potentially async (not within the process
> tree anyway) syscalls emanating from what happens next. Subsequent
> actions are separate "remedial" workflows which is a wholly separate
> philosophical discussion about how to handle having been compromised
> already.

Indeed, there are some prerequisites for a secure system.  In this case
we trust all the system-installed executable code.  If attackers can
fill a memfd with arbitrary code, it means that they already have code
execution.  This patch series will help mitigate some ways to get code
execution.

> 
> Security is very much not binary and in that vein of logic i think
> that we should probably define our shades of gray as ranges of what we
> want to protect/how and at what operational cost to then permit
> "dial-in" knobs to actually garner adoption from a broad range of
> systems outside the "real hardened efforts." At some point this turns
> into "limit users to sftp or git shells" which is a perfectly valid
> approach when the context permits that level of draconian restriction
> but the architectural breakdown of "native command, interpreted
> context, fully binary" shell types is pretty universal with new ones
> being API access into runtimes of clouds (SSM/serial/etc) which have
> their own set of limitations at execution and interface layers.
> Organizing defensive functions to handle the primitives necessary for
> each of these shell classes would likely help stratify/simplify this
> conversation and allow for more granular tasking toward those specific
> objectives.

Thanks for the discussion.  I agree, but the difficulty with this patch
series is that it brings a simple *building block*.  Of course, this
will definitely not be enough to secure any systems, but it will fill a
gap in some secure systems, and it could also harden more generic
systems (e.g. restricted system services which should not need shell
access).  I listed some examples with the new securebits proposal:
https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/

> 
> Thanks,
> -Boris
> 
> 
> On Tue, Jul 16, 2024 at 1:48 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > (adding back other people in Cc)
> >
> > On Tue, Jul 16, 2024 at 01:29:43PM -0400, Boris Lukashev wrote:
> > > Wouldn't count those shell chickens - awk alone is enough and we can
> > > use ssh and openssl clients (all in metasploit public code). As one of
> > > the people who makes novel shell types, I can assure you that this
> > > effort is only going to slow skiddies and only until the rest of us
> > > publish mitigations for this mitigation :)
> >
> > Security is not binary. :)
> >
> > Not all Linux systems are equals. Some hardened systems need this kind
> > of feature and they can get guarantees because they fully control and
> > trust their executable binaries (e.g. CLIP OS, chromeOS) or they
> > properly sandbox them.  See context in the cover letter.
> >
> > awk is a script interpreter that should be patched too, like other Linux
> > tools.
> >
> > >
> > > -Boris (RageLtMan)
> > >
> > > On July 16, 2024 12:12:49 PM EDT, James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> > > >On Tue, 2024-07-16 at 17:57 +0200, Roberto Sassu wrote:
> > > >> But the Clip OS 4 patch does not cover the redirection case:
> > > >>
> > > >> # ./bash < /root/test.sh
> > > >> Hello World
> > > >>
> > > >> Do you have a more recent patch for that?
> > > >
> > > >How far down the rabbit hole do you want to go?  You can't forbid a
> > > >shell from executing commands from stdin because logging in then won't
> > > >work.  It may be possible to allow from a tty backed file and not from
> > > >a file backed one, but you still have the problem of the attacker
> > > >manually typing in the script.
> > > >
> > > >The saving grace for this for shells is that they pretty much do
> > > >nothing on their own (unlike python) so you can still measure all the
> > > >executables they call out to, which provides reasonable safety.
> > > >
> > > >James
> > > >

