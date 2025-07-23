Return-Path: <linux-fsdevel+bounces-55904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAC3B0FBEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 23:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D669AA1A76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 21:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160A120E31C;
	Wed, 23 Jul 2025 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHq2quM6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E14F17C91
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 21:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753304553; cv=none; b=XRYjV8EziGAMj0DhFfYwGe2GMtMBMAkpCFSvYSwYZLJlQNhqhp6POoaL3dupshT0b/yPvK5y9EBg2juK1gNjfJwkIuGXO9ZQ485mpqvkQJzs+4ay6HbTXGzd0g5tqO5pjZoKr+6w+Xdq6f5eaGROBrQ80GeyYGz7ECkSwIEAau0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753304553; c=relaxed/simple;
	bh=aGOGNIkUw5pCEPbQ61HJsYL3aYT1mqC7yWZ0ceX4IYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EkDudvw09XMvV+796JIxbGzQl5rCZ+tyrEBY49mSzr9ScdJ2Vmk7Up9pbAZHj1OQyJ88Cfkg7N//wQsFGxpeUOYQu0LQDYjq+GkNjtGtIMKszgp9HaxTdAqheQHu4xKc4E/A1WKQivvh0+gvQyJ7tplfZLmRh0M7EWSVfcYoEys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHq2quM6; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ab81d0169cso4847811cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753304550; x=1753909350; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RbxiciJuxQ+pMz4plUNC3K7psBCIxoOvwOE6t3pIac=;
        b=AHq2quM6VO68MbquudCC/6XNOgK1VlAAeykpFT4ebWsZsOyWV2Zy+8XoXJ7zpz5lm1
         GBTGxbRGZX+hnHMd02g7gthoWi25SLbmalE15bPh/sZ9xU3r+iXy+27aCgEGEdlUIpvf
         mhrf/LzE1NJgsqdxcg+X8uoxVIp8wpASgqIdTyGZSGwtFewQI/K3UZIpY24i7oybIh2D
         NyESeiCA2wyWqZ7Y8RQG9jBLIuU4RSoGNZGPOqpNHnlWM7hzzb4E0s/lU1vdJpTXi7VJ
         NfmUIE3TatxEsJJYnoma+U7RJGnUeeKN/g+dN/yu9vIyziPLQpoz+nAULGohsMiSsqcj
         FWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753304550; x=1753909350;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RbxiciJuxQ+pMz4plUNC3K7psBCIxoOvwOE6t3pIac=;
        b=DZ03thxtP6ZbdtXY2Ut/4RjJzTX+89PJrwbro2BcxJXu6aKorN30z6lM9sbhXWlEnw
         lQbCycNi55qf/j92qfvpqyn4yfALZmSYMhE4Epch96R2LOnHAam0sPFb2G5z5aWAGWio
         jAH0cFsu2WXZ6xePkRbXsJb741cBTe+5XGzFhb/QkLcTUtMDAgHQEv/3xUICgRro8O4M
         LwjohEavzSossV+FZXXGXuSeDbnxD7q2zx5GnBpThzWmdn86ORnaFOjQcB1colxwoSC0
         0hvAz0Zvgq0wE+5goBbux1Q7K0jQecDyiFr/rPzXkpqMRLKYl60pW/QaHaSTPuyB1pgW
         NjwA==
X-Gm-Message-State: AOJu0YxZ9YS0m5K3ekcvZXa8RGZJPHW/NZTSVuK11aJsl80auClkSLiG
	cWrtcD+VAizvJlFAcEO9ItQYdt6H9bdieZmo4Hpe5Ah36N/nM+RxZy4I48AjaLPgQdozozTP+n5
	AN42S3Vm6yjPQkp5eqOea1u3pqn/MSBk=
X-Gm-Gg: ASbGncs8YXLJfhLBTVWT2B+n6N7megX2MafKV1PGAwofFKMsyMeTcTYbCOUIi5mFm4s
	9kwTPvXAyYnORh23fo1NMq7p4Nc7vBNMYP0EwmEWBHMBNpvxNReqyxfv+7ABaXnyBp8JNVqmT+F
	V8qg9msR17ODR90vsGDro1WaabMl7I5mk7urE+HMoX4GVInGifpXkNyGmtCD/NE4aeSF3fpKJwA
	mai6vooaKNcPwjSMg==
