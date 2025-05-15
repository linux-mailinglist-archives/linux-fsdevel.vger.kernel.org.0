Return-Path: <linux-fsdevel+bounces-49117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F40AB8382
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 12:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A36727A319C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936A297A4B;
	Thu, 15 May 2025 10:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdlfQCTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2291C18DB37;
	Thu, 15 May 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747303450; cv=none; b=OuAmxfC//9CbH/qtTQ0FeOViBSnvxwoR17D/lveKYdg6q2M9weQieoK9/OtlXmwgEO4rSvnuG+i56l66CX+AN7BwpZAFpwITucIdlGZWXnJS/zcobIW70bOLFMlDBa6rtRfPBJ5Sizo/32gR8FOe0Ppjicy00H9TKNgoJbCJZV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747303450; c=relaxed/simple;
	bh=sD1eHD0aNCDTJQ1r/x2BlkpBGb6+H+dwk6qBtn6A6eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQiGtNIPnms912SWKmXBcvTnQ5B2vo5AiIynhCGpU000ZY2RsoV2/A+mYnrOfpqMXPLZOmV6HsKFtl4FVfrqdGaZseEcir6oDpmZCyPL4MS7PoYzHZs2c2oS5f1LvnSc7CUOKDGWSdXOMLnDQkquI3RUvU1rgKnE+hz9PMr9OnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SdlfQCTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB21C4CEE7;
	Thu, 15 May 2025 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747303449;
	bh=sD1eHD0aNCDTJQ1r/x2BlkpBGb6+H+dwk6qBtn6A6eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdlfQCTmqiyc9cLRn+bVZ+J/xKgEspqF0Xu5p+/MWV6lwgvd5Lj8GKu0SHK6ExgDM
	 wdl5smrvYBEAv233vaVzX+xdxBbq8VNg+eXXl1G5vFNI2TVEsSNxMyt1dLNB7OtHmE
	 i09U3/VA+pM89W75yUOWmZ3HBaqvB2rIFp8kxGmrc0hxCOLryKo/Zn0O/zVzpixJtW
	 roRpUVx+OI1n7fhD3n1pZbEFimyLqzII6s/qKrupFLv+4KDguIzE0hAHVJiLpuIpTG
	 wzsrcEMv6piv+Yv2BAzI19UUcFgwLeSGYEj4HyES8HYjMYE17NVnQ6nYEfIv5hGuCb
	 bUqghGUUvFwbQ==
Date: Thu, 15 May 2025 12:04:04 +0200
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
Message-ID: <g3e3ygz4jb73b3zhxexpwacwui3imlwauujzeq2nlopp2i2fjp@lzj33hcwztc2>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-1-d0ad83f5f4c3@kernel.org>
 <e2ebf88d-46a2-4f38-a0c8-940c3d3bee49@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ru77vocekp26ujzg"
Content-Disposition: inline
In-Reply-To: <e2ebf88d-46a2-4f38-a0c8-940c3d3bee49@suse.com>


