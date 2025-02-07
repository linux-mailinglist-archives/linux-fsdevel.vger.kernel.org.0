Return-Path: <linux-fsdevel+bounces-41229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A2A2C91B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 17:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DB8165258
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 16:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F318DB0C;
	Fri,  7 Feb 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqKiQzCZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D059188A0E
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738946553; cv=none; b=tToGds/eoJ8JSyAyVC7IqfmlcJALpd+CpjAkwhH3h47UyFrWMOIHWpRC2lk+Nun0f/rY3YxWZzvzPARsIg/ipgJ352lcQT0flN0OHO1JYQVtrpHrLSc8+7QdlSmEr4MjhOF7PM+xy6xmrO3sUjBuPSzPkGN/wS0Fg8PfrzGirMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738946553; c=relaxed/simple;
	bh=6zu2SLbznhfsnK09I2mfovnEFZwo3VW+R7WLCrD8TJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1iNGRm6WCbGNRmmxTseHA8mJWfzL1o/DY2OKjvuvxqelcA4toAWmvUvfgqmli5zAHu1biqYa9bViDpmCJiUQkzfSaI0YoQ8xq3gJ33CowSxAZqHD9YzvI7xupBekY3/+S9yXoBpItQio5hI4kO97z0oYh0DLNgAhCUIQAQacGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqKiQzCZ; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ab78e6edb48so108744466b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Feb 2025 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738946550; x=1739551350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4/AdjD2EqSw1tKOIP1cG+n6zCz1b34KIvzZLIVT1ck=;
        b=MqKiQzCZDxRKoEE+2WF048amD5sXx9yfaDHBclq8CcwYidDWt3vgRdJ7iIANYxGMCn
         gIh5ni+MHaY3PRnKw6wCFiPXNOaCfDaYURlN28OxSDtqvUoWKJpBra/if+gEv9lfmSfb
         K999JLKEoe2Ww66yBSBgsmxRvOmHWp3XwyG4ep9XiC6t7415WCTdaWRgI/aIC5CWtxrm
         +3sjm+e2z0QoHXrKKn1WE17OKvCX3ycwGYmU5NQ1+tl2Cxmwwl/dE9uZ7H4G8E2kc1Gx
         UvCgQv+w1S34eZATT2STOsGn6pu1YO2zH+iU0ItpQJtV73KaBVrgexGCsWWqIQ+JMbqj
         wPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738946550; x=1739551350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4/AdjD2EqSw1tKOIP1cG+n6zCz1b34KIvzZLIVT1ck=;
        b=c9Vp74k9eH2Yiw9LH9+alWsCKzTLPo4s55+SGAp/Ae+0npDCFAGGscQxZI1hAUvc22
         cNT1l90S9pLn4fjmaHosB5dh1wg3lvTJi/xVjiOZiWtf2TYDMRelbezE8+VCX51YzOX7
         0osMhSP/hf7R7HJgclyd6+BD59ifzDaBxZD7gn0JWuu6n9eg5BEAvq1+4RaC55RkvAJZ
         tXegK3/zQfn/G0G1hhkm9r7XzpHcGnLS24EEWGuapf/MYtfRt/zVR0RpitKVbF+vi2W2
         6Q1pe0oftvR+fC6blYx1JKtyc0uF1iI+A6AlS8TxVzlnA38O15vsBL4EY0U4o+ufUSGB
         wMmg==
X-Forwarded-Encrypted: i=1; AJvYcCUwD146jz/PPJyed06RUJRSApreZaAkTGG8piDxz8qrG/uQxEUt3eBF3qbddTEE9xF2jRKnpnrY3fEKQjTi@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4+t23xLFH00FRkYqjSs6rwePAhjSRV1/Z0ltTZz016c4aEIv
	q/9MlpqCfmJxqyHYp43gfagUxHRiYE9cCdIbMJhMR+w8ekL0YDfPInZvn/9QAFoBVOXMFAqL0oy
	lVqyGAWIbY0BDEW9fT5FsGEh6VSQ=
X-Gm-Gg: ASbGncuPOdTp7NndE4wv0xIiS21cAJiB/xKWw5J8kkFNcU3OEE638XPLxXn11Sko3Fm
	Hu4Gr4wDAqZWkAnjAFLIjuz60PgmjRh67bKHRLoPrigMATC4mCZ8xBkW9Mp8tawjqnQ8MAs4I
