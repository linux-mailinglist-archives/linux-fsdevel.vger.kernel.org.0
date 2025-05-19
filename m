Return-Path: <linux-fsdevel+bounces-49428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C20ABC22B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 17:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29630188A6D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63302857C9;
	Mon, 19 May 2025 15:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg+W/TWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C8B2746A;
	Mon, 19 May 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747668036; cv=none; b=ZOoGtwz4OiQr11Vthr1y18ZxRHGR0Lpj4QGFW5f0dLavDo3Hp6SLYNrOePXvE9CRfiwf9y+4WuH6yQJdndz8R5EwXg1J13B2f9o+Ya8bUacMKSAM8jmGkM/v0cgrU2645yaS7e6uCD05SW4lSApXJdWalZ5mfHUGQE0nU6tePDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747668036; c=relaxed/simple;
	bh=hCsytdVeeJL9k59PuEkSeSt24V1PhRpfKVXpzj7jUtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmuY1pafp96XZnbeYS8sjGpmWiuaUkSysChoircafBfcFGvWGnzLE7OOlFFL3zIVN4PlNYNIc3eF9/EntNUE4nBeGEkLVXv0E2atWMLJ6v3Dj4lTQmZAh0h6WfhSEBBEBs2SvlqoPdtfVt4KaAJVmhAYKcG2VP3v3Da6ycANMkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg+W/TWK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31192C4CEE4;
	Mon, 19 May 2025 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747668035;
	bh=hCsytdVeeJL9k59PuEkSeSt24V1PhRpfKVXpzj7jUtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pg+W/TWKKyjgF5xP20j0uAdD0cIn+UCdcUHoBD8pvqnECQMtWaatkCm3ynMk1tcKQ
	 BnFX9YSkQqtUIqBJw8xMqDfNAU80qfQ5jKuhqN8lSxQ1uBnPX+xsF7kROYIXaoGtbi
	 p41LAZ79T2BhxM69kZciPyVjVh+p1iGy9hvmiFowCNVhK4wPPalkEdnOUGWnvX3Ph2
	 N2wvZe/D7j8ui6YHApTHqAm0hdwMIhqIYwg76JLjDrJAoUCh2T4wWySPbqF8c8KZPf
	 XfUUm4HHS5mTc9BxQFVQ59h5CSgXnfwnOolD5CF6/Y97/QLWj/M15r9u+xhM86jyb7
	 M5DYrZNKbxFoQ==
Date: Mon, 19 May 2025 17:20:30 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Kees Cook <kees@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
	linux-parisc@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 01/12] module: Move modprobe_path and modules_disabled
 ctl_tables into the module subsys
Message-ID: <l7dgle5lhsvfrikd4rqvzuwrqwrseucf5ijgnbi6fxook6dnhj@sc7givb3qimb>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
 <e2ebf88d-46a2-4f38-a0c8-940c3d3bee49@suse.com>
 <g3e3ygz4jb73b3zhxexpwacwui3imlwauujzeq2nlopp2i2fjp@lzj33hcwztc2>
 <f6058414-e04d-4b7f-b4e6-3ac3613edbc1@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="otw3l52sr4y45r5c"
Content-Disposition: inline
In-Reply-To: <f6058414-e04d-4b7f-b4e6-3ac3613edbc1@suse.com>


--otw3l52sr4y45r5c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 02:45:22PM +0200, Petr Pavlu wrote:
> On 5/15/25 12:04, Joel Granados wrote:
> > On Thu, May 15, 2025 at 10:04:53AM +0200, Petr Pavlu wrote:
> >> On 5/9/25 14:54, Joel Granados wrote:
> >>> Move module sysctl (modprobe_path and modules_disabled) out of sysctl=
=2Ec
> >>> and into the modules subsystem. Make the modprobe_path variable static
> >>> as it no longer needs to be exported. Remove module.h from the includ=
es
> >>> in sysctl as it no longer uses any module exported variables.
=2E..
> > Like this?:
> > [...]
>=20
> Let's also move the KMOD_PATH_LEN definition and the modprobe_path
> declaration from include/linux/kmod.h to kernel/module/internal.h, as
> they are now fully internal to the module loader, and use "module"
> instead of "kmod" in the sysctl registration to avoid confusion with the
> modprobe logic.
>=20
> The adjusted patch is below.
>=20
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Thx for review and patch. Have applied it to my current V2 branch [1]

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git=
/log/?h=3Djag/mv_ctltables_iter2

