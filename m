Return-Path: <linux-fsdevel+bounces-45159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA69A73DF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 19:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA10E18894CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFD021A454;
	Thu, 27 Mar 2025 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+q0dvnq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0E11E4B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099814; cv=none; b=LxE4/sWtNYIhUMjqQWfqGpVAD7+Aq1p0ctmvVUWT9e+rfo/Nq8rOY9G4egFrsetUmA52+VHxqectyH2WT5S2ITFyFKs2anauFv+aImwKtatCDbjXVxJtCdCcLJVFOqGY0wwHZgavJhxNumRYqIKveQt3nbg/BoRratgT/Di3aRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099814; c=relaxed/simple;
	bh=Saloq+d+jJTOnb7HDZmvwcSUTqw+G5k1yhBiVvped/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y5zYP2B3GGxlXlRX4S2MdWz6pePSOOObUDzMDbMPz3sdI8F6cMNfQA/6YdYVWoGy+HUBMTEK2u/NRK5lN/DCwtLQa3l/VySYS6apHgni3GFxGjuy/GyJdgXYPxT/SRswzo9atW5STFRiYJPi5/szNmlnpTrX1hbdfQ9Vo5WCruQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+q0dvnq; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaecf50578eso224977266b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Mar 2025 11:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743099811; x=1743704611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FTm4aDT1fSRMnjCMJ28lOdR+6ZoSVkc2oosAdMiURpA=;
        b=Q+q0dvnq2PN4mDXn3wLQ/Bz4Pq8ox2d6MPYIZ+FQvMxiAr61z32/9+K6r9ht8pbyrt
         XjyHAI/AkD/CLVGzIK91zKcALB2FCLWSx/ShEut4XK2R4WX3p97/OYNL3NpPcj+sf+yk
         tU5ZjvjfwleRVUhZVqRfsjbNZUTprI6zP4Kg8J0nj66o9JSf6LHwN/ERjakHoSI7prhk
         fXdZjaKgwr6L+Uzg75hOSuy1B4bfOoPtP8ZGjhvzur4NfMtt+bDLAyZXWtxI+pcrW/tb
         xthMAK2W11Nk4ijobsaTqz1VNe9o3cfATsQKg6xnRjNQG5X4hSMw0C7Fo7Zww5FwkYwJ
         RcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743099811; x=1743704611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FTm4aDT1fSRMnjCMJ28lOdR+6ZoSVkc2oosAdMiURpA=;
        b=c3xuUpF1V0yt5P1x7QYv76Yv96pkNKk51kdsXEKNI44oojGpk8B3TtCXrc3mStSYfJ
         3egZVkiyDfeJQbGLKY93/4OeYkNv1nrz+cRtsa/AS1Jhzh4Y+GdjvBBC5nREpVPbFLrT
         pZoetgtQ6//FqOdkzg9tYEB04GgQxs2mQpK2zzyBF6BlOaW4c2C/QNQM63142+xc+tpT
         81WS8y5JlOSnVavsvJ89grtgXstn5TXEhFujxjYIpneQaZZMS5p+6ECKFNTFC3tDKxFy
         UHz62rXZLubTLDxbZrAE+DykCPdCQlyi68pS+PT/ZfcFzN2FoNTO1/IbSMAxwTmzP7HB
         K1jg==
X-Forwarded-Encrypted: i=1; AJvYcCUIEsZ1hcV6evk8p8cPeELrZKFycCXuHPXhLMQLMl6M7e8eJTXxMcVpT5Xdu9XeySI7KQymPLeN3oDDCaD2@vger.kernel.org
X-Gm-Message-State: AOJu0YyNzdXEgCdTrmMr+hUyZ32xSnFLqLSqGuIJmt5+gc8Mcr2+mf7q
	JqOk5SGSWHMox4NC8lF0TL3bUnFXOfPy9CLBwmHqpZ/YUWlp5Xes48HzBeUerRIm/BbxXlcd9cg
	8RW9y9T8QHu6vfqzgDIM6PHjB+ho=
X-Gm-Gg: ASbGncvEwVFw5fY/STgxcd1RwhSqMf1aLHkbpSlbls6SFCIyxcAmjRZqy6p/fsVJowv
	VzFd4J4CjkSWBQJlqE9eW0Rr/CUWs3otzA759bmmeXavygsCckGijclyjcDKSb5dgK/oM1uyMTC
	jpbhEJkKegvZqoDiuRTnCuUmkXoA==
