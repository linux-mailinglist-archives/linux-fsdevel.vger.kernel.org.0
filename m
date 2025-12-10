Return-Path: <linux-fsdevel+bounces-71033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE490CB1D4D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 268AF30F61DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 03:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90DB226CF1;
	Wed, 10 Dec 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZG2fyxO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A7621D3F4;
	Wed, 10 Dec 2025 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338579; cv=none; b=nISWt83qN2Gx3mv5TtNh7KViRSfisDt242wX40ctj7DWSPice2+aOhiKPqv5Ri+3JzQy2J9q6AL5VKJoCCNpVZPULb5g0ouGQxBoE7pjEVO+HWpk+vKbTfxYTpYciRttpB7UUbksR3orQlnC9WloIpSMT/zdxdeWgDyWRhLny7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338579; c=relaxed/simple;
	bh=4u10GokmAsXviKaDqzZ7iDhdmjSN3KW+vW7yoWbPtWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcNjJfdbrTVGmRoP/GFgbmSqvjcMCeD1Nx/AWi4Ke8YlRs+7kfhylKB9hkrCBJcKt9Nll+VfDs+jpwd8nMtAren8vsIbU1SzmQuOQd8Ti4jGUYRpTWc4PVQw1OeibGPTIYHpIZdxV3qSS68BEmhlmfWI71vXMi4YrdwTMv9Pqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZG2fyxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB64C19423;
	Wed, 10 Dec 2025 03:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765338578;
	bh=4u10GokmAsXviKaDqzZ7iDhdmjSN3KW+vW7yoWbPtWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZG2fyxODSGaQXAmiMv1fBrsrY+7QKqriFyY9h/+Ug7n8Zs/SYFCbwrH7LbEyyMOZ
	 E0wS/2kK7Umao5dt1WEYOJg+0YUsyZ0857r6QI5a8KpPrZcSYEmU20dnElrk2HtzQO
	 tMN3QNZmoYHz9CYWiUviSU5uDb7s3FICn/OrrWXYmHX3tazZ4R9ifVqSaBU6Oe5lfq
	 1NeWoqEkbpJmL88vcrJkaXJewsPU69soK66ijMDwjRy0bvlDzIJboruOdL/cPHlSsg
	 2KmwNzAHc8OqsQWuABQp5WkrJCO6+TIppVctD2OHJodlOpgR8dLVKGOHLnRN71ieXo
	 ymn4CX/LD3Gdg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] fuse: Invalidate the page cache after FOPEN_DIRECT_IO write
Date: Tue,  9 Dec 2025 22:48:51 -0500
Message-ID: <20251210034915.2268617-10-sashal@kernel.org>
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

[ Upstream commit b359af8275a982a458e8df6c6beab1415be1f795 ]

generic_file_direct_write() also does this and has a large
comment about.

Reproducer here is xfstest's generic/209, which is exactly to
have competing DIO write and cached IO read.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis Summary

### The Bug

This commit fixes a **data coherency bug** in FUSE when using
`FOPEN_DIRECT_IO`. The problem occurs when:
1. A direct I/O write completes on a FUSE filesystem
2. A concurrent buffered read has populated the page cache with (now
   stale) data
3. Without invalidation, the cached read returns **stale data**

The VFS layer handles this in `generic_file_direct_write()`
(mm/filemap.c:4172-4224) by calling
`kiocb_invalidate_post_direct_write()` after direct writes. The comment
in VFS explicitly mentions this is needed to "invalidate clean pages
which might have been cached by non-direct readahead."

### The Fix

The fix adds the same post-write invalidation pattern to FUSE's
`fuse_direct_io()` function:
- After a successful write (`res > 0 && write && fopen_direct_io`)
- Call `invalidate_inode_pages2_range(mapping, idx_from, idx_to)`
- This ensures stale read-ahead pages are invalidated

**Code size:** +9 lines, single function, single file

### Stable Kernel Criteria Assessment

| Criterion | Assessment |
|-----------|------------|
| Obviously correct | ✅ Yes - follows established VFS pattern |
| Fixes real bug | ✅ Yes - stale data reads (data integrity) |
| Has reproducer | ✅ Yes - xfstest generic/209 |
| Small and contained | ✅ Yes - 9 lines in one function |
| No new features | ✅ Correct - pure bug fix |
| Cc: stable tag | ❌ Not present |
| Fixes: tag | ❌ Not present |

### Dependencies and Backport Concerns

**Critical dependency:** This commit requires commit `80e4f25262f9f`
("fuse: invalidate page cache pages before direct write") which
introduced the `fopen_direct_io` variable and `idx_from`/`idx_to`
calculations. That commit was merged in **v6.6-rc1**.

**Backportable to:**
- stable/linux-6.6.y ✅
- stable/linux-6.11.y ✅
- stable/linux-6.12.y ✅

**NOT backportable to:**
- stable/linux-6.1.y ❌ (missing prerequisite code)
- Earlier LTS kernels ❌

### Risk Assessment

**LOW RISK:**
- Very small change (+9 lines)
- Uses existing, well-tested API (`invalidate_inode_pages2_range`)
- Follows the same pattern as the VFS layer
- Error return from invalidation is silently ignored (same as VFS
  behavior - "if this invalidation fails, tough, the write still
  worked...")
- Only affects FUSE filesystems using `FOPEN_DIRECT_IO` with concurrent
  cached reads

### User Impact

- **Severity:** Medium-High - stale data reads are a data integrity
  issue
- **Affected users:** FUSE filesystem users enabling `FOPEN_DIRECT_IO`
  (including some high-performance storage systems)
- **Reproducer:** Clear, well-known xfstest (generic/209)

### Verdict

Despite lacking explicit stable tags, this is a legitimate data
integrity fix. The bug causes **real user-visible corruption** (stale
data reads), the fix is small and surgical, follows an established VFS
pattern, and has low regression risk. The lack of `Cc: stable` doesn't
disqualify it - many important fixes arrive without explicit tags.

For kernels 6.6+, this should be backported. For earlier kernels, the
prerequisite code doesn't exist, so backporting would require additional
work.

**YES**

 fs/fuse/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index c5c82b3807911..bb4ecfd469a5e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1681,6 +1681,15 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 	if (res > 0)
 		*ppos = pos;
 
+	if (res > 0 && write && fopen_direct_io) {
+		/*
+		 * As in generic_file_direct_write(), invalidate after the
+		 * write, to invalidate read-ahead cache that may have competed
+		 * with the write.
+		 */
+		invalidate_inode_pages2_range(mapping, idx_from, idx_to);
+	}
+
 	return res > 0 ? res : err;
 }
 EXPORT_SYMBOL_GPL(fuse_direct_io);
-- 
2.51.0


