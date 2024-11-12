Return-Path: <linux-fsdevel+bounces-34560-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302C9C650B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 00:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CFC9B3AFB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAABE21B453;
	Tue, 12 Nov 2024 22:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3/S7KMm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1721745E;
	Tue, 12 Nov 2024 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731451057; cv=none; b=WcLf241bycYHHyFZDdZ+zuo6LDALOR1Dl5Wn7ODUTAkf55lwi2OoeQyL0iKWVV/bKXen7oEDxTFSR3bF/sI7E/jjDy3MF8dVj64ch/mJmnYttZTyRJjywA6P+rB3AbD3j4ozgNUnezZ0Rqwjy/jgbDBbz+W33Yd+MKDv6DDg05Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731451057; c=relaxed/simple;
	bh=2Xgye9kLSVVbThxJiOuv4J9XrHzW3k7ZdKbuDsZUfQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPl2MeoBlXuQfg9jljcTgE9F/uWohrLsbNLxERkhBUHccHnaFf7UUcd7DlX/asn0y9BPqZev1F09PSiHjILgXzYIjzTySYf0FwY2Nb734TvdA9jjMAQVC/2FoK8PhxPhjlP56XfjITuVI775yb66CFGede9FMu/iNvgaGK+a6hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3/S7KMm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-460ab1bc2aeso41740581cf.3;
        Tue, 12 Nov 2024 14:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731451054; x=1732055854; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsJ4qi0tKyd0z6dgveSDFEC/C40H7WEHG7mL/4zFsfM=;
        b=Y3/S7KMmcXifxWWFnm6pb4z91esJ78yDboGLiFHhkNaw1EyvP7PcKjmru5Bl+FPXWT
         /muGP73W25PQQnar+CIZUz69poDWzfIvkCpe6EmIWw990djrFdOEiXM9unaGxKzRaXjD
         i02Z+uSNgfk2oJQ/I2mm7rDannqPci00QTkSZlhFFdZyr72hSjcfNibYCYQ+Sa73ISZG
         x6Ii0Ku/e8ZhFSqvXiz83Lwr/IV9r7rd48b85wyjpRersB0hyvSJ7CcNfv6Sk6Ny8IUh
         Sb1JC6IPDyF/g6cJlhAfUrNBzLQD+HUatUC905R7w44JwZT2dtuAv34tgwcZwZEHxDJ6
         SngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731451054; x=1732055854;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsJ4qi0tKyd0z6dgveSDFEC/C40H7WEHG7mL/4zFsfM=;
        b=o9L4Bu1zD1C8sbgBAoONgDosWmJxsn6r7DABPY3g/zzyuUGloZc/KgCcRoZzKG0y15
         00U/1ddXY5Ka4vzwtnEYYFhzJ+6BXElP//TnIR0D79VodOND8Vbplxy5hZqNJP+3Y3Wn
         r1Y7iBw9tCWGnW1sHoycUG4ERadJ6+7EXZo5bkjAUqyqWyZ7i3YdHHDDBh02UCL/8gmE
         oaUoJ3z/PpiuCO71Erz1KOOPPxMphsIpvBkjCBDM1nmNE8viV1aLDpbpH0DLoEz7IsMp
         ScvNsAixlwdSf/I+nyw16KqZ2mRFi+yYSOaD2Uyq6wS+zFIE+b3JAD5QR2sMjB8qT+NV
         ROag==
