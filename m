Return-Path: <linux-fsdevel+bounces-47720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3112AA4A49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 13:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BE694E0869
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 11:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D554242909;
	Wed, 30 Apr 2025 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TaCeVghT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9A1E8329
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746013205; cv=none; b=MjkLD/YiubbvW6zlfZ42fs183KeHNQPHDh2n1iOcgG148Ml7E2qho4ulHgSM4P+FIYD/NRnmePmacrX6CY6Vm5tY/fBo37HwGRRZznqo1+NoS4q7kM/y4ACbT1PWd4mj8os/KO54cmh3A8JihPqyUeWaj3ERYBMQUaG2/Veh0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746013205; c=relaxed/simple;
	bh=keoLtY0ClvPPjGIwINcGj7HgHhBF8AtBoEsqH+2vw4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QJ5g70RLJ8ZWcRewyp/vHx/FfbIRNkPbhSul0WRkAY87Rsuu8DSmt6S2qpxhg4UZXhgfG+E5eQwayTLZ1vyIa4eAOjKVzrjmUk0zKNCNytwzger+m8mfv1D6yeUQ6SG/Mzy2utk4b2/xkEV2w/g70GA6uVsgYFyPUmsRtjLhuUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TaCeVghT; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 08ECB3FC4D
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746013201;
	bh=Czegh8cwsRC1992QA7zOdLzmcoA2LPWmJVr38XiyDEw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version;
	b=TaCeVghTSO4U3zJWz7zzw+jZurlQLv6EO272wU7t6WAn5owFLibHALCdtNC799hSu
	 w5BIXwGaSYswHDulLp3Ujr1DU+UL4RqUo726+kekHagTM+fuf9/zaowXbA+6tx8BvC
	 3IANLMukwSZOqG5ljC20k0AtyrIc9rSZKa2ywXobPOlPJEVlUV1Y8m5x6rrQZxLeDr
	 QxXfWw/1R+xvtHU/mFRJZu9feNXmZIGPDp5hkz3gRpHz7ZWCm1xs/zYN34bcWwTo0V
	 vBc87xpwlqqolteDQCGABTamcMeeh3DIsuEBMhYZ++fMeJmiDyeOGQWbjiSENsExW/
	 tnk0rjyI5HdTA==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb66d17be4so542559766b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 04:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746013200; x=1746618000;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Czegh8cwsRC1992QA7zOdLzmcoA2LPWmJVr38XiyDEw=;
        b=IqmsjbNOitFBviufTvnGfEI3Qlwu9lV5eCPcJN6fStnkz9a9cHupKycsKp41K0vnFe
         PIjlqQVdMPO7dsZnIkDI/RrVi5JNriCq9wDs6OL/u/96amQ+xTDjP9Mc+SBFT1Cj6n1X
         4S2kPyiaErg/IBRTuScf6Gv2qGlVAvPVe2xNMtbC1WNeiKuOnWvwLNGP1ytFvEB3Qgoh
         aCuIDHVxX98AuoeHVLaT283Ai8bf85/wZCeJpM7L1nKHJA1yXozzfJgm2fuOKB9Edldz
         DpH0lMC3znibETmuvN9zXaA/5c4k96Vc+HaLl0hz7n3SSJxykK376k6NdTReFa9S5lEt
         y7YA==
X-Gm-Message-State: AOJu0YydG2ARDp7SKaX0IGzYxveIx+72hIRZgyWgXZDk4YlL0/BggG0I
	bd19bhVhxBjXohDjnOrAoSmP6dZqs/PNsoLLgLFylWmYGT6vnOYsXi3As06OYsAun5cog1lWzRu
	Fhx2QFh40N3k4KyFSmDXu5+18b9cBEBcycO9P930W5gRTYyGfMOvVBNyP5MRBy7I/2K3SkqCQSK
	FQ7Gc=
X-Gm-Gg: ASbGncu97xaSsQ0Xnrb5q8GSI1kNEoGyX9nxGedPsgnT4+BHBZz+zEF96U1bglCZI7m
	H+63uPmTFK/V46wJgQh/GCG31AdKRODmp06rRZcuz5fko7cjoYBmgvh+Hxq0s9vl1XZYNXBgGMs
	/dxLf3Ycg6tUPbapzjFiNvdCX7vgkFHyU7WljEOUjjZbOb4Lbd/EXDNlo+8j3pFcsgySZuUYgc3
	WYLcgmUzu2YQFjpi/iVfolRuexwUTjArFv1VpCwGApGDVnoDeBTtQATCw3D+n3id09leqooFKe/
	Faz0Jp47bN69qjdM2f+vYf8iNf36TfxK
