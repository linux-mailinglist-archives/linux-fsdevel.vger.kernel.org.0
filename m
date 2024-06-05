Return-Path: <linux-fsdevel+bounces-21054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD998FD19D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 933651C2264A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290248CFC;
	Wed,  5 Jun 2024 15:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZ9vzmT5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76B5D51C;
	Wed,  5 Jun 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717601355; cv=none; b=EQ3Rc6JU8JvxmYtqkP4OMLdN17OWPMByEvYT2KBKU4Jj7vTfMJklFzVZ0zhT3x5/YEVPZzOUO/5l2sCqFgHOrB+CKsc/DPsxN6l9+PAemNWqCAJkxPfm8MeaMhKE+YjCiKIXNa3WnhLfDi7oQXo23dly/3r+98K2H6A2A5xW6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717601355; c=relaxed/simple;
	bh=HwvNFpzT+al4U/Q+ANq8xw4diZyhziBGEYyh+bs+DIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFSEJ8jLoqJ9+jQopoCgp21tEkGAe4ifdt43lTlBLKfgLtgrsKoYpIBjdtUXdmgpKlcIzUOjD/CQpK7LfyBbt7JgT6h3sqMjEevq0ggBqgMTMghGMdGw/GEl8gLdCknb4N1kNihquTpItbSTrkKHlSYvPQ6TtN6KoetXNbGgWoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZ9vzmT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E1A5C2BD11;
	Wed,  5 Jun 2024 15:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717601355;
	bh=HwvNFpzT+al4U/Q+ANq8xw4diZyhziBGEYyh+bs+DIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZ9vzmT5OTLJNHr6S+I/JEDqav3byqcSeMtJVBd8aTDoL6u93h3pcY9Vs6jmLLiFM
	 so+odux6IPaLezC4hh3atH9M4RVqqNc4fc+nk/XsRw+qdkkSLBQ/B3hAuXoy2tCguQ
	 i/o0sE15ZnNgFmmtJD6QCEvquCCiGG1wBaCtVaRb3m6XA8RKvKDMNu2gXqJ5YT0VlS
	 zEWgsPwIG73D2IuS3e5fmWfcAM89RD8e8wkLi8PpzWTuVSzVWVuHoQgBWj+9ndljG8
	 WUvWLFMY8iUtfMgx9TXON4MCXCYHW2u1Fa+25F18tCCCfxWZNSFHfFZO/7OOdpD83S
	 2oxHlzUpKq2WA==
From: Christian Brauner <brauner@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	linux-xfs@vger.kernel.org
Subject: Re: (subset) [PATCHv2 1/2] iomap: Fix iomap_adjust_read_range for plen calculation
Date: Wed,  5 Jun 2024 17:29:05 +0200
Message-ID: <20240605-vorort-ausgibt-54881bbfe967@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com>
References: <cover.1715067055.git.ritesh.list@gmail.com> <a32e5f9a4fcfdb99077300c4020ed7ae61d6e0f9.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1332; i=brauner@kernel.org; h=from:subject:message-id; bh=HwvNFpzT+al4U/Q+ANq8xw4diZyhziBGEYyh+bs+DIE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQltDj1vBcPljW+9WcZ98YPm1YcfvXdwtDtQ6R2A/+sl UoFDL9SOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyM4WR4ce5RdkZXyzq576K 2H7u/oxHVctLdJ3bjBJE4hIPTb/7IJiR4dy3Sf+aa5IeK2/vfMMX2+Lz/gTHWalvmQyz7Pb8a9T 8zQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 07 May 2024 14:25:42 +0530, Ritesh Harjani (IBM) wrote:
> If the extent spans the block that contains i_size, we need to handle
> both halves separately so that we properly zero data in the page cache
> for blocks that are entirely outside of i_size. But this is needed only
> when i_size is within the current folio under processing.
> "orig_pos + length > isize" can be true for all folios if the mapped
> extent length is greater than the folio size. That is making plen to
> break for every folio instead of only the last folio.
> 
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/2] iomap: Fix iomap_adjust_read_range for plen calculation
      https://git.kernel.org/vfs/vfs/c/0fbe97059215

