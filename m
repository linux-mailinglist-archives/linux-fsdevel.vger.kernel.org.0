Return-Path: <linux-fsdevel+bounces-23867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7199341C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6604B22BD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A622183083;
	Wed, 17 Jul 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b="bwM9jGXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631618306A
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239176; cv=none; b=SAL8Tnrmm/CwYktL+RlFZ77PpTw3ieV9xSMV17CTIsybDBK/mApaA7SA1g7EaEwBxbhqoNhoSkPC/1P4x+VrS0dQMOBYKtxvCRdKCKLWusGAqQtclITWuj2xPBZb4rpsnuY6gWtGYcTve349IAET9k94deHshy+rQt+SyCk2cQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239176; c=relaxed/simple;
	bh=H+21wE+2iLRZVcP4hl3SPiAfZGYS6lnRDxIGD4RAScs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ro+NhOoBzEtOVJBnXrpVhl6pAEY1mO6RAy5vKpEGtrE8xhW1KIkyjfgX0zRnN6JQrxnJf3DET6eQx7PCh7ZQQU6+ldHG4qU4u8q/BjZ42/Wb2N6qonRVQ9nWknUWYWJT7NG8bdZ3v6Yz/6c6f/7Kct5UsCT82zGGynSSBmuK188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sempervictus.com; spf=pass smtp.mailfrom=sempervictus.com; dkim=pass (2048-bit key) header.d=sempervictus-com.20230601.gappssmtp.com header.i=@sempervictus-com.20230601.gappssmtp.com header.b=bwM9jGXI; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sempervictus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sempervictus.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e03a0faee1eso59961276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2024 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sempervictus-com.20230601.gappssmtp.com; s=20230601; t=1721239173; x=1721843973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M8eaQLw9xNg9uFvBqSP89sHIql2nuE2XWi7tzCheL6U=;
        b=bwM9jGXIDPY2RP+zfLzAji+xk+1TZw3XnxzIJYrZ3lgTntWgVbzSOoarL9rYRLMUqD
         hRBRPodo2UO5qJfPfhfyJa1qJQLNM9nD3pB4YvHNouUiT87p87jUOjwiQN5ed1X8v919
         RWF/8UKZqFMeQz5GM+LeFAYxqJjbyf9r88HDhjvpZDChOFGBka8+wZTuTYgNnXZaCceA
         N6vTYRoL05roZ5Pwbxlrh4Jr2mTgtrHPm5hi817AUhIOsarZ8pzE44z19Vcd1A3iz+I+
         U1huGfSQoUNFTspen+P1vG+9P2DVOGSrZauJy+pq5qOpLsLbXiHyozBem93kEXtP4a3k
         B6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721239173; x=1721843973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M8eaQLw9xNg9uFvBqSP89sHIql2nuE2XWi7tzCheL6U=;
        b=b9rGyGFCXXqjsArZOj4X7VJ+raM3h/ELgkGvToV3nDQ564gDwv0A8PAvJbSvKc/5jZ
         u5CMjvg0h1KeEir6ttUFOqG5oGzfzAXTidytd1qfdVmZTZoNQ9SOk5+R5UhxoRy+n5WJ
         HlJOyAVMUFb0Cxn1LKqf+op5nA8V+Kx5OWgOOGMfqfloB3EOEUoG51EDQ45wL2D/oR1V
         yt41duhIZc+m/Nb4XoVWw0C/3UhCOmcuYvbqSlc3xRYu655EM/Pc4/7CsfbLQUFp+ur9
         mPljXTeYBRpix3WUhcBYIVimFE7qpCP8kfqMl5te70v8JS2yRBsLYjqpmKh8y4hERfF1
         YDTw==
