Return-Path: <linux-fsdevel+bounces-63832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91467BCEFA3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 06:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3994C4E77A2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Oct 2025 04:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA198B663;
	Sat, 11 Oct 2025 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="VqF+MD+x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C68734BA49
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Oct 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760155469; cv=none; b=MDVA6Qr4UbkhMt5DOHSPnx2fKVsILJbUPB7o9Va68SQkEdiSOZ7SiQWW28F5DklIKZOXXZlOOaKQvP2NrsxKshCh87Oq0zMHOwfr1NrBAjAAtD1iCtTTQNL1GqMoEFy3mwuimM/3kLCswwTGdIg1fPIDtUdW1d+nOmMlapDCqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760155469; c=relaxed/simple;
	bh=aWOHv5sIMa96Q5/sU0zDoEGYdX0W0fCCXNPW/LilCIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivS023tLiPbwmESGFaF86SHy6EQlNY3CdAccIUuLp6waS35B/xRTdOAeXH5jB2F48PMCvVROgR9o+NOg/vnbWEchFVZol5z/J7w9zOi91XmIEUZdYuo9lFDusVKfd2OlTU1sFxhch+91iJEZfQcUbQdb8Ruxf9tZvSEVbjaShjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=VqF+MD+x; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57e36125e8aso2580906e87.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1760155465; x=1760760265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wxrYhYASPW7hNkv0I+/dkIwogDxR5uy/leBbcueqFmk=;
        b=VqF+MD+xgMTgr7lXkfXMbbXY7wkhB30iVLMvIIxxCfW82nr18QYeo3OaxUBzW2Qlto
         CVm6S0OrCWMCLingwuP6EdHIbUC0nWIg7kl5GzT7WNDytoA+WQptmaD7xk9LLAEXQhs2
         jQzyMBUOtNl6r5PBU+G2aYwmvquNTCxhlSzL4oljzSpopuQZHPZ+9jM5hgcLcwYTfHng
         HBU0Vwu63l2ockEh643GDSBPdsoPx9YTHA05cQllOSsMq5Ixev2LbQQgZUDHVWhqKKcl
         GUxR3FDnYn9nowwKVrkUFPDFoV0wF7jaIIPW03kAPLk6Cf49m3xUVCMaV5T+SWISjs9L
         lcJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760155465; x=1760760265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wxrYhYASPW7hNkv0I+/dkIwogDxR5uy/leBbcueqFmk=;
        b=wc5+j5FsMUNxXE1hBM5RjMdXGrs1mPvMP7IimMeH/CZeR8M35ETod9p6BSlEhMKiHm
         uN28/UJwCwSsVmVg/yRWWLLeAEAngxbB54o6+Lsxs0K0WQuRQFYvMyqN4oi2WLZ/USuH
         dXwBRWoUvImW2WhkljVfBVZ1kZtVYcJUCNpGKM1bYmeK46Krofok50yk8Iyy/dXI/u+k
         UKQc3S2ZxLLiwk1JQfBvM/xaHEUlzBQ+RtMGlzEk8CilGu+v7VJAnbCkjdjw9W1ikMCX
         N5/WTo6cVg7SMJl/CLKcV6sXo9KM4Axsrv7cjHyalvJsbihBGef1c6h6dibMKry7Qopn
         mqWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoa2Va3N7yEQNiFkXg7DcBIXf5hNAPrm/a9onTsBwYkJnSmVTM/iqvBBkFyj2OePcHq4gSnG1tNazAHOfn@vger.kernel.org
X-Gm-Message-State: AOJu0YxWC+9uDoxHVddNXJM/SJ91LZkVCuqbNbF7+ST1LnqOMTGQocT5
	YeauIOR5C8alMltNERXazl8j8E6L0XwPjzIXvLt0KnGjwxoDghUbjFQLmTj2jrp3ojjGDOsscCL
	BzrLNVHReT2E/c3MNL68xRjYFEJ+paDVA5x4g9Q9Zwh7nR821BtT22A==
