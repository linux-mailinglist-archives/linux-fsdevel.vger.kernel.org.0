Return-Path: <linux-fsdevel+bounces-55884-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F4EB0F805
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 18:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D80E1C83322
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489131EB5E1;
	Wed, 23 Jul 2025 16:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdNBj3cR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD261C1AAA
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753287895; cv=none; b=qsrRxp64weOXrwoWn6bmtfFsI4OjMkCD7jljc/6lSXm2HOdVM1+AKa3UA272hMoNRPQvxsho+MVb65JwqVG704uqlETnMMPFHE/TTpGvKGpe0Y8AVZ5Rj6OMka7XaP622e7y3A4IeCgxT/i6PvFBgMxICG4juTzaDCru8qKXlzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753287895; c=relaxed/simple;
	bh=8gfWWaDSmz2rr6uIgp4SvCu3HrhxdOeg0iDYPuGejpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eD74bQdOxjP/hwiaiFkA+UqbX5tsmlBfDxqfm8anDjNJT73EORxSN+a7ZKhG+cljtLatEm8lx6B+XUKmpa5Z+T6tb6T9pofZhN0bFcsWGxpE/ebhWwMIgMR7oqR2uxxm3gDzveMEz/ignZkHC4YX3mPIdngCt0vfuQHtX+G1Wfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdNBj3cR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE8AC4CEE7;
	Wed, 23 Jul 2025 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753287895;
	bh=8gfWWaDSmz2rr6uIgp4SvCu3HrhxdOeg0iDYPuGejpo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=MdNBj3cRHb/TuSABQt/AQ5M7WYi4sp+IZXfrsiGPCRhiZYYhFNUy5DUkm52DeB/hz
	 IyyhWuqr1KGXxsJcofCXE/z6rtUXf1isoFYeZM/CNFMTf+Otde1I2z4j1DQofLhcTv
	 UqMxCq47t+BO7xUN3xxsuFPXxWci15cGMp/eli7GJJOW0E0ArYk3YCGwJUuUm+S5jp
	 Ese7AJyd9zyJWhxIOgT9W84t7T6ZD3KOH/oETGT1WDBHncrRSMK3YK7hJLsxkdhMcz
	 UcM/r5QVMi7rwkST7VbcVeyKOfh/hJRlrlLNlgywQBTPZFIrfsOpH2O9SYn9tcuG+D
	 vNXx3m8lHslTQ==
Message-ID: <96df21fad772cfe2dbe736a22aaf18384c6a5205.camel@kernel.org>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the
 connection
From: Jeff Layton <jlayton@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	neal@gompa.dev, John@groves.net, miklos@szeredi.hu, bernd@bsbernd.com
Date: Wed, 23 Jul 2025 12:24:53 -0400
In-Reply-To: <20250723153742.GH2672029@frogsfrogsfrogs>
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
	 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
	 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com>
	 <20250719003215.GG2672029@frogsfrogsfrogs>
	 <5ba49b0ff30f4e4f44440d393359a06a2515ab20.camel@kernel.org>
	 <fda653661ea160cc65bd217c450c5291a7d3f3b1.camel@kernel.org>
	 <20250723153742.GH2672029@frogsfrogsfrogs>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-23 at 08:37 -0700, Darrick J. Wong wrote:
> On Tue, Jul 22, 2025 at 08:38:08AM -0400, Jeff Layton wrote:
> > On Tue, 2025-07-22 at 08:30 -0400, Jeff Layton wrote:
> > > On Fri, 2025-07-18 at 17:32 -0700, Darrick J. Wong wrote:
> > > > On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > > > > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@k=
ernel.org> wrote:
> > > > > >=20
> > > > > > From: Darrick J. Wong <djwong@kernel.org>
> > > > > >=20
> > > > > > generic/488 fails with fuse2fs in the following fashion:
> > > > > >=20
> > > > > > generic/488       _check_generic_filesystem: filesystem on /dev=
/sdf is inconsistent
> > > > > > (see /var/tmp/fstests/generic/488.full for details)
> > > > > >=20
> > > > > > This test opens a large number of files, unlinks them (which re=
ally just
> > > > > > renames them to fuse hidden files), closes the program, unmount=
s the
> > > > > > filesystem, and runs fsck to check that there aren't any incons=
istencies
> > > > > > in the filesystem.
> > > > > >=20
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
> > > > >=20
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
> > > >=20
> > > > I don't think supplying a return value for close() is as helpful as=
 it
