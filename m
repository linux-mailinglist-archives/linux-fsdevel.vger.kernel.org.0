Return-Path: <linux-fsdevel+bounces-55826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18240B0F2A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00AE188F9E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4652E716E;
	Wed, 23 Jul 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOHA+p7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E00FD2FF;
	Wed, 23 Jul 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275375; cv=none; b=DNPcap0TNOImGsPQ470zT2adjrSOpECsNOAmqG+VKIMcIpF8bbxnQO39o0YAtjL4CIUBWc9B7uoaNo8r1EOco5REnMxY26/k+1pv51ynpACLHOtvMWmFAN/Ji2AOEDgz0F9Z9BDrGjA0Cu+rj4MN20wkLFUIfoj1ecwTv2QaSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275375; c=relaxed/simple;
	bh=4LObQmvPGP4Xdx54gMT9v2IhlSCfWXU+fc410oxbZs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJ/0AB2ZqAqkxSFQvMyZXmdjV5H4EHIxFO3kmY68iq11dh3tLGC3/iCEzjdmPhbfQ5SScduivztIrshLja898dRF6I3b7eqDaAIYT8zQWCY5T5VOiYdvsfDxx+uDIBN6H310aJq+iPap4I/JovxEoWdHvYY1Iga28Yib84wDx3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOHA+p7t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BC6C4CEE7;
	Wed, 23 Jul 2025 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753275375;
	bh=4LObQmvPGP4Xdx54gMT9v2IhlSCfWXU+fc410oxbZs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rOHA+p7ttbBQ8036RJGSlySh/y+ZJqFWBRaPjDL+EHaU5Q0A51GoipNlEWkbhN1xb
	 Nrl9A0bgLwjkEhV1L2X+r1X4ySWNaLnFExU8+k3XDOj2baHrVcGe3HL0B84SzBjL2p
	 NLtgQN8S2wP6jNRh2+7UIFKurMD4NBxB/muAaUzQ5NNINI5GvEdv+PWnuS3C9daroI
	 X20XR6I2usEIGUr5VJLYNFr2hxuhWzcWDbMqnLITENGefOhWY0nCpFT5PcYrzfrTTP
	 El1+54LaeABTU2Mz7eR8OsaOyQqgqLcmTHUkRJ+Xy0kPkEpEMmTizhcyR3Zz1canI0
	 q+HZ2kIAbvYXQ==
From: Christian Brauner <brauner@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	joshi.k@samsung.com,
	Christoph Hellwig <hch@lst.de>,
	vincent.fu@samsung.com,
	anuj1072538@gmail.com,
	axboe@kernel.dk,
	hch@infradead.org,
	martin.petersen@oracle.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH v3] block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP
Date: Wed, 23 Jul 2025 14:56:03 +0200
Message-ID: <20250723-rollbahn-abwesend-2179df4eefd9@brauner>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250722120755.87501-1-anuj20.g@samsung.com>
References: <20250722120755.87501-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=brauner@kernel.org; h=from:subject:message-id; bh=4LObQmvPGP4Xdx54gMT9v2IhlSCfWXU+fc410oxbZs8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ03H4pdrMzNOvNeZXgtNeaWrM+7J1sb8z6QJbjvmDbz x4tX22LjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc2czIMFte+94zq6t1PCkS KbPuygpohm7km1T7eeJk9557EybOUWb4Xzl54sy+2h3r44OZfNu73nOdM9witULsgP20tsy6nYc 3swEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 22 Jul 2025 17:37:55 +0530, Anuj Gupta wrote:
> The blk_get_meta_cap() implementation directly assigns bi->csum_type to
> the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
> blk_integrity_checksum values are not guaranteed to match the UAPI
> defined values.
> 
> Fix this by explicitly mapping internal checksum types to UAPI-defined
> constants to ensure compatibility and correctness, especially for the
> devices using CRC64 PI.
> 
> [...]

Applied to the vfs-6.17.integrity branch of the vfs/vfs.git tree.
Patches in the vfs-6.17.integrity branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.17.integrity

[1/1] block: fix lbmd_guard_tag_type assignment in FS_IOC_GETLBMD_CAP
      https://git.kernel.org/vfs/vfs/c/bc5b0c8febcc

