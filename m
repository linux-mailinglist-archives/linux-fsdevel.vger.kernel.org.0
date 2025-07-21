Return-Path: <linux-fsdevel+bounces-55619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72991B0CBDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 22:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97E187A8945
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F5C23A9AB;
	Mon, 21 Jul 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFiWxck1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244D47DA7F
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753129977; cv=none; b=Aj7ZeFY0HScJys052u0NxAfTL/6St3A82uqKrMAGRX8HQhzaDmTeMWl6ktDhadNZwa1s88EE6P6vwKd6Phc2l2XaaUq2M0BNkP08xa0tm4Kw73POD+o645WTNzh+bblk53jF9TtgN/cGVCcdXKq6f+TaAmPDQmQWVr+ifn/kuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753129977; c=relaxed/simple;
	bh=tPr1SjRDi7EufhadB2BFOPU6927OJJcbq9+U1IFZlGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6XIry48bwEmD2x5zumKMqcz4g/U7gsWhmidoCe17g/IsPkQbqOTvBPxhbR/esEtfGtJ5Ml3VidSLgXUHLyDlwk4qgnSSbY/HjbNXFINXaLLFPSr4wcxYpQauAyJkGSCA119xg8T2ylnqikKvltANlQ6gjmHIik6yxpOu1Hz1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFiWxck1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ab71ac933eso38472841cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 13:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753129975; x=1753734775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFQOpMlImmOQ3o67C+NJNCUg92tLIZRoWzEs9hQYX5o=;
        b=bFiWxck1f6d54V4eBCyqGKiCYT2S53Cr/TzxcmVFh2C+seq0h1GmDtJUGhMZXRpaUG
         3x+wIvAKYFdNqTprTh+x7OHkloeCNM1Hev9d/0DLRCftVqG7fNzukuVQZ4fZzpyLHVrv
         r/UeTbTFTUTaL1m5DOktXjunJK1SipijVdHq2k9SRC/38vIFn33nT/oJZuetUkFrm0uz
         KA7/yH8fjhsZksUXXLepAMlrS0dgOuYytY1mxiWxD5zj2gVPafidweom2WTsVhNyaQ+5
         W1jYTdMdYkMInU1o+Ke9URr5yrsDtRzNh2MFuEJR5SC8UrukyP/MAQUzYYFhc7tsAigC
         XkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753129975; x=1753734775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFQOpMlImmOQ3o67C+NJNCUg92tLIZRoWzEs9hQYX5o=;
        b=qYJcTR+UOj7LfV7+17BfbJOrc6ri0xOSeUeZvVKijDlFQm6l53aCHbkGQ/dT8gfBWm
         VU1pkFajT/J2s2KtVRyJ6rHS7hxoF0Pn89PcPt1NlODDOGB0haytp2Zg1RKBkjq8/ASu
         Yn3LTA4h1DLhqAJURsiNDHa6dUqHpUU3r+lS4YejVJuNFA5jKFYwJRmgu+m5GMUHci5/
         9K+IKRYmfJcc7FNCIUUQDFrP4JRLNvJMe8t2aYVerNqojesT2f24+pAo4h0EOLaWXCn3
         JF4DAUM8llgbUcMMDPeCfJHWR3zOE5yDt5OPK38FqKIsJSwTIS572zAA0DESf5xTaXQ/
         r1mA==
X-Gm-Message-State: AOJu0Yy1s1ouOhXQtYBYvdCcOnA1Lvfa9y9wbWS1pkxbQgiJsScRbe2j
	yiekzIhSfSfPNUhxYNSl/B1YBvbDW1iOvQPv3VZuojao3h15L8rziPKt/WDTYdhrMCuzL2Bg3Pd
	l2Azu3903wj9tOB5ggpvf8qfAAqbuc/0=
X-Gm-Gg: ASbGnctbL4P6waGWG736H7hOru3t2IkBubyX/vmFsvHVnc6zNCecZBsWuFI0ypQsD5h
	JQjvpSOzQ8BBo9u2VaEOcvznLmNYB5s0tGRF7znmPDvC3hN/De7y6NI6WLRKhNxn/yW2dvIwIE1
	OKiOo0X2qftEgXuq27+wXRhNSzDpP1ezCjz2FE+s0Wjyeb1gJze3JIGSZwrFSvXPTye93k3dco7
	tT1ON33lu2oi225YWy+Vg==