X-Gm-Gg: ASbGncvmIkBx1ale4Hapvmye6+slPHUAdkdKSwtMyAcQxefg7Paev3G9bvtLrm99SXP
	R+fSfZPQSgd6XINZR1fRWvZgAwnLiUKjZN+hCG3th8DHoRO681i+LsV++6GXrQx6gpwjbeL23NH
	fRnOGV3YxUF8Znd3yMb+1DS0+b6chB9+LQNZH9ywVZN5BwERUB4ReYOEL2sEwJL+7O8hrw6h2dZ
	dbB80w7nz5lPeg8DE1y59qf
X-Google-Smtp-Source: AGHT+IERWkZjkwJeaANefd5QQVPUh0Tn17+zj0nbldzP+dMe/pRxkwxO+dBwZOKYhTBehxYzcRf98nJx4rDx7SgsRAM=
X-Received: by 2002:a05:6512:3c9c:b0:577:494e:ca61 with SMTP id
 2adb3069b0e04-5906dd53f00mr4476671e87.31.1760155465047; Fri, 10 Oct 2025
 21:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003093213.52624-1-xemul@scylladb.com> <aOCiCkFUOBWV_1yY@infradead.org>
 <CALCETrVsD6Z42gO7S-oAbweN5OwV1OLqxztBkB58goSzccSZKw@mail.gmail.com>
 <aOSgXXzvuq5YDj7q@infradead.org> <CALCETrW3iQWQTdMbB52R4=GztfuFYvN_8p52H1fopdS8uExQWg@mail.gmail.com>
 <aObXUBCtp4p83QzS@dread.disaster.area> <CALCETrX-cs5MH3k369q2Fk5Q-pYQfEV6CW3va-4E9vD1CoCaGA@mail.gmail.com>
 <aOm0WCB_woFgnv0v@dread.disaster.area>
In-Reply-To: <aOm0WCB_woFgnv0v@dread.disaster.area>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 10 Oct 2025 21:04:13 -0700
X-Gm-Features: AS18NWApra4q9AvFnZo6mqAkIEnBar0j0AX5L00uLKlUP_lGMQeMi0q_KHg1Mfg
Message-ID: <CALCETrWoXb40d=CJLkPy+NaAGOmdULPw6xcrXgQVhcwv49hBiA@mail.gmail.com>
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing O_NOCMTIME
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org, 
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>, linux-api@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:35=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Wed, Oct 08, 2025 at 02:51:14PM -0700, Andy Lutomirski wrote:
> > On Wed, Oct 8, 2025 at 2:27=E2=80=AFPM Dave Chinner <david@fromorbit.co=
m> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 08:22:35AM -0700, Andy Lutomirski wrote:
> > > > On Mon, Oct 6, 2025 at 10:08=E2=80=AFPM Christoph Hellwig <hch@infr=
adead.org> wrote:
> > > > >
> > > > > On Sat, Oct 04, 2025 at 09:08:05AM -0700, Andy Lutomirski wrote:
> >
> > >
> > > You are conflating "synchronous update" with "blocking".
> > >
> > > Avoiding the need for synchronous timestamp updates is exactly what
> > > the lazytime mount option provides. i.e. lazytime degrades immediate
> > > consistency requirements to eventual consistency similar to how the
> > > default relatime behaviour defers atime updates for eventual
> > > writeback.
> > >
> > > IOWs, we've already largely addressed the synchronous c/mtime update
> > > problem but what we haven't done is made timestamp updates
> > > fully support non-blocking caller semantics. That's a separate
> > > problem...
> >
> > I'm probably missing something, but is this really different?
>
> Yes, and yes.
>
> > Either the mtime update can block or it can't block.
>
> Sure, but that's not the issue we have to deal with.
>
> In many filesystems and fs operations, we have to know if an
> operation is going to block -before- we start the operation. e.g.
> transactional changes cannot be rolled back once we've started the
> modification if they need to block to make progress (e.g. read in
> on-disk metadata).
>
> This foresight, in many cases, is -unknowable-. Even though the
> operation /likely/ won't block, we cannot *guarantee* ahead of time
> that any given instance of the operation will /not/ block.  Hence
> the reliable non-blocking operation that users are asking for is not
> possible with unknowable implementation characteristics like this.
>
> IOWs, a timestamp update implementation can be synchronous and
> reliably non-blocking if it always knows when blocking will occur
> and can return -EAGAIN instead of blocking to complete the
> operation.
>
> If it can't know when/if blocking will occur, then lazytime allows
> us to defer the (potentially) blocking update operation to another
> context that can block. Queuing for async processing can easily be
> made non-blocking, and __mark_inode_dirty(I_DIRTY_TIME) does this
> for us.
>
> So, yeah, it should be pretty obvious at this point that non-blocking
> implementation is completely independent of whether the operation is
> performed synchronously or asynchronously. It's easier to make async
> operations non-blocking, but that doesn't mean "non_blocking" and
> "asynchronous execution" are interchangable terms or behaviours.
>
> > I haven't dug all the
> > way into exactly what happens in __mark_inode_dirty(), but there is a
> > lot going on in there even in the I_DIRTY_TIME path.
>
> It's pretty simple, really.  __mark_inode_dirty(I_DIRTY_TIME) is
> non-blocking and queues the inode on the wb->i_dirty_time queue
> for later processing.
>

