Return-Path: <linux-fsdevel+bounces-27577-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACC1962800
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CAAB23382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5C2184528;
	Wed, 28 Aug 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INcijHKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C1174ED0;
	Wed, 28 Aug 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724849902; cv=none; b=RPOjkD9qWqonf0of869fX/P2BMNJkXiht/Pebu2gdIkZaYkHi1Z3Nkcep41blykOzn8nXhgpb6ap4Na0QmH8Fv6USgy6q01iegNZ2wen++NbxXEautW9h6YRT00UY6L67l/fj2hpEkCg5B60n1r5xVBnltsawr0m9LkKVN8X5yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724849902; c=relaxed/simple;
	bh=n86jAMr/f3BgwZu+naWFNgdxfrENfR6IstOBFoINw5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mT1uqUBV8l1xq2FaAgTCSMTdcgifFBkGP18MaZoVOjCdpqG+M88KkX+7ZX4x7F9M68iqd0uXdJ9dVTHF7jX5XHKZol3IQwi68Q5ES2QU7AhGIxE3kPjNU8ldo0FpDxV4OZPN9iOMhM6EIjdMkPGzGs/XR+4m5H6iuUzsWEjseCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INcijHKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCEAC98EDF;
	Wed, 28 Aug 2024 12:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724849902;
	bh=n86jAMr/f3BgwZu+naWFNgdxfrENfR6IstOBFoINw5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=INcijHKdxjgi3vpAx+1+S/ILXebjKI5bADpOfOi4NopNEYIvGCKxL8t1TBOkImOEH
	 +Z2c2/YU+d5Gaoot+ZNRqHXS9O/KOZkFTKJX0+SJkNYeOXPYY8yVOdVIETooYyKduL
	 qQNBPAQwE0t87a5YZwOjIJx/7vJ4J1gcsO0D+sZGdVeq43YiSf0uH+90AR1t/ZJ0IJ
	 2w3HaXZLAUqTqiUVE1c6mYTcy/exa0OpW9vw83OcftKX9A1k1GJ2kcLiTXPcjC99E6
	 kapylEkZBO2AAQAjTgt43Gq2Bpxs/TVo6lj5R2sQjIU49yDy+vkjHQHShrLDcw3EuU
	 QmfxYS2161jHQ==
Date: Wed, 28 Aug 2024 14:58:15 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
Message-ID: <n2fxqs3tekvljezaqpfnwhsmjymch4vb47y744zwmy7urf3flv@zvjtepkem4l7>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jlsfvt4o727tdvtw"
Content-Disposition: inline
In-Reply-To: <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>


--jlsfvt4o727tdvtw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	justinstitt@google.com, ebiederm@xmission.com, alexei.starovoitov@gmail.com, 
	rostedt@goodmis.org, catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <keescook@chromium.org>, 
	Matus Jokay <matus.jokay@stuba.sk>, "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v8 1/8] Get rid of __get_task_comm()
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
 <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
MIME-Version: 1.0
In-Reply-To: <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>