X-Google-Smtp-Source: AGHT+IH9Kj95hfZOYYJGWljd2kmZLVOjxhCqyzIW96mN6GSO8XmM933x+F+a6gE7zQIwc4q9OmGwMQPjSnVpRw7+lqY=
X-Received: by 2002:a17:907:940a:b0:ac3:991:a631 with SMTP id
 a640c23a62f3a-ac6faf0b842mr392392266b.34.1743099810474; Thu, 27 Mar 2025
 11:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj00D_fP3nRUBjAry6vwUCNjYuUpCZg2Uc8hwMk6n+2HA@mail.gmail.com>
 <Z41rfVwqp6mmgOt9@dread.disaster.area> <CAOQ4uxgYERCmPrTXjuM4Q3HdWK_HxuOkkpAEnesDHCAD=9fsOg@mail.gmail.com>
 <dc0649f70ca69741d351060c8c3816a347c00687.camel@kernel.org>
 <gihbrvdkldci257z5amkrowcsrzgjjmtnif7ycvpi6rsbktvnz@rfqybs7klfkj> <CAOQ4uxinA4C0iJCwZqkhLo-R9NLF=Sd_YXHEcXCX2BBNBSvNAA@mail.gmail.com>
In-Reply-To: <CAOQ4uxinA4C0iJCwZqkhLo-R9NLF=Sd_YXHEcXCX2BBNBSvNAA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 27 Mar 2025 19:23:19 +0100
X-Gm-Features: AQ5f1Jpjk6zbgLrageWeRNyBVV6pw9XVCkjRkm9fcLW_yvG3VkbkFq9CcYWzugw
Message-ID: <CAOQ4uxjBysYT3iH=SLuOErMZHXyWRhj=Ym_WF7+uYQySG7RyRA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] vfs write barriers
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Dave Chinner <david@fromorbit.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 6:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Feb 11, 2025 at 5:22=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 23-01-25 13:14:11, Jeff Layton wrote:
> > > On Mon, 2025-01-20 at 12:41 +0100, Amir Goldstein wrote:
> > > > On Sun, Jan 19, 2025 at 10:15=E2=80=AFPM Dave Chinner <david@fromor=
bit.com> wrote:
> > > > >
> > > > > On Fri, Jan 17, 2025 at 07:01:50PM +0100, Amir Goldstein wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I would like to present the idea of vfs write barriers that was=
 proposed by Jan
> > > > > > and prototyped for the use of fanotify HSM change tracking even=
ts [1].
> > > > > >
> > > > > > The historical records state that I had mentioned the idea brie=
fly at the end of
> > > > > > my talk in LSFMM 2023 [2], but we did not really have a lot of =
time to discuss
> > > > > > its wider implications at the time.
> > > > > >
> > > > > > The vfs write barriers are implemented by taking a per-sb srcu =
read side
> > > > > > lock for the scope of {mnt,file}_{want,drop}_write().
> > > > > >
> > > > > > This could be used by users - in the case of the prototype - an=
 HSM service -
> > > > > > to wait for all in-flight write syscalls, without blocking new =
write syscalls
> > > > > > as the stricter fsfreeze() does.
> > > > > >
> > > > > > This ability to wait for in-flight write syscalls is used by th=
e prototype to
> > > > > > implement a crash consistent change tracking method [3] without=
 the
> > > > > > need to use the heavy fsfreeze() hammer.
> > > > >
> > > > > How does this provide anything guarantee at all? It doesn't order=
 or
