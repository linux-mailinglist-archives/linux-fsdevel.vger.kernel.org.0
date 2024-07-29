Return-Path: <linux-fsdevel+bounces-24442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC79B93F4EE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 14:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8662828FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 12:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40F3146D71;
	Mon, 29 Jul 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAY1oBVy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D17080034;
	Mon, 29 Jul 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255153; cv=none; b=FOlFh0wIjURgrevBRZPzWHQuFgxVO8cPJKfUfKaSPDYqu1YjD26AbzjWK323WqMcHpP+qVU4ZiBYxxrQF/fLc4IxyhbYXKoM/9iVmBW+LGMiOuHTvNxnbehag0LENUbe28NIiZ3x8sGpbPnu/MHQA1h9bJQ6kgDBdmc6Y5ooDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255153; c=relaxed/simple;
	bh=676pxmrdMG379dy9Banv9LMk0s/zvJkHYmSuRMT0izY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qO24dA6WO2n2DAsTBd9UebvmMjKzNrsXEOLCdnSKUK1UOvgtrip6Md+lsydXT6cgx8uAsUqmqh+vx8rYeqjP6gQbbF1oZDXHFO39c/qIniv+LpLNTHITwF/m/pcHVcSNMB+CuAnOElj16GfYfrMLplUDr2ozMywdtZepM7sRNvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAY1oBVy; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so394480066b.1;
        Mon, 29 Jul 2024 05:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722255149; x=1722859949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHUHE5omJDhLqkutfEXF8xChoXoFAMjo0TECDsNJhK0=;
        b=KAY1oBVyjfBtbvWzgoM3zLSFfAtt9cmtRI4XbpW5dtAst/a+XHODX6j3Aw6e5+q0Mf
         L8xxSiBk6c7nX7kJwO/YUkVqPGrlq8nymV50yLxYXTGA6O0jClcS97mqQlEm7rGze52F
         +cjG/5fIPvahycKHZuUe516Ni3im3HOKZJnqEF4DZ22qHKzV7l3wpEhtuY+31UmrHR+B
         D44Vh5cxadxKY+xnoZ3oihY4SlMUhX2lRLHpBWAkvaw6tBGFhSv087oUq/sIjYCEHFUJ
         e1nfz4/fMbKWt9nB1ZjpG72yLGxQR47wAHgwnciyEIMNvXnWoP0eDHSjDJzSUmvSljLF
         bFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722255149; x=1722859949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHUHE5omJDhLqkutfEXF8xChoXoFAMjo0TECDsNJhK0=;
        b=Cb1yhirT5HNTN8JbgSr3ys5xi23qH4HociW4W0IBd9zUZsd0UhiWO6T4qCYNSvjW1g
         7qwjqA/j9xFYqqdrSh+HU5AdBoOI3x/5BIh7eF2L2sxl+nHOWemSKaX9oZ6J78UFTbly
         TXERdAByiwkaMYsJ3anOaXND8dzZaisuHMYT1Z+nrcC9FHFOO/xKkPgEvky1Xz/2ciMu
         SrDbWSJaE4pnwSO53+FCj/AhApmLe70SjiXKcegi4XH1vFMp8G7ZEh5c9GL1qRYBWwcT
         /pnhCvBIDKX/yuPwjAGx5PqHRu9Fzax07o3ceQnctjUZB/Lx3LfbVFLZcN8TxFPg9wHW
         oWKw==
X-Forwarded-Encrypted: i=1; AJvYcCXCI6Pt4PBvgN4AeOcLYWGznUDnbt9dkYw97G66piB9V/LDB1wbYOTmhG6XPx18yqV6StpIv2MbCJFlqFWAHaiNmQS4ZqdkU26cuV4qmlR4PPjINk4/Vfrxhmjf7pvikSVRGNnj9NaIpZcSKvjv9+BBRXwo8S4XpNSFHAQMYYRmJvzt26qGHw==
X-Gm-Message-State: AOJu0YxsZsp5o4m0AIchmwoEX6m974vRUStgIOT2wGhicqFVLiosEhmf
	yD8M/Bd6zDBXr0pQ/0VHvCys7e7ot1bkYgI7xWzTO3flWk6K81iLOn+r4rVVNQCxGewvBF0e0Wa
	iLTmTYBc39PPgz2AEOmPlwYsnqLI=
