Return-Path: <linux-fsdevel+bounces-24725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DF7944163
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 04:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CAD11C227F1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 02:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9D13210A;
	Thu,  1 Aug 2024 02:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zurm0Kkx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E91EB4A7
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722480464; cv=none; b=carAfOV5m6abdKywUS+K3XsBjMvheWnl7EzOKNGNvte7QmL4+PrON1mw7GB6xJt32X2Tbbd0MyF6UBGKNJkigCKxe0Whv9qL0tqYY+RtMhqDUZ0oRDKC/VYIckLFzUqoy16aWDDNuW+vOGYVjjBT58ydGIsTavAYTtcBjbgb838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722480464; c=relaxed/simple;
	bh=c57xJFU59VViOh9ckF1GajbCdd6PY/33xlK4iihLZRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cqPExMa1egeFphry7wagKMA0k55j+w5DbtN3e2YTym+bllSg64G+6A4Ykt8pH/Cr6GyrxKGwZ8IGf7mNGSeC2OoDbf18OMis2b/HQpqSghij2Tr/0sexzhM7FDaFi/fmP6mFMmOXDkI+mf4skPIjr3yAN4XMPurTbDURY9Fedqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zurm0Kkx; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so14534186d6.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722480461; x=1723085261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjwUmB2FQPEATsO8j2eZp8i+JJEGouL+AKPVxOQCzXc=;
        b=Zurm0KkxSKEbB44VMuneXkHgCScsAYh3k2N9l+3x5ieGizT6MGViocLMRbEo/Qzhwn
         QcYtWN9wzGCc/9p29whlKR9OOM735HZuALfiJB221jI0lnkE6RXKkAVtcD6j7dCXH/Kd
         Z8JGbNkkA+DvxG/dyEW2DnyPeupPRgFCUCQGNxikAOGaY5D2MKzv5RDLJ9/VBXQzSeaR
         3uEiPDfP0Hb+aqdeMZAueJpln0/RDyQt30Q9aUO4p8amYCtoIP2UOJKehHLMYM0B0da2
         CkCWvJNpPeLDHdkjKmIvoi1n84IQTg+A5YgA7MBvdfBocAHiVe/0Oz38Iyy2DdEjSL6e
         sOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722480461; x=1723085261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjwUmB2FQPEATsO8j2eZp8i+JJEGouL+AKPVxOQCzXc=;
        b=WkcaUWB9aavDoq3XLgRln87+yQ9yHknEiZgWR4Z7zGZijuUjLfnbFTJSV2GnRjLF7k
         Xf3c2vipDuXBi6f5bYXtaAQ0PA7V4tG7Q4nH10XpuQcf5jcOPBQscC/43CS0raKMxuzy
         xBtHYteqKXqG5Y91FDO6yy9ffhHnMfGIx+hB9i14koTglcTduSqUhbi5QQetIN9dzUWY
         /fSOJeuM2U/vTfz5HUX01prW6m0P7c+c1ifaHx0gpo6+ZL15bsJDcirGi5fH3zLrA1nC
         6xx7VMQLvdon/gPfisK1CAWoc/f67mB8mdrlGbYuhC5U4wzLwG9Hvy39T6EeQ9R8XWZi
         s97Q==
X-Forwarded-Encrypted: i=1; AJvYcCXUBwQQ61M//7zw7lzW0xbqQoACYfSRewo8whPGbpdZwUQhEOkAdvvvMphpese16UjgeM6x690Jw11F/+I5p2hGLiAM0O/3lPb9N5My/w==
X-Gm-Message-State: AOJu0YzwT44Lkf72K/vcwy1gwyHIih6f3l+IfNrIpki+Pqofgf+txcon
	k2dgoielohVRnXC3hg8bbu5ektNT9EqvSSTTq+YVdpmziTUOp7KDYYngZZEMKo7M5d1T91wUMiD
	DitZ69vXRuC5ImNDV4Kp2Jd364cM=
X-Google-Smtp-Source: AGHT+IHT5Z56Z+r49qSJxs5gTwd8R5FvqNi6lmilyGT0bUWqX2iUZTEurHRI/gB+YO/vBlOuUluXuFR99tXxiMbaOl4=
X-Received: by 2002:a05:6214:428f:b0:6bb:53aa:46e8 with SMTP id
 6a1803df08f44-6bb8d86f277mr5105256d6.10.1722480461059; Wed, 31 Jul 2024
 19:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com>
 <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
 <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com> <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
