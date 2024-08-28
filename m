Return-Path: <linux-fsdevel+bounces-27704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DBB963666
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 01:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68041C2273E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 23:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D7D1AC433;
	Wed, 28 Aug 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="Xb16D8AO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC73165EE4
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 23:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888770; cv=none; b=SRQ7P2tTwBwl4DQ51LB972MvAIoLomVBGPn+1HNCGigjZinN31Vzkib9FyK2L5ifsrCkW/E3YGNdesTKJ4s8VxuwHF6v/NpTs8pqlFD8Xg8B8/GrikFUeZb3Mga/vyQ+z4ZItTu6tQncqLJ0v/00FS3nhFtwgA/WmWfVkCeRZEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888770; c=relaxed/simple;
	bh=BgnIxlgtuWM8Q4+hGvwXSGP9XlQTN/CKOze1Py+zZA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcwfXOasXJX2By4lH3NEVpSEMVYT2pCWCDvBAonjvoRNgx/utiyyDUu/RRk8aE8JwffhmJmmWdMxcvL3FmLF7vKzr5qDDMStnS5g3ZWL+5EQFuJyj0npi/bb5lGgPVkdcqvjtf44tIlUSEiMAv6uDceeu9VavB8seTwe0mNhZQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=Xb16D8AO; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7141e20e31cso69755b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Aug 2024 16:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1724888767; x=1725493567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EiTwJRAU5xz2F/mgZExetRRqjWot7+EZlL+tKi6rkkw=;
        b=Xb16D8AOIVSa3fuu2sxrLSlQ9zikQThqaExGmIl0xBdyM92a4WQumHhRETJrUVdrSz
         pcd6rKe9kTqKuPVZ8EezqGvAZZJgOx9ZDXWzdPBFfpNutuMHXK7gZivM10vQyYerkw/l
         Y4MkuJPA2vvYNWZVSwuk6ocNWVnmZ0dubdUkbG8RKyQmMJJPX8L/NNCm/YNF57rjlbhc
         i5lHcdQe5FjlBXT9qSLbKHHE435x9ylqDoyj0te1/lqrEWoFe1/W//xL6ve4Arv6jQSh
         pz6xkoxkG0vQodMYDH7jV00YJcDTy15tkfCFx5K5bArwWNB268JucOezeSMJK6Ed9TrR
         NlIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888767; x=1725493567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiTwJRAU5xz2F/mgZExetRRqjWot7+EZlL+tKi6rkkw=;
        b=J/A9fOi0IbJT/0HlMtw4NP+Op60GjSm07hvPrfNnAj1cpuEj1XOXKwRbWrzrUJyooN
         r1GY6Z/LuMv304yJv5VqzIpVtV8ikYd//GuocRmC1V0H+Sjv30QL+c4Vf8Jx3kLxK6yq
         l1xGYT8sdxIRfOJCccMaMmfRepnkvZWoRVL4Cl1nWCaFVmCaWtabu+HfJkXdiUPRA2Hc
         26qA3kdT5suMmqfxVVqHGWZrzEdOJZMUjmT3V+N2ghBVPkfBGVgSOEkSmJgOxpiqFzKz
         kz2ooTxuJFQW9sOlc5ams622kPzHfeAAFRdZTvRRgripeV60NLctGxo6khI+0mBsQEFK
         juDA==
X-Gm-Message-State: AOJu0YytB08SJLmJfGlBBQAuV+Bp0Kw5waLz/D56nvTPaZ3uDOgXPu/R
	k9pPvrAcJUEbfBuf7C90iM9DHZcfLmbRch9SH8na2TE9wmvF3TnoaChhKCOqh5c=