X-Forwarded-Encrypted: i=1; AJvYcCWJezjoEpSH7rhyOjJZSgBU0AcvejdYCRte8/SggUtJxdlKRb++kJ/6angnsvYcAVyGAu+kziM6bMnogB90+BWdrsgOh0QZNbgOoFMmLQ==
X-Gm-Message-State: AOJu0Yy+islymcWNh6JucBX3ommA0/guE/uyVJiESycAQb2k2PyUH3Nq
	ThalZLZdfG/BAIvN4e/JzuHXTnzXhNqxFfRkRwCEFUV/8HUKDh5vVN0jhRWzqguYEWHIAPFbpJi
	aghsiAx7NvL5DYhXyNSXW/orbQgNnRgEBwFvtlA==
X-Google-Smtp-Source: AGHT+IHEIU9neXftIncv5fOI1sUBbkOnPhjhzxfBjmV6pQBNc144cKpBZMqrxy2p/3onnp89VdZ5B8F9Pc4Udgj9/PQ=
X-Received: by 2002:a05:6902:278a:b0:e03:63d0:4516 with SMTP id
 3f1490d57ef6-e05ed7e2324mr2980262276.57.1721239173538; Wed, 17 Jul 2024
 10:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <55b4f6291e8d83d420c7d08f4233b3d304ce683d.camel@linux.ibm.com>
 <20240709.AhJ7oTh1biej@digikod.net> <9e3df65c2bf060b5833558e9f8d82dcd2fe9325a.camel@huaweicloud.com>
 <ee1ae815b6e75021709612181a6a4415fda543a4.camel@HansenPartnership.com>
 <E608EDB8-72E8-4791-AC9B-8FF9AC753FBE@sempervictus.com> <20240716.shaliZ2chohj@digikod.net>
In-Reply-To: <20240716.shaliZ2chohj@digikod.net>
From: Boris Lukashev <rageltman@sempervictus.com>
Date: Wed, 17 Jul 2024 13:59:22 -0400
Message-ID: <CAFUG7CfqAV0vzuFf_WL+wedeRzAfOyRGVWRVhfNBxS3FU78Tig@mail.gmail.com>
Subject: Re: [RFC PATCH v19 0/5] Script execution control (was O_MAYEXEC)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
	Scott Shell <scottsh@microsoft.com>, Shuah Khan <shuah@kernel.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Steve Dower <steve.dower@python.org>, 
	Steve Grubb <sgrubb@redhat.com>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies, sent from phone so plain-text wasn't flying.
To elaborate a bit on the quick commentary there - i'm the happy
camper behind most of the SSL shells, SSH stuff, AWS shells, and so on
in Metasploit. So please take the following with a grain of
tinfoil-hat salt as i'm well aware that there is no perfect defense
against these things which covers all bases while permitting any level
of sane operation in a general-purpose linux system (also work w/
GrapheneOS which is a far more suitable context for this sort of
thing). Having loosely followed the discussion thread, my offsec-brain
$0.02 are:

