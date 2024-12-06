Return-Path: <linux-fsdevel+bounces-36584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E29E625F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE121882DF4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85112208DA;
	Fri,  6 Dec 2024 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b="f0t7e7gy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EC4C9A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 00:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733445794; cv=none; b=bOuz1gwXHyUtxZIsmLqQrquWYX5zVHO+FXyB3I+1fCZPBe6IZac2UafkqQ5ObmLSs5Yr3MfrWqa868MHMfzE7o0j4HqQanss1k7V9S3QHNUFgJ1OM/4gDtyKjugSJgrI49zL/kll/WxFymRXLnhIK1+Zhhgm6dT1UxU1rPzZRXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733445794; c=relaxed/simple;
	bh=LF3VHU+A46SYFHb8Uzn3Q6i0j91+JTJGgMchpKGIlwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZDCoCfY38YblIBDFHckEQwkZ+XQWGIRWeDrXbUUPQy2IBmr3aCdnAzRfyJTOiZxQnW4NmyGRJ5w+Rvfw6KWh8zPFItBkIrFympquNHdfPZaQ4nD2akzUh+czZZPOpgLYItoM4skJYYM8JXy52MjYXW/kHCLUkdIO+T1nBnHYYmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net; spf=pass smtp.mailfrom=poochiereds.net; dkim=pass (2048-bit key) header.d=poochiereds-net.20230601.gappssmtp.com header.i=@poochiereds-net.20230601.gappssmtp.com header.b=f0t7e7gy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=poochiereds.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poochiereds.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21145812538so12582585ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 16:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poochiereds-net.20230601.gappssmtp.com; s=20230601; t=1733445790; x=1734050590; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ciRaoq1yV0b6VfvZLYMNdej9y+jQtOAKcQ1wn+hSscI=;
        b=f0t7e7gyd9R5tx/vqI8Lzc7bXBVo3R7AMvwRWS9Ga+HspajD9l8ubV+nIXjhZZBx7G
         h/0n0NuSO449aj30IeE9aqn8mPl0Oq6Q6mGCNkQbA/0Dd9SuUwVVpTXX3qox+LxD8eHY
         ACAsg/4TeB6RU6nN3A2seB06XGPB3Kq75K1byAiNSpVUkRqVTahZeITPgjiueC3eZtcB
         nrLLIaea25iWjgA4ncGF3xY65UzJOkaoI6edhrgWP7qUaUYgGzFNTbWnSQt3pw3jnjMz
         /7HpZcdgoZ3QIgYmXAgMcdjBe33ZgnUtnJUzPbP6tdzzo4OKvrEyS9e7olSlA8lSDc5H
         ugHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733445790; x=1734050590;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ciRaoq1yV0b6VfvZLYMNdej9y+jQtOAKcQ1wn+hSscI=;
        b=u1nwqxjZdEglNlNdq2xenpPt7xLMp1KWoDTFfa3a7wLUCgrU18kx/QdVId8Y7SqOen
         46XFjvnI/o/Wyl+/5t8rlkimZs/Wy/BppVbtPQVrrKx0CLq/mG6pDvtGVOGioH6Cw7mh
         TfoGGX9kTIEtUEuqaVgTrfs24gqPFVS0Fo3HzaqBc0dPK7jUU8t59ksYNkNMaBGx0exG
         zRToCUiOZmBOdkhWhx40q+lwQMFPs0V+77FTp4G2QZmUe2cIVeRDSTgNW7XUgF5lR4fc
         6tNJwAoBZZIefO6ukSSbLJpbLIgc+2lCIAAc+b08m87e1WWmWYy/x50twFyfdHZLtDoq
         Q4Sw==
X-Forwarded-Encrypted: i=1; AJvYcCUwgYCNuuhVuk7blXSN0J/d3WAwXP1hNYOl7Znf2zplNEPo2OymUbgItqFsYZ9bHM96rlF/OXBEhwoSuF+e@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5pVaOLBvXtp0W9PYnkiusXynBS0UDKhaacWHG1m3snGs81QCo
	ZrTZx0gTmyFH8DgHodGrqIFsQpIXugUqOYJWdQZZ+WG8WHWr51yqGfnmKFa+gjtfd8FzYsa99LJ
	P
