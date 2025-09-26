Return-Path: <linux-fsdevel+bounces-62865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E60BA31AC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 11:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221463A40C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5C4270EDE;
	Fri, 26 Sep 2025 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="auatWujk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2311A9FA4;
	Fri, 26 Sep 2025 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758878321; cv=none; b=AuEqBvA5s/EbIcQ9tis2/K/q1VU4jp1B2YcCTv3rH2Mw3hvLO+sQbtYtUsr70BO8XbHKMkag0o8BhTjI5QOzNQapKw95KHJtxMnQ/Pacuyxks9DhHLb9P6TqcoSmZWALLE47Hh9tefWeu1er0PUkuY+w+11uRpX4s4yKNz4xekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758878321; c=relaxed/simple;
	bh=lozI3rl4zYPj97+CWWSBZu7ZX5RoUVvRnwJ1TdPsGdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb+y2DG5ZX3Rigpl8jN4Jwy1LPfG2rHICC/bTEYDEB9lPuIDMYp9yAfIi2c5Z7a28jsaVfTv9EpnRtLMmxV18/VK69pKf3YzAPjEvUduu6FNL/wR/DKdR7BSXDLRIiebW+hU1OtrzAwsWJpPsJqSG+EE1GDao41FrW2nEFXq4g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=auatWujk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C77C4CEF5;
	Fri, 26 Sep 2025 09:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758878320;
	bh=lozI3rl4zYPj97+CWWSBZu7ZX5RoUVvRnwJ1TdPsGdA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=auatWujkfRpKBdRW67k1fiCj6qbuY/xjW4qiWWAKnnyh/2n6zd1/wPHUjAiufZPcQ
	 S5y+ZEAaizML6tcb3rSjiXUe47FDsGw7wNI1ulDWyAs4+00JxkxFsuBWDrgV5TuTKP
	 ROmO8MMuo6JN0KvEjVqfxrpDxOJBwGcczPp0s0rIu1d73f50azw7TjB3xyGGhBY8u/
	 gEViDXzrlU4C13oqZd01HBxdYqpcdpQyjScqqYDdaIctupGbCnKepNQi+EWwwAYT0C
	 kZzYXRAv9+H15Pama42fw3Uev+fhrcVK6bRKBEFkMJLneYNe0q5YblftIpXUC0kKdN
	 zFEfdhM3X+b0Q==
Date: Fri, 26 Sep 2025 11:18:34 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Waiman Long <longman@redhat.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Konstantin Khorenko <khorenko@virtuozzo.com>, 
	Denis Lunev <den@virtuozzo.com>, Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH] locking: detect spin_lock_irq() call with disabled
 interrupts
Message-ID: <xdfm634qqtchbaqfnnnmwqwmto5bllkspfixescyxltvjb4y2c@l4uiiarg5kjs>
References: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k7cespx45mtvkcmy"
Content-Disposition: inline
In-Reply-To: <20250606095741.46775-1-ptikhomirov@virtuozzo.com>


--k7cespx45mtvkcmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 06, 2025 at 05:57:23PM +0800, Pavel Tikhomirov wrote:
> This is intended to easily detect irq spinlock self-deadlocks like:
>=20
>   spin_lock_irq(A);
>   spin_lock_irq(B);
>   spin_unlock_irq(B);
>     IRQ {
>       spin_lock(A); <- deadlocks
>       spin_unlock(A);
>     }
>   spin_unlock_irq(A);
=2E..
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9b4f0cff76ea..1e3cca2e3c8f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -50,6 +50,7 @@
>  #include <linux/sched/sysctl.h>
>  #include <linux/mount.h>
>  #include <linux/pid.h>
> +#include <linux/spinlock.h>
> =20
>  #include "../lib/kstrtox.h"
> =20
> @@ -1758,6 +1759,14 @@ static const struct ctl_table kern_table[] =3D {
>  		.extra2		=3D SYSCTL_INT_MAX,
>  	},
>  #endif
> +#ifdef CONFIG_DEBUG_SPINLOCK
> +	{
> +		.procname	=3D "debug_spin_lock_irq_with_disabled_interrupts",
> +		.data		=3D &debug_spin_lock_irq_with_disabled_interrupts,
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_do_static_key,
> +	},
> +#endif
Patchwork reminded me about this one and I see now that I missed a
comment. In case you are working on a V2, do *NOT* add more ctl_table
elements to the kern_table. If you need to add a sysctl file for
locking, do it under kernel/locking. You can take inspiration from how
rtmutex_sysctl_table and "max_lock_depth" is handled.

best

>  };
> =20
>  int __init sysctl_init_bases(void)
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ebe33181b6e6..c4834f4c9d51 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1465,6 +1465,18 @@ config DEBUG_SPINLOCK
>  	  best used in conjunction with the NMI watchdog so that spinlock
>  	  deadlocks are also debuggable.
> =20
> +config DEBUG_SPINLOCK_IRQ_WITH_DISABLED_INTERRUPTS_BY_DEFAULT
> +	bool "Detect spin_(un)lock_irq() call with disabled(enabled) interrupts"
> +	depends on DEBUG_SPINLOCK
> +	help
> +	  Say Y here to detect spin_lock_irq() and spin_unlock_irq() calls
> +	  with disabled (enabled) interrupts. This helps detecting bugs
> +	  where the code is not using the right locking primitives. E.g.
> +	  using spin_lock_irq() twice in a row (on different locks). And thus
> +	  code can reenable interrupts where they should be disabled and lead
> +	  to deadlock.
> +	  Say N if you are unsure.
> +
>  config DEBUG_MUTEXES
>  	bool "Mutex debugging: basic checks"
>  	depends on DEBUG_KERNEL && !PREEMPT_RT
> --=20
> 2.49.0
>=20

--=20

Joel Granados

--k7cespx45mtvkcmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmjWWmIACgkQupfNUreW
QU8Elgv/WDqex30sO8Ki9Qu5tHKSCYM01F/5F/RqfX6PZYf4LbXfDcR1GVgzBdN5
L8Ie7oZFSVITFTunbdp33Z95aZ3z3wVQmU8+zT6YJ7RU77OEMcHtpEd/CVocmfnn
tA7+2NqWKaEFbWqhoeKfEx42hXGB7dqsi5vXl8B2srVWOx98lFP9AgjuBDDWHltD
HYOb+0IW9dfbNuVnWfYOM/WUxbqt4bjqbzqGj19n7cIp8q01Aoj0MT3Dke1S21SY
ofIuaElyqg5fbtYOshHlpcB2vMMc9o+TVIVU5VHreW8fwMdcFleYCYCLYncaKV+2
/9XmnJ4yeT4ohfY2l3EL+FMomev3TYdKZKmvlkecCp7QKp0EPLi2ylvDy0jKQA2X
9S5i+LvjKfehWUJtUku8MWRsc3fy1U0BJpchzcBfi9gDXT1DCRLyu61vy9o48IAf
/Mjr+JJ3Uj4v6D0/ii2xbqnOIPYxd+Bp1sDfpMjS4Yg0KuBpac0udxxycugu/Efe
/eyG3cP1
=gHiA
-----END PGP SIGNATURE-----

--k7cespx45mtvkcmy--

