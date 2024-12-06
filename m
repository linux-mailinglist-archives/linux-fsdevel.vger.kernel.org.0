Return-Path: <linux-fsdevel+bounces-36666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC81D9E77EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 19:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B906D16460C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2024 18:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11821FFC4B;
	Fri,  6 Dec 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcA+sWFV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF48256E
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Dec 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733508991; cv=none; b=UPhFequ2pQtGIDW7y+/tOP1Tb7tKGqUpQoqZpGACMWTMJdqePf34hJGja0RQRPoYnPM8MM4/EkootfAI0l3XUeY1UeXR/mnmZ+xkZ/sF791p+ppLfpogWZzwz17QmGSpjxo3o+E8OLgrBSsL87KX6DyooVFu3+vkKomu2VtEp8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733508991; c=relaxed/simple;
	bh=G3oYq20PCk2mDsDBSmgRi4otpeMDoRNwx6FCgtpstB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PokQA3hCJfu93kzy2q/7No33aQragHNR4K66wnnNV9qZLoLsyX2F/mvRrdhIQpGHA6RdTfKxeb8cy5bhSuOn7Sf7rEormOaWSWnXvaJAuVLUegGyZaZsjHvNGjXAW5Gvdzz32DAQGQhnG2Y2T2NP4HI+ty0Ylb67Fg6iq8xNlzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcA+sWFV; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-46684744173so39701711cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2024 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733508988; x=1734113788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YSGoofVsvvAOtfMcUS/5tDeWlEiedBqxdhWjldPLYl0=;
        b=EcA+sWFVwX4I2xycFlfc2pCVeYNcbCdRBzQiprHn8E4+C6r5hjLS5K3CVXYGyoe/jM
         +zGpbtPYOgzEtRXm8YTgF31XAPEyMrwWa18UDa2P5kfmvAb4UUu6KScNxk8vUfAJCB8D
         YKtk4v19GrDdltKqlex8cy8+JtIzRhOmsuRZyJMHDZGJFPTvN4lcURn7yUH5qZKhr1LH
         kxRVk+LwSm8+YRGUhYKnfBC80DFz4y+w4WLjoGpDZLo9VEiP51OFiqcYLj2nv5s+qQCq
         Z1Oi0dLM6qqD2GuR3s6PM/Y49HIgkHccW3scV7J1hDiJCXiiIBbonKmgGu9d3iMqsb2F
         ecfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733508988; x=1734113788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YSGoofVsvvAOtfMcUS/5tDeWlEiedBqxdhWjldPLYl0=;
        b=XfQb8Hu/o8SV+SBZGzcxT7YpIoHG0VTECajmiHhH6kPcf1aSpEpM8kSOTk0kvFu4Qh
         QXp0y+6FmIYzUhmUkBD/SLEaBzIbdplRYJs5tb1ZyykWUsO9GwyS7kZHWan3CCG48svx
         k7Zv3oKuIxO0TD6eWN0F2ceb8lssmelhvviN3jLgIqm2rh2dUzvMVZqDEIq0B0aQaqhc
         DXuLrYYNZNOImDRpy9Brm3dzE/TWz91mgHfXLavyO/5ofFUBZoDZONxe6F+xsDc3vchx
         0c9Cl4HcMZrPYU6Z7ZPZdK7siA1/akuF4+KjYqghtW0lmXU2vCe0Z9wxZNLDhbDDMFqj
         Nq3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWGALP5ko34L05wP88iKgQmiGVDyxMDxt9POz5Ii++gXHoHnFuu7ub7vU3t1p5I7g7NL6LiTVjvxc7UA0+@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JS9BnioaBmEodZOKIKdq2xjBccAkANKVxwT493kMzAil+y1n
	T2NTt+JjI/Nf2EYVOEG2vHD/c6XpBEWV8XyeJzTZx5tIxZ96+ArjK20jv3AdSyNX4lkjxbNwzHX
	AbNEQKZHrspsY4SREKgUkIWWhTkc2zQ==