X-Google-Smtp-Source: AGHT+IGOPhLjHesXckMNvUEgrlLxB92vk1KpjjTteYdAqRDgjLsNmwlHEClC05EQs3thfzMGvQB2XQ==
X-Received: by 2002:a05:6a21:918a:b0:1ca:dcae:a798 with SMTP id adf61e73a8af0-1cce0ffe3bemr1213679637.9.1724888767255;
        Wed, 28 Aug 2024 16:46:07 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-0-65.pa.nsw.optusnet.com.au. [49.179.0.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e742c8asm64390a12.9.2024.08.28.16.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 16:46:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sjSMV-00GHwU-2f;
	Thu, 29 Aug 2024 09:46:03 +1000
Date: Thu, 29 Aug 2024 09:46:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
Subject: Re: VFS caching of file extents
Message-ID: <Zs+2u3/UsoaUHuid@dread.disaster.area>
References: <Zs97qHI-wA1a53Mm@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs97qHI-wA1a53Mm@casper.infradead.org>

On Wed, Aug 28, 2024 at 08:34:00PM +0100, Matthew Wilcox wrote:
> Today it is the responsibility of each filesystem to maintain the mapping
> from file logical addresses to disk blocks (*).  There are various ways
> to query that information, eg calling get_block() or using iomap.
> 
> What if we pull that information up into the VFS? 

We explicitly pulled that information out of the VFS by moving away
from per-page bufferheads that stored the disk mapping for the
cached data to the on-demand query based iomap infrastructure.

> Filesystems obviously
> _control_ that information, so need to be able to invalidate entries.

Which is one of the reasons for keeping it out of the VFS...

Besides, which set of mapping information that the filesystem holds are we
talking about here?

FYI: XFS has *three* sets of mapping information per inode - the
data fork, the xattr fork and the COW fork. The data fork and the
COW fork both reference file data mappings, and they can overlap
whilst there are COW operations ongoing. Regular files can also have
xattr fork mappings.

Further, directories and symlinks have both data and xattr fork
based mappings, and they do not use the VFS for caching metadata -
that is all internal to the filesystem. Hence if we move to caching
mapping information in the VFS, we have to expose the VFS inode all
the way down into the lowest layers of the XFS metadata subsystem
when there is absolutely nothing that is Linux/VFS specific.

IOWs, if we don't cache mapping information natively in the
filesystem, we are forcing filesystems to drill VFS structures deep
into their internal metadata implementations.  Hence if you're
thinking purely about caching file data mappings at the VFS, then
what you're asking filesystems to support is multiple extent map
caching schemes instead of just one. 

And I'm largely ignoring the transactional change requirements
for extent maps, and how a VFS cache would place the cache locking
both above and below transaction boundaries. And then there's the
inevitable shrinker interface for reclaim of cached VFS extent maps
and the placement of the locking both above and below memory
allocation. That's a recipe for lockdep false positives all over the
place...

> And we wouldn't want to store all extents in the VFS all the time, so
> would need to have a way to call into the filesystem to populate ranges
> of files.

This would require substantial modification to filesysetms like XFS
that assume the mapping cache is always fully populated before a
lookup or modification is done. It's not just a case of "make sure
this range is populated", it's also a change of the entire locking
model for extent map access because cache population under a shared
lock is inherently racy.

> We'd need to decide how to lock/protect that information
> -- a per-file lock?  A per-extent lock?  No locking, just a seqcount?

Right now Xfs uses a private per-inode metadata rwsem for exclusion
and we generally don't have terrible contention problems with that strategy. Other
filesystems use private rwsems, too, but often they only protect
mapping operations, not all the metadata in the inode. Other filesystems
use per-extent locking.

As such, I'm not sure there is a "one size fits all" model here...

> We need a COW bit in the extent which tells the user that this extent
> is fine for reading through, but if there's a write to be done then the
> filesystem needs to be asked to create a new extent.

It's more than that - we need somewhere to hold the COW extent
mappings that we've allocated and overlap existing data mappings.
We do delayed allocation and/or preallocation with allocate-around
for COW to minimise fragmentation. Hence we have concurrent mappings
for the same file range for the existing data and where the dirty
cached data is going to end up being placed when it is finally
written. And then on IO completion we do the transactional update
to punch out the old data extent and swap in the new data extent
from the COW fork where we just wrote the new data to.

IOWs, managing COW mappings is much more complex than a simple flag
that says "this range needs allocation on writeback". Yes, we can do
unwritten extents like that (i.e. a simple flag in the extent to
say "do unwritten extent conversion on IO completion"), but COW is
much, much more complex...

> There are a few problems I think this can solve.  One is efficient
> implementation of NFS READPLUS.

How "inefficient" is an iomap implementation? It iterates one extent
at a time, and a readplus iterator can simply encode data and holes
as it queries teh range one extent at a time, right?

> Another is the callback from iomap
> to the filesystem when doing buffered writeback.

Filesystems need to do COW setup work or delayed allocation here, so
we have to call into the filesystem regardless of whether there is a
VFS mapping cache or not.

In that case the callout requires exclusive locking, but if it's an
overwrite, the callout only needs shared locking.  But until we call
into the filesystem we don't know what operation we have to perform
or which type of locks we have to take because the extent map can
change until we hold the internal extent map lock...

Fundamentally, I don't want operations like truncate, hole punch,
etc to have to grow *another* lock. We currently have to take
the inode lock, the invalidate lock and internal metadata locks
to lock everything out. With an independent mapping cache, we're
also going to have to take that lock as well to, especially if
things like writeback only use the mapping cache lock.

> A third is having a
> common implementation of FIEMAP.

We've already got that with iomap.

> I've heard rumours that FUSE would like
> something like this, and maybe there are other users that would crop up.
> 
> Anyway, this is as far as my thinking has got on this topic for now.
> Maybe there's a good idea here, maybe it's all a huge overengineered mess
> waiting to happen.  I'm sure other people know this area of filesystems
> better than I do.

Caching mapping state in the VFS has proven to be less than ideal in
the past for reasons of coherency and resource usage. We've
explicitly moved away from that model to an extent-query model with
iomap, and right now I'm not seeing any advantages or additional
functionality that caching extent maps in the VFS would bring over
the existing iomap model...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

