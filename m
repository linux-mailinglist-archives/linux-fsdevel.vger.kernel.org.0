Return-Path: <linux-fsdevel+bounces-27537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C79996248E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9180286637
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 10:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4820D16B74B;
	Wed, 28 Aug 2024 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n474//dd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8815216132F;
	Wed, 28 Aug 2024 10:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724840140; cv=none; b=VTFT3D7YBFnl/afoJnW8DOtsD+6CxZPJEIt97kwa9hEyAg5KlhDy+on+rG2WNqwBtgO8qk5Tll3hasZzD9pBhdQdGHT55cNfiaKOVRppQ+3rUlO0CXZUk9lp9Al40BElv95DnR8bQAbQOJfp/tZENAUw+sPoOKu1r7JgJhZAg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724840140; c=relaxed/simple;
	bh=5xuHNpJ8s4HOyC/ZMbuo393EqBOuuHgBE8NpAhMS1xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfWKw6G0eVSUKdGcitRmZGAGCD/t8reKnkfIP+wTZuGLmNU4vqbuSpgsQT0ArUjk5WCh4s14GcH3xurx2GV5FaxPYjeRaj1+sOu4TIHm8DfS6l1vK9rqejWpNbst6cu4OK1mZ+NuGdWZ+dgJ8XbYb7FuIvtmpYclp8Z3QOS4GfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n474//dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E4DC98EC0;
	Wed, 28 Aug 2024 10:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724840140;
	bh=5xuHNpJ8s4HOyC/ZMbuo393EqBOuuHgBE8NpAhMS1xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n474//ddYkvBDbFi4PGLE0FTy+iiAA4s4wyNdxcHGJALrL1fthrhN3uI+zqdovRS/
	 144KFSBIez7oTLYMwkU1OpzSMrIJ/beg9u2IV2kfsLQ3HbVrfcjTYwUOYc0zNYGCUW
	 sJPUqdSKe/vNZkKLA9B0zTCgnE8dCgdnbOaVHYsUF8xA9psYiMn54rrFhKkNIi3oCl
	 dvtmwiVj6Pzfi2AhPqiPDt2mnx4XVarJ+wsJOyfm+g/Kx8+3f9FhCTGEuLGnAERvcX
	 Jg4rftmJ9JMgCrLnqOr0dbza144I/TB8JbkMRSm3BmoN9HM3dOV8VyCx9rbu7NESVa
	 DUUS4wBFCSJWg==
Date: Wed, 28 Aug 2024 12:15:33 +0200
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
Message-ID: <lql4y2nvs3ewadszhmv4m6fnqja4ff4ymuurpidlwvgf4twvru@esnh37a2jxbd>
References: <20240828030321.20688-1-laoar.shao@gmail.com>
 <20240828030321.20688-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="74qvuoge5bg2djof"
Content-Disposition: inline
In-Reply-To: <20240828030321.20688-2-laoar.shao@gmail.com>


--74qvuoge5bg2djof
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
MIME-Version: 1.0
In-Reply-To: <20240828030321.20688-2-laoar.shao@gmail.com>

Hi Yafang,

On Wed, Aug 28, 2024 at 11:03:14AM GMT, Yafang Shao wrote:
> We want to eliminate the use of __get_task_comm() for the following
> reasons:
>=20
> - The task_lock() is unnecessary
>   Quoted from Linus [0]:
>   : Since user space can randomly change their names anyway, using locking
>   : was always wrong for readers (for writers it probably does make sense
>   : to have some lock - although practically speaking nobody cares there
>   : either, but at least for a writer some kind of race could have
>   : long-term mixed results
>=20
> - The BUILD_BUG_ON() doesn't add any value
>   The only requirement is to ensure that the destination buffer is a valid
>   array.
>=20
> - Zeroing is not necessary in current use cases
>   To avoid confusion, we should remove it. Moreover, not zeroing could
>   potentially make it easier to uncover bugs. If the caller needs a
>   zero-padded task name, it should be explicitly handled at the call site.
>=20
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://lore.kernel.org/all/CAHk-=3DwivfrF0_zvf+oj6=3D=3DSh=3D-npJo=
oP8chLPEfaFV0oNYTTBA@mail.gmail.com [0]
> Link: https://lore.kernel.org/all/CAHk-=3DwhWtUC-AjmGJveAETKOMeMFSTwKwu99=
v7+b6AyHMmaDFA@mail.gmail.com/
> Suggested-by: Alejandro Colomar <alx@kernel.org>
> Link: https://lore.kernel.org/all/2jxak5v6dfxlpbxhpm3ey7oup4g2lnr3ueurfbo=
sf5wdo65dk4@srb3hsk72zwq
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Cc: Matus Jokay <matus.jokay@stuba.sk>
> Cc: Alejandro Colomar <alx@kernel.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> ---
>  fs/exec.c             | 10 ----------
>  fs/proc/array.c       |  2 +-
>  include/linux/sched.h | 32 ++++++++++++++++++++++++++------
>  kernel/kthread.c      |  2 +-
>  4 files changed, 28 insertions(+), 18 deletions(-)
>=20

[...]

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..c40b95a79d80 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h

[...]

> @@ -1914,10 +1917,27 @@ static inline void set_task_comm(struct task_stru=
ct *tsk, const char *from)
>  	__set_task_comm(tsk, from, false);
>  }
> =20
> -extern char *__get_task_comm(char *to, size_t len, struct task_struct *t=
sk);
> +/*

[...]

> + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> + */
>  #define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);	\
> -	__get_task_comm(buf, sizeof(buf), tsk);		\
> +	strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));	\

