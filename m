Return-Path: <linux-fsdevel+bounces-18211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690068B684C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA0EB1F21EC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87E7101C5;
	Tue, 30 Apr 2024 03:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3DNxmWQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F74DDDA;
	Tue, 30 Apr 2024 03:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447166; cv=none; b=cwt6zQub3omfK2b1jhcLt75hpoab+snXCi8cy6mSyRkaRvMuGeHu4RWGFlkGrVCKMEqduwvSJ4tyXVgjPZp5CjcTSB8mMRTltxzEbd0PYGYYBS7esdJUJPhaDR/zSyVaYF7BJCHbIYG4kcwCHj1bvv7RH2PGGErrjkxDBsdA370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447166; c=relaxed/simple;
	bh=FHlcZvFx6GfuKtymFK4OGO+74fcA3bU1aWNe4GeLjZ4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G72RkFWPvw1u8EdHpFZKCZ/zpaCXJuAlP1Tf5j9ckufriFJMR5UofbZsYX6XKf7h068tHLsm1Q/SQkrz9XXX/k8Us2fD9zGDRDm3u0Pt7KDq0uO4C1wFYYTbrTO/UGJqnmR+H917NgswDXCjQRLAzdOtlI0tZ/v1f0ng8eDAYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3DNxmWQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDA0C116B1;
	Tue, 30 Apr 2024 03:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447165;
	bh=FHlcZvFx6GfuKtymFK4OGO+74fcA3bU1aWNe4GeLjZ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=k3DNxmWQoP2K48vdbyGH39ytCfxdcelEgltdFCfKM2eyqwVu5NXUNsXgWKzleWpoc
	 o4DiCm3AFtbtQhV2wsK8UHhMG/mCKz0rtXj6lTryLXnJYl5THJC8+o8ELyO/2HAnIH
	 10V2iInASne6/cBg6ZM1DLHVpIkC6HSeqmVzJ8sQiPPWh6l/9Ikh8VbZfjXks6Zf6a
	 ap8vhUzr6Hksd8+PP1WJwX4fc32kNnGM9Wo/qvXegzWLNNjRrqPZ55Wfp1W0phSamL
	 UHHBCCtQUDHey15yOQDHMpiDGvcBMKO6AA0PkdeK4rRy1VuO4o9y/wx5betFugUcXD
	 1frt7lygLi99w==
Date: Mon, 29 Apr 2024 20:19:24 -0700
Subject: [PATCHSET v5.6] fstests: fs-verity support for XFS
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: Andrey Albershteyn <andrey.albershteyn@gmail.com>,
 fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
In-Reply-To: <20240430031134.GH360919@frogsfrogsfrogs>
References: <20240430031134.GH360919@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

This patchset adds support for fsverity to XFS.  In keeping with
Andrey's original design, XFS stores all fsverity metadata in the
extended attribute data.  However, I've made a few changes to the code:
First, it now caches merkle tree blocks directly instead of abusing the
buffer cache.  This reduces lookup overhead quite a bit, at a cost of
needing a new shrinker for cached merkle tree blocks.

To reduce the ondisk footprint further, I also made the verity
enablement code detect trailing zeroes whenever fsverity tells us to
write a buffer, and elide storing the zeroes.  To further reduce the
footprint of sparse files, I also skip writing merkle tree blocks if the
block contents are entirely hashes of zeroes.

Next, I implemented more of the tooling around verity, such as debugger
support, as much fsck support as I can manage without knowing the
internal format of the fsverity information; and added support for
xfs_scrub to read fsverity files to validate the consistency of the data
against the merkle tree.

Finally, I add the ability for administrators to turn off fsverity,
which might help recovering damaged data from an inconsistent file.

From Andrey Albershteyn:

Here's v5 of my patchset of adding fs-verity support to XFS.

This implementation uses extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes. The names are offsets into the tree.
From Darrick J. Wong:

This v5.3 patchset builds upon v5.2 of Andrey's patchset to implement
fsverity for XFS.

The biggest thing that I didn't like in the v5 patchset is the abuse of
the data device's buffer cache to store the incore version of the merkle
tree blocks.  Not only do verity state flags end up in xfs_buf, but the
double-alloc flag wastes memory and doesn't remain internally consistent
if the xattrs shift around.

I replaced all of that with a per-inode xarray that indexes incore
merkle tree blocks.  For cache hits, this dramatically reduces the
amount of work that xfs has to do to feed fsverity.  The per-block
overhead is much lower (8 bytes instead of ~300 for xfs_bufs), and we no
longer have to entertain layering violations in the buffer cache.  I
also added a per-filesystem shrinker so that reclaim can cull cached
merkle tree blocks, starting with the leaf tree nodes.

I've also rolled in some changes recommended by the fsverity maintainer,
fixed some organization and naming problems in the xfs code, fixed a
collision in the xfs_inode iflags, and improved dead merkle tree cleanup
per the discussion of the v5 series.  At this point I'm happy enough
with this code to start integrating and testing it in my trees, so it's
time to send it out a coherent patchset for comments.

For v5.3, I've added bits and pieces of online and offline repair
support, reduced the size of partially filled merkle tree blocks by
removing trailing zeroes, changed the xattr hash function to better
avoid collisions between merkle tree keys, made the fsverity
invalidation bitmap unnecessary, and made it so that we can save space
on sparse verity files by not storing merkle tree blocks that hash
totally zeroed data blocks.

From Andrey Albershteyn:

Here's v5 of my patchset of adding fs-verity support to XFS.

This implementation uses extended attributes to store fs-verity
metadata. The Merkle tree blocks are stored in the remote extended
attributes. The names are offsets into the tree.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

This has been running on the djcloud for months with no problems.  Enjoy!
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fsverity

xfsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfsprogs-dev.git/log/?h=fsverity

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=fsverity
---
Commits in this patchset:
 * common/verity: enable fsverity for XFS
 * xfs/{021,122}: adapt to fsverity xattrs
 * xfs/122: adapt to fsverity
 * xfs: test xfs_scrub detection and correction of corrupt fsverity metadata
 * xfs: test disabling fsverity
 * common/populate: add verity files to populate xfs images
---
 common/populate    |   24 +++++++++
 common/verity      |   39 ++++++++++++++-
 tests/xfs/021      |    3 +
 tests/xfs/122.out  |    3 +
 tests/xfs/1880     |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1880.out |   37 ++++++++++++++
 tests/xfs/1881     |  111 +++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/1881.out |   28 +++++++++++
 8 files changed, 378 insertions(+), 2 deletions(-)
 create mode 100755 tests/xfs/1880
 create mode 100644 tests/xfs/1880.out
 create mode 100755 tests/xfs/1881
 create mode 100644 tests/xfs/1881.out


