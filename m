Return-Path: <linux-fsdevel+bounces-25137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A5D949580
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6CA281A95
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3629936124;
	Tue,  6 Aug 2024 16:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jv4Ed6wq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26418D635
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722961417; cv=none; b=SwIQ/1WdZoWu3VEWZk2TEWIAvWl4hK6VvomBOd9lN141Ia5FArUlacrgHaJ2adsNCPYZwuBxwAYH6dALUYrX8p9in8BNQ6PModFOYvzmXhC2rfGR7CnI2D50xrIWOlJRtbvjjhopNj/JILyirneHmj0MjIsi0m0LQTceggm5s/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722961417; c=relaxed/simple;
	bh=HOpg/P1t4YWhO45M0UsNI/9As2Kuhp494esvOLxnuT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKLpYaIp4shioig0GqdSjykc/uRLvSRnLEqXm2by9FK60kFQhv1R3OQVIP2cSvyJj3fI73StSK2DfHezXUmVuumujvZ0YP0atkSXbC30C8h6SCMiKaBxtOKBujJX318edDKcDhNRPjAZbouwNBu4i0WiQ4jYJNXn2lukpiiQIwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jv4Ed6wq; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-450059a25b9so192281cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722961414; x=1723566214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnCdpy/yEdub6iTC/knCXK75ee9M2ITTjnXwIXbKat8=;
        b=jv4Ed6wq2jx7X11t8CyDm2Vuut72FLMwgsQD/zmtc8S9iyF4LqtecoAhiiffMdpi/K
         P2IPG3BExaxkI7vd006TNMgwu5q9+myckHya12C3krskrbV9XD+1ljAQHdeOmq8U3tNV
         VRIok04cUqGTzlCXea2KqAR7eEa0+AgDplKO3gV+jDr5a/43OOih7ZVUPnRlb+Sj6Ke3
         +kLeqHTxYD8kpaefM7ftXl4/szdvBGcWwkF5SdLtbdmnbS2+OGg8qX2pkeyOYCr0HuyW
         TBhK8V7HHoOVQrmrEv+dZmrcIBQRPC1/2Z+VVX8LvLKbptvu4KooxrZMOdYqYORWjCub
         Ycuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722961414; x=1723566214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnCdpy/yEdub6iTC/knCXK75ee9M2ITTjnXwIXbKat8=;
        b=ort+hlbDMny9qx9rG4VQwFMm3pvX8wvAe7YiAhd/Tv96Lz3i87a4QaBFwsR6HYJqQ1
         qb3s8l+suxBUXKOngDPTMz/jMICKMmFLZYcQ+nSIrybIsGRTsTsHuNB+v1Ba/ytBicb5
         Oz1Ty/5bbnc4I8OsBhOev5BAOrj+jItRLggELv6iHWLrAQzhoGVvlxIdrH93Sd+PWQsr
         oFz75ioob7x3RZsNW8+Gl3aBYEOpsU5PlRsQetx2Ih8JsBLXCsSwa6NGqkK2ejfO9mCG
         nEMBJI2XN/xJLf2DQsyK2RV7cdZ4NHr6F2ghT7XA18BWvAQ+ARWzSK86ejr9rTVm5Iq8
         8mZw==
X-Forwarded-Encrypted: i=1; AJvYcCXYaVKKqnmhiNqz7IHuU7Z+HYaz88vTYw6JeE39L1L8W2n7hDVqH57figEIdTHe7ezGzsn8SxNNIVASU1rPUAZUETCMd/fmzRLBMXI2Vg==
X-Gm-Message-State: AOJu0YyqENQT0xP7H5M4gU4NaerMzjce9RtS/CTbEzemhSFozUvRms+/
	vzIE/RN5SRJRlnonni49bNjxGNmASFvakviWp8CJbNx/4wOhPHonxqF0PSez0cK9gghtO6POeux
	lsW2w7o3l0a/XenVVyF83s+q1lqA=
X-Google-Smtp-Source: AGHT+IEtPXi9Mvw0052fLv/RvTfTgn1pYI2QKfYgZ2tT5WDgSBuuuoK+5cDaoABPhcmgwXxXSg4ZsnfX+XBoNt4BN4Q=
X-Received: by 2002:a05:622a:5cd:b0:44f:dc79:afd6 with SMTP id
 d75a77b69052e-45184550deemr306213871cf.17.1722961413603; Tue, 06 Aug 2024
 09:23:33 -0700 (PDT)
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
 <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
 <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com>
 <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
 <CAJnrk1ZMYj3uheexfb3gG+pH6P_QBrmW-NPDeedWHGXhCo7u_g@mail.gmail.com>
 <CALOAHbA3MRp7X=A52HEZq6A-c2Qi=zZS8dinALGcgsisJ6Ck2g@mail.gmail.com> <CAJnrk1ZRBuEtL65m2e1rwU9wJn3FTLCiJctv_T-fKAQaAbwLFQ@mail.gmail.com>
In-Reply-To: <CAJnrk1ZRBuEtL65m2e1rwU9wJn3FTLCiJctv_T-fKAQaAbwLFQ@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 6 Aug 2024 09:23:22 -0700
Message-ID: <CAJnrk1YL8zvTRESyf_nXvHwHBt-1HLSSpO7s=Ys7ZF28g5YQeA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 10:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Sun, Aug 4, 2024 at 12:48=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Sat, Aug 3, 2024 at 3:05=E2=80=AFAM Joanne Koong <joannelkoong@gmail=
.com> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 7:47=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Thu, Aug 1, 2024 at 2:46=E2=80=AFAM Joanne Koong <joannelkoong@g=
mail.com> wrote:
> > > > >
> > > > > On Wed, Jul 31, 2024 at 10:52=E2=80=AFAM Joanne Koong <joannelkoo=
ng@gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao=
@gmail.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannel=
koong@gmail.com> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar=
.shao@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joa=
nnelkoong@gmail.com> wrote:
> > > > > > > > > >
> > > > > > > > > > There are situations where fuse servers can become unre=
sponsive or take
> > > > > > > > > > too long to reply to a request. Currently there is no u=
pper bound on
> > > > > > > > > > how long a request may take, which may be frustrating t=
o users who get
> > > > > > > > > > stuck waiting for a request to complete.
> > > > > > > > > >
> > > > > > > > > > This patchset adds a timeout option for requests and tw=
o dynamically
> > > > > > > > > > configurable fuse sysctls "default_request_timeout" and=
 "max_request_timeout"