X-Google-Smtp-Source: AGHT+IFBBZEvkW4hmgyca3jT232/MfTM5s3RwzLP050zSfi7YIfAXFcsYbOQtC0pntxGaEkUiK7K1AP/CawAPNGqd1M=
X-Received: by 2002:a05:6402:194b:b0:5dc:a44e:7644 with SMTP id
 4fb4d7f45d1cf-5de44fe95c1mr10285969a12.2.1738946549556; Fri, 07 Feb 2025
 08:42:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-daten-mahlzeit-99d2079864fb@brauner> <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
In-Reply-To: <hn5go2srp6csjkckh3sgru7moukgsa3glsvc6bwd5leabzamw6@osxrfpjw5wqq>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 7 Feb 2025 17:42:17 +0100
X-Gm-Features: AWEUYZl5GZq36NaN7CFQfYnNAH8PJ59zd5YYYcWeeHgvUG4QceFZ5ikE5iewwos
Message-ID: <CAGudoHGGW0BZcqyWbEV7x3rtQnRCkhhkbHNhYB0QeihSnE0VTA@mail.gmail.com>
Subject: Re: [PATCH] fs: don't needlessly acquire f_lock
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 4:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 07-02-25 15:10:33, Christian Brauner wrote:
> > Before 2011 there was no meaningful synchronization between
> > read/readdir/write/seek. Only in commit
> > ef3d0fd27e90 ("vfs: do (nearly) lockless generic_file_llseek")
> > synchronization was added for SEEK_CUR by taking f_lock around
> > vfs_setpos().
> >
> > Then in 2014 full synchronization between read/readdir/write/seek was
> > added in commit 9c225f2655e3 ("vfs: atomic f_pos accesses as per POSIX"=
)
> > by introducing f_pos_lock for regular files with FMODE_ATOMIC_POS and
> > for directories. At that point taking f_lock became unnecessary for suc=
h
> > files.
> >
> > So only acquire f_lock for SEEK_CUR if this isn't a file that would hav=
e
> > acquired f_pos_lock if necessary.
> >
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> ...
>
> >       if (whence =3D=3D SEEK_CUR) {
> > +             bool locked;
> > +
> >               /*
> > -              * f_lock protects against read/modify/write race with
> > -              * other SEEK_CURs. Note that parallel writes and reads
> > -              * behave like SEEK_SET.
> > +              * If the file requires locking via f_pos_lock we know
> > +              * that mutual exclusion for SEEK_CUR on the same file
> > +              * is guaranteed. If the file isn't locked, we take
> > +              * f_lock to protect against f_pos races with other
> > +              * SEEK_CURs.
> >                */
> > -             guard(spinlock)(&file->f_lock);
> > -             return vfs_setpos(file, file->f_pos + offset, maxsize);
> > +             locked =3D (file->f_mode & FMODE_ATOMIC_POS) ||
> > +                      file->f_op->iterate_shared;
>
> As far as I understand the rationale this should match to
> file_needs_f_pos_lock() (or it can possibly be weaker) but it isn't obvio=
us
> to me that's the case. After thinking about possibilities, I could convin=
ce
> myself that what you suggest is indeed safe but the condition being in tw=
o
> completely independent places and leading to subtle bugs if it gets out o=
f
> sync seems a bit fragile to me.
>

A debug-only assert that the lock is held when expected should sort it out?

> > +             if (!locked)
> > +                     spin_lock(&file->f_lock);
> > +             offset =3D vfs_setpos(file, file->f_pos + offset, maxsize=
);
> > +             if (!locked)
> > +                     spin_unlock(&file->f_lock);
> > +             return offset;
> >       }
> >
> >       return vfs_setpos(file, offset, maxsize);

btw I ran this sucker over a kernel build:

bpftrace -e 'kprobe:generic_file_llseek_size { @[((struct file
*)arg0)->f_mode & (1 << 15), ((struct file
*)arg0)->f_op->iterate_shared, arg2] =3D count(); }
'
Attaching 1 probe...
^C

@[32768, 0x0, 2]: 9
@[32768, 0x0, 1]: 171797
@[32768, 0x0, 0]: 660866

SEEK_CUR is 1, so this *does* show up.

--=20
Mateusz Guzik <mjguzik gmail.com>

