Return-Path: <linux-fsdevel+bounces-40016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A543A1AD28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jan 2025 00:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 617F8188A517
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 23:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526A31C331E;
	Thu, 23 Jan 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfvL7uo9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9EF1E884
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737674132; cv=none; b=QLpCOsdQs5BzHbw+rOmfCfKAQKX4c1ShoWYzkf0/E2yuMqiAD/rFPQlkcOLImiHBKPZjigQwrcVxi0nQc+lvAAFx/2vqSXQDaEoUhy74pzmu9VXRThh0Q00sIR7CccBnhe85iU39g00H6bkLMI11ny0yZQXe93nSs8Z05LEIklw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737674132; c=relaxed/simple;
	bh=JHtv2q932zXSBu76okRCePIggBrxRocva0fdDFGWxIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIwoM8IvWekRKcaqjTPg+mmFVRhUQ5u0b4rHqfl47qnapaUg7USLgF9YM9RmIFojK3uNGa7BBUxmnSkdDyaVmBS2rdpxZflyDT75UR5ooL3DeDuv2QJ2KAAODkGAwGbXMAB2EA8MZpcbVW6gpA98fTghdiXi6NStx4+BVQVFqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfvL7uo9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46df3fc7176so14709271cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 15:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737674130; x=1738278930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3oQv+61FH/djOfO+CdA8NmHF8UAZ3aX+4Dpe3AD7Ng=;
        b=SfvL7uo9CMalIIW9UquXRcT43532H/1Qt/14ZBGu6ppLXH72dBykhVjS/Ir0YPbjUc
         J3YiYWtA+iTAVsGFUr51WCTR/7JDSfoAHlfZ/1Og0ngZpbpsb97ZAlZeWFRUk8aRB/Cd
         jlGaKgclw+LmUW0J4uFPQNMU0JZza4NSQgE1pyxFOZZx8yahUFdUFvSN9GuSc1KkaqGT
         obGMcsYANiXAzBvS2iKDhmBJRNc4Z0uqGnAuai1RDLF2X4y/MxFfFUeumAW17KkyFXNk
         /IPhuQ5cWPlKB+jMffVAcCsojanFAuzGydTYtayrNAMI+ncFJbOC8LoGYV4JlJIW6Jub
         Yiag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737674130; x=1738278930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3oQv+61FH/djOfO+CdA8NmHF8UAZ3aX+4Dpe3AD7Ng=;
        b=eU7/4O7ck0cNx93lpEkmAmzZR6WPfSz6hewIQ3UVWdWuV35cDyUYo5csJ8jy7dFOio
         AnPVtJXxvmvKPsmxFGO4gTKFZUV69o1w9BdHyY1jROfXj3opNOIN20ouJ/hjlnEOIPw5
         nIu0p3CCfdQQKX1erQw6MNebbNxm/X2RMMj8swU1+w+isxGTNc3XXi1b+fGUXnduwy50
         f2O/WylvoE9l49f/3ZbgHHbtr5tkmhbt3s+BshAceBcsmMgAi/ZFtHcnBInK0k0PpPkO
         VTzJT2RKQUtrE3Vno+sQQlS5d4EqUo9Sh9awpYG7QlfMFPjxOlKkAFd8o1hjosV1HOlZ
         BBNA==
X-Forwarded-Encrypted: i=1; AJvYcCVr1FDT8KPaSw5TBg4ExnpIEXml3tFp5FJR7gzuWRlQQFMxVn9VZ5BgR33wOZMAhaWqvhH2Ru49NVdgoqqa@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWxhIU4lnTBr38ssCpMdoUQ+XKrEY932+H/lrPsJxiCtdAk/3
	0Hz+/yabwD6FgEU+m+o3vurRAhQlPcK/7h5i/WGlD65DdwcNcv2fdYhcRStWMg6UrFkQ9MuH3iM
	54Za8stzd35dSxzfA4IFMteSxsI4=
X-Gm-Gg: ASbGncvwDwXFGDkCokx5zyxHUTHEx0cUJrXw+PeBqBNR+oiej245+Vb90hV2UzDJSdi
	Ep9QJOp+wa+Mi1p74svaZZ5kQhdax2NXMwCUY7ECOAi/ZQb5+cJaGxN/ewmNc2ZN4NVVJ8F61Qd
	+KPQ==
X-Google-Smtp-Source: AGHT+IGN/MV1mNzv5Kg1IUZctxf2rknCeIWE2/nqijOqIOoj3pRVA3QuAnavYWsr4Hrf2FLjK+wuWidz1ugQLx6kRDw=
X-Received: by 2002:a05:6214:260b:b0:6d8:92c9:12a0 with SMTP id
 6a1803df08f44-6e1b224cc1cmr412028196d6.44.1737674129628; Thu, 23 Jan 2025
 15:15:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
 <20250122215528.1270478-3-joannelkoong@gmail.com> <87ikq5x4ws.fsf@igalia.com>
 <CAJnrk1aNyk6meJObQKgQ3Szv6aws7QJqYJS5bGYYVApOBqWOcw@mail.gmail.com> <874j1pkxgc.fsf@igalia.com>