> > > > > > > > > > for controlling/enforcing timeout behavior system-wide.
> > > > > > > > > >
> > > > > > > > > > Existing fuse servers will not be affected unless they =
explicitly opt into the
> > > > > > > > > > timeout.
> > > > > > > > > >
> > > > > > > > > > v1: https://lore.kernel.org/linux-fsdevel/2024071721345=
8.1613347-1-joannelkoong@gmail.com/
> > > > > > > > > > Changes from v1:
> > > > > > > > > > - Add timeout for background requests
> > > > > > > > > > - Handle resend race condition
> > > > > > > > > > - Add sysctls
> > > > > > > > > >
> > > > > > > > > > Joanne Koong (2):
> > > > > > > > > >   fuse: add optional kernel-enforced timeout for reques=
ts
> > > > > > > > > >   fuse: add default_request_timeout and max_request_tim=
eout sysctls
> > > > > > > > > >
> > > > > > > > > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > > > > > > > > >  fs/fuse/Makefile                        |   2 +-
> > > > > > > > > >  fs/fuse/dev.c                           | 187 ++++++++=
+++++++++++++++-
> > > > > > > > > >  fs/fuse/fuse_i.h                        |  30 ++++
> > > > > > > > > >  fs/fuse/inode.c                         |  24 +++
> > > > > > > > > >  fs/fuse/sysctl.c                        |  42 ++++++
> > > > > > > > > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > > > > > > > > >  create mode 100644 fs/fuse/sysctl.c
> > > > > > > > > >
> > > > > > > > > > --
> > > > > > > > > > 2.43.0
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Hello Joanne,
> > > > > > > > >
> > > > > > > > > Thanks for your update.
> > > > > > > > >
> > > > > > > > > I have tested your patches using my test case, which is s=
imilar to the
> > > > > > > > > hello-fuse [0] example, with an additional change as foll=
ows:
> > > > > > > > >
> > > > > > > > > @@ -125,6 +125,8 @@ static int hello_read(const char *pat=
h, char *buf,
> > > > > > > > > size_t size, off_t offset,
> > > > > > > > >         } else
> > > > > > > > >                 size =3D 0;
> > > > > > > > >
> > > > > > > > > +       // TO trigger timeout
> > > > > > > > > +       sleep(60);
> > > > > > > > >         return size;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > [0] https://github.com/libfuse/libfuse/blob/master/exampl=
e/hello.c
> > > > > > > > >
> > > > > > > > > However, it triggered a crash with the following setup:
> > > > > > > > >
> > > > > > > > > 1. Set FUSE timeout:
> > > > > > > > >   sysctl -w fs.fuse.default_request_timeout=3D10
> > > > > > > > >   sysctl -w fs.fuse.max_request_timeout =3D 20
> > > > > > > > >
> > > > > > > > > 2. Start FUSE daemon:
> > > > > > > > >   ./hello /tmp/fuse
> > > > > > > > >
> > > > > > > > > 3. Read from FUSE:
> > > > > > > > >   cat /tmp/fuse/hello
> > > > > > > > >
> > > > > > > > > 4. Kill the process within 10 seconds (to avoid the timeo=
ut being triggered).
> > > > > > > > >    Then the crash will be triggered.
> > > > > > > >
> > > > > > > > Hi Yafang,
> > > > > > > >
> > > > > > > > Thanks for trying this out on your use case!
> > > > > > > >
> > > > > > > > How consistently are you able to repro this?
> > > > > > >
> > > > > > > It triggers the crash every time.
> > > > > > >
> > > > > > > > I tried reproing using
> > > > > > > > your instructions above but I'm not able to get the crash.
> > > > > > >
> > > > > > > Please note that it is the `cat /tmp/fuse/hello` process that=
 was