X-Received: by 2002:a17:906:f58f:b0:ac4:5f1:a129 with SMTP id a640c23a62f3a-acedc5d0772mr310943266b.15.1746013200483;
        Wed, 30 Apr 2025 04:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwGN7zPSr1vWN8boTb1dQr3YrLPCs0tsLJqWnnJxAwwideDbsjRmhwrhmWzrvFSqwMK2QihQ==
X-Received: by 2002:a17:906:f58f:b0:ac4:5f1:a129 with SMTP id a640c23a62f3a-acedc5d0772mr310939566b.15.1746013200018;
        Wed, 30 Apr 2025 04:40:00 -0700 (PDT)
Received: from deep-thought.gnur.de ([95.89.205.15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6eda7affsm915636866b.170.2025.04.30.04.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 04:39:59 -0700 (PDT)
Message-ID: <43933af22cdbff81e75a07461b29b91afacedadc.camel@canonical.com>
Subject: Re: [PATCH v2 3/3] coredump: hand a pidfd to the usermode coredump
 helper
From: Benjamin Drung <benjamin.drung@canonical.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Luca
 Boccassi <luca.boccassi@gmail.com>, Lennart Poettering
 <lennart@poettering.net>, Daan De Meyer	 <daan.j.demeyer@gmail.com>, Mike
 Yuan <me@yhndnzj.com>, Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=	
 <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org
Date: Wed, 30 Apr 2025 13:39:58 +0200
In-Reply-To: <20250425-erbschaft-nummer-8ddbe420ae22@brauner>
References: <20250414-work-coredump-v2-0-685bf231f828@kernel.org>
	 <20250414-work-coredump-v2-3-685bf231f828@kernel.org>
	 <ee1263a1bcb7510f2ec7a4c34e5c64b3a1d21d7a.camel@canonical.com>
	 <20250425-eskapaden-regnen-4534af2aef11@brauner>
	 <e1ee6aba07c367b9518fe3fab1dd71c418e3446a.camel@canonical.com>
	 <20250425-erbschaft-nummer-8ddbe420ae22@brauner>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 18:49 +0200, Christian Brauner wrote:
> On Fri, Apr 25, 2025 at 02:03:34PM +0200, Benjamin Drung wrote:
> > On Fri, 2025-04-25 at 13:57 +0200, Christian Brauner wrote:
> > > On Fri, Apr 25, 2025 at 01:31:56PM +0200, Benjamin Drung wrote:
> > > > Hi,
> > > >=20
> > > > On Mon, 2025-04-14 at 15:55 +0200, Christian Brauner wrote:
> > > > > Give userspace a way to instruct the kernel to install a pidfd in=
to the
> > > > > usermode helper process. This makes coredump handling a lot more
> > > > > reliable for userspace. In parallel with this commit we already h=
ave
> > > > > systemd adding support for this in [1].
> > > > >=20
> > > > > We create a pidfs file for the coredumping process when we proces=
s the
> > > > > corename pattern. When the usermode helper process is forked we t=
hen
> > > > > install the pidfs file as file descriptor three into the usermode
> > > > > helpers file descriptor table so it's available to the exec'd pro=
gram.
> > > > >=20
> > > > > Since usermode helpers are either children of the system_unbound_=
wq
> > > > > workqueue or kthreadd we know that the file descriptor table is e=
mpty
> > > > > and can thus always use three as the file descriptor number.
> > > > >=20
> > > > > Note, that we'll install a pidfd for the thread-group leader even=
 if a
> > > > > subthread is calling do_coredump(). We know that task linkage has=
n't
> > > > > been removed due to delay_group_leader() and even if this @curren=
t isn't
> > > > > the actual thread-group leader we know that the thread-group lead=
er
> > > > > cannot be reaped until @current has exited.
> > > > >=20
> > > > > Link: https://github.com/systemd/systemd/pull/37125 [1]
> > > > > Tested-by: Luca Boccassi <luca.boccassi@gmail.com>
> > > > > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > > > > ---
> > > > >  fs/coredump.c            | 59 ++++++++++++++++++++++++++++++++++=
++++++++++----
> > > > >  include/linux/coredump.h |  1 +
> > > > >  2 files changed, 56 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > > > index 9da592aa8f16..403be0ff780e 100644
> > > > > --- a/fs/coredump.c
> > > > > +++ b/fs/coredump.c
> > > > > @@ -43,6 +43,9 @@
> > > > >  #include <linux/timekeeping.h>
> > > > >  #include <linux/sysctl.h>
> > > > >  #include <linux/elf.h>
> > > > > +#include <linux/pidfs.h>
> > > > > +#include <uapi/linux/pidfd.h>
> > > > > +#include <linux/vfsdebug.h>
> > > > > =20
> > > > >  #include <linux/uaccess.h>
> > > > >  #include <asm/mmu_context.h>
> > > > > @@ -60,6 +63,12 @@ static void free_vma_snapshot(struct coredump_=
params *cprm);
> > > > >  #define CORE_FILE_NOTE_SIZE_DEFAULT (4*1024*1024)
> > > > >  /* Define a reasonable max cap */
> > > > >  #define CORE_FILE_NOTE_SIZE_MAX (16*1024*1024)
> > > > > +/*
> > > > > + * File descriptor number for the pidfd for the thread-group lea=
der of
> > > > > + * the coredumping task installed into the usermode helper's fil=
e
> > > > > + * descriptor table.
> > > > > + */
> > > > > +#define COREDUMP_PIDFD_NUMBER 3
> > > > > =20
> > > > >  static int core_uses_pid;
> > > > >  static unsigned int core_pipe_limit;
> > > > > @@ -339,6 +348,27 @@ static int format_corename(struct core_name =
*cn, struct coredump_params *cprm,
> > > > >  			case 'C':
> > > > >  				err =3D cn_printf(cn, "%d", cprm->cpu);
> > > > >  				break;
> > > > > +			/* pidfd number */
> > > > > +			case 'F': {
> > > > > +				/*
> > > > > +				 * Installing a pidfd only makes sense if
> > > > > +				 * we actually spawn a usermode helper.
> > > > > +				 */
> > > > > +				if (!ispipe)
> > > > > +					break;
> > > > > +
> > > > > +				/*
> > > > > +				 * Note that we'll install a pidfd for the
> > > > > +				 * thread-group leader. We know that task
> > > > > +				 * linkage hasn't been removed yet and even if
> > > > > +				 * this @current isn't the actual thread-group
> > > > > +				 * leader we know that the thread-group leader
> > > > > +				 * cannot be reaped until @current has exited.
> > > > > +				 */
> > > > > +				cprm->pid =3D task_tgid(current);
> > > > > +				err =3D cn_printf(cn, "%d", COREDUMP_PIDFD_NUMBER);
> > > > > +				break;
> > > > > +			}
> > > > >  			default:
> > > > >  				break;
> > > > >  			}
> > > > >=20
> > > >=20
> > > > I tried this change with Apport: I took the Ubuntu mainline kernel =
build
> > > > https://kernel.ubuntu.com/mainline/daily/2025-04-24/ (that refers t=
o
> > > > mainline commit e54f9b0410347c49b7ffdd495578811e70d7a407) and appli=
ed
> > > > these three patches on top. Then I modified Apport to take the
> > > > additional `-F%F` and tested that on Ubuntu 25.04 (plucky). The res=
ult
> > > > is the coredump failed as long as there was `-F%F` on
> > >=20
> > > I have no clue what -F%F is and whether that leading -F is something
> > > specific to Apport but the specifier is %F not -F%F. For example:
> > >=20
> > >         > cat /proc/sys/kernel/core_pattern
> > >         |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %F
> > >=20
> > > And note that this requires the pipe logic to be used, aka "|" needs =
to
> > > be specified. Without it this doesn't make sense.
> >=20
> > Apport takes short option parameters. They match the kernel template
> > specifiers. The failing pattern:
> >=20
> > $ cat /proc/sys/kernel/core_pattern=20
> > > /usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -F%F -- %=
E
> >=20
> > Once I drop %F Apport is called without issues:
> >=20
> > $ cat /proc/sys/kernel/core_pattern=20
> > > /usr/share/apport/apport -p%p -s%s -c%c -d%d -P%P -u%u -g%g -- %E
>=20
> Youm must have CONFIG_DEBUG_VFS=3Dy enabled where we trample the pidfs
> file we just allocated. It's a debug only assert. I've removed it now
> and pushed it to vfs-6.16.coredump. Can you either try with that or
> simply unset CONFIG_DEBUG_VFS and retest.

Yes, the Ubuntu mainline builds have CONFIG_DEBUG_VFS=3Dy set. I tried
your vfs-6.16.coredump and it works. Thanks.

--=20
Benjamin Drung
Debian & Ubuntu Developer

