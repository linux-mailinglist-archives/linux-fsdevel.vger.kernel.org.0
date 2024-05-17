Return-Path: <linux-fsdevel+bounces-19686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3008C89A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 17:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F059DB217E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 15:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6F12F5A7;
	Fri, 17 May 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUNgytXP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29C399;
	Fri, 17 May 2024 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961390; cv=none; b=bGVCBrqTrzrjltDV1F33DqQPkjof5TxBzr5UpsQM5xKCtF6ane0rbhpmnSXjmGJBmli5CqJ0y+0BdUAECiNW4AKgw02+DT3FpIj7xxEO5xVKyjaG6ncwNnaqnINMjRY5S5H63AJjEwm3PmTpQYI/BxZkOG/TeKPNeyRmPLhdMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961390; c=relaxed/simple;
	bh=nd1PdYlGsC/QzJZOWPgYLrKd4b9pdsPDAgH20vsDd2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dosnj8Jrt+eNtRQ+9cvr0ScwmJMgGMi6p1AQhiri9ANdGPNQXfUX4aHErj2Bkg14/IWqwp/3U73VPnrb1wjJnoTqtREfNuvO1Ru/06DHp303jRyzo8oZhlcMVyfIs8fTUy74ibVzhOnAx+9fcyEu8ZpfHPpFRbws0pDLJJmDi9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUNgytXP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E924C2BD10;
	Fri, 17 May 2024 15:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715961390;
	bh=nd1PdYlGsC/QzJZOWPgYLrKd4b9pdsPDAgH20vsDd2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kUNgytXPDsJDnd36NEfB6qy3xgyzJoQXnX2qjM9AfXMRmisYE9datL2emeAW+89V2
	 MmmjVsRYaSK/EEQrCRCpdf+WDpBtRCjB/iEQ8UpqO/NxJgKQZaLn07pK7PMz3wtNT6
	 LBxWPiR4x7fag8RQdmfDMMrANKAmO3Aue4ta45ZZoNQgnRFKTmsXvSgHIjava7Hcq1
	 vVZ7D8ShM9O2keL/o19P/tV/hLD6bdkzf8aMFbxmHnZAaSqQRPF9ZHfgsU5u8gzESw
	 PgRePemdmycWjy8QjoKUGTKyaY9q+DPySoYQhkS/OiP5jdpSOLIdhc+GP7eqe5Q4tW
	 Q9dERIVXoylLA==
Date: Fri, 17 May 2024 08:56:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Zorro Lang <zlang@redhat.com>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCHSET v5.6] fstests: fs-verity support for XFS
Message-ID: <20240517155629.GL360908@frogsfrogsfrogs>
References: <20240430031134.GH360919@frogsfrogsfrogs>
 <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
 <20240511050146.vc4jr2gagwjwwhdp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511050146.vc4jr2gagwjwwhdp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Sat, May 11, 2024 at 01:01:46PM +0800, Zorro Lang wrote:
> Hi Darrick,
> 
> Due to only half of this patchset got reviewed, so I'd like to wait for your
> later version. I won't pick up part of this patchset to merge this time, I
> think better to merge it as an integrated patchset.

Christoph and I talked about the future of this patchset at LSF and
there are some file format changes in store, so please hold off on
analyzing this patchset for now.

--D