In-Reply-To: <874j1pkxgc.fsf@igalia.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Jan 2025 15:15:18 -0800
X-Gm-Features: AbW1kvYJWLGu9FXNYczdyF8UlGz1kFxi7mpliescpRJyJ_W-FDftrV8J1Ef2sOc
Message-ID: <CAJnrk1ZiFycvy-KBEsuT9JsM+KmjsbfbVvjNDeX_i4zWAWTUyw@mail.gmail.com>
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

On Thu, Jan 23, 2025 at 1:53=E2=80=AFPM Luis Henriques <luis@igalia.com> wr=
ote:
>
> Hi Joanne,
>
> On Thu, Jan 23 2025, Joanne Koong wrote:
>
> > On Thu, Jan 23, 2025 at 1:21=E2=80=AFAM Luis Henriques <luis@igalia.com=
> wrote:
> >>
> >> Hi Joanne,
> >>
> >> On Wed, Jan 22 2025, Joanne Koong wrote:
> >>
> >> > Introduce two new sysctls, "default_request_timeout" and
> >> > "max_request_timeout". These control how long (in seconds) a server =
can
> >> > take to reply to a request. If the server does not reply by the time=
out,
> >> > then the connection will be aborted. The upper bound on these sysctl
> >> > values is 65535.
> >> >
> >> > "default_request_timeout" sets the default timeout if no timeout is
> >> > specified by the fuse server on mount. 0 (default) indicates no defa=
ult
> >> > timeout should be enforced. If the server did specify a timeout, the=
n
> >> > default_request_timeout will be ignored.
> >> >
> >> > "max_request_timeout" sets the max amount of time the server may tak=
e to
> >> > reply to a request. 0 (default) indicates no maximum timeout. If
> >> > max_request_timeout is set and the fuse server attempts to set a
> >> > timeout greater than max_request_timeout, the system will use
> >> > max_request_timeout as the timeout. Similarly, if default_request_ti=
meout
> >> > is greater than max_request_timeout, the system will use
> >> > max_request_timeout as the timeout. If the server does not request a
> >> > timeout and default_request_timeout is set to 0 but max_request_time=
out
> >> > is set, then the timeout will be max_request_timeout.
> >> >
> >> > Please note that these timeouts are not 100% precise. The request ma=
y
> >> > take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set=
 max
> >> > timeout due to how it's internally implemented.
> >> >
> >> > $ sysctl -a | grep fuse.default_request_timeout
> >> > fs.fuse.default_request_timeout =3D 0
> >> >
> >> > $ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >> > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> >> >
> >> > $ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >> > 65535
> >> >
> >> > $ sysctl -a | grep fuse.default_request_timeout
> >> > fs.fuse.default_request_timeout =3D 65535
> >> >
> >> > $ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
> >> > 0
> >> >
> >> > $ sysctl -a | grep fuse.default_request_timeout
> >> > fs.fuse.default_request_timeout =3D 0
> >> >
> >> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> >> > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> >> > Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >> > ---
> >> >  Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++++++++++++++++
> >> >  fs/fuse/fuse_i.h                        | 10 +++++++++
> >> >  fs/fuse/inode.c                         | 28 ++++++++++++++++++++++=
+--
> >> >  fs/fuse/sysctl.c                        | 24 +++++++++++++++++++++
> >> >  4 files changed, 85 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation=
/admin-guide/sysctl/fs.rst
> >> > index f5ec6c9312e1..35aeb30bed8b 100644
> >> > --- a/Documentation/admin-guide/sysctl/fs.rst
> >> > +++ b/Documentation/admin-guide/sysctl/fs.rst
> >> > @@ -347,3 +347,28 @@ filesystems:
> >> >  ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
> >> >  setting/getting the maximum number of pages that can be used for se=
rvicing
> >> >  requests in FUSE.
> >> > +
> >> > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file =
for
> >> > +setting/getting the default timeout (in seconds) for a fuse server =
to
> >> > +reply to a kernel-issued request in the event where the server did =
not
> >> > +specify a timeout at mount. If the server set a timeout,
> >> > +then default_request_timeout will be ignored.  The default
> >> > +"default_request_timeout" is set to 0. 0 indicates no default timeo=
ut.
> >> > +The maximum value that can be set is 65535.
> >> > +
> >> > +``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
> >> > +setting/getting the maximum timeout (in seconds) for a fuse server =
to
> >> > +reply to a kernel-issued request. A value greater than 0 automatica=
lly opts
> >> > +the server into a timeout that will be set to at most "max_request_=
timeout",
> >> > +even if the server did not specify a timeout and default_request_ti=
meout is
> >> > +set to 0. If max_request_timeout is greater than 0 and the server s=
et a timeout
> >> > +greater than max_request_timeout or default_request_timeout is set =
to a value
> >> > +greater than max_request_timeout, the system will use max_request_t=
imeout as the
> >> > +timeout. 0 indicates no max request timeout. The maximum value that=
 can be set
