Return-Path: <linux-fsdevel+bounces-25940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944589520EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2628B9EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2B51BBBEA;
	Wed, 14 Aug 2024 17:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyiH5hge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB616BE14
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723655899; cv=none; b=SE1RlqNJfOKdZoNK6kohhJbuzHC5sGFXZ9vOtsmxF7dHwdYc7/6xfk37CGIhKlJiwO3AiZGvKWf4ifmBly7+cxfoCEeTxXsQevYdvbIEEaJZCDjL0IUnrWOAMCuNp9ij3xAJhnnAOSelICJ6QMWXPqwMYsuXrw8dDIQnpeT290c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723655899; c=relaxed/simple;
	bh=H3kWyh8UNKeZU92NRAzU1EtC537XHnnRFwXCDoM3Dck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yt1TysPpyyLKGbnB4iapUNPWJLc6+/frpN3NPF4rGFLQi0lSaP9IxrAJ+okjI4PekxpXJ0vMiYNyapRTZrVyCgQcmWQbQZljzU3qXeNRlUKAA4WAgPPeuIh4Y/VnOxso4V4886oQPnAPaYhEJAOS4Pu27pJOaOs+38pG/7y8zSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyiH5hge; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3dc16d00ba6so41833b6e.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723655897; x=1724260697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjObD5DcwAYFDWfI2qGqoQo65qq4ErKRhMs5/Efks/Q=;
        b=cyiH5hgemRxWnBcOsC+vey/CWPlRNza1diETclCRPVpZeSALviyK5488eEtg110JUu
         QX2QGSDuRmbrBvHL4r//GHp4tOj7AIDtCfjyFpVF5kDvSBkAiCbkJOza+hWUTf7DVKUs
         dPvWxLMwpAUF+5F/7FLJfYZw47CSo2FdDR6Dj5qJKRfrc6w0ofPSHj//7hYLvMHW4ouD
         TsrALDB1c9WsN/Mh0wmdl1k+ztGVwC3FTBaRIa6HMvnv0zlTbHgONoPmMuyT0MGdRzBP
         PRx7H3Tn7A6pHFIQtcIJ0ceOUKDrDxWoMSqEp5zs6JA4pH1SsR1bHdEZz64oHC5Bm3tI
         +m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723655897; x=1724260697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vjObD5DcwAYFDWfI2qGqoQo65qq4ErKRhMs5/Efks/Q=;
        b=cOtODhDflp8cilIhTRj+J7IAF/arHDQEd5G4ffQAJ6mDdU2U/0mfLi/Btl1tGIISCR
         VMJgahTbIK7QZTWFluiFZwYjwOtF1r1QGE1Tmch1KpniuqHKCM5YNZO/Gw5tPZSHKbaW
         7Xl7ly4bw5ck/uw+N0EmxbhoLDOYuLds7J82Dcf6JeOCXlupY4Z8CbSEXVBG4R0/c2sK
         gXgbFu1c13FT7fGU7j9caLJuJbyMzPGXJJvhVzB2LDu39TfuMs0r91jdOqNgfwD04/Gp
         6eFPJxFBe7YwpidpezEKt5FAYS3NURmAuLOr+lULrUdvVuommKk4/kNMsM2eW+5R32jK
         Dhmg==
X-Forwarded-Encrypted: i=1; AJvYcCVyjvS9yaOUWYe4yDKMJQs983tnTYORhsSyLuCFqYOiY3ft8nnCyn6EdCoA4EmLeNrd+qZkL02RSrrXmIgdeSolv/U4FKuOJsHA9HyTrA==
X-Gm-Message-State: AOJu0YzP5bR4JcLZlMAOoEGeNeLDh8QwU4sdWEav9EmyanpTWBMhgSv/
	EbThrNrxm0hzOGHWJBgSyXZVATYIK0PHxv0n1upsHdT215t/EgLnSrhAsWt5Sjj35YemswzC7iw
	FcK0ppXrpXWvLm+/c66ySkCjI4rZs+Gtk+C4=
X-Google-Smtp-Source: AGHT+IGQf4iyYTxpU9FtJW3H4ihA/jN+ujCqFGRbO4LTzbhHynBPwHk2PYH31LWkNT4pHvExYwTeiXO+Ci/X6hGjuvY=
X-Received: by 2002:a05:6808:4492:b0:3da:a793:f0df with SMTP id
 5614622812f47-3dd298def77mr3301889b6e.9.1723655896683; Wed, 14 Aug 2024
 10:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
 <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm> <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
 <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm>
