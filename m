Return-Path: <linux-fsdevel+bounces-24897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F0794638E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 038ED281D3C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C081537CE;
	Fri,  2 Aug 2024 19:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7uo1/RH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD51E522
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Aug 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722625561; cv=none; b=XQXbVTu++LLcD/6EwizPmbv9nSEQxAcqoeQhHSNVJPFIdELclEzMwbWPSg1UeL557q9gOKF60jnfCJowGmSdzTIt8kN4Sj9HfuTB7eHdUqXnfcwMJgtZzscIyQxM6Jh8ThL8QmFx32SebRUM727jwxfZ9kSIUk5yV4jhSHrCmzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722625561; c=relaxed/simple;
	bh=HN0W98ntmqnV+5xiOZh9jLXeJ/y/u49LnBSBUjDSe7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXywXURktPVSH5cuxltOUDU0YGcSUaGVneWVbUYdu8QKhM+5pmTfSNWuqkIuvadoMSp80KueMGLO0G2rQSARgAslIAaFZu8Yw+SnQFH6V4AuPFAixS3Y1y9Ja3O48P5grwL7FRNWpei1RO8Hs3f1wg859BHMNgpvvW95vTrkl0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7uo1/RH; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7a1df0a9281so516782885a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Aug 2024 12:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722625558; x=1723230358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLpfhvyrCmHrWvkrho0PLqpqrGvL1crCNylx9wHyUAY=;
        b=B7uo1/RHVlCtTSiFEevpQGukFez0pSscPs5xmejo4m2PhnespbAW9Et0TadIkVpPpE
         jYMnSFE4xVB2/7l/bp/nMhn/WP2KWBtgF8xC6uuFp+CMBjwH5lJDmOBIEoq3G+8UaqTI
         H7kRvY9whTNa91Gr0as+QTvmOT1Q+i8b124gdZKzhfTJxcKQNTHTWD6OWVmP0y9F+nEb
         kcAN8Bot601IfzE4fPUsNJHdsTfoxftGza3ibEE8aBa0oB5dQtswraRaIw+HKZSJGhB2
         NgoW6Tue1dleg5m3RRJGAtp3hgKGL6Uft+Ihut74vTZneIs05bbYcLkIFJkMuG3c8aPl
         L+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722625558; x=1723230358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLpfhvyrCmHrWvkrho0PLqpqrGvL1crCNylx9wHyUAY=;
        b=dDK0bolSlqQlqLKyIK2Tlr+2FZ2FDhR5YEUkNG8wB4+82HcA3vwBqVKqfSmRD+KJWQ
         NfQyUAQpovTxFJ16nan3RXp3DBlb0tkJhiFxwAgLcVDf6lFwzLah7HO+7VQ2LX4kGM5u
         kpaZT3qLMe7EBgYWEtERWdnsLeEQEfG23fHUQtEt8CubYP7DYmw5cv5ExWra4HX46ZXK
         iCjn7P+SX7xtSJ/ypjaXX1/gdtzlA5AL+ARQGASDGlwM5niEm8xOzC47TIGAsgFZ6vKw
         qLxrFAYTfMH8i7a4ZQZT2Wl5bFvjYC+4g8S91uIgzTTZNuNu6KQnSWWrMLYlPJt180Ml
         7Jrg==
X-Forwarded-Encrypted: i=1; AJvYcCUcxNruKCw0ouuSEsogBstPED5YbJ9V89lSRk8scTheLdLudsOnYm+Cy5b3dOpr1bCDYAfoiQZPehIpTMgfnqatXsfHS1M8yGEuLDRzew==
X-Gm-Message-State: AOJu0YxNd0KsYQWGd/YeG6ha7HCgoRxjOfQgBXDK89lcPNfskM4GZHNM
	aN3kxaIdTubZZTbL7Nx6gcdr5yektZHhCtbwl2oP6e+SLwd1o5/j7gVALE3yhdBWOTfX/Lgp/fN
	sFXTvs0bV9/hoP8kB8ZgAIJhp0y8=
X-Google-Smtp-Source: AGHT+IHimQIyxqOwK7csoA/H+ZkSuV62EkRhSnhVcJ+dicj3m39lqT2SMziukVWFsxBLdKRfc+36vPWtV/rJ27sGOxE=
X-Received: by 2002:a05:620a:1987:b0:79f:87c:a540 with SMTP id
 af79cd13be357-7a34f005a5dmr427469185a.58.1722625557851; Fri, 02 Aug 2024
 12:05:57 -0700 (PDT)
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
 <CAJnrk1bCrsy7s2ODTgZvrXk_4HwC=9hjeHjPvRm8MHDx+yE6PQ@mail.gmail.com> <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
