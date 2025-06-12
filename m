Return-Path: <linux-fsdevel+bounces-51490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7957AD72CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57BC63A2609
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CF2472BD;
	Thu, 12 Jun 2025 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCDACP7V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94623D2AE;
	Thu, 12 Jun 2025 13:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749736770; cv=none; b=ffxB4sdGwglEmJI9B1XiP8vPcm/R4LWI6Eo9n4ljdWvXMPYqcnGluucOFaATw49Z3+d70LVlvg6E/TdfHLJKJKsxhfvL2DPz6ubBRYO/8gIa6zc5jJUiynN0IjSLUTSsFc72CqLZMslQCkhpG4iETENLjlABUbPKvy1yI96QccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749736770; c=relaxed/simple;
	bh=0fruNrL61s70gsmhqJiV7bdE97vxE3uBVBn3wzWCIEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HXdv7530t23ii22VABX1YniU893jVKZKCRjt0cmi7eZt4aXO0QRAMOLGazzP+BtzbFH+tHJixm+l7+b4XHi2OvBVLVzDm+cc/GqbdoabczV0Yc6mv1uPb3RhXfgT4eqCvJYQlv1JQUtjPm4+xMDDRaBmL+loQbXMs4n1+oepL/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCDACP7V; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-605b9488c28so1766723a12.2;
        Thu, 12 Jun 2025 06:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749736767; x=1750341567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axy0rlQIMI9WMYF0qCH4ZRxaAh4fle4NuWe/olzB1AY=;
        b=mCDACP7VYvEbo4sM+Xs653oASS/z5cy9LTyskx075mH1TdSHapdTIMedq7vob/D/iC
         uTRU2Iejw3yjt1MCi2rXNQGiV4gXrA8x7y2qwRNJxxnvrsqwL2O85FO7OFMa0g9N+aQL
         +MGQwRYX57e3/u2nwIIwbpbYL+hCvjlQlG5IomconqBYzJuohD04rpaM4r19GdQ0LarK
         y1mtm7kXFKUiC/hjoSKSf1UDWmcH/6UJ9kAloUFtaZ7NcOosrLU7e5UMWuNlKpqgNRD0
         FLsbZFFrtWODopgO6DoySsS470IJQ14OahpR7yffo212Rk7ZFDGjFwu9DA8MFbUZdwKj
         1Wjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749736767; x=1750341567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axy0rlQIMI9WMYF0qCH4ZRxaAh4fle4NuWe/olzB1AY=;
        b=xTuRT2Ue4rdjLrDtQkNw5vGmnehpuFJ4B0cKx6K4voupl11Zf+kb1t9Eq8ytBnTf1h
         R0sDjJNdj9Ks1BxigHMrN9eGxf7Wi7mO0vmFjJSgTLGjUG0XYpzPnedqgR1Iy6vJRxOP
         N4IVose+8AXNNjj3sg80ii0Pq2WaSne2QRsBNiG5q6INPm1J/SY8SHJuARyemewGbL+x
         6EwK4yPm/rUR4yYDa3inkCLDLQEo3zgPgEXVhofvIQq7jL/DvTZ9Drv7TKNmKv6JczCa
         SnooCxW05Dd7Hoin2FlyDpqfQeAGrW5FJQwW0sMYYzg1wrf7ieyEPveWKEtas8OxYcut
         x7YA==
X-Forwarded-Encrypted: i=1; AJvYcCUUPP7IITJNMfktNtpqyBzsjIObDc4/D0OkyjFeWquwzv0NjIgk15NKABa23efooueYQiZ3ezoJNUtvj5F+@vger.kernel.org, AJvYcCWmoMgsGemilP2h24jEJQxHqjQbJ63H6RsqERVL9+RzwPTaY6XF+V8Tb3lPvLfXUbpWMX2+A3sY9Sm4cRVA@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPyQ7BYaeDJe/5NPKDzMIWSSq9haJ/dsMUsC0OB5kk6E19K9o
	of+Ou7tj4NK6qbNpNDa+LY/Gm+9e5kR4843qdT8b8QdO4G8rmgLdJFjKhs6aakg615J/GlXAqOQ
	7Hhr4BanOdVYyYI8yQegCtECTYVscSMY=
