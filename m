Return-Path: <linux-fsdevel+bounces-67364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE27C3D16E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 19:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0ADDB4E15BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826C34E771;
	Thu,  6 Nov 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1ipVNFR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F7266581
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 18:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762454276; cv=none; b=TSbLBbQqxY1yUf6xY3iAH4+t9jicVspDenABThefizL+d6v6OsnckQc0Sg8VE7X1IogVhBLgPqST3XJEH5tPz6nhbm0Ii+PbpeZKuuAav0IZO5UQPFXJDQ+G8NeKNSmbW422uHNeGvG8t7AQRJ2q87iQVESkpQ1rS7KNEDCiE/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762454276; c=relaxed/simple;
	bh=5256A5dPemD9unL1vf9PDE3Tc486BFQ5LY3G2WfEQSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=knlmhXqROHAsCoDBlr8BCyS3I1hutblnT3rVlbeZ5ps9LLVxP02zZ1u1phdKBLmzlt4aT4x1f7JQtjCWUQsLQYgGBlOMBGSm8VJcf0PKRKze+0anTN2+O6TWN+CprReZ49xc8DRNdn+1yY6rPfRr+jbYc1DMiYTvMXAbhgsG4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1ipVNFR; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed946ed3cdso833831cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Nov 2025 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762454273; x=1763059073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAcfA5hGRITzrUog7OQn42ys36qqdqkjwntx+V9q/Fw=;
        b=e1ipVNFR8iBf7EMph4SK4+ms2UiJIKSZvD41qP1U8w6J7dz9AsK6hdKEh5H/6wBYgi
         yUqZjKONwU8QWvTPJHR8+F2hysuHsBaBihUKejErhE2GwzuSyyuNx0Ick45syCbprH/2
         mEGqQAy2d3Evp1rfaZEYqlUtBI9FE9PUfG8L0UH171/nJ4JVL6Nw+WIpT/N8O71XPMMp
         zcFqNxuWijr9Sl4fURCe0jr9J0EmpuIz+byanTsFmRUck0DBcTQH+FCAxIbG46HVc8e8
         9zi4RRqRn1ehxacVmlSughLkQ2UAFO7RSl8CbaYQug9+unUrNAMfNnBpJdqUpUFkcQxv
         J7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762454273; x=1763059073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAcfA5hGRITzrUog7OQn42ys36qqdqkjwntx+V9q/Fw=;
        b=OhddAnP87PVYAU8bJm9RJqjqJqW/F4S0WV8QBsKzK73fdYgEX4hFLZ6ucsbTViNBOX
         dRUeWCcJ7OhMeXytmoThCw6vXY1IKA5T8D7vOUEYOSklXMQiGZnEOusX8ptgMaEp5iz0
         aJwEJjKn+wXy4saT/ePHtd/9qh14Gov0G23nSMnl/HwONAgHnZE154DnGdcJHCQTqVmZ
         T5O+CGMOklKIAWMz29zGe+khwjwdoqeJJz2n3XLMxY0xfznL5qaNiNvuSDsbw3G4QcSN
         WLMWt5y3eF1FPNTZ+CVoO9iaeVcNrgQTvAmnrP5sAHUGk2IUyadq3NiBAskgSPiqq6W1
         PPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3jnNdYevVH1rH1LV4a9htuQeNy9aDIzNFi9FmfXnF9DIq99p6iOcrPmH7RyVCaeWv3PkU+xEH9zomf21l@vger.kernel.org
X-Gm-Message-State: AOJu0YxQqosXt2AE5k3KOsQ/UaUPs3vVpaFsZhX3yiWWRnG1jjSGf14n
	h8nkp4yPsCOXYNGMA5r4vwDMsI3aTdh03gM3nADUM/tXfulbpkqpjqfrrH7mdBNt21LwpUrMlt2
	pWppwAztv8VBcVV8IEPVyPEPnleyV0yuOmg==