In-Reply-To: <CALOAHbCsqi1LeXkdZr2RT0tMTmuCHJ+h0X1fMipuo1-DWXARWA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 2 Aug 2024 12:05:47 -0700
Message-ID: <CAJnrk1ZMYj3uheexfb3gG+pH6P_QBrmW-NPDeedWHGXhCo7u_g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 7:47=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Thu, Aug 1, 2024 at 2:46=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
> >
> > On Wed, Jul 31, 2024 at 10:52=E2=80=AFAM Joanne Koong <joannelkoong@gma=
il.com> wrote:
> > >
> > > On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannelkoong@=
gmail.com> wrote:
> > > > >
> > > > > On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@=
gmail.com> wrote:
> > > > > >
> > > > > > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelko=
ong@gmail.com> wrote:
> > > > > > >
> > > > > > > There are situations where fuse servers can become unresponsi=
ve or take
> > > > > > > too long to reply to a request. Currently there is no upper b=
ound on
> > > > > > > how long a request may take, which may be frustrating to user=
s who get
> > > > > > > stuck waiting for a request to complete.
> > > > > > >
> > > > > > > This patchset adds a timeout option for requests and two dyna=
mically
> > > > > > > configurable fuse sysctls "default_request_timeout" and "max_=
request_timeout"
> > > > > > > for controlling/enforcing timeout behavior system-wide.
> > > > > > >
> > > > > > > Existing fuse servers will not be affected unless they explic=
itly opt into the
> > > > > > > timeout.
> > > > > > >
> > > > > > > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613=
347-1-joannelkoong@gmail.com/
> > > > > > > Changes from v1:
> > > > > > > - Add timeout for background requests
> > > > > > > - Handle resend race condition
> > > > > > > - Add sysctls
> > > > > > >
> > > > > > > Joanne Koong (2):
> > > > > > >   fuse: add optional kernel-enforced timeout for requests
> > > > > > >   fuse: add default_request_timeout and max_request_timeout s=
ysctls
> > > > > > >
> > > > > > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > > > > > >  fs/fuse/Makefile                        |   2 +-
> > > > > > >  fs/fuse/dev.c                           | 187 ++++++++++++++=
+++++++++-
> > > > > > >  fs/fuse/fuse_i.h                        |  30 ++++
> > > > > > >  fs/fuse/inode.c                         |  24 +++
> > > > > > >  fs/fuse/sysctl.c                        |  42 ++++++
> > > > > > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > > > > > >  create mode 100644 fs/fuse/sysctl.c
> > > > > > >
> > > > > > > --
> > > > > > > 2.43.0
> > > > > > >
> > > > > >
> > > > > > Hello Joanne,
> > > > > >
> > > > > > Thanks for your update.
> > > > > >
> > > > > > I have tested your patches using my test case, which is similar=
 to the
