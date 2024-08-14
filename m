Return-Path: <linux-fsdevel+bounces-25944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D8B9521D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A601C220A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 18:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B571BE232;
	Wed, 14 Aug 2024 18:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdNbvxa+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7433D1BDAAC
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 18:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658820; cv=none; b=I1QCvc0jvzW6hfVKFCqFuXMjSpr4v/Uf0yJBcdR3NfVbBtQszkaeCR03GPvfHZbqUGnDPbhGV8sPR8N5pazEQ38SFjSwLlSQzyQ2pnPVdMHNCHOE7UPehgz34ab+ABh9d6dTs6cU8L0yViipWFS/vkAZZMsIVN3fMVXxzSdUT8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658820; c=relaxed/simple;
	bh=hhQnGejS85oljjcKKoWKUmtO/cN7haSuShx1Vfv+uVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYVoHFsY/GdwBvpATvXTZfka3P7WUTME5EDDB8Ce76n2jynCsUzvK+RBU7z1cT8Gt5hgC5wwuYCCCSz6oPyjgZ8Dm16sY70c7hSymCLSOgO3YPUm3ISowcgDXI6+xl7roU+0hubUaBuinYDUAHditmabH6ueP+/D2SGE1sMetYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdNbvxa+; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-451a0b04f6bso733241cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2024 11:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723658817; x=1724263617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H0ahRmKwJYTlqK1rmFO0QO/5bggrvOevbBZ28EMQpo=;
        b=TdNbvxa+SzSeIc3LtSDYqXYiDMa1zLIa2qel+1Z2yWMj8Wia2JSTsW5CY9NshDT/o2
         3eIG1TCYT86Hf0tlPKv1XbsDlWyKzGosqVeFCb1+XSMWWNQFw8gUjHXnEM49CRlbioPD
         PAaGCSaj46bf0U/XB76Ui5cpd7Llt3fpHdGDpJjmq2TJSX/twae/mG/QBo2fP8L327WM
         0WDlVRlQkOVZsIJsYQh43guERRwFEzafq5MQIfqeVbJ1Q/0eafMt1DfjRXQHGfpNLBnZ
         WJI9lAxjhf6mp8xEJZ3VvnUjJYiKL8YV26CppkmvDbqsiibn012eedZvAaHzo5am/qCx
         z5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723658817; x=1724263617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+H0ahRmKwJYTlqK1rmFO0QO/5bggrvOevbBZ28EMQpo=;
        b=QzhJ29q4LKabh3tNdLupOgojCJ8hh34CH86pBMdu4cJX6k0Z/o3ntFsfc13meZoSi+
         1Zm5zUd5s8n5Ld21hB7VKRLF5vPsrGN+9HfjGIwxRdapgUFhnYTGa0a2tVW2nxNe98NC
         N0TiSNievWeCqw30XtckXbEqvWAj1CvKcr4V17dozSfcd7ChacCl1SLtqSv1GF/Z4rL3
         0+0VwWTFUtsMXTaJ/Tnu/37v6/K34LWdahSzUqbVmtDper8ued6cpjqwpxhEl0xVKolv
         HU+Joi6Tqbpjp6YpNhcwfDlSN0H9IFPh6eUChrhoXTuNLCLWbfAodZbKrCag/2o6Wmil
         iOJw==
X-Forwarded-Encrypted: i=1; AJvYcCXrYq5oYetkfmri+9o8GEH3KOm4ZUhJUvNC7SFB9yX0xbXHIslZQLi/8orhPpaIDJWdBJ+axXgBUZ6NED+LZSmfF46Ssa+XJGHYI2ocMw==
X-Gm-Message-State: AOJu0YxXJIoLTZJ9kS/KxcFYTxdso/RDnlA9CFMjZftP138Edy9f/3br
	dQ0L7XjSPXp4HI/gAzS1bjkRPgJs8WYEiYHuqWQKDX1eNjGE+5602mIa5gUCce4GGM4p+tRdKMU
	xZSHypsAOb5MhTB6JibDJR+IPoMY=
X-Google-Smtp-Source: AGHT+IG9UxoUFkci4IXgWfhDED1XKEdAjvUAAPWlQyfSE5GCYdyEtUNZayMy64CxLeXLqzsBPNI+npVm+SQNuqFddY4=
X-Received: by 2002:ac8:70c:0:b0:453:5c20:90b7 with SMTP id
 d75a77b69052e-4535c2091eemr31221251cf.0.1723658817135; Wed, 14 Aug 2024
 11:06:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
 <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm> <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
 <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm> <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
 <9941c561-b358-4058-8797-3e8081b019dc@fastmail.fm>
In-Reply-To: <9941c561-b358-4058-8797-3e8081b019dc@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 Aug 2024 11:06:46 -0700
Message-ID: <CAJnrk1a3EFerySC+eEkfLdeo9fe8bqccOqcFK_S547aoLVWUEw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com, 
	Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:52=E2=80=AFAM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/14/24 19:18, Joanne Koong wrote:
