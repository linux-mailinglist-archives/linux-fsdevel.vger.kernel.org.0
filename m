Return-Path: <linux-fsdevel+bounces-55905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0021DB0FC00
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3B84E0BC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 21:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89D42586EB;
	Wed, 23 Jul 2025 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJUDcacN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567412E630
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753305116; cv=none; b=PoMW/vqfamQmVDO5bYlacruamXxr/X15+Y9husactQkVXEqWya18dzKHtJPqapOL7gLaAVbObKRP3Phui7hVczQmY4MP8zl+9XG/tmaD/1n5skGoWQg6IwFu51M2WKe7HXkL4R9RT9vKKpoUt7quWwdcyM4rt0G6xIv3aAFleSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753305116; c=relaxed/simple;
	bh=UTkRUEJ6Ecg0VDnpiaNrr0HGEmJapMt2pGDb0ykHPpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mTNxIZVcWsEMch2bZBJe2u60s2kv/8kKV4Kg8j6YMhrmA1RsUNwHTEynCDuZu7RNyXh14FzIy61oBBMCn+/W08qQGqrrihS7ZoZi1wQGAgZCHOgcvk0X2lTK4kqwKbVqRFxLjJ10y+BWwjKqX5qkLByWww/XiNGYjvtM2LUn6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJUDcacN; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab7384b108so4570011cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753305113; x=1753909913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cf0/en5oUeolq0JM4XZ1njJTDz6fjEUsf+hI67xstQs=;
        b=LJUDcacNks8PVvEBGMOLxtxxW2j3p8ReE0+JWjdA3EiKYRnpfwS6lw5r3NQh5tbgU1
         grdlwVE22PYf+eDAQJ3kYE4YHhLVrch7ibsx832uv+vZ1TbbSJIVqd/Mq83Csjs2Tgbe
         LBBlXy6BYYpOI3k8xCtaQVz1J+d3nWSuZGqkKeyHlU2wdgH+JsrJIiBiVwN9C601v9Ea
         cagoAPH2FoOtA5FasmeB77mYOBJKwLsdJb8pjSv8eYZ3u8n6Ek76tZ5BzQKDKs3mCMq3
         FvgGplx6dVHzZ7ArZJEEjE7GvgIVbI8YJzZBSiI1eqzxUsCd8E3iwnOeUwfamqLlvqKw
         iCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753305113; x=1753909913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cf0/en5oUeolq0JM4XZ1njJTDz6fjEUsf+hI67xstQs=;
        b=wyHkGXTcGRI0QfIcElpGxpvf6oNYp4WrpGqCI5JXGjxGjutImlCf0EkXB/fmowZEsG
         EMGvAiOFd/KZg3sQJHN5vCvl9OUpaE8WCGSBuZPTAKJWzpeWh+S31eQvSkOp2KFRPGf0
         ENFauwB1nOl3IZakCb16+3LtNr4h34Okblu+d2H8MYwvSyBPvtc+rpuBN+hmSr3450gp
         LKkrEKYmh7QPA2/55RlX+C1buDwAAmXVw5yZW9B/+asrxqGu3ufQ1i9Ne7QARSONEY8g
         HhBs2GqhvfbNH0/9EBHuPAHdx3CeZoOk2zMRpfgXAsz6uCKF4z5ZRaqtlo+DIJ827+HD
         zA8Q==
X-Gm-Message-State: AOJu0YzRZ/yrW3gL8iLhMpewApbqyEZq0zWbIPYCmY3jSvNsNtSY0RRg
	kup7mbnGCEq/7DVBiHQLxS/aqw6xJzcA/54WlJrrqD8t8i/8IZcUBFR32i84MPhII9yGnRpwLBk
	tpPf7KLPIelk+meDLcE5OXnKFbRn0/1qRQC3Q
X-Gm-Gg: ASbGnctqo2zeQxvA3ARzCaifib2xpzn1f3uXb01DrKeo0I78NWleJz2QTpcqL0W0Muv
	E/uidW2cLdiS/54zRhjZU9oMK6lq2rAhF0/C0NOM7NORQ1XwbgzQlvzNVxxus7wA4iPR9Qw8KoG
	5KEN985Fzt4U1Vl18gQUhicJ28S6BVIkQMe4s6Q3MgdlKq3mxymxwaohxfQYXRclspdBLK8qykc
	ejRDoM=