> > > > > > hello-fuse [0] example, with an additional change as follows:
> > > > > >
> > > > > > @@ -125,6 +125,8 @@ static int hello_read(const char *path, cha=
r *buf,
> > > > > > size_t size, off_t offset,
> > > > > >         } else
> > > > > >                 size =3D 0;
> > > > > >
> > > > > > +       // TO trigger timeout
> > > > > > +       sleep(60);
> > > > > >         return size;
> > > > > >  }
> > > > > >
> > > > > > [0] https://github.com/libfuse/libfuse/blob/master/example/hell=
o.c
> > > > > >
> > > > > > However, it triggered a crash with the following setup:
> > > > > >
> > > > > > 1. Set FUSE timeout:
> > > > > >   sysctl -w fs.fuse.default_request_timeout=3D10
> > > > > >   sysctl -w fs.fuse.max_request_timeout =3D 20
> > > > > >
> > > > > > 2. Start FUSE daemon:
> > > > > >   ./hello /tmp/fuse
> > > > > >
> > > > > > 3. Read from FUSE:
> > > > > >   cat /tmp/fuse/hello
> > > > > >
> > > > > > 4. Kill the process within 10 seconds (to avoid the timeout bei=
ng triggered).
> > > > > >    Then the crash will be triggered.
> > > > >
> > > > > Hi Yafang,
> > > > >
> > > > > Thanks for trying this out on your use case!
> > > > >
> > > > > How consistently are you able to repro this?
> > > >
> > > > It triggers the crash every time.
> > > >
> > > > > I tried reproing using
> > > > > your instructions above but I'm not able to get the crash.
> > > >
> > > > Please note that it is the `cat /tmp/fuse/hello` process that was
> > > > killed, not the fuse daemon.
> > > > The crash seems to occur when the fuse daemon wakes up after
> > > > sleep(60). Please ensure that the fuse daemon can be woken up.
> > > >
> > >
> > > I'm still not able to trigger the crash by killing the `cat
> > > /tmp/fuse/hello` process. This is how I'm repro-ing
> > >
> > > 1) Add sleep to test code in
> > > https://github.com/libfuse/libfuse/blob/master/example/hello.c
> > > @@ -125,6 +126,9 @@ static int hello_read(const char *path, char *buf=
,
> > > size_t size, off_t offset,
> > >         } else
> > >                 size =3D 0;
> > >
> > > +       sleep(60);
> > > +       printf("hello_read woke up from sleep\n");
> > > +
> > >         return size;
> > >  }
> > >
> > > 2)  Set fuse timeout to 10 seconds
> > > sysctl -w fs.fuse.default_request_timeout=3D10
> > >
> > > 3) Start fuse daemon
> > > ./example/hello ./tmp/fuse
> > >
> > > 4) Read from fuse
> > > cat /tmp/fuse/hello
> > >
> > > 5) Get pid of cat process
> > > top -b | grep cat
> > >
> > > 6) Kill cat process (within 10 seconds)
> > >  sudo kill -9 <cat-pid>
> > >
> > > 7) Wait 60 seconds for fuse's read request to complete
> > >
> > > From what it sounds like, this is exactly what you are doing as well?
> > >
> > > I added some kernel-side logs and I'm seeing that the read request is
> > > timing out after ~10 seconds and handled by the timeout handler
> > > successfully.
> > >
> > > On the fuse daemon side, these are the logs I'm seeing from the above=
 repro:
> > > ./example/hello /tmp/fuse -f -d
> > >
> > > FUSE library version: 3.17.0
> > > nullpath_ok: 0
> > > unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
> > > INIT: 7.40
> > > flags=3D0x73fffffb
> > > max_readahead=3D0x00020000
> > >    INIT: 7.40
> > >    flags=3D0x4040f039
> > >    max_readahead=3D0x00020000
> > >    max_write=3D0x00100000
> > >    max_background=3D0
> > >    congestion_threshold=3D0
> > >    time_gran=3D1
> > >    unique: 2, success, outsize: 80
> > > unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 46, pid: 673
> > > LOOKUP /hello
> > > getattr[NULL] /hello
> > >    NODEID: 2
> > >    unique: 4, success, outsize: 144
> > > unique: 6, opcode: OPEN (14), nodeid: 2, insize: 48, pid: 673
> > > open flags: 0x8000 /hello
> > >    open[0] flags: 0x8000 /hello
> > >    unique: 6, success, outsize: 32
> > > unique: 8, opcode: READ (15), nodeid: 2, insize: 80, pid: 673
> > > read[0] 4096 bytes from 0 flags: 0x8000
> > > unique: 10, opcode: FLUSH (25), nodeid: 2, insize: 64, pid: 673
> > >    unique: 10, error: -38 (Function not implemented), outsize: 16
> > > unique: 11, opcode: INTERRUPT (36), nodeid: 0, insize: 48, pid: 0
> > > FUSE_INTERRUPT: reply to kernel to disable interrupt
> > >    unique: 11, error: -38 (Function not implemented), outsize: 16
> > >
> > > unique: 12, opcode: RELEASE (18), nodeid: 2, insize: 64, pid: 0
> > >    unique: 12, success, outsize: 16
> > >
> > > hello_read woke up from sleep
> > >    read[0] 13 bytes from 0
> > >    unique: 8, success, outsize: 29
> > >
> > >
> > > Are these the debug logs you are seeing from the daemon side as well?
> > >
> > > Thanks,
> > > Joanne
> > > > >
> > > > > From the crash logs you provided below, it looks like what's happ=
ening
> > > > > is that if the process gets killed, the timer isn't getting delet=
ed.
> >
> > When I looked at this log previously, I thought you were repro-ing by
> > killing the fuse daemon process, not the cat process. When we kill the
> > cat process, the timer shouldn't be getting deleted. (if the daemon
> > itself is killed, the timers get deleted)
> >
> > > > > I'll look more into what happens in fuse when a process is killed=
 and
> > > > > get back to you on this.
> >
> > This is the flow of what is happening on the kernel side (verified by
> > local printks) -
> >
> > `cat /tmp/fuse/hello`:
> > Issues a FUSE_READ background request (via fuse_send_readpages(),
> > fm->fc->async_read). This request will have a timeout of 10 seconds on
> > it
> >
> > The cat process is killed:
> > This does not clean up the request. The request is still on the fpq
> > processing list.
> >
> > Timeout on request expires:
> > The timeout handler runs and properly cleans up / frees the request.
> >
> > Fuse daemon wakes from sleep and replies to the request:
> > In dev_do_write(), the kernel won't be able to find this request
> > (since it timed out and was removed from the fpq processing list) and
> > return with -ENOENT
>
> Thank you for your explanation.
> I will verify if there are any issues with my test environment.
>
Hi Yafang,

Would you mind adding these printks to your kernel when you run the
repro and pasting what they show?

--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -287,6 +287,9 @@ static void do_fuse_request_end(struct fuse_req
*req, bool from_timer_callback)
        struct fuse_conn *fc =3D fm->fc;
        struct fuse_iqueue *fiq =3D &fc->iq;

+       printk("do_fuse_request_end: req=3D%p, from_timer=3D%d,
req->timer.func=3D%d\n",
+              req, from_timer_callback, req->timer.function !=3D NULL);
+
        if (from_timer_callback)
                req->out.h.error =3D -ETIME;

@@ -415,6 +418,8 @@ static void fuse_request_timeout(struct timer_list *tim=
er)
 {
        struct fuse_req *req =3D container_of(timer, struct fuse_req, timer=
);

+       printk("fuse_request_timeout: req=3D%p\n", req);
+
        /*
         * Request reply is being finished by the kernel right now.
         * No need to time out the request.
@@ -612,6 +617,7 @@ ssize_t fuse_simple_request(struct fuse_mount *fm,
struct fuse_args *args)

        if (!args->noreply)
                __set_bit(FR_ISREPLY, &req->flags);
+       printk("fuse_simple_request: req=3D%p, op=3D%u\n", req, args->opcod=
e);
        __fuse_request_send(req);
        ret =3D req->out.h.error;
        if (!ret && args->out_argvar) {
@@ -673,6 +679,7 @@ int fuse_simple_background(struct fuse_mount *fm,
struct fuse_args *args,

        fuse_args_to_req(req, args);

+       printk("fuse_background_request: req=3D%p, op=3D%u\n", req, args->o=
pcode);
        if (!fuse_request_queue_background(req)) {
                fuse_put_request(req);


When I run it on my side, I see

[   68.117740] fuse_background_request: req=3D00000000874e2f14, op=3D26
[   68.131440] do_fuse_request_end: req=3D00000000874e2f14,
from_timer=3D0, req->timer.func=3D1
[   71.558538] fuse_simple_request: req=3D00000000cf643ace, op=3D1
[   71.559651] do_fuse_request_end: req=3D00000000cf643ace,
from_timer=3D0, req->timer.func=3D1
[   71.561044] fuse_simple_request: req=3D00000000f2c001f0, op=3D14
[   71.562524] do_fuse_request_end: req=3D00000000f2c001f0,
from_timer=3D0, req->timer.func=3D1
[   71.563820] fuse_background_request: req=3D00000000584f2cc3, op=3D15
[   78.580035] fuse_simple_request: req=3D00000000ecbee970, op=3D25
[   78.582614] do_fuse_request_end: req=3D00000000ecbee970,
from_timer=3D0, req->timer.func=3D1
[   81.624722] fuse_request_timeout: req=3D00000000584f2cc3
[   81.625443] do_fuse_request_end: req=3D00000000584f2cc3,
from_timer=3D1, req->timer.func=3D1
[   81.626377] fuse_background_request: req=3D00000000b2d792ed, op=3D18
[   81.627623] do_fuse_request_end: req=3D00000000b2d792ed,
from_timer=3D0, req->timer.func=3D1

I'm seeing only one timer get called, on the read request (opcode=3D15),
and I'm not seeing do_fuse_request_end having been called on that
request before the timer is invoked.
I'm curious to compare this against the logs on your end.

Thanks!!

> --
> Regards
> Yafang

