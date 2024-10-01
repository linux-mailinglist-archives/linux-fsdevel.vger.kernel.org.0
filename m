Return-Path: <linux-fsdevel+bounces-30563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A18B098C587
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 20:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 268671F225FC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 18:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63823194083;
	Tue,  1 Oct 2024 18:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="oG5Z2ZTx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3BE1CCB30;
	Tue,  1 Oct 2024 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727808210; cv=none; b=I0H4WsP57/yZTw+5qZVWsRrYGs/xYtP+ykHG1EW3D3/HexfbIGcge9n+8eBsH7qa9EuG8BLe1d5vDnzcp1z0bpX96LtCFUxrlkDm56Gt6gRr80oHM2xvRJTij/oXRywZcamVwVKCN72toOyuhuMsnS8XLsF0wI55p0oWWrDU5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727808210; c=relaxed/simple;
	bh=kxsD0tcrpOtkWzlDymask8mRZIgqH1j9jpMBg93Ru08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yfw3/97VVI+gqGR9+vBmRstkIxDD1+oLHmeuA7dB+s4Epk2eqKCGCVTKb7Uwu2PhUofiy3bCeDdKDbp41VVp8DkEgxUmn5Z/3j5rEjaXZZki9VHIb3yLGQnRpN27uDfEigXwCwwS1jg/uQ+3Uyhf7xSfnd7cXUWua55gQhaSMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=oG5Z2ZTx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XJ6Jk63MBz9stL;
	Tue,  1 Oct 2024 20:43:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1727808198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SfckWOZyeKCCTkxlw0k8OsZZpMs7CWgdY49hBe8AMoU=;
	b=oG5Z2ZTxIpWVgyVsZemiSxwbZUERvfeEdxz0D41pOp46VXnRvnqIZE/8cLih9YvGZQ+/S0
	1fa0AWD0FuRL5s8FgJER8vVDtQv5tAoIxrVd9QPt3YxM2qy+nS3YMa3Ze4kM9Q5xzYuuQj
	spi0sIx0wHSbC45DLMkThHYvDnMsXZobaGs84oN6VQi9iPoxBRtLtGI+w7hVe2G6yKU8s0
	e372CE9pRP2d0pPjK3zSDEUfwZ1rbkujnrtXbZgLvPk4uxw4VAFGRTSmye33sDQPTapImS
	rJspoTiIc8bakMSuge7Uqqww72ikghA9G24jeVUu405coV488g4Tpl49FDmbDQ==
Date: Tue, 1 Oct 2024 20:42:56 +0200
From: Aleksa Sarai <cyphar@cyphar.com>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Tycho Andersen <tandersen@netflix.com>, Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: [PATCH v3 1/2] exec: fix up /proc/pid/comm in the
 execveat(AT_EMPTY_PATH) case
Message-ID: <20241001.175124-western.preview.meager.saws-pzvpWxOhfokt@cyphar.com>
References: <20241001134945.798662-1-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3lo5xmu6ghn35bw"
Content-Disposition: inline
In-Reply-To: <20241001134945.798662-1-tycho@tycho.pizza>


--q3lo5xmu6ghn35bw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-01, Tycho Andersen <tycho@tycho.pizza> wrote:
> From: Tycho Andersen <tandersen@netflix.com>
>=20
> Zbigniew mentioned at Linux Plumber's that systemd is interested in
> switching to execveat() for service execution, but can't, because the
> contents of /proc/pid/comm are the file descriptor which was used,
> instead of the path to the binary. This makes the output of tools like
> top and ps useless, especially in a world where most fds are opened
> CLOEXEC so the number is truly meaningless.
>=20
> Change exec path to fix up /proc/pid/comm in the case where we have
> allocated one of these synthetic paths in bprm_init(). This way the actual
> exec machinery is unchanged, but cosmetically the comm looks reasonable to
> admins investigating things.

While I still think the argv[0] solution was semantically nicer, it
seems this is enough to fix the systemd problem for most cases and so we
can revisit the argv[0] discussion in another 10 years. :D

Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>

> Signed-off-by: Tycho Andersen <tandersen@netflix.com>
> Suggested-by: Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> Link: https://github.com/uapi-group/kernel-features#set-comm-field-before=
-exec
> ---
> v2: * drop the flag, everyone :)
>     * change the rendered value to f_path.dentry->d_name.name instead of
>       argv[0], Eric
> v3: * fix up subject line, Eric
> ---
>  fs/exec.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/exec.c b/fs/exec.c
> index dad402d55681..9520359a8dcc 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1416,7 +1416,18 @@ int begin_new_exec(struct linux_binprm * bprm)
>  		set_dumpable(current->mm, SUID_DUMP_USER);
> =20
>  	perf_event_exec();
> -	__set_task_comm(me, kbasename(bprm->filename), true);
> +
> +	/*
> +	 * If fdpath was set, execveat() made up a path that will
> +	 * probably not be useful to admins running ps or similar.
> +	 * Let's fix it up to be something reasonable.
> +	 */
> +	if (bprm->fdpath) {
> +		BUILD_BUG_ON(TASK_COMM_LEN > DNAME_INLINE_LEN);
> +		__set_task_comm(me, bprm->file->f_path.dentry->d_name.name, true);
> +	} else {
> +		__set_task_comm(me, kbasename(bprm->filename), true);
> +	}
> =20
>  	/* An exec changes our domain. We are no longer part of the thread
>  	   group */
>=20
> base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
> --=20
> 2.34.1
>=20

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--q3lo5xmu6ghn35bw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCZvxCsAAKCRAol/rSt+lE
b9a7AQCywMOUyIiShRxJolrjyHBHkJI94qweiIBj8LqxUmjrpQEAnpFpW/U64Nn6
jN42oNJkKE07fVbcd+YXiM4zAGksbgg=
=XP0W
-----END PGP SIGNATURE-----

--q3lo5xmu6ghn35bw--