I see that there's a two-argument macro

	#define strscpy(dst, src)	sized_strscpy(dst, src, sizeof(dst))

which is used in patch 2/8

	diff --git a/kernel/auditsc.c b/kernel/auditsc.c
	index 6f0d6fb6523f..e4ef5e57dde9 100644
	--- a/kernel/auditsc.c
	+++ b/kernel/auditsc.c
	@@ -2730,7 +2730,7 @@ void __audit_ptrace(struct task_struct *t)
		context->target_uid =3D task_uid(t);
		context->target_sessionid =3D audit_get_sessionid(t);
		security_task_getsecid_obj(t, &context->target_sid);
	-       memcpy(context->target_comm, t->comm, TASK_COMM_LEN);
	+       strscpy(context->target_comm, t->comm);
	 }

	 /**

I propose modifying that macro to use ARRAY_SIZE() instead of sizeof(),
and then calling that macro here too.  That would not only make sure
that this is an array, but make sure that every call to that macro is an
array.  An if there are macros for similar string functions that reduce
the argument with a usual sizeof(), the same thing could be done to
those too.

Have a lovley day!
Alex

> +	buf;						\
>  })
> =20
>  #ifdef CONFIG_SMP
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index f7be976ff88a..7d001d033cf9 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -101,7 +101,7 @@ void get_kthread_comm(char *buf, size_t buf_size, str=
uct task_struct *tsk)
>  	struct kthread *kthread =3D to_kthread(tsk);
> =20
>  	if (!kthread || !kthread->full_name) {
> -		__get_task_comm(buf, buf_size, tsk);
> +		strscpy(buf, tsk->comm, buf_size);
>  		return;
>  	}
> =20
> --=20
> 2.43.5
>=20

--=20
<https://www.alejandro-colomar.es/>

--74qvuoge5bg2djof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmbO+MUACgkQnowa+77/
2zKy2RAAnnnQ7wIvUyQxf0H9XEIY8X2+ncAYPevk+tiPOW5bQccWRYr4HTCgFzGw
ROoKl9PQMjlmswMdkJxLRBd3r2r4nwpDtvORpRfVBbyJwcEbrh1+L8l834QWQbKA
sf7ADLROAhIWViIeyaFhFYw/LyBh8fwArPgzPbS1V1YbpXQeh50zpTaZG5CnTFzC
OwQ02fhV2rZABw7Vc5d/ZSk0sk4ZfkfqrGKADzX2fhVYkcXYta4QU5oIYmtVlZ1K
GyNHVHWcF27pDYQ/it3bKIugmz3RpyJ0uf7vYwcOwfnCeypEQquaEHAxOOuCdjGk
SdObiDbJmE5L3FmMcRxHacE2bX5vSlubD9oNFhIA8nJVNN//lvEcG2f7uLUNtT9a
rb5+wxYYuIoe5CY/hAm0g4R5RTen4WJdnnGuawk703XeRp7eZKvOfJHgwx+mLiln
CB3EGWz6g8ieUhnYcmn3ZRH0YyStGxY/xVgWldQSJkcLJSQ/ppGk+BqeDwShUPnD
lPvOwIzfDehLUj+he0PiELV787pJWEbrXHdUumbLryBlBEAnwgkz93KfZtEYjGst
g/63uDKyaxh6XYNtKbmYyDC0uN3jf9JKdfNFtA73mlOaeV4EYP7DLUc9m7t9Wuq6
QXB8wxZoun63oEyvF1QFKG1QEU0q9LRvy3h/isMlJmcehTcqI3Y=
=NyZ7
-----END PGP SIGNATURE-----

--74qvuoge5bg2djof--

