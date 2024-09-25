Return-Path: <linux-fsdevel+bounces-30051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E1398564B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBCB2846F4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53FE15B570;
	Wed, 25 Sep 2024 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPbHKLV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E22F12D20D;
	Wed, 25 Sep 2024 09:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256289; cv=none; b=RfflnRPwn/YzKlGYdikAn9Z5CxJzY870AyiB/6pE/8sSPmXhZMLwtLI68cyyCne1QY/10+eD6NxIRZzDZ3RHva7w0FdQ4BTuRa+bxbhD9gSOopHiz9iFKv5kiZLJSElrKeSzvFZ22nKJG4qJ2qXhYZ2qYegrh/p4YxFYLt/Pe04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256289; c=relaxed/simple;
	bh=uPw0oG6aoHzp3ov2gu1o+AyTBz3JDueP1649ca6JBEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQhO+8MPxq8OeYZpNL7kH5CPMcgkbifE04jaJhE7zBxyFOgy3Y0Hxh8TyRL3Rua7uhptqgqPllmUN9GTZFRMuazHYhyVhsXDs9BtI2EMybQp5kcHk6JD63Up8H4emGuYBwrTxwMVlWy4WWnDxQzmkK2aycXTSRA7ifA9hz/zoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPbHKLV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09C4C4CEC3;
	Wed, 25 Sep 2024 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727256288;
	bh=uPw0oG6aoHzp3ov2gu1o+AyTBz3JDueP1649ca6JBEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aPbHKLV3Dc1cCpeA8FmbJaWqB/41ZRIxN2xLcZyIAmQ+ECVUuY4jIy5GFFeXg7IVm
	 oQVRdhK7W9NOGbQCzYKwMWYzPBDlCR+kPGjjxNnHAVctiMwCSsl5f9XIJbrjptuNsf
	 3mFXQYL8TMhRflXuw3IkxwcNBSuWC9qurOBlCTsKVqQqpdYKn93A1T3KzhM1is5t7f
	 akvhQw6jF4ERU9jHFxEdRJ9lI6SpIf4sJsgn9Qa5ymo8wQS8nroyw7KFCDqHCVd6AA
	 Z1wb6ruVr5GjwzGai5Mq09sNrwmKCmKf8mxmdE3T+kOs8BRWx67q9SpwdQQ6xetI/I
	 4A5Ai5fIHyihQ==
From: Christian Brauner <brauner@kernel.org>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v4
Date: Wed, 25 Sep 2024 11:24:36 +0200
Message-ID: <20240925-lauftraining-zollfrei-d61da7c6f171@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240924074115.1797231-1-hch@lst.de> <20240925-beinhalten-sagenhaft-184f5cc9035b@brauner>
References: <20240924074115.1797231-1-hch@lst.de> <20240925-beinhalten-sagenhaft-184f5cc9035b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2393; i=brauner@kernel.org; h=from:subject:message-id; bh=uPw0oG6aoHzp3ov2gu1o+AyTBz3JDueP1649ca6JBEo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9vnb9+FbLia8Oay2eMf9bpofMadVJl30NYtJWfa2bI M6UfOHzy45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJfHrMyHD4qp9ba3T9NUW9 qaJVG/a/i+IIV2Y/XM/QffrlrRlMYvsYGba1prIqpihyhdRlFk1r3a5tst5H55zbo8+fOWYed4m 4xAsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 24 Sep 2024 09:40:42 +0200, Christoph Hellwig wrote:
> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> [...]

Sorry, pulled v3 on accident. Now actually pulled v4.

---

Applied to the vfs.iomap.v6.13 branch of the vfs/vfs.git tree.
Patches in the vfs.iomap.v6.13 branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap.v6.13

[01/10] iomap: factor out a iomap_last_written_block helper
        https://git.kernel.org/vfs/vfs/c/5d33a6215cf4
[02/10] iomap: remove iomap_file_buffered_write_punch_delalloc
        https://git.kernel.org/vfs/vfs/c/45f14ab7316c
[03/10] iomap: move locking out of iomap_write_delalloc_release
        https://git.kernel.org/vfs/vfs/c/7f700d206e70
[04/10] xfs: factor out a xfs_file_write_zero_eof helper
        https://git.kernel.org/vfs/vfs/c/83b6773ce54a
[05/10] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
        https://git.kernel.org/vfs/vfs/c/63744a511a6a
[06/10] xfs: zeroing already holds invalidate_lock
        https://git.kernel.org/vfs/vfs/c/7156dde42b72
[07/10] xfs: support the COW fork in xfs_bmap_punch_delalloc_range
        https://git.kernel.org/vfs/vfs/c/3bc21e71b820
[08/10] xfs: share more code in xfs_buffered_write_iomap_begin
        https://git.kernel.org/vfs/vfs/c/367332e4a22a
[09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
        https://git.kernel.org/vfs/vfs/c/a032a49ce426
[10/10] xfs: punch delalloc extents from the COW fork for COW writes
        https://git.kernel.org/vfs/vfs/c/23bdeeb38d2e

