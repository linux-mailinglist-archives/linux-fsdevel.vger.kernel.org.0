Return-Path: <linux-fsdevel+bounces-23440-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AF992C4C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 22:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3026F1C209D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EDB146D74;
	Tue,  9 Jul 2024 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="lcV5oubD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DE415216C
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jul 2024 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557741; cv=none; b=jcKoFHw86yw/2btNyRBxaMsr8rfAdpiVVxdxCbok8yQOtwTiq4UmsKGZIKy/566vynltyJvacaA7DmAgTH7AokCCXUjWSXh5BbPUo3OoUDujJVs5iZEiXrICVrcj9b3CkQ2nwphf+ouWK6waVXllDtLogzdMtYuUYprYEiFj1YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557741; c=relaxed/simple;
	bh=aZw9C8tFPyShePfTza2iIJraUiRpHMpnuObC6NWgnsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSdXR3xkxO3iF51la7MUkgbf8IbiKSEwYqR9AhtwtCOEtTUx1ABZGFC9VyCdFbYtbP1woz834SVu208k8iQ+hpepsEuOhhwZKsTmTWLiE8BzUiRu/xspxMEl+uE2CLdbeqwtb2HHe9NmovOlI4MUEGTstEVhjQ7fwwhSqF6hGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=lcV5oubD; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WJXwf5vhJzsJ2;
	Tue,  9 Jul 2024 22:42:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720557730;
	bh=b/6BV4qENhC2jLKcP5I5zsdG+AAW0O4kWpLE4Pdgsx4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lcV5oubD1HhBRpEpPcxMKtGDQ9TqcBhGdXp79aW87IvdgoYtwICUbJiuLCQusIsIV
	 zh8XujpWxWy+Q6jb/cLpy5yf5/lNSPPTQTakgJ4Fnp3uiHbRPiZzsRSnz0PcG6yhmS
	 Xf0ItQwcE5vjbwKGxHDcSNrW5WjR6671nkei7WCU=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4WJXwP3TsTz1q7;
	Tue,  9 Jul 2024 22:41:57 +0200 (CEST)
Date: Tue, 9 Jul 2024 22:41:54 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jeff Xu <jeffxu@google.com>
Cc: Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, Theodore Ts'o <tytso@mit.edu>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, Vincent Strubel <vincent.strubel@ssi.gouv.fr>, 
	Xiaoming Ni <nixiaoming@huawei.com>, Yin Fengwei <fengwei.yin@intel.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
Message-ID: <20240709.eud4ao8Kie6n@digikod.net>
References: <20240704190137.696169-1-mic@digikod.net>
 <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
 <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
 <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
 <87r0c3dc1c.fsf@oldenburg.str.redhat.com>
 <CALmYWFvA7VPz06Tg8E-R_Jqn2cxMiWPPC6Vhy+vgqnofT0GELg@mail.gmail.com>
 <20240709.gae4cu4Aiv6s@digikod.net>
 <CALmYWFsvKq+yN4qHhBamxyjtcy9myg8_t3Nc=5KErG=DDaDAEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALmYWFsvKq+yN4qHhBamxyjtcy9myg8_t3Nc=5KErG=DDaDAEA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Jul 09, 2024 at 11:57:27AM -0700, Jeff Xu wrote:
> On Tue, Jul 9, 2024 at 2:18 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Mon, Jul 08, 2024 at 10:52:36AM -0700, Jeff Xu wrote:
> > > On Mon, Jul 8, 2024 at 10:33 AM Florian Weimer <fweimer@redhat.com> wrote:
> > > >
> > > > * Jeff Xu:
> > > >
> > > > > On Mon, Jul 8, 2024 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> > > > >>
> > > > >> * Jeff Xu:
> > > > >>
> > > > >> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > > > >> > libraries too ?  or just the main executable itself.
> > > > >>
> > > > >> I expect that dynamic linkers will have to do this for everything they
> > > > >> map.
> > > > > Then all the objects (.so, .sh, etc.) will go through  the check from
> > > > > execveat's main  to security_bprm_creds_for_exec(), some of them might
> > > > > be specific for the main executable ?
> >
> > Yes, we should check every executable code (including seccomp filters)
> > to get a consistent policy.
> >
> > What do you mean by "specific for the main executable"?
> >
> I meant:
> 
> The check is for the exe itself, not .so, etc.
> 
> For example:  /usr/bin/touch is checked.
> not the shared objects:
> ldd /usr/bin/touch
> linux-vdso.so.1 (0x00007ffdc988f000)
> libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f59b6757000)
> /lib64/ld-linux-x86-64.so.2 (0x00007f59b6986000)

ld.so should be patched to check shared-objects.

> 
> Basically, I asked if the check can be extended to shared-objects,
> seccomp filters, etc, without modifying existing LSMs.

Yes, the check should be used against any piece of code such as
shared-objects, seccomp filters...

> you pointed out "LSM should not need to be updated with this patch
> series.", which already answered my question.
> 
> Thanks.
> -Jeff
> 
> -Jeff

