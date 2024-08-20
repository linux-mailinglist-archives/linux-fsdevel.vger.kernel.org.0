Return-Path: <linux-fsdevel+bounces-26328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DE2957AD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 03:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34B9282D14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416F715AC4;
	Tue, 20 Aug 2024 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcY2nXev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1024E33FD
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 01:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116572; cv=none; b=BSjT1noV3gtE0kWCz3aUWqYKKZn5HtY5ramxjPwoKhCSYaN5O0Y5T2b4HUsiWPaSfHVHCgT1c9SVhrzMkaPOhkzypxByDcjOpSAJJnYJwpmLwsEUSQYtDt/ixgSTksY41nesqlwY+DrmcShBg/Btwc6/WG1/FhnHHs2IZAtgdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116572; c=relaxed/simple;
	bh=MZteRR5e9+iPj4SQUmcmLCD74reZp9VqX2Wvf7VTdF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wmr+M4nIX61zYrzt3Vby7djojKMJAvoDosnPQY4ma1gZ265lJYprg6CNKuJvCuSh2TdPRtxMeU0ey16EN7D0Cle578S3I3ELylWy1CWRz+JiPbRGhXGa4ppQhnlnZhp/pkIqZotxPeKgY8Glls0anH94/trPvnYLlPeIcY/twQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hcY2nXev; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3dd25b2c3f2so1994141b6e.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2024 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116570; x=1724721370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mSSV9m4E4HKVi+ckeXBwN8ufwuY8V3PAjjStmO/MSLA=;
        b=hcY2nXevU4creNLd0tOkbjvrv/Of6qGe51/4RWSbseSEVqneM7gn24kTcMDmv8Sndy
         vQ9w/avBiLdDNfLEe7Ju1YACZ7z3I0jucC4QNKAbfvNtZpM7awbEC2kbY5mw9I4vReWn
         Gd4zbl+nwPYfCw0onUKBZ5Ba7l45YZIjK0jd3ByndjfTLJLJ2YfVit3J4tMpQDLmDzff
         2lWuMDMflUWEaAGizRDp6VgiCLsn3gdoQEgqv0Wn0dFKPuQGRQWziX6J416J4IWbo4MD
         EWY3eF5UaVPiC9U1q/YeRru+YsvU3sSWfvlC01x46+pyBeaQKUxzmuHamTfzMw1HufKK
         fe2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116570; x=1724721370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mSSV9m4E4HKVi+ckeXBwN8ufwuY8V3PAjjStmO/MSLA=;
        b=gjzQYrgwMpYmfLgo87JJUIoKF0fO0L0WudqLyA0494oNzGPgCdP7dUOGpPPg1qS6DU
         JP7+rXqGjknF+l3rhjwUst9ygCskuyhFPw+5n4047g2rOBk0buWsGg40AUmMfqClQxhS
         axMpzFrLyS90hKRfttvUz1dhpKpc/vAyZRzLEc1cCOdS1pBXLodODEjiamjeuKWc+23I
         M6eqn6ZOt1ujDYa44391tG6XILCFwZdR/UM5fd26guBwGLPbvMAxQDl03vMrM3qMBqBm
         IAIch+9PzWuSys0rSUAAYBajtjWOKVhEK/UKltAG8efzcnuqH3Jj/e28P/j3doK3gSZj
         ArwA==
X-Forwarded-Encrypted: i=1; AJvYcCUh114hUymxzq8S8px8NZ06fd7UrVV/5WxqNJ7h8Bb+/F25MVXqL8S0XtazdIVQheUDSX2Mj9kvi56bc8i3@vger.kernel.org
X-Gm-Message-State: AOJu0YzEw+ZvWioCMAX1VfxdYgnO4zbTvjCbHT089tHlhSdspy3gkoaX
	DdcuBQQUeFpkVxTNFyx4TnTLljvERTN2nGsUj+LH38eAjW/uA6D7YgAPfQgc0KXH9z031gEdt9C
	0/hphiBYwdMpzZEhOL11qYT3EzIMlpg==
X-Google-Smtp-Source: AGHT+IEjBiVDp6rGZRg5CIcCURiRzGs43bMB2w/LVZXIBAuGd2dv7nndEFTp9i86JDV0MA/FDDQKHWqfCZ75qn0xUUk=
X-Received: by 2002:a05:6808:4492:b0:3d9:38e2:5392 with SMTP id
 5614622812f47-3dd3af641camr12293100b6e.36.1724116570152; Mon, 19 Aug 2024
 18:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813212149.1909627-1-joannelkoong@gmail.com>
 <4c37917a-9a64-4ea0-9437-d537158a8f40@fastmail.fm> <CAJnrk1aC-qUTb1e-n7O-wqrbUKMcq18tyE7LAxattdGU22NaPA@mail.gmail.com>
 <C23FB164-EB7A-436F-8C3F-533B00F67730@fastmail.fm> <CAJnrk1ZZ2eEcwYeXHmJxxMywQ8=iDkffvcJK8W8exA02vjrvUg@mail.gmail.com>
 <9941c561-b358-4058-8797-3e8081b019dc@fastmail.fm> <CAJnrk1a3EFerySC+eEkfLdeo9fe8bqccOqcFK_S547aoLVWUEw@mail.gmail.com>
 <e36998aa-3bb6-4d57-b29f-6bcdc586357b@fastmail.fm>
