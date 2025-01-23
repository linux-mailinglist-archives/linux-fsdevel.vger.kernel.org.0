Return-Path: <linux-fsdevel+bounces-39982-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA85A1A8D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 18:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216B13A267D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 17:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E72142E6F;
	Thu, 23 Jan 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOs8JA6s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123F013D520
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 17:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652745; cv=none; b=gNed2EdywwLCc4QpHHr67GskQ8YTszDLwo0VU5hOqMZhjGnoire7w7K/wyIvmizlXYQX1uzHEhjA3NgJnfcMnTCR2O72zca2UO0EcPpswUAfkiVEXCEBd08rysIlcLVY7h17ShYXYTbwzuquTJYRLbTTbQwVIiAn1bHYR4xCjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652745; c=relaxed/simple;
	bh=fViDk1X+t9WrNG2L998gi1MGkd69s1mbb+gH5NBNEnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JPRKQU1918svStDo7a10t0SNFJh3YiqigdOKE+ytJpMahPhDAIjIjzEClnTxwxjG6MdPGPWyr4EFHdselxv309yv5vm8u7VCp2ZyeRDkNJCPXO0P8ukGac/leZPn4X5v6vZK0Asdy0jGWvX/nRRI5nIZSfOHwlPAYamuX69ghLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOs8JA6s; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b6e4d38185so118815585a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737652742; x=1738257542; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUltR5Av2kO2dxPngb0/OiESS5vCPHIIgjujp1tm92E=;
        b=cOs8JA6seQaISCGXakaivmYTbpWwuD4JhdryJEf3mPK+V91aFX3CrP0apNkM7PMvOY
         RLS2ofGm6nx+pci//4QdHoquPTyj8QcK71oX1zPgnQ5bTtf1OuRigcg4PVyLddQznO2C
         7xW1YWHUC3np9ZWqUtLaVpZ9+ocKGv0jxE6vkN1VwHq4UdTFhi069C2sUlHVS6lAqb4k
         Cf8D48NwC82mdDmIuVvmG50cblt1EpvxZLT0eHNcu5hSGbFdlBhFqT5wbRh4YV8IujgK
         Na0PqXiUf1wYR9dmku7gLQ+1FKa84y9B5kh/XzQ+6ak6usCOzlkVbu/E3Qv8E/PWHQ0K
         032A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652742; x=1738257542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUltR5Av2kO2dxPngb0/OiESS5vCPHIIgjujp1tm92E=;
        b=hMwoFqOVOOxc5egX4ShP4WRd1UUMnEMdYeUrIayxnc9yAmkRdIRa75c4fWskSbufvM
         p6Y96KoK7mFsh2lX1Mr/Bo336PEJR8cNcQSxVZDUIdjHIgfxNNhbnMcnnmAPVny7hRSb
         XyEa6HAga5Z663T5lUpiowtPJgRCM1K+P64sB7dAZyYegJqvS6SfBe26EiSe+YbESk+H
         hqmaRCQigjjwp0yM7W2/D/tmL396zG4T1mD7/381yX/AE5WmwTEMoSVBSzflb4C9SKrD
         t2lRO5848HIRk0HgEjZWwxkW/jdQbh18E7Mc4W/aHWsI8NfTanoHzALjNHftXLAMhOME
         HnVg==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ1+KIMMvLKbh2wq4n4S819u6J+RVfmToFZSj9e29vmEv/oZQZJBJQvIWtdbyey1ru+jQ855o9hGlYHlz@vger.kernel.org
X-Gm-Message-State: AOJu0YxKmVPLNulCGk4ZoqTpy2aHCakTtDk57B2NHRT534nESwCwB0YZ
	UY/QtEkUJSoUTpHfb07bSswqJigp4JltLRtlO5fEhtdimzEjV/YM4Wl9WUDUTy6hLBvR8Q0sZ2z
	faeJyk6g7FLnF5RXQk9wtklNB7Wk=
X-Gm-Gg: ASbGncvVDQUhb/+YgUOyaEJhC2DIRIz4dFR4rYG/nSBKcue1/L67StyzY/uun3EXrkX
	ZbC0kA1ARJEImkgkxWK+aV7DnOrN/cdDC20IoqSZGwOKnJNxtJ96VzOsTs3+HuETDf/leChDb4S
	oBEw==
X-Google-Smtp-Source: AGHT+IGpsSE2/9hetCLCpZI036yxYzSGP0Rn1APynOOeTv4+cmZaFl8m6BOQKFgvEpuXlslKFk2oRt6Lo8z1L9PDD7s=
X-Received: by 2002:a05:620a:2588:b0:7b6:d241:d4ae with SMTP id
 af79cd13be357-7be6327c505mr3743377985a.42.1737652741698; Thu, 23 Jan 2025
 09:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
In-Reply-To: <87ikq5x4ws.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 09:18:51 -0800
X-Gm-Features: AbW1kva98XVZEr_DoMwDGH_uAEjX60mixX7iLe8lurGJWxa8WcyT0Wpg_Fd3yRs
Message-ID: <CAJnrk1aNyk6meJObQKgQ3Szv6aws7QJqYJS5bGYYVApOBqWOcw@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Luis Henriques <luis@igalia.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	jlayton@kernel.org, senozhatsky@chromium.org, tfiga@chromium.org, 
	bgeffon@google.com, etmartin4313@gmail.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:21=E2=80=AFAM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Joanne,