X-Google-Smtp-Source: AGHT+IH2uDiin8TJtFO8c20YtPosV62kciEHYe7dTuCNT4fBbYhBVjXLnYvhQWTPG87BvCY/LmYsYiNE+dVJE6+iWdY=
X-Received: by 2002:a05:622a:1a83:b0:4a4:41a1:b944 with SMTP id
 d75a77b69052e-4ab93c6ebbamr337138511cf.1.1753129974798; Mon, 21 Jul 2025
 13:32:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175279449418.710975.17923641852675480305.stgit@frogsfrogsfrogs>
 <175279449501.710975.16858401145201411486.stgit@frogsfrogsfrogs>
 <CAJnrk1YeJPdtHMDatQvg8mDPYx4fgkeUCrBgBR=8zFMpOn3q0A@mail.gmail.com> <20250719003215.GG2672029@frogsfrogsfrogs>
In-Reply-To: <20250719003215.GG2672029@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 21 Jul 2025 13:32:43 -0700
X-Gm-Features: Ac12FXwvG2zNp6I0bTQqB8HBJI_5G5cKWD1sJKWbkIZ1j_q2oOjTYbOLSKvRbQk
Message-ID: <CAJnrk1YvGrgJK6qd0UPMzNUxyJ6QwY2b-HRhsj5QVrHsLxuQmQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: flush pending fuse events before aborting the connection
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, John@groves.net, 
	miklos@szeredi.hu, bernd@bsbernd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 5:32=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Fri, Jul 18, 2025 at 03:23:30PM -0700, Joanne Koong wrote:
> > On Thu, Jul 17, 2025 at 4:26=E2=80=AFPM Darrick J. Wong <djwong@kernel.=
org> wrote:
> > >
> > > From: Darrick J. Wong <djwong@kernel.org>
> > >
> > > generic/488 fails with fuse2fs in the following fashion:
> > >
> > > generic/488       _check_generic_filesystem: filesystem on /dev/sdf i=
s inconsistent
> > > (see /var/tmp/fstests/generic/488.full for details)
> > >
> > > This test opens a large number of files, unlinks them (which really j=
ust
> > > renames them to fuse hidden files), closes the program, unmounts the
> > > filesystem, and runs fsck to check that there aren't any inconsistenc=
ies
> > > in the filesystem.
> > >
> > > Unfortunately, the 488.full file shows that there are a lot of hidden
> > > files left over in the filesystem, with incorrect link counts.  Traci=
ng
> > > fuse_request_* shows that there are a large number of FUSE_RELEASE
> > > commands that are queued up on behalf of the unlinked files at the ti=
me
> > > that fuse_conn_destroy calls fuse_abort_conn.  Had the connection not
> > > aborted, the fuse server would have responded to the RELEASE commands=
 by
> > > removing the hidden files; instead they stick around.
> >
> > Tbh it's still weird to me that FUSE_RELEASE is asynchronous instead
> > of synchronous. For example for fuse servers that cache their data and
> > only write the buffer out to some remote filesystem when the file gets
> > closed, it seems useful for them to (like nfs) be able to return an
> > error to the client for close() if there's a failure committing that
>
> I don't think supplying a return value for close() is as helpful as it
> seems -- the manage says that there is no guarantee that data has been
> flushed to disk; and if the file is removed from the process' fd table
> then the operation succeeded no matter the return value. :P
>
> (Also C programmers tend to be sloppy and not check the return value.)

Amir pointed out FUSE_FLUSH gets sent on the FUSE_RELEASE path so that
addresses my worry. FUSE_FLUSH is sent synchronously (and close() will
propagate any flush errors too), so now if there's an abort or
something right after close() returns, the client is guaranteed that
any data they wrote into a local cache has been flushed by the server.

>
> > data; that also has clearer API semantics imo, eg users are guaranteed
> > that when close() returns, all the processing/cleanup for that file
> > has been completed.  Async FUSE_RELEASE also seems kind of racy, eg if
> > the server holds local locks that get released in FUSE_RELEASE, if a
>
> Yes.  I think it's only useful for the case outined in that patch, which
> is that a program started an asyncio operation and then closed the fd.
> In that particular case the program unambiguously doesn't care about the
> return value of close so it's ok to perform the release asynchronously.

