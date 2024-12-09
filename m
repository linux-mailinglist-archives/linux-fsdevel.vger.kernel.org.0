Return-Path: <linux-fsdevel+bounces-36838-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA5F9E9B7F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DBB1886C75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B079B1474A2;
	Mon,  9 Dec 2024 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS5zSVGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5214A0AA;
	Mon,  9 Dec 2024 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761420; cv=none; b=KrR2jhNCe4zmSKVyf9W7lNSMUmqnu5xjxO45ZHQ4VYwqCAcXa1Um4/jF2cstvCVQQZ0GmQ/24z5Ba74LAA3A9U5mL0yMYaLbJbEaFh1uaYiBXQ8z4Zwv4q1rXAvGWsM2rBX9gEbydnjCV0i9IF9K0Fb5OULRfaSMNZV2tOgredc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761420; c=relaxed/simple;
	bh=J7WTWNZjTNU6Inc8M05Ida9EHcfcexe793ivbpD1Zls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aIfIdomPrq5Dn8QrPGfvzrFQf6GHzl8014hK73zHlo5b7fOGuftHW0zFnwJc2WVeYNgeWc+0j8mXbMPEkPLReYAirMCD8PW9viIUy+0QVj2O/SYjrwCaCuqizjK95SdN2BABk+VXOzKy5kmEDvkP0h+otYw3BEd1eA8oh4Cl3iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS5zSVGU; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3d2a30afcso4558614a12.3;
        Mon, 09 Dec 2024 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733761416; x=1734366216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0K8ZP2F40I1V9oEBcZ5JHDlz8ReIw6B0xGg0te9jF0k=;
        b=gS5zSVGUicqjDYMYUITd6cV9y5tTk34DvbL/jjIcc5EDQIfag5cRlnlpBnF9qUpjiv
         BXW8SU4RIApxMe2fjbMTYSgZvto6U0RTLnKqAMa+luj3g5RCtBTAihRloblYD1oNigaH
         QRLYrXNVY13A22b0wZIuAttOj/iws13X4tIz4QZlVP0/RnebuSww0RkF0mP0qf0yqCMZ
         w0V7TCrE1RnnHIE/U4tSGB1+yKTGWX3IgIRso1pwDn8HZ6i0W35ALzYqJEagPOMBp7fj
         xuvVOJtuPF/QecOoo1619N01LZemGRu2cYiSmsYf0/FdmNHjnHHSaKWdqXZsna/okVj7
         /Mzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761416; x=1734366216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0K8ZP2F40I1V9oEBcZ5JHDlz8ReIw6B0xGg0te9jF0k=;
        b=jHMtFLfN7wpqipMR+6IoWpc8vgkeMGRidpqS5zbghWebwFkYyHoVTAZ+zsRoXwTT9f
         qQUwIC2B8/8uKwcwx8z2K++kBVEnkim1OhmV+38BrmMmxmBjfak2d5x6MPHO/SHgLdPX
         RParkq0D2vaitV15+rPnps41D1agEQQrthUeETNHg5u7owQSfaOAtIBqzMOn4vVMtIi+
         R1++xrnsW1FrK9/mmU/b/xTzPPlCRlMb+z9FWANPgaxYf9VY4C+FPefONIgD0dpn9KGq
         k8OvZVUeH6B+t3/+T1SHgP6hhNf2shaMaTpYCu2Cx7HjHMgUta3XAfytcwU3sFykl54J
         4A1w==
X-Forwarded-Encrypted: i=1; AJvYcCUbC1XPSGSI9j3iluFSw2EEWc65esD2t9Y43JMjVR+KqIA4BTbOKQo4Jtq1unJYkFxwdskb1XJLczwj/Q==@vger.kernel.org, AJvYcCUf+qcuuIvyCikd/BzOqOv1CSd5iR409MAwUK2xvMxatHf33AWdzSVjrU166S9aLyFqelLvn49t1yQDBq15@vger.kernel.org, AJvYcCVA2bQ/OcdkPEIrWGnMyxRZpeSpZeYQ/BJfHKg7pgT2CJIQkurQMoZqe3b1xaRLyzGQ3LsZ95yLq3k+@vger.kernel.org, AJvYcCVEMnqh+u6y2c2ThyWZEEnndagmckBpVUTnB4P2jdXxyEyKPaZ2SYTHVElAEJqxj7DCqnw5dH3B92quXfoUnQ==@vger.kernel.org, AJvYcCWSawgqBdKfdA/v1BAH/i7Vi9qCVeigT+EUcyo9YD0wmb3wm0JdR7/rxS1oHx88dyOHtKWscgchQHuNZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZEhhDNq9xKBiXEaTqBPiwlAa0KEb+rxGCjL4TRdJxhmrmIiEK
	JH9OR2T1OW3iY4tFQPoUcOgHi1SvE9WbTgLQDbSE9Vm3CgthxjKivO+QxXrbSmvw7/bXi/4U/gF
	MQhRcp4tTC3RPB80mnHQPlk+yr2E=
