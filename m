Return-Path: <linux-fsdevel+bounces-48810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18D9AB4CD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F3A4645BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F051C1F03DE;
	Tue, 13 May 2025 07:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1cuC8NK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C274315E;
	Tue, 13 May 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121609; cv=none; b=OK6tE3Wn8RmaaVe7hcx3jEL3twH1WBbsheu4gmYwrWsXtg5TtmcGWyO5g36ZhGEkMRzuZojHigtGiBXNCFUJMoYQL30a97zKvY8cmziGTwX6ZMTdaCM+yfFSK5VfyVVeAjW6vPSnzb1OMfYuonJLp9i5Vr44mvJkCSKtMCTnETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121609; c=relaxed/simple;
	bh=oydnFwFzyvTFZLytjGu4FLOFoRfASVhdPt5sskdlZPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ZrQwHzlUuGaHtfyGcTxFRDPXA3Fa24/HAWubz+wKwcAnApYmKcarAiB/wsNup6f7r+5btGIoRlC0DTZ85x5owSA2NlEi638C8dxHTpIXyIOc9BngBHF7fy7Gj5UESwMtWnAZMV9G+d7rTFPRhZ7W8pWCNO9yzU1PZfo9lGwNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1cuC8NK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38272C4CEE4;
	Tue, 13 May 2025 07:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121608;
	bh=oydnFwFzyvTFZLytjGu4FLOFoRfASVhdPt5sskdlZPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h1cuC8NKAbWGk5N4z9eoNPIQ6NBkZHWfTFBOMG6WcDqpnNYaelJWfkZf82BqvkDSl
	 P/SajPouty4fKsU9symCU24kVd6HIGfDEqjl8fysrHGn06p2mqEb6M0ny0gYBoxxBk
	 KeV2K9sjGbcqfaahL5nhnRXWUj06irpfg80ARwqSV7eG2SqwwBAwTjvK/K/HmYNC+3
	 ClsSUW2zxuP5+BIRP9Uh8Sg+1e8cC47UVPi/e6Hv3UN5bc6ttmhPXS1uHrb7nlx2Hl
	 1bxJvfmr+aeiyc8BpGfu5tpnm9UEP2MWYHDM53CjBoe7hXKGFQZU+2v+E1qoSj2UG6
	 EapmAmIgZLQyQ==
Date: Tue, 13 May 2025 09:33:23 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, 
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
Subject: Re: [PATCH 09/12] sysctl: move cad_pid into kernel/pid.c
Message-ID: <hqklj5woeb3hl3n4btn6xognyw63tkp7x2ht6dkw52nmhwfioo@ssagrmnhg2bu>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-9-d0ad83f5f4c3@kernel.org>
 <202505091200.FC2683DD@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fouo2tqrgcca44q"
Content-Disposition: inline
In-Reply-To: <202505091200.FC2683DD@keescook>


--5fouo2tqrgcca44q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 12:01:24PM -0700, Kees Cook wrote:
> On Fri, May 09, 2025 at 02:54:13PM +0200, Joel Granados wrote:
> > Move cad_pid as well as supporting function proc_do_cad_pid into
> > kernel/pic.c. Replaced call to __do_proc_dointvec with proc_dointvec
> > inside proc_do_cad_pid which requires the copy of the ctl_table to
> > handle the temp value.
> >=20
> > This is part of a greater effort to move ctl tables into their
> > respective subsystems which will reduce the merge conflicts in
> > kernel/sysctl.c.
> >=20
> > Signed-off-by: Joel Granados <joel.granados@kernel.org>
> > ---
> >  kernel/pid.c    | 32 ++++++++++++++++++++++++++++++++
> >  kernel/sysctl.c | 31 -------------------------------
> >  2 files changed, 32 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 4ac2ce46817fdefff8888681bb5ca3f2676e8add..bc87ba08ae8b7c67f3457b3=
1309b56b5d90f8c52 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -717,6 +717,29 @@ static struct ctl_table_root pid_table_root =3D {
> >  	.set_ownership	=3D pid_table_root_set_ownership,
> >  };
> > =20
> > +static int proc_do_cad_pid(const struct ctl_table *table, int write, v=
oid *buffer,
> > +		size_t *lenp, loff_t *ppos)
> > +{
> > +	struct pid *new_pid;
> > +	pid_t tmp_pid;
> > +	int r;
> > +	struct ctl_table tmp_table =3D *table;
> > +
> > +	tmp_pid =3D pid_vnr(cad_pid);
> > +	tmp_table.data =3D &tmp_pid;
> > +
> > +	r =3D proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
> > +	if (r || !write)
> > +		return r;
> > +
> > +	new_pid =3D find_get_pid(tmp_pid);
> > +	if (!new_pid)
> > +		return -ESRCH;
> > +
> > +	put_pid(xchg(&cad_pid, new_pid));
> > +	return 0;
> > +}
> > +
> >  static const struct ctl_table pid_table[] =3D {
> >  	{
> >  		.procname	=3D "pid_max",
> > @@ -727,6 +750,15 @@ static const struct ctl_table pid_table[] =3D {
> >  		.extra1		=3D &pid_max_min,
> >  		.extra2		=3D &pid_max_max,
> >  	},
> > +#ifdef CONFIG_PROC_SYSCTL
> > +	{
> > +		.procname	=3D "cad_pid",
> > +		.data		=3D NULL,
>=20
> nit: this is redundant, any unspecified member will be zero-initialized.
Thx. Changed it locally, but will not resend for this.
>=20
> Regardless:
>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
=2E..
> > -		.data		=3D NULL,
> > -		.maxlen		=3D sizeof (int),
> > -		.mode		=3D 0600,
> > -		.proc_handler	=3D proc_do_cad_pid,
> > -	},
> >  #endif
> >  	{
> >  		.procname	=3D "overflowuid",
> >=20
> > --=20
> > 2.47.2
> >=20
> >=20
>=20
> --=20
> Kees Cook

--=20

Joel Granados

--5fouo2tqrgcca44q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgi9bkACgkQupfNUreW
QU9gYwv9HmmGGJZHXMl5xZnY6+FsJWyyJPwiDmBpHKqnKUS42gx1LYy2Q2iMzgFt
YcxKJxmpLBMq0zNs1c7WNKOBf/3YXplkC/1ZGQPADy/fPhZIqjoZgE9IY7rlPuRW
ZqHGdVvpT6hjyjx9buwt+BAt7LbMZFrpH+KgqIy27NUu6icIQiZv5p1QTqHW4/MP
mwk0aJcMZnCExOxBdRgKDzhiQRnKFgDZcbM2QeOLuuPZsLA/rPQA5UxlnXVGJ82s
1bm/UR896mg8Ziq42SuV2yl9S4cT/mNKoNgxTtVAOrNYajc5mcjQPalvDCitBQTk
L9ieGsR6I/+jYgJVCoc9vHuYkJuX7B52HcHH2rC/9bmSKqr1ea7xFcG7eA3iViJz
rQzlj+z9wxfi+81TJSPXsUZmFkFhKXaZNQEgt7rhjtwiv2aafkFpOp6vN7dlrkrW
OyvLd59uapsslRXXBAlyqMbnHEhg69c/Pqk5bup1Cj5WU4zhK2OmMk3sR2Vu80cD
/fMGl+l+
=zOoe
-----END PGP SIGNATURE-----

--5fouo2tqrgcca44q--

