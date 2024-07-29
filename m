Return-Path: <linux-fsdevel+bounces-24423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718893F3A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A08A1F22207
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD19E1459FE;
	Mon, 29 Jul 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CV76ooek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A7314535A;
	Mon, 29 Jul 2024 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722251204; cv=none; b=EZ9vxj6Pyv4PyLRfScN4pM7tm9wVy/cZEyQbkbOX89G0dKa6y4BAtxqwUx33IQn4dwAMjQlBKEZYp7s/ccIWw5KcB9jtTabhcnW25nq1mZf5tA+W+MGa4o9ycvpJHpdL4vIPE4B1eR+ox5cO6rcqxXRsBUaK44fM2OLNUxX4nkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722251204; c=relaxed/simple;
	bh=naURJxVNf1JPQm7zih37QRBFiqtso9MuGSK5PWNmydE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+b3dCYn7uokTMBGgDDvk6pcRMPG+mapxIp0XTfyjnfCxCjVmy5z5kEi1oj/ITeaKQOTEGvU6mpaWI8QTiMZTxJhxznZbvfNG90oTeS+syrRLU2JypENQzrobxUQhMV260A+ynX73hj1yMhsHh8E7eZ/WWo5YUBbwbhGAFIK4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CV76ooek; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efaae7edfso3643027e87.2;
        Mon, 29 Jul 2024 04:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722251200; x=1722856000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvDRYsbj1x+58XwX6lTzO6a7ZyJ1v5LFG1X/F+WEr74=;
        b=CV76ooekYg6KDXBqxYdJKebObuHXB+hwyqSFxLiZ1QlpuIfAbH/B9I5TsfhHf2aqdj
         b/OBeXIkOlmtc1M/P5SStqal8PempNDzsXR73w335UQJeHbGpMMRtrVZ9rD/j5BTsXiJ
         wdWHbhVwMbXBTDMT9r6mP0sGXlWJuOJ1bOUONGVPrTkwGZaCk8sZMzNx7poenu9Utjid
         gYUvG0ZKU3bR0GWdWkZ7ljKqZzCJxJB4A9w5/QC8q+byf3tAcHVN+a6KRV6MYtPrXDbb
         AUV20Avbx53NAyVbjDbSPcPhXXiXe5RxySAN59mm2XJ8/3tG2rZckQotdhWH96iAEUvZ
         AmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722251200; x=1722856000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AvDRYsbj1x+58XwX6lTzO6a7ZyJ1v5LFG1X/F+WEr74=;
        b=CEUSNUD/KN1rNz+MJ2oTIg8RITrhZrvUqc32lQmhmPVEHXpR2111GITy038CKTBePG
         sPgcPSeFgKdmis4sb/AfT2AogJ3VKpRz1ApewRMoHlJdVqpBmEdK2C3TQPIQyaL4LPP3
         MrVGF6rYO7v313kqs5VXD1TDH7agJEJHveiY7n1NFpvtnO4Nb+qqybwwJkS66on1f0Hi
         NSms0B0vEV5k6IGQ5RXOoi8+odUt7RF6i+J5tZudlfAm+oTyXLWDaTEObiupp871sed3
         UKQGY7p0HGbSMYoltJ1jJNDWe4QFtk7XXcHf4+NlpzJKeLagqjXZISyOjPhcguMmvp6j
         tx1A==
X-Forwarded-Encrypted: i=1; AJvYcCXHcY035v0ECgMThlzQXWuqsVp9N5qxqPE4Y0WjVydy5XjtSTYCeAQDMJzLYW9Wda5J5vfnj2KPEWBKdzQbCQFet3ES89o808gtPRzgFFC2KvpTbvwkcWJ8p0vkogyI6NEnKsckvCVv
X-Gm-Message-State: AOJu0YxWPIzmTkFfhYkbwSV0oz7F3FgDY4T6I+gvMJNEE8w9MK5RlTZj
	7jJimS5QYJyDa88sb/PdSVK04szjNvzYMZpEJvdiQ1Xrp+DJMKWRGeXeUA/JGnAgkvhE1VihNmR
	TWIvQg/pAihZYRn1FQTx/dXhEDHk=
