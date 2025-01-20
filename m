Return-Path: <linux-fsdevel+bounces-39667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC24A16BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39719164395
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 11:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6EF1DF257;
	Mon, 20 Jan 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFB3o6nN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD7F18FDC8
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737374118; cv=none; b=X07NVfqi/FDicIgwzSkDZkL2x9DhoZeiSRckIHSpInpeYdez7DtcwU/5II0+fzRqcYJJ40E2wcVKO5HLXaKNGmt5g1HkMN2Ri8FC2tUHK6I/kPN7UlVDLg6/dPD46RpHVelf35NEntC3OnITOLRJZnrMxOMEOczpipMtMkez5aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737374118; c=relaxed/simple;
	bh=FWv+SZwztuXqQKM+1LrTyCAl7RvwemCR6x/eFA0YGHk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u31KUYmYZz8jPK5Eh+wR5pobhUzKHfIC4BRrrC2Qq8spBzPQiABisXP3sfid5AYgw4oaVcZqUIHUGQ5tLxrXj3y64zYD7vnXauQfwX1Oz+OcYAWcDk8Mn30eiyfWyXyf7h2051KJXoMa2mCVfGW/0+KMwvZmyv7IxXJwDeFqn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFB3o6nN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7B7C4CEDD;
	Mon, 20 Jan 2025 11:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737374117;
	bh=FWv+SZwztuXqQKM+1LrTyCAl7RvwemCR6x/eFA0YGHk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=kFB3o6nNVfkDym5NpsdNX3CFeU8FD+s+w6vVPDf9GxIm9USMqnEI6zp2vC7mY9MWK
	 6ONHC7vN05aNjE1sg6egmSSWKCRbVGeddoKrCDI5C+3gEmjTkbi9ff22DrcdKJqltA
	 448+3Xz0wlyiwoNQBjKa07Iu8g4Eoeu0vfyJ+2wlHNJwYW2MKvXS9/tIuyvJsMRjsp
	 s6TvIi6XP7/bXBWK2L4EeEtUdqKZyXh3uxXNX3vBzRkWuE8EAP7umQqq6C07ppyic3
	 yyZCaUb13T4ZWXT1gzEmir/0jMvmq7dcX13lxuF2kq2aHlY8kI4R8CjeF+oaIaT3jR
	 /5DEauBjaX2hA==
Message-ID: <8d9968b696f63657fc270a2a33ac56da94abf35a.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] allowing parallel directory modifications at
 the VFS layer
From: Jeff Layton <jlayton@kernel.org>
To: NeilBrown <neilb@suse.de>, Dave Chinner <david@fromorbit.com>
Cc: lsf-pc@lists.linuxfoundation.org, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Date: Mon, 20 Jan 2025 06:55:16 -0500
In-Reply-To: <173732553757.22054.12851849131700067664@noble.neil.brown.name>
References: <>, <Z41z9gKyyVMiRZnB@dread.disaster.area>
	 <173732553757.22054.12851849131700067664@noble.neil.brown.name>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 09:25 +1100, NeilBrown wrote:
> On Mon, 20 Jan 2025, Dave Chinner wrote:
> > On Sat, Jan 18, 2025 at 12:06:30PM +1100, NeilBrown wrote:
> > >=20
> > > My question to fs-devel is: is anyone willing to convert their fs (or
> > > advice me on converting?) to use the new interface and do some testin=
g
> > > and be open to exploring any bugs that appear?
> >=20
> > tl;dr: You're asking for people to put in a *lot* of time to convert
> > complex filesystems to concurrent directory modifications without
> > clear indication that it will improve performance. Hence I wouldn't
> > expect widespread enthusiasm to suddenly implement it...
>=20
> Thanks Dave!
> Your point as detailed below seems to be that, for xfs at least, it may
> be better to reduce hold times for exclusive locks rather than allow
> concurrent locks.  That seems entirely credible for a local fs but
> doesn't apply for NFS as we cannot get a success status before the
> operation is complete.  So it seems likely that different filesystems
> will want different approaches.  No surprise.
>=20
> There is some evidence that ext4 can be converted to concurrent
> modification without a lot of work, and with measurable benefits.  I
> guess I should focus there for local filesystems.
>=20
> But I don't want to assume what is best for each file system which is
> why I asked for input from developers of the various filesystems.
>=20
> But even for xfs, I think that to provide a successful return from mkdir
> would require waiting for some IO to complete, and that other operations
> might benefit from starting before that IO completes.
> So maybe an xfs implementation of mkdir_shared would be:
>  - take internal exclusive lock on directory
>  - run fast foreground part of mkdir
>  - drop the lock
>  - wait for background stuff, which could affect error return, to
>   complete
>  - return appropriate error, or success
>=20
> So xfs could clearly use exclusive locking where that is the best
> choice, but not have exclusive locking imposed for the entire operation.
> That is my core goal : don't impose a particular locking style - allow
> the filesystem to manage locking within an umbrella that ensures the
> guarantees that the vfs needs (like no creation inside a directory
> during rmdir).
>=20
>=20

I too don't think this approach is incompatible with XFS necessarily,
but we may very well find that once we remove the bottleneck of the
exclusive i_rwsem around directory modifications, that the bottleneck
just moves down to within the filesystem driver. We have to start
somewhere though!

Also, I should mention that it looks like Al won't be able to attend
LSF/MM this year. We may not want to schedule a time slot for this
after all, as I think his involvement will be key here.

>=20
> >=20
> > In more detail....
> >=20
> > It's not exactly simple to take a directory tree structure that is
> > exclusively locked for modification and make it safe for concurrent
> > updates. It -might- be possible to make the directory updates in XFS
> > more concurrent, but it still has an internal name hash btree index
> > that would have to be completely re-written to support concurrent
> > updates.
> >=20
> > That's also ignoring all the other bits of the filesystem that will
> > single thread outside the directory. e.g. during create we have to
> > allocate an inode, and locality algorithms will cluster new inodes
> > in the same directory close together. That means they are covered by
> > the same exclusive lock (e.g. the AGI and AGF header blocks in XFS).
> > Unlink has the same problem.
> >=20
> > IOWs, it's not just directory ops and structures that need locking
> > changes; the way filesystems do inode and block allocation and
> > freeing also needs to change to support increased concurrency in
> > directory operations.
> >=20
> > Hence I suspect that concurrent directory mods for filesystems like
> > XFS will need a new processing model - possibly a low overhead
> > intent-based modification model using in-memory whiteouts and async
> > background batching of intents. We kinda already do this with unlink
> > - we do the directory removal in the foreground, and defer the rest
> > of the unlink (i.e. inode freeing) to async background worker
> > threads.
> >=20
> > e.g. doing background batching of namespace ops means things like
> > "rm *" in a directory doesn't need to transactionally modify the
> > directory as it runs. We could track all the inodes we are unlinking
> > via the intents and then simply truncate away the entire directory
> > when it becomes empty and rmdir() is called. We still have to clean
> > up and mark all the inodes free, but that can be done in the
> > background.
> >=20
> > As such, I suspect that moving XFS to a more async processing model
> > for directory namespace ops to minimise lock hold times will be
> > simpler (and potentially faster!) than rewriting large chunks of the
> > XFS directory and inode management operations to allow for
> > i_rwsem/ILOCK/AGI/AGF locking concurrency...
> >=20
> > -Dave.
> > --=20
> > Dave Chinner
> > david@fromorbit.com
> >=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