X-Forwarded-Encrypted: i=1; AJvYcCU9Kd5q6aRIgGG78AsfbXpJRyKkkQV9l6uHiM9iRX8xj1h1w2kGkod4XWEb2Cz087SyDekiS8tm7jBL/Q==@vger.kernel.org, AJvYcCVEoGhCm6uzrwupYQ0IZ0U7l4/CSL9KHK4z6j7V6jCcHLapWbeoOZ5UZjTP6+IDbKhvI6CalUPHTqC0cIwB3w==@vger.kernel.org, AJvYcCWA6Lf8YLuGLXe3X5FIh6WkqUDnvc0gAIU4O76CfJ4ZXc+RThmq48NDwTDQt0J2SBiFrqy2WGH5o6kY@vger.kernel.org, AJvYcCX5mV5xrbfSXGgxmPvVUi6jbHKYXutTedothY/YPB50OphDFlKfHY7HckNvlEo5oEWHwG9+Hp1Y9NVpRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPVO2SlzO4MJ5rNUBy8R+FsZXVJIx+zxQjHulK9XekClQaJMcF
	4ljbT0qL+KMBWv+n3OYiFUfwMCKxTdfVc1I0Ov+kVnpAGtKM2OVMqi348EwZIiclXVlTOBJGy86
	OSRfwAK/yvAxROp2yKMrFqickFh2EjCt+NUU=
X-Google-Smtp-Source: AGHT+IET/tFAIWy1NMuNPLTnj95HbAr/sGehV2uRf9hScSchtuK/dDofnhh+PiANipLY45hJp1UT5T5IJchyMZUuD0U=
X-Received: by 2002:a05:622a:4c08:b0:45f:3b3:49e6 with SMTP id
 d75a77b69052e-463093ef010mr274250321cf.41.1731451054504; Tue, 12 Nov 2024
 14:37:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1731433903.git.josef@toxicpanda.com> <8c8e9452d153a1918470cbe52a8eb6505c675911.1731433903.git.josef@toxicpanda.com>
 <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
In-Reply-To: <CAHk-=wjFKgs-to95Op3p19Shy+EqW2ttSOwk2OadVN-e=eV73g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Nov 2024 23:37:23 +0100
Message-ID: <CAOQ4uxjHXmYGH3wUO=w+tM+CiFWBjWvZEZZkSXA5FO8T+VP4mA@mail.gmail.com>
Subject: Re: [PATCH v7 01/18] fsnotify: opt-in for permission events at
 file_open_perm() time
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com, linux-fsdevel@vger.kernel.org, 
	jack@suse.cz, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 8:46=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 12 Nov 2024 at 09:56, Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > @@ -119,14 +118,37 @@ static inline int fsnotify_file(struct file *file=
, __u32 mask)
> >          * handle creation / destruction events and not "real" file eve=
nts.
> >          */
> >         if (file->f_mode & (FMODE_NONOTIFY | FMODE_PATH))
> > +               return false;
> > +
> > +       /* Permission events require that watches are set before FS_OPE=
N_PERM */
> > +       if (mask & ALL_FSNOTIFY_PERM_EVENTS & ~FS_OPEN_PERM &&
> > +           !(file->f_mode & FMODE_NOTIFY_PERM))
> > +               return false;
>
> This still all looks very strange.
>
> As far as I can tell, there is exactly one user of FS_OPEN_PERM in
> 'mask', and that's fsnotify_open_perm(). Which is called in exactly
> one place: security_file_open(), which is the wrong place to call it
> anyway and is the only place where fsnotify is called from the
> security layer.
>
> In fact, that looks like an active bug: if you enable FSNOTIFY, but
> you *don't* enable CONFIG_SECURITY, the whole fsnotify_open_perm()
> will never be called at all.
>
> And I just verified that yes, you can very much generate such a config.
>

See: 1cda52f1b461 fsnotify, lsm: Decouple fsnotify from lsm
in linux-next. This patch set is based on the fs-next branch.

> So the whole FS_OPEN_PERM thing looks like a special case, called from
> a (broken) special place, and now polluting this "fsnotify_file()"
> logic for no actual reason and making it all look unnecessarily messy.
>
> I'd suggest that the whole fsnotify_open_perm() simply be moved to
> where it *should* be - in the open path - and not make a bad and
> broken attempt at hiding inside the security layer, and not use this
> "fsnotify_file()" logic at all.
>
> The open-time logic is different. It shouldn't even attempt - badly -
> to look like it's the same thing as some regular file access.
>

OK, we can move setting the FMODE_NOTIFY_PERM to the open path.
I have considered that it may be better to unhide it, but wasn't sure.

Thanks,
Amir.

