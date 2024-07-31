Return-Path: <linux-fsdevel+bounces-24701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB4F943530
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 19:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73E301C213F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF643A8F0;
	Wed, 31 Jul 2024 17:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXutXfud"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02D434CE5
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722448342; cv=none; b=ClMtChh7zg1dlxTbBcPKzDvPu3zKS6lHEnGUpKm8J73sqHZypFFlGsqCM6wZOlcIVEgATFB8tetKLVwb8KXugSc3zQrecUjJ4HPPWVeP0rlCtx070poUVGGqHhFtapd6/PljyaLLz2o7DK4+NchBxn3p2HK16mNtFBJ8QrmNuLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722448342; c=relaxed/simple;
	bh=8hnbgDakOj+3YynLlMtPeNNKAZ16sVMNR7j3Z5iFMLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jpvpJpJZbj2o28oytRc8ZPwicAKNUupGp/mXNALGy7kztxQszVBeZ0uGyDfc5wM2m///3piFyaKonxGhUBngVVNm5pCBzIp8Ya+2EvaKGrVkrlNA7dUjGcK2lc2Tj2UOcN5GRLb4C9Vw2qi2r8J8/jg7p9JOcdM2J3TDS4aG5xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXutXfud; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fe9aa3bfaso35617141cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2024 10:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722448340; x=1723053140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+njW89gVTiWYfMSDRj39RltWyemuZg9TgacaI8khhg=;
        b=TXutXfudf+KLxTHFYi13egIrghaH0r/b5r6HZGiw/4QJ2Upc5CQICCd/GpVGOjQ8RX
         5auNR858sQ3PvLf8IJvwy//Fnu9KoY6QuyEBCo1iN9xob/69LYN9rmjeFyoBW2grtPkZ
         c9r7A2VpmErov06rKn31B060/3O1pjmSOcowSipVJWMNT+DJbylY3ArROWjT72cMCE43
         NoviqAvx2MPAbmwBdudnBnQH9Q6uPDQj+NLQGae/cumQ6vRmwKlHKg1iyzDTyYqfNJKY
         AI71NjytjkBVdH7eg0MMVPyMiP8iS5rMyT56oVBSDynj3weHGYx1D2v9KLWzWACfAo7y
         uUww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722448340; x=1723053140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+njW89gVTiWYfMSDRj39RltWyemuZg9TgacaI8khhg=;
        b=RlMICagxknUZ0FNLWl/+OLN3sACjbg67ekm+A3BeEFKLlxdEMH7SEJ/7MwMmQ07rUZ
         Y8Fayrn+1vS4+CmsYgpmZHcn4ipXq9VD0UCjwLn+EGpA7ivOe+P6v9YyxO8J2JrWzO3N
         PveVtPQvzHp53S2hNnEGHGRO7mtQh2f7A6MNxSEHlZixGmNY87fSvb2NlVxpQGAspUJG
         kKG3WLnzxBpfHB/eLs/wL9ZDCYqtKf4OPpxVQTLPmpljKPn3cCaMw9cjUnPHDwB80C1m
         toUbCG2V8uaFLuBm1nzlF7vzZ9NbjCPVEsD7zLQTe0nBROsU3SQp8NBcxT55NZtHsWI5
         UX2g==
X-Forwarded-Encrypted: i=1; AJvYcCUL3rq4GGA9znqw0Uhywv8H+bWBLgfs2/FoPLukZJMNxuoc8nsaFejwPQU9xlLpehrIW8Rcr09T9VzonqA+n8De+dGfA/xomOqqFweFpA==
X-Gm-Message-State: AOJu0YxOFElhdRExCi5Y1lIKz4GPmKV4DGuDPsFoR4HGcTcxDWLtEGGZ
	Y6Yk9XC/JVribQV5cMH0UJMKSd+r6e0p9oArQ+YbA+lAR9wfLLENBvQxiiYOF3XIarmmuH9v7OY
	OlXs4m/Te0s5/UDzumVVHOqV893k=