> >> > +is 65535.
> >> > +
> >> > +For timeouts, if the server does not respond to the request by the =
time
> >> > +the set timeout elapses, then the connection to the fuse server wil=
l be aborted.
> >> > +Please note that the timeouts are not 100% precise (eg you may set =
60 seconds but
> >> > +the timeout may kick in after 70 seconds). The upper margin of erro=
r for the
> >> > +timeout is roughly FUSE_TIMEOUT_TIMER_FREQ seconds.
> >> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> >> > index 1321cc4ed2ab..e5114831798f 100644
> >> > --- a/fs/fuse/fuse_i.h
> >> > +++ b/fs/fuse/fuse_i.h
> >> > @@ -49,6 +49,16 @@ extern const unsigned long fuse_timeout_timer_fre=
q;
> >> >
> >> >  /** Maximum of max_pages received in init_out */
> >> >  extern unsigned int fuse_max_pages_limit;
> >> > +/*
> >> > + * Default timeout (in seconds) for the server to reply to a reques=
t
> >> > + * before the connection is aborted, if no timeout was specified on=
 mount.
> >> > + */
> >> > +extern unsigned int fuse_default_req_timeout;
> >> > +/*
> >> > + * Max timeout (in seconds) for the server to reply to a request be=
fore
> >> > + * the connection is aborted.
> >> > + */
> >> > +extern unsigned int fuse_max_req_timeout;
> >> >
> >> >  /** List of active connections */
> >> >  extern struct list_head fuse_conn_list;
> >> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> >> > index 79ebeb60015c..4e36d99fae52 100644
> >> > --- a/fs/fuse/inode.c
> >> > +++ b/fs/fuse/inode.c
> >> > @@ -37,6 +37,9 @@ DEFINE_MUTEX(fuse_mutex);
> >> >  static int set_global_limit(const char *val, const struct kernel_pa=
ram *kp);
> >> >
> >> >  unsigned int fuse_max_pages_limit =3D 256;
> >> > +/* default is no timeout */
> >> > +unsigned int fuse_default_req_timeout =3D 0;
> >> > +unsigned int fuse_max_req_timeout =3D 0;
> >> >
> >> >  unsigned max_user_bgreq;
> >> >  module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
> >> > @@ -1268,6 +1271,24 @@ static void set_request_timeout(struct fuse_c=
onn *fc, unsigned int timeout)
> >> >                          fuse_timeout_timer_freq);
> >> >  }
> >> >
> >> > +static void init_server_timeout(struct fuse_conn *fc, unsigned int =
timeout)
> >> > +{
> >> > +     if (!timeout && !fuse_max_req_timeout && !fuse_default_req_tim=
eout)
> >> > +             return;
> >> > +
> >> > +     if (!timeout)
> >> > +             timeout =3D fuse_default_req_timeout;
> >> > +
> >> > +     if (fuse_max_req_timeout) {
> >> > +             if (timeout)
> >> > +                     timeout =3D min(fuse_max_req_timeout, timeout)=
;
> >>
> >> Sorry for this late comment (this is v12 already!), but I wonder if it
> >> would be worth to use clamp() instead of min().  Limiting this value t=
o
> >> the range [FUSE_TIMEOUT_TIMER_FREQ, fuxe_max_req_timeout] would preven=
t
> >> accidentally setting the timeout to a very low value.
> >
> > I don't think we need to clamp to FUSE_TIMEOUT_TIMER_FREQ. If the user
> > sets a timeout value lower than FUSE_TIMEOUT_TIMER_FREQ (15 secs), imo
> > that should be supported. For example, if the user sets the timeout to
> > 10 seconds, then the connection should be aborted if the request takes
> > 13 seconds. I don't see why we need to have the min bound be
> > FUSE_TIMEOUT_TIMER_FREQ. imo, the user-specified timeout value and
> > FUSE_TIMEOUT_TIMER_FREQ value are orthogonal. But I also don't feel
> > strongly about this and am fine with whichever way we go.
>
> Sure, my comment was just a suggestion too.  I just thought it would be
> easy to accidentally set the timeout to '1' instead of '10', and that thi=
s
> very low value could cause troubles.  On the other hand, I understand tha=
t
> 15 secondss is probably too high for using as a minimum.  Anyway, this wa=
s
> just my 2=C2=A2.
>

Hi Luis,

i see that Miklos already merged the suggestion in. I don't feel
strongly either way so I'll just leave it as is then.

Thanks,
Joanne

> Cheers,
> --
> Luis
>
> >

> >>