In-Reply-To: <e36998aa-3bb6-4d57-b29f-6bcdc586357b@fastmail.fm>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 19 Aug 2024 18:15:59 -0700
Message-ID: <CAJnrk1ZUJ7u+Qi_JMRooYdPY-3r__1bYZB0gGzQDmaXs155Jcw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_FETCH_ATTR flag for fetching attributes
 after open
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	osandov@osandov.com, sweettea-kernel@dorminy.me, kernel-team@meta.com, 
	Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 3:36=E2=80=AFPM Bernd Schubert
<bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 8/14/24 20:06, Joanne Koong wrote:
> > On Wed, Aug 14, 2024 at 10:52=E2=80=AFAM Bernd Schubert
> > <bernd.schubert@fastmail.fm> wrote:
> >>
> >>
> >>
> >> On 8/14/24 19:18, Joanne Koong wrote:
> >>> On Tue, Aug 13, 2024 at 3:41=E2=80=AFPM Bernd Schubert
> >>> <bernd.schubert@fastmail.fm> wrote:
> >>>>
> >>>> On August 13, 2024 11:57:44 PM GMT+02:00, Joanne Koong <joannelkoong=
@gmail.com> wrote:
> >>>>> On Tue, Aug 13, 2024 at 2:44=E2=80=AFPM Bernd Schubert
> >>>>> <bernd.schubert@fastmail.fm> wrote:
> >>>>>>
> >>>>>> On 8/13/24 23:21, Joanne Koong wrote:
> >>>>>>> Add FOPEN_FETCH_ATTR flag to indicate that attributes should be
> >>>>>>> fetched from the server after an open.
> >>>>>>>
> >>>>>>> For fuse servers that are backed by network filesystems, this is
> >>>>>>> needed to ensure that file attributes are up to date between
> >>>>>>> consecutive open calls.
> >>>>>>>
> >>>>>>> For example, if there is a file that is opened on two fuse mounts=
,
> >>>>>>> in the following scenario:
> >>>>>>>
> >>>>>>> on mount A, open file.txt w/ O_APPEND, write "hi", close file
> >>>>>>> on mount B, open file.txt w/ O_APPEND, write "world", close file
> >>>>>>> on mount A, open file.txt w/ O_APPEND, write "123", close file
> >>>>>>>
> >>>>>>> when the file is reopened on mount A, the file inode contains the=
 old
> >>>>>>> size and the last append will overwrite the data that was written=
 when