X-Google-Smtp-Source: AGHT+IGXchrs6OYZ1ZlIZpAZH37T5/qyEMjSAZ2CVxAzBU+x0MvLi6PzuG/CJ1klsCwfis2aMAC5um/n9/40i1jZhjw=
X-Received: by 2002:ac8:5d44:0:b0:44f:ee6b:b83b with SMTP id
 d75a77b69052e-4515eae9f9amr309961cf.48.1722448339647; Wed, 31 Jul 2024
 10:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730002348.3431931-1-joannelkoong@gmail.com>
 <CALOAHbD=PY+forv4WebU06igfTdk2UpuwEpNosimWKE=Y=QmYg@mail.gmail.com>
 <CAJnrk1ZQReyeySuPZctDFKt=_AwRfBE8cZEjLNU3SbEuaO49+w@mail.gmail.com> <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
In-Reply-To: <CALOAHbCWQOw6Hj6+zEiivRtfd4haqO+Q8KZQj2OPpsJ3M2=3AA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 31 Jul 2024 10:52:08 -0700
Message-ID: <CAJnrk1ZGR_a6=GHExrAeQN339++R_rcFqtiRrQ0AS4btr4WDLQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] fuse: add timeout option for requests
To: Yafang Shao <laoar.shao@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:14=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Wed, Jul 31, 2024 at 2:16=E2=80=AFAM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > On Mon, Jul 29, 2024 at 11:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > >
> > > On Tue, Jul 30, 2024 at 8:28=E2=80=AFAM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > >
> > > > There are situations where fuse servers can become unresponsive or =
take
> > > > too long to reply to a request. Currently there is no upper bound o=
n
> > > > how long a request may take, which may be frustrating to users who =
get
> > > > stuck waiting for a request to complete.
> > > >
> > > > This patchset adds a timeout option for requests and two dynamicall=
y
> > > > configurable fuse sysctls "default_request_timeout" and "max_reques=
t_timeout"
> > > > for controlling/enforcing timeout behavior system-wide.
> > > >
> > > > Existing fuse servers will not be affected unless they explicitly o=
pt into the
> > > > timeout.
> > > >
> > > > v1: https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-=
joannelkoong@gmail.com/
> > > > Changes from v1:
> > > > - Add timeout for background requests
> > > > - Handle resend race condition
> > > > - Add sysctls
> > > >
> > > > Joanne Koong (2):
> > > >   fuse: add optional kernel-enforced timeout for requests
> > > >   fuse: add default_request_timeout and max_request_timeout sysctls
> > > >
> > > >  Documentation/admin-guide/sysctl/fs.rst |  17 +++
> > > >  fs/fuse/Makefile                        |   2 +-
> > > >  fs/fuse/dev.c                           | 187 ++++++++++++++++++++=
+++-
> > > >  fs/fuse/fuse_i.h                        |  30 ++++
> > > >  fs/fuse/inode.c                         |  24 +++
> > > >  fs/fuse/sysctl.c                        |  42 ++++++
> > > >  6 files changed, 293 insertions(+), 9 deletions(-)
> > > >  create mode 100644 fs/fuse/sysctl.c
> > > >
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Hello Joanne,
> > >
> > > Thanks for your update.
> > >
> > > I have tested your patches using my test case, which is similar to th=
e
> > > hello-fuse [0] example, with an additional change as follows:
> > >
> > > @@ -125,6 +125,8 @@ static int hello_read(const char *path, char *buf=
,
> > > size_t size, off_t offset,
> > >         } else
> > >                 size =3D 0;
> > >
> > > +       // TO trigger timeout
> > > +       sleep(60);
> > >         return size;
> > >  }
> > >
> > > [0] https://github.com/libfuse/libfuse/blob/master/example/hello.c
> > >
> > > However, it triggered a crash with the following setup:
> > >
> > > 1. Set FUSE timeout:
> > >   sysctl -w fs.fuse.default_request_timeout=3D10
> > >   sysctl -w fs.fuse.max_request_timeout =3D 20
> > >
> > > 2. Start FUSE daemon:
> > >   ./hello /tmp/fuse
> > >
> > > 3. Read from FUSE:
> > >   cat /tmp/fuse/hello
> > >
> > > 4. Kill the process within 10 seconds (to avoid the timeout being tri=
ggered).
> > >    Then the crash will be triggered.
> >
> > Hi Yafang,
> >
> > Thanks for trying this out on your use case!
> >
> > How consistently are you able to repro this?
>
> It triggers the crash every time.
>
> > I tried reproing using
> > your instructions above but I'm not able to get the crash.
>
> Please note that it is the `cat /tmp/fuse/hello` process that was
> killed, not the fuse daemon.
> The crash seems to occur when the fuse daemon wakes up after
> sleep(60). Please ensure that the fuse daemon can be woken up.
>