> Thanks,
> Zorro
> 
> On Mon, Apr 29, 2024 at 08:19:24PM -0700, Darrick J. Wong wrote:
> > Hi all,
> > 
> > This patchset adds support for fsverity to XFS.  In keeping with
> > Andrey's original design, XFS stores all fsverity metadata in the
> > extended attribute data.  However, I've made a few changes to the code:
> > First, it now caches merkle tree blocks directly instead of abusing the
> > buffer cache.  This reduces lookup overhead quite a bit, at a cost of
> > needing a new shrinker for cached merkle tree blocks.
> > 
> > To reduce the ondisk footprint further, I also made the verity
> > enablement code detect trailing zeroes whenever fsverity tells us to
> > write a buffer, and elide storing the zeroes.  To further reduce the
> > footprint of sparse files, I also skip writing merkle tree blocks if the
> > block contents are entirely hashes of zeroes.
> > 
> > Next, I implemented more of the tooling around verity, such as debugger
> > support, as much fsck support as I can manage without knowing the
> > internal format of the fsverity information; and added support for
> > xfs_scrub to read fsverity files to validate the consistency of the data
> > against the merkle tree.
> > 
> > Finally, I add the ability for administrators to turn off fsverity,
> > which might help recovering damaged data from an inconsistent file.
> > 
> > From Andrey Albershteyn:
> > 
> > Here's v5 of my patchset of adding fs-verity support to XFS.
> > 
> > This implementation uses extended attributes to store fs-verity
> > metadata. The Merkle tree blocks are stored in the remote extended
> > attributes. The names are offsets into the tree.
> > From Darrick J. Wong:
> > 
> > This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
> > fsverity for XFS.
> > 
> > The biggest thing that I didn't like in the v5 patchset is the abuse of
> > the data device's buffer cache to store the incore version of the merkle
> > tree blocks.  Not only do verity state flags end up in xfs_buf, but the
> > double-alloc flag wastes memory and doesn't remain internally consistent
> > if the xattrs shift around.
> > 
> > I replaced all of that with a per-inode xarray that indexes incore
> > merkle tree blocks.  For cache hits, this dramatically reduces the
> > amount of work that xfs has to do to feed fsverity.  The per-block
> > overhead is much lower (8 bytes instead of ~300 for xfs_bufs), and we no
> > longer have to entertain layering violations in the buffer cache.  I
> > also added a per-filesystem shrinker so that reclaim can cull cached
> > merkle tree blocks, starting with the leaf tree nodes.
> > 
> > I've also rolled in some changes recommended by the fsverity maintainer,
> > fixed some organization and naming problems in the xfs code, fixed a
> > collision in the xfs_inode iflags, and improved dead merkle tree cleanup
> > per the discussion of the v5 series.  At this point I'm happy enough
> > with this code to start integrating and testing it in my trees, so it's
> > time to send it out a coherent patchset for comments.
> > 
> > For v5.3, I've added bits and pieces of online and offline repair
> > support, reduced the size of partially filled merkle tree blocks by
> > removing trailing zeroes, changed the xattr hash function to better
> > avoid collisions between merkle tree keys, made the fsverity
> > invalidation bitmap unnecessary, and made it so that we can save space
> > on sparse verity files by not storing merkle tree blocks that hash
> > totally zeroed data blocks.
> > 
> > From Andrey Albershteyn:
> > 
> > Here's v5 of my patchset of adding fs-verity support to XFS.
> > 
> > This implementation uses extended attributes to store fs-verity
> > metadata. The Merkle tree blocks are stored in the remote extended
> > attributes. The names are offsets into the tree.
> > 
> > If you're going to start using this code, I strongly recommend pulling
> > from my git trees, which are linked below.
> > 
> > This has been running on the djcloud for months with no problems.  Enjoy!
> > Comments and questions are, as always, welcome.
> > 
> > --D
> > 
> > kernel git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity
> > 
> > xfsprogs git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity
> > 
> > fstests git tree:
> > https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity
> > ---
> > Commits in this patchset:
> >  * common/verity: enable fsverity for XFS
> >  * xfs/{021,122}: adapt to fsverity xattrs
> >  * xfs/122: adapt to fsverity
> >  * xfs: test xfs_scrub detection and correction of corrupt fsverity metadata
> >  * xfs: test disabling fsverity
> >  * common/populate: add verity files to populate xfs images
> > ---
> >  common/populate    |   24 +++++++++
> >  common/verity      |   39 ++++++++++++++-
> >  tests/xfs/021      |    3 +
> >  tests/xfs/122.out  |    3 +
> >  tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/1880.out |   37 ++++++++++++++
> >  tests/xfs/1881     |  111 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/1881.out |   28 +++++++++++
> >  8 files changed, 378 insertions(+), 2 deletions(-)
> >  create mode 100755 tests/xfs/1880
> >  create mode 100644 tests/xfs/1880.out
> >  create mode 100755 tests/xfs/1881
> >  create mode 100644 tests/xfs/1881.out
> > 
> 
> 