>
> On Wed, Jan 22 2025, Joanne Koong wrote:
>
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control how long (in seconds) a server can
> > take to reply to a request. If the server does not reply by the timeout=
,
> > then the connection will be aborted. The upper bound on these sysctl
> > values is 65535.
> >
> > "default_request_timeout" sets the default timeout if no timeout is
> > specified by the fuse server on mount. 0 (default) indicates no default
> > timeout should be enforced. If the server did specify a timeout, then
> > default_request_timeout will be ignored.
> >
> > "max_request_timeout" sets the max amount of time the server may take t=
o
> > reply to a request. 0 (default) indicates no maximum timeout. If
> > max_request_timeout is set and the fuse server attempts to set a
> > timeout greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. Similarly, if default_request_timeo=
ut
> > is greater than max_request_timeout, the system will use
> > max_request_timeout as the timeout. If the server does not request a
> > timeout and default_request_timeout is set to 0 but max_request_timeout
> > is set, then the timeout will be max_request_timeout.
> >
> > Please note that these timeouts are not 100% precise. The request may
> > take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set ma=
x
> > timeout due to how it's internally implemented.
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 0
> >
> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >
> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 65535
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 65535
> >
> > $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> > 0
> >
> > $ sysctl -a | grep fuse.default_request_timeout
> > fs.fuse.default_request_timeout =3D 0
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > ---
> >  Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++++++++++++++++
> >  fs/fuse/fuse_i.h                        | 10 +++++++++
> >  fs/fuse/inode.c                         | 28 +++++++++++++++++++++++--
> >  fs/fuse/sysctl.c                        | 24 +++++++++++++++++++++
> >  4 files changed, 85 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/ad=
min-guide/sysctl/fs.rst
> > index f5ec6c9312e1..35aeb30bed8b 100644
> > --- a/Documentation/admin-guide/sysctl/fs.rst
> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > @@ -347,3 +347,28 @@ filesystems:
> >  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> >  setting/getting the maximum number of pages that can be used for servi=
cing
> >  requests in FUSE.
> > +
> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> > +setting/getting the default timeout (in seconds) for a fuse server to
> > +reply to a kernel-issued request in the event where the server did not
> > +specify a timeout at mount. If the server set a timeout,
> > +then default_request_timeout will be ignored.  The default
> > +"default_request_timeout" is set to 0. 0 indicates no default timeout.
> > +The maximum value that can be set is 65535.
> > +
> > +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> > +setting/getting the maximum timeout (in seconds) for a fuse server to
> > +reply to a kernel-issued request. A value greater than 0 automatically=
 opts
> > +the server into a timeout that will be set to at most "max_request_tim=
eout",
> > +even if the server did not specify a timeout and default_request_timeo=
ut is
> > +set to 0. If max_request_timeout is greater than 0 and the server set =
a timeout
> > +greater than max_request_timeout or default_request_timeout is set to =
a value
> > +greater than max_request_timeout, the system will use max_request_time=
out as the
> > +timeout. 0 indicates no max request timeout. The maximum value that ca=
n be set
> > +is 65535.
> > +
> > +For timeouts, if the server does not respond to the request by the tim=
e
> > +the set timeout elapses, then the connection to the fuse server will b=
e aborted.
> > +Please note that the timeouts are not 100% precise (eg you may set 60 =
seconds but
> > +the timeout may kick in after 70 seconds). The upper margin of error f=
or the
> > +timeout is roughly FUSE_TIMEOUT_TIMER_FREQ seconds.
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 1321cc4ed2ab..e5114831798f 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -49,6 +49,16 @@ extern const unsigned long fuse_timeout_timer_freq;
> >
> >  /** Maximum of max_pages received in init_out */
> >  extern unsigned int fuse_max_pages_limit;
> > +/*
> > + * Default timeout (in seconds) for the server to reply to a request
> > + * before the connection is aborted, if no timeout was specified on mo=
unt.
> > + */
> > +extern unsigned int fuse_default_req_timeout;
> > +/*
> > + * Max timeout (in seconds) for the server to reply to a request befor=
e
> > + * the connection is aborted.
> > + */
> > +extern unsigned int fuse_max_req_timeout;
> >
> >  /** List of active connections */
> >  extern struct list_head fuse_conn_list;
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 79ebeb60015c..4e36d99fae52 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -37,6 +37,9 @@ DEFINE_MUTEX(fuse_mutex);
> >  static int set_global_limit(const char *val, const struct kernel_param=
 *kp);
> >
> >  unsigned int fuse_max_pages_limit =3D 256;
> > +/* default is no timeout */
> > +unsigned int fuse_default_req_timeout =3D 0;
> > +unsigned int fuse_max_req_timeout =3D 0;
> >
> >  unsigned max_user_bgreq;
> >  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> > @@ -1268,6 +1271,24 @@ static void set_request_timeout(struct fuse_conn=
 *fc, unsigned int timeout)
