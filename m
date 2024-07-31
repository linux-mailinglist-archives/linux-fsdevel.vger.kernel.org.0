Return-Path: <linux-fsdevel+bounces-24706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E949435D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 20:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28AC285683
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04F64778E;
	Wed, 31 Jul 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXvee1ES"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D643169
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 18:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722451604; cv=none; b=VV5rMAIlzv/8jJN9B+W/l9ZcGBdaKVtHg2HZt88PmN2g19qIyMXUZLHllslyLUhyJuVhCj+uVzj20lV9CRtE6g2/4LAq4xXlgVHB8odFRjLsBZgktCMPeuCKvzw3M1FXGWBTwLG0V3qXM3+pLQ7Uj5TsL28SYCK/4Co4yeqspYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722451604; c=relaxed/simple;
	bh=PWqJo/61YusE8XVIKFS8Yd4fprAg5/5PyxQCXIF/P/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFiE9G9V/jCDDf0xmuBD9x5XJUQArKQeKDofQxM1pc9RyS1NKpXNKCK2INp/yR+VrDXT3pwrBAMgBVzQcgExOffMenx59TOHnTCVply9/zpcT5zdhV9gZUl9ccuyC86ovjJhIXoHjfamWg/E3u4dE8Dx4BDD+vmwyQMJDfespAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXvee1ES; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ed741fe46so6953232e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722451600; x=1723056400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEoTjQxko5FzNfOPq3ZVw3bGOJcOInnzLGuFbZ+ZF3U=;
        b=AXvee1ESojlSiljRmOkEydbTJueM4Xm37mqpa4t8HmM+VZmdJkIk4z/qCeTDD5/3/g
         stdqKNmCPbZsf1NFp+UL2HYtrW4emrOkilAxlv+2gXK1NQxVfV8kq+SZbT0DS3T524OW
         o5pJYo8qjunFiCysIP6G7LWGPAqwoKTanZJgakix7H7IsXnrbFyR+hmjPU53mC0S1Stu
         GJDRWxL+G87cWRbWrOZAR43U89/JCKSZavlfYKQln7HVVAHegfXImc6wu/J+BplAJBYV
         Vu0/4D5WYrRpHcUyHgVijAWrH+9DJtadSJBVZI84BIUMD+LCDgiKivJswTiGib/Ewdjb
         zt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722451600; x=1723056400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEoTjQxko5FzNfOPq3ZVw3bGOJcOInnzLGuFbZ+ZF3U=;
        b=Kpi3NPpfQqu6JKxy83Mb/0nhEORzG+0to93filSjYq76f/7507AoZ1dKTBSaFzMfxr
         YFMXCZ0Qxc0zK1nH4i/3JdeGAX56brBHySrNaVqDRIp3izfqXqbii6SSOrY38LB89yur
         DSQcqXkeDO9VHMQdy4iNu3xcCZ0HOqtYz6+TwYo+Fu+J7fwlWjfK0YywksuG2YIMsU2Z
         QQGp6evqRbGd1fNwGumjaXCL/Qr6/nX+AUr6+yG0e3vpZoOoHOJ7oLnknj8JO8mb23Ks
         6XW3h+uT2Y7i9sUV0V1t16C3/b4Q7/soamULciUuF0bwcTpDD612NryXbXwK2nyCC3Jx
         s92g==
X-Forwarded-Encrypted: i=1; AJvYcCW4AZaH26JE253QWTNlPn9hDrptQuSiLhiZU/ec8mF5QjpLSx8Mza4eZmDfdxgCXcVCZ56+/vd8HWv4TEPrAHQQa6xw4KXSeags5QrpiQ==
X-Gm-Message-State: AOJu0YwbOyxK7JHDipW6z6NnB0YTID1ZzpaGjOUtx+uBKQn14LqiJfb8
	0+Vc1UI8nBR7SUPtOHxH0L2ooSm4i3pVkjVNHx1k6GSp3ffzzDVvkNWJAq+R/dn/yxa/PQdRzuz
	UzJwnSwXLdOaCV2TtHZONp7KbohA=
