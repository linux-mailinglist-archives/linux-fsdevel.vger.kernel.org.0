Return-Path: <linux-fsdevel+bounces-65627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D942C094DE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE24F6AC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Oct 2025 16:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F47303CA2;
	Sat, 25 Oct 2025 16:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3FRWhoB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DF7301022;
	Sat, 25 Oct 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408792; cv=none; b=YdB+/ExrUBS/haL1GR4QJG09Y2NC5NTNFWeAEtnJE/VxoEXTGOzQUvY7+7BTHYiWBxqfoD/Ohfzn1uVMpRcVblt9t3xe9o8Qm1pzdwmUwPVTwtM9ftvf6kXY74kAr2iK0/6EZfwjPFk21bxqMq6rHmdC1u2yOp4hVb8NB6TCD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408792; c=relaxed/simple;
	bh=+clk79vRm0NlaSpI08G8uRTSXMz8DMUNriZ+YPMi10g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evAzQTnfLOYstQTTReAutK8eyesbT7wynpzbdNsc0GpC78mkbnh0Owwc5skmWrJ1CWFvfYsCtxUUFV2oY2VazPmlhBfipz5oSk44iArFZ5+y0qXD64OUhnXUkt9kivatHG2ue9rK0AJL7Ue1TCxoNMCcZS3xIsh7Ep5slM+IgBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3FRWhoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B4DC4CEF5;
	Sat, 25 Oct 2025 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408792;
	bh=+clk79vRm0NlaSpI08G8uRTSXMz8DMUNriZ+YPMi10g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3FRWhoB5DTkxYu1NrZSVsVX+1qI/piJC9gxkWMqF7nkHJ4LrpvB19bP93LUtKW64
	 6Oah6wCgQVPHBqTQAjmlULwwoijPGskHuMeyH7n24ip4E/H3EiLpqSMqQRGH2vyPd3
	 9xD9/B5m4Ew+nP1WWIiH3Msozi7MjCJ99pdiyDvaqpnpwWYBjbCvoo0gvlpogl/x5v
	 wm265fuN/CdFhXAoGLDim1HOxSM0BHcyN1APSry2T6+ucyLPsUxryU/J5zaJpHH4oQ
	 2inRD14LO6h98tkJLBMf2jdjJynZpi8dpoLYQQJyPfMPEw6DtXebd28+YAFefaM9NL
	 CLyZtjL8nBEZA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Chunsheng Luo <luochunsheng@ustc.edu>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] fuse: zero initialize inode private data
Date: Sat, 25 Oct 2025 11:55:03 -0400
Message-ID: <20251025160905.3857885-72-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 3ca1b311181072415b6432a169de765ac2034e5a ]

This is slightly tricky, since the VFS uses non-zeroing allocation to
preserve some fields that are left in a consistent state.

Reported-by: Chunsheng Luo <luochunsheng@ustc.edu>
Closes: https://lore.kernel.org/all/20250818083224.229-1-luochunsheng@ustc.edu/
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What changed
  - In `fs/fuse/inode.c:98`, `fuse_alloc_inode()` now zero-initializes
    the entire FUSE-private part of `struct fuse_inode` while explicitly
    preserving the embedded VFS `struct inode`:
    - `fs/fuse/inode.c:106` adds a layout check:
      `BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);`
    - `fs/fuse/inode.c:108` zeroes everything beyond `fi->inode`:
      `memset((void *)fi + sizeof(fi->inode), 0, sizeof(*fi) -
      sizeof(fi->inode));`
  - The manual piecemeal initialization of only a handful of fields
    (e.g., `i_time`, `nodeid`, `nlookup`, `attr_version`, `orig_ino`,
    `state`, `submount_lookup`) is removed and replaced by the blanket
    private-data zeroing.
  - The invariants and locks are still set after zeroing:
    - `fi->inval_mask = ~0;` (`fs/fuse/inode.c:110`)
    - `mutex_init(&fi->mutex);` (`fs/fuse/inode.c:111`)
    - `spin_lock_init(&fi->lock);` (`fs/fuse/inode.c:112`)
    - `fi->forget = fuse_alloc_forget();` (`fs/fuse/inode.c:113`)
    - DAX and passthrough helpers remain unchanged
      (`fs/fuse/inode.c:117`, `fs/fuse/inode.c:120`).

