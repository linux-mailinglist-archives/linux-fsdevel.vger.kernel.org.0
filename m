Return-Path: <linux-fsdevel+bounces-25653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735A594E834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 10:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EE01C216EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 08:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14871166F15;
	Mon, 12 Aug 2024 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rnh6yX87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533D614D28F;
	Mon, 12 Aug 2024 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723449933; cv=none; b=hQoVxEV03iagaz7zIjwABYsU14uwRS+hmpa7M9wJnnaQbfC/yYrrWgCGKF5oRhVEqSCqCw7uGFcT0qbR7MoLSokn+7c/7YG6FpkZ1e9ELJpVaiTLBGWnUSzYk4CUKOZlHY/9EgU/CNiYHLaKBB8uuJCiEn8QrRPfFRG6Ukwurzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723449933; c=relaxed/simple;
	bh=yJMblP9VcpG/FwkXRMSJuZ99TzHFyPGmOF9lfg0RRE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGVYDhtanA6ykZlsz2O6tS0A6oZpStdtjG+NXAZOnCL4nhjZcPTCrhbE35f0WE3CsWlUWdEeBV90Rdu041GRHRZ2yzqYzGX25wAUtEbpiB8q2WFsCyN7NcFPQld//IJSUd+FFgwWN8iCzqX7AE3t4iFYrQndeVp1qqAebqYOg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rnh6yX87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14B7C32782;
	Mon, 12 Aug 2024 08:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723449933;
	bh=yJMblP9VcpG/FwkXRMSJuZ99TzHFyPGmOF9lfg0RRE8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rnh6yX87Uo33YSj+iSA8peN8E2d2OEgVIkIOv5MZ2AE2Vgo+L8snzXLroqvUp5m00
	 YEwY8o+BYv85p/xikxBhbgda09/EKQzEGVVNsXiyH1UXU1M55C9dSW/oiR2nTYie5A
	 aCj2uUroQVXpGBlpuUQdsIzQ1lgJP6rZyHukPNis/m3QUnX15mdk88rgZvtFpirOqn
	 LYafyds+r43n+qsPCUc3k4zFjasLVrgjaEYviNjUXenLJCHKtkbEBMePMvQkiu24jN
	 aqkzAxClltvV+mgKjb4baqXQBTIuK9sGx2LqeHb3uywWGnxlW9W6fFrVPtLtE2UyVg
	 mizbsRvYJHxzg==
Date: Mon, 12 Aug 2024 10:05:26 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, Matus Jokay <matus.jokay@stuba.sk>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v6 1/9] Get rid of __get_task_comm()
Message-ID: <qztvfvesnxkaol6n3ucf5ovp2ssq4hzxceaedgfexieggzj6zh@pyd5f43pccyh>
References: <20240812022933.69850-1-laoar.shao@gmail.com>
 <20240812022933.69850-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="62fk5rgm4hdf5yga"
Content-Disposition: inline
In-Reply-To: <20240812022933.69850-2-laoar.shao@gmail.com>


--62fk5rgm4hdf5yga
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, 
	ebiederm@xmission.com, alexei.starovoitov@gmail.com, rostedt@goodmis.org, 
	catalin.marinas@arm.com, penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, Matus Jokay <matus.jokay@stuba.sk>, 
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v6 1/9] Get rid of __get_task_comm()
References: <20240812022933.69850-1-laoar.shao@gmail.com>
 <20240812022933.69850-2-laoar.shao@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20240812022933.69850-2-laoar.shao@gmail.com>

Hi Yafang,