Shells are the provenance of the post-exploitation world - it's what
we want to get as a result of the exploit succeeding. So i think we
want to keep clear delineation between exploit and post-exp mitigation
as they're actually separate concerns of the killchain.
1. Command shells tend to differentiate from interpreted or binary
execution environments in their use of POSIX file descriptor
primitives such as pipes. How those are marshalled, chained, and
maintained (in a loop or whatever, hiding args, etc) are the only real
IOCs available at this tier for interdiction as observation of data
flow through the pipes is too onerous and complex. Target systems vary
in the post-exp surfaces exposed (/dev/tcp for example) with the
mechanics of that exposure necessitating adaptation of marshalling,
chaining, and maintenance to fit the environment; but the basic
premise of what forms a command shell cannot be mitigated without
breaking POSIX mechanics themselves - offsec devs are no different
from anyone else, we want our code to utilize architectural primitives
instead of undefined behavior for longevity and ecosystem
persistence/relevance.
2. The conversation about interpreted languages is probably a dead-end
unless you want to neuter the interpreter - check out Spencer
McIntyre's work re Python meterpreter or HDs/mine/etc on the PHP side.
The stagers, loaded contexts, execution patterns, etc are all
trivially modified to avoid detection (private versions not submitted
for free ripping by lazy commercial entities to the FOSS ecosystem,
yet). Dynamic code loading of interpreted languages is trivial and
requires no syscalls, just text/serialized IL/etc. The complexity of
loaded context available permits much more advanced functionality than
we get in most basic command interpreter shells - <advanced evasions
go here before doing something that'll get you caught> sort of thing.
3. Lastly, binary payloads such as Mettle have their own advantages re
portability, skipping over libc, etc but need to be "harnessed-in"
from say a command-injection exploit via memfd or similar. We haven't
published our memfd stagers while the relevant sysctl gets adopted
more widely, but we've had them for a long time (meaning real bad guys
have as well) and have other ways to get binary content into
executable memory or make memory containing it executable
(to-the-gills Grsec/PaX systems notwithstanding). IMO, interdiction of
the harnessed injection from a command context is the last time when
anything of use can be done at this layer unless we're sure that we
can trace all related and potentially async (not within the process
tree anyway) syscalls emanating from what happens next. Subsequent
actions are separate "remedial" workflows which is a wholly separate
philosophical discussion about how to handle having been compromised
already.

Security is very much not binary and in that vein of logic i think
that we should probably define our shades of gray as ranges of what we
want to protect/how and at what operational cost to then permit
"dial-in" knobs to actually garner adoption from a broad range of
systems outside the "real hardened efforts." At some point this turns
into "limit users to sftp or git shells" which is a perfectly valid
approach when the context permits that level of draconian restriction
but the architectural breakdown of "native command, interpreted
context, fully binary" shell types is pretty universal with new ones
being API access into runtimes of clouds (SSM/serial/etc) which have
their own set of limitations at execution and interface layers.
Organizing defensive functions to handle the primitives necessary for
each of these shell classes would likely help stratify/simplify this
conversation and allow for more granular tasking toward those specific
objectives.

Thanks,
-Boris


On Tue, Jul 16, 2024 at 1:48=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> (adding back other people in Cc)
>
> On Tue, Jul 16, 2024 at 01:29:43PM -0400, Boris Lukashev wrote:
> > Wouldn't count those shell chickens - awk alone is enough and we can
> > use ssh and openssl clients (all in metasploit public code). As one of
> > the people who makes novel shell types, I can assure you that this
> > effort is only going to slow skiddies and only until the rest of us
> > publish mitigations for this mitigation :)
>
> Security is not binary. :)
>
> Not all Linux systems are equals. Some hardened systems need this kind
> of feature and they can get guarantees because they fully control and
> trust their executable binaries (e.g. CLIP OS, chromeOS) or they
> properly sandbox them.  See context in the cover letter.
>
> awk is a script interpreter that should be patched too, like other Linux
> tools.
>
> >
> > -Boris (RageLtMan)
> >
> > On July 16, 2024 12:12:49 PM EDT, James Bottomley <James.Bottomley@Hans=
enPartnership.com> wrote:
> > >On Tue, 2024-07-16 at 17:57 +0200, Roberto Sassu wrote:
> > >> But the Clip OS 4 patch does not cover the redirection case:
> > >>
> > >> # ./bash < /root/test.sh
> > >> Hello World
> > >>
> > >> Do you have a more recent patch for that?
> > >
> > >How far down the rabbit hole do you want to go?  You can't forbid a
> > >shell from executing commands from stdin because logging in then won't
> > >work.  It may be possible to allow from a tty backed file and not from
> > >a file backed one, but you still have the problem of the attacker
> > >manually typing in the script.
> > >
> > >The saving grace for this for shells is that they pretty much do
> > >nothing on their own (unlike python) so you can still measure all the
> > >executables they call out to, which provides reasonable safety.
> > >
> > >James
> > >

