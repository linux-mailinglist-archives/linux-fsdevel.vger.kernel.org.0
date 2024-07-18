Return-Path: <linux-fsdevel+bounces-23930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6788A934FA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE31E1F210F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4B01411EE;
	Thu, 18 Jul 2024 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtp/TrJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DEC142E88;
	Thu, 18 Jul 2024 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315118; cv=none; b=ZCZZnSXl1CVlFYzfhzWNSVotrdh3hU9TqUUwR1h59GP61OP/tLIALBXE8XC+7Sg4LU7SnbRPPM1m+lw8EKBSe4r93oJosuz/EXrkEFMbUOntKQHiuHbYjxeqklo7+exfEJ1E4Y8XUx0fFsKYdjq4ZmpH0YQOXTk8/MCgWDNrzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315118; c=relaxed/simple;
	bh=7/dfhgLh/M3NKMwjO5kGc5wSi3Df+4MsQUYRMqvLVUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0n1Si5RQ6qBnsAnPoHWJdSa0wzaPGX8fd+7s1jO/ZFY1vsCfKnr67fofUZQ/u4ihVfgzJvrf0APGwHQzCTzR92O5B/1l79wm0B+xMSVMCHz8GCMrF03IhCy/YUC4aS/TpY4C0MIsX/hbIA9r1f7uAyKbs/kclpZt/vlIgGCY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtp/TrJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C674C116B1;
	Thu, 18 Jul 2024 15:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315117;
	bh=7/dfhgLh/M3NKMwjO5kGc5wSi3Df+4MsQUYRMqvLVUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qtp/TrJsnCwIENfDF2o0vDWlQFd020eKOCXxnky/TdQlhv9D/C5/3frR5wSUKe8U8
	 3lXb3E0fe/PbZe14sMfSR9iTvfvTqvkBvMgrrkhQyXDGoQjgUMcJ+2AfJN4kvfXwMN
	 XcovuqeGqBj7EJzWOg8Ve1zJ5WGEPpXci2Vo0+QIxlsPWST4iHjsNTDkYyRK3vHXTB
	 0C2MdEJkv4UEH936ZAuOvZF6XPRuL19Q/JazWXCDBmbnYjGxG/QKhUbr8n2vzKAw61
	 zD1TtaY2GLZCKXWEhWumfG67t5Lcscf+PEq5gpWFai1ms+4QXVstqN7t60dVc7dgTc
	 z6KwyKmE0lsZw==
Date: Thu, 18 Jul 2024 08:05:16 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: alx@kernel.org, linux-man@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	dchinner@redhat.com, martin.petersen@oracle.com,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v4 2/3] readv.2: Document RWF_ATOMIC flag
Message-ID: <20240718150516.GH103014@frogsfrogsfrogs>
References: <20240717093619.3148729-1-john.g.garry@oracle.com>
 <20240717093619.3148729-3-john.g.garry@oracle.com>
 <20240717214423.GI1998502@frogsfrogsfrogs>
 <2eb8c7b7-7758-49a3-b837-2e2a622c0ed9@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eb8c7b7-7758-49a3-b837-2e2a622c0ed9@oracle.com>