X-Google-Smtp-Source: AGHT+IGOWaXgLSu+nM6PgW8q80peulZWkkJeylu3h79P5q4pr5clhRkLiB0waF3W1FjioDkOmz9XtKIvHzpEtXeUeU0=
X-Received: by 2002:ac8:5712:0:b0:4ab:6d28:5ca0 with SMTP id
 d75a77b69052e-4ae7b78ac4amr19777241cf.36.1753305112757; Wed, 23 Jul 2025
 14:11:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
 <20250719003215.GG2672029@frogsfrogsfrogs> <CAJnrk1YvGrgJK6qd0UPMzNUxyJ6QwY2b-HRhsj5QVrHsLxuQmQ@mail.gmail.com>
 <20250723173425.GX2672070@frogsfrogsfrogs> <CAJnrk1ad0O5ghB_m2=D4zQyYE0rcG3M_m09_qESGiQyFB4_Vsw@mail.gmail.com>
In-Reply-To: <CAJnrk1ad0O5ghB_m2=D4zQyYE0rcG3M_m09_qESGiQyFB4_Vsw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 14:11:41 -0700
X-Gm-Features: Ac12FXy86wGhsbpYWCwwzZymMiZpIyE4KRFdowyNSewTeWJNSMqzlwMciQMsruc
Message-ID: <CAJnrk1ZyRNNRgWW8bY_dAYpxtS56bfjQ1pymL6CfwBikFEC3Ag@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 2:02=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Wed, Jul 23, 2025 at 10:34=E2=80=AFAM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> >
> > On Mon, Jul 21, 2025 at 01:32:43PM -0700, Joanne Koong wrote:
> > > On Fri, Jul 18, 2025 at 5:32=E2=80=AFPM Darrick J. Wong <djwong@kerne=
l.org> wrote:
> > > >
> > > > On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > > > > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >
> > > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > >
> > > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > > >
> > > > > > generic/488       _check_generic_filesystem: filesystem on /dev=
/sdf is inconsistent
> > > > > > (see /var/tmp/fstests/generic/488.full for details)
> > > > > >
> > > > > > This test opens a large number of files, unlinks them (which re=
ally just
> > > > > > renames them to fuse hidden files), closes the program, unmount=
s the
> > > > > > filesystem, and runs fsck to check that there aren't any incons=
istencies
> > > > > > in the filesystem.
> > > > > >
> > > > > > Unfortunately, the 488.full file shows that there are a lot of =
hidden
> > > > > > files left over in the filesystem, with incorrect link counts. =
 Tracing
> > > > > > fuse_request_* shows that there are a large number of FUSE_RELE=
ASE
> > > > > > commands that are queued up on behalf of the unlinked files at =
the time
> > > > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connecti=
on not
> > > > > > aborted, the fuse server would have responded to the RELEASE co=
mmands by
> > > > > > removing the hidden files; instead they stick around.
> > > > >
> > > > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous inst=
ead
> > > > > of synchronous. For example for fuse servers that cache their dat=
a and
> > > > > only write the buffer out to some remote filesystem when the file=
 gets
> > > > > closed, it seems useful for them to (like nfs) be able to return =
an
> > > > > error to the client for close() if there's a failure committing t=
hat
> > > >
> > > > I don't think supplying a return value for close() is as helpful as=
 it
