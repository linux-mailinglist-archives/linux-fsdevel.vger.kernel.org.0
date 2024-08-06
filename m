Return-Path: <linux-fsdevel+bounces-25106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C594929D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31371F20DD2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 14:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD44518D62B;
	Tue,  6 Aug 2024 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpmIF3j0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F83E18D620
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953190; cv=none; b=nWOELOF2gWQbEFggWk+M/uOcLcmHjFdqiAL18RnqpMtPFz5k873wrY232ifWQgxsGaTGo8ejHfYKja6JWH9D8kRkhDy/47Aopz38JHLHmEXhCnWasxTV2ekMFr/d+UyGVnoeUO/x5EDzOBMMw1sqtBzTzi6lScfxtU+Chf+8eIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953190; c=relaxed/simple;
	bh=PeCxQVxIX5ZrBU3fXow49eONwhR+qTkRLObw6VuKjOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3nH+MjoGexHEUJjZl+gdEzCDHvIwno0VBqTuVIHhbZB3Og9o1VIxnRSKGCpsFOVCoOWBDUkliZO1o1ZrCsb659HxZfMQRZbXa0Jwa2qpfJb3/ZJmHjzh+P6MQ383itzDJVu/MSRftmN8OYVtLIUzlRE38dqkLQzQubfRKtxfA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpmIF3j0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b95b710e2cso2826966d6.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722953187; x=1723557987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sdJEKiTE7saK38JjGaKyTgdID5zzlz7hwI/T7RM/Cyo=;
        b=QpmIF3j0U8F0xexXWv5N1Q5XxBGUqWuiuaN+4oFbMKB2aGWzBawSdcpZuJmMklpVKH
         zZX/af3f2b3EGIbQro4ACVEyMu5XyAArnP0iNvHtqYbsBl0U4vsuPzK77lsTigb8YHuZ
         waoMX4GJvBMvdN35552hGv1quG8Acjc/OWN3NEBFpWYiWuutkNObRgogtWcS+8uAZHNV
         OHz/ORXMeK9v/sknnniCGDtFWtosbPefqimZJfZvQ0Ew4YyRa7S9SGgxQwrqbWDgOlqO
         AhsDBaJksoNS3fnj/4P83QYZUJ/xCXUUmVB5s0dAtB786I1/FhxKTamA/1Tv3dlZwB3j
         0C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722953187; x=1723557987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sdJEKiTE7saK38JjGaKyTgdID5zzlz7hwI/T7RM/Cyo=;
        b=QMJfir87I91yNGIxAurRqJpchTYZzknq2frX9MLJFcqUPeNdsrqrOzBc9TvSBg81eE
         cgTn8UxMczUPbXp4qXNX8f5Rstvq+4VvXzWFOK2Dgx+gc5y5ol8g/q7XFKL9/C0kAv8m
         tuAq0w9jVIqo2PC03Tck6bAq+FcLyvgtm3KMphwmUrd5WTCDS1XiZMzbRNRredA+XCW9
         U1QUvxovG6T78+fO6Rh2QpaRZx1Of5gC+vwSX6/mA15KaXUdjY23cnO4IVV8JqXleTQU
         4hXcj/CzZRHy3XbjuHy+Hm8tGvuKPORzK1X0wz56PCbdZqHYO6ADyznUHYuoyMzEJkCG
         mbjw==
X-Forwarded-Encrypted: i=1; AJvYcCWke1YO5ehdG8mGjyOCzg1/tv7wI2ktFOqmibkIZKXUhOYgGiYw5AWtxcJ49oGb6EYLYM1iXj6+pKSqSfUdgjXwABvTbYQ2Zuxv7NGuzA==
X-Gm-Message-State: AOJu0YyijrxOo/Vf/sBfD9RdnH7HJ+u1a1Qx7HVPQD+Zjzz+I6vei5AU
	bHIVTXFoiTyBWgGcIhoy14iyNBQPjlYdzEB556fbeJCa3Sl6HiMDq8SwnUwlRUPQeU6IfyTix/W
	nWLgCnd/14SbwcWSzf7TlTyXv9ig=
X-Google-Smtp-Source: AGHT+IGrRAdrwfP9YvAFELratQMCn0pGHRANRVvTK7ipnhhDItNdI0HuvB7mWPLjwqJbIKxdcxV8Uq3LxInMLxw/Hp0=
X-Received: by 2002:a05:6214:3909:b0:6b2:da3d:999f with SMTP id
 6a1803df08f44-6bb9843f728mr205839676d6.41.1722953187388; Tue, 06 Aug 2024
 07:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <20240805134034.mf3ljesorgupe6e7@quack3>
 <CALOAHbCor0VoCNLACydSytV7sB8NK-TU2tkfJAej+sAvVsVDwA@mail.gmail.com> <20240806132432.jtdlv5trklgxwez4@quack3>
