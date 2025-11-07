Return-Path: <linux-fsdevel+bounces-67470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC91AC416BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 20:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1EB9534325B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 19:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F502FE58F;
	Fri,  7 Nov 2025 19:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rknm6f7I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01A83009F5
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Nov 2025 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543133; cv=none; b=WT+OVuMiZkACndzOXN2+7mV/ynqAmAwYZI6qkEp0eZ4MC068Y2wk1DKM3DN4bvPe3AtxZGJMPXKrLVie+2YJ6u+7GA98U0UbauILjCsXURM267DolDvcuJIv6WfI2gD2yIyEgfiq7UJ2EOaeCvdHZ7KVv2C+kgm28CjBELThodk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543133; c=relaxed/simple;
	bh=mLPe+fXmm2nvn9EJNZeGeOR3PuWikH1QMl89Uzqqtq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L35c1Dn5X8KtBWCvO8NagFguhhMquSe+gKBID9iC9ALJPBbRxZj9OcIwzNv92DrzSx/pgC90hrtbvCU+2kMyDbPIlpTjqDhr58HyOJcSWN0BzztYdQHVL3HDEEFeqiU9LxWLLOkYwHHDNydoVKMLoqyzoCPonnrtTXHaaWQkmLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rknm6f7I; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4eb75e8e47eso8683271cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Nov 2025 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543124; x=1763147924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApfWByii0qpgUHP4Xas3yFADBj9aHxmYzrGDOkruBpQ=;
        b=Rknm6f7Ixy9QLRyd6x0NRiqgQ+Jn96A4jLZkzDc4ER6XS78T3ILlo6gOxk/WfDeoO8
         KyCRipYB7qZ/iTZxeMHkC+guzijAvuFmuUZtqm6ZXuawDSgmUdx2y/Nz8qDFCjtgmC6L
         PBSLldM9+9uOjIKAc/Krefh+Tkwu9sDs4UTBhDbyIGXETuKSk+zH/GEDBhFJ++g4loHk
         bOwVjUrguTWkUk5Ep8tXl5bNR2rwmr3/P3NZNit97RX1TUi7DGIw/QaquQE4Zwm3gnJg
         t8Xlaq+veCuLwRuF2Z+AGZ5tZJ4lrdyGdqVIHZ/3ISiNRY8vlRf1eG94EW66U/iFFrxO
         CsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543124; x=1763147924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ApfWByii0qpgUHP4Xas3yFADBj9aHxmYzrGDOkruBpQ=;
        b=ucAT2qO9p5RB6VQXjcoj3G5QwT1wtHC6Y0keO/g2AqhECrqjV46kRoYEibV+owymLf
         TAswdcp84gxTMuv/ZOGe4ZudFYtfuciZy0c281lApy2qgorRNpe+b/zPLsEGIrfqsLd3
         ARR/0PVB8J/H2JyavSGM+CxxxSIc0dGB+2FRqsCOqNwnWn/xAUmTPqwtqRIxbgkt4bw5
         Xt4DOEmsNxhyjHtNmOa7xM958MaGTFSSI2eheZ1VDBovgfye4kIwhurUjdXl85KC+vNo
         W8G+Qt0Y+9VRhHAbj3cyV9kQaD5cJ1v/Azefgp3IZMw4dIsDawrBSzHEx10mGw0cwMXg
         jojQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa9jjNV+GtywbymmcpYEnoKX5QQ9lTH0ErLkyaN+XNUZdnATSoiAbNzOhimSRDZypiB6FIb3rcR23RXVNS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhyo60ouaejs2+Y29qxO3LK67gu/oBVs7l0hYGZNqPrEAoXAK7
	Idm4N2eXnaL7L+ZyRyxtvSgIA3ha1pvtzgQgp6yaR/y6K+xQK6f/SivOiNrjIFcHOtLprB8hAlL
	vGHsZhIxlpMblRZPDNDO7u+tYlZtigSw=