X-Gm-Gg: ASbGnct83M2dEYqxoqNSGcNo/vbvFGXDj7ajEYRq7GD2G8ekFzQd4AYcyRlZ1Vp+Z7M
	NWMuhczuijX3AlggC+Qy/Sa90HJIb/9VmVzMPOCyjwwBKOgj+Ud5SkRduzQE3wa5gwC6dqmMyrX
	XfoBHsTFbj2GutXB4jssXzDClQjWcbsLhJK2s+fDcdMYneFKBSpazWXQ+fnO8qAlDJ2tBeVpW5V
	wrMO0FlWn3mjarsWY3e+WKIdwgCcS/vjPfRecOlEa9f9r3mJQlAEY1y0B0FIglAEinictNnS1Ac
	mo6JbAUwpsAs/IY=
X-Google-Smtp-Source: AGHT+IGCT5uYAi+E/KO9PR8vUOiL+Sbq+e6eUFTipMXfVmXEZyLCtjAxd1VHC7sJlbJWXpfAGRlJl9y/IZ5Y1EdIZKU=
X-Received: by 2002:a05:622a:181b:b0:4eb:a2ab:4173 with SMTP id
 d75a77b69052e-4ed94a83e01mr2791101cf.55.1762454272893; Thu, 06 Nov 2025
 10:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176169809222.1424347.16562281526870178424.stgit@frogsfrogsfrogs>
 <176169809274.1424347.4813085698864777783.stgit@frogsfrogsfrogs>
 <CAJnrk1ZovORC=tLW-Q94XXY5M4i5WUd4CgRKEo7Lc7K2Sg+Kog@mail.gmail.com>
 <20251103221349.GE196370@frogsfrogsfrogs> <CAJnrk1a4d__8RHu0EGN2Yfk3oOhqZLJ7fBCNQYdHoThPrvnOaQ@mail.gmail.com>
 <20251106001730.GH196358@frogsfrogsfrogs>
In-Reply-To: <20251106001730.GH196358@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 6 Nov 2025 10:37:41 -0800
X-Gm-Features: AWmQ_blHHwjgoj4YBPsE1p2-riUELJq0Ojr0S5ikcN_ihAkE6Er53Dl2_I6M0lE
Message-ID: <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 4:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
>
> <snipping here because this thread has gotten very long>
>
> > > > > +       while (wait_event_timeout(fc->blocked_waitq,
> > > > > +                       !fc->connected || atomic_read(&fc->num_wa=
iting) =3D=3D 0,
> > > > > +                       HZ) =3D=3D 0) {
> > > > > +               /* empty */
> > > > > +       }
> > > >
> > > > I'm wondering if it's necessary to wait here for all the pending
> > > > requests to complete or abort?
> > >
> > > I'm not 100% sure what the fuse client shutdown sequence is supposed =
to
> > > be.  If someone kills a program with a large number of open unlinked
> > > files and immediately calls umount(), then the fuse client could be i=
n
> > > the process of sending FUSE_RELEASE requests to the server.
> > >
> > > [background info, feel free to speedread this paragraph]
> > > For a non-fuseblk server, unmount aborts all pending requests and
> > > disconnects the fuse device.  This means that the fuse server won't s=
ee
> > > all the FUSE_REQUESTs before libfuse calls ->destroy having observed =
the
> > > fusedev shutdown.  The end result is that (on fuse2fs anyway) you end=
 up