X-Google-Smtp-Source: AGHT+IGeEuUKG1z97cRWs95AVdgot+ucxsj/zqZuOCUoENiwPSBKZ5/RmJrmpgPXs4n8/nYYRwXanRHAajgH/mMoi50=
X-Received: by 2002:a05:6512:128b:b0:52d:582e:4117 with SMTP id
 2adb3069b0e04-5309b2ce92dmr11624298e87.54.1722451599773; Wed, 31 Jul 2024
 11:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
 <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com> <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 31 Jul 2024 11:46:26 -0700
Message-ID: <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 10:52=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> > >
> > > On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> > > >
> > > > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelkoong@=
gmail.com> wrote:
> > > > >
> > > > > There are situations where fuse servers can become unresponsive o=
r take
> > > > > too long to reply to a request. Currently there is no upper bound=
 on
> > > > > how long a request may take, which may be frustrating to users wh=
o get
> > > > > stuck waiting for a request to complete.
> > > > >
> > > > > This patchset adds a timeout option for requests and two dynamica=
lly
> > > > > configurable fuse sysctls "default_request_timeout" and "max_requ=
est_timeout"
> > > > > for controlling/enforcing timeout behavior system-wide.
> > > > >
> > > > > Existing fuse servers will not be affected unless they explicitly=
 opt into the