> > > > seems -- the manage says that there is no guarantee that data has b=
een
> > > > flushed to disk; and if the file is removed from the process' fd ta=
ble
> > > > then the operation succeeded no matter the return value. :P
> > > >
> > > > (Also C programmers tend to be sloppy and not check the return valu=
e.)
> > >
> > > Amir pointed out FUSE_FLUSH gets sent on the FUSE_RELEASE path so tha=
t
> > > addresses my worry. FUSE_FLUSH is sent synchronously (and close() wil=
l
> > > propagate any flush errors too), so now if there's an abort or
> > > something right after close() returns, the client is guaranteed that
> > > any data they wrote into a local cache has been flushed by the server=
.
> >
> > <nod>
> >
> > > >
> > > > > data; that also has clearer API semantics imo, eg users are guara=
nteed
> > > > > that when close() returns, all the processing/cleanup for that fi=
le
> > > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, =
eg if
> > > > > the server holds local locks that get released in FUSE_RELEASE, i=
f a
> > > >
> > > > Yes.  I think it's only useful for the case outined in that patch, =
which
> > > > is that a program started an asyncio operation and then closed the =
fd.
> > > > In that particular case the program unambiguously doesn't care abou=
t the
> > > > return value of close so it's ok to perform the release asynchronou=
sly.
> > >
> > > I wonder why fuseblk devices need to be synchronously released. The
> > > comment says " Make the release synchronous if this is a fuseblk
> > > mount, synchronous RELEASE is allowed (and desirable)". Why is it
> > > desirable?
> >
> > Err, which are you asking about?
> >
> > Are you asking why it is that fuseblk mounts call FUSE_DESTROY from
> > unmount instead of letting libfuse synthesize it once the event loop
> > terminates?  I think that's because in the fuseblk case, the kernel has
> > the block device open for itself, so the fuse server must write and
> > flush all dirty data before the unmount() returns to the caller.
> >
> > Or were you asking why synchronous RELEASE is done on fuseblk
> > filesystems?  Here is my speculation:
> >
> > Synchronous RELEASE was added back in commit 5a18ec176c934c ("fuse: fix
> > hang of single threaded fuseblk filesystem").  I /think/ the idea behin=
d
> > that patch was that for fuseblk servers, we're ok with issuing a
> > FUSE_DESTROY request from the kernel and waiting on it.
> >
> > However, for that to work correctly, all previous pending requests
> > anywhere in the fuse mount have to be flushed to and completed by the
> > fuse server before we can send DESTROY, because destroy closes the
> > filesystem.
> >
> > So I think the idea behind 5a18ec176c934c is that we make FUSE_RELEASE
> > synchronous so it's not possible to umount(8) until all the releases
> > requests are finished.
>
> Thanks for the explanation. With the fix you added in this patch then,
> it seems there's no reason fuseblk requests shouldn't now also be
> asynchronous since your fix ensures that all pending requests have
> been flushed and completed before issuing the DESTROY
>
> >
> > > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > > grabbing that lock, then we end up deadlocked if the server is
> > > > > single-threaded.
> > > >
> > > > Hrm.  I suppose if you had a script that ran two programs one after=
 the
> > > > other, each of which expected to be able to open and lock the same =
file,
> > > > then you could run into problems if the lock isn't released by the =
time
> > > > the second program is ready to open the file.
> > >
> > > I think in your scenario with the two programs, the worst outcome is
> > > that the open/lock acquiring can take a while but in the (contrived
> > > and probably far-fetched) scenario where it's single threaded, it
> > > would result in a complete deadlock.
> >
> > <nod> I concede it's a minor point. :)
> >
> > > > But having said that, some other program could very well open and l=
ock
> > > > the file as soon as the lock drops.
> > > >
> > > > > I saw in your first patch that sending FUSE_RELEASE synchronously
> > > > > leads to a deadlock under AIO but AFAICT, that happens because we
> > > > > execute req->args->end() in fuse_request_end() synchronously; I t=
hink
> > > > > if we execute that release asynchronously on a worker thread then=
 that
> > > > > gets rid of the deadlock.
> > > >
> > > > <nod> Last time I think someone replied that maybe they should all =
be
> > > > asynchronous.
> > > >
> > > > > If FUSE_RELEASE must be asynchronous though, then your approach m=
akes
> > > > > sense to me.
> > > >
> > > > I think it only has to be asynchronous for the weird case outlined =
in
> > > > that patch (fuse server gets stuck closing its own client's fds).
> > > > Personally I think release ought to be synchronous at least as far =
as
> > > > the kernel doing all the stuff that close() says it has to do (remo=
val
> > > > of record locks, deleting the fd table entry).
> > > >
> > > > Note that doesn't necessarily mean that the kernel has to be comple=
tely
> > > > done with all the work that entails.  XFS defers freeing of unlinke=
d
> > > > files until a background garbage collector gets around to doing tha=
t.
> > > > Other filesystems will actually make you wait while they free all t=
he
> > > > data blocks and the inode.  But the kernel has no idea what the fus=
e
> > > > server actually does.
> > >
> > > I guess if that's important enough to the server, we could add
> > > something an FOPEN flag for that that servers could set on the file
> > > handle if they want synchronous release?
> >
> > If a fuse server /did/ have background garbage collection, there are a
> > few things it could do -- every time it sees a FUSE_RELEASE of an
> > unlinked file, it could set a timer (say 50ms) after which it would kic=
k
> > the gc thread to do its thing.  Or it could do wake up the background
> > thread in response to a FUSE_SYNCFS command and hope it finishes by the
> > time FUSE_DESTROY comes around.
> >
> > (Speaking of which, can we enable syncfs for all fuse servers?)
>
> I'm not sure what you mean by this - i thought the implementation of
> FUSE_SYNCFS is dependent on each server's logic depending on if
> they've set a callback for it or not? Speaking of which, it doesn't
> look like FUSE_SYNCFS support has been added to libfuse yet.
>
> >
> > But that said, not everyone wants the fancy background gc stuff that XF=
S
> > does.  FUSE_RELEASE would then be doing a lot of work.
> >
> > > after Amir's point about FUSE_FLUSH, I'm in favor now of FUSE_RELEASE
> > > being asynchronous.
> > > >
> > > > > > Create a function to push all the background requests to the qu=
eue and
> > > > > > then wait for the number of pending events to hit zero, and cal=
l this
> > > > > > before fuse_abort_conn.  That way, all the pending events are p=
rocessed
> > > > > > by the fuse server and we don't end up with a corrupt filesyste=
m.
> > > > > >
> > > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > ---
> > > > > >  fs/fuse/fuse_i.h |    6 ++++++
> > > > > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > > > > >  fs/fuse/inode.c  |    1 +
> > > > > >  3 files changed, 45 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > +/*
> > > > > > + * Flush all pending requests and wait for them.  Only call th=
is function when
> > > > > > + * it is no longer possible for other threads to add requests.
> > > > > > + */
> > > > > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long t=
imeout)
> > > > >
> > > > > It might be worth renaming this to something like
> > > > > 'fuse_flush_bg_requests' to make it more clear that this only flu=
shes
> > > > > background requests
> > > >
> > > > Hum.  Did I not understand the code correctly?  I thought that
> > > > flush_bg_queue puts all the background requests onto the active que=
ue
> > > > and issues them to the fuse server; and the wait_event_timeout sits
> > > > around waiting for all the requests to receive their replies?
> > >
> > > Sorry, didn't mean to be confusing with my previous comment. What I
> > > was trying to say is that "fuse_flush_requests" implies that all
> > > requests get flushed to userspace but here only the background
> > > requests get flushed.
> >
> > Oh, I see now, I /was/ mistaken.  Synchronous requests are ...
> >
> > Wait, no, still confused :(
> >
> > fuse_flush_requests waits until fuse_conn::num_waiting is zero.
> >
> > Synchronous requests (aka the ones sent through fuse_simple_request)
> > bump num_waiting either directly in the args->force case or indirectly
> > via fuse_get_req.  num_waiting is decremented in fuse_put_request.
> > Therefore waiting for num_waiting to hit zero implements waiting for al=
l
> > the requests that were in flight before fuse_flush_requests was called.
> >
> > Background requests (aka the ones sent via fuse_simple_background) have
> > num_waiting set in the !args->force case or indirectly in
> > fuse_request_queue_background.  num_waiting is decremented in
> > fuse_put_request the same as is done for synchronous requests.
> >
> > Therefore, it's correct to say that waiting for num_requests to become =
0
> > is sufficient to wait for all pending requests anywhere in the
> > fuse_mount to complete.
>
> You're right, good point, waiting on fc->num_waiting =3D=3D 0 also ensure=
s
> foreground requests have been completed. sorry for the confusion!
>
> Connections can also be aborted through the
> /sys/fs/fuse/connections/*/abort interface or through request timeouts
> (eg fuse_check_timeout()) - should those places too flush pending
> requests and wait for them before aborting the connection?
>

Or I guess just the FUSE_RELEASE one since that seems to be the only
one that could lead to disk inconsistencies if it's not completed