In-Reply-To: <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Aug 2024 10:18:05 -0700
Message-ID: <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com, 
	Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 3:41=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Bernd Schubert
> ><bernd.schubert@fastmail.fm> wrote:
> >>
> >> On 8/13/24 23:21, Joanne Koong wrote:
> >> > Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> >> > fetched from the server after an open.
> >> >
> >> > For fuse servers that are backed by network filesystems, this is
> >> > needed to ensure that file attributes are up to date between
> >> > consecutive open calls.
> >> >
> >> > For example, if there is a file that is opened on two fuse mounts,
> >> > in the following scenario:
> >> >
> >> > on mount A, open file.txt w/ O_APPEND, write "hi", close file
> >> > on mount B, open file.txt w/ O_APPEND, write "world", close file
> >> > on mount A, open file.txt w/ O_APPEND, write "123", close file
> >> >
> >> > when the file is reopened on mount A, the file inode contains the ol=
d
> >> > size and the last append will overwrite the data that was written wh=
en
> >> > the file was opened/written on mount B.
> >> >
> >> > (This corruption can be reproduced on the example libfuse passthroug=
h_hp
> >> > server with writeback caching disabled and nopassthrough)
> >> >
> >> > Having this flag as an option enables parity with NFS's close-to-ope=
n
> >> > consistency.
> >> >
> >> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >> > ---
> >> >  fs/fuse/file.c            | 7 ++++++-
> >> >  include/uapi/linux/fuse.h | 7 ++++++-
> >> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >> > index f39456c65ed7..437487ce413d 100644
> >> > --- a/fs/fuse/file.c
> >> > +++ b/fs/fuse/file.c
> >> > @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struc=
t file *file)
> >> >       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> >> >       if (!err) {
> >> >               ff =3D file->private_data;
> >> > -             err =3D fuse_finish_open(inode, file);
> >> > +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
> >> > +                     fuse_invalidate_attr(inode);
> >> > +                     err =3D fuse_update_attributes(inode, file, ST=
ATX_BASIC_STATS);
> >> > +             }
> >> > +             if (!err)
> >> > +                     err =3D fuse_finish_open(inode, file);
> >> >               if (err)
> >> >                       fuse_sync_release(fi, ff, file->f_flags);
> >> >               else if (is_truncate)
> >>
> >> I didn't come to it yet, but I actually wanted to update Dharmendras/m=
y
> >> atomic open patches - giving up all the vfs changes (for now) and then
> >> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. An=
d
> >> then update attributes through that.
> >> Would that be an alternative for you? Would basically require to add a=
n
> >> atomic_open method into your file system.
> >>
> >> Definitely more complex than your solution, but avoids a another
> >> kernel/userspace transition.
> >
> >Hi Bernd,
> >
> >Unfortunately I don't think this is an alternative for my use case. I
> >haven't looked closely at the implementation details of your atomic
> >open patchset yet but if I'm understanding the gist of it correctly,
> >it bundles the lookup with the open into 1 request, where the
> >attributes can be passed from server -> kernel through the reply to
> >that request. I think in the case I'm working on, the file open call
> >does not require a lookup so it can't take advantage of your feature.
> >I just tested it on libfuse on the passthrough_hp server (with no
> >writeback caching and nopassthrough) on the example in the commit
> >message and I'm not seeing any lookup request being sent for that last
> >open call (for writing "123").
> >
>
>
> Hi Joanne,
>
> gets late here and I'm typing on my phone.  I hope formatting is ok.
>
> what I meant is that we use the atomic open op code for both, lookup-open=
 and plain open - i.e. we always update attributes on open. Past atomic ope=
n patches did not do that yet, but I later realized that always using atomi=
c open op
>
> - avoids the data corruption you run into
> - probably no need for atomic-revalidate-open vfs patches anymore  as we =
can now safely set a high attr timeout
>
>
> Kind of the same as your patch, just through a new op code.

Awesome, thanks for the context Bernd. I think this works for our use
case then. To confirm the "we will always update attributes on open"
part, this will only send the FUSE_GETATTR request to the server if
the server has invalidated the inode (eg through the
fuse_lowlevel_notify_inval_inode() api), otherwise this will not send
an extra FUSE_GETATTR request, correct? Other than the attribute
updating, would there be any other differences from using plain open
vs the atomic open version of plain open?

Do you have a tentative timeline in mind for when the next iteration
of the atomic open patchset would be out?

Thanks,
Joanne
>
> Thanks,
> Bernd
>