X-Gm-Gg: ASbGncv5y+ChbD5LulydOvdjCoLvZ7QPHvvzxAAze0x4uTjQnteQM4N/2Ylmd3/mFOk
	BbZCwf9xY6Nk4OOKUjR74O2VSQxXId9H3vi0SxdU8imnHdjgFNqwaxtyx+KiUxbinpliO1jL0MV
	i0PdC8oiJojr+zv+bLflneyhgeOkwihOizCTLy6mF/suSt0jI5dqXGoDcxPbfeCSLxUx/EjGrln
	dpP5u9hRDP8EgfmBmjeEUXEUgIS0mUAx3haaNWSnhbnseEK3P38vqHkXz66aAj6JgEMhJ1BYVZ3
	s8XBhV6CAHO/+Us=
X-Google-Smtp-Source: AGHT+IFxeeP9JEXA1aSO+JG1Qn+HJTqGwMuJH5Yqc79jXCgyX3rJqVTk9EcoRcaT4hzH0tIfgf01xhQ1JvcC8jbOXXY=
X-Received: by 2002:a05:622a:2c7:b0:4eb:a11e:4c1d with SMTP id
 d75a77b69052e-4eda416840bmr9496421cf.41.1762543123827; Fri, 07 Nov 2025
 11:18:43 -0800 (PST)
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
 <20251106001730.GH196358@frogsfrogsfrogs> <CAJnrk1Ycsw0pn+Qdo5+4adVrjha=ypofE_Wk0GwLwrandpjLeQ@mail.gmail.com>
 <20251107042619.GK196358@frogsfrogsfrogs>
In-Reply-To: <20251107042619.GK196358@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 7 Nov 2025 11:18:33 -0800
X-Gm-Features: AWmQ_bmsYFdus_wTZJBQ5HtDe1isAQOclJ9CWIIY4dcZ9b7vpsw51rj1Stpq78A
Message-ID: <CAJnrk1Yqy5t5U3Y3VHgdtTTaK7NRkDu0UBy4zGEnq=tvXEhoiQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, bernd@bsbernd.com, neal@gompa.dev, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 8:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.org> =
wrote:
>
> [I read this email backwards, like I do]
>
> On Thu, Nov 06, 2025 at 10:37:41AM -0800, Joanne Koong wrote:
> > On Wed, Nov 5, 2025 at 4:17=E2=80=AFPM Darrick J. Wong <djwong@kernel.o=
rg> wrote:
> > >
> > > On Tue, Nov 04, 2025 at 11:22:26AM -0800, Joanne Koong wrote:
> > >
> > > <snipping here because this thread has gotten very long>
> > >
> > > > > > > +       while (wait_event_timeout(fc->blocked_waitq,
> > > > > > > +                       !fc->connected || atomic_read(&fc->nu=
m_waiting) =3D=3D 0,
> > > > > > > +                       HZ) =3D=3D 0) {
> > > > > > > +               /* empty */
> > > > > > > +       }
> > > > > >
> > > > > > I'm wondering if it's necessary to wait here for all the pendin=
g
> > > > > > requests to complete or abort?
> > > > >
> > > > > I'm not 100% sure what the fuse client shutdown sequence is suppo=
sed to
> > > > > be.  If someone kills a program with a large number of open unlin=
ked
> > > > > files and immediately calls umount(), then the fuse client could =
be in
> > > > > the process of sending FUSE_RELEASE requests to the server.
> > > > >
> > > > > [background info, feel free to speedread this paragraph]
> > > > > For a non-fuseblk server, unmount aborts all pending requests and
> > > > > disconnects the fuse device.  This means that the fuse server won=
't see
> > > > > all the FUSE_REQUESTs before libfuse calls ->destroy having obser=
ved the
> > > > > fusedev shutdown.  The end result is that (on fuse2fs anyway) you=
 end up
