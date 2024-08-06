Return-Path: <linux-fsdevel+bounces-25096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B96948E0A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 13:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964451F25858
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E941C231A;
	Tue,  6 Aug 2024 11:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MxFGNHzB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09872A1CF
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 11:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944726; cv=none; b=r90e6mJBeRB9Ne04hmdD/vlTezE0u0IM/0jJuJ7ko1hjOJHaDDJnq5mb05P3QksdX6ADkjqxr8Hv5AG4GZ8fYO7vBpaGg++zdoCmnDdPzrQxKzxz9lzQB+hgNl+g9UavmtGWQxA7n/ToO7lAvJC5/lvsxR4uH6wd5qUj/1F8Mrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944726; c=relaxed/simple;
	bh=8AQvrYaoHaxfhCaSRRpl2VZjjX4jSNDsokAAL31E4Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/pRwUfHsQYoO3hIOT7QA6rmJ3CzGkBeDRQgoMkxlnZJeX1Gj5ukjBty8lG9SbOArGzeiwwGXq7DtmybGlzXTSCdPYzVN1IeRYtf166BiTYos84EHvbkjyUlCeZlbT5VQlw+wMz4kP82dDbqsu4EGCVkd8xUjrCBsH8DIJ6OT4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MxFGNHzB; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5d5d4d07babso224598eaf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Aug 2024 04:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722944724; x=1723549524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN3YKs17M/LKQXCOd52R4CZMj51CVK2LNFp2PvfeFIA=;
        b=MxFGNHzBrUqSTX5XSm31+3E0G2dGDMPlJJWmMYUiPtyPFjmFjbfasY/hgpxZgP+lGj
         DQWWS6g8demsSbbONKEJ7xCht7KQoQPak4qFOvL4/RdeNSGf3aZH2qRnEbCqsMc2WOJM
         fugzHsJiSh5ZsNDw+mnkiWb+/tBWbIwYD8mICl/hcFihxlBuykeHM85k6TrSF13ApiBY
         RmsZpmpvRI542fx4vTnmBedKPWTGRRuVoWV9INxhQ4iMn7rwhBimFDAj3kz00uK4m21K
         +h6PMCFTfD5MauRMH6KN6oRZJuBW7m6cTKNqRMWN3y1/iLazp6W/LXOlCH0ORv/PM38J
         XY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944724; x=1723549524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN3YKs17M/LKQXCOd52R4CZMj51CVK2LNFp2PvfeFIA=;
        b=oGC+d9hSNbZxcpjJHy3tbdF71iH+p+ouwOx0eexw5ZQMMYu0+wkwVuxvPJUwrK8iZp
         oG/o1vXXRnOhEwCiHsAz6U4Kh14zpXSVlKJqEMkbWjj1z6OUkxDzc2Ci0AQYYvjIO0L9
         T6BOhfEWzWQ39JtvTIMjN6eFkenekYXQstegV6fIh4voIjyt6RdsTSHA3Z5aoYEVnHf3
         d+mPyB3Vs/+urW4m1wPSXX6Lie8jeVHcSHYQY23FLI093XQkWDmLyldKXPELevUdMT8f
         cmS9HoZBztKzVFQEdEUrx/lgC24EwBicuiqBwZuhnMr56ZjZpGqo8YRO/0RzACH72y5D
         DL6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbGCfAyn/XZYPocEHhH1c7AP2XWWakxJB7xaEJgDPaC8ZbRWihCbLyT0cZ4YdysycYDA/X8TAzPplI1UtQsY8zJpf7zgB2hpMO22gxsA==
X-Gm-Message-State: AOJu0YzFp/hUgnUhrMQgOARGUFlElLNfSGX5UJQTsK4CW4XBnRSFMZ5D
	kw9gW7tDTnUgTtCi9Go4wNUrX+w08h/3vdA8hH+2wtiD2teWN9Gi8qwjo/4iWwzuTYHCc+183ur
	agihtrkK1YT0TQsaoVEvLki2AUhtIdt6h4oBoDukT
X-Google-Smtp-Source: AGHT+IElBQMxACfx+2yZr/jxoXxVHrV2G4+XSdNBJkYK+GM5xdBza6rr8QgagHbmVdvaiZ1aMoQ1MbIaEisvgixEgWE=
X-Received: by 2002:a05:6358:3a28:b0:1ac:6662:36a1 with SMTP id
 e5c5f4694b2df-1af3baaa162mr2208625355d.10.1722944723650; Tue, 06 Aug 2024
 04:45:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804080251.21239-1-laoar.shao@gmail.com> <ZrG4/8pjGRC2v1PX@dread.disaster.area>
