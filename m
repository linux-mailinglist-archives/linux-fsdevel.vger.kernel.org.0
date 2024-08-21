Return-Path: <linux-fsdevel+bounces-26418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CCB959290
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 04:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204CF288144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 02:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546C53370;
	Wed, 21 Aug 2024 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czHHAN0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35EA55C29
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 02:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724205647; cv=none; b=kwQFPK8KIu766OgCRFhnLc5wesBTKZvT5G3tfvGPjHPa93CFqlD/DU3IJBpX7WXTOWPxbCTqpUpxzpjyIC5gqnTbyd6J5meLHSFlwQ/3U97qjMVX3wRpONH6lynANLgEDZqsrNiUomxwvS+sj1IywcA4qfjE5QhwwUmUrF2gRJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724205647; c=relaxed/simple;
	bh=BaJwxO+p5xk4tXvrc4hEfQYst4boFHMnDG33sVtmKR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FTy3EYBxoIRdfLPH28V0F24dF+JjEw9eag0O6WaPRY8eEv4X6z5u5HboHX0XjdiaGmG4kjprDDwpVqaTV1xzzmaFysy61dSSEE+0GNHeEdt4Sx/s2mAseMWYrBtfyJqVbN6kQMborMW+DJs8MJkb00Bo4yzqlfvppPRg7xtAfhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czHHAN0/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6bf84c3d043so23794816d6.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724205645; x=1724810445; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wytmRlzDo2FbbIdUXZ3oAXvUgEfp7aHkVTlea7M312k=;
        b=czHHAN0/Ngiv9zWOuOBti65Tl5c29oDFU98r7ha9HlS0DHv3VEHWvd2ZBDffA5BaHT
         nYntCfmxRvER/oL4ntWn23wKgU20azqdq73gJe1Sk0D3rFxrvHDN2Jn6e3EZSXPU9FM4
         3eA/AIOYpdAjCGCaPOSNW8GPvJbMCaRKfm5fnCj/GlN4KMFLQTTKlZmftrQW/qyd4NWm
         5gEllWCQKOuF/EAyRtE/+xQnPOMSn47pR9le6dGdoNJM3nvhBAJjwvkncGWRiqB+YIqL
         DHSalib1pW0YXLmrawjMlU7DwEMby7s4AV0TFXyZAymI6CZNiRP/rhj2mVgOzgaLTz+T
         OTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724205645; x=1724810445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wytmRlzDo2FbbIdUXZ3oAXvUgEfp7aHkVTlea7M312k=;
        b=S+OpgK5sn5K54W9oYs0sr/K4M6K1I1vUFgp+re7+syb7M9AISfEOPouXGgwHDg2Upx
         f01S8w49MQQZKzxJDjIoYD67snMJhW+rUrXYXMELXc828f2XOWsuK2UXM8rQMcUkLUgG
         cw0V7RrL2IfI1ttRpYDB6NKE6zDtWM2RvFKg3FW4gzARwt6XFrBOKTwHsmki+7n5t+ok
         DRL2ZW6UbZBPeR+zDYWp58EePbqLkYK6xb8Nbkp8zWjpzdq7rUGi7glA8FCswNagChIy
         5W7w2N55ofj6VR3xf03YO/jIntUTRnWyde/Iem7If7LvX3TEHYPXQTVBH9x404fYvsa/
         Twog==
X-Forwarded-Encrypted: i=1; AJvYcCUu1muvdiXkAekquUARVbM7FfBTBSVial1X6YYZvlBRUlRrAUkbEIUkQ4mD9sFluNfZp1DPA3m27iDTkt7H@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6+lGYTmtbcxw7I/3aIV/zE6j4vsbTDY6cMyOJ2FzOtahVDop/
	CWUsh+bnYCcMJRjPQhkaippLNCrsnG2Z4umSCLlRy6z5vxiE8/gA7S6ub1VmLvRVlkYTYrdQEe7
	+1zWxaAnMPK0bhucRrI68Cz8mGcA=
X-Google-Smtp-Source: AGHT+IHYynoA5QeKVwCPeqF9JH5YGU89njlNkXCOD50vgrQ/0x7v4JYaQ5QByODyqG7Oh2m6A+/YUF87BPbLgVAfK1M=
X-Received: by 2002:a05:6214:4406:b0:6bf:6f7e:39c1 with SMTP id
 6a1803df08f44-6c155e25357mr11609506d6.47.1724205644794; Tue, 20 Aug 2024
 19:00:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813232241.2369855-1-joannelkoong@gmail.com>
 <20240813232241.2369855-3-joannelkoong@gmail.com> <CALOAHbDt6QiUt4mzMx2DS=16u5dx1tnPBqO2kT4gh_9gBgoq1A@mail.gmail.com>
 <CAJnrk1aVLeFTmW-zYhoFhsvQ148C1XF8a+qda48GZqqU7UiP-w@mail.gmail.com>