> >>>>>>> the file was opened/written on mount B.
> >>>>>>>
> >>>>>>> (This corruption can be reproduced on the example libfuse passthr=
ough_hp
> >>>>>>> server with writeback caching disabled and nopassthrough)
> >>>>>>>
> >>>>>>> Having this flag as an option enables parity with NFS's close-to-=
open
> >>>>>>> consistency.
> >>>>>>>
> >>>>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>>>>>> ---
> >>>>>>>  fs/fuse/file.c            | 7 ++++++-
> >>>>>>>  include/uapi/linux/fuse.h | 7 ++++++-
> >>>>>>>  2 files changed, 12 insertions(+), 2 deletions(-)
> >>>>>>>
> >>>>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> >>>>>>> index f39456c65ed7..437487ce413d 100644
> >>>>>>> --- a/fs/fuse/file.c
> >>>>>>> +++ b/fs/fuse/file.c
> >>>>>>> @@ -264,7 +264,12 @@ static int fuse_open(struct inode *inode, st=
ruct file *file)
> >>>>>>>       err =3D fuse_do_open(fm, get_node_id(inode), file, false);
> >>>>>>>       if (!err) {
> >>>>>>>               ff =3D file->private_data;
> >>>>>>> -             err =3D fuse_finish_open(inode, file);
> >>>>>>> +             if (ff->open_flags & FOPEN_FETCH_ATTR) {
> >>>>>>> +                     fuse_invalidate_attr(inode);
> >>>>>>> +                     err =3D fuse_update_attributes(inode, file,=
 STATX_BASIC_STATS);
> >>>>>>> +             }
> >>>>>>> +             if (!err)
> >>>>>>> +                     err =3D fuse_finish_open(inode, file);
> >>>>>>>               if (err)
> >>>>>>>                       fuse_sync_release(fi, ff, file->f_flags);
> >>>>>>>               else if (is_truncate)
> >>>>>>
> >>>>>> I didn't come to it yet, but I actually wanted to update Dharmendr=
as/my
> >>>>>> atomic open patches - giving up all the vfs changes (for now) and =
then
> >>>>>> always use atomic open if available, for FUSE_OPEN and FUSE_CREATE=
. And
> >>>>>> then update attributes through that.
> >>>>>> Would that be an alternative for you? Would basically require to a=
dd an
> >>>>>> atomic_open method into your file system.
> >>>>>>
> >>>>>> Definitely more complex than your solution, but avoids a another
> >>>>>> kernel/userspace transition.
> >>>>>
> >>>>> Hi Bernd,
> >>>>>
> >>>>> Unfortunately I don't think this is an alternative for my use case.=
 I
> >>>>> haven't looked closely at the implementation details of your atomic
> >>>>> open patchset yet but if I'm understanding the gist of it correctly=
,
> >>>>> it bundles the lookup with the open into 1 request, where the
> >>>>> attributes can be passed from server -> kernel through the reply to
> >>>>> that request. I think in the case I'm working on, the file open cal=
l
> >>>>> does not require a lookup so it can't take advantage of your featur=
e.
> >>>>> I just tested it on libfuse on the passthrough_hp server (with no
> >>>>> writeback caching and nopassthrough) on the example in the commit
> >>>>> message and I'm not seeing any lookup request being sent for that l=
ast
> >>>>> open call (for writing "123").
> >>>>>
> >>>>
> >>>>
> >>>> Hi Joanne,
> >>>>
> >>>> gets late here and I'm typing on my phone.  I hope formatting is ok.
> >>>>
> >>>> what I meant is that we use the atomic open op code for both, lookup=
-open and plain open - i.e. we always update attributes on open. Past atomi=
c open patches did not do that yet, but I later realized that always using =
atomic open op
> >>>>
> >>>> - avoids the data corruption you run into
> >>>> - probably no need for atomic-revalidate-open vfs patches anymore  a=
s we can now safely set a high attr timeout
> >>>>
> >>>>
> >>>> Kind of the same as your patch, just through a new op code.
> >>>
> >>> Awesome, thanks for the context Bernd. I think this works for our use
> >>> case then. To confirm the "we will always update attributes on open"
> >>> part, this will only send the FUSE_GETATTR request to the server if
> >>> the server has invalidated the inode (eg through the
> >>> fuse_lowlevel_notify_inval_inode() api), otherwise this will not send
> >>> an extra FUSE_GETATTR request, correct? Other than the attribute
> >>
> >> If we send FUSE_OPEN_ATOMIC (or whatever we name it) in
> >> fuse_file_open(), it would always ask server side for attributes.
> >
> > Oh I see, the FUSE_OPEN_ATOMIC request itself would ask for attributes
> > and the attributes would be sent by the server as the reply to the
> > FUSE_ATOMIC_OPEN. This sounds great! in my patch, there's an
> > additional FUSE_GETATTR request incurred to get the attributes.
> >
> >> I.e. we assume that a server that has atomic open implemented can easi=
ly
> >> provide attributes or asks for close-to-open coherency.
> >>
> >>
> >> I'm not sure if I correctly understood your questions about
> >> notifications and FUSE_GETATTR - from my point of view that that is
> >> entirely independent from open. And personally I try to reduce
> >
> > I missed that the attributes would be bundled with FUSE_OPEN_ATOMIC so
> > I thought we would need an additional FUSE_GETATTR request to get
> > them. Apologies for the confusion!
> >
> >> kernel/userspace transitions - additional notifications and FUSE_GETAT=
TR
> >> are not helpful here :)
> >>
> >>> updating, would there be any other differences from using plain open
> >>> vs the atomic open version of plain open?
> >>
> >> Just the additional file attributes and complexity that brings.
> >>
> >>>
> >>> Do you have a tentative timeline in mind for when the next iteration
> >>> of the atomic open patchset would be out?
> >>
> >> I wanted to have new fuse-uring patches ready by last week, but I'm
> >> still refactoring things - changing things on top of the existing seri=
es
> >> is easy, rebasing it is painful...  I can _try_ to make a raw new
> >> atomic-open patch set during the next days (till Sunday), but not prom=
ised.
> >>
> >
> > Sounds great. thanks for your work on this!
>
> Here is a totally untested (and probably ugly) version of what I had in m=
y
> mind
>
> https://github.com/bsbernd/linux/commits/open-getattr/
> https://github.com/libfuse/libfuse/pull/1020
>
> (It builds, but nothing more tested).
>
> Instead of rather complex atomic-open it adds FUSE_OPEN_GETATTR and hooks=
 into
> fuse_file_open.
> I was considering to hook into fuse_do_open, but that would cause quite s=
ome code
> dup for fuse_file_open. We need the inode to update attributes and in fus=
e_do_open
> we could use file->f_inode, but I didn't verify if it is reliable at this=
 stage
> (do_dentry_open() assignes it, but I didn't verify possible other code pa=
ths) - for
> now I added the inode parameter to all code paths.
>
>
> Going to test and clean it up tomorrow.

Thanks for the update, Bernd!

>
>
> Thanks,
> Bernd