> > > with a lot of .fuseXXXXX files that nobody cleans up.
> > >
> > > If you make ->destroy release all the remaining open files, now you r=
un
> > > into a second problem, which is that if there are a lot of open unlin=
ked
> > > files, freeing the inodes can collectively take enough time that the
> > > FUSE_DESTROY request times out.
> > >
> > > On a fuseblk server with libfuse running in multithreaded mode, there
> > > can be several threads reading fuse requests from the fusedev.  The
> > > kernel actually sends its own FUSE_DESTROY request, but there's no
> > > coordination between the fuse workers, which means that the fuse serv=
er
> > > can process FUSE_DESTROY at the same time it's processing FUSE_RELEAS=
E.
> > > If ->destroy closes the filesystem before the FUSE_RELEASE requests a=
re
> > > processed, you end up with the same .fuseXXXXX file cleanup problem.
> >
> > imo it is the responsibility of the server to coordinate this and make
> > sure it has handled all the requests it has received before it starts
> > executing the destruction logic.
>
> I think we're all saying that some sort of fuse request reordering
> barrier is needed here, but there's at least three opinions about where
> that barrier should be implemented.  Clearly I think the barrier should
> be in the kernel, but let me think more about where it could go if it
> were somewhere else.
>
> First, Joanne's suggestion for putting it in the fuse server itself:
>
> I don't see how it's generally possible for the fuse server to know that
> it's processed all the requests that the kernel might have sent it.
> AFAICT each libfuse thread does roughly this:
>
> 1. read() a request from the fusedev fd
> 2. decode the request data and maybe do some allocations or transform it
> 3. call fuse server with request
> 4. fuse server does ... something with the request
> 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
>
> Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it find
> out if there are other fuse worker threads that are somewhere in steps
> 2 or 3?  AFAICT the library doesn't keep track of the number of threads
> that are waiting in fuse_session_receive_buf_internal, so fuse servers
> can't ask the library about that either.
>
> Taking a narrower view, it might be possible for the fuse server to
> figure this out by maintaining an open resource count.  It would
> increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
> decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE is
> the only kind of request that can be pending when a FUSE_DESTROY comes
> in, then destroy just has to wait for the counter to hit zero.

I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
if there are X worker threads that are all running fuse_do_work( )
then if you get a FUSE_DESTROY on one of those threads that thread can
set some se->destroyed field. At this point the other threads will
have already called fuse_session_receive_buf_internal() on all the
flushed background requests, so after they process it and return from
fuse_session_process_buf_internal(), then they check if se->destroyed
was set, and if it is they exit the thread, while in the thread that
got the FUSE_DESTROY it sleeps until all the threads have completed
and then it executes the destroy logic.That to me seems like the
cleanest approach.

>
> Is the above assumption correct?
>
> I don't see any fuse servers that actually *do* this, though.  I
> perceive that there are a lot of fuse servers out there that aren't
> packaged in Debian, though, so is this actually a common thing for
> proprietary fuse servers which I wouldn't know about?
>
> Downthread, Bernd suggested doing this in libfuse instead of making the
> fuse servers do it.  He asks:
>
> "There is something I don't understand though, how can FUSE_DESTROY
> happen before FUSE_RELEASE is completed?
>
> "->release / fuse_release
>    fuse_release_common
>       fuse_file_release
>          fuse_file_put
>             fuse_simple_background
>             <userspace>
>             <userspace-reply>
>                fuse_release_end
>                   iput()"
>
> The answer to this is: fuse_file_release is always asynchronous now, so
> the FUSE_RELEASE is queued to the background and the kernel moves on
> with its life.
>
> It's likely much more effective to put the reordering barrier in the
> library (ignoring all the vendored libfuse out there) assuming that the
> above assumption holds.  I think it wouldn't be hard to have _do_open
> (fuse_lowlevel.c) increment a counter in fuse_session, decrement it in
> _do_release, and then _do_destroy would wait for it to hit zero.
>
> For a single-threaded fuse server I think this might not even be an
> issue because the events are (AFAICT) processed in order.  However,
> you'd have to be careful about how you did that for a multithreaded fuse
> server.  You wouldn't want to spin in _do_destroy because that takes out
> a thread that could be doing work.  Is there a way to park a request?

If the background requests are flushed before the destroy request,
then this doesn't take out a thread because al the background requests
will already have been or are being serviced.

>
> Note that both of these approaches come with the risk that the kernel
> could decide to time out and abort the FUSE_DESTROY while the server is
> still waiting for the counter to hit zero.
>
> For a fuseblk filesystem this abort is very dangerous because the kernel
> releases its O_EXCL hold on the block device in kill_block_super before
> the fuse server has a chance to finish up and close the block device.
> The fuseblk server itself could not have opened the block device O_EXCL
> so that means there's a period where another process (or even another
> fuseblk mount) could open the bdev O_EXCL and both try to write to the
> block device.
>
> (I actually have been wondering who uses the fuse request timeouts?  In
> my testing even 30min wasn't sufficient to avoid aborts for some of the
> truncate/inactivation fstests.)