In-Reply-To: <CAJnrk1aVLeFTmW-zYhoFhsvQ148C1XF8a+qda48GZqqU7UiP-w@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 21 Aug 2024 10:00:08 +0800
Message-ID: <CALOAHbATRgAzN=E-=6zcmUB3qtB1ca5KBg6KAVcvtZNMR_WMVQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] fuse: add default_request_timeout and
 max_request_timeout sysctls
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 2:31=E2=80=AFAM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Aug 19, 2024 at 11:40=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Wed, Aug 14, 2024 at 7:24=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > Introduce two new sysctls, "default_request_timeout" and
> > > "max_request_timeout". These control timeouts on replies by the
> > > server to kernel-issued fuse requests.
> > >
> > > "default_request_timeout" sets a timeout if no timeout is specified b=
y
> > > the fuse server on mount. 0 (default) indicates no timeout should be =
enforced.
> > >
> > > "max_request_timeout" sets a maximum timeout for fuse requests. If th=
e
> > > fuse server attempts to set a timeout greater than max_request_timeou=
t,
> > > the system will default to max_request_timeout. Similarly, if the max
> > > default timeout is greater than the max request timeout, the system w=
ill
> > > default to the max request timeout. 0 (default) indicates no timeout =
should
> > > be enforced.
> > >
> > > $ sysctl -a | grep fuse
> > > fs.fuse.default_request_timeout =3D 0
> > > fs.fuse.max_request_timeout =3D 0
> > >
> > > $ echo 0x100000000 | sudo tee /proc/sys/fs/fuse/default_request_timeo=
ut
> > > tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument
> > >
> > > $ echo 0xFFFFFFFF | sudo tee /proc/sys/fs/fuse/default_request_timeou=
t
> > > 0xFFFFFFFF
> > >
> > > $ sysctl -a | grep fuse
> > > fs.fuse.default_request_timeout =3D 4294967295
> > > fs.fuse.max_request_timeout =3D 0
> > >
> > > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > > Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> > > Reviewed-by: Bernd Schubert <bschubert@ddn.com>
> > > ---
> > >  Documentation/admin-guide/sysctl/fs.rst | 17 ++++++++++
> > >  fs/fuse/Makefile                        |  2 +-
> > >  fs/fuse/fuse_i.h                        | 16 ++++++++++
> > >  fs/fuse/inode.c                         | 19 ++++++++++-
> > >  fs/fuse/sysctl.c                        | 42 +++++++++++++++++++++++=
++
> > >  5 files changed, 94 insertions(+), 2 deletions(-)
> > >  create mode 100644 fs/fuse/sysctl.c
> > >
> > > diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/=
admin-guide/sysctl/fs.rst
> > > index 47499a1742bd..44fd495f69b4 100644
> > > --- a/Documentation/admin-guide/sysctl/fs.rst
> > > +++ b/Documentation/admin-guide/sysctl/fs.rst
> > > @@ -332,3 +332,20 @@ Each "watch" costs roughly 90 bytes on a 32-bit =
kernel, and roughly 160 bytes
> > >  on a 64-bit one.
> > >  The current default value for ``max_user_watches`` is 4% of the
> > >  available low memory, divided by the "watch" cost in bytes.
> > > +
> > > +5. /proc/sys/fs/fuse - Configuration options for FUSE filesystems
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +This directory contains the following configuration options for FUSE
> > > +filesystems:
> > > +
> > > +``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file f=
or
> > > +setting/getting the default timeout (in seconds) for a fuse server t=
o
> > > +reply to a kernel-issued request in the event where the server did n=
ot
> > > +specify a timeout at mount. 0 indicates no timeout.
> >
> > While testing on my servers, I observed that the timeout value appears
> > to be doubled. For instance, if I set the timeout to 10 seconds, the
> > "Timer expired" message occurs after 20 seconds.
> >
> > Is this an expected behavior, or is the doubling unavoidable? I'm okay
> > with it as long as we have a functioning timeout. However, I recommend
> > documenting this behavior to avoid any potential confusion for users.
>
> Hi Yafang,
>
> Are you testing this by running "cat hello" from the libfuse hello
> example server and seeing the doubled timeout?

right.

>
> This is happening because cat hello sends two FUSE_READ requests. The
> first FUSE_READ is a background request (called from
> fuse_readahead()). I confirmed that this takes 10 seconds to time out
> and then the timeout handler kicks in. Then the second FUSE_READ is a
> regular request (called from fuse_read_folio() -> fuse_do_readpage()).
> This second request also takes 10 seconds to time out. After this
> second request times out is when the "cat hello" returns, which is why
> the overall time is 20 seconds because of the 2 requests each taking
> 10 seconds.
>

Thanks for your detailed explanation.

--=20
Regards
Yafang

