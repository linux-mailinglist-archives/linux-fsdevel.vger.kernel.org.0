Return-Path: <linux-fsdevel+bounces-63543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18E3BC119E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B83E3B0E3E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7DF2D94A6;
	Tue,  7 Oct 2025 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANmC41sp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE4192D68;
	Tue,  7 Oct 2025 11:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835529; cv=none; b=kGF+oJovlePZWHZBNNkzZ75WYy0/xleHbyS7PcPaGICgkbB2u2metTUETT0Vv08Taio7gSJuIAE4KSSaYuQ+foSkdv8q9HhiHuIDJ+Ed+xMBVSNZZA3sIbmpEukdUlpsF+jm60T8jlAq6ixeB8NCWCHCjlxF3m9IeTSFS0aQtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835529; c=relaxed/simple;
	bh=y59Hzrx70QzGvjpVw8oWwWW4S1dfEWaSGLjaUnb+Nyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EPELsox+HdzAuln5VBVsEPoaNgfY9J/rdqRk5nEcxZclMLilJS9XpJrQClNnEVbZdbhpQdq/uEamZLAB08wTMb/ZvYtqH3IIDPml+FfwP+Qy99BctgEdnuxPdVxFnHYZbtoJbKXwlFMiMuAu6eK5NX/sXQLbL64sLWRRs/ZOkgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANmC41sp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0B6C4CEF1;
	Tue,  7 Oct 2025 11:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759835527;
	bh=y59Hzrx70QzGvjpVw8oWwWW4S1dfEWaSGLjaUnb+Nyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ANmC41spX4gmn7wUij7P7tZD8nz7BBusmjGjVsPhQ8aJZLEVU6IBVDcTcDgFVNy8S
	 pOjZcm4W9qNA/xg4s8fJUu6yn8mVeNPdnvEUoA5BSuUSSkNJYsBQ8UUo9+EtToTBlG
	 7Xsytbw+3jMbftALxVs+2oTOqSG0/me62L7pB+ZwVuzaP9bOV6iRL04z0kdiJHfwnO
	 qJ+92aDjvIJ5dxmJIchmixRypEFLW0ECI9K8xUIthRQ4pEomVRmRGiHa54yDJ/8pMH
	 hwtiu4TNGdo9saqnfCoirkyn9MjqA8hQ5ACaVPafYaq8NYfjfdorsXSnx78qCJxsBV
	 0ar/opAtlzdbQ==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	hch@infradead.org,
	djwong@kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v5 0/7] iomap: zero range folio batch support
Date: Tue,  7 Oct 2025 13:12:01 +0200
Message-ID: <20251007-kittel-tiefbau-c3cc06b09439@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251003134642.604736-1-bfoster@redhat.com>
References: <20251003134642.604736-1-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134; i=brauner@kernel.org; h=from:subject:message-id; bh=y59Hzrx70QzGvjpVw8oWwWW4S1dfEWaSGLjaUnb+Nyo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ8+do0r+3ezLAz+Qk3JpoH9Kstu7uDVcopNOHMwR77l X9ljjHc6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIhhUjwxGLhLev9fW37E9q Z7mx6/vSBV8+tE/zi7u+ZN4fpYyITCZGhjmHZN1y/hu02Us9Edi9v0/azHgBw4N13+dIKyQuN+e s4gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Fri, 03 Oct 2025 09:46:34 -0400, Brian Foster wrote:
> Only minor changes in v5 to the XFS errortag patch. I've kept the R-b
> tags because the fundamental logic is the same, but the errortag
> mechanism has been reworked and so that one needed a rebase (which turns
> out much simpler). A second look certainly couldn't hurt, but otherwise
> the associated fstest still works as expected.
> 
> Note that the force zeroing fstests test has since been merged as
> xfs/131. Otherwise I still have some followup patches to this work re:
> the ext4 on iomap work, but it would be nice to move this along before
> getting too far ahead with that.
> 
> [...]

Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
Patches in the vfs-6.19.iomap branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs-6.19.iomap

[1/7] filemap: add helper to look up dirty folios in a range
      https://git.kernel.org/vfs/vfs/c/757f5ca76903
[2/7] iomap: remove pos+len BUG_ON() to after folio lookup
      https://git.kernel.org/vfs/vfs/c/e027b6ecb710
[3/7] iomap: optional zero range dirty folio processing
      https://git.kernel.org/vfs/vfs/c/5a9a21cb7706
[4/7] xfs: always trim mapping to requested range for zero range
      https://git.kernel.org/vfs/vfs/c/50dc360fa097
[5/7] xfs: fill dirty folios on zero range of unwritten mappings
      https://git.kernel.org/vfs/vfs/c/492258e4508a
[6/7] iomap: remove old partial eof zeroing optimization
      https://git.kernel.org/vfs/vfs/c/47520b756355
[7/7] xfs: error tag to force zeroing on debug kernels
      https://git.kernel.org/vfs/vfs/c/87a5ca9f6c56