> >                          fuse_timeout_timer_freq);
> >  }
> >
> > +static void init_server_timeout(struct fuse_conn *fc, unsigned int tim=
eout)
> > +{
> > +     if (!timeout && !fuse_max_req_timeout && !fuse_default_req_timeou=
t)
> > +             return;
> > +
> > +     if (!timeout)
> > +             timeout =3D fuse_default_req_timeout;
> > +
> > +     if (fuse_max_req_timeout) {
> > +             if (timeout)
> > +                     timeout =3D min(fuse_max_req_timeout, timeout);
>
> Sorry for this late comment (this is v12 already!), but I wonder if it
> would be worth to use clamp() instead of min().  Limiting this value to
> the range [FUSE_TIMEOUT_TIMER_FREQ, fuxe_max_req_timeout] would prevent
> accidentally setting the timeout to a very low value.

I don't think we need to clamp to FUSE_TIMEOUT_TIMER_FREQ. If the user
sets a timeout value lower than FUSE_TIMEOUT_TIMER_FREQ (15 secs), imo
that should be supported. For example, if the user sets the timeout to
10 seconds, then the connection should be aborted if the request takes
13 seconds. I don't see why we need to have the min bound be
FUSE_TIMEOUT_TIMER_FREQ. imo, the user-specified timeout value and
FUSE_TIMEOUT_TIMER_FREQ value are orthogonal. But I also don't feel
strongly about this and am fine with whichever way we go.

Thanks,
Joanne

>
> There are also some white-spaces/tabs issues with the other patch, which
> are worth fixing before merging.  Other than that, feel free to add my
>
> Reviewed-by: Luis Henriques <luis@igalia.com>
>
> Cheers,
> --
> Lu=C3=ADs
>
> > +             else
> > +                     timeout =3D fuse_max_req_timeout;
> > +     }
> > +
> > +     set_request_timeout(fc, timeout);
> > +}
> > +
> >  struct fuse_init_args {
> >       struct fuse_args args;
> >       struct fuse_init_in in;
> > @@ -1286,6 +1307,7 @@ static void process_init_reply(struct fuse_mount =
*fm, struct fuse_args *args,
> >               ok =3D false;
> >       else {
> >               unsigned long ra_pages;
> > +             unsigned int timeout =3D 0;
> >
> >               process_init_limits(fc, arg);
> >
> > @@ -1404,14 +1426,16 @@ static void process_init_reply(struct fuse_moun=
t *fm, struct fuse_args *args,
> >                       if (flags & FUSE_OVER_IO_URING && fuse_uring_enab=
led())
> >                               fc->io_uring =3D 1;
> >
> > -                     if ((flags & FUSE_REQUEST_TIMEOUT) && arg->reques=
t_timeout)
> > -                             set_request_timeout(fc, arg->request_time=
out);
> > +                     if (flags & FUSE_REQUEST_TIMEOUT)
> > +                             timeout =3D arg->request_timeout;
> >               } else {
> >                       ra_pages =3D fc->max_read / PAGE_SIZE;
> >                       fc->no_lock =3D 1;
> >                       fc->no_flock =3D 1;
> >               }
> >
> > +             init_server_timeout(fc, timeout);
> > +
> >               fm->sb->s_bdi->ra_pages =3D
> >                               min(fm->sb->s_bdi->ra_pages, ra_pages);
> >               fc->minor =3D arg->minor;
> > diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> > index b272bb333005..3d542ef9d889 100644
> > --- a/fs/fuse/sysctl.c
> > +++ b/fs/fuse/sysctl.c
> > @@ -13,6 +13,12 @@ static struct ctl_table_header *fuse_table_header;
> >  /* Bound by fuse_init_out max_pages, which is a u16 */
> >  static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
> >
> > +/*
> > + * fuse_init_out request timeouts are u16.
> > + * This goes up to ~18 hours, which is plenty for a timeout.
> > + */
> > +static unsigned int sysctl_fuse_req_timeout_limit =3D 65535;
> > +
> >  static struct ctl_table fuse_sysctl_table[] =3D {
> >       {
> >               .procname       =3D "max_pages_limit",
> > @@ -23,6 +29,24 @@ static struct ctl_table fuse_sysctl_table[] =3D {
> >               .extra1         =3D SYSCTL_ONE,
> >               .extra2         =3D &sysctl_fuse_max_pages_limit,
> >       },
> > +     {
> > +             .procname       =3D "default_request_timeout",
> > +             .data           =3D &fuse_default_req_timeout,
> > +             .maxlen         =3D sizeof(fuse_default_req_timeout),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D &sysctl_fuse_req_timeout_limit,
> > +     },
> > +     {
> > +             .procname       =3D "max_request_timeout",
> > +             .data           =3D &fuse_max_req_timeout,
> > +             .maxlen         =3D sizeof(fuse_max_req_timeout),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D &sysctl_fuse_req_timeout_limit,
> > +     },
> >  };
> >
> >  int fuse_sysctl_register(void)
> > --
> > 2.43.5
> >
>