X-Google-Smtp-Source: AGHT+IEZKi0805XE2dSE6i/BpgMYTCCG7iutA9Pa8YvW74dFyjc2u4OWjofKXLOzwVgI0EzE9jJcGF8nUvEGA3viLxs=
X-Received: by 2002:a05:622a:181c:b0:4a9:93f0:e228 with SMTP id
 d75a77b69052e-4ae6de219demr59254071cf.1.1753304550014; Wed, 23 Jul 2025
 14:02:30 -0700 (PDT)
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
 <20250723173425.GX2672070@frogsfrogsfrogs>
In-Reply-To: <20250723173425.GX2672070@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 23 Jul 2025 14:02:19 -0700
X-Gm-Features: Ac12FXxYbMW_FQ_OSXcqqpDGRoBXs-qK96nz_f1ag8vHNk0uQlR9PFSFazocqb4
Message-ID: <CAJnrk1ad0O5ghB_m2=D4zQyYE0rcG3M_m09_qESGiQyFB4_Vsw@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 10:34=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Mon, Jul 21, 2025 at 01:32:43PM -0700, Joanne Koong wrote:
> > On Fri, Jul 18, 2025 at 5:32=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > > > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@ker=
nel.org> wrote:
> > > > >
> > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > >
> > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > >
> > > > > generic/488       _check_generic_filesystem: filesystem on /dev/s=
df is inconsistent
> > > > > (see /var/tmp/fstests/generic/488.full for details)
> > > > >
> > > > > This test opens a large number of files, unlinks them (which real=
ly just
> > > > > renames them to fuse hidden files), closes the program, unmounts =
the
> > > > > filesystem, and runs fsck to check that there aren't any inconsis=
tencies
> > > > > in the filesystem.
> > > > >
> > > > > Unfortunately, the 488.full file shows that there are a lot of hi=
dden
> > > > > files left over in the filesystem, with incorrect link counts.  T=
racing
> > > > > fuse_request_* shows that there are a large number of FUSE_RELEAS=
E
> > > > > commands that are queued up on behalf of the unlinked files at th=
e time
> > > > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection=
 not
> > > > > aborted, the fuse server would have responded to the RELEASE comm=
ands by
> > > > > removing the hidden files; instead they stick around.
> > > >
> > > > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instea=
d
> > > > of synchronous. For example for fuse servers that cache their data =
and
> > > > only write the buffer out to some remote filesystem when the file g=
ets
> > > > closed, it seems useful for them to (like nfs) be able to return an
> > > > error to the client for close() if there's a failure committing tha=
t
> > >
> > > I don't think supplying a return value for close() is as helpful as i=
t
> > > seems -- the manage says that there is no guarantee that data has bee=
n
> > > flushed to disk; and if the file is removed from the process' fd tabl=
e
> > > then the operation succeeded no matter the return value. :P
> > >
> > > (Also C programmers tend to be sloppy and not check the return value.=
)
> >
> > Amir pointed out FUSE_FLUSH gets sent on the FUSE_RELEASE path so that
> > addresses my worry. FUSE_FLUSH is sent synchronously (and close() will
> > propagate any flush errors too), so now if there's an abort or
> > something right after close() returns, the client is guaranteed that
> > any data they wrote into a local cache has been flushed by the server.
>
> <nod>
>
> > >
> > > > data; that also has clearer API semantics imo, eg users are guarant=
eed
> > > > that when close() returns, all the processing/cleanup for that file
> > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg=
 if
