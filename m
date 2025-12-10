Return-Path: <linux-fsdevel+bounces-71034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E74B2CB1D62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C45263102946
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 03:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AB130F554;
	Wed, 10 Dec 2025 03:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luC57BGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281030E84B;
	Wed, 10 Dec 2025 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338593; cv=none; b=X6ijVZW161RvLMUNtsPly9S2i4OfRQvnUGrUwVktvza2yp5+WEGP+q7AWfD0+VcTbaaEvIX0OsRJ2c3xxSYIf8MkvwQeJzaaZQubMnnorKAHyACGCtC/juL+6zocOdQl5y+Mmx0NLpFxBIUv/cduiRgl6R36l/APPYUXQDnNh9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338593; c=relaxed/simple;
	bh=S2b/0V83PcUCe+l4IeH8xwKHovi3aSC1bPqe/UxbLl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UL2IIoyrv5IA7o2hST8cA6TyBqNtR0Jrg8Tc3kCGaVRe6KtsJoUGXfSXhzeUxYO48XrN/xIdOEJWIkUB5U5jgXyYrTfwtZwhEw0LouUMGk5k2CscTCZ3ixe2Y4+JFaNVBMWVLD1EvyjIiveU48NSIgzakiqfUSwH7+pTJclXwRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luC57BGx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09103C16AAE;
	Wed, 10 Dec 2025 03:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765338593;
	bh=S2b/0V83PcUCe+l4IeH8xwKHovi3aSC1bPqe/UxbLl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luC57BGxQlWAo03uFLwG3jb4IOF4x0oKKRuXSY65Mvtp2P+GU0j18GDZZHhzU3rWP
	 x7ihwRsuWryDmbnJ7Hqsg0xFoTkj7UIp49EstvkZneasRN8Bw0YprjaKQrn2fYwV0w
	 QtFBw4VOiVaocOTjlXZni6o5L+4o1jk/G/hYkffDhsHnzSRzfFqfgATsVMiaEEfdfC
	 At/VqG5URklD6sX/hR3CV+0QXam317jBWXIk2kqKysTuwxe1Qkkf4ch9irsYbjzQdV
	 QWYN3qNJF9YxTq/B0I8fIMaFPk2ppG6PbY2UJXzb1J0tNKhzqm80WAT/dqy6L9bbLY
	 neIimzYkUKTHw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] fuse: Always flush the page cache before FOPEN_DIRECT_IO write
Date: Tue,  9 Dec 2025 22:48:57 -0500
Message-ID: <20251210034915.2268617-16-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210034915.2268617-1-sashal@kernel.org>
References: <20251210034915.2268617-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bernd Schubert <bschubert@ddn.com>

[ Upstream commit 1ce120dcefc056ce8af2486cebbb77a458aad4c3 ]

This was done as condition on direct_io_allow_mmap, but I believe
this is not right, as a file might be open two times - once with
write-back enabled another time with FOPEN_DIRECT_IO.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis Summary

### 1. WHAT THE COMMIT FIXES

This commit addresses a **data coherency bug** in FUSE when a file can
be opened twice with different modes:
- **File descriptor A**: opened normally with page cache (write-back
  caching enabled)
- **File descriptor B**: opened with `FOPEN_DIRECT_IO` flag

**The Bug:**
The original code only flushed dirty pages before direct I/O when
`fc->direct_io_allow_mmap` was enabled. However, dirty pages can exist
regardless of this flag - they can come from a write-back cached file
handle to the same file.

**Data corruption scenario:**
1. Write data via normal cached file handle → creates dirty pages in
   page cache
2. Write to same location via FOPEN_DIRECT_IO handle → goes directly to
   backend storage
3. Later, dirty pages from step 1 flush to disk → **OVERWRITE** the
   direct IO data

This causes **data loss/corruption** where writes via direct I/O are
silently overwritten.

### 2. CODE CHANGE ANALYSIS

The change is minimal:
```c
- if (fopen_direct_io && fc->direct_io_allow_mmap) {
+       if (fopen_direct_io) {
```

Simply removes the `&& fc->direct_io_allow_mmap` condition, making the
`filemap_write_and_wait_range()` call happen for **all**
`FOPEN_DIRECT_IO` operations, not just when `direct_io_allow_mmap` is
enabled.

### 3. STABLE CRITERIA CHECK

| Criterion | Assessment |
|-----------|------------|
| Obviously correct | ✅ The fix is logically sound - always flush dirty
pages before direct IO |
| Fixes real bug | ✅ Data corruption/loss in specific multi-fd scenarios
|
| Important issue | ✅ Data corruption is severe |
| Small and contained | ✅ Single condition removal, one file |
| No new features | ✅ Pure correctness fix |
| Clean application | ✅ Should apply cleanly |

### 4. RISK ASSESSMENT

**Risk: LOW**
- The change is **conservative** - it flushes *more* often, not less
- Worst case: slight performance regression from additional sync
  operations
- Best case: prevents data corruption in mixed cached/direct IO
  scenarios
- The affected code path (`fuse_direct_io`) is well-established

### 5. BACKPORT CONCERNS

**Negative signals:**
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag pointing to `b5a2a3a0b7766` (which introduced the
  incomplete logic)

**Positive signals:**
- Small, surgical fix
- Fixes data corruption (high severity)
- Maintainer-reviewed (signed off by Miklos Szeredi, FUSE maintainer)
- Safe direction of change

### 6. VERSION APPLICABILITY

The original buggy commit (`b5a2a3a0b7766`) was merged in v6.10, so this
fix applies to:
- v6.10.y through current stable trees

### 7. USER IMPACT

Affects FUSE users who:
- Use FOPEN_DIRECT_IO feature
- Have the same file opened through multiple file descriptors with
  different caching modes
- This is not a theoretical scenario - FUSE servers like libfuse can
  legitimately have files accessed this way

### CONCLUSION

Despite the absence of explicit `Cc: stable` tags, this commit **should
be backported**. It fixes a real data corruption bug with a minimal,
obviously correct change. The fix is safe (more synchronization, not
less), small, and addresses a serious issue. The lack of stable tags
appears to be an oversight rather than an indication the fix isn't
needed in stable. Data corruption bugs in filesystems are exactly the
type of issue stable trees exist to fix.

**YES**

 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05b..c5c82b3807911 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1607,7 +1607,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (!ia)
 		return -ENOMEM;
 
-	if (fopen_direct_io && fc->direct_io_allow_mmap) {
+	if (fopen_direct_io) {
 		res = filemap_write_and_wait_range(mapping, pos, pos + count - 1);
 		if (res) {
 			fuse_io_free(ia);
-- 
2.51.0


