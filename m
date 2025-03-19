Return-Path: <linux-fsdevel+bounces-44426-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C94A68714
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2088918937DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65A6251785;
	Wed, 19 Mar 2025 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXdDCIK0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE115A85A;
	Wed, 19 Mar 2025 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373647; cv=none; b=NrV33edhotXR/idn3MsTWDUN2tq67mSgMqNWEDTuRfytnSqhxyVr0CopsLYPf2YYHHx1QxrVOHvzlgvhG6Ex3K7C7lnVZmGVnLSBfjDPDQKcCga9HCJumA3c4mXiaOBugQFMa9JBriyXn6Crn21eqQ2JnQhbGDJvD13kOFfZ2oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373647; c=relaxed/simple;
	bh=SbA4LrXka1Li7WuMqZY0Sq9GlTGzLuYjPQjhl3PE8uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W1IBTBd5xOL2oJSO0brRsaJs4TnvdWDHs1Vx6ZWcXs/M3UuGzUOLHMBE4b89rK0xbTviRp+RzODGMc/OSWYZgoZxlvl/zjHJj5AFtkQBG/gAJGjqRyAX/YGNttYhnK0xuT5Qbu7ETQscPg9Pszg3m4T6+9Ylr0l1jJxk4JYkoWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXdDCIK0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB00C4CEE9;
	Wed, 19 Mar 2025 08:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373646;
	bh=SbA4LrXka1Li7WuMqZY0Sq9GlTGzLuYjPQjhl3PE8uU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EXdDCIK0FoUKDa9G21rvtDm8URosRy+quzgxa/C9mQnx4ShATP6jf+Sw3d+y5ewkS
	 CXgawqrcfHJ81niukUpjIJRsfs4ZCN9XeLcWc3j0uWGtlwyBXzmOrcXQorl+o4YYX/
	 5S9xB8V9u/RZjVxO1Shu2AjTD6Pebht/JnkaUlPRAd3abWC44ZjnnsT/v/haBl8UOq
	 Zr6l8S0c3Qptos+IxfsWCvwa7GYgwynP+HgAjtC/uVUq3GsAa6wx1DFDaHQUwZtMyV
	 4xpPvyY6IPgVm8GpWmQCtPFPNZ6IRUG9n6bRQofRWB84iWkkF2Q1EykMwjgjRUtk8q
	 U6CVLPZ4hue7A==
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-nfs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 1/6] VFS: improve interface for lookup_one functions
Date: Wed, 19 Mar 2025 09:40:24 +0100
Message-ID: <20250319-landkarte-schornstein-a9594c2fe435@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250319031545.2999807-2-neil@brown.name>
References: <20250319031545.2999807-1-neil@brown.name> <20250319031545.2999807-2-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1759; i=brauner@kernel.org; h=from:subject:message-id; bh=SbA4LrXka1Li7WuMqZY0Sq9GlTGzLuYjPQjhl3PE8uU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTfamZ/ZLNlWYDmDZVNXcJN5Tqbr+ZzJcw1OzSl4vGpt exbgjk/dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk7zWGf2rF/4pDdv8vvxW4 hPmfM7/Ry60/5qvu2Xs9SqJIy2H/2x6Gf3qJ4Z+Xzo6N0V0/iXnRQ6U5vimbPaw/RCbu3LthW/m OaawA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Wed, 19 Mar 2025 14:01:32 +1100, NeilBrown wrote:
> The family of functions:
>   lookup_one()
>   lookup_one_unlocked()
>   lookup_one_positive_unlocked()
> 
> appear designed to be used by external clients of the filesystem rather
> than by filesystems acting on themselves as the lookup_one_len family
> are used.
> 
> [...]

Applied to the vfs-6.16.async.dir branch of the vfs/vfs.git tree.
Patches in the vfs-6.16.async.dir branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.16.async.dir

[1/6] VFS: improve interface for lookup_one functions
      https://git.kernel.org/vfs/vfs/c/d01d332dbf28
[2/6] nfsd: Use lookup_one() rather than lookup_one_len()
      https://git.kernel.org/vfs/vfs/c/4c664a5962b7
[3/6] cachefiles: Use lookup_one() rather than lookup_one_len()
      https://git.kernel.org/vfs/vfs/c/ebc0dcbf5ba2
[4/6] VFS: rename lookup_one_len family to lookup_noperm and remove permission check
      https://git.kernel.org/vfs/vfs/c/12597aa5fea6
[5/6] Use try_lookup_noperm() instead of d_hash_and_lookup() outside of VFS
      https://git.kernel.org/vfs/vfs/c/d2bacbb4495a
[6/6] VFS: change lookup_one_common and lookup_noperm_common to take a qstr
      https://git.kernel.org/vfs/vfs/c/b496b0712e63