X-Gm-Gg: ASbGncsOIDfpbhyNkvVBfn776fgJluHisKRE4CFw8ozSFF9noR8mBJEBzjlVDWRanAI
	di8fA0nYDy7ot3FlaftzQA1S7dJyRZsAXjffYQmkUE6nAIVU=
X-Google-Smtp-Source: AGHT+IHQTwe71tmqifI60NmsqlhTYpK/5g79iuNnWLs4kf3nUaNxC7NCsmgY3RFfO0K03L8Rck97htndPNd1XnOfCOA=
X-Received: by 2002:a05:622a:4a:b0:466:98e1:cc70 with SMTP id
 d75a77b69052e-46734cbba2emr60494671cf.14.1733508988266; Fri, 06 Dec 2024
 10:16:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114191332.669127-1-joannelkoong@gmail.com>
 <20241114191332.669127-4-joannelkoong@gmail.com> <d626ecff2108849b896dc93b3baa860127589f52.camel@poochiereds.net>
In-Reply-To: <d626ecff2108849b896dc93b3baa860127589f52.camel@poochiereds.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 6 Dec 2024 10:16:17 -0800
Message-ID: <CAJnrk1Y38eKLqzWaPUf64ATU4boG+R+qo+sH3arsZ2xNXSGiVQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 3/3] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Jeff Layton <jlayton@poochiereds.net>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, laoar.shao@gmail.com, 
	kernel-team@meta.com, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 4:43=E2=80=AFPM Jeff Layton <jlayton@poochiereds.net=
> wrote:
>
> On Thu, 2024-11-14 at 11:13 -0800, Joanne Koong wrote:
> > Introduce two new sysctls, "default_request_timeout" and
> > "max_request_timeout". These control how long (in minutes) a server can
> > take to reply to a request. If the server does not reply by the timeout=
,
> > then the connection will be aborted.
> >
>
> Is this patch really needed? You have a per-mount limit already, do we
> need a global default and max?

Yes, I do think this patch would be useful. Since fuse servers can run
unprivileged, I think giving system admins some way to enforce a
default and max limit that applies automatically to all fuse servers
would help protect against malicious or buggy servers on the system.

>
> Also, ditto here wrt seconds vs. minutes. If these *are* needed, then
> having them expressed in seconds would be more intuitive for most
> admins.

Noted. I'll change this to seconds in the next iteration of this patchset.
>
>
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
> > take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeou=
t
> > due to how it's internally implemented.
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
> > ---
> >  Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++++++++++++++++
> >  fs/fuse/fuse_i.h                        | 10 +++++++++
> >  fs/fuse/inode.c                         | 16 +++++++++++++--
> >  fs/fuse/sysctl.c                        | 20 ++++++++++++++++++
> >  4 files changed, 71 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/ad=
min-guide/sysctl/fs.rst
> > index fa25d7e718b3..790a34291467 100644
> > --- a/Documentation/admin-guide/sysctl/fs.rst
> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > @@ -342,3 +342,30 @@ filesystems:
> >  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> >  setting/getting the maximum number of pages that can be used for servi=
cing
> >  requests in FUSE.
> > +
> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
> > +setting/getting the default timeout (in minutes) for a fuse server to
> > +reply to a kernel-issued request in the event where the server did not
> > +specify a timeout at mount. If the server set a timeout,
> > +then default_request_timeout will be ignored.  The default
> > +"default_request_timeout" is set to 0. 0 indicates a no-op (eg
> > +requests will not have a default request timeout set if no timeout was
> > +specified by the server).
> > +
> > +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> > +setting/getting the maximum timeout (in minutes) for a fuse server to
> > +reply to a kernel-issued request. A value greater than 0 automatically=
 opts