First, I apologize if I'm off base here.

Second, I don't think I'm entirely nuts, and I'm moderately confident
that, ten-ish years ago, I tested lazytime in the hopes that it would
solve my old problem, and IIRC it didn't help.  I was running a
production workload on ext4 on regrettably slow spinning rust backed
by a truly atrocious HPE controller.  And I was running latencytop to
generate little traces when my task got blocked, and there was no form
of AIO involved.  (And I don't really understand how AIO is wired up
internally...  And yes, in retrospect I should not have been using
shared-writable mmaps or even file-backed things at all for what I was
doing, but I had unrealistic expectations of how mmap worked when I
wrote that code more like 20 years ago, and I wasn't even using Linux
at the time I wrote it.)

I'm looking at the code now, and I see what you're talking about, and
__mark_inode_dirty(inode, I_DIRTY_TIME) looks fairly polite and like
it won't block.  But the relevant code seems to be:

int generic_update_time(struct inode *inode, int flags)
{
        int updated =3D inode_update_timestamps(inode, flags);
        int dirty_flags =3D 0;

        if (updated & (S_ATIME|S_MTIME|S_CTIME))
                dirty_flags =3D inode->i_sb->s_flags & SB_LAZYTIME ?
I_DIRTY_TIME : I_DIRTY_SYNC;
        if (updated & S_VERSION)
                dirty_flags |=3D I_DIRTY_SYNC;
        __mark_inode_dirty(inode, dirty_flags);
        ...

inode_update_timestamps does this, where updated !=3D 0 if the timestamp
actually changed (which is subject to some complex coarse-graining
logic so it may only happen some of the time):

                if (IS_I_VERSION(inode) &&
inode_maybe_inc_iversion(inode, updated))
                        updated |=3D S_VERSION;

IS_I_VERSION seems to be unconditionally true on ext4.
inode_maybe_inc_iversion always returns true if updated is set, so
generic_update_time has a decent chance of doing
__mark_inode_dirty(inode, I_DIRTY_SYNC), which calls
s_op->dirty_inode, which calls ext4_journal_start, which, from my
recollection a decade ago, could easily block for a good second or so
on my delightful, now retired, HP/HPE system.

In my case, I think this is the path that was blocking for me in lots
of do_wp_page calls that would otherwise not have blocked.  I also
don't see any kiocb passed around or any mechanism by which this code
could know that it's supposed to be nonblocking, although I have
approximately no understanding of Linux AIO and I don't really know
what I should be looking for.

I could try to instrument the code a bit and test to see if I've
analyzed it right in a few days.

--Andy
Andy Lutomirski
AMA Capital Management, LLC