> > > > seems -- the manage says that there is no guarantee that data has b=
een
> > > > flushed to disk; and if the file is removed from the process' fd ta=
ble
> > > > then the operation succeeded no matter the return value. :P
> > > >=20
> > > > (Also C programmers tend to be sloppy and not check the return valu=
e.)
> > > >=20
> > >=20
> > > The POSIX spec and manpage for close(2) make no mention of writeback
> > > errors, so it's not 100% clear that returning them there is at all OK=
.
> > > Everyone sort of assumes that it makes sense to do so, but it can be
> > > actively harmful.
> > >=20
> >=20
> > Actually, they do mention this, but I still argue that it's not a good
> > idea to do so. If you want writeback errors use fsync() (or maybe the
> > new ioctl() that someone was plumbing in that scrapes errors without
> > doing writeback).
> >=20
> > > Suppose we do this:
> > >=20
> > > open() =3D 1
> > > write(1)
> > > close(1)=C2=A0
> > > open() =3D 2
> > > fsync(2) =3D ???
> > >=20
> > > Now, assume there was a writeback error that happens either before or
> > > after the close.
> > >=20
> > > With the way this works today, you will get back an error on that fin=
al
> > > fsync() even if fd 2 was opened _after_ the writeback error occurred,
> > > because nothing will have scraped it yet.
> > >=20
> > > If you scrape the error to return it on the close though, then the
> > > result of that fsync() would be inconclusive. If the error happens
> > > before the close(), then fsync() will return 0. If it fails after the
> > > close(), then the fsync() will see an error.
>=20
> <nod> Given the horrible legacy of C programmers not really checking the
> return value from close(), I think that /if/ the kernel is going to
> check for writeback errors at close, it should sample the error state
> but not clear it, so that the fsync returns accumulated errors.
>=20
> (That said, my opinion is that after years of all of us telling
> programmers that fsync is the golden standard for checking if bad stuff
> happened, we really ought only be clearing error state during fsync.)
>=20

That is pretty doable. The only question is whether it's something we
*want* to do. Something like this would probably be enough if so:

diff --git a/fs/open.c b/fs/open.c
index 7828234a7caa..a20657a85ee1 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1582,6 +1582,10 @@ SYSCALL_DEFINE1(close, unsigned int, fd)
=20
        retval =3D filp_flush(file, current->files);
