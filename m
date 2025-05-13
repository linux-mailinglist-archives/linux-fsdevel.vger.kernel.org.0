Return-Path: <linux-fsdevel+bounces-48814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98293AB4D54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 09:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E521B3AA7DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 07:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8121F180E;
	Tue, 13 May 2025 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICyfMrK8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAF41E5B94;
	Tue, 13 May 2025 07:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122591; cv=none; b=URFxxIC+sV5NTM595YjVU8CxeE7/Cn0sU2fqnioetpItBnukas/xiypj+zGC62/T7Gdg8yqn5Q/01ZSqC7E8NDvS6oU+eHxu2ep91aX/UC1fGZjeu5jrWevkNU9Hk9bTPrP4aZwt88sF6ofittY3yi/JbNllTgKnnNpKn+Znqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122591; c=relaxed/simple;
	bh=z+XKwlKxvho0rlpEIn0bjoCqOXNrPIEWodnNK5WbJJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYViPWda8p+NEHHCvzN5Yo8bR6JbL4Ii672Z9Z0pMn4FTV1XVG0Uxrv+PkVOotsqVM4yvlvEVuT6I5h3N+4JMBMTdZTMdIAOXrsGPfCtMmWuLBXjChnVjfTIYZbeJLOX5XdSwx6o4Hz1+wNrEs/F9ypg53zmL+9VhUETCKpw1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICyfMrK8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE39EC4CEE4;
	Tue, 13 May 2025 07:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747122590;
	bh=z+XKwlKxvho0rlpEIn0bjoCqOXNrPIEWodnNK5WbJJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICyfMrK8mhiA/OukQgVVroae9K1GoFJUvWMzgTt2E9VSNfkJVyx/BiJXh7hDwRupN
	 vQugGeWqM/CZbN07jv+GX+v7HG44hoBoz7j1e/xSsj/MrkgkUaxC8Vw0zpZT6eeXFR
	 5pDKYrmSzylrdVyA6z2oLJNWxwsu9Af9MqA46swDCjseS7ly4YQ6W7qzvB90G9vcKN
	 gMPsr6tcbDpNY+sLEN8fVVA1Fe8zFmpd9TUPkKiRRjfBxBjA4oUQh/ABIb0I+ai1VE
	 T6A0zExe59APk/1qaqjF8GO+BWLk9cBZFzQs2DCDYTAXkhKk1Slpx2OsT44RbP5ASH
	 fZ8VPCWKfD5EQ==
Date: Tue, 13 May 2025 09:49:43 +0200
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
Subject: Re: [PATCH 07/12] Input: sysrq: mv sysrq into drivers/tty/sysrq.c
Message-ID: <ddkgmitslawut5zmeinxvuiwsfzxx5ysn5gtuvruemnnrhicwn@lkpckufsinum>
References: <20250509-jag-mv_ctltables_iter2-v1-0-d0ad83f5f4c3@kernel.org>
 <20250509-jag-mv_ctltables_iter2-v1-7-d0ad83f5f4c3@kernel.org>
 <202505091010.F2F8C676@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4m4abidfdrbxi5yd"
Content-Disposition: inline
In-Reply-To: <202505091010.F2F8C676@keescook>


--4m4abidfdrbxi5yd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 09, 2025 at 10:10:28AM -0700, Kees Cook wrote:
> On Fri, May 09, 2025 at 02:54:11PM +0200, Joel Granados wrote:
> > Move both sysrq ctl_table and supported sysrq_sysctl_handler helper
> > function into drivers/tty/sysrq.c. Replaced the __do_proc_dointvec in
> > helper function with do_proc_dointvec as the former is local to
> > kernel/sysctl.c.
>=20
> nit: do_proc_dointvec_minmax
Thx. I even added a small comment to the commit message to clarify:
```
Move both sysrq ctl_table and supported sysrq_sysctl_handler helper
function into drivers/tty/sysrq.c. Replaced the __do_proc_dointvec in
helper function with do_proc_dointvec_minmax as the former is local to
kernel/sysctl.c. Here we use the minmax version of do_proc_dointvec
because do_proc_dointvec is static and calling do_proc_dointvec_minmax
with a NULL min and max is the same as calling do_proc_dointvec.
```

I'll also put a comment in the code to make sure that a min max is not
added by mistake.

Best

--=20

Joel Granados

--4m4abidfdrbxi5yd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmgi+ZcACgkQupfNUreW
QU+v4Qv/efXaubw/UZ0/uYrlHOJZg+VxZvyldRdbiHjo3Ub408gh2trrRYtceCsY
ICssy3kBVRggr7y+KLqjXZZOVoAz8/PVXR38X+6FozTLuSpwrtIY0vLeXeew7GU0
kwYWrcn+MtqfBuo32INYySExZJs7/NoQLVqGwQrPIdRhuM/N/srMoe/uGeMwQnhl
mLdzg3jlOdcYSxbKj6bdCMBg/2qHTWIv9iVQfdRNy3bALXOmvGJNlHBgd2qROsyg
T7Y78uAfyz2h/mnTrRi0JxjssYLfjFQLoy2+Y/KBwonDdAyRRRQg6na93jB+DJWs
Veq4CcLz5XA4OfxXNPosQYtrfzKUahzQSiwGvOq4F+fNhp2JrHf3jYmojoC2pPSN
e0AV2jZBVk7Y+gkyeEkYgEF9A7AtHqFXLlCc5wovR/dYG8seSJWLuaVkphB0oXdC
QK0b1e9pm6iy1k5xhRhP7KZCcoqynySk816gPhatZI0ARh0+5YJT8D2TEJYkCvJx
IoAnZ+8h
=dHUN
-----END PGP SIGNATURE-----

--4m4abidfdrbxi5yd--