On Thu, Jul 18, 2024 at 03:07:59PM +0100, John Garry wrote:
> On 17/07/2024 22:44, Darrick J. Wong wrote:
> > On Wed, Jul 17, 2024 at 09:36:18AM +0000, John Garry wrote:
> > > From: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > 
> > > Add RWF_ATOMIC flag description for pwritev2().
> > > 
> > > Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > [jpg: complete rewrite]
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   man/man2/readv.2 | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
> > >   1 file changed, 76 insertions(+)
> > > 
> > > diff --git a/man/man2/readv.2 b/man/man2/readv.2
> > > index eecde06dc..9c8a11324 100644
> > > --- a/man/man2/readv.2
> > > +++ b/man/man2/readv.2
> > > @@ -193,6 +193,66 @@ which provides lower latency, but may use additional resources.
> > >   .B O_DIRECT
> > >   flag.)
> > >   .TP
> > > +.BR RWF_ATOMIC " (since Linux 6.11)"
> > > +Requires that writes to regular files in block-based filesystems be issued with
> > > +torn-write protection.
> > > +Torn-write protection means that for a power or any other hardware failure,
> > > +all or none of the data from the write will be stored,
> > > +but never a mix of old and new data.
> > > +This flag is meaningful only for
> > > +.BR pwritev2 (),
> > > +and its effect applies only to the data range written by the system call.
> > > +The total write length must be power-of-2 and must be sized in the range
> > > +.RI [ stx_atomic_write_unit_min ,
> > > +.IR stx_atomic_write_unit_max ].
> > > +The write must be at a naturally-aligned offset within the file with respect to
> > > +the total write length -
> > > +for example,
> > 
> > Nit: these could be two sentences
> > 
> > "The write must be at a naturally-aligned offset within the file with
> > respect to the total write length.  For example, ..."
> 
> ok, sure
> 
> > 
> > > +a write of length 32KB at a file offset of 32KB is permitted,
> > > +however a write of length 32KB at a file offset of 48KB is not permitted.
> > 
> > Pickier nit: KiB, not KB.
> 
> ok
> 
> > 
> > > +The upper limit of
> > > +.I iovcnt
> > > +for
> > > +.BR pwritev2 ()
> > > +is in
> > 
> > "is given by" ?
> 
> ok, fine, I don't mind
> 
> > 
> > > +.I stx_atomic_write_segments_max.
> > > +Torn-write protection only works with
> > > +.B O_DIRECT
> > > +flag, i.e. buffered writes are not supported.
> > > +To guarantee consistency from the write between a file's in-core state with the
> > > +storage device,
> > > +.BR fdatasync (2),
> > > +or
> > > +.BR fsync (2),
> > > +or
> > > +.BR open (2)
> > > +and either
> > > +.B O_SYNC
> > > +or
> > > +.B O_DSYNC,
> > > +or
> > > +.B pwritev2 ()
> > > +and either
> > > +.B RWF_SYNC
> > > +or
> > > +.B RWF_DSYNC
> > > +is required. Flags
> > 
> > This sentence   ^^ should start on a new line.
> 
> yes
> 
> > 
> > > +.B O_SYNC
> > > +or
> > > +.B RWF_SYNC
> > > +provide the strongest guarantees for
> > > +.BR RWF_ATOMIC,
> > > +in that all data and also file metadata updates will be persisted for a
> > > +successfully completed write.
> > > +Just using either flags
> > > +.B O_DSYNC
> > > +or
> > > +.B RWF_DSYNC
> > > +means that all data and any file updates will be persisted for a successfully
> > > +completed write.
> > 
> 
> ughh, this is hard to word both concisely and accurately...
> 
> > "any file updates" ?  I /think/ the difference between O_SYNC and
> > O_DSYNC is that O_DSYNC persists all data and file metadata updates for
> > the file range that was written, whereas O_SYNC persists all data and
> > file metadata updates for the entire file.
> 
> I think that https://man7.org/linux/man-pages/man2/open.2.html#NOTES
> describes it best.
> 
> > 
> > Perhaps everything between "Flags O_SYNC or RWF_SYNC..." and "...for a
> > successfully completed write." should instead refer readers to the notes
> > about synchronized I/O flags in the openat manpage?
> 
> Maybe that would be better, but we just need to make it clear that
> RWF_ATOMIC provides the guarantee that the data is atomically updated only
> in addition to whatever guarantee we have for metadata updates from
> O_SYNC/O_DSYNC.
> 
> 
> So maybe:
> RWF_ATOMIC provides the guarantee that any data is written with torn-write
> protection, and additional flags O_SYNC or O_DSYNC provide
> same Synchronized I/O guarantees as documented in <openat manpage reference>

  ^ the same

> 
> OK?

Yes.

> > > +Not using any sync flags means that there is no guarantee that data or
> > > +filesystem updates are persisted.
> > > +.TP
> > >   .BR RWF_SYNC " (since Linux 4.7)"
> > >   .\" commit e864f39569f4092c2b2bc72c773b6e486c7e3bd9
> > >   Provide a per-write equivalent of the
> > > @@ -279,10 +339,26 @@ values overflows an
> > >   .I ssize_t
> > >   value.
> > >   .TP
> > > +.B EINVAL
> > > + For
> > > +.BR RWF_ATOMIC
> > > +set,
> > 
> > "If RWF_ATOMIC is specified..." ?
> > 
> > (to be a bit more consistent with the language around the AT_* flags in
> > openat)
> 
> ok, fine
> 
> > 
> > > +the combination of the sum of the
> > > +.I iov_len
> > > +values and the
> > > +.I offset
> > > +value does not comply with the length and offset torn-write protection rules.
> > > +.TP
> > >   .B EINVAL
> > >   The vector count,
> > >   .IR iovcnt ,
> > >   is less than zero or greater than the permitted maximum.
> > > +For
> > > +.BR RWF_ATOMIC
> > > +set, this maximum is in
> > 
> > (same)
> > 
> > --D
> > 
> 
> Thanks for checking,

NP. :)

--D

> John
> 
> 

