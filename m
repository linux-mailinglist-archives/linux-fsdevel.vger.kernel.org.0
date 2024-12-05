Return-Path: <linux-fsdevel+bounces-36541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10F9E58B6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 15:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5CF283913
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 14:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF321A457;
	Thu,  5 Dec 2024 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epkT98bP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22530217725;
	Thu,  5 Dec 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733409837; cv=none; b=df3SVUDGm26MLUzroaTgvpQyGmphO8Xcw6WVSSVyJEdXtaz7pxmd+PfVBgImkSlw4Ig+T4GkKgkeBWyDdWgj2rHIO+Z0K9jp4Pm6eOrMvP+MvVLrH/asPXFnRfCC6n+AuQUHcicRunHEdZNcybYbZFty+AGS+KJQ4ga6VpAeXh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733409837; c=relaxed/simple;
	bh=zqyWVW0Ah870Tx8aiC9OabF19suR5RYgkjxlpVelWJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1VU2lPlSAfqVkhMkEKjj/7nW/FJjG2adDYQYE8UulBUTh69o1MdtcMKFkLjd62O6o/tyKoBdVHN/1RicUMX6eOjEdJWPaDA6HOP7j1mblKkv3WqudUqhx6UNMszivIjHTKqKYj7xgkEIag2ep/GpMhfgogxVmI7qftUJD+/7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epkT98bP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0d3dd3097so1558711a12.0;
        Thu, 05 Dec 2024 06:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733409834; x=1734014634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTHLCrP6PQfSoGLasbB1lKEfOxQRigWWYHIwjLkZHQY=;
        b=epkT98bPrwTHDQilgZLDsJTEUcTV7H/S0zgiyg9sNeDMbVmt7nc+cUzSLiS8Q8lRWk
         qF2DRJdbq2gw3/7H81Szfxu4nX5BMlqnkaYwpZ31bJEhjcBcbkrTcUJRfTPRC4N5fhoK
         jPVuBKJqqXgIv3MODj402BqeH0ZOQnpoWiH4bxvzFVJjCOswvekXzLwNzz/37qXAOiOy
         +5WyjAVoP46tdUoIIjiqB70s3VRXpjUGhQjqeLzTjkvAReNi2T+QvW6uh0/8wsBU++F7
         FmiLAV7/HD8smOT6izkuDqETu9znB8vufSQCmKa5SW5sk89eoQDvhk6BwT+Er7mzUOyD
         FobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733409834; x=1734014634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTHLCrP6PQfSoGLasbB1lKEfOxQRigWWYHIwjLkZHQY=;
        b=bfJ/0zXbiOao9Rgeu3DtgVHjir4ets8zzA738fxpzCqyVVdFKNu9Uo67/WUpqmMZ3k
         gpNsdnwza53tSdF8XRUIoELmOE+Wox0blAsFTTm1pcdQ33lucCnNuN6V5HvJJNLDfU6p
         Z0noV4x1mW61sMZugrS0+l1x/t7P5TBLEMKtv3sQfgLaQoTs/NVrpzYmSNKT9QN7oIMY
         g4eYR9O+kd38aZMf/qfCCrzuoz7rGt6HGJGKKVhBPTpdKjCdJJH/dRUghu84oEBD+ns0
         Z5dUYv7UxoPW4M6gg1ZaYTHqGbJcFZrDnkj31n2fCCFMlTOfxtDD0CgfggKpuMU+dXj8
         BSsw==
X-Forwarded-Encrypted: i=1; AJvYcCURILGAtIVffqIsza7GTNEU5XNBU13Xf7dqBxl2IbzKWfpSstnzkwa8w1c1re1n6+fXR1dKYRbEOgGs8hK6@vger.kernel.org, AJvYcCXKq/kiMCt5usKvn1rJQr802x0nGqtBHpCc/EGf3DR4D/1hv14uuIc8AMNvLtAfgkhvaLeA99ctYq/91x61@vger.kernel.org
X-Gm-Message-State: AOJu0YwBMexLl+uLnq1clA7Q1z3jP0uG1n11Umg6dQA+QefmbwK76j2I
	nABO+Ab2mLrZVtNvg2LBA9T492aUBAg7Ws2cdpbFeosSqpVBSlReynDY9uqNg0GdW98lLI4YKWW
	xbkJDJsW1lSGWuAZhtZQWeVdz420=
X-Gm-Gg: ASbGncucs1+3LYPzyHU1ju5HwZGfjEHSthpe6PTqcbcNA1/45wAp1dZiwF70OTmxTDf
	G6KqG5PNZdckaPKH4eIzcu/xFuoSnTw==
X-Google-Smtp-Source: AGHT+IE/Y3zRB25vcI/ImwUoISM2FjLOb4IOpg92EWzfpP4MF78wQGXCoFqhErXtWgLWUASnNPm9OeTW4J94vICuSSY=
X-Received: by 2002:a05:6402:2351:b0:5cf:ab23:1f07 with SMTP id
 4fb4d7f45d1cf-5d113cc7a3amr8306133a12.15.1733409834224; Thu, 05 Dec 2024
 06:43:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHG6zYMfFmhizJDPAw=CF8QY8dzbvg0cSEW4XVcvTYhELw@mail.gmail.com>
 <20241205120332.1578562-1-mjguzik@gmail.com> <20241205141850.GS3387508@ZenIV>
In-Reply-To: <20241205141850.GS3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 5 Dec 2024 15:43:41 +0100
Message-ID: <CAGudoHH3HFDgu61S4VW2H2DXj1GMJzFRstTWhDx=jjHcb-ArwQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: elide the smp_rmb fence in fd_install()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: paulmck@kernel.org, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	edumazet@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 3:18=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Thu, Dec 05, 2024 at 01:03:32PM +0100, Mateusz Guzik wrote:
> >  void fd_install(unsigned int fd, struct file *file)
> >  {
> > -     struct files_struct *files =3D current->files;
> > +     struct files_struct *files;
> >       struct fdtable *fdt;
> >
> >       if (WARN_ON_ONCE(unlikely(file->f_mode & FMODE_BACKING)))
> >               return;
> >
> > +     /*
> > +      * Synchronized with expand_fdtable(), see that routine for an
> > +      * explanation.
> > +      */
> >       rcu_read_lock_sched();
> > +     files =3D READ_ONCE(current->files);
>
> What are you trying to do with that READ_ONCE()?  current->files
> itself is *not* changed by any of that code; current->files->fdtab is.

To my understanding this is the idiomatic way of spelling out the
non-existent in Linux smp_consume_load, for the resize_in_progress
flag.

Anyway to elaborate I'm gunning for a setup where the code is
semantically equivalent to having a lock around the work.
Pretend ->resize_lock exists, then:
fd_install:
files =3D current->files;
read_lock(files->resize_lock);
fdt =3D rcu_dereference_sched(files->fdt);
rcu_assign_pointer(fdt->fd[fd], file);
read_unlock(files->resize_lock);

expand_fdtable:
write_lock(files->resize_lock);
[snip]
rcu_assign_pointer(files->fdt, new_fdt);
write_unlock(files->resize_lock);

Except rcu_read_lock_sched + appropriately fenced resize_in_progress +
synchronize_rcu do it.

--=20
Mateusz Guzik <mjguzik gmail.com>