X-Gm-Gg: ASbGncvqWETol0LywT2pAyMUjH1mOREvi1YetI2lQWpSI3ciAbsDYljLVE6/srdXN3r
	3KohTPaH4G3G7Ey9xgxXCYCGTqWuhmhoTSJ7uX4iZDaazmyGrYvn1v6ODPAMrlgTYnwAshHnVv7
	J2uxzvcn+aPq0jo68HKvivfKPEdX1rJ9LMpb0gTm5ik80=
X-Google-Smtp-Source: AGHT+IHCp92945l3Lbtgjt/svwIozABtOwPn4OQRdnVjt/ol944mXSPlcGwdCBTCbWlG9Pwl0bclDvHWAS/3qCMb/j4=
X-Received: by 2002:a17:906:4fca:b0:adb:e08:5e87 with SMTP id
 a640c23a62f3a-adea25df16emr412104266b.19.1749736766532; Thu, 12 Jun 2025
 06:59:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87tt4u4p4h.fsf@igalia.com> <20250612094101.6003-1-luis@igalia.com>
 <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
In-Reply-To: <ybfhcrgmiwlsa4elkag6fuibfnniep76n43xzopxpe645vy4zr@fth26jirachp>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 12 Jun 2025 15:59:14 +0200
X-Gm-Features: AX0GCFuVyzyb2mmghgZNaZwSNzJ0qgm89k7sk9w6b-c01nLChtinaI9yTu6OiLw
Message-ID: <CAGudoHG7jcSWkLYf0P6W6zYnK4XAY-xb30Vu5-qFVtX9atUWYQ@mail.gmail.com>
Subject: Re: [PATCH] fs: drop assert in file_seek_cur_needs_f_lock
To: Luis Henriques <luis@igalia.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 3:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Thu, Jun 12, 2025 at 10:41:01AM +0100, Luis Henriques wrote:
> > The assert in function file_seek_cur_needs_f_lock() can be triggered ve=
ry
> > easily because, as Jan Kara suggested, the file reference may get
> > incremented after checking it with fdget_pos().
> >
> > Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> > Signed-off-by: Luis Henriques <luis@igalia.com>
> > ---
> > Hi Christian,
> >
> > It wasn't clear whether you'd be queueing this fix yourself.  Since I d=
on't
> > see it on vfs.git, I decided to explicitly send the patch so that it do=
esn't
> > slip through the cracks.
> >
> > Cheers,
> > --
> > Luis
> >
> >  fs/file.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index 3a3146664cf3..075f07bdc977 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -1198,8 +1198,6 @@ bool file_seek_cur_needs_f_lock(struct file *file=
)
> >       if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_sh=
ared)
> >               return false;
> >
> > -     VFS_WARN_ON_ONCE((file_count(file) > 1) &&
> > -                      !mutex_is_locked(&file->f_pos_lock));
> >       return true;
> >  }
> >
>
> There this justifies the change.
>

Huh. scratch this sentence. I stand by the rest. :)

> fdget_pos() can only legally skip locking if it determines to be in
> position where nobody else can operate on the same file obj, meaning
> file_count(file) =3D=3D 1 and it can't go up. Otherwise the lock is taken=
.
>
> Or to put it differently, fdget_pos() NOT taking the lock and new refs
> showing up later is a bug.
>
> I don't believe anything of the sort is happening here.
>
> Instead, overlayfs is playing games and *NOT* going through fdget_pos():
>
>         ovl_inode_lock(inode);
>         realfile =3D ovl_real_file(file);
>         [..]
>         ret =3D vfs_llseek(realfile, offset, whence);
>
> Given the custom inode locking around the call, it may be any other
> locking is unnecessary and the code happens to be correct despite the
> splat.
>
> I think the safest way out with some future-proofing is to in fact *add*
> the locking in ovl_llseek() to shut up the assert -- personally I find
> it uneasy there is some underlying file obj flying around.
>
> Even if ultimately the assert has to go, the proposed commit message
> does not justify it.



--=20
Mateusz Guzik <mjguzik gmail.com>