> > > > > with a lot of .fuseXXXXX files that nobody cleans up.
> > > > >
> > > > > If you make ->destroy release all the remaining open files, now y=
ou run
> > > > > into a second problem, which is that if there are a lot of open u=
nlinked
> > > > > files, freeing the inodes can collectively take enough time that =
the
> > > > > FUSE_DESTROY request times out.
> > > > >
> > > > > On a fuseblk server with libfuse running in multithreaded mode, t=
here
> > > > > can be several threads reading fuse requests from the fusedev.  T=
he
> > > > > kernel actually sends its own FUSE_DESTROY request, but there's n=
o
> > > > > coordination between the fuse workers, which means that the fuse =
server
> > > > > can process FUSE_DESTROY at the same time it's processing FUSE_RE=
LEASE.
> > > > > If ->destroy closes the filesystem before the FUSE_RELEASE reques=
ts are
> > > > > processed, you end up with the same .fuseXXXXX file cleanup probl=
em.
> > > >
> > > > imo it is the responsibility of the server to coordinate this and m=
ake
> > > > sure it has handled all the requests it has received before it star=
ts
> > > > executing the destruction logic.
> > >
> > > I think we're all saying that some sort of fuse request reordering
> > > barrier is needed here, but there's at least three opinions about whe=
re
> > > that barrier should be implemented.  Clearly I think the barrier shou=
ld
> > > be in the kernel, but let me think more about where it could go if it
> > > were somewhere else.
> > >
> > > First, Joanne's suggestion for putting it in the fuse server itself:
> > >
> > > I don't see how it's generally possible for the fuse server to know t=
hat
> > > it's processed all the requests that the kernel might have sent it.
> > > AFAICT each libfuse thread does roughly this:
> > >
> > > 1. read() a request from the fusedev fd
> > > 2. decode the request data and maybe do some allocations or transform=
 it