X-Gm-Gg: ASbGncsfkQuhxaRcp2gWcejl9PQNhOL1fBZ9MOifIS7lQ39f3mCF2dvqsaF2sKQgYQX
	FcRnop3VuF3prQ02iNYgHjY51Hwy/H0Rzyw/v8OlnZbl1rIKq9Pw840cTxVOi5E93XJ0a+HYWWP
	1IVb587pwDCY1ZnpQvPjrb3f6zyloRSV+M2dpjoH0mqRIzaFF+LSZguwAWsPgwzV4ckNccZvRBZ
	Rfm2mNOLjet2295TFO7JA3FYv1kU9Xs5K7loqGSWsuL/x1F8vDc86q8YYboBYUsFWGdAMNdgAXI
	i7rGpV4=
X-Google-Smtp-Source: AGHT+IHzHltMOCSnutYsIZRSSGure+DKDAvvQxguEwspYKRiDyqMVS8UFOnmG2vWA0nNzGajPFAWQA==
X-Received: by 2002:a17:902:fc84:b0:215:352c:af5d with SMTP id d9443c01a7336-21614d7e3ecmr13043435ad.25.1733445790153;
        Thu, 05 Dec 2024 16:43:10 -0800 (PST)
Received: from ?IPv6:2a03:83e0:1151:18:9a3:d23e:c44a:c3d9? ([2620:10d:c090:500::4:561f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8f0b571sm18377755ad.183.2024.12.05.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:43:09 -0800 (PST)
Message-ID: <d626ecff2108849b896dc93b3baa860127589f52.camel@poochiereds.net>
Subject: Re: [PATCH RESEND v9 3/3] fuse: add default_request_timeout and
 max_request_timeout sysctls
From: Jeff Layton <jlayton@poochiereds.net>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu, 
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com, bernd.schubert@fastmail.fm, 
 jefflexu@linux.alibaba.com, laoar.shao@gmail.com, kernel-team@meta.com,
 Bernd Schubert <bschubert@ddn.com>
Date: Thu, 05 Dec 2024 16:43:08 -0800
In-Reply-To: <20241114191332.669127-4-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
	 <20241114191332.669127-4-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@poochiereds.net; prefer-encrypt=mutual;
 keydata=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
 q/2QWqNFB6xOBr5rQ5xwl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-11-14 at 11:13 -0800, Joanne Koong wrote:
> Introduce two new sysctls, "default_request_timeout" and
> "max_request_timeout". These control how long (in minutes) a server can
> take to reply to a request. If the server does not reply by the timeout,
> then the connection will be aborted.
>=20

Is this patch really needed? You have a per-mount limit already, do we
need a global default and max?

Also, ditto here wrt seconds vs. minutes. If these *are* needed, then
having them expressed in seconds would be more intuitive for most
admins.


> "default_request_timeout" sets the default timeout if no timeout is
> specified by the fuse server on mount. 0 (default) indicates no default
> timeout should be enforced. If the server did specify a timeout, then
> default_request_timeout will be ignored.
>=20
> "max_request_timeout" sets the max amount of time the server may take to
> reply to a request. 0 (default) indicates no maximum timeout. If
> max_request_timeout is set and the fuse server attempts to set a
> timeout greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. Similarly, if default_request_timeout
> is greater than max_request_timeout, the system will use
> max_request_timeout as the timeout. If the server does not request a
> timeout and default_request_timeout is set to 0 but max_request_timeout
> is set, then the timeout will be max_request_timeout.
>=20
> Please note that these timeouts are not 100% precise. The request may
> take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeout
> due to how it's internally implemented.
>=20
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout =3D 0
>=20
> $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
>=20
> $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 65535
>=20
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout =3D 65535
>=20
> $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> 0
>=20
> $ sysctl -a | grep fuse.default_request_timeout
> fs.fuse.default_request_timeout =3D 0
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++++++++++++++++
>  fs/fuse/fuse_i.h                        | 10 +++++++++
>  fs/fuse/inode.c                         | 16 +++++++++++++--
>  fs/fuse/sysctl.c                        | 20 ++++++++++++++++++
>  4 files changed, 71 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admi=
n-guide/sysctl/fs.rst
> index fa25d7e718b3..790a34291467 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -342,3 +342,30 @@ filesystems:
>  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
>  setting/getting the maximum number of pages that can be used for servici=
ng
>  requests in FUSE.
> +
> +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> +setting/getting the default timeout (in minutes) for a fuse server to
> +reply to a kernel-issued request in the event where the server did not
> +specify a timeout at mount. If the server set a timeout,
> +then default_request_timeout will be ignored.  The default
> +"default_request_timeout" is set to 0. 0 indicates a no-op (eg
> +requests will not have a default request timeout set if no timeout was
> +specified by the server).
> +
> +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> +setting/getting the maximum timeout (in minutes) for a fuse server to
> +reply to a kernel-issued request. A value greater than 0 automatically o=
pts
> +the server into a timeout that will be at most "max_request_timeout", ev=
en if
> +the server did not specify a timeout and default_request_timeout is set =
to 0.
> +If max_request_timeout is greater than 0 and the server set a timeout gr=
eater
> +than max_request_timeout or default_request_timeout is set to a value gr=
eater
> +than max_request_timeout, the system will use max_request_timeout as the
> +timeout. 0 indicates a no-op (eg requests will not have an upper bound o=
n the
> +timeout and if the server did not request a timeout and default_request_=
timeout
> +was not set, there will be no timeout).
> +
> +Please note that for the timeout options, if the server does not respond=
 to
> +the request by the time the timeout elapses, then the connection to the =
fuse
> +server will be aborted. Please also note that the timeouts are not 100%
> +precise (eg you may set 10 minutes but the timeout may kick in after 11
> +minutes).
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index 9092201c4e0b..e82ddff8d752 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -46,6 +46,16 @@
> =20
>  /** Maximum of max_pages received in init_out */
>  extern unsigned int fuse_max_pages_limit;
> +/*
> + * Default timeout (in minutes) for the server to reply to a request
> + * before the connection is aborted, if no timeout was specified on moun=
t.
> + */
> +extern unsigned int fuse_default_req_timeout;
> +/*
> + * Max timeout (in minutes) for the server to reply to a request before
> + * the connection is aborted.
> + */
> +extern unsigned int fuse_max_req_timeout;
> =20
>  /** List of active connections */
>  extern struct list_head fuse_conn_list;
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index ee006f09cd04..1e7cc6509e42 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -36,6 +36,9 @@ DEFINE_MUTEX(fuse_mutex);
>  static int set_global_limit(const char *val, const struct kernel_param *=
kp);
> =20
>  unsigned int fuse_max_pages_limit =3D 256;
> +/* default is no timeout */
> +unsigned int fuse_default_req_timeout =3D 0;
> +unsigned int fuse_max_req_timeout =3D 0;
> =20
>  unsigned max_user_bgreq;
>  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> @@ -1701,8 +1704,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
> =20
>  static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_co=
ntext *ctx)
>  {
> -	if (ctx->req_timeout) {
> -		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_tim=
eout))
> +	unsigned int timeout =3D ctx->req_timeout ?: fuse_default_req_timeout;
> +
> +	if (fuse_max_req_timeout) {
> +		if (!timeout)
> +			timeout =3D fuse_max_req_timeout;
> +		else
> +			timeout =3D min(timeout, fuse_max_req_timeout);
> +	}
> +
> +	if (timeout) {
> +		if (check_mul_overflow(timeout * 60, HZ, &fc->timeout.req_timeout))
>  			fc->timeout.req_timeout =3D ULONG_MAX;
>  		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
>  		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
> diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> index b272bb333005..6a9094e17950 100644
> --- a/fs/fuse/sysctl.c
> +++ b/fs/fuse/sysctl.c
> @@ -13,6 +13,8 @@ static struct ctl_table_header *fuse_table_header;
>  /* Bound by fuse_init_out max_pages, which is a u16 */
>  static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
> =20
> +static unsigned int sysctl_fuse_max_req_timeout_limit =3D U16_MAX;
> +
>  static struct ctl_table fuse_sysctl_table[] =3D {
>  	{
>  		.procname	=3D "max_pages_limit",
> @@ -23,6 +25,24 @@ static struct ctl_table fuse_sysctl_table[] =3D {
>  		.extra1		=3D SYSCTL_ONE,
>  		.extra2		=3D &sysctl_fuse_max_pages_limit,
>  	},
> +	{
> +		.procname	=3D "default_request_timeout",
> +		.data		=3D &fuse_default_req_timeout,
> +		.maxlen		=3D sizeof(fuse_default_req_timeout),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_douintvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D &sysctl_fuse_max_req_timeout_limit,
> +	},
> +	{
> +		.procname	=3D "max_request_timeout",
> +		.data		=3D &fuse_max_req_timeout,
> +		.maxlen		=3D sizeof(fuse_max_req_timeout),
> +		.mode		=3D 0644,
> +		.proc_handler	=3D proc_douintvec_minmax,
> +		.extra1		=3D SYSCTL_ZERO,
> +		.extra2		=3D &sysctl_fuse_max_req_timeout_limit,
> +	},
>  };
> =20
>  int fuse_sysctl_register(void)

--=20
Jeff Layton <jlayton@poochiereds.net>