=20
+       /* Do an opportunistic writeback error check before returning. */
+       if (likely(retval =3D=3D 0))
+               retval =3D filemap_check_wb_err(file_inode(file)->i_mapping=
, file->f_wb_err);
+
        /*
         * We're returning to user space. Don't bother
         * with any delayed fput() cases.


> Evidently some projects do fsync-after-open assuming that close doesn't
> flush and wait for writeback:
> https://despairlabs.com/blog/posts/2025-03-13-fsync-after-open-is-an-elab=
orate-no-op/
>
> > > > > data; that also has clearer API semantics imo, eg users are guara=
nteed
> > > > > that when close() returns, all the processing/cleanup for that fi=
le
> > > > > has been completed.  Async FUSE_RELEASE also seems kind of racy, =
eg if
> > > > > the server holds local locks that get released in FUSE_RELEASE, i=
f a
> > > >=20
> > > > Yes.  I think it's only useful for the case outined in that patch, =
which
> > > > is that a program started an asyncio operation and then closed the =
fd.
> > > > In that particular case the program unambiguously doesn't care abou=
t the
> > > > return value of close so it's ok to perform the release asynchronou=
sly.
> > > >=20
> > > > > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > > > > grabbing that lock, then we end up deadlocked if the server is
> > > > > single-threaded.
> > > >=20
> > > > Hrm.  I suppose if you had a script that ran two programs one after=
 the
> > > > other, each of which expected to be able to open and lock the same =
file,
> > > > then you could run into problems if the lock isn't released by the =
time
> > > > the second program is ready to open the file.
> > > >=20
> > > > But having said that, some other program could very well open and l=
ock
> > > > the file as soon as the lock drops.
> > > >=20
> > > > > I saw in your first patch that sending FUSE_RELEASE synchronously
> > > > > leads to a deadlock under AIO but AFAICT, that happens because we
> > > > > execute req->args->end() in fuse_request_end() synchronously; I t=
hink
> > > > > if we execute that release asynchronously on a worker thread then=
 that
> > > > > gets rid of the deadlock.
> > > >=20
> > > > <nod> Last time I think someone replied that maybe they should all =
be
> > > > asynchronous.
> > > >=20
> > > > > If FUSE_RELEASE must be asynchronous though, then your approach m=
akes
> > > > > sense to me.
> > > >=20
> > > > I think it only has to be asynchronous for the weird case outlined =
in
> > > > that patch (fuse server gets stuck closing its own client's fds).
> > > > Personally I think release ought to be synchronous at least as far =
as
> > > > the kernel doing all the stuff that close() says it has to do (remo=
val
> > > > of record locks, deleting the fd table entry).
> > > >=20
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
> > > >=20
> > > > > > Create a function to push all the background requests to the qu=
eue and
> > > > > > then wait for the number of pending events to hit zero, and cal=
l this
> > > > > > before fuse_abort_conn.  That way, all the pending events are p=
rocessed
> > > > > > by the fuse server and we don't end up with a corrupt filesyste=
m.
> > > > > >=20
> > > > > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > > > ---
> > > > > >  fs/fuse/fuse_i.h |    6 ++++++
> > > > > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > > > > >  fs/fuse/inode.c  |    1 +
> > > > > >  3 files changed, 45 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > +/*
> > > > > > + * Flush all pending requests and wait for them.  Only call th=
is function when
> > > > > > + * it is no longer possible for other threads to add requests.
> > > > > > + */
> > > > > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long t=
imeout)
> > > > >=20
> > > > > It might be worth renaming this to something like
> > > > > 'fuse_flush_bg_requests' to make it more clear that this only flu=
shes
> > > > > background requests
> > > >=20
> > > > Hum.  Did I not understand the code correctly?  I thought that
> > > > flush_bg_queue puts all the background requests onto the active que=
ue
> > > > and issues them to the fuse server; and the wait_event_timeout sits
> > > > around waiting for all the requests to receive their replies?
> > > >=20
> > > > I could be mistaken though.  This is my rough understanding of what
> > > > happens to background requests:
> > > >=20
> > > > 1. Request created
> > > > 2. Put request on bg_queue
> > > > 3. <wait>
> > > > 4. Request removed from bg_queue
> > > > 5. Request sent
> > > > 6. <wait>
> > > > 7. Reply received
> > > > 8. Request ends and is _put.
> > > >=20
> > > > Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
> > > > fc->waiting tracks the number of requests that are anywhere between=
 the
> > > > end of step 1 and the start of step 8.
> > > >=20
> > > > In any case, I want to push all the bg requests and wait until ther=
e are
> > > > no more requests in the system.
> > > >=20
> > > > --D
> >=20
> > --=20
> > Jeff Layton <jlayton@kernel.org>
> >=20

--=20
Jeff Layton <jlayton@kernel.org>

