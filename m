Return-Path: <linux-fsdevel+bounces-30050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB04398563A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 11:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61B8C1F23DEE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 09:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FD915B570;
	Wed, 25 Sep 2024 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jM+m31En"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFF512D20D;
	Wed, 25 Sep 2024 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727256001; cv=none; b=OE2JQoMCU/6rNuoZyZU9G5gIO6gVoybvjZxJl1Zzm6Y9lyC1jSQaBW9w+Roun/uqbm2YE1euuIYi/rVDnAXYbzy03hdufTsHyTKC9wx7FI2USWnJAO4Mf5KCSAyKCqM+0ueYeVDVeFq4bwDxMAnXdjE1Oif5XLgfQGw4Jv1qH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727256001; c=relaxed/simple;
	bh=qpAQgIjgWM2CygDijlzW6i1v4qqbssZ9fafaj8S+mKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PW3wuthlc92UPBvZVcPLszb84/USNX/i4jYCf4figvpazRAee5uvYkeVPxcRP3Qwmqpm7XJsMKYjQTQThSuFpOOE6Hq166BIqzfSTq03KiKF1Xpekr3dNT9zip2xab6bkUv/yHhMyUdOA6BqKdZ4SH5Ih5cK5SjKS3m2o31ioiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jM+m31En; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1F0C4CEC3;
	Wed, 25 Sep 2024 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727256001;
	bh=qpAQgIjgWM2CygDijlzW6i1v4qqbssZ9fafaj8S+mKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jM+m31EnUXGQAO0CZuQe55tneahmG9RTi/FQaCBI4miRDNXFks0s1SmvFdPiWnI1N
	 Za0a40O5IpXxolLO7lBiLOJgP8q6/N+g4rdE5hFLDhQXePC6W+MyjGbGFfim70/bOi
	 8OnTquJJ9NyiF/iiDYlRIhVepMOrWWkmxfTH7itHoNORKsEfRbQxYEN6CRkkXfaTs8
	 X2cNjSCmscLpaUlW5pz76/MGLmrnrUnKK+IQgxV86J9SY/Ec38ikTBFW/HIagcwigE
	 3Z9Gj3XQbpf+0OWVA6UGcJEvV/4nbYKZuniUnkoojYjCwUTLD7Si4xh0fvE8Kgx903
	 13QqKOfIGjD4A==
From: Christian Brauner <brauner@kernel.org>
To: Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: fix stale delalloc punching for COW I/O v3
Date: Wed, 25 Sep 2024 11:19:27 +0200
Message-ID: <20240925-beinhalten-sagenhaft-184f5cc9035b@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923152904.1747117-1-hch@lst.de>
References: <20240923152904.1747117-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2387; i=brauner@kernel.org; h=from:subject:message-id; bh=qpAQgIjgWM2CygDijlzW6i1v4qqbssZ9fafaj8S+mKY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaR9vrpb62rVSnuLtcw/d9Y3LJl6du7ahiTZNTmPdxsm/ 51VfszAoqOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiO5UZ/udMOD87+k6IRKDe z0KN9vOHOUUPCKwtecvJtDFP5963ae8YGf5vE//MWF0fkn7/oeHhTx1xsfGTXn+6Ult8frdg5V+ FYh4A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 23 Sep 2024 17:28:14 +0200, Christoph Hellwig wrote:
> this is another fallout from the zoned XFS work, which stresses the XFS
> COW I/O path very heavily.  It affects normal I/O to reflinked files as
> well, but is very hard to hit there.
> 
> The main problem here is that we only punch out delalloc reservations
> from the data fork, but COW I/O places delalloc extents into the COW
> fork, which means that it won't get punched out forshort writes.
> 
> [...]

If that should take another route, let me know.

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
        https://git.kernel.org/vfs/vfs/c/91c5635e1fdc
[02/10] iomap: remove iomap_file_buffered_write_punch_delalloc
        https://git.kernel.org/vfs/vfs/c/7e8b9d3d403b
[03/10] iomap: move locking out of iomap_write_delalloc_release
        https://git.kernel.org/vfs/vfs/c/749a89eb81a3
[04/10] xfs: factor out a xfs_file_write_zero_eof helper
        https://git.kernel.org/vfs/vfs/c/86e3e09d26c4
[05/10] xfs: take XFS_MMAPLOCK_EXCL xfs_file_write_zero_eof
        https://git.kernel.org/vfs/vfs/c/fbe5a71ceb96
[06/10] xfs: zeroing already holds invalidate_lock
        https://git.kernel.org/vfs/vfs/c/b9db9ae79580
[07/10] xfs: support the COW fork in xfs_bmap_punch_delalloc_range
        https://git.kernel.org/vfs/vfs/c/73ca182d0a9f
[08/10] xfs: share more code in xfs_buffered_write_iomap_begin
        https://git.kernel.org/vfs/vfs/c/621aa9522fcb
[09/10] xfs: set IOMAP_F_SHARED for all COW fork allocations
        https://git.kernel.org/vfs/vfs/c/4bb081d6d8e0
[10/10] xfs: punch delalloc extents from the COW fork for COW writes
        https://git.kernel.org/vfs/vfs/c/48e0d3ca3198