>=20
> --=20
> Thanks,
> Petr
>=20
>=20
> diff --git a/include/linux/kmod.h b/include/linux/kmod.h
> index 68f69362d427..9a07c3215389 100644
> --- a/include/linux/kmod.h
> +++ b/include/linux/kmod.h
> @@ -14,10 +14,7 @@
>  #include <linux/workqueue.h>
>  #include <linux/sysctl.h>
> =20
> -#define KMOD_PATH_LEN 256
> -
>  #ifdef CONFIG_MODULES
> -extern char modprobe_path[]; /* for sysctl */
>  /* modprobe exit status on success, -ve on error.  Return value
>   * usually useless though. */
>  extern __printf(2, 3)
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 8050f77c3b64..f4ab8d90c475 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -304,7 +304,6 @@ struct notifier_block;
> =20
>  #ifdef CONFIG_MODULES
> =20
> -extern int modules_disabled; /* for sysctl */
>  /* Get/put a kernel symbol (calls must be symmetric) */
>  void *__symbol_get(const char *symbol);
>  void *__symbol_get_gpl(const char *symbol);
> diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> index 626cf8668a7e..0954c8de00c2 100644
> --- a/kernel/module/internal.h
> +++ b/kernel/module/internal.h
> @@ -58,6 +58,9 @@ extern const struct kernel_symbol __stop___ksymtab_gpl[=
];
>  extern const u32 __start___kcrctab[];
>  extern const u32 __start___kcrctab_gpl[];
> =20
> +#define KMOD_PATH_LEN 256
> +extern char modprobe_path[];
> +
>  struct load_info {
>  	const char *name;
>  	/* pointer to module in temporary copy, freed at end of load_module() */
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index a2859dc3eea6..a336b7b3fb23 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -126,9 +126,37 @@ static void mod_update_bounds(struct module *mod)
>  }
> =20
>  /* Block module loading/unloading? */
> -int modules_disabled;
> +static int modules_disabled;
>  core_param(nomodule, modules_disabled, bint, 0);
> =20
> +static const struct ctl_table module_sysctl_table[] =3D {
> +	{
> +		.procname	=3D "modprobe",
> +		.data		=3D &modprobe_path,
> +		.maxlen		=3D KMOD_PATH_LEN,
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_dostring,
> +	},
> +	{
> +		.procname	=3D "modules_disabled",
> +		.data		=3D &modules_disabled,
> +		.maxlen		=3D sizeof(int),
> +		.mode		=3D 0644,
> +		/* only handle a transition from default "0" to "1" */
> +		.proc_handler	=3D proc_dointvec_minmax,
> +		.extra1		=3D SYSCTL_ONE,
> +		.extra2		=3D SYSCTL_ONE,
> +	},
> +};
> +
> +static int __init init_module_sysctl(void)
> +{
> +	register_sysctl_init("kernel", module_sysctl_table);
> +	return 0;
> +}
> +
> +subsys_initcall(init_module_sysctl);
> +
>  /* Waiting for a module to finish initializing? */
>  static DECLARE_WAIT_QUEUE_HEAD(module_wq);
> =20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9b4f0cff76ea..473133d9651e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -19,7 +19,6 @@
>   *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
>   */
> =20
> -#include <linux/module.h>
>  #include <linux/sysctl.h>
>  #include <linux/bitmap.h>
>  #include <linux/printk.h>
> @@ -1616,25 +1615,6 @@ static const struct ctl_table kern_table[] =3D {
>  		.proc_handler	=3D proc_dointvec,
>  	},
>  #endif
> -#ifdef CONFIG_MODULES
> -	{
> -		.procname	=3D "modprobe",
> -		.data		=3D &modprobe_path,
> -		.maxlen		=3D KMOD_PATH_LEN,
> -		.mode		=3D 0644,
> -		.proc_handler	=3D proc_dostring,
> -	},
> -	{
> -		.procname	=3D "modules_disabled",
> -		.data		=3D &modules_disabled,
> -		.maxlen		=3D sizeof(int),
> -		.mode		=3D 0644,
> -		/* only handle a transition from default "0" to "1" */
> -		.proc_handler	=3D proc_dointvec_minmax,
> -		.extra1		=3D SYSCTL_ONE,
> -		.extra2		=3D SYSCTL_ONE,
> -	},
> -#endif
>  #ifdef CONFIG_UEVENT_HELPER
>  	{
>  		.procname	=3D "hotplug",
>=20

--=20

Joel Granados

--otw3l52sr4y45r5c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgrTDAACgkQupfNUreW
QU/twAv8DxA6gxRLdNSDZrJxSdnvcFu76bvp0iwD1X6Ms0Yq16tmcaIqSS8XtA7r
Qe9aRNluUy/XUZj84T/WmyEBTVMLERBJAxp0moXvGXSHJ7hkKDJ2uM74VfH3xvcR
RhM9Hlc6MkUqywUumSFsCUeqvsftJY/e/3Yg72ANzknwRuNC97dh+EZihUxDnufa
JrBHT/f2y3qUHeJfpHS8aOa7LuZtL93rHeoju8Sacw6PQcmI2+hZWFr3nC3UK3FW
jiEn6n2oZgzpdgpgnoguceNDRjqCJMVojeM24vEPT7XRxl8ez9cbu4w/vWqtuts4
0fekBOrig2pDSWAA2u/Qkyk4uWpLxveSsYb8XCXjYqMWcZSJJ+Z+o/bv5z5niPZP
DP7eTwecC+yS6lwU2aN0CLFu13QL9XAVp28YO2xzRLN0g5HqqViItD8bl4F3kZCr
m9bb0y2TKAwncoFOEPGa5tEIZ39w2C7RWlXM8XIRYWR0vp4it6KAi92eO7Cb0374
3lh/X1hk
=Ofdx
-----END PGP SIGNATURE-----

--otw3l52sr4y45r5c--