In-Reply-To: <20240806132432.jtdlv5trklgxwez4@quack3>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 6 Aug 2024 22:05:50 +0800
Message-ID: <CALOAHbASNdPPRXVAxcjVWW7ucLG_DOM+6dpoonqAPpgBS00b7w@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Jan Kara <jack@suse.cz>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	Dave Chinner <david@fromorbit.com>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:24=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 06-08-24 19:54:58, Yafang Shao wrote:
> > On Mon, Aug 5, 2024 at 9:40=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> > > On Sun 04-08-24 16:02:51, Yafang Shao wrote:
> > > > Background
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > Our big data workloads are deployed on XFS-based disks, and we freq=
uently
> > > > encounter hung tasks caused by xfs_ilock. These hung tasks arise be=
cause
> > > > different applications may access the same files concurrently. For =
example,
> > > > while a datanode task is writing to a file, a filebeat[0] task migh=
t be
> > > > reading the same file concurrently. If the task writing to the file=
 takes a
> > > > long time, the task reading the file will hang due to contention on=
 the XFS
> > > > inode lock.
> > > >
> > > > This inode lock contention between writing and reading files only o=
ccurs on
> > > > XFS, but not on other file systems such as EXT4. Dave provided a cl=
ear
> > > > explanation for why this occurs only on XFS[1]:
> > > >
> > > >   : I/O is intended to be atomic to ordinary files and pipes and FI=
FOs.
> > > >   : Atomic means that all the bytes from a single operation that st=
arted
> > > >   : out together end up together, without interleaving from other I=
/O
> > > >   : operations. [2]
> > > >   : XFS is the only linux filesystem that provides this behaviour.
> > > >
> > > > As we have been running big data on XFS for years, we don't want to=
 switch
> > > > to other file systems like EXT4. Therefore, we plan to resolve thes=
e issues
> > > > within XFS.
> > > >
> > > > Proposal
> > > > =3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > One solution we're currently exploring is leveraging the preadv2(2)
> > > > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS=
 inode
> > > > lock hung task. This can be illustrated as follows:
> > > >
> > > >   retry:
> > > >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> > > >           sleep(n)
> > > >           goto retry;
> > > >       }
> > > >
> > > > Since the tasks reading the same files are not critical tasks, a de=
lay in
> > > > reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NO=
WAIT but
> > > > also enables IOCB_NOIO. Therefore, if the file is not in the page c=
ache, it
> > > > will loop indefinitely until someone else reads it from disk, which=
 is not
> > > > acceptable.
> > > >
> > > > So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(=
2). This
> > > > flag will allow reading from the disk if the file is not in the pag=
e cache
> > > > but will not allow waiting for the lock if it is held by others. Wi=
th this
> > > > new flag, we can resolve our issues effectively.
> > > >
> > > > Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dast=
ard/ [0]
> > > > Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> > > > Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/rea=
d.html [2]
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > Cc: Dave Chinner <david@fromorbit.com>
> > >
> > > Thanks for the detailed explanation! I understand your problem but I =
have to
> > > say I find this flag like a hack to workaround particular XFS behavio=
r and
> > > the guarantees the new RWF_IOWAIT flag should provide are not very cl=
ear to
> > > me.
> >
> > Its guarantee is clear:
> >
> >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> >   : Atomic means that all the bytes from a single operation that starte=
d
> >   : out together end up together, without interleaving from other I/O
> >   : operations.
>
> Oh, I understand why XFS does locking this way and I'm well aware this is
> a requirement in POSIX. However, as you have experienced, it has a
> significant performance cost for certain workloads (at least with simple
> locking protocol we have now) and history shows users rather want the ext=
ra
> performance at the cost of being a bit more careful in userspace. So I
> don't see any filesystem switching to XFS behavior until we have a
> performant range locking primitive.
>
> > What this flag does is avoid waiting for this type of lock if it
> > exists. Maybe we should consider a more descriptive name like
> > RWF_NOATOMICWAIT, RWF_NOFSLOCK, or RWF_NOPOSIXWAIT? Naming is always
> > challenging.
>
> Aha, OK. So you want the flag to mean "I don't care about POSIX read-writ=
e
> exclusion". I'm still not convinced the flag is a great idea but
> RWF_NOWRITEEXCLUSION could perhaps better describe the intent of the flag=
.

That's better. Should we proceed with implementing this new flag? It
provides users with an option to avoid this type of issue.

--=20
Regards
Yafang