- Why this fixes a real bug
  - Inode objects are allocated via `alloc_inode_sb()`, which is a non-
    zeroing slab allocation (`include/linux/fs.h:3407` →
    `kmem_cache_alloc_lru`). This means previously freed memory content
    can persist in new `struct fuse_inode` instances unless explicitly
    cleared.
  - Before this change, FUSE only zeroed a subset of private fields,
    leaving many newly added or less obvious fields uninitialized/stale,
    which can lead to incorrect behavior. Examples:
    - `fi->cached_i_blkbits` is used by cached getattr to compute
      `stat->blksize` without a server roundtrip (`fs/fuse/dir.c:1373`).
      If not initialized, userspace can observe garbage or stale block
      sizes when using cached attributes.
    - `fi->i_time` controls attribute staleness; it must start from a
      known baseline to force initial refresh (it’s now guaranteed
      zeroed before being set; previously it was explicitly written, but
      other related fields were not).
    - Readdir cache state in `fi->rdc.*` (e.g. `cached`, `pos`, `size`,
      `version`) must start clean, and is explicitly initialized only in
      `fuse_init_dir()` (`fs/fuse/dir.c:2266`). Zeroing ensures no stale
      values leak in the interim.
    - File-io cache accounting (`fi->iocachectr`, waitqueues and lists)
      is initialized in `fuse_init_file_inode()`
      (`fs/fuse/file.c:3121`–`fs/fuse/file.c:3136`); zeroing up front
      prevents spurious non-zero counters or garbage pointers before
      that init runs.
    - Passthrough backing file pointer `fi->fb` (present with
      `CONFIG_FUSE_PASSTHROUGH`) is now guaranteed NULL initially; the
      code also explicitly sets it via `fuse_inode_backing_set(fi,
      NULL)` (`fs/fuse/inode.c:120`). Zeroing avoids any transient stale
      pointer exposure.
  - This change conforms to the VFS model of non-zeroing allocation: it
    deliberately preserves `struct inode` (the part the VFS expects to
    keep stable) and only clears the FUSE-private tail. The
    `BUILD_BUG_ON` enforces the assumption that `inode` is the first
    field.

- Scope and risk
  - The fix is small, localized to a single function in FUSE, and does
    not modify any public interfaces or core VFS behavior.
  - It reduces risk by eliminating uninitialized data usage and
    potential state inconsistencies from inode slab reuse.
  - It is defensive across existing and future FUSE private fields,
    avoiding the need to remember to add manual zeroing for every new
    field.

- Dependencies and backport considerations
  - The code relies on standard kernel primitives: `offsetof`,
    `BUILD_BUG_ON`, and existing FUSE helpers. No architectural changes.
  - `alloc_inode_sb()` non-zeroing semantics are already present in
    stable series (see `include/linux/fs.h:3407`), so the bug exists
    there too.
  - The patch does not depend on other new features; it should apply
    cleanly or be trivial to adapt in stable trees that have the nearby
    code structure.

- User impact
  - Prevents user-visible inconsistencies (e.g., wrong `blksize` values)
    and eliminates potential undefined behavior from stale per-inode
    private state across reuse.
  - Also improves robustness against uninitialized reads that could
    manifest as rare warnings or subtle regressions.

Given it fixes a correctness bug with minimal, contained changes and
clear safety benefits, this commit is a good candidate for backporting
to stable trees.

 fs/fuse/inode.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 7ddfd2b3cc9c4..7c0403a002e75 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -101,14 +101,11 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	if (!fi)
 		return NULL;
 
-	fi->i_time = 0;
+	/* Initialize private data (i.e. everything except fi->inode) */
+	BUILD_BUG_ON(offsetof(struct fuse_inode, inode) != 0);
+	memset((void *) fi + sizeof(fi->inode), 0, sizeof(*fi) - sizeof(fi->inode));
+
 	fi->inval_mask = ~0;
-	fi->nodeid = 0;
-	fi->nlookup = 0;
-	fi->attr_version = 0;
-	fi->orig_ino = 0;
-	fi->state = 0;
-	fi->submount_lookup = NULL;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.51.0