I'm still not able to trigger the crash by killing the `cat
/tmp/fuse/hello` process. This is how I'm repro-ing

1) Add sleep to test code in
https://github.com/libfuse/libfuse/blob/master/example/hello.c
@@ -125,6 +126,9 @@ static int hello_read(const char *path, char *buf,
size_t size, off_t offset,
        } else
                size =3D 0;

+       sleep(60);
+       printf("hello_read woke up from sleep\n");
+
        return size;
 }

2)  Set fuse timeout to 10 seconds
sysctl -w fs.fuse.default_request_timeout=3D10

3) Start fuse daemon
./example/hello ./tmp/fuse

4) Read from fuse
cat /tmp/fuse/hello

5) Get pid of cat process
top -b | grep cat

6) Kill cat process (within 10 seconds)
 sudo kill -9 <cat-pid>

7) Wait 60 seconds for fuse's read request to complete

From what it sounds like, this is exactly what you are doing as well?

I added some kernel-side logs and I'm seeing that the read request is
timing out after ~10 seconds and handled by the timeout handler
successfully.

On the fuse daemon side, these are the logs I'm seeing from the above repro=
:
./example/hello /tmp/fuse -f -d

FUSE library version: 3.17.0
nullpath_ok: 0
unique: 2, opcode: INIT (26), nodeid: 0, insize: 104, pid: 0
INIT: 7.40
flags=3D0x73fffffb
max_readahead=3D0x00020000
   INIT: 7.40
   flags=3D0x4040f039
   max_readahead=3D0x00020000
   max_write=3D0x00100000
   max_background=3D0
   congestion_threshold=3D0
   time_gran=3D1
   unique: 2, success, outsize: 80
unique: 4, opcode: LOOKUP (1), nodeid: 1, insize: 46, pid: 673
LOOKUP /hello
getattr[NULL] /hello
   NODEID: 2
   unique: 4, success, outsize: 144
unique: 6, opcode: OPEN (14), nodeid: 2, insize: 48, pid: 673
open flags: 0x8000 /hello
   open[0] flags: 0x8000 /hello
   unique: 6, success, outsize: 32
unique: 8, opcode: READ (15), nodeid: 2, insize: 80, pid: 673
read[0] 4096 bytes from 0 flags: 0x8000
unique: 10, opcode: FLUSH (25), nodeid: 2, insize: 64, pid: 673
   unique: 10, error: -38 (Function not implemented), outsize: 16
unique: 11, opcode: INTERRUPT (36), nodeid: 0, insize: 48, pid: 0
FUSE_INTERRUPT: reply to kernel to disable interrupt
   unique: 11, error: -38 (Function not implemented), outsize: 16

unique: 12, opcode: RELEASE (18), nodeid: 2, insize: 64, pid: 0
   unique: 12, success, outsize: 16

hello_read woke up from sleep
   read[0] 13 bytes from 0
   unique: 8, success, outsize: 29


Are these the debug logs you are seeing from the daemon side as well?

Thanks,
Joanne
> >
> > From the crash logs you provided below, it looks like what's happening
> > is that if the process gets killed, the timer isn't getting deleted.
> > I'll look more into what happens in fuse when a process is killed and
> > get back to you on this.
>
> Thanks
>
> --
> Regards
> Yafang