X-Google-Smtp-Source: AGHT+IGCWTYzZAGY/mLYNDYY9b7pAkT985MLe4E4aDNJTBmg8tmkUhUdRP6WWZ+vqSeT5KkxCsQPT4BATExP+T/fyh8=
X-Received: by 2002:ac2:568e:0:b0:52c:dcea:86e2 with SMTP id
 2adb3069b0e04-5309b269906mr5968577e87.1.1722251200252; Mon, 29 Jul 2024
 04:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874j88sn4d.fsf@oldenburg.str.redhat.com> <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com> <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87sevspit1.fsf@oldenburg.str.redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 29 Jul 2024 13:06:28 +0200
Message-ID: <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
Subject: Re: Testing if two open descriptors refer to the same inode
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat.com=
> wrote:
>
> * Mateusz Guzik:
>
> > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> >> * Mateusz Guzik:
> >>
> >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> >> >> It was pointed out to me that inode numbers on Linux are no longer
> >> >> expected to be unique per file system, even for local file systems.
> >> >
> >> > I don't know if I'm parsing this correctly.
> >> >
> >> > Are you claiming on-disk inode numbers are not guaranteed unique per
> >> > filesystem? It sounds like utter breakage, with capital 'f'.
> >>
> >> Yes, POSIX semantics and traditional Linux semantics for POSIX-like
> >> local file systems are different.
> >
> > Can you link me some threads about this?
>
> Sorry, it was an internal thread.  It's supposed to be common knowledge
> among Linux file system developers.  Aleksa referenced LSF/MM
> discussions.
>

So much for open development :-P

> > I had this in mind (untested modulo compilation):
> >
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 300e5d9ad913..5723c3e82eac 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file *fil=
p)
> >       return f.file =3D=3D filp;
> >  }
> >
> > +static long f_dupfd_query_inode(int fd, struct file *filp)
> > +{
> > +     CLASS(fd_raw, f)(fd);
> > +
> > +     return f.file->f_inode =3D=3D filp->f_inode;
> > +}
> > +
> >  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> >               struct file *filp)
> >  {
> > @@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsi=
gned long arg,
> >       case F_DUPFD_QUERY:
> >               err =3D f_dupfd_query(argi, filp);
> >               break;
> > +     case F_DUPFD_QUERY_INODE:
> > +             err =3D f_dupfd_query_inode(argi, filp);
> > +             break;
> >       case F_GETFD:
> >               err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> >               break;
> > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
> > index c0bcc185fa48..2e93dbdd8fd2 100644
> > --- a/include/uapi/linux/fcntl.h
> > +++ b/include/uapi/linux/fcntl.h
> > @@ -16,6 +16,8 @@
> >
> >  #define F_DUPFD_QUERY        (F_LINUX_SPECIFIC_BASE + 3)
> >
> > +#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
> > +
> >  /*
> >   * Cancel a blocking posix lock; internal use only until we expose an
> >   * asynchronous lock api to userspace:
>
> It's certainly much easier to use than name_to_handle_at, so it looks
> like a useful option to have.
>
> Could we return a three-way comparison result for sorting?  Or would
> that expose too much about kernel pointer values?
>

As is this would sort by inode *address* which I don't believe is of
any use -- the order has to be assumed arbitrary.

Perhaps there is something which is reliably the same and can be
combined with something else to be unique system-wide (the magic
handle thing?).

But even then you would need to justify trying to sort by fcntl calls,
which sounds pretty dodgey to me.

Given that thing I *suspect* statx() may want to get extended with
some guaranteed unique identifier. Then you can sort in userspace all
you want.

Based on your opening mail I assumed you only need to check 2 files,
for which the proposed fcntl does the trick.

Or to put it differently: there seems to be more to the picture than
in the opening mail, so perhaps you could outline what you are looking
for.

--=20
Mateusz Guzik <mjguzik gmail.com>

