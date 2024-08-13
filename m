Return-Path: <linux-fsdevel+bounces-25826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73238950F65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 23:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23782283C6C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523731AAE11;
	Tue, 13 Aug 2024 21:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsjkIivt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B061E498
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723586278; cv=none; b=sndg48RWzQNe0GEDpkbd6g5HYEVPdy/Jc7U9SNUQHfutIM2Q+TjctcryfCeF8D/74vVgs7RN71IYRYmR4ugbcLakJWXJjXzxHvQv0UxpNsgu1rBQPmF7t1iC0mwaVK/LcQ2turnmAlWr5ldKuQNb4PSu4YOS8ONQ6iOnJPc4O58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723586278; c=relaxed/simple;
	bh=IJ2c8woO/1+7VurSpAq1s4Pafk37I2h9o4knJk5RtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O60GswoNmmgkKlbdQpSYQK5WhMM6TokqueRNu+CWwZGBlHFr72lMArMmJ7fxHFpnmYdP/TMVrbTTazUENPYxvzVw9N21y/DFHDfDte3wVir2cUriAKVtv2SQa2U7VWijcv1UK/aFaROlpzJc6xl0mIT9wmPoZ/+rfTCjoe0gtSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsjkIivt; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70936061d0dso3514186a34.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Aug 2024 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723586276; x=1724191076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfpHAOq0kW+XRSrPvoXhMQ9TO04R0mhjQpW03DKdMrU=;
        b=PsjkIivtqPmVESoKhRqVR97lh11oLzwK+7V5AhbBeCuxwEtHxiEoVeQmz98LrfDt6x
         +hPuzQkJPsXwdlni7Nu4E6/L9IclPyELFXg4ustOGNEERE2/W8MMFuo58u71WcIq421T
         Hwc52x41xA/+VhdoOhOlacPgINi9P/v75sRM2A+LRPaBNwfo9tukiTq59Eg1OXn9DPgJ
         whcnIjDbaBpdO870qA3XPZB29GAftB06jWoGLvpBHz2GLeXZTqmGUo73bamVbas0eMzm
         vgMlCQluka3fdKgAClvv3Xzj36tJ5oFcd9HcDCzmFo9gje/sYRhYfLwKQePDK0m0YiAh
         11Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723586276; x=1724191076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfpHAOq0kW+XRSrPvoXhMQ9TO04R0mhjQpW03DKdMrU=;
        b=ckd2gO5IbxTsxo9TZBvt+mHi2IBKLIUPdJ0ZTuZlbOAm3Q1h6AaDpRwaYUgS35FU5e
         m6QF6toXTjJtjJymTe/gatv7f3/i6pprFkuT3UdntN03EV+JIWYgc1SfO7tFRHFxaFt3
         6U6zTngDxmPYlCYwGpK2QW5FRdz2P4PrTd35RXYXgWv2lXYJIO3JgAoUs7WDqAMsINXl
         jfdht9GGfNkq6KAJEI0lZ6Okk1h07XFqj6abw4swiDw5PWQVyTELcG5h9aIT/FGFxOPO
         re222FGTuiApG2gWPhBzCE7Nw9kkWPHfZehDXawlL1GVACbrDRPUl0n70NCEQ3FpmdRR
         SaNA==
X-Forwarded-Encrypted: i=1; AJvYcCV1E5oIwlTJb4HAVoF+z4kCoNOjSM1826zCudlZ9DAmkJxMfYbX5DEHRpjJ9kXyq3o1M+zgOym76fsyo2RBSYGBzzTBdapiacFfP6lRdA==
X-Gm-Message-State: AOJu0YwGVe0KJzYBmBMKs+jYYnMHGqUU7A/BNHR84217bM08+fKRI55m
	ktEzUKqy8hbObxdqfrQb1xIiK1jBAdl9BipvdbnuTG26YAol4Jj0RZxrxfRyJK6Xo1S0y/MV1u+
	wL5hvRxrm9EIjLxGaeNs7/qC73O4=
X-Google-Smtp-Source: AGHT+IGG5G28Pu6PO1R1vL748LpbWi8keVtA64WoRJctQatIRDGQRIEwNSeE5tVN+xXANQvh0nTBtvJauE1pCmrnkWg=
X-Received: by 2002:a05:6830:2589:b0:709:3df3:7ed8 with SMTP id
 46e09a7af769-70c9d94bb19mr1122545a34.13.1723586275620; Tue, 13 Aug 2024
 14:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com> <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm>
In-Reply-To: <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 Aug 2024 14:57:44 -0700
Message-ID: <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com, 
	Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
> On 8/13/24 23:21, Joanne Koong wrote:
> > Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> > fetched from the server after an open.
> >
> > For fuse servers that are backed by network filesystems, this is
> > needed to ensure that file attributes are up to date between
> > consecutive open calls.
> >
> > For example, if there is a file that is opened on two fuse mounts,
> > in the following scenario:
> >
> > on mount A, open file.txt w/ O_APPEND, write "hi", close file
> > on mount B, open file.txt w/ O_APPEND, write "world", close file
> > on mount A, open file.txt w/ O_APPEND, write "123", close file
> >
> > when the file is reopened on mount A, the file inode contains the old
> > size and the last append will overwrite the data that was written when
> > the file was opened/written on mount B.
> >
> > (This corruption can be reproduced on the example libfuse passthrough_h=
p
> > server with writeback caching disabled and nopassthrough)
> >
> > Having this flag as an option enables parity with NFS's close-to-open
> > consistency.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/file.c            | 7 ++++++-
> >  include/uapi/linux/fuse.h | 7 ++++++-
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index f39456c65ed7..437487ce413d 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, struct f=
ile *file)
> >       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> >       if (!err) {
> >               ff =3D file->private_data;
> > -             err =3D fuse_finish_open(inode, file);
> > +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
> > +                     fuse_invalidate_attr(inode);
> > +                     err =3D fuse_update_attributes(inode, file, STATX=
_BASIC_STATS);
> > +             }
> > +             if (!err)
> > +                     err =3D fuse_finish_open(inode, file);
> >               if (err)
> >                       fuse_sync_release(fi, ff, file->f_flags);
> >               else if (is_truncate)
>
> I didn't come to it yet, but I actually wanted to update Dharmendras/my
> atomic open patches - giving up all the vfs changes (for now) and then
> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE. And
> then update attributes through that.
> Would that be an alternative for you? Would basically require to add an
> atomic_open method into your file system.
>
> Definitely more complex than your solution, but avoids a another
> kernel/userspace transition.

Hi Bernd,

Unfortunately I don't think this is an alternative for my use case. I
haven't looked closely at the implementation details of your atomic
open patchset yet but if I'm understanding the gist of it correctly,
it bundles the lookup with the open into 1 request, where the
attributes can be passed from server -> kernel through the reply to
that request. I think in the case I'm working on, the file open call
does not require a lookup so it can't take advantage of your feature.
I just tested it on libfuse on the passthrough_hp server (with no
writeback caching and nopassthrough) on the example in the commit
message and I'm not seeing any lookup request being sent for that last
open call (for writing "123").

Thanks,
Joanne

>
> Thanks,
> Bernd

