Return-Path: <linux-fsdevel+bounces-51218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ABAD48F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 04:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AAA417C0CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 02:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467D42253FB;
	Wed, 11 Jun 2025 02:49:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DAEAC6
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 02:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749610170; cv=none; b=qgHxYcrWsVYfVYkis9PK9X8XXtjUuubC+RGtyYb30pEEBoEK1M71UUzBBRvwAqzaypLIdrGO0syWRGpU9V+GJijVstVBaB15SlBGxca0TB8r8j7LOsCGUhQgUFzC6UtKGdBMRSS2FA4jS4E9PzugsODqnFF+OKKYmgYMR7xZihg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749610170; c=relaxed/simple;
	bh=c1iyHEfX3PdCWXgUyvDSwgkoCR2UH8popZ66z4qF00E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Xdb8GC5Wl1vEeqaMbAmUtLqXJCQLCs41HHyIBQwLkPTDAu4k9VxvjrrGDLn0duNq3uU9o04ey9ciRTE0jsa7+Ui69kdJ3ZmaphdYUjQNvC/YKyi3v7ObF9gXvOr1/Mdx5yU2DBmHiBmhEwYSNJsqt07mtlZBIF+TckdKmEddvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uPBWm-007z5s-6X;
	Wed, 11 Jun 2025 02:49:24 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject:
 Re: [PATCH 5/8] Introduce S_DYING which warns that S_DEAD might follow.
In-reply-to: <20250611011307.GI299672@ZenIV>
References: <>, <20250611011307.GI299672@ZenIV>
Date: Wed, 11 Jun 2025 12:49:21 +1000
Message-id: <174961016183.608730.150458194978102523@noble.neil.brown.name>

On Wed, 11 Jun 2025, Al Viro wrote:
> On Wed, Jun 11, 2025 at 11:00:06AM +1000, NeilBrown wrote:
>=20
> > Yes.
> >=20
> > >=20
> > > Where does your dentry lock nest wrt ->i_rwsem?  As a bonus (well, malu=
s, I guess)
> > > question, where does it nest wrt parent *and* child inodes' ->i_rwsem f=
or rmdir
> > > and rename?
> >=20
> > Between inode of parent of the dentry and inode of the dentry.
>=20
> That's... going to be fun to prove the deadlock avoidance.
> Looking forward to such proof...

I do hope to write something along those lines, but I'd rather do it
after getting feedback on the design.  It's already changed several
times and while I have growing confidence that I understand the key
issues there is still room for change as discussed below.

>=20
> Look, the reason why I'm sceptical is that we had quite a few interesting
> problems with directory locking schemes; fun scenarios are easy to
> miss and I've fucked up more than a few times in that area.  Fixing it
> afterwards can be a real bitch, especially if we get filesystem-specific
> parts in the picture.

That's part of why I like bringing all the locking into namei.c using
lookup_and_lock() etc.  Having everything in one place won't make it
easy but might make it more tractable.

>=20
> So let's sort it out _before_ we go there.  And I mean proof - verifiable
> statements about the functions, etc.

I was hoping to get some of the refactoring - which I think it useful in
any case - in before needing a complete tidy solution.  Partly this is
because I thought the review discussion of the locking would be more
effective when the code was clean and centralised....

>=20
> Incidentally, what was the problem with having dentry locked before
> the parent?  At least that way we would have a reasonable lock ordering...
> It would require some preliminary work, but last time I looked at the
> area (not very deeply) it felt like a plausible direction...  I wonder
> which obstacle have I missed...
>=20

If we are to put the parent locking after the dentry locking it must
also be after the d_alloc_parallel() locking.  As some readdir
implementations (quite sensibly) use d_alloc_parallel() to prime the
dcache with readdir results, we would not be able to hold the parent
locked across readdir.  So we would need some other exclusion with
rmdir.

Put another way: if we want to push the parent locking down into the
filesystem for anything, we really need to do it for everything.
For rmdir we would need the "set S_DYING and wait for locked dentries"
to happen before taking the lock, and we cannot use parent lock for
readdir.

Maybe we could do that, but we can't use spare d_flags or i_flags for
the readdir locking - we need a counter.  Maybe i_writecount or
i_dio_count could provide the space we need as they aren't used on
directories.

I thought that going down that path added more complexity than I wanted,
but it does have the advantage of making the purpose and scope of the
different locks more explicit.

... or maybe we could change those readdir routines to do a try-lock.
i.e.  have a d_alloc_parallel() variant which returned -EWOULDBLOCK
rather than waiting for the dentry to be ready.  Maybe that is a
sensible approach anyway...

Another (unrelated) option that I've considered but not yet explored is
using the same locking scheme for in_lookup dentries and for the targets
of operations.  There would be just two DCACHE flags (locked, and
waiter-exists) and the in_lookup dentries would be recognised by having
d_inode being $RESERVED_ADDRESS.  Then dentries would always be created
locked and then unlocked when they are ready (like inodes).  I think I
like this, but I also wonder if it is worth the churn.

NeilBrown