> > > 3. call fuse server with request
> > > 4. fuse server does ... something with the request
> > > 5. fuse server finishes, hops back to libfuse / calls fuse_reply_XXX
> > >
> > > Let's say thread 1 is at step 4 with a FUSE_DESTROY.  How does it fin=
d
> > > out if there are other fuse worker threads that are somewhere in step=
s
> > > 2 or 3?  AFAICT the library doesn't keep track of the number of threa=
ds
> > > that are waiting in fuse_session_receive_buf_internal, so fuse server=
s
> > > can't ask the library about that either.
> > >
> > > Taking a narrower view, it might be possible for the fuse server to
> > > figure this out by maintaining an open resource count.  It would
> > > increment this counter when a FUSE_{OPEN,CREATE} request succeeds and
> > > decrement it when FUSE_RELEASE comes in.  Assuming that FUSE_RELEASE =
is
> > > the only kind of request that can be pending when a FUSE_DESTROY come=
s
> > > in, then destroy just has to wait for the counter to hit zero.
> >
> > I was thinking this logic could be in libfuse's fuse_loop_mt.c. Where
> > if there are X worker threads that are all running fuse_do_work( )
> > then if you get a FUSE_DESTROY on one of those threads that thread can
> > set some se->destroyed field. At this point the other threads will
> > have already called fuse_session_receive_buf_internal() on all the
> > flushed background requests, so after they process it and return from
> > fuse_session_process_buf_internal(), then they check if se->destroyed
> > was set, and if it is they exit the thread, while in the thread that
> > got the FUSE_DESTROY it sleeps until all the threads have completed
> > and then it executes the destroy logic.That to me seems like the
> > cleanest approach.
>
> Hrm.  Well now (scrolling to the bottom and back) that I know that the
> FUSE_DESTROY won't get put on the queue ahead of the FUSE_RELEASEs, I
> think that /could/ work.
>
> One tricky thing with having worker threads check a flag and exit is
> that they can be sleeping in the kernel (from _fuse_session_receive_buf)
> when the "just go away" flag gets set.  If the thread never wakes up,
> then it'll never exit.  In theory you could have the FUSE_DESTROY thread
> call pthread_cancel on all the other worker threads to eliminate them
> once they emerge from PTHREAD_CANCEL_DISABLE state, but I still have
> nightmares from adventures in pthread_cancel at Sun in 2002. :P
>
> Maybe an easier approach would be to have fuse_do_work increment a
> counter when it receives a buffer and decrement it when it finishes with
> that buffer.  The FUSE_DESTROY thread merely has to wait for that
> counter to reach 1, at which point it's the only thread with a request
> to process, so it can call do_destroy.  That at least would avoid adding
> a new user of pthread_cancel() into the mt loop code.
>
> > >
> > > Is the above assumption correct?
> > >
> > > I don't see any fuse servers that actually *do* this, though.  I
> > > perceive that there are a lot of fuse servers out there that aren't
> > > packaged in Debian, though, so is this actually a common thing for
> > > proprietary fuse servers which I wouldn't know about?
> > >
> > > Downthread, Bernd suggested doing this in libfuse instead of making t=
he
> > > fuse servers do it.  He asks:
> > >
> > > "There is something I don't understand though, how can FUSE_DESTROY
> > > happen before FUSE_RELEASE is completed?
> > >
> > > "->release / fuse_release
> > >    fuse_release_common
> > >       fuse_file_release
> > >          fuse_file_put
> > >             fuse_simple_background
> > >             <userspace>
> > >             <userspace-reply>
> > >                fuse_release_end
> > >                   iput()"
> > >
> > > The answer to this is: fuse_file_release is always asynchronous now, =
so
> > > the FUSE_RELEASE is queued to the background and the kernel moves on
> > > with its life.
> > >
> > > It's likely much more effective to put the reordering barrier in the
> > > library (ignoring all the vendored libfuse out there) assuming that t=
he
> > > above assumption holds.  I think it wouldn't be hard to have _do_open
> > > (fuse_lowlevel.c) increment a counter in fuse_session, decrement it i=
n
> > > _do_release, and then _do_destroy would wait for it to hit zero.
> > >
> > > For a single-threaded fuse server I think this might not even be an
> > > issue because the events are (AFAICT) processed in order.  However,
> > > you'd have to be careful about how you did that for a multithreaded f=
use
> > > server.  You wouldn't want to spin in _do_destroy because that takes =
out
> > > a thread that could be doing work.  Is there a way to park a request?
> >
> > If the background requests are flushed before the destroy request,
> > then this doesn't take out a thread because al the background requests
> > will already have been or are being serviced.
>
> <nod>
>
> I'm still concerned about a few things with the libfuse approach though.
> The kernel is the initiator, so it knows the data dependencies between
> requests.  Consequently, it's in the best position to know that if
> request R2 depends on R1, then it shouldn't issue R2 until it has
> received an acknowledgement for R1.  The fuse server is the target, it
> shouldn't be second-guessing what the initiator wants.
>
> The second concern is that if a request timeout is in effect, then all
> the time that libfuse spends waiting for other request to drain is
> charged to that request.  IOWs, if the timeout is 60s and libfuse holds
> the FUSE_DESTROY for 40s, the fuse server only has 20s to reply to the
> request whereas the sysadmin might have assumed that the server would
> have a full 60s to flush the filesystem and exit.
>
> If you're worried about no-timeout fuse servers hanging the unmount
> process, what about killing the fuse server?  Or telling the kernel to
> abort the connection?  Either should suffice to kill the wait_event
> loop.
>
> The third thing is that the iomap patchset will change the unmount
> request sequence:
>
> 1. <some number of FUSE_RELEASEs>
> 2. FUSE_SYNCFS to tell the fuse server to write all its dirty data
> 3. FUSE_DESTROY to close the filesystem

imo it's the responsibility of FUSE_DESTROY to write out any lingering
dirty data before tearing down state and there shouldn't need to be an
extra FUSE_SYNCFS issued before the destroy.

>
> If we put the ordering barrier in libfuse, then we'll have to modify
> libfuse to flush all of (1) before processing (2), and then wait for (2)
> to finish before processing (3).  But libfuse doesn't know that a
> particular FUSE_SYNCFS will be succeeded by a FUSE_DESTROY.  I could
> drop the SYNCFS and let DESTROY handle all the flushing.  But again, the
> kernel already knows the ordering that it requires, so it should enforce
> that ordering directly.
>
> (Sorry, I feel like I'm belaboring the point excessively, I'll stop)
>
> The libfuse approach /does/ have the small advantage that it can start
> working on the FUSE_DESTROY as soon as the other workers quiesce because
> it doesn't have to wait for the kernel to see the last FUSE_RELEASE
> reply and generate the DESTROY request.