On Wed, Aug 28, 2024 at 12:15:40PM GMT, Alejandro Colomar wrote:
> Hi Yafang,
>=20
> On Wed, Aug 28, 2024 at 11:03:14AM GMT, Yafang Shao wrote:
> > We want to eliminate the use of __get_task_comm() for the following
> > reasons:
> >=20
> > - The task_lock() is unnecessary
> >   Quoted from Linus [0]:
> >   : Since user space can randomly change their names anyway, using lock=
ing
> >   : was always wrong for readers (for writers it probably does make sen=
se
> >   : to have some lock - although practically speaking nobody cares there
> >   : either, but at least for a writer some kind of race could have
> >   : long-term mixed results
> >=20
> > - The BUILD_BUG_ON() doesn't add any value
> >   The only requirement is to ensure that the destination buffer is a va=
lid
> >   array.
> >=20
> > - Zeroing is not necessary in current use cases
> >   To avoid confusion, we should remove it. Moreover, not zeroing could
> >   potentially make it easier to uncover bugs. If the caller needs a
> >   zero-padded task name, it should be explicitly handled at the call si=
te.
> >=20
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-np=
JooP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> > Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu=
99v7+b6AyHMmaDFA@mail.gmail.com/
> > Suggested-by: Alejandro Colomar <alx@kernel.org>
> > Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurf=
bosf5wdo65dk4@srb3hsk72zwq
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Eric Biederman <ebiederm@xmission.com>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Matus Jokay <matus.jokay@stuba.sk>
> > Cc: Alejandro Colomar <alx@kernel.org>
> > Cc: "Serge E. Hallyn" <serge@hallyn.com>
> > ---
> >  fs/exec.c             | 10 ----------
> >  fs/proc/array.c       |  2 +-
> >  include/linux/sched.h | 32 ++++++++++++++++++++++++++------
> >  kernel/kthread.c      |  2 +-
> >  4 files changed, 28 insertions(+), 18 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index f8d150343d42..c40b95a79d80 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
>=20
> [...]
>=20
> > @@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_st=
ruct *tsk, const char *from)
> >  	__set_task_comm(tsk, from, false);
> >  }
> > =20
> > -extern char *__get_task_comm(char *to, size_t len, struct task_struct =
*tsk);
> > +/*
>=20
> [...]
>=20
> > + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> > + */
> >  #define get_task_comm(buf, tsk) ({			\
> > -	BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);	\
> > -	__get_task_comm(buf, sizeof(buf), tsk);		\
> > +	strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));	\
>=20
> I see that there's a two-argument macro
>=20
> 	#define strscpy(dst, src)	sized_strscpy(dst, src, sizeof(dst))
>=20
> which is used in patch 2/8
>=20
> 	diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> 	index 6f0d6fb6523f..e4ef5e57dde9 100644
> 	--- a/kernel/auditsc.c
> 	+++ b/kernel/auditsc.c
> 	@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
> 		context->target_uid =3D task_uid(t);
> 		context->target_sessionid =3D audit_get_sessionid(t);
> 		security_task_getsecid_obj(t, &context->target_sid);
> 	-       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
> 	+       strscpy(context->target_comm, t->comm);
> 	 }
>=20
> 	 /**

Ahh, the actual generic definition is in <include/linux/string.h>.
You could do

	diff --git i/include/linux/string.h w/include/linux/string.h
	index 9edace076ddb..060504719904 100644
	--- i/include/linux/string.h
	+++ w/include/linux/string.h
	@@ -76,11 +76,11 @@ ssize_t sized_strscpy(char *, const char *, size_t);
	  * known size.
	  */
	 #define __strscpy0(dst, src, ...)      \
	-       sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
	+       sized_strscpy(dst, src, ARRAY_SIZE(dst))
	 #define __strscpy1(dst, src, size)     sized_strscpy(dst, src, size)
	=20
	 #define __strscpy_pad0(dst, src, ...)  \
	-       sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
	+       sized_strscpy_pad(dst, src, ARRAY_SIZE(dst))
	 #define __strscpy_pad1(dst, src, size) sized_strscpy_pad(dst, src, size)
	=20
	 /**

>=20
> I propose modifying that macro to use ARRAY_SIZE() instead of sizeof(),
> and then calling that macro here too.  That would not only make sure
> that this is an array, but make sure that every call to that macro is an
> array.  An if there are macros for similar string functions that reduce
> the argument with a usual sizeof(), the same thing could be done to
> those too.
>=20
> Have a lovley day!
> Alex
>=20
> > +	buf;						\
> >  })
> > =20
> >  #ifdef CONFIG_SMP
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index f7be976ff88a..7d001d033cf9 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -101,7 +101,7 @@ void get_kthread_comm(char *buf, size_t buf_size, s=
truct task_struct *tsk)
> >  	struct kthread *kthread =3D to_kthread(tsk);
> > =20
> >  	if (!kthread || !kthread->full_name) {
> > -		__get_task_comm(buf, buf_size, tsk);
> > +		strscpy(buf, tsk->comm, buf_size);
> >  		return;
> >  	}
> > =20
> > --=20
> > 2.43.5
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es/>



--=20
<https://www.alejandro-colomar.es/>

--jlsfvt4o727tdvtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbPHuEACgkQnowa+77/
2zKgBA//eGa/SyzAmBdUjYfc4f7liEeEv+OWUTlM7ld3iAWQPIRtR+Qi4A8etapm
5a92Z1667JrB0rfpZiBDHdROGwzukfPY/V/Ppj5wF1janRjy7jy98Tc1k8QYSSux
bzTNagcGoRRrMcOQoXRsHZmb9VlripTPQj36lApImB0GtnipmfEbSiQns1I03A8/
vnnXEGHRT+EIKyE2Q6LNyanJwqsTI7aZyXOS1Xe3bekkRjmL3cM9cploLxALaiIK
OFhjtk10ALjug21HhBO6Fufg3b1m8reK+tl5+3WKi+h4Z+OupJhKvf5i0XLVLXto
1Vu+j/lc/VrR7SIQdFcyKYjWM3Igp/BPSjWpGmYNH/fUE1S3RQoYFAyS3Iy5GbkI
jy5s29zvCm1fjfN1/u0/35uxmdzFqRAI72FfoZUKG7DRrLdyEXDwgLRJncCCh9fT
3qxl7Px3MAoXUbtps7p0btpRVO7Xhn9D5OUtYo3RUY4Dcpn9ed2ANI/bdZeyg7hs
NbTayf3XNnzN1Tbq7+XBv7E66gV89G36kS65kmE5c6HQ7kwf5yDxwoQfrqgjaFYN
bwRxokSRWphrNpHN0pGmaBvJTgBFAizWjhtWl8siOQJPixaW/ga1Ql57UbVE7Qkk
SdeJkHw1w492JAct0QQsWOqdyYksI9k6qLG/n4zMwwnVemIWtRg=
=aSp9
-----END PGP SIGNATURE-----

--jlsfvt4o727tdvtw--