X-Gm-Gg: ASbGncvgtw+2R3P8bHCzdojMkYlNBx6qMFxCy47jroR9DIF3nLmdX5ihTmFvJ2rbOMg
	xLgTQdecV/gAnhGK1fUnX0BzUb4IL/dAUUQY=
X-Google-Smtp-Source: AGHT+IHmex2O3oPEmcdzQYRDxskxCLJEzFe9sxDiHkQR1oioeUncNUJNUrhnRyG2dNZ7LdMyL3H2jyVIZBJBfxS9GRo=
X-Received: by 2002:a05:6402:3906:b0:5cf:924f:9968 with SMTP id
 4fb4d7f45d1cf-5d3be661c03mr13750415a12.2.1733761415276; Mon, 09 Dec 2024
 08:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241208152520.3559-1-spasswolf@web.de> <20241209121104.j6zttbqod3sh3qhr@quack3>
 <20241209122648.dpptugrol4p6ikmm@quack3>
In-Reply-To: <20241209122648.dpptugrol4p6ikmm@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Dec 2024 17:23:24 +0100
Message-ID: <CAOQ4uxgVNGmLqURdO0wf3vo=K-a2C--ZLKFzXw-22PJdkBjEdA@mail.gmail.com>
Subject: Re: commit 0790303ec869 leads to cpu stall without CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
To: Jan Kara <jack@suse.cz>
Cc: Bert Karwatzki <spasswolf@web.de>, Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org, 
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:26=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 09-12-24 13:11:04, Jan Kara wrote:
> > > Then I took a closer look at the function called in the problematic c=
ode
> > > and noticed that fsnotify_file_area_perm(), is a NOOP when
> > > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set (which was the case in =
my
> > > .config). This also explains why this was not found before, as
> > > distributional .config file have this option enabled.  Setting the op=
tion
> > > to y solves the issue, too
> >
> > Well, I agree with you on all the points but the real question is, how =
come
> > the test FMODE_FSNOTIFY_HSM(file->f_mode) was true on our kernel when y=
ou
> > clearly don't run HSM software, even more so with
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled. That's the real cause of t=
his
> > problem. Something fishy is going on here... checking...
> >
> > Ah, because I've botched out file_set_fsnotify_mode() in case
> > CONFIG_FANOTIFY_ACCESS_PERMISSIONS is disabled. This should fix the
> > problem:
> >
> > index 1a9ef8f6784d..778a88fcfddc 100644
> > --- a/include/linux/fsnotify.h
> > +++ b/include/linux/fsnotify.h
> > @@ -215,6 +215,7 @@ static inline int fsnotify_open_perm(struct file *f=
ile)
> >  #else
> >  static inline void file_set_fsnotify_mode(struct file *file)
> >  {
> > +       file->f_mode |=3D FMODE_NONOTIFY_PERM;
> >  }
> >
> > I'm going to test this with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled=
 and
> > push out a fixed version. Thanks again for the report and analysis!
>
> So this was not enough, What we need is:
> index 1a9ef8f6784d..778a88fcfddc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -215,6 +215,10 @@ static inline int fsnotify_open_perm(struct file *fi=
le)
>  #else
>  static inline void file_set_fsnotify_mode(struct file *file)
>  {
> +       /* Is it a file opened by fanotify? */
> +       if (FMODE_FSNOTIFY_NONE(file->f_mode))
> +               return;
> +       file->f_mode |=3D FMODE_NONOTIFY_PERM;
>  }
>
> This passes testing for me so I've pushed it out and the next linux-next
> build should have this fix.

This fix is not obvious to the code reviewer (especially when that is
reviewer Linus...)
Perhaps it would be safer and less hidden to do:

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -211,11 +211,16 @@ typedef int (dio_iodone_t)(struct kiocb *iocb,
loff_t offset,

 #define FMODE_FSNOTIFY_NONE(mode) \
        ((mode & FMODE_FSNOTIFY_MASK) =3D=3D FMODE_NONOTIFY)
+#ifdef CONFIG_FANOTIFY_ACCESS_PERMISSIONS
 #define FMODE_FSNOTIFY_PERM(mode) \
        ((mode & FMODE_FSNOTIFY_MASK) =3D=3D 0 || \
         (mode & FMODE_FSNOTIFY_MASK) =3D=3D (FMODE_NONOTIFY | FMODE_NONOTI=
FY_PERM))
 #define FMODE_FSNOTIFY_HSM(mode) \
        ((mode & FMODE_FSNOTIFY_MASK) =3D=3D 0)
+#else
+#define FMODE_FSNOTIFY_PERM(mode)      0
+#define FMODE_FSNOTIFY_HSM(mode)       0
+#endif

Similar to IS_POSIXACL()

Thanks,
Amir.

