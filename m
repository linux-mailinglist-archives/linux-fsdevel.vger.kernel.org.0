Return-Path: <linux-fsdevel+bounces-19217-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B47E8C16B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6001C20B45
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159313DDAB;
	Thu,  9 May 2024 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQhqrvOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20213DDDE;
	Thu,  9 May 2024 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284971; cv=none; b=u3sXsPl6/aJb6T8HKUAmlBnS+OPVY6uAn4f/009yIF+SUjV/SfVWIVG1SKBezyXzNHst3xiqw7/IAqTsRc1xi3F/wqkDvbDZCRT3zwkOjCvZNbYMlrXWId/2F9CxY/R2nwXvEYJUU5CQAD/Exp5azQeMZB8THLCrEUuHAWwPu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284971; c=relaxed/simple;
	bh=QCcv+LXMC5xkj8H5hLogsZEPWQAnchUSlmyjqGUtH84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7dO9DiXepCTtxU5PQDmfmvC50Msmvxp772zTnYs3lmu6xyTGYA1f3yWUVckFDuFEtDgbjlbQFo2we4qFh0cqrI2C4tRmXyMq7smIhDYQYyLveQkDABKerR0b2iAu7QlMCivnQGTaEycnnMO4ySVunSXp9HUs7UR1O5ZXwc1cWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQhqrvOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34581C116B1;
	Thu,  9 May 2024 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715284971;
	bh=QCcv+LXMC5xkj8H5hLogsZEPWQAnchUSlmyjqGUtH84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQhqrvOPFvP8V+U7i4Q6XD3o/P7uR7zRlD9PEL/wvX42JQppEIYzhR8H7lmGj7LVa
	 77aCmXR7WPzrY9xXzwPV2PfbxD6wjsy/uE6NEy1BZnGGybPc6Yq6adT4JuI+2AKpUY
	 IMwzjurwbiMT/X5jjpMbPYS6Ct+hvThqPQ+AavlavlZv9rnn4bmg47kU3+lEbBX7Hf
	 2FgFuw+8FpZTtKsHpFnI2Pn2ScuWztEDx1aY/HL8MvznhKF659d9UcN2CStQC2enE+
	 kgAf+ldZhqk6opjBsiAREGKLY0R1svPkTvzC56kpoyS8flYaXxu/DFhK14OeWdliLD
	 xBzBYPwxWmYUg==
Date: Thu, 9 May 2024 13:02:50 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: aalbersh@redhat.com, ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	alexl@redhat.com, walters@verbum.org, fsverity@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 18/26] xfs: use merkle tree offset as attr hash
Message-ID: <20240509200250.GQ360919@frogsfrogsfrogs>
References: <171444680291.957659.15782417454902691461.stgit@frogsfrogsfrogs>
 <171444680671.957659.2149857258719599236.stgit@frogsfrogsfrogs>
 <ZjHmzBRVc3HcyX7-@infradead.org>
 <ZjHt1pSy4FqGWAB6@infradead.org>
 <20240507212454.GX360919@frogsfrogsfrogs>
 <ZjtmVIST_ujh_ld6@infradead.org>
 <20240508202603.GC360919@frogsfrogsfrogs>
 <ZjxY_LbTOhv1i24m@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjxY_LbTOhv1i24m@infradead.org>

On Wed, May 08, 2024 at 10:02:52PM -0700, Christoph Hellwig wrote:
> On Wed, May 08, 2024 at 01:26:03PM -0700, Darrick J. Wong wrote:
> > I guess we could make it really obvious by allocating range in the
> > mapping starting at MAX_FILEOFF and going downwards.  Chances are pretty
> > good that with the xattr info growing upwards they're never going to
> > meet.
> 
> Yes, although I'd avoid taking chances.  More below.
> 
> > > Or we decide the space above 2^32 blocks can't be used by attrs,
> > > and only by other users with other means of discover.  Say the
> > > verify hashes..
> > 
> > Well right now they can't be used by attrs because xfs_dablk_t isn't big
> > enough to fit a larger value.
> 
> Yes.

Thinking about this further, I think building the merkle tree becomes a
lot more difficult than the current design.  At first I thought of
reserving a static partition in the attr fork address range, but got
bogged donw in figuring out how big the static partition has to be.

Downthread I realized that the maximum size of a merkle tree is actually
ULONG_MAX blocks, which means that on a 64-bit machine there effectively
is no limit.

For an 8EB file with sha256 hashes (32 bytes) and 4k blocks, we need
2^(63-12) hashes.  Assuming maximum loading factor of 128 hashes per
block, btheight spits out:

# xfs_db /dev/sdf -c 'btheight -b 4096 merkle_sha256 -n '$(( 2 ** (63 - 12) ))
merkle_sha256: best case per 4096-byte block: 128 records (leaf) / 128 keyptrs (node)
level 0: 2251799813685248 records, 17592186044416 blocks
level 1: 17592186044416 records, 137438953472 blocks
level 2: 137438953472 records, 1073741824 blocks
level 3: 1073741824 records, 8388608 blocks
level 4: 8388608 records, 65536 blocks
level 5: 65536 records, 512 blocks
level 6: 512 records, 4 blocks
level 7: 4 records, 1 block
8 levels, 17730707194373 blocks total

That's about 2^45 blocks.  If the hash is sha512, double those figures.
For a 1k block size, we get:

# xfs_db /dev/sdf -c 'btheight -b 1024 merkle_sha256 -n '$(( 2 ** (63 - 10) ))
merkle_sha256: best case per 1024-byte block: 32 records (leaf) / 32 keyptrs (node)
level 0: 9007199254740992 records, 281474976710656 blocks
level 1: 281474976710656 records, 8796093022208 blocks
level 2: 8796093022208 records, 274877906944 blocks
level 3: 274877906944 records, 8589934592 blocks
level 4: 8589934592 records, 268435456 blocks
level 5: 268435456 records, 8388608 blocks
level 6: 8388608 records, 262144 blocks
level 7: 262144 records, 8192 blocks
level 8: 8192 records, 256 blocks
level 9: 256 records, 8 blocks
level 10: 8 records, 1 block
11 levels, 290554814669065 blocks total

That would be 2^49 blocks but mercifully fsverity doesn't allow more
than 8 levels of tree.

So I don't think it's a good idea to create a hardcoded partition in the
attr fork for merkle tree data, since it would have to be absurdly large
for the common case of sub-1T files:

# xfs_db /dev/sdf -c 'btheight -b 4096 merkle_sha512 -n '$(( 2 ** (40 - 12) ))
merkle_sha512: best case per 4096-byte block: 64 records (leaf) / 64 keyptrs (node)
level 0: 268435456 records, 4194304 blocks
level 1: 4194304 records, 65536 blocks
level 2: 65536 records, 1024 blocks
level 3: 1024 records, 16 blocks
level 4: 16 records, 1 block
5 levels, 4260881 blocks total

That led me to the idea of dynamic partitioning, where we find a sparse
part of the attr fork fileoff range and use that.  That burns a lot less
address range but means that we cannot elide merkle tree blocks that
contain entirely hash(zeroes) because elided blocks become sparse holes
in the attr fork, and xfs_bmap_first_unused can still find those holes.
I guess you could mark those blocks as unwritten, but that wastes space.

Setting even /that/ aside, how would we allocate/map the range?  I think
we'd want a second ATTR_VERITY attr to claim ownership of whatever attr
fork range we found.  xfs_fsverity_write_merkle would have to do
something like this, pretending that the merkle tree blocksize matches
the fs blocksize:

	offset = /* merkle tree pos to attr fork xfs_fileoff_t */
	xfs_trans_alloc()

	xfs_bmapi_write(..., offset, 1...);

	xfs_trans_buf_get()
	/* copy merkle tree contents */
	xfs_trans_log_buf()

	/* update verity extent attr value */
	xfs_attr_defer_add("verity.merkle",
			{fileoff: /* start of range */,
			 blockcount: /* blocks mapped so far */
			});

	xfs_trans_commit()

Note that xfs_fsverity_begin_enable would have to ensure that there's an
attr fork and that it's not in local format.  On the plus side, doing
all this transactionally means we have a second user of logged xattr
updates. :P

Online repair would need to grow new code to copy the merkle tree.

Tearing down the merkle tree (aka if tree setup fails and someone wants
to try again) use the "verity.merkle" attr to figure out which blocks to
clobber.

Caching at least is pretty easy, look up the "verity.merkle" attribute
to find the fileoff, compute the fileoff of the particular block we want
in the attr fork, xfs_buf_read the buffer, and toss the contents in the
incore cache that we have now.

<shrug> What do you think of that?

--D

> > The dangerous part here is that the code
> > silently truncates the outparam of xfs_bmap_first_unused, so I'll fix
> > that too.
> 
> Well, we should check for that in xfs_attr_rmt_find_hole /
> xfs_da_grow_inode_int, totally independent of the fsverity work.
> The condition is basically impossible to hit right now, but I'd rather
> make sure we do have a solid check.  I'll prepare a patch for it.
> 
> 