> > > > > timeout.
> > > > >
> > > > > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-=
1-joannelkoong@gmail.com/
> > > > > Changes from v1:
> > > > > - Add timeout for background requests
> > > > > - Handle resend race condition
> > > > > - Add sysctls
> > > > >
> > > > > Joanne Koong (2):
> > > > >   fuse: add optional kernel-enforced timeout for requests
> > > > >   fuse: add default_request_timeout and max_request_timeout sysct=
ls
> > > > >
> > > > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > > > >  fs/fuse/Makefile                        |   2 +-
> > > > >  fs/fuse/dev.c                           | 187 ++++++++++++++++++=
+++++-
> > > > >  fs/fuse/fuse_i.h                        |  30 ++++
> > > > >  fs/fuse/inode.c                         |  24 +++
> > > > >  fs/fuse/sysctl.c                        |  42 ++++++
> > > > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > > > >  create mode 100644 fs/fuse/sysctl.c
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
> > > >
> > > > Hello Joanne,
> > > >
> > > > Thanks for your update.
> > > >
> > > > I have tested your patches using my test case, which is similar to =
the
> > > > hello-fuse [0] example, with an additional change as follows:
> > > >
> > > > @@ -125,6 +125,8 @@ static int hello_read(const char *path, char *b=
uf,
> > > > size_t size, off_t offset,
> > > >         } else
> > > >                 size =3D 0;
> > > >
> > > > +       // TO trigger timeout
> > > > +       sleep(60);
> > > >         return size;
> > > >  }
> > > >
> > > > [0] https://github.com/libfuse/libfuse/blob/master/example/hello.c
> > > >
> > > > However, it triggered a crash with the following setup:
> > > >
> > > > 1. Set FUSE timeout:
> > > >   sysctl -w fs.fuse.default_request_timeout=3D10
> > > >   sysctl -w fs.fuse.max_request_timeout =3D 20
> > > >
> > > > 2. Start FUSE daemon:
> > > >   ./hello /tmp/fuse
> > > >
> > > > 3. Read from FUSE:
> > > >   cat /tmp/fuse/hello
> > > >
> > > > 4. Kill the process within 10 seconds (to avoid the timeout being t=
riggered).
> > > >    Then the crash will be triggered.
> > >
> > > Hi Yafang,
> > >
> > > Thanks for trying this out on your use case!
> > >
> > > How consistently are you able to repro this?
> >
> > It triggers the crash every time.
> >
> > > I tried reproing using
> > > your instructions above but I'm not able to get the crash.
> >
> > Please note that it is the `cat /tmp/fuse/hello` process that was
> > killed, not the fuse daemon.
> > The crash seems to occur when the fuse daemon wakes up after
> > sleep(60). Please ensure that the fuse daemon can be woken up.
> >
>
> I'm still not able to trigger the crash by killing the `cat
> /tmp/fuse/hello` process. This is how I'm repro-ing
>
> 1) Add sleep to test code in
> https://github.com/libfuse/libfuse/blob/master/example/hello.c
> @@ -125,6 +126,9 @@ static int hello_read(const char *path, char *buf,
> size_t size, off_t offset,
>         } else
>                 size =3D 0;
>
> +       sleep(60);
> +       printf("hello_read woke up from sleep\n");
> +
>         return size;
>  }
>
> 2)  Set fuse timeout to 10 seconds
> sysctl -w fs.fuse.default_request_timeout=3D10
>
> 3) Start fuse daemon
> ./example/hello ./tmp/fuse
>
> 4) Read from fuse
> cat /tmp/fuse/hello
>
> 5) Get pid of cat process
> top -b | grep cat
>
> 6) Kill cat process (within 10 seconds)
>  sudo kill -9 <cat-pid>
>
> 7) Wait 60 seconds for fuse's read request to complete
>
> From what it sounds like, this is exactly what you are doing as well?
>
> I added some kernel-side logs and I'm seeing that the read request is
> timing out after ~10 seconds and handled by the timeout handler
> successfully.
>
> On the fuse daemon side, these are the logs I'm seeing from the above rep=
ro:
> ./example/hello /tmp/fuse -f -d
>
> FUSE library version: 3.17.0
> nullpath_ok: 0
> unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
> INIT: 7.40
> flags=3D0x73fffffb
> max_readahead=3D0x00020000
>    INIT: 7.40
>    flags=3D0x4040f039
>    max_readahead=3D0x00020000
>    max_write=3D0x00100000
>    max_background=3D0
>    congestion_threshold=3D0
>    time_gran=3D1
>    unique: 2, success, outsize: 80
> unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 46, pid: 673
> LOOKUP /hello
> getattr[NULL] /hello
>    NODEID: 2
>    unique: 4, success, outsize: 144
> unique: 6, opcode: OPEN (14), nodeid: 2, insize: 48, pid: 673
> open flags: 0x8000 /hello
>    open[0] flags: 0x8000 /hello
>    unique: 6, success, outsize: 32
> unique: 8, opcode: READ (15), nodeid: 2, insize: 80, pid: 673
> read[0] 4096 bytes from 0 flags: 0x8000
> unique: 10, opcode: FLUSH (25), nodeid: 2, insize: 64, pid: 673
>    unique: 10, error: -38 (Function not implemented), outsize: 16
> unique: 11, opcode: INTERRUPT (36), nodeid: 0, insize: 48, pid: 0
> FUSE_INTERRUPT: reply to kernel to disable interrupt
>    unique: 11, error: -38 (Function not implemented), outsize: 16
>
> unique: 12, opcode: RELEASE (18), nodeid: 2, insize: 64, pid: 0
>    unique: 12, success, outsize: 16
>
> hello_read woke up from sleep
>    read[0] 13 bytes from 0
>    unique: 8, success, outsize: 29
>
>
> Are these the debug logs you are seeing from the daemon side as well?
>
> Thanks,
> Joanne
> > >
> > > From the crash logs you provided below, it looks like what's happenin=
g
> > > is that if the process gets killed, the timer isn't getting deleted.

When I looked at this log previously, I thought you were repro-ing by
killing the fuse daemon process, not the cat process. When we kill the
cat process, the timer shouldn't be getting deleted. (if the daemon
itself is killed, the timers get deleted)

> > > I'll look more into what happens in fuse when a process is killed and
> > > get back to you on this.

This is the flow of what is happening on the kernel side (verified by
local printks) -

`cat /tmp/fuse/hello`:
Issues a FUSE_READ background request (via fuse_send_readpages(),
fm->fc->async_read). This request will have a timeout of 10 seconds on
it

The cat process is killed:
This does not clean up the request. The request is still on the fpq
processing list.

Timeout on request expires:
The timeout handler runs and properly cleans up / frees the request.

Fuse daemon wakes from sleep and replies to the request:
In dev_do_write(), the kernel won't be able to find this request
(since it timed out and was removed from the fpq processing list) and
return with -ENOENT

> >
> > Thanks
> >
> > --
> > Regards
> > Yafang