In-Reply-To: <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 1 Aug 2024 10:47:04 +0800
Message-ID: <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 2:46=E2=80=AFAM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Wed, Jul 31, 2024 at 10:52=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> >
> > On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gm=
ail.com> wrote:
> > > > >
> > > > > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelkoon=
g@gmail.com> wrote:
> > > > > >
> > > > > > There are situations where fuse servers can become unresponsive=
 or take
> > > > > > too long to reply to a request. Currently there is no upper bou=
nd on
> > > > > > how long a request may take, which may be frustrating to users =
who get
> > > > > > stuck waiting for a request to complete.
> > > > > >
> > > > > > This patchset adds a timeout option for requests and two dynami=
cally
> > > > > > configurable fuse sysctls "default_request_timeout" and "max_re=
quest_timeout"
> > > > > > for controlling/enforcing timeout behavior system-wide.
> > > > > >
> > > > > > Existing fuse servers will not be affected unless they explicit=
ly opt into the
> > > > > > timeout.
> > > > > >
> > > > > > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.161334=
7-1-joannelkoong@gmail.com/
> > > > > > Changes from v1:
> > > > > > - Add timeout for background requests
> > > > > > - Handle resend race condition
> > > > > > - Add sysctls
> > > > > >
> > > > > > Joanne Koong (2):
> > > > > >   fuse: add optional kernel-enforced timeout for requests
> > > > > >   fuse: add default_request_timeout and max_request_timeout sys=
ctls
> > > > > >
> > > > > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > > > > >  fs/fuse/Makefile                        |   2 +-
> > > > > >  fs/fuse/dev.c                           | 187 ++++++++++++++++=
+++++++-
> > > > > >  fs/fuse/fuse_i.h                        |  30 ++++
> > > > > >  fs/fuse/inode.c                         |  24 +++
> > > > > >  fs/fuse/sysctl.c                        |  42 ++++++
> > > > > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > > > > >  create mode 100644 fs/fuse/sysctl.c
> > > > > >
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > > > >
> > > > > Hello Joanne,
> > > > >
> > > > > Thanks for your update.
> > > > >
> > > > > I have tested your patches using my test case, which is similar t=
o the
> > > > > hello-fuse [0] example, with an additional change as follows:
> > > > >
> > > > > @@ -125,6 +125,8 @@ static int hello_read(const char *path, char =
*buf,
> > > > > size_t size, off_t offset,
> > > > >         } else
> > > > >                 size =3D 0;
> > > > >
> > > > > +       // TO trigger timeout
> > > > > +       sleep(60);
> > > > >         return size;
> > > > >  }
> > > > >
> > > > > [0] https://github.com/libfuse/libfuse/blob/master/example/hello.=
c
> > > > >
> > > > > However, it triggered a crash with the following setup:
> > > > >
> > > > > 1. Set FUSE timeout:
> > > > >   sysctl -w fs.fuse.default_request_timeout=3D10
> > > > >   sysctl -w fs.fuse.max_request_timeout =3D 20
> > > > >
> > > > > 2. Start FUSE daemon:
> > > > >   ./hello /tmp/fuse
> > > > >
> > > > > 3. Read from FUSE:
> > > > >   cat /tmp/fuse/hello
> > > > >
> > > > > 4. Kill the process within 10 seconds (to avoid the timeout being=
 triggered).