> > > > > wait for physical IOs in any way, so writeback can be active on a
> > > > > file and writing data from both sides of a syscall write "barrier=
".
> > > > > i.e. there is no coherency between what is on disk, the cmtime of
> > > > > the inode and the write barrier itself.
> > > > >
> > > > > Freeze is an actual physical write barrier. A very heavy handed
> > > > > physical right barrier, yes, but it has very well defined and
> > > > > bounded physical data persistence semantics.
> > > >
> > > > Yes. Freeze is a "write barrier to persistence storage".
> > > > This is not what "vfs write barrier" is about.
> > > > I will try to explain better.
> > > >
> > > > Some syscalls modify the data/metadata of filesystem objects in mem=
ory
> > > > (a.k.a "in-core") and some syscalls query in-core data/metadata
> > > > of filesystem objects.
> > > >
> > > > It is often the case that in-core data/metadata readers are not ful=
ly
> > > > synchronized with in-core data/metadata writers and it is often tha=
t
> > > > in-core data and metadata are not modified atomically w.r.t the
> > > > in-core data/metadata readers.
> > > > Even related metadata attributes are often not modified atomically
> > > > w.r.t to their readers (e.g. statx()).
> > > >
> > > > When it comes to "observing changes" multigrain ctime/mtime has
> > > > improved things a lot for observing a change in ctime/mtime since
> > > > last sampled and for observing an order of ctime/mtime changes
> > > > on different inodes, but it hasn't changed the fact that ctime/mtim=
e
> > > > changes can be observed *before* the respective metadata/data
> > > > changes can be observed.
> > > >
> > > > An example problem is that a naive backup or indexing program can
> > > > read old data/metadata with new timestamp T and wrongly conclude
> > > > that it read all changes up to time T.
> > > >
> > > > It is true that "real" backup programs know that applications and
> > > > filesystem needs to be quisences before backup, but actual
> > > > day to day cloud storage sync programs and indexers cannot
> > > > practically freeze the filesystem for their work.
> > > >
> > >
> > > Right. That is still a known problem. For directory operations, the
> > > i_rwsem keeps things consistent, but for regular files, it's possible
> > > to see new timestamps alongside with old file contents. That's a
> > > problem since caching algorithms that watch for timestamp changes can
> > > end up not seeing the new contents until the _next_ change occurs,
> > > which might not ever happen.
> > >
> > > It would be better to change the file write code to update the
> > > timestamps after copying data to the pagecache. It would still be
> > > possible in that case to see old attributes + new contents, but that'=
s
> > > preferable to the reverse for callers that are watching for changes t=
o
> > > attributes.
> > >
> > > Would fixing that help your use-case at all?
> >
> > I think Amir wanted to make here a point in the other direction: I.e., =
if
> > the application did:
> >  * sample inode timestamp
> >  * vfs_write_barrier()
> >  * read file data
> >
> > then it is *guaranteed* it will never see old data & new timestamp and =
hence
> > the caching problem is solved. No need to update timestamp after the wr=
ite.
> >
> > Now I agree updating timestamps after write is much nicer from usabilit=
y
> > POV (given how common pattern above it) but this is just a simple examp=
le
> > demonstrating possible uses for vfs_write_barrier().
> >
>
> I was trying to figure out if updating timestamp after write would be eno=
ugh
> to deal with file writes and I think that it is not enough when adding
> signalling
> (events) into the picture.
> In this case, the consumer is expected to act on changes (e.g. index/back=
up)
> soon after they happen.
> I think this case is different from NFS cache which only cares about cach=
e
> invalidation on file access(?).
>
> In any case, we need a FAN_PRE_MODIFY blocking event to store a
> persistent change intent record before the write - that is needed to find
> changes after a crash.
>
> Now unless we want to start polling ctime (and we do not want that),
> we need a signal to wake the consumer after the write to page cache
>
> One way is to rely on the FAN_MODIFY async event post write.
> But there is ambiguity in the existing FAN_MODIFY events:
>
>     Thread A starts write on file F (no listener for FAN_PRE_MODIFY)
> Event consumer starts
>         Thread B starts write on file F
>         FAN_PRE_MODIFY(F) reported from thread B
>     Thread A completes write on file F
>     FAN_MODIFY(F) reported from thread A (or from aio completion thread)
> Event consumer believes it got the last event and can read the final
> version of F
>
> So if we use this method we will need a unique cookie to
> associate the POST_MODIFY with the PRE_MODIFY event.
>
> Something like this:
>
> writer                                [fsnotifyd]
> -------                                -------------
> file_start_write_usn() =3D> FAN_PRE_MODIFY[ fsid, usn, fhandle ]
> {                                 <=3D Record change intent before respon=
se
> =E2=80=A6do some in-core changes
>    (e.g. data + mode + ctime)...
> } file_end_write_usn() =3D> FAN_POST_MODIFY[ fsid, usn, fhandle ]
>                                          Consume changes after FAN_POST_M=
ODIFY
>
> While this is a viable option, it adds yet more hooks and more
> events and it does not provide an easy way for consumers to
> wait for the completion of a batch of modifications.
>
> The vfs_write_barrier method provides a better way to wait for completion=
:
>
> writer                                [fsnotifyd]
> -------                                -------------
> file_start_write_srcu() =3D> FAN_PRE_MODIFY[ fsid, usn, fhandle ]
> {                                  <=3D Record change intent before respo=
nse
> =E2=80=A6do some in-core changes under srcu read lock
>    (e.g. data + mode + ctime)...
> } file_end_write_srcu()
>      synchronize_srcu()   <=3D vfs_write_barrier();
>                     Consume a batch of recorded changes after write barri=
er
>                     act on the changes and clear the change intent record=
s
>
> I am hoping to be able to argue for the case of vfs_write_barrier()
> in LSFMM, but if this will not be acceptable, I can work with the
> post modify events solution.
>

FYI, I had discussed it with some folks at LSFMM after my talk
and what was apparent to me from this chat and also from the questions
during my presentation, is that I did not succeed in explaining the problem=
.

I believe that the path forward for me, which is something that Jan
has told me from the beginning, is to implement a reference design
of persistent change journal, because this is too complex of an API
to discuss without the user code that uses it.

I am still on the fence about whether I want to do a userspace fsnotifyfd
or a kernel persistent change journal library/subsystem as a reference
design. I do already have a kernel subsystem (ovl watch) so I may end
up cleaning that one up to use a proper fanotify API and maybe that would
be the way to do it.

One more thing that I realised during LSFMM, is that some filesystems
(e.g. NTFS, Lustre) already have an internal persistent change journal.
If I implement a kernel persistent change journal subsystem, then
we could use the same fanotify API to read events from fs that implements
its own persistent change journal and from a fs that allows to use the
fs agnostic persistent change journal.

Thanks,
Amir.