> > > > > > > killed, not the fuse daemon.
> > > > > > > The crash seems to occur when the fuse daemon wakes up after
> > > > > > > sleep(60). Please ensure that the fuse daemon can be woken up=
.
> > > > > > >
> > > > > >
> > > > > > I'm still not able to trigger the crash by killing the `cat
> > > > > > /tmp/fuse/hello` process. This is how I'm repro-ing
> > > > > >
> > > > > > 1) Add sleep to test code in
> > > > > > https://github.com/libfuse/libfuse/blob/master/example/hello.c
> > > > > > @@ -125,6 +126,9 @@ static int hello_read(const char *path, cha=
r *buf,
> > > > > > size_t size, off_t offset,
> > > > > >         } else
> > > > > >                 size =3D 0;
> > > > > >
> > > > > > +       sleep(60);
> > > > > > +       printf("hello_read woke up from sleep\n");
> > > > > > +
> > > > > >         return size;
> > > > > >  }
> > > > > >
> > > > > > 2)  Set fuse timeout to 10 seconds
> > > > > > sysctl -w fs.fuse.default_request_timeout=3D10
> > > > > >
> > > > > > 3) Start fuse daemon
> > > > > > ./example/hello ./tmp/fuse
> > > > > >
> > > > > > 4) Read from fuse
> > > > > > cat /tmp/fuse/hello
> > > > > >
> > > > > > 5) Get pid of cat process
> > > > > > top -b | grep cat
> > > > > >
> > > > > > 6) Kill cat process (within 10 seconds)
> > > > > >  sudo kill -9 <cat-pid>
> > > > > >
> > > > > > 7) Wait 60 seconds for fuse's read request to complete
> > > > > >
> > > > > > From what it sounds like, this is exactly what you are doing as=
 well?
> > > > > >
> > > > > > I added some kernel-side logs and I'm seeing that the read requ=
est is
> > > > > > timing out after ~10 seconds and handled by the timeout handler
> > > > > > successfully.
> > > > > >
> > > > > > On the fuse daemon side, these are the logs I'm seeing from the=
 above repro:
> > > > > > ./example/hello /tmp/fuse -f -d
> > > > > >
> > > > > > FUSE library version: 3.17.0
> > > > > > nullpath_ok: 0
> > > > > > unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
> > > > > > INIT: 7.40
> > > > > > flags=3D0x73fffffb
> > > > > > max_readahead=3D0x00020000
> > > > > >    INIT: 7.40
> > > > > >    flags=3D0x4040f039
> > > > > >    max_readahead=3D0x00020000
> > > > > >    max_write=3D0x00100000
> > > > > >    max_background=3D0
> > > > > >    congestion_threshold=3D0
> > > > > >    time_gran=3D1
> > > > > >    unique: 2, success, outsize: 80
> > > > > > unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 46, pid: 673
> > > > > > LOOKUP /hello
> > > > > > getattr[NULL] /hello
> > > > > >    NODEID: 2
> > > > > >    unique: 4, success, outsize: 144
> > > > > > unique: 6, opcode: OPEN (14), nodeid: 2, insize: 48, pid: 673
> > > > > > open flags: 0x8000 /hello
> > > > > >    open[0] flags: 0x8000 /hello
> > > > > >    unique: 6, success, outsize: 32
> > > > > > unique: 8, opcode: READ (15), nodeid: 2, insize: 80, pid: 673
> > > > > > read[0] 4096 bytes from 0 flags: 0x8000
> > > > > > unique: 10, opcode: FLUSH (25), nodeid: 2, insize: 64, pid: 673
> > > > > >    unique: 10, error: -38 (Function not implemented), outsize: =
16
> > > > > > unique: 11, opcode: INTERRUPT (36), nodeid: 0, insize: 48, pid:=
 0
> > > > > > FUSE_INTERRUPT: reply to kernel to disable interrupt
> > > > > >    unique: 11, error: -38 (Function not implemented), outsize: =
16
> > > > > >
> > > > > > unique: 12, opcode: RELEASE (18), nodeid: 2, insize: 64, pid: 0
> > > > > >    unique: 12, success, outsize: 16
> > > > > >
> > > > > > hello_read woke up from sleep
> > > > > >    read[0] 13 bytes from 0
> > > > > >    unique: 8, success, outsize: 29
> > > > > >
> > > > > >
> > > > > > Are these the debug logs you are seeing from the daemon side as=
 well?
> > > > > >
> > > > > > Thanks,
> > > > > > Joanne
> > > > > > > >
> > > > > > > > From the crash logs you provided below, it looks like what'=
s happening
> > > > > > > > is that if the process gets killed, the timer isn't getting=
 deleted.
> > > > >
> > > > > When I looked at this log previously, I thought you were repro-in=
g by
> > > > > killing the fuse daemon process, not the cat process. When we kil=
l the
> > > > > cat process, the timer shouldn't be getting deleted. (if the daem=
on
> > > > > itself is killed, the timers get deleted)
> > > > >
> > > > > > > > I'll look more into what happens in fuse when a process is =
killed and
> > > > > > > > get back to you on this.
> > > > >
> > > > > This is the flow of what is happening on the kernel side (verifie=
d by
> > > > > local printks) -
> > > > >
> > > > > `cat /tmp/fuse/hello`:
> > > > > Issues a FUSE_READ background request (via fuse_send_readpages(),
> > > > > fm->fc->async_read). This request will have a timeout of 10 secon=
ds on
> > > > > it
> > > > >
> > > > > The cat process is killed:
> > > > > This does not clean up the request. The request is still on the f=
pq
> > > > > processing list.
> > > > >
> > > > > Timeout on request expires:
> > > > > The timeout handler runs and properly cleans up / frees the reque=
st.
> > > > >
> > > > > Fuse daemon wakes from sleep and replies to the request:
> > > > > In dev_do_write(), the kernel won't be able to find this request
> > > > > (since it timed out and was removed from the fpq processing list)=
 and
> > > > > return with -ENOENT
> > > >
> > > > Thank you for your explanation.
> > > > I will verify if there are any issues with my test environment.
> > > >
> > > Hi Yafang,
> > >
> > > Would you mind adding these printks to your kernel when you run the
> > > repro and pasting what they show?
> > >
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -287,6 +287,9 @@ static void do_fuse_request_end(struct fuse_req
> > > *req, bool from_timer_callback)
> > >         struct fuse_conn *fc =3D fm->fc;
> > >         struct fuse_iqueue *fiq =3D &fc->iq;
> > >
> > > +       printk("do_fuse_request_end: req=3D%p, from_timer=3D%d,
> > > req->timer.func=3D%d\n",
> > > +              req, from_timer_callback, req->timer.function !=3D NUL=
L);
> > > +
> > >         if (from_timer_callback)
> > >                 req->out.h.error =3D -ETIME;
> > >
> > > @@ -415,6 +418,8 @@ static void fuse_request_timeout(struct timer_lis=
t *timer)
> > >  {
> > >         struct fuse_req *req =3D container_of(timer, struct fuse_req,=
 timer);
> > >
> > > +       printk("fuse_request_timeout: req=3D%p\n", req);
> > > +
> > >         /*
> > >          * Request reply is being finished by the kernel right now.
> > >          * No need to time out the request.
> > > @@ -612,6 +617,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm=
,
> > > struct fuse_args *args)
> > >
> > >         if (!args->noreply)
> > >                 __set_bit(FR_ISREPLY, &req->flags);
> > > +       printk("fuse_simple_request: req=3D%p, op=3D%u\n", req, args-=
>opcode);
> > >         __fuse_request_send(req);
> > >         ret =3D req->out.h.error;
> > >         if (!ret && args->out_argvar) {
> > > @@ -673,6 +679,7 @@ int fuse_simple_background(struct fuse_mount *fm,
> > > struct fuse_args *args,
> > >
> > >         fuse_args_to_req(req, args);
> > >
> > > +       printk("fuse_background_request: req=3D%p, op=3D%u\n", req, a=
rgs->opcode);
> > >         if (!fuse_request_queue_background(req)) {
> > >                 fuse_put_request(req);
> > >
> > >
> > > When I run it on my side, I see
> > >
> > > [   68.117740] fuse_background_request: req=3D00000000874e2f14, op=3D=
26
> > > [   68.131440] do_fuse_request_end: req=3D00000000874e2f14,
> > > from_timer=3D0, req->timer.func=3D1
> > > [   71.558538] fuse_simple_request: req=3D00000000cf643ace, op=3D1
> > > [   71.559651] do_fuse_request_end: req=3D00000000cf643ace,
> > > from_timer=3D0, req->timer.func=3D1
> > > [   71.561044] fuse_simple_request: req=3D00000000f2c001f0, op=3D14
> > > [   71.562524] do_fuse_request_end: req=3D00000000f2c001f0,
> > > from_timer=3D0, req->timer.func=3D1
> > > [   71.563820] fuse_background_request: req=3D00000000584f2cc3, op=3D=
15
> > > [   78.580035] fuse_simple_request: req=3D00000000ecbee970, op=3D25
> > > [   78.582614] do_fuse_request_end: req=3D00000000ecbee970,
> > > from_timer=3D0, req->timer.func=3D1
> > > [   81.624722] fuse_request_timeout: req=3D00000000584f2cc3
> > > [   81.625443] do_fuse_request_end: req=3D00000000584f2cc3,
> > > from_timer=3D1, req->timer.func=3D1
> > > [   81.626377] fuse_background_request: req=3D00000000b2d792ed, op=3D=
18
> > > [   81.627623] do_fuse_request_end: req=3D00000000b2d792ed,
> > > from_timer=3D0, req->timer.func=3D1
> > >
> > > I'm seeing only one timer get called, on the read request (opcode=3D1=
5),
> > > and I'm not seeing do_fuse_request_end having been called on that
> > > request before the timer is invoked.
> > > I'm curious to compare this against the logs on your end.
> >
> > The log on my side is as follows,
> Thank you Yafang. These logs are very helpful.
>
> >
> > [  283.329421] fuse_background_request: req=3D000000002b4f82d4, op=3D26
> > [  283.330043] do_fuse_request_end: req=3D000000002b4f82d4,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.889844] fuse_simple_request: req=3D00000000865e85bf, op=3D3
> > [  287.889914] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.889933] fuse_simple_request: req=3D00000000865e85bf, op=3D22
> > [  287.889994] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.890096] fuse_simple_request: req=3D00000000865e85bf, op=3D27
> > [  287.890130] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.890142] fuse_simple_request: req=3D00000000865e85bf, op=3D28
> > [  287.890167] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.890178] fuse_simple_request: req=3D00000000865e85bf, op=3D1
> > [  287.890191] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.890209] fuse_simple_request: req=3D00000000865e85bf, op=3D28
> > [  287.890216] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  287.890222] fuse_background_request: req=3D00000000865e85bf, op=3D29
> > [  287.890230] do_fuse_request_end: req=3D00000000865e85bf,
> > from_timer=3D0, req->timer.func=3D0
> > [  312.311752] fuse_background_request: req=3D00000000a8da8b44, op=3D26
> > [  312.312249] do_fuse_request_end: req=3D00000000a8da8b44,
> > from_timer=3D0, req->timer.func=3D1
> > [  317.368786] fuse_simple_request: req=3D00000000bc4817dd, op=3D1
> > [  317.368871] do_fuse_request_end: req=3D00000000bc4817dd,
> > from_timer=3D0, req->timer.func=3D1
> > [  317.368910] fuse_simple_request: req=3D00000000bc4817dd, op=3D14
> > [  317.368942] do_fuse_request_end: req=3D00000000bc4817dd,
> > from_timer=3D0, req->timer.func=3D1
> > [  317.368967] fuse_simple_request: req=3D00000000bc4817dd, op=3D15
> > [  327.855189] fuse_request_timeout: req=3D00000000bc4817dd
> > [  327.855195] do_fuse_request_end: req=3D00000000bc4817dd,
> > from_timer=3D1, req->timer.func=3D1
> > [  327.855218] fuse_simple_request: req=3D00000000c34cc363, op=3D15
> > [  327.855328] fuse_simple_request: req=3D00000000c34cc363, op=3D25
> > [  327.855401] do_fuse_request_end: req=3D00000000c34cc363,
> > from_timer=3D0, req->timer.func=3D1
> > [  327.855496] fuse_background_request: req=3D00000000c34cc363, op=3D18
> > [  327.855508] do_fuse_request_end: req=3D00000000c34cc363,
> > from_timer=3D0, req->timer.func=3D1
> > [  338.095136] Oops: general protection fault, probably for
> > non-canonical address 0xdead00000000012a: 0000 [#1] PREEMPT SMP NOPTI
> > [  338.096415] CPU: 58 PID: 0 Comm: swapper/58 Kdump: loaded Not
> > tainted 6.10.0+ #8
> > [  338.098219] RIP: 0010:__run_timers+0x27e/0x360
> > [  338.098686] Code: 07 48 c7 43 08 00 00 00 00 48 85 c0 74 78 4d 8b
> > 2f 4c 89 6b 08 0f 1f 44 00 00 49 8b 45 00 49 8b 55 08 48 89 02 48 85
> > c0 74 04 <48> 89 50 08 4d 8b 65 18 49 c7 45 08 00 00 00 00 48 b8 22 01
> > 00 00
> > [  338.100381] RSP: 0018:ffffb4ef808bced8 EFLAGS: 00010086
> > [  338.100907] RAX: dead000000000122 RBX: ffff9827ffca13c0 RCX: 0000000=
000000001
> > [  338.101623] RDX: ffffb4ef808bcef8 RSI: 0000000000000000 RDI: ffff982=
7ffca13e8
> > [  338.102333] RBP: ffffb4ef808bcf70 R08: 000000000000008b R09: ffff982=
7ffca1430
> > [  338.103020] R10: ffffffff93e060c0 R11: 0000000000000089 R12: 0000000=
000000001
> > [  338.103726] R13: ffff97e9dc06a0a0 R14: 0000000100009200 R15: ffffb4e=
f808bcef8
> > [  338.104439] FS:  0000000000000000(0000) GS:ffff9827ffc80000(0000)
> > knlGS:0000000000000000
> > [  338.105229] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  338.105795] CR2: 000000c002f99340 CR3: 0000000148254001 CR4: 0000000=
000370ef0
> > [  338.106502] Call Trace:
> > [  338.106836]  <IRQ>
> > [  338.107175]  ? show_regs+0x69/0x80
> > [  338.107603]  ? die_addr+0x38/0x90
> > [  338.108005]  ? exc_general_protection+0x236/0x490
> > [  338.108557]  ? asm_exc_general_protection+0x27/0x30
> > [  338.109095]  ? __run_timers+0x27e/0x360
> > [  338.109563]  ? __run_timers+0x1b4/0x360
> > [  338.110009]  ? kvm_sched_clock_read+0x11/0x20
> > [  338.110528]  ? sched_clock_noinstr+0x9/0x10
> > [  338.111002]  ? sched_clock+0x10/0x30
> > [  338.111447]  ? sched_clock_cpu+0x10/0x190
> > [  338.111914]  run_timer_softirq+0x3a/0x60
> > [  338.112406]  handle_softirqs+0x118/0x350
> > [  338.112859]  irq_exit_rcu+0x60/0x80
> > [  338.113295]  sysvec_apic_timer_interrupt+0x7f/0x90
> > [  338.113823]  </IRQ>
> > [  338.114147]  <TASK>
> > [  338.114447]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> > [  338.115002] RIP: 0010:default_idle+0xb/0x20
> > [  338.115498] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90
> > 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d b3 51 33
> > 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > 00 90
> > [  338.117337] RSP: 0018:ffffb4ef8028fe18 EFLAGS: 00000246
> > [  338.117894] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0001b48=
ebb3a1032
> > [  338.118673] RDX: 0000000000000001 RSI: ffffffff9412e060 RDI: ffff982=
7ffcbc8e0
> > [  338.119415] RBP: ffffb4ef8028fe20 R08: 0000004eb7fb01b4 R09: 0000000=
000000001
> > [  338.120151] R10: ffffffff93e56080 R11: 0000000000000001 R12: 0000000=
000000001
> > [  338.120872] R13: ffffffff9412e060 R14: ffffffff9412e0e0 R15: 0000000=
000000001
> > [  338.121615]  ? ct_kernel_exit.constprop.0+0x79/0x90
> > [  338.122171]  ? arch_cpu_idle+0x9/0x10
> > [  338.122602]  default_enter_idle+0x22/0x2f
> > [  338.123064]  cpuidle_enter_state+0x88/0x430
> > [  338.123556]  cpuidle_enter+0x34/0x50
> > [  338.123978]  call_cpuidle+0x22/0x50
> > [  338.124449]  cpuidle_idle_call+0xd2/0x120
> > [  338.124909]  do_idle+0x77/0xd0
> > [  338.125313]  cpu_startup_entry+0x2c/0x30
> > [  338.125763]  start_secondary+0x117/0x140
> > [  338.126240]  common_startup_64+0x13e/0x141
> > [  338.126711]  </TASK>
> >
> > In addition to the hello-fuse, there is another FUSE daemon, lxcfs,
> > running on my test server. After disabling lxcfs, the system no longer
> > panics, but there are still error logs:
> >
> > [  285.804534] fuse_background_request: req=3D0000000063502a93, op=3D26
> > [  285.805041] do_fuse_request_end: req=3D0000000063502a93,
> > from_timer=3D0, req->timer.func=3D1
> > [  290.967412] fuse_simple_request: req=3D000000003f362e4b, op=3D1
> > [  290.967480] do_fuse_request_end: req=3D000000003f362e4b,
> > from_timer=3D0, req->timer.func=3D1
> > [  290.967517] fuse_simple_request: req=3D000000003f362e4b, op=3D14
> > [  290.967585] do_fuse_request_end: req=3D000000003f362e4b,
> > from_timer=3D0, req->timer.func=3D1
> > [  290.967655] fuse_simple_request: req=3D000000003f362e4b, op=3D15
> > [  300.996023] fuse_request_timeout: req=3D000000003f362e4b
> > [  300.996030] do_fuse_request_end: req=3D000000003f362e4b,
> > from_timer=3D1, req->timer.func=3D1
> > [  300.996066] fuse_simple_request: req=3D00000000b4182f02, op=3D15
> > [  300.996180] fuse_simple_request: req=3D000000003f362e4b, op=3D25
> > [  300.996185] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  300.996980] BUG: KFENCE: use-after-free write in enqueue_timer+0x24/=
0xb0
> >
> > [  300.997788] Use-after-free write at 0x0000000022312cb7 (in kfence-#1=
56):
> > [  300.998476]  enqueue_timer+0x24/0xb0
> > [  300.998479]  __mod_timer+0x23b/0x360
> > [  300.998481]  add_timer+0x20/0x30
> > [  300.998483]  fuse_simple_request+0x1bc/0x2f0 [fuse]
> > [  300.998506]  fuse_flush+0x1ac/0x1f0 [fuse]
> > [  300.998511]  filp_flush+0x39/0x90
> > [  300.998517]  filp_close+0x15/0x30
> > [  300.998519]  put_files_struct+0x77/0xe0
> > [  300.998522]  exit_files+0x47/0x60
> > [  300.998524]  do_exit+0x262/0x480
> > [  300.998528]  do_group_exit+0x34/0x90
> > [  300.998531]  get_signal+0x92f/0x980
> > [  300.998534]  arch_do_signal_or_restart+0x2a/0x100
> > [  300.998537]  syscall_exit_to_user_mode+0xe3/0x1a0
> > [  300.998541]  do_syscall_64+0x71/0x170
> > [  300.998545]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > [  300.998759] kfence-#156: 0x00000000b4182f02-0x0000000084fc5c46,
> > size=3D200, cache=3Dip4-frags
> >
> > [  300.998761] allocated by task 15064 on cpu 26 at 300.996061s:
> > [  300.998766]  fuse_request_alloc+0x21/0xb0 [fuse]
> > [  300.998771]  fuse_get_req+0xde/0x270 [fuse]
> > [  300.998775]  fuse_simple_request+0x33/0x2f0 [fuse]
> > [  300.998779]  fuse_do_readpage+0x15e/0x200 [fuse]
> > [  300.998783]  fuse_read_folio+0x29/0x60 [fuse]
> > [  300.998787]  filemap_read_folio+0x3b/0xe0
> > [  300.998791]  filemap_update_page+0x236/0x2d0
> > [  300.998792]  filemap_get_pages+0x225/0x390
> > [  300.998794]  filemap_read+0xed/0x3a0
> > [  300.998796]  generic_file_read_iter+0xb8/0x100
> > [  300.998798]  fuse_file_read_iter+0xd8/0x150 [fuse]
> > [  300.998804]  vfs_read+0x25e/0x340
> > [  300.998806]  ksys_read+0x67/0xf0
> > [  300.998808]  __x64_sys_read+0x19/0x20
> > [  300.998810]  x64_sys_call+0x1709/0x20b0
> > [  300.998813]  do_syscall_64+0x65/0x170
> > [  300.998815]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> >
> > [  300.998817] freed by task 15064 on cpu 26 at 300.996084s:
> > [  300.998822]  fuse_put_request+0x89/0xf0 [fuse]
> > [  300.998826]  fuse_simple_request+0xe1/0x2f0 [fuse]
> > [  300.998830]  fuse_do_readpage+0x15e/0x200 [fuse]
> > [  300.998835]  fuse_read_folio+0x29/0x60 [fuse]
> > [  300.998839]  filemap_read_folio+0x3b/0xe0
> > [  300.998840]  filemap_update_page+0x236/0x2d0
> > [  300.998842]  filemap_get_pages+0x225/0x390
> > [  300.998844]  filemap_read+0xed/0x3a0
> > [  300.998846]  generic_file_read_iter+0xb8/0x100
> > [  300.998848]  fuse_file_read_iter+0xd8/0x150 [fuse]
> > [  300.998852]  vfs_read+0x25e/0x340
> > [  300.998854]  ksys_read+0x67/0xf0
> > [  300.998856]  __x64_sys_read+0x19/0x20
> > [  300.998857]  x64_sys_call+0x1709/0x20b0
> > [  300.998859]  do_syscall_64+0x65/0x170
> > [  300.998860]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> This is very interesting. These logs (and the ones above with the
> lxcfs server running concurrently) are showing that the read request
> was freed but not through the do_fuse_request_end path. It's weird
> that fuse_simple_request reached fuse_put_request without
> do_fuse_request_end having been called (which is the only place where
> FR_FINISHED gets set and wakes up the wait events in
> request_wait_answer).
>
> I'll take a deeper look tomorrow and try to make more sense of it.

Finally realized what's happening!
When we kill the cat program, if the request hasn't been sent out to
userspace yet when the fatal signal interrupts the
wait_event_interruptible and wait_event_killable in
request_wait_answer(), this will clean up the request manually (not
through the fuse_request_end() path), which doesn't delete the timer.

I'll fix this for v3.

Thank you for surfacing this and it would be much appreciated if you
could test out v3 when it's submitted to make sure.

Thanks!
Joanne

>
> >
> > [  300.999115] CPU: 26 PID: 15064 Comm: cat Kdump: loaded Not tainted 6=
.10.0+ #8
> > [  301.000803] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [  301.001695] do_fuse_request_end: req=3D000000003f362e4b,
> > from_timer=3D0, req->timer.func=3D1
> > [  301.001723] fuse_background_request: req=3D000000003f362e4b, op=3D18
> > [  301.001767] do_fuse_request_end: req=3D000000003f362e4b,
> > from_timer=3D0, req->timer.func=3D1
> > [  311.235964] fuse_request_timeout: req=3D00000000b4182f02
> > [  311.235969] ------------[ cut here ]------------
> > [  311.235970] list_del corruption, ffff9a8072d3a000->next is
> > LIST_POISON1 (dead000000000100)
> > [  311.235982] WARNING: CPU: 26 PID: 0 at lib/list_debug.c:56
> > __list_del_entry_valid_or_report+0x8a/0xf0
> > [  311.236036] CPU: 26 PID: 0 Comm: swapper/26 Kdump: loaded Tainted:
> > G    B              6.10.0+ #8
> > [  311.236040] RIP: 0010:__list_del_entry_valid_or_report+0x8a/0xf0
> > [  311.236043] Code: 31 c0 5d c3 cc cc cc cc 48 c7 c7 60 7a 5e b0 e8
> > cc ea a4 ff 0f 0b 31 c0 5d c3 cc cc cc cc 48 c7 c7 88 7a 5e b0 e8 b6
> > ea a4 ff <0f> 0b 31 c0 5d c3 cc cc cc cc 48 89 ca 48 c7 c7 c0 7a 5e b0
> > e8 9d
> > [  311.236045] RSP: 0018:ffffb6364056ce60 EFLAGS: 00010282
> > [  311.236047] RAX: 0000000000000000 RBX: ffff9a8072d3a0a0 RCX: 0000000=
000000027
> > [  311.236048] RDX: ffff9a807f4a0848 RSI: 0000000000000001 RDI: ffff9a8=
07f4a0840
> > [  311.236049] RBP: ffffb6364056ce60 R08: 0000000000000000 R09: ffffb63=
64056cce0
> > [  311.236050] R10: ffffb6364056ccd8 R11: ffffffffb1017ee8 R12: ffff9a8=
072d3a000
> > [  311.236051] R13: ffff9a420d5af000 R14: 0000000100002800 R15: ffff9a4=
20d5af054
> > [  311.236054] FS:  0000000000000000(0000) GS:ffff9a807f480000(0000)
> > knlGS:0000000000000000
> > [  311.236056] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  311.236057] CR2: 000000c000dc5000 CR3: 000000010cc38003 CR4: 0000000=
000370ef0
> > [  311.236058] Call Trace:
> > [  311.236059]  <IRQ>
> > [  311.236061]  ? show_regs+0x69/0x80
> > [  311.236065]  ? __warn+0x88/0x130
> > [  311.236068]  ? __list_del_entry_valid_or_report+0x8a/0xf0
> > [  311.236070]  ? report_bug+0x18f/0x1a0
> > [  311.236074]  ? handle_bug+0x40/0x70
> > [  311.236077]  ? exc_invalid_op+0x19/0x70
> > [  311.236079]  ? asm_exc_invalid_op+0x1b/0x20
> > [  311.236083]  ? __list_del_entry_valid_or_report+0x8a/0xf0
> > [  311.236086]  fuse_request_timeout+0x15c/0x1a0 [fuse]
> > [  311.236094]  ? __pfx_fuse_request_timeout+0x10/0x10 [fuse]
> > [  311.236099]  call_timer_fn+0x2c/0x130
> > [  311.236102]  ? __pfx_fuse_request_timeout+0x10/0x10 [fuse]
> > [  311.236106]  __run_timers+0x2c2/0x360
> > [  311.236108]  ? kvm_sched_clock_read+0x11/0x20
> > [  311.236110]  ? sched_clock_noinstr+0x9/0x10
> > [  311.236111]  ? sched_clock+0x10/0x30
> > [  311.236114]  ? sched_clock_cpu+0x10/0x190
> > [  311.236116]  run_timer_softirq+0x3a/0x60
> > [  311.236118]  handle_softirqs+0x118/0x350
> > [  311.236121]  irq_exit_rcu+0x60/0x80
> > [  311.236123]  sysvec_apic_timer_interrupt+0x7f/0x90
> > [  311.236124]  </IRQ>
> > [  311.236125]  <TASK>
> > [  311.236126]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> > [  311.236128] RIP: 0010:default_idle+0xb/0x20
> > [  311.236130] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90
> > 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d b3 51 33
> > 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > 00 90
> > [  311.236131] RSP: 0018:ffffb6364018fe18 EFLAGS: 00000246
> > [  311.236133] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0001c05=
82ca6ada0
> > [  311.236134] RDX: 0000000000000001 RSI: ffffffffb112e060 RDI: ffff9a8=
07f4bc8e0
> > [  311.236135] RBP: ffffb6364018fe20 R08: 00000048770ca8ec R09: 0000000=
000000001
> > [  311.236135] R10: ffffffffb0e56080 R11: 0000000000000001 R12: 0000000=
000000001
> > [  311.236136] R13: ffffffffb112e060 R14: ffffffffb112e0e0 R15: 0000000=
000000001
> > [  311.236138]  ? ct_kernel_exit.constprop.0+0x79/0x90
> > [  311.236140]  ? arch_cpu_idle+0x9/0x10
> > [  311.236142]  default_enter_idle+0x22/0x2f
> > [  311.236144]  cpuidle_enter_state+0x88/0x430
> > [  311.236146]  cpuidle_enter+0x34/0x50
> > [  311.236150]  call_cpuidle+0x22/0x50
> > [  311.236151]  cpuidle_idle_call+0xd2/0x120
> > [  311.236154]  do_idle+0x77/0xd0
> > [  311.236156]  cpu_startup_entry+0x2c/0x30
> > [  311.236158]  start_secondary+0x117/0x140
> > [  311.236160]  common_startup_64+0x13e/0x141
> > [  311.236163]  </TASK>
> > [  311.236163] ---[ end trace 0000000000000000 ]---
> > [  311.236165] do_fuse_request_end: req=3D00000000b4182f02,
> > from_timer=3D1, req->timer.func=3D1
> > [  311.236166] ------------[ cut here ]------------
> > [  311.236167] refcount_t: underflow; use-after-free.
> > [  311.236174] WARNING: CPU: 26 PID: 0 at lib/refcount.c:28
> > refcount_warn_saturate+0xc2/0x110
> > [  311.236207] CPU: 26 PID: 0 Comm: swapper/26 Kdump: loaded Tainted:
> > G    B   W          6.10.0+ #8
> > [  311.236209] RIP: 0010:refcount_warn_saturate+0xc2/0x110
> > [  311.236211] Code: 01 e8 d2 72 a6 ff 0f 0b 5d c3 cc cc cc cc 80 3d
> > 33 d4 b1 01 00 75 81 48 c7 c7 30 69 5e b0 c6 05 23 d4 b1 01 01 e8 ae
> > 72 a6 ff <0f> 0b 5d c3 cc cc cc cc 80 3d 0d d4 b1 01 00 0f 85 59 ff ff
> > ff 48
> > [  311.236212] RSP: 0018:ffffb6364056cdf8 EFLAGS: 00010286
> > [  311.236213] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000=
000000027
> > [  311.236214] RDX: ffff9a807f4a0848 RSI: 0000000000000001 RDI: ffff9a8=
07f4a0840
> > [  311.236215] RBP: ffffb6364056cdf8 R08: 0000000000000000 R09: ffffb63=
64056cc78
> > [  311.236216] R10: ffffb6364056cc70 R11: ffffffffb1017ee8 R12: ffff9a8=
072d3a000
> > [  311.236217] R13: ffff9a420d5af000 R14: ffff9a42426a6ec0 R15: ffff9a8=
072d3a010
> > [  311.236219] FS:  0000000000000000(0000) GS:ffff9a807f480000(0000)
> > knlGS:0000000000000000
> > [  311.236221] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  311.236222] CR2: 000000c000dc5000 CR3: 000000010cc38003 CR4: 0000000=
000370ef0
> > [  311.236223] Call Trace:
> > [  311.236223]  <IRQ>
> > [  311.236224]  ? show_regs+0x69/0x80
> > [  311.236233]  ? __warn+0x88/0x130
> > [  311.236235]  ? refcount_warn_saturate+0xc2/0x110
> > [  311.236236]  ? report_bug+0x18f/0x1a0
> > [  311.236238]  ? handle_bug+0x40/0x70
> > [  311.236240]  ? exc_invalid_op+0x19/0x70
> > [  311.236242]  ? asm_exc_invalid_op+0x1b/0x20
> > [  311.236244]  ? refcount_warn_saturate+0xc2/0x110
> > [  311.236246]  ? refcount_warn_saturate+0xc2/0x110
> > [  311.236247]  fuse_put_request+0xc6/0xf0 [fuse]
> > [  311.236253]  do_fuse_request_end+0xcc/0x1e0 [fuse]
> > [  311.236258]  fuse_request_timeout+0xac/0x1a0 [fuse]
> > [  311.236263]  ? __pfx_fuse_request_timeout+0x10/0x10 [fuse]
> > [  311.236267]  call_timer_fn+0x2c/0x130
> > [  311.236269]  ? __pfx_fuse_request_timeout+0x10/0x10 [fuse]
> > [  311.236274]  __run_timers+0x2c2/0x360
> > [  311.236275]  ? kvm_sched_clock_read+0x11/0x20
> > [  311.236277]  ? sched_clock_noinstr+0x9/0x10
> > [  311.236278]  ? sched_clock+0x10/0x30
> > [  311.236280]  ? sched_clock_cpu+0x10/0x190
> > [  311.236281]  run_timer_softirq+0x3a/0x60
> > [  311.236283]  handle_softirqs+0x118/0x350
> > [  311.236285]  irq_exit_rcu+0x60/0x80
> > [  311.236286]  sysvec_apic_timer_interrupt+0x7f/0x90
> > [  311.236288]  </IRQ>
> > [  311.236288]  <TASK>
> > [  311.236289]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
> > [  311.236291] RIP: 0010:default_idle+0xb/0x20
> > [  311.236293] Code: 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 6e ff ff ff 90
> > 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 eb 07 0f 00 2d b3 51 33
> > 00 fb f4 <fa> c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > 00 90
> > [  311.236294] RSP: 0018:ffffb6364018fe18 EFLAGS: 00000246
> > [  311.236295] RAX: 0000000000004000 RBX: 0000000000000001 RCX: 0001c05=
82ca6ada0
> > [  311.236296] RDX: 0000000000000001 RSI: ffffffffb112e060 RDI: ffff9a8=
07f4bc8e0
> > [  311.236297] RBP: ffffb6364018fe20 R08: 00000048770ca8ec R09: 0000000=
000000001
> > [  311.236298] R10: ffffffffb0e56080 R11: 0000000000000001 R12: 0000000=
000000001
> > [  311.236299] R13: ffffffffb112e060 R14: ffffffffb112e0e0 R15: 0000000=
000000001
> > [  311.236300]  ? ct_kernel_exit.constprop.0+0x79/0x90
> > [  311.236302]  ? arch_cpu_idle+0x9/0x10
> > [  311.236304]  default_enter_idle+0x22/0x2f
> > [  311.236306]  cpuidle_enter_state+0x88/0x430
> > [  311.236308]  cpuidle_enter+0x34/0x50
> > [  311.236310]  call_cpuidle+0x22/0x50
> > [  311.236311]  cpuidle_idle_call+0xd2/0x120
> > [  311.236313]  do_idle+0x77/0xd0
> > [  311.236315]  cpu_startup_entry+0x2c/0x30
> > [  311.236317]  start_secondary+0x117/0x140
> > [  311.236318]  common_startup_64+0x13e/0x141
> > [  311.236320]  </TASK>
> > [  311.236321] ---[ end trace 0000000000000000 ]---
> >
> > I wish I could provide you with a clear explanation of what happened
> > in my test environment, but I haven't had the time to delve into the
> > details yet.
> >
> >
> > --
> > Regards
> > Yafang

