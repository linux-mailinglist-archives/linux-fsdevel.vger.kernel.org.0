Return-Path: <linux-fsdevel+bounces-67103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098EC355D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 12:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE6318C54B2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 11:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3484A2D7DE8;
	Wed,  5 Nov 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVFKczwF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B51191493;
	Wed,  5 Nov 2025 11:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762342274; cv=none; b=n/NWNPvedAWHXuGKhuVZmz5tFidGvt84ZSyWomu5gwI58BWPKDr9aMtAkSa7qPZeceacP31RdFRixZg03khc8cm/j48wrrBMg+pSSNYSdhG88mOYv9uV4Y4/T3PyIoG/He7xkqqHqvbvzVkVK06CmZx/B6OUcUh752Fucf1bvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762342274; c=relaxed/simple;
	bh=WtURY0uD44AoguOSak+nV2pEPZmlCr/xoq++x7NStGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H/zMEhPEBpV7moN3m+AYZEjQLNSQ6zKq3cEf0JAD88+g9RnMtZR/dFrA3X4bz+y4VnM2QnPVXojJATYST6qkO5AjMo6Ccrd7OiKPid0Xs5OupfSKpnLJY1+tZ0MV4YvIcB0Kqq3pkvJoplIJYQ0P0WRp2VNpF7ShOlVUKi4+dyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVFKczwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33A6C4CEF8;
	Wed,  5 Nov 2025 11:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762342274;
	bh=WtURY0uD44AoguOSak+nV2pEPZmlCr/xoq++x7NStGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZVFKczwF/5vVhuE2JiD/87qvFzMgcc8sOlNhbgU4vD/8o+OEIaw2bdL5aQ/+6qMm/
	 070QG5V9CvJq7J40yvjR3KHln+ro9rwh3fVQVKHTvHAPhep5jI1ZY+/n9jVOk9Es5m
	 LvUhMg1ExclS17Cqdmd2CS2IzPCo3rMJtwxN5Dyfhym9ybxoXjpHF476rvQeXfQyVO
	 +dYsuwSa/NGDEqhdKHh1eRWrLeF5HUsQtM+3yhZk9dtOBORi5TBFEFuEMjk1rGealn
	 LfRGh+qEY/xkXL0+BIASE3Q/Obw69pB7YBkCmAEug2sTcqYgbOSB/NuVLCPJytWlFf
	 g11F+cYOrcTQg==
From: Christian Brauner <brauner@kernel.org>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Qu Wenruo <wqu@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: Re: [PATCH RFC 0/2] fs: fully sync all fsese even for an emergency sync
Date: Wed,  5 Nov 2025 12:31:05 +0100
Message-ID: <20251105-rezitieren-anpfiff-4e21c114802d@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1762142636.git.wqu@suse.com>
References: <cover.1762142636.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=brauner@kernel.org; h=from:subject:message-id; bh=WtURY0uD44AoguOSak+nV2pEPZmlCr/xoq++x7NStGU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRym9bqrN/zVktr/+2jTb+1d7vflbfY9PXAnLCKluBFq 3d2H8hd0lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRypOMDD+CdxtIvPg5/baY td2HzKNMnq1Zx45nmM4rKVJ+fuv74vMM/1Sa3uVwmfnYVWzx8SmTmhe3tZy95UCA3g+D6ufzZc5 3sQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Mon, 03 Nov 2025 14:37:27 +1030, Qu Wenruo wrote:
> The first patch is a cleanup related to sync_inodes_one_sb() callback.
> Since it always wait for the writeback, there is no need to pass any
> parameter for it.
> 
> The second patch is a fix mostly affecting btrfs, as btrfs requires a
> explicit sync_fc() call with wait == 1, to commit its super blocks,
> and sync_bdevs() won't cut it at all.
> 
> [...]

Applied to the vfs-6.19.misc branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.misc

[1/2] fs: do not pass a parameter for sync_inodes_one_sb()
      https://git.kernel.org/vfs/vfs/c/fbc22c299636
[2/2] fs: fully sync all fses even for an emergency sync
      https://git.kernel.org/vfs/vfs/c/2706659d642e

