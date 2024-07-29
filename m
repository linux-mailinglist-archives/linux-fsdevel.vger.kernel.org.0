Return-Path: <linux-fsdevel+bounces-24420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D793F358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927F728289C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 10:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A74145347;
	Mon, 29 Jul 2024 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWpiYhcb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D19143751;
	Mon, 29 Jul 2024 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722250631; cv=none; b=gqtvccIU8HUO9enGGJDEYPa5S2uwS4I/SZ8doiLxWCN+V0A2sEy/4+0ySQW5caw3zuXeXr5tt3ajVXuAeflciOOAw+YHqRWM0hkHJGzFWE0DVeJbFEgNtIK7wwUO/zvMw1Gh+OMlV7ohi7/Ms1EGg/O5EnwQ3nib9h39tZQnVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722250631; c=relaxed/simple;
	bh=w8GSSPcqI23nQn+Oxi/v7Rnq2v5BOe9aqJpc237LX6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rHh3OnhH/0ydmI+MvsLdAnEQtfW7K/cgx/PCYdKSISiUIltmhz+ryMjXLtWztx90NCV6VAh78jMi3Do/HPsPNH2Tq/cR+7UrvMNDA6JLGJp4bicSDfwh6vl2F2BgakGch8eWQse7YYiiC3Qlj8GNBYFXwAEXIKQ35Bwn5B1vgOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWpiYhcb; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7a8caef11fso368044866b.0;
        Mon, 29 Jul 2024 03:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722250628; x=1722855428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INLYd6MkBJDtRKL2MMGVSgGrl5yoEzJ269u2K/zCeV4=;
        b=aWpiYhcbG0MhExZAptAZdbub/eSEuASymqRKEXFBTbRcjE8g0LcSJusaXwW2C0P3dr
         qGUC2Mp/MlHr9y1YCVgng+M+2bgXRrD9mSC18gEU+DkpEHu2FkOAiAzvjMBPSJaKOLym
         VQrEn6CuDfCNfEoFbIWVFBOLPjgkZtrrI3tiyJ3TCkurjprI6TtnY+OGw1gcxDZibvYv
         uGiJMWPXpw8C5JtnKEw046fl3ZaIjLdrYK8BcqbpyydCr1Cq8JHoJOFOvAt80wF3ftt0
         ujfw8u/7V42/fwyWPzYeleAsKu9dfg9vcsMSiHio3b9GKk+2d7EmbgadTNWz9GJ7K4Uu
         h5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722250628; x=1722855428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=INLYd6MkBJDtRKL2MMGVSgGrl5yoEzJ269u2K/zCeV4=;
        b=Du8tV6A+2ylcTGiFMpo2KPspA82c1j9Ueq4VI6NuUpbK7O8PHvHb2d/NXbrPmvC2Op
         WFAPkOlmEuafwuKA9vsXndgq1kOzDq9XeaQ5dIDK5V/p1sJaY8NakyyZcha2AuV2Ekeg
         K8IafM+EOewKfBUciRY3LplBAiTAW+H/srEqOAugz5+aG95Sqql2TooP7yiLS4X3BHE3
         x0+M/pOoBi0JIwW+SkLfXZjRAw3oN0oUNNDkE3YTiUkZMuPGsq/7cJpcgELvhb/8Nhk1
         V8ok6dh3wxlJsBFzOQpiGoMA0d1b2DwQZIbgd+5XA6hcNjwuIGRAbo/fv27XFclvpYwR
         QaZA==
X-Forwarded-Encrypted: i=1; AJvYcCWeLLFhxeQNN1KjqB9noebaVZxqJH9fQy68Ewr1oxTE6SsP1mppIYWbaVJ5iEYJrj7BZbT6lBVvuAiQHbC4uJweDTh695ioJZrwi41f1WkaCZ4YXPHvGwwHISLvbrtD/ViqoYI9xe5L
X-Gm-Message-State: AOJu0YxbMzbfQuV4ten+Rou4vtPf2g2kev2OkXMo1yJt979R4eDRPcB4
	Lacj0ICzcirAeWsGP9S/USG4/hWkkgA9ThuAeqv9DfyconivFOyZDZU6kyTASHWGnPnM3zneqCi
	VSZt9hV/UV68wzylHFZiZTohewk8=
X-Google-Smtp-Source: AGHT+IGd8KZTHSY0DEwk0SrmRD2TA6ca0kQ9mCvKAuy3lmSwdNDiRVWmiN34gGLduCOdvS8ZKofIi7iqMUoMBlkOPHw=
X-Received: by 2002:a17:907:948f:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a7d40074c96mr521592766b.32.1722250627832; Mon, 29 Jul 2024
 03:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874j88sn4d.fsf@oldenburg.str.redhat.com> <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com> <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
In-Reply-To: <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 29 Jul 2024 12:56:55 +0200
Message-ID: <CAGudoHHnpOp5JL-wUnVp+X=dt+pRtX2o-dbfuqQamjWhxJei-A@mail.gmail.com>
Subject: Re: Testing if two open descriptors refer to the same inode
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:50=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> > * Mateusz Guzik:
> >
> > > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > >> It was pointed out to me that inode numbers on Linux are no longer
> > >> expected to be unique per file system, even for local file systems.
> > >
> > > I don't know if I'm parsing this correctly.
> > >
> > > Are you claiming on-disk inode numbers are not guaranteed unique per
> > > filesystem? It sounds like utter breakage, with capital 'f'.
> >
> > Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> > local file systems are different.
> >
>
> Can you link me some threads about this?
>
> > > While the above is not what's needed here, I guess it sets a preceden=
t
> > > for F_DUPINODE_QUERY (or whatever other name) to be added to handily
> > > compare inode pointers. It may be worthwhile regardless of the above.
> > > (or maybe kcmp could be extended?)
> >
> > I looked at kcmp as well, but I think it's dependent on
> > checkpoint/restore.  File sameness checks are much more basic than that=
.
> >
>
> I had this in mind (untested modulo compilation):
>
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 300e5d9ad913..5723c3e82eac 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file *filp)
>         return f.file =3D=3D filp;
>  }
>
> +static long f_dupfd_query_inode(int fd, struct file *filp)
> +{
> +       CLASS(fd_raw, f)(fd);
> +
> +       return f.file->f_inode =3D=3D filp->f_inode;
> +}
> +
>  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
>                 struct file *filp)
>  {
> @@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsign=
ed long arg,
>         case F_DUPFD_QUERY:
>                 err =3D f_dupfd_query(argi, filp);
>                 break;
> +       case F_DUPFD_QUERY_INODE:
> +               err =3D f_dupfd_query_inode(argi, filp);
> +               break;
>         case F_GETFD:
>                 err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
>                 break;
> diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> index c0bcc185fa48..2e93dbdd8fd2 100644
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -16,6 +16,8 @@
>
>  #define F_DUPFD_QUERY  (F_LINUX_SPECIFIC_BASE + 3)
>
> +#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
> +
>  /*
>   * Cancel a blocking posix lock; internal use only until we expose an
>   * asynchronous lock api to userspace:

To clarify, if indeed the dev + ino combo is no longer sufficient to
conclude it's the same thing, an explicit & handy to use way should be
provided.

For a case where you got both inodes open something like the above
will do the trick, unless I'm missing something. I can do a proper
patch posting later after runtime testing and whatnot if you confirm
this sorts out your problem.

--=20
Mateusz Guzik <mjguzik gmail.com>

