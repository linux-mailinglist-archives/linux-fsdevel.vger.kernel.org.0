Return-Path: <linux-fsdevel+bounces-58399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8482B2E244
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B25F7B5871
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 16:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0603D14AA9;
	Wed, 20 Aug 2025 16:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cySH4xMt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD12869E;
	Wed, 20 Aug 2025 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755707245; cv=none; b=pz9nymdyrGDtzA+hh3Blk4cNslOEMsB94JeH9y5KzRE7AeJ/RdW++7uTZPJAWvUFpDJielHlomm+QCgCAD7XIYTRP3wTaai4tITAHlYiK13ouMAjYQCi+OpXtkc4SFQIBNLe9oQc06FncCqoBjy3rVkJ22xGse/e3CVVKLRIUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755707245; c=relaxed/simple;
	bh=6b0KLUQmQqEXc+dre+tvQYRy/Qs3uwqYitS62zeXa3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvA/9R3XD9MkOSnRGHyityCeuBclrl2Gh6AqLvzo0K1uNh6TDb1SCQzYxDuccoseznTYPK5SkeF9lKDBph9DwfKBCcB7eK1OXAKd044nowF8DWhdc49GBx70yj+I9I5leoY8NjkW1qlPh3rXBK19BEnxShmyWVjp11gFa9HsJAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cySH4xMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E417FC113CF;
	Wed, 20 Aug 2025 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755707245;
	bh=6b0KLUQmQqEXc+dre+tvQYRy/Qs3uwqYitS62zeXa3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cySH4xMtjGxHrDny/M0+6aZHAZ5pW2iDZqp19u4pVNLv2AgPVT/v+WT7sGMHByOGJ
	 /BQ2dhHH8JWotA4bNrX8uJ1uGe3Wa1VWjZPinMYhRcNNHiIRgZuhSK98ghczmTrFGO
	 jn/Xq6O0EHAzQor25Elsiy3yh1a+RuZ/VNHXTUSb4P+RdvhoUmccbiN6yHBCVi80et
	 fMvSoif7REFgdclhPGwcsr0g64hTEc9nRvfhFH3aXTo4aLujwg3MW6lGZiCBfZKrfy
	 LKWSBAGJtdu6nDzP7dl8f0TvIyBcQg7Lt0GwpVjgfFeSy0A2R2ckz6o2sUXGv9SLjt
	 KJfH0YAOmX7Nw==
Date: Wed, 20 Aug 2025 09:27:24 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Chunsheng Luo <luochunsheng@ustc.edu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fuse: clarify extending writes handling
Message-ID: <20250820162724.GL7942@frogsfrogsfrogs>
References: <CAJfpegsz3fScMWh4BVuzax1ovVN5qEm1yr8g=XEU0DnsHbXCvQ@mail.gmail.com>
 <20250820021143.1069-1-luochunsheng@ustc.edu>
 <20250820052043.GJ7942@frogsfrogsfrogs>
 <CAJfpegtXUekKPaCxEG29SWAK0CTz-fdGvH=_1G5rcK9=eHt6wQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtXUekKPaCxEG29SWAK0CTz-fdGvH=_1G5rcK9=eHt6wQ@mail.gmail.com>

On Wed, Aug 20, 2025 at 08:52:35AM +0200, Miklos Szeredi wrote:
> On Wed, 20 Aug 2025 at 07:20, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > I don't understand the current behavior at all -- why do the callers of
> > fuse_writeback_range pass an @end parameter when it ignores @end in
> > favor of LLONG_MAX?  And why is it necessary to flush to EOF at all?
> > fallocate and copy_file_range both take i_rwsem, so what could they be
> > racing with?  Or am I missing something here?
> 
> commit 59bda8ecee2f ("fuse: flush extending writes")
> 
> The issue AFAICS is that if writes beyond the range end are not
> flushed, then EOF on backing file could be below range end (if pending
> writes create a hole), hence copy_file_range() will stop copying at
> the start of that hole.
> 
> So this patch is incorrect, since not flushing copy_file_range input
> file could result in a short copy.

<nod> As far as Mr. Luo's patch is concerned, I agree that a strict "no
behavior changes" patch should have changed the inode_in writeback_range
call to:

	err = fuse_writeback_range(inode_in, pos_in, LLONG_MAX);

Though if all callsites are going to pass LLONG_MAX in as @end, then
why not eliminate the parameter entirely?

What I'm (still) wondering is why was it necessary to flush the source
and destination ranges between (pos + len - 1) and LLONG_MAX?  But let's
see, what did 59bda8ecee2f have to say?

| fuse: flush extending writes
|
| Callers of fuse_writeback_range() assume that the file is ready for
| modification by the server in the supplied byte range after the call
| returns.

Ok, so far so good.

| If there's a write that extends the file beyond the end of the supplied
| range, then the file needs to be extended to at least the end of the range,
| but currently that's not done.
|
| There are at least two cases where this can cause problems:
|
|  - copy_file_range() will return short count if the file is not extended
|    up to end of the source range.

That suggests to me

filemap_write_and_wait_range(inode_in, pos_in, pos_in + pos_len - 1)

but I don't see why we need to flush more bytes than that?  The server's
CFR implementation has all the bytes it needs to read the source data.

Hum.  But what if CFR is actually reflink?  I guess you'd want to
buffer-copy the unaligned head and tail regions, and reflink the
allocation units in the middle, but I still don't see why the fuse
server needs more of the source file than (pos, pos + len - 1)?

|  - FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE will not extend the file,
|    hence the region may not be fully allocated.

Hrm, ZERO | KEEP_SIZE is supposed to allow preallocation of blocks
beyond EOF, or at least that's what XFS does:

$ truncate -s 10m /mnt/test
$ xfs_io -c 'fzero -k 100m 64k' /mnt/test
$ filefrag -v /mnt/test
Filesystem type is: 58465342
File size of /mnt/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:    25600..   25615:         24..        39:     16:      25600: last,unwritten,eof
/mnt/test: 1 extent found

as does ext4:

$ truncate -s 10m /mnt/test
$ xfs_io -c 'fzero -k 100m 64k' /mnt/test
$ filefrag -v /mnt/test
Filesystem type is: ef53
File size of /mnt/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:    25600..   25615:      33808..     33823:     16:      25600: last,unwritten,eof
/mnt/test: 1 extent found

(Notice that the 10M file has one extent starting at 100M)

I can see why you'd want to flush the target range in case the fuse
server has a better trick up its sleeve to zero the already-written
region that isn't the punch-and-realloc behavior that xfs and ext4 have.
But here too I don't see why the fuse server would need more than the
target region.

Though I think for both cases we end up flushing more than the target
region, because the page cache rounds start down and end up to PAGE_SIZE
boundaries.

| Fix by flushing writes from the start of the range up to the end of the
| file.  This could be optimized if the writes are non-extending, etc, but
| it's probably not worth the trouble.

<shrug> Was there a bug report associated with this commit?  I couldn't
find the any hits on the subject line in lore.  Was this simply a big
hammer that solved whatever corruption problems were occuring?  Or
something found in code inspection?

<confused>

--D

> Thanks,
> Miklos
> 