On Mon, Aug 12, 2024 at 10:29:25AM GMT, Yafang Shao wrote:
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
>  include/linux/sched.h | 31 +++++++++++++++++++++++++------
>  kernel/kthread.c      |  2 +-
>  4 files changed, 27 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index a47d0e4c54f6..2e468ddd203a 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1264,16 +1264,6 @@ static int unshare_sighand(struct task_struct *me)
>  	return 0;
>  }
> =20
> -char *__get_task_comm(char *buf, size_t buf_size, struct task_struct *ts=
k)
> -{
> -	task_lock(tsk);
> -	/* Always NUL terminated and zero-padded */
> -	strscpy_pad(buf, tsk->comm, buf_size);

This comment is correct (see other comments below).

(Except that pedantically, I'd write it as NUL-terminated with a hyphen,
 just like zero-padded.)

> -	task_unlock(tsk);
> -	return buf;
> -}
> -EXPORT_SYMBOL_GPL(__get_task_comm);
> -
>  /*
>   * These functions flushes out all traces of the currently running execu=
table
>   * so that a new one can be started
> diff --git a/fs/proc/array.c b/fs/proc/array.c
> index 34a47fb0c57f..55ed3510d2bb 100644
> --- a/fs/proc/array.c
> +++ b/fs/proc/array.c
> @@ -109,7 +109,7 @@ void proc_task_name(struct seq_file *m, struct task_s=
truct *p, bool escape)
>  	else if (p->flags & PF_KTHREAD)
>  		get_kthread_comm(tcomm, sizeof(tcomm), p);
>  	else
> -		__get_task_comm(tcomm, sizeof(tcomm), p);
> +		get_task_comm(tcomm, p);

LGTM.  (This would have been good even if not removing the helper.)

> =20
>  	if (escape)
>  		seq_escape_str(m, tcomm, ESCAPE_SPACE | ESCAPE_SPECIAL, "\n\\");
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 33dd8d9d2b85..e0e26edbda61 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1096,9 +1096,11 @@ struct task_struct {
>  	/*
>  	 * executable name, excluding path.
>  	 *
> -	 * - normally initialized setup_new_exec()
> -	 * - access it with [gs]et_task_comm()
> -	 * - lock it with task_lock()
> +	 * - normally initialized begin_new_exec()
> +	 * - set it with set_task_comm()
> +	 *   - strscpy_pad() to ensure it is always NUL-terminated

The comment above is inmprecise.
It should say either
"strscpy() to ensure it is always NUL-terminated", or
"strscpy_pad() to ensure it is NUL-terminated and zero-padded".

> +	 *   - task_lock() to ensure the operation is atomic and the name is
> +	 *     fully updated.
>  	 */
>  	char				comm[TASK_COMM_LEN];
> =20
> @@ -1912,10 +1914,27 @@ static inline void set_task_comm(struct task_stru=
ct *tsk, const char *from)
>  	__set_task_comm(tsk, from, false);
>  }
> =20
> -extern char *__get_task_comm(char *to, size_t len, struct task_struct *t=
sk);
> +/*
> + * - Why not use task_lock()?
> + *   User space can randomly change their names anyway, so locking for r=
eaders
> + *   doesn't make sense. For writers, locking is probably necessary, as =
a race
> + *   condition could lead to long-term mixed results.
> + *   The strscpy_pad() in __set_task_comm() can ensure that the task com=
m is
> + *   always NUL-terminated.

This comment has the same imprecission that I noted above.

> Therefore the race condition between reader and
> + *   writer is not an issue.
> + *
> + * - Why not use strscpy_pad()?
> + *   While strscpy_pad() prevents writing garbage past the NUL terminato=
r, which
> + *   is useful when using the task name as a key in a hash map, most use=
 cases
> + *   don't require this. Zero-padding might confuse users if it=E2=80=99=
s unnecessary,
> + *   and not zeroing might even make it easier to expose bugs. If you ne=
ed a
> + *   zero-padded task name, please handle that explicitly at the call si=
te.
> + *
> + * - ARRAY_SIZE() can help ensure that @buf is indeed an array.
> + */
>  #define get_task_comm(buf, tsk) ({			\
> -	BUILD_BUG_ON(sizeof(buf) !=3D TASK_COMM_LEN);	\
> -	__get_task_comm(buf, sizeof(buf), tsk);		\
> +	strscpy(buf, (tsk)->comm, ARRAY_SIZE(buf));	\
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

Other than that, LGTM.

--=20
<https://www.alejandro-colomar.es/>

--62fk5rgm4hdf5yga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAma5wkAACgkQnowa+77/
2zIerBAAjn3HL/5KRo0RJMvfZHqb7XVmLQlWw/O9qz5vv2ZOa7fTVN0WbAscF9HY
bTJGyIikJsrsKoQpLI+ySjhJmRUS0LNg3bKxgVgYPUjt/tl3zWPd9TZ+o7dTQ3Dn
+tPCRs0xF316BxTbnT66L6dFjckXQMJcM1wlUsBZqbIfdfiFq9wzbnVOCxmmn2Z3
gvDvmDg7M9E0D5dQCjow6VQNKuBe/HUT7SY9nWZllYnRZH9hRlYQ/GW7SHFSiV75
LnHWi81xvQ8F0c2hf3DSZGRSunrLTir7TRIfHL/8OpP2ckiqdsEbrgDl6jRz9f6w
6a2M9MfaQSQ0l0X+Wnr5gk0fdGoyePm1Xmx/3yrTzV/4CGNEqvcgHvkmqbz30HbF
6AoDwXK0JZdA20ANRSayUuNtv7T+ZJ3xZQbe2CTyNMGD4kaF4J1V359CZMUEx2D1
mgSypDxkGUYRDf91dN2jYcsDDtP3YbysfiTxVNViwDRgXyFVIyo8FIo8P0+q6QRG
n5ebmcAD2CIqE/MKcuEr4DHoa+HD08eIYPC29VP/XoUTuq0fVSJehf3zloCtrRUh
TtVlWEAeDKzZ6xkglyYH6cgMKAkM+s/v+ctXw6SgF9SJfMBXTTn33VTsqj86JGOO
w/kuIw8T7OCnuVKRRRho3C7ciI5Wu7Whf8cOv/l125fp2OJq9NM=
=AhLH
-----END PGP SIGNATURE-----

--62fk5rgm4hdf5yga--