I wonder why fuseblk devices need to be synchronously released. The
comment says " Make the release synchronous if this is a fuseblk
mount, synchronous RELEASE is allowed (and desirable)". Why is it
desirable?

>
> > subsequent FUSE_OPEN happens before FUSE_RELEASE then depends on
> > grabbing that lock, then we end up deadlocked if the server is
> > single-threaded.
>
> Hrm.  I suppose if you had a script that ran two programs one after the
> other, each of which expected to be able to open and lock the same file,
> then you could run into problems if the lock isn't released by the time
> the second program is ready to open the file.

I think in your scenario with the two programs, the worst outcome is
that the open/lock acquiring can take a while but in the (contrived
and probably far-fetched) scenario where it's single threaded, it
would result in a complete deadlock.

>
> But having said that, some other program could very well open and lock
> the file as soon as the lock drops.
>
> > I saw in your first patch that sending FUSE_RELEASE synchronously
> > leads to a deadlock under AIO but AFAICT, that happens because we
> > execute req->args->end() in fuse_request_end() synchronously; I think
> > if we execute that release asynchronously on a worker thread then that
> > gets rid of the deadlock.
>
> <nod> Last time I think someone replied that maybe they should all be
> asynchronous.
>
> > If FUSE_RELEASE must be asynchronous though, then your approach makes
> > sense to me.
>
> I think it only has to be asynchronous for the weird case outlined in
> that patch (fuse server gets stuck closing its own client's fds).
> Personally I think release ought to be synchronous at least as far as
> the kernel doing all the stuff that close() says it has to do (removal
> of record locks, deleting the fd table entry).
>
> Note that doesn't necessarily mean that the kernel has to be completely
> done with all the work that entails.  XFS defers freeing of unlinked
> files until a background garbage collector gets around to doing that.
> Other filesystems will actually make you wait while they free all the
> data blocks and the inode.  But the kernel has no idea what the fuse
> server actually does.

I guess if that's important enough to the server, we could add
something an FOPEN flag for that that servers could set on the file
handle if they want synchronous release?

after Amir's point about FUSE_FLUSH, I'm in favor now of FUSE_RELEASE
being asynchronous.
>
> > > Create a function to push all the background requests to the queue an=
d
> > > then wait for the number of pending events to hit zero, and call this
> > > before fuse_abort_conn.  That way, all the pending events are process=
ed
> > > by the fuse server and we don't end up with a corrupt filesystem.
> > >
> > > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> > > ---
> > >  fs/fuse/fuse_i.h |    6 ++++++
> > >  fs/fuse/dev.c    |   38 ++++++++++++++++++++++++++++++++++++++
> > >  fs/fuse/inode.c  |    1 +
> > >  3 files changed, 45 insertions(+)
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > +/*
> > > + * Flush all pending requests and wait for them.  Only call this fun=
ction when
> > > + * it is no longer possible for other threads to add requests.
> > > + */
> > > +void fuse_flush_requests(struct fuse_conn *fc, unsigned long timeout=
)
> >
> > It might be worth renaming this to something like
> > 'fuse_flush_bg_requests' to make it more clear that this only flushes
> > background requests
>
> Hum.  Did I not understand the code correctly?  I thought that
> flush_bg_queue puts all the background requests onto the active queue
> and issues them to the fuse server; and the wait_event_timeout sits
> around waiting for all the requests to receive their replies?

Sorry, didn't mean to be confusing with my previous comment. What I
was trying to say is that "fuse_flush_requests" implies that all
requests get flushed to userspace but here only the background
requests get flushed.

Thanks,
Joanne
>
> I could be mistaken though.  This is my rough understanding of what
> happens to background requests:
>
> 1. Request created
> 2. Put request on bg_queue
> 3. <wait>
> 4. Request removed from bg_queue
> 5. Request sent
> 6. <wait>
> 7. Reply received
> 8. Request ends and is _put.
>
> Non-background (foreground?) requests skip steps 2-4.  Meanwhile,
> fc->waiting tracks the number of requests that are anywhere between the
> end of step 1 and the start of step 8.
>
> In any case, I want to push all the bg requests and wait until there are
> no more requests in the system.
>
> --D