In-Reply-To: <ZrG4/8pjGRC2v1PX@dread.disaster.area>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Tue, 6 Aug 2024 19:44:47 +0800
Message-ID: <CALOAHbC9xyjjpu5Zpqxh20CQKZ_QL=8qojxf4AtC4NXRt1ySPQ@mail.gmail.com>
Subject: Re: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
To: Dave Chinner <david@fromorbit.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 1:47=E2=80=AFPM Dave Chinner <david@fromorbit.com> w=
rote:
>
> On Sun, Aug 04, 2024 at 04:02:51PM +0800, Yafang Shao wrote:
> > Background
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > Our big data workloads are deployed on XFS-based disks, and we frequent=
ly
> > encounter hung tasks caused by xfs_ilock. These hung tasks arise becaus=
e
> > different applications may access the same files concurrently. For exam=
ple,
> > while a datanode task is writing to a file, a filebeat[0] task might be
> > reading the same file concurrently. If the task writing to the file tak=
es a
> > long time, the task reading the file will hang due to contention on the=
 XFS
> > inode lock.
> >
> > This inode lock contention between writing and reading files only occur=
s on
> > XFS, but not on other file systems such as EXT4. Dave provided a clear
> > explanation for why this occurs only on XFS[1]:
> >
> >   : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
> >   : Atomic means that all the bytes from a single operation that starte=
d
> >   : out together end up together, without interleaving from other I/O
> >   : operations. [2]
> >   : XFS is the only linux filesystem that provides this behaviour.
> >
> > As we have been running big data on XFS for years, we don't want to swi=
tch
> > to other file systems like EXT4. Therefore, we plan to resolve these is=
sues
> > within XFS.
>
> I've been looking at range locks again in the past few days because,
> once again, the need for range locking to allow exclusive range
> based operations to take place whilst concurrent IO is occurring has
> arisen. We need to be able to clone, unshare, punch holes, exchange
> extents, etc without interrupting ongoing IO to the same file.
>
> This is just another one of the cases where range locking will solve
> the problems you are having without giving up the atomic write vs
> read behaviour posix asks us to provide...

We noticed you mentioned that the issue could be resolved with range
locking, but it's unclear when that will be completed. It would be
helpful if you could send patches for it; we can assist with testing.
Additionally, aside from encountering xfs_ilock in the read() syscall,
we have also experienced it in the sendfile() syscall. Currently, our
only solution for sendfile() is to modify the userspace code to avoid
using sendfile() when other threads are writing to the file...

>
> > Proposal
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >
> > One solution we're currently exploring is leveraging the preadv2(2)
> > syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS ino=
de
> > lock hung task. This can be illustrated as follows:
> >
> >   retry:
> >       if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
> >           sleep(n)
> >           goto retry;
> >       }
>
> Hmmm.
>
> > Since the tasks reading the same files are not critical tasks, a delay =
in
> > reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT=
 but
> > also enables IOCB_NOIO. Therefore, if the file is not in the page cache=
, it
> > will loop indefinitely until someone else reads it from disk, which is =
not
> > acceptable.
> >
> > So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). =
This
> > flag will allow reading from the disk if the file is not in the page ca=
che
> > but will not allow waiting for the lock if it is held by others. With t=
his
> > new flag, we can resolve our issues effectively.
> >
> > Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/=
 [0]
> > Link: https://github.com/elastic/beats/tree/master/filebeat [1]
> > Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.ht=
ml [2]
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Dave Chinner <david@fromorbit.com>
> > ---
> >  include/linux/fs.h      | 6 ++++++
> >  include/uapi/linux/fs.h | 5 ++++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index fd34b5755c0b..5df7b5b0927a 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3472,6 +3472,12 @@ static inline int kiocb_set_rw_flags(struct kioc=
b *ki, rwf_t flags,
> >                       return -EPERM;
> >               ki->ki_flags &=3D ~IOCB_APPEND;
> >       }
> > +     if (flags & RWF_IOWAIT) {
> > +             kiocb_flags |=3D IOCB_NOWAIT;
> > +             /* IOCB_NOIO is not allowed for RWF_IOWAIT */
> > +             if (kiocb_flags & IOCB_NOIO)
> > +                     return -EINVAL;
> > +     }
>
> I'm not sure that this will be considered an acceptible workaround
> for what is largely considered by most Linux filesystem developers
> an anchronistic filesystem behaviour.

Considering that it is required by POSIX, it may not be deemed an
anachronistic filesystem behavior.

> I don't really want people to
> work around this XFS behaviour, either - waht I'd like to see is
> more people putting effort into trying to solve the range locking
> problem...

I'm not an expert on XFS, but I'm willing to assist by testing this
new feature for you.

--
Regards
Yafang