> > +the server into a timeout that will be at most "max_request_timeout", =
even if
> > +the server did not specify a timeout and default_request_timeout is se=
t to 0.
> > +If max_request_timeout is greater than 0 and the server set a timeout =
greater
> > +than max_request_timeout or default_request_timeout is set to a value =
greater
> > +than max_request_timeout, the system will use max_request_timeout as t=
he
> > +timeout. 0 indicates a no-op (eg requests will not have an upper bound=
 on the
> > +timeout and if the server did not request a timeout and default_reques=
t_timeout
> > +was not set, there will be no timeout).
> > +
> > +Please note that for the timeout options, if the server does not respo=
nd to
> > +the request by the time the timeout elapses, then the connection to th=
e fuse
> > +server will be aborted. Please also note that the timeouts are not 100=
%
> > +precise (eg you may set 10 minutes but the timeout may kick in after 1=
1
> > +minutes).
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 9092201c4e0b..e82ddff8d752 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -46,6 +46,16 @@
> >
> >  /** Maximum of max_pages received in init_out */
> >  extern unsigned int fuse_max_pages_limit;
> > +/*
> > + * Default timeout (in minutes) for the server to reply to a request
> > + * before the connection is aborted, if no timeout was specified on mo=
unt.
> > + */
> > +extern unsigned int fuse_default_req_timeout;
> > +/*
> > + * Max timeout (in minutes) for the server to reply to a request befor=
e
> > + * the connection is aborted.
> > + */
> > +extern unsigned int fuse_max_req_timeout;
> >
> >  /** List of active connections */
> >  extern struct list_head fuse_conn_list;
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index ee006f09cd04..1e7cc6509e42 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -36,6 +36,9 @@ DEFINE_MUTEX(fuse_mutex);
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
> > @@ -1701,8 +1704,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount)=
;
> >
> >  static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_=
context *ctx)
> >  {
> > -     if (ctx->req_timeout) {
> > -             if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->ti=
meout.req_timeout))
> > +     unsigned int timeout =3D ctx->req_timeout ?: fuse_default_req_tim=
eout;
> > +
> > +     if (fuse_max_req_timeout) {
> > +             if (!timeout)
> > +                     timeout =3D fuse_max_req_timeout;
> > +             else
> > +                     timeout =3D min(timeout, fuse_max_req_timeout);
> > +     }
> > +
> > +     if (timeout) {
> > +             if (check_mul_overflow(timeout * 60, HZ, &fc->timeout.req=
_timeout))
> >                       fc->timeout.req_timeout =3D ULONG_MAX;
> >               timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
> >               mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIME=
R_FREQ);
> > diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
> > index b272bb333005..6a9094e17950 100644
> > --- a/fs/fuse/sysctl.c
> > +++ b/fs/fuse/sysctl.c
> > @@ -13,6 +13,8 @@ static struct ctl_table_header *fuse_table_header;
> >  /* Bound by fuse_init_out max_pages, which is a u16 */
> >  static unsigned int sysctl_fuse_max_pages_limit =3D 65535;
> >
> > +static unsigned int sysctl_fuse_max_req_timeout_limit =3D U16_MAX;
> > +
> >  static struct ctl_table fuse_sysctl_table[] =3D {
> >       {
> >               .procname       =3D "max_pages_limit",
> > @@ -23,6 +25,24 @@ static struct ctl_table fuse_sysctl_table[] =3D {
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
> > +             .extra2         =3D &sysctl_fuse_max_req_timeout_limit,
> > +     },
> > +     {
> > +             .procname       =3D "max_request_timeout",
> > +             .data           =3D &fuse_max_req_timeout,
> > +             .maxlen         =3D sizeof(fuse_max_req_timeout),
> > +             .mode           =3D 0644,
> > +             .proc_handler   =3D proc_douintvec_minmax,
> > +             .extra1         =3D SYSCTL_ZERO,
> > +             .extra2         =3D &sysctl_fuse_max_req_timeout_limit,
> > +     },
> >  };
> >
> >  int fuse_sysctl_register(void)
>
> --
> Jeff Layton <jlayton@poochiereds.net>