--ru77vocekp26ujzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 10:04:53AM +0200, Petr Pavlu wrote:
> On 5/9/25 14:54, Joel Granados wrote:
> > Move module sysctl (modprobe_path and modules_disabled) out of sysctl.c
> > and into the modules subsystem. Make the modprobe_path variable static
> > as it no longer needs to be exported. Remove module.h from the includes
> > in sysctl as it no longer uses any module exported variables.
> >=20
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kernel/sysctl.c.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > [...]
> > --- a/kernel/module/kmod.c
> > +++ b/kernel/module/kmod.c
> > @@ -60,7 +60,7 @@ static DEFINE_SEMAPHORE(kmod_concurrent_max, MAX_KMOD=
_CONCURRENT);
> >  /*
> >  	modprobe_path is set via /proc/sys.
> >  */
> > -char modprobe_path[KMOD_PATH_LEN] =3D CONFIG_MODPROBE_PATH;
> > +static char modprobe_path[KMOD_PATH_LEN] =3D CONFIG_MODPROBE_PATH;
> > =20
> >  static void free_modprobe_argv(struct subprocess_info *info)
> >  {
> > @@ -177,3 +177,33 @@ int __request_module(bool wait, const char *fmt, .=
=2E.)
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL(__request_module);
> > +
> > +#ifdef CONFIG_MODULES
> > +static const struct ctl_table kmod_sysctl_table[] =3D {
> > +	{
> > +		.procname	=3D "modprobe",
> > +		.data		=3D &modprobe_path,
> > +		.maxlen		=3D KMOD_PATH_LEN,
> > +		.mode		=3D 0644,
> > +		.proc_handler	=3D proc_dostring,
> > +	},
> > +	{
> > +		.procname	=3D "modules_disabled",
> > +		.data		=3D &modules_disabled,
> > +		.maxlen		=3D sizeof(int),
> > +		.mode		=3D 0644,
> > +		/* only handle a transition from default "0" to "1" */
> > +		.proc_handler	=3D proc_dointvec_minmax,
> > +		.extra1		=3D SYSCTL_ONE,
> > +		.extra2		=3D SYSCTL_ONE,
> > +	},
>=20
> This is minor.. but the file kernel/module/kmod.c contains the logic to
> request direct modprobe invocation by the kernel. Registering the
> modprobe_path sysctl here is appropriate. However, the modules_disabled
> setting affects the entire module loader so I don't think it's best to
> register it here.
>=20
> I suggest keeping a single table for the module sysctl values but moving
> it to kernel/module/main.c. This means the variable modprobe_path must
> retain external linkage, on the other hand, modules_disabled can be made
> static.

Like this?:

---
 include/linux/module.h |  1 -
 kernel/module/main.c   | 30 +++++++++++++++++++++++++++++-
 kernel/sysctl.c        | 20 --------------------
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index d94b196d5a34..25476168e012 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -302,7 +302,6 @@ struct notifier_block;
=20
 #ifdef CONFIG_MODULES
=20
-extern int modules_disabled; /* for sysctl */
 /* Get/put a kernel symbol (calls must be symmetric) */
 void *__symbol_get(const char *symbol);
 void *__symbol_get_gpl(const char *symbol);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..13055ef65f15 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -126,9 +126,37 @@ static void mod_update_bounds(struct module *mod)
 }
=20
 /* Block module loading/unloading? */
-int modules_disabled;
+static int modules_disabled;
 core_param(nomodule, modules_disabled, bint, 0);
=20
+static const struct ctl_table kmod_sysctl_table[] =3D {
+	{
+		.procname	=3D "modprobe",
+		.data		=3D &modprobe_path,
+		.maxlen		=3D KMOD_PATH_LEN,
+		.mode		=3D 0644,
+		.proc_handler	=3D proc_dostring,
+	},
+	{
+		.procname	=3D "modules_disabled",
+		.data		=3D &modules_disabled,
+		.maxlen		=3D sizeof(int),
+		.mode		=3D 0644,
+		/* only handle a transition from default "0" to "1" */
+		.proc_handler	=3D proc_dointvec_minmax,
+		.extra1		=3D SYSCTL_ONE,
+		.extra2		=3D SYSCTL_ONE,
+	},
+};
+
+static int __init init_kmod_sysctl(void)
+{
+	register_sysctl_init("kernel", kmod_sysctl_table);
+	return 0;
+}
+
+subsys_initcall(init_kmod_sysctl);
+
 /* Waiting for a module to finish initializing? */
 static DECLARE_WAIT_QUEUE_HEAD(module_wq);
=20
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 9b4f0cff76ea..473133d9651e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -19,7 +19,6 @@
  *  Removed it and replaced it with older style, 03/23/00, Bill Wendling
  */
=20
-#include <linux/module.h>
 #include <linux/sysctl.h>
 #include <linux/bitmap.h>
 #include <linux/printk.h>
@@ -1616,25 +1615,6 @@ static const struct ctl_table kern_table[] =3D {
 		.proc_handler	=3D proc_dointvec,
 	},
 #endif
-#ifdef CONFIG_MODULES
-	{
-		.procname	=3D "modprobe",
-		.data		=3D &modprobe_path,
-		.maxlen		=3D KMOD_PATH_LEN,
-		.mode		=3D 0644,
-		.proc_handler	=3D proc_dostring,
-	},
-	{
-		.procname	=3D "modules_disabled",
-		.data		=3D &modules_disabled,
-		.maxlen		=3D sizeof(int),
-		.mode		=3D 0644,
-		/* only handle a transition from default "0" to "1" */
-		.proc_handler	=3D proc_dointvec_minmax,
-		.extra1		=3D SYSCTL_ONE,
-		.extra2		=3D SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_UEVENT_HELPER
 	{
 		.procname	=3D "hotplug",
--=20
2.47.2

--=20

Joel Granados

--ru77vocekp26ujzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmglvAoACgkQupfNUreW
QU8L/Av/YmkHrysPaGwJRKxmis9nMWc0PYzFjViNFVlZuFXAXKu5kWSHvaxsq8fl
+yJvXtS9QV8pXzyKlEgEdknV+d8qh95hPO7WArzybZ3bivL7LsjCnBU6mflIQnOb
xfvTTJncJ5PUk15VXsPA9mNiYy+xA2y7HCsxD7N3Vz2uDzl2HnJucfga9SRuua52
lTItMHiKvN0oxOwsVH5jQtPijcknG9sV7Cz84O31WuvY7DPhNFUBhhb6UGB5RA25
pM4Zb7bWDBv+xnWKGBjHFdhCqCDFr/Honyjvl4xiSbGd0kzucDlJiSkHiJfE/zFl
2Fvm/edUeW7PUI7pqyYunJeEeTDiNU1/aalCIErLT8idbEf5EwbqPVjMCU9ktVXS
73LiItIXrewicguZtSGB+nJMz4ETZKzBxFQo2ZTEsZ9saxr0SebmpSg1jar5rkXy
S+3KjAQKE7JsI7s765cc1m/SCPceaN02cw9zMELFXt/0tQU5xIH2rWTLinYpFVyt
HrP1upxU
=vQLm
-----END PGP SIGNATURE-----

--ru77vocekp26ujzg--