> > > > the server holds local locks that get released in FUSE_RELEASE, if =
a
> > >
> > > Yes.  I think it's only useful for the case outined in that patch, wh=
ich
> > > is that a program started an asyncio operation and then closed the fd=
.
> > > In that particular case the program unambiguously doesn't care about =
the
> > > return value of close so it's ok to perform the release asynchronousl=
y.
> >
> > I wonder why fuseblk devices need to be synchronously released. The
> > comment says " Make the release synchronous if this is a fuseblk
> > mount, synchronous RELEASE is allowed (and desirable)". Why is it
> > desirable?
>
> Err, which are you asking about?
>
> Are you asking why it is that fuseblk mounts call FUSE_DESTROY from
> unmount instead of letting libfuse synthesize it once the event loop
> terminates?  I think that's because in the fuseblk case, the kernel has
> the block device open for itself, so the fuse server must write and
> flush all dirty data before the unmount() returns to the caller.
>
> Or were you asking why synchronous RELEASE is done on fuseblk
> filesystems?  Here is my speculation:
>
> Synchronous RELEASE was added back in commit 5a18ec176c934c ("fuse: fix
> hang of single threaded fuseblk filesystem").  I /think/ the idea behind
> that patch was that for fuseblk servers, we're ok with issuing a
> FUSE_DESTROY request from the kernel and waiting on it.
>
> However, for that to work correctly, all previous pending requests
> anywhere in the fuse mount have to be flushed to and completed by the
> fuse server before we can send DESTROY, because destroy closes the
> filesystem.
>
> So I think the idea behind 5a18ec176c934c is that we make FUSE_RELEASE
> synchronous so it's not possible to umount(8) until all the releases
> requests are finished.

Thanks for the explanation. With the fix you added in this patch then,
it seems there's no reason fuseblk requests shouldn't now also be
asynchronous since your fix ensures that all pending requests have
been flushed and completed before issuing the DESTROY

>
> > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > grabbing that lock, then we end up deadlocked if the server is
> > > > single-threaded.
> > >
> > > Hrm.  I suppose if you had a script that ran two programs one after t=
he
> > > other, each of which expected to be able to open and lock the same fi=
le,
> > > then you could run into problems if the lock isn't released by the ti=
me
> > > the second program is ready to open the file.
> >
> > I think in your scenario with the two programs, the worst outcome is
> > that the open/lock acquiring can take a while but in the (contrived
> > and probably far-fetched) scenario where it's single threaded, it
> > would result in a complete deadlock.
>
> <nod> I concede it's a minor point. :)
>
> > > But having said that, some other program could very well open and loc=
k
> > > the file as soon as the lock drops.
> > >
> > > > I saw in your first patch that sending FUSE_RELEASE synchronously
> > > > leads to a deadlock under AIO but AFAICT, that happens because we
> > > > execute req->args->end() in fuse_request_end() synchronously; I thi=
nk
> > > > if we execute that release asynchronously on a worker thread then t=
hat
> > > > gets rid of the deadlock.
> > >
> > > <nod> Last time I think someone replied that maybe they should all be
> > > asynchronous.
> > >
> > > > If FUSE_RELEASE must be asynchronous though, then your approach mak=
es
> > > > sense to me.
> > >
> > > I think it only has to be asynchronous for the weird case outlined in
> > > that patch (fuse server gets stuck closing its own client's fds).
> > > Personally I think release ought to be synchronous at least as far as
> > > the kernel doing all the stuff that close() says it has to do (remova=
l
> > > of record locks, deleting the fd table entry).
> > >
> > > Note that doesn't necessarily mean that the kernel has to be complete=
ly
> > > done with all the work that entails.  XFS defers freeing of unlinked
> > > files until a background garbage collector gets around to doing that.
> > > Other filesystems will actually make you wait while they free all the
> > > data blocks and the inode.  But the kernel has no idea what the fuse
> > > server actually does.
> >
> > I guess if that's important enough to the server, we could add
> > something an FOPEN flag for that that servers could set on the file
> > handle if they want synchronous release?
>
> If a fuse server /did/ have background garbage collection, there are a
> few things it could do -- every time it sees a FUSE_RELEASE of an
> unlinked file, it could set a timer (say 50ms) after which it would kick
> the gc thread to do its thing.  Or it could do wake up the background
> thread in response to a FUSE_SYNCFS command and hope it finishes by the
> time FUSE_DESTROY comes around.
>
> (Speaking of which, can we enable syncfs for all fuse servers?)

I'm not sure what you mean by this - i thought the implementation of
FUSE_SYNCFS is dependent on each server's logic depending on if
they've set a callback for it or not? Speaking of which, it doesn't
look like FUSE_SYNCFS support has been added to libfuse yet.

>
> But that said, not everyone wants the fancy background gc stuff that XFS
> does.  FUSE_RELEASE would then be doing a lot of work.
>
> > after Amir's point about FUSE_FLUSH, I'm in favor now of FUSE_RELEASE
> > being asynchronous.
> > >
> > > > > Create a function to push all the background requests to the queu=
e and
> > > > > then wait for the number of pending events to hit zero, and call =
this
> > > > > before fuse_abort_conn.  That way, all the pending events are pro=
cessed
> > > > > by the fuse server and we don't end up with a corrupt filesystem.
> > > > >
> > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > ---
> > > > >  fs/fuse/fuse_i.h |    6 ++++++
> > > > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > > > >  fs/fuse/inode.c  |    1 +
> > > > >  3 files changed, 45 insertions(+)
> > > > >
> > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > +/*
> > > > > + * Flush all pending requests and wait for them.  Only call this=
 function when
> > > > > + * it is no longer possible for other threads to add requests.
> > > > > + */
> > > > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long tim=
eout)
> > > >
> > > > It might be worth renaming this to something like
> > > > 'fuse_flush_bg_requests' to make it more clear that this only flush=
es
> > > > background requests
> > >
> > > Hum.  Did I not understand the code correctly?  I thought that
> > > flush_bg_queue puts all the background requests onto the active queue
> > > and issues them to the fuse server; and the wait_event_timeout sits
> > > around waiting for all the requests to receive their replies?
> >
> > Sorry, didn't mean to be confusing with my previous comment. What I
> > was trying to say is that "fuse_flush_requests" implies that all
> > requests get flushed to userspace but here only the background
> > requests get flushed.
>
> Oh, I see now, I /was/ mistaken.  Synchronous requests are ...
>
> Wait, no, still confused :(
>
> fuse_flush_requests waits until fuse_conn::num_waiting is zero.
>
> Synchronous requests (aka the ones sent through fuse_simple_request)
> bump num_waiting either directly in the args->force case or indirectly
> via fuse_get_req.  num_waiting is decremented in fuse_put_request.
> Therefore waiting for num_waiting to hit zero implements waiting for all
> the requests that were in flight before fuse_flush_requests was called.
>
> Background requests (aka the ones sent via fuse_simple_background) have
> num_waiting set in the !args->force case or indirectly in
> fuse_request_queue_background.  num_waiting is decremented in
> fuse_put_request the same as is done for synchronous requests.
>
> Therefore, it's correct to say that waiting for num_requests to become 0
> is sufficient to wait for all pending requests anywhere in the
> fuse_mount to complete.

You're right, good point, waiting on fc->num_waiting =3D=3D 0 also ensures
foreground requests have been completed. sorry for the confusion!

Connections can also be aborted through the
/sys/fs/fuse/connections/*/abort interface or through request timeouts
(eg fuse_check_timeout()) - should those places too flush pending
requests and wait for them before aborting the connection?

>
> Right?
>
> Maybe this should be called fuse_flush_requests_and_wait. :)
>
> --D
>
> > Thanks,
> > Joanne
> > >
> > > I could be mistaken though.  This is my rough understanding of what
> > > happens to background requests:
> > >
> > > 1. Request created
> > > 2. Put request on bg_queue
> > > 3. <wait>
> > > 4. Request removed from bg_queue
> > > 5. Request sent
> > > 6. <wait>
> > > 7. Reply received
> > > 8. Request ends and is _put.
> > >
> > > Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
> > > fc->waiting tracks the number of requests that are anywhere between t=
he
> > > end of step 1 and the start of step 8.
> > >
> > > In any case, I want to push all the bg requests and wait until there =
are
> > > no more requests in the system.
> > >
> > > --D
> >