imo the main advantage is that handling this in userspace offers
servers a lot more flexibility for controlling unmount/destroy
behavior. If we have this logic in the kernel, we're guaranteeing that
all previous requests must be completed (no matter how long they take)
before the server sees FUSE_DESTROY. For example if some servers in
the future want to prioritize fast unmounts over having lingering
unlinked files, then this allows for that. Or if the server wants to
write out data while RELEASE is happening, they can do that too
instead of having to wait for the RELEASE to finish.

I'm not sure if we even really do need to wait for RELEASE to finish
before replying back to the DESTROY request. For unlinking files and
writing data out to storage for example, can't you do all of that
still even after replying back to the DESTROY request? The connection
will be aborted but that seems fine, that just means the client can't
communicate with the server. This would let the unmount finish quickly
while meanwhile the server logic can run still even after the unmount
/ connection abort, and the server could then do/finish all the
unlinking logic / writing to storage. Then when all of that is
finished, the server could officially clean everything up and exit.


>
> > > Note that both of these approaches come with the risk that the kernel
> > > could decide to time out and abort the FUSE_DESTROY while the server =
is
> > > still waiting for the counter to hit zero.
> > >
> > > For a fuseblk filesystem this abort is very dangerous because the ker=
nel
> > > releases its O_EXCL hold on the block device in kill_block_super befo=
re
> > > the fuse server has a chance to finish up and close the block device.
> > > The fuseblk server itself could not have opened the block device O_EX=
CL
> > > so that means there's a period where another process (or even another
> > > fuseblk mount) could open the bdev O_EXCL and both try to write to th=
e
> > > block device.
> > >
> > > (I actually have been wondering who uses the fuse request timeouts?  =
In
> > > my testing even 30min wasn't sufficient to avoid aborts for some of t=
he
> > > truncate/inactivation fstests.)
> >
> > Meta uses fuse request timeouts. We saw a few cases of deadlocks in
> > some buggy fuse server implementations, so we now enforce default
> > timeouts. The timeout is set to a pretty large number though. Our main
> > use of it is to free/cleanup system resources if the server is
> > deadlocked.
>
> If you can share, how long of a timeout?  I've noticed that some clouds
> set their iscsi timeouts to 12h or more(!) and that's for a single SCSI
> command.

Right now the default is 30 minutes.

Thanks,
Joanne