Meta uses fuse request timeouts. We saw a few cases of deadlocks in
some buggy fuse server implementations, so we now enforce default
timeouts. The timeout is set to a pretty large number though. Our main
use of it is to free/cleanup system resources if the server is
deadlocked.

If it takes 30 minutes to do all the cleanup, then I think it's worse
to have unmounting take that long, than to just do a quicker unmount
and have lingering unlinked files on the server. As a user, if I were
unmounting something and it took that long, I would probably just kill
the whole thing anyways.

>
> Aside: The reason why I abandoned making fuse2fs a fuseblk server is
> because I realized this exact trap -- the fuse server MUST have
> exclusive write access to the device at all times, or else it can race
> with other programs (e.g. tune2fs) and corrupt the filesystem.  In
> fuseblk mode the kernel owns the exclusive access and but doesn't
> install that file in the server's fd table.  At best the fuse server can
> pretend that it has exclusive write access, but the kernel can make that
> go away without telling the fuse server, which opens a world of hurt.
>
> > imo the only responsibility of the
> > kernel is to actually send the background requests before it sends the
> > FUSE_DESTROY. I think non-fuseblk servers should also receive the
> > FUSE_DESTROY request.
>
> They do receive it because fuse_session_destroy calls ->destroy if no
> event has been received from the kernel after the fusedev shuts down.
>
> > >
> > > Here, if you make a fuseblk server's ->destroy release all the remain=
ing
> > > open files, you have an even worse problem, because that could race w=
ith
> > > an existing libfuse worker that's processing a FUSE_RELEASE for the s=
ame
> > > open file.
> > >
> > > In short, the client has a FUSE_RELEASE request that pairs with the
> > > FUSE_OPEN request.  During regular operations, an OPEN always ends wi=
th
> > > a RELEASE.  I don't understand why unmount is special in that it abor=
ts
> > > release requests without even sending them to the server; that sounds
> > > like a bug to me.  Worse yet, I looked on Debian codesearch, and near=
ly
> > > all of the fuse servers I found do not appear to handle this correctl=
y.
> > > My guess is that it's uncommon to close 100,000 unlinked open files o=
n a
> > > fuse filesystem and immediately unmount it.  Network filesystems can =
get
> > > away with not caring.
> > >
> > > For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open fil=
es
> > > have been RELEASEd so that client can know that (a) the filesystem (a=
t
> > > least as far as the kernel cares) is quiesced, and (b) the server
> > > persisted all dirty metadata to disk.  Only then would I send the
> > > FUSE_DESTROY.
> >
> > Hmm, is FUSE_FLUSH not enough? As I recently learned (from Amir),
> > every close() triggers a FUSE_FLUSH. For dirty metadata related to
> > writeback, every release triggers a synchronous write_inode_now().
>
> It's not sufficient, because there might be other cached dirty metadata
> that needs to be flushed out to disk.  A fuse server could respond to a
> FUSE_FLUSH by pushing out that inode's dirty metadata to disk but go no
> farther.  Plumbing in FUSE_SYNCFS for iomap helps a lot in that regard
> because that's a signal that we need to push dirty ext4 bitmaps and
> group descriptors and whatnot out to storage; without it we end up doing
> all that at destroy time.
>
> > > > We are already guaranteeing that the
> > > > background requests get sent before we issue the FUSE_DESTROY, so i=
t
> > > > seems to me like this is already enough and we could skip the wait
> > > > because the server should make sure it completes the prior requests
> > > > it's received before it executes the destruction logic.
> > >
> > > That's just the thing -- fuse_conn_destroy calls fuse_abort_conn whic=
h
> > > aborts all the pending background requests so the server never sees
> > > them.
> >
> > The FUSE_DESTROY request gets sent before fuse_abort_conn() is called,
> > so to me, it seems like if we flush all the background requests and
> > then send the FUSE_DESTROY, that suffices.
>
> I think it's worse than that -- fuse_send_destroy sets fuse_args::force
> and sends the request synchronously, which (afaict) means it jumps ahead
> of the backgrounded requests.

Hmm, where are you seeing that? afaict, args->force forces the request
to be sent to userspace even if interrupted and it skips the
fuse_block_alloc() check.

Thanks,
Joanne