X-Google-Smtp-Source: AGHT+IF3qWMnouMsh8zKfGd7dmW+6bIUeyEBdwqvkO5x/YzUnTyGD7rh3Ma8NXLNR8uTYTkJVh6YOqj62cIBbt5nXyw=
X-Received: by 2002:a17:906:d551:b0:a75:2781:a5c4 with SMTP id
 a640c23a62f3a-a7d3ffedb21mr605346666b.29.1722255148508; Mon, 29 Jul 2024
 05:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <874j88sn4d.fsf@oldenburg.str.redhat.com> <ghqndyn4x7ujxvybbwet5vxiahus4zey6nkfsv6he3d4en6ehu@bq5s23lstzor>
 <875xsoqy58.fsf@oldenburg.str.redhat.com> <vmjtzzz7sxctmf7qrf6mw5hdd653elsi423joiiusahei22bft@quvxy4kajtxt>
 <87sevspit1.fsf@oldenburg.str.redhat.com> <CAGudoHEBNRE+78n=WEY=Z0ZCnLmDFadisR-K2ah4SUO6uSm4TA@mail.gmail.com>
 <20240729.114221-bumpy.fronds.spare.forts-a2tVepJTDtVb@cyphar.com>
In-Reply-To: <20240729.114221-bumpy.fronds.spare.forts-a2tVepJTDtVb@cyphar.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 29 Jul 2024 14:12:15 +0200
Message-ID: <CAGudoHFQ9TtG-5__38-ND4KTxYCpEKVv_X9HhZixcdnVMUBEwQ@mail.gmail.com>
Subject: Re: Testing if two open descriptors refer to the same inode
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Florian Weimer <fweimer@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	Dave Chinner <dchinner@redhat.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 1:47=E2=80=AFPM Aleksa Sarai <cyphar@cyphar.com> wr=
ote:
>
> On 2024-07-29, Mateusz Guzik <mjguzik@gmail.com> wrote:
> > On Mon, Jul 29, 2024 at 12:57=E2=80=AFPM Florian Weimer <fweimer@redhat=
.com> wrote:
> > >
> > > * Mateusz Guzik:
> > >
> > > > On Mon, Jul 29, 2024 at 12:40:35PM +0200, Florian Weimer wrote:
> > > >> * Mateusz Guzik:
> > > >>
> > > >> > On Mon, Jul 29, 2024 at 08:55:46AM +0200, Florian Weimer wrote:
> > > >> >> It was pointed out to me that inode numbers on Linux are no lon=
ger
> > > >> >> expected to be unique per file system, even for local file syst=
ems.
> > > >> >
> > > >> > I don't know if I'm parsing this correctly.
> > > >> >
> > > >> > Are you claiming on-disk inode numbers are not guaranteed unique=
 per