> > On Tue, Aug 13, 2024 at 3:41=E2=80=AFPM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >> On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong@g=
mail.com> wrote:
> >>> On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Bernd Schubert
> >>> <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> On 8/13/24 23:21, Joanne Koong wrote:
> >>>>> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> >>>>> fetched from the server after an open.
> >>>>>
> >>>>> For fuse servers that are backed by network filesystems, this is
> >>>>> needed to ensure that file attributes are up to date between
> >>>>> consecutive open calls.
> >>>>>
> >>>>> For example, if there is a file that is opened on two fuse mounts,
> >>>>> in the following scenario:
> >>>>>
> >>>>> on mount A, open file.txt w/ O_APPEND, write "hi", close file
> >>>>> on mount B, open file.txt w/ O_APPEND, write "world", close file
> >>>>> on mount A, open file.txt w/ O_APPEND, write "123", close file
> >>>>>
> >>>>> when the file is reopened on mount A, the file inode contains the o=
ld
> >>>>> size and the last append will overwrite the data that was written w=
hen
> >>>>> the file was opened/written on mount B.
> >>>>>
> >>>>> (This corruption can be reproduced on the example libfuse passthrou=
gh_hp
> >>>>> server with writeback caching disabled and nopassthrough)
> >>>>>
> >>>>> Having this flag as an option enables parity with NFS's close-to-op=
en
> >>>>> consistency.
> >>>>>
> >>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>> ---
> >>>>>  fs/fuse/file.c            | 7 ++++++-
> >>>>>  include/uapi/linux/fuse.h | 7 ++++++-
> >>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>>>> index f39456c65ed7..437487ce413d 100644
> >>>>> --- a/fs/fuse/file.c
> >>>>> +++ b/fs/fuse/file.c
> >>>>> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, stru=
ct file *file)
> >>>>>       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> >>>>>       if (!err) {
> >>>>>               ff =3D file->private_data;
> >>>>> -             err =3D fuse_finish_open(inode, file);
> >>>>> +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
> >>>>> +                     fuse_invalidate_attr(inode);
> >>>>> +                     err =3D fuse_update_attributes(inode, file, S=
TATX_BASIC_STATS);
> >>>>> +             }
> >>>>> +             if (!err)
> >>>>> +                     err =3D fuse_finish_open(inode, file);
> >>>>>               if (err)
> >>>>>                       fuse_sync_release(fi, ff, file->f_flags);
> >>>>>               else if (is_truncate)
> >>>>
> >>>> I didn't come to it yet, but I actually wanted to update Dharmendras=
/my
> >>>> atomic open patches - giving up all the vfs changes (for now) and th=
en
> >>>> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. =
And
> >>>> then update attributes through that.
> >>>> Would that be an alternative for you? Would basically require to add=
 an
> >>>> atomic_open method into your file system.
> >>>>
> >>>> Definitely more complex than your solution, but avoids a another
> >>>> kernel/userspace transition.
> >>>
> >>> Hi Bernd,
> >>>
> >>> Unfortunately I don't think this is an alternative for my use case. I
> >>> haven't looked closely at the implementation details of your atomic
> >>> open patchset yet but if I'm understanding the gist of it correctly,
> >>> it bundles the lookup with the open into 1 request, where the
> >>> attributes can be passed from server -> kernel through the reply to
> >>> that request. I think in the case I'm working on, the file open call
> >>> does not require a lookup so it can't take advantage of your feature.
> >>> I just tested it on libfuse on the passthrough_hp server (with no
> >>> writeback caching and nopassthrough) on the example in the commit
> >>> message and I'm not seeing any lookup request being sent for that las=
t
> >>> open call (for writing "123").
> >>>
> >>
> >>
> >> Hi Joanne,
> >>
> >> gets late here and I'm typing on my phone.  I hope formatting is ok.
> >>
> >> what I meant is that we use the atomic open op code for both, lookup-o=
pen and plain open - i.e. we always update attributes on open. Past atomic =
open patches did not do that yet, but I later realized that always using at=
omic open op
> >>
> >> - avoids the data corruption you run into
> >> - probably no need for atomic-revalidate-open vfs patches anymore  as =
we can now safely set a high attr timeout
> >>
> >>
> >> Kind of the same as your patch, just through a new op code.
> >
> > Awesome, thanks for the context Bernd. I think this works for our use
> > case then. To confirm the "we will always update attributes on open"
> > part, this will only send the FUSE_GETATTR request to the server if
> > the server has invalidated the inode (eg through the
> > fuse_lowlevel_notify_inval_inode() api), otherwise this will not send
> > an extra FUSE_GETATTR request, correct? Other than the attribute
>
> If we send FUSE_OPEN_ATOMIC (or whatever we name it) in
> fuse_file_open(), it would always ask server side for attributes.

Oh I see, the FUSE_OPEN_ATOMIC request itself would ask for attributes
and the attributes would be sent by the server as the reply to the
FUSE_ATOMIC_OPEN. This sounds great! in my patch, there's an
additional FUSE_GETATTR request incurred to get the attributes.

> I.e. we assume that a server that has atomic open implemented can easily
> provide attributes or asks for close-to-open coherency.
>
>
> I'm not sure if I correctly understood your questions about
> notifications and FUSE_GETATTR - from my point of view that that is
> entirely independent from open. And personally I try to reduce

I missed that the attributes would be bundled with FUSE_OPEN_ATOMIC so
I thought we would need an additional FUSE_GETATTR request to get
them. Apologies for the confusion!

> kernel/userspace transitions - additional notifications and FUSE_GETATTR
> are not helpful here :)
>
> > updating, would there be any other differences from using plain open
> > vs the atomic open version of plain open?
>
> Just the additional file attributes and complexity that brings.
>
> >
> > Do you have a tentative timeline in mind for when the next iteration
> > of the atomic open patchset would be out?
>
> I wanted to have new fuse-uring patches ready by last week, but I'm
> still refactoring things - changing things on top of the existing series
> is easy, rebasing it is painful...  I can _try_ to make a raw new
> atomic-open patch set during the next days (till Sunday), but not promise=
d.
>

Sounds great. thanks for your work on this!

>
> Thanks,
> Bernd