>
> > If it takes 30 minutes to do all the cleanup, then I think it's worse
> > to have unmounting take that long, than to just do a quicker unmount
>
> If you don't handle unlinked lists in a O(n) (or O(1) way) then
> unprivileged userspace programs can manipulate the filesystem so that it
> actually /can/ take hours to unmount.  XFS, ext4, and now fuse4fs have
> learned that the hard way. ;)
>
> > and have lingering unlinked files on the server. As a user, if I were
> > unmounting something and it took that long, I would probably just kill
> > the whole thing anyways.
>
> That very much depends on what you're going to do with that filesystem.
> If you're disposing of a container then, meh, fire away.  Some people
> "use" FS_IOC_SHUTDOWN to "terminate" containers quickly.
>
> > >
> > > Aside: The reason why I abandoned making fuse2fs a fuseblk server is
> > > because I realized this exact trap -- the fuse server MUST have
> > > exclusive write access to the device at all times, or else it can rac=
e
> > > with other programs (e.g. tune2fs) and corrupt the filesystem.  In
> > > fuseblk mode the kernel owns the exclusive access and but doesn't
> > > install that file in the server's fd table.  At best the fuse server =
can
> > > pretend that it has exclusive write access, but the kernel can make t=
hat
> > > go away without telling the fuse server, which opens a world of hurt.
> > >
> > > > imo the only responsibility of the
> > > > kernel is to actually send the background requests before it sends =
the
> > > > FUSE_DESTROY. I think non-fuseblk servers should also receive the
> > > > FUSE_DESTROY request.
> > >
> > > They do receive it because fuse_session_destroy calls ->destroy if no
> > > event has been received from the kernel after the fusedev shuts down.
> > >
> > > > >
> > > > > Here, if you make a fuseblk server's ->destroy release all the re=
maining
> > > > > open files, you have an even worse problem, because that could ra=
ce with
> > > > > an existing libfuse worker that's processing a FUSE_RELEASE for t=
he same
> > > > > open file.
> > > > >
> > > > > In short, the client has a FUSE_RELEASE request that pairs with t=
he
> > > > > FUSE_OPEN request.  During regular operations, an OPEN always end=
s with
> > > > > a RELEASE.  I don't understand why unmount is special in that it =
aborts
> > > > > release requests without even sending them to the server; that so=
unds
> > > > > like a bug to me.  Worse yet, I looked on Debian codesearch, and =
nearly
> > > > > all of the fuse servers I found do not appear to handle this corr=
ectly.
> > > > > My guess is that it's uncommon to close 100,000 unlinked open fil=
es on a
> > > > > fuse filesystem and immediately unmount it.  Network filesystems =
can get
> > > > > away with not caring.
> > > > >
> > > > > For fuse+iomap, I want unmount to send FUSE_SYNCFS after all open=
 files
> > > > > have been RELEASEd so that client can know that (a) the filesyste=
m (at
> > > > > least as far as the kernel cares) is quiesced, and (b) the server
> > > > > persisted all dirty metadata to disk.  Only then would I send the
> > > > > FUSE_DESTROY.
> > > >
> > > > Hmm, is FUSE_FLUSH not enough? As I recently learned (from Amir),
> > > > every close() triggers a FUSE_FLUSH. For dirty metadata related to
> > > > writeback, every release triggers a synchronous write_inode_now().
> > >
> > > It's not sufficient, because there might be other cached dirty metada=
ta
> > > that needs to be flushed out to disk.  A fuse server could respond to=
 a
> > > FUSE_FLUSH by pushing out that inode's dirty metadata to disk but go =
no
> > > farther.  Plumbing in FUSE_SYNCFS for iomap helps a lot in that regar=
d
> > > because that's a signal that we need to push dirty ext4 bitmaps and
> > > group descriptors and whatnot out to storage; without it we end up do=
ing
> > > all that at destroy time.
> > >
> > > > > > We are already guaranteeing that the
> > > > > > background requests get sent before we issue the FUSE_DESTROY, =
so it
> > > > > > seems to me like this is already enough and we could skip the w=
ait
> > > > > > because the server should make sure it completes the prior requ=
ests
> > > > > > it's received before it executes the destruction logic.
> > > > >
> > > > > That's just the thing -- fuse_conn_destroy calls fuse_abort_conn =
which
> > > > > aborts all the pending background requests so the server never se=
es
> > > > > them.
> > > >
> > > > The FUSE_DESTROY request gets sent before fuse_abort_conn() is call=
ed,
> > > > so to me, it seems like if we flush all the background requests and
> > > > then send the FUSE_DESTROY, that suffices.
> > >
> > > I think it's worse than that -- fuse_send_destroy sets fuse_args::for=
ce
> > > and sends the request synchronously, which (afaict) means it jumps ah=
ead
> > > of the backgrounded requests.
> >
> > Hmm, where are you seeing that? afaict, args->force forces the request
> > to be sent to userspace even if interrupted and it skips the
> > fuse_block_alloc() check.
>
> Oh!  You're right, the FUSE_DESTROY request is list_add_tail'd to
> fiq->pending, just like every other req, because they all go through
> fuse_dev_queue_req.  Sorry about misreading that, but thank /you/ for
> pointing it out! :)
>
> --D
>
> > Thanks,
> > Joanne
> >