> > > >> > filesystem? It sounds like utter breakage, with capital 'f'.
> > > >>
> > > >> Yes, POSIX semantics and traditional Linux semantics for POSIX-lik=
e
> > > >> local file systems are different.
> > > >
> > > > Can you link me some threads about this?
> > >
> > > Sorry, it was an internal thread.  It's supposed to be common knowled=
ge
> > > among Linux file system developers.  Aleksa referenced LSF/MM
> > > discussions.
> > >
> >
> > So much for open development :-P
> >
> > > > I had this in mind (untested modulo compilation):
> > > >
> > > > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > > > index 300e5d9ad913..5723c3e82eac 100644
> > > > --- a/fs/fcntl.c
> > > > +++ b/fs/fcntl.c
> > > > @@ -343,6 +343,13 @@ static long f_dupfd_query(int fd, struct file =
*filp)
> > > >       return f.file =3D=3D filp;
> > > >  }
> > > >
> > > > +static long f_dupfd_query_inode(int fd, struct file *filp)
> > > > +{
> > > > +     CLASS(fd_raw, f)(fd);
> > > > +
> > > > +     return f.file->f_inode =3D=3D filp->f_inode;
> > > > +}
> > > > +
> > > >  static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
> > > >               struct file *filp)
> > > >  {
> > > > @@ -361,6 +368,9 @@ static long do_fcntl(int fd, unsigned int cmd, =
unsigned long arg,
> > > >       case F_DUPFD_QUERY:
> > > >               err =3D f_dupfd_query(argi, filp);
> > > >               break;
> > > > +     case F_DUPFD_QUERY_INODE:
> > > > +             err =3D f_dupfd_query_inode(argi, filp);
> > > > +             break;
> > > >       case F_GETFD:
> > > >               err =3D get_close_on_exec(fd) ? FD_CLOEXEC : 0;
> > > >               break;
> > > > diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.=
h
> > > > index c0bcc185fa48..2e93dbdd8fd2 100644
> > > > --- a/include/uapi/linux/fcntl.h
> > > > +++ b/include/uapi/linux/fcntl.h
> > > > @@ -16,6 +16,8 @@
> > > >
> > > >  #define F_DUPFD_QUERY        (F_LINUX_SPECIFIC_BASE + 3)
> > > >
> > > > +#define F_DUPFD_QUERY_INODE (F_LINUX_SPECIFIC_BASE + 4)
> > > > +
> > > >  /*
> > > >   * Cancel a blocking posix lock; internal use only until we expose=
 an
> > > >   * asynchronous lock api to userspace:
> > >
> > > It's certainly much easier to use than name_to_handle_at, so it looks
> > > like a useful option to have.
> > >
> > > Could we return a three-way comparison result for sorting?  Or would
> > > that expose too much about kernel pointer values?
> > >
> >
> > As is this would sort by inode *address* which I don't believe is of
> > any use -- the order has to be assumed arbitrary.
> >
> > Perhaps there is something which is reliably the same and can be
> > combined with something else to be unique system-wide (the magic
> > handle thing?).
> >
> > But even then you would need to justify trying to sort by fcntl calls,
> > which sounds pretty dodgey to me.
>
> Programs need to key things by (dev, ino) currently, so you need to be
> able to get some kind of ordinal that you can sort with.
>

That I know, except normally that's done by sorting by (f)stat results.

> If we really want to make an interface to let you do this without
> exposing hashes in statx, then kcmp(2) makes more sense, but having to
> keep a file descriptor for each entry in a hashtable would obviously
> cause -EMFILE issues.
>

Agreed, hence the proposal to extend statx.

> > Given that thing I *suspect* statx() may want to get extended with
> > some guaranteed unique identifier. Then you can sort in userspace all
> > you want.
>
> Yeah, this is what the hashed fhandle patch I have does.
>

Ok, I see your other e-mail.

> > Based on your opening mail I assumed you only need to check 2 files,
> > for which the proposed fcntl does the trick.
> >
> > Or to put it differently: there seems to be more to the picture than
> > in the opening mail, so perhaps you could outline what you are looking
> > for.
>
> Hardlink detection requires creating a hashmap of (dev, ino) to find
> hardlinks. Pair-wise checking is not sufficient for that usecase (which
> AFAIK is the most common thing people use inode numbers for -- it's at
> least probably the most common thing people run in practice since
> archive tools do this.)
>

So if you have *numerous* files to check then indeed the fcntl is no
good, but the sorting variant is no good either -- you don't know what
key to look stuff up by since you don't know any of the addresses
(obfuscated or otherwise).

There needs to be a dev + ino replacement which retains the property
of being reliable between reboots and so on.

Since you said you have a patchset which exports something in statx,
chances are this is sorted out -- I'm gong to wait for that, meanwhile
I'm not going to submit my fcntl anywhere -- hopefuly it will be
avoided. :)
--
Mateusz Guzik <mjguzik gmail.com>

