Return-Path: <linux-fsdevel+bounces-31994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8332099EE3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A98C1F254AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4086172BB9;
	Tue, 15 Oct 2024 13:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ka8D5aZk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E51AF0D2;
	Tue, 15 Oct 2024 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000472; cv=none; b=nvAKNeXXthE8YdNRbcu7JyMzukuXDyKl+CBIXHe2j2mhQl6QibSNaDGBOA0YnT8yqYHJNgPU1JiqdCgVVPRdjkhXuBikcBB9vKIau+pAyl7DxfZIJWtoESJ9vuEbQ9IQAG28YI20XTPszvjlnSldzl4eHbOUoeyV99DQ1gBwlXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000472; c=relaxed/simple;
	bh=/eoXAF6sKjSl7j5RJ5J7LCa9D0/hptE4xTgs9Hhekbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nP1cgcOSa3d7Wu5qsh1i1054kmdJrHbva3uUTZBu+MwWHahDROSrf0PzEKtmxmToxzNiETlk+4YVy31o7WO3A+Hq/e0PgGF8mB2YeUVrkzbwSjURoHPuuWFliREMaoKT20rEryy/H3gnigRMJdnZQqlXFQlV08N/AE/f9DkLrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ka8D5aZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209BFC4CED0;
	Tue, 15 Oct 2024 13:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000471;
	bh=/eoXAF6sKjSl7j5RJ5J7LCa9D0/hptE4xTgs9Hhekbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ka8D5aZkHEepWUB0VOleuqva3xtGtuXtj2VOrRRnEtfWgxCu+oG4iXV+vfn3NxAyQ
	 eNSqE3P/cI1mLqdnZMjmzucvwdLodkRK00C1d2acj15ajCt6dQjNUVpp6pfdzs9Gci
	 QpaOgPUtcsuh+MOyIK3C17ZmMaupYNcwpK/2jxf1kY54FodlWSgleSHhMPIezRfCvb
	 FTP3jZ9Ka1htnROnlTO6iV8vM7rZ08oUdWW+wPEmAZKtDqi8txEcDHlXftc/gHBWJg
	 7owsXv9pBbtAstUCZEaKjZjcpp64o1pNlBpeUbS/vH2HeguvRzdZEjMXwkjgn+F9ak
	 1Jdi4SJvpB1MQ==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iomap: turn iomap_want_unshare_iter into an inline function
Date: Tue, 15 Oct 2024 15:54:23 +0200
Message-ID: <20241015-fischen-pavian-5087edf46590@brauner>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015041350.118403-1-hch@lst.de>
References: <20241015041350.118403-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=brauner@kernel.org; h=from:subject:message-id; bh=/eoXAF6sKjSl7j5RJ5J7LCa9D0/hptE4xTgs9Hhekbs=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTzlQjKsV9mtX0kfWTC8oT3V00ruNYVSHyb3r/bjmmqv jZvnd39jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInse8PwV6Zo76nkxXx6WdYM n6VndCX8fOdc75caGhwo6NrQ67bmLCPD98Vn5Db1VG2qLchwmGXy8LzwcmP/ST/bw2amxN+dUfm UDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 15 Oct 2024 06:13:50 +0200, Christoph Hellwig wrote:
> iomap_want_unshare_iter currently sits in fs/iomap/buffered-io.c, which
> depends on CONFIG_BLOCK.  It is also in used in fs/dax.c whіch has no
> such dependency.  Given that it is a trivial check turn it into an inline
> in include/linux/iomap.h to fix the DAX && !BLOCK build.
> 
> 

Applied to the vfs.iomap branch of the vfs/vfs.git tree.
Patches in the vfs.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.iomap

[1/1] iomap: turn iomap_want_unshare_iter into an inline function
      https://git.kernel.org/vfs/vfs/c/13586180450a