> > > > >    Then the crash will be triggered.
> > > >
> > > > Hi Yafang,
> > > >
> > > > Thanks for trying this out on your use case!
> > > >
> > > > How consistently are you able to repro this?
> > >
> > > It triggers the crash every time.
> > >
> > > > I tried reproing using
> > > > your instructions above but I'm not able to get the crash.
> > >
> > > Please note that it is the `cat /tmp/fuse/hello` process that was
> > > killed, not the fuse daemon.
> > > The crash seems to occur when the fuse daemon wakes up after
> > > sleep(60). Please ensure that the fuse daemon can be woken up.
> > >
> >
> > I'm still not able to trigger the crash by killing the `cat
> > /tmp/fuse/hello` process. This is how I'm repro-ing
> >
> > 1) Add sleep to test code in
> > https://github.com/libfuse/libfuse/blob/master/example/hello.c
> > @@ -125,6 +126,9 @@ static int hello_read(const char *path, char *buf,
> > size_t size, off_t offset,
> >         } else
> >                 size =3D 0;
> >
> > +       sleep(60);
> > +       printf("hello_read woke up from sleep\n");
> > +
> >         return size;
> >  }
> >
> > 2)  Set fuse timeout to 10 seconds
> > sysctl -w fs.fuse.default_request_timeout=3D10
> >
> > 3) Start fuse daemon
> > ./example/hello ./tmp/fuse
> >
> > 4) Read from fuse
> > cat /tmp/fuse/hello
> >
> > 5) Get pid of cat process
> > top -b | grep cat
> >
> > 6) Kill cat process (within 10 seconds)
> >  sudo kill -9 <cat-pid>
> >
> > 7) Wait 60 seconds for fuse's read request to complete
> >
> > From what it sounds like, this is exactly what you are doing as well?
> >
> > I added some kernel-side logs and I'm seeing that the read request is
> > timing out after ~10 seconds and handled by the timeout handler
> > successfully.
> >
> > On the fuse daemon side, these are the logs I'm seeing from the above r=
epro:
> > ./example/hello /tmp/fuse -f -d
> >
> > FUSE library version: 3.17.0
> > nullpath_ok: 0
> > unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
> > INIT: 7.40
> > flags=3D0x73fffffb
> > max_readahead=3D0x00020000
> >    INIT: 7.40
> >    flags=3D0x4040f039
> >    max_readahead=3D0x00020000
> >    max_write=3D0x00100000
> >    max_background=3D0
> >    congestion_threshold=3D0
> >    time_gran=3D1
> >    unique: 2, success, outsize: 80
> > unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 46, pid: 673
> > LOOKUP /hello
> > getattr[NULL] /hello
> >    NODEID: 2
> >    unique: 4, success, outsize: 144
> > unique: 6, opcode: OPEN (14), nodeid: 2, insize: 48, pid: 673
> > open flags: 0x8000 /hello
> >    open[0] flags: 0x8000 /hello
> >    unique: 6, success, outsize: 32
> > unique: 8, opcode: READ (15), nodeid: 2, insize: 80, pid: 673
> > read[0] 4096 bytes from 0 flags: 0x8000
> > unique: 10, opcode: FLUSH (25), nodeid: 2, insize: 64, pid: 673
> >    unique: 10, error: -38 (Function not implemented), outsize: 16
> > unique: 11, opcode: INTERRUPT (36), nodeid: 0, insize: 48, pid: 0
> > FUSE_INTERRUPT: reply to kernel to disable interrupt
> >    unique: 11, error: -38 (Function not implemented), outsize: 16
> >
> > unique: 12, opcode: RELEASE (18), nodeid: 2, insize: 64, pid: 0
> >    unique: 12, success, outsize: 16
> >
> > hello_read woke up from sleep
> >    read[0] 13 bytes from 0
> >    unique: 8, success, outsize: 29
> >
> >
> > Are these the debug logs you are seeing from the daemon side as well?
> >
> > Thanks,
> > Joanne
> > > >
> > > > From the crash logs you provided below, it looks like what's happen=
ing
> > > > is that if the process gets killed, the timer isn't getting deleted=
.
>
> When I looked at this log previously, I thought you were repro-ing by
> killing the fuse daemon process, not the cat process. When we kill the
> cat process, the timer shouldn't be getting deleted. (if the daemon
> itself is killed, the timers get deleted)
>
> > > > I'll look more into what happens in fuse when a process is killed a=
nd
> > > > get back to you on this.
>
> This is the flow of what is happening on the kernel side (verified by
> local printks) -
>
> `cat /tmp/fuse/hello`:
> Issues a FUSE_READ background request (via fuse_send_readpages(),
> fm->fc->async_read). This request will have a timeout of 10 seconds on
> it
>
> The cat process is killed:
> This does not clean up the request. The request is still on the fpq
> processing list.
>
> Timeout on request expires:
> The timeout handler runs and properly cleans up / frees the request.
>
> Fuse daemon wakes from sleep and replies to the request:
> In dev_do_write(), the kernel won't be able to find this request
> (since it timed out and was removed from the fpq processing list) and
> return with -ENOENT

Thank you for your explanation.
I will verify if there are any issues with my test environment.

--
Regards
Yafang

