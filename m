Return-Path: <linux-fsdevel+bounces-71032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5687CB1D32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68B8C308A382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 03:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522BE30F533;
	Wed, 10 Dec 2025 03:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBthoe7L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB372618;
	Wed, 10 Dec 2025 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338569; cv=none; b=nJFQgD7PPeDEgmM289pDkousDUaE4Cd0UevUR6TJjOgwnG/DAhcNqJW9eNejQ0rcJhUN2r5JMVN8Re7BOCzZeHtvEL2vqA0OB3d/niI+8OS4CexG/12+Aam64vmkplGPI8d8sLZKAHnXFoMtMaWu3w3LmMok5w6wNJALMcLzWpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338569; c=relaxed/simple;
	bh=FpaJnbQklqI3YBJxr2vDUXzx9Wo/xx4nLvXABCDXie8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lnDbTi5MREGZhOLI7YshY2EKs2iXCYcMKt0fFTadR2r4+bYPeu36aJ2lJEtBwAd4Iy6YcnSNyDUJaqZTzz/eXfGTkX09VWQbVU6lw/rHxZWo4MFbJ/tqsKRv2L1yFXs41gCMdpAfTwJph7GMxuW2xz8dksOi1h2Hl9EWZ04uoS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBthoe7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE41C16AAE;
	Wed, 10 Dec 2025 03:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765338569;
	bh=FpaJnbQklqI3YBJxr2vDUXzx9Wo/xx4nLvXABCDXie8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBthoe7L+RpvrbSXJUNqZKoBbdvIiZdn1nHUG7ZGtn7cr1LD93JszCuBZUa8KjK0y
	 HX5cd0Tebsqcw78UrbxL/QfjFZhME3wa+rwCauxC11mB/2hxyDHAeNQoBIgKOHqerK
	 1MQab8X4R7gvVLnhfl+pBVSbgsCC45Mlt760H5mcTeXmfPVvoWszYAG3jm3PVr4X0Z
	 Y1i24lyNBSxckLBNaYeio+TXAg8ncUt6UhLM03irEfUS9sq8tNC4mSxH9cW2NPSeJw
	 NxAsvIuboqKmOtr9u5sEwGLiKJa+XERcqdVLdhHM9z/07JJWXR2CRYxr+yVl/Heb4L
	 kxnqA01eVKAQw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.12] exfat: zero out post-EOF page cache on file extension
Date: Tue,  9 Dec 2025 22:48:47 -0500
Message-ID: <20251210034915.2268617-6-sashal@kernel.org>
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

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 4e163c39dd4e70fcdce948b8774d96e0482b4a11 ]

xfstests generic/363 was failing due to unzeroed post-EOF page
cache that allowed mmap writes beyond EOF to become visible
after file extension.

For example, in following xfs_io sequence, 0x22 should not be
written to the file but would become visible after the extension:

  xfs_io -f -t -c "pwrite -S 0x11 0 8" \
    -c "mmap 0 4096" \
    -c "mwrite -S 0x22 32 32" \
    -c "munmap" \
    -c "pwrite -S 0x33 512 32" \
    $testfile

This violates the expected behavior where writes beyond EOF via
mmap should not persist after the file is extended. Instead, the
extended region should contain zeros.

Fix this by using truncate_pagecache() to truncate the page cache
after the current EOF when extending the file.

Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: exfat: zero out post-EOF page cache on file
extension

### 1. COMMIT MESSAGE ANALYSIS

**Problem Description**:
- xfstests generic/363 failing due to unzeroed post-EOF page cache
- mmap writes beyond EOF become visible after file extension
- This violates expected POSIX behavior where extended regions should
  contain zeros

**Keywords**: "failing", "fix" - indicates this fixes a real bug

**Tags**:
- No `Cc: stable@vger.kernel.org` tag
- No `Fixes:` tag
- Signed-off-by from exfat maintainer (Namjae Jeon)

### 2. CODE CHANGE ANALYSIS

The fix adds `truncate_pagecache()` calls in two locations:

**Change 1 - `exfat_cont_expand()` (~line 30)**:
```c
+       truncate_pagecache(inode, i_size_read(inode));
```
This truncates page cache to current EOF when expanding a file,
invalidating any stale data that may have been written beyond EOF via
mmap.

**Change 2 - `exfat_file_write_iter()` (~line 645)**:
```c
+       if (pos > i_size_read(inode))
+               truncate_pagecache(inode, i_size_read(inode));
```
This truncates page cache before writes that extend the file, with a
conditional check to only run when write position exceeds current file
size.

**Technical mechanism of the bug**:
- User mmaps a file and writes beyond EOF into page cache
- These writes don't persist (they're beyond EOF)
- Later, when the file is extended, the stale page cache with those
  beyond-EOF writes becomes part of the valid file content
- Result: data that should never have persisted becomes visible

**Why the fix works**: `truncate_pagecache()` invalidates all page cache
beyond the specified position, ensuring any stale post-EOF data is
discarded before extending the file.

### 3. CLASSIFICATION

- **Type**: Bug fix for **data integrity issue**
- **Category**: Filesystem semantics violation
- **Not an exception case**: Not a device ID, quirk, DT update, or build
  fix

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed**: +3 lines (very small)
- **Files touched**: 1 file (fs/exfat/file.c)
- **Complexity**: Low - uses standard kernel APIs
- **Subsystem maturity**: exfat is relatively mature (in mainline since
  5.7)
- **Regression risk**: LOW - `truncate_pagecache()` is a well-tested
  standard API used by many filesystems for this exact purpose

### 5. USER IMPACT

- **Who is affected**: Users of exfat filesystem (common on SD cards,
  USB drives, camera media)
- **Severity**: Moderate to high - data integrity violation
- **Reproducibility**: Reproducible via xfstests generic/363, specific
  mmap usage patterns
- **Real-world impact**: Could cause unexpected data appearing in files,
  data corruption scenarios

### 6. STABILITY INDICATORS

- **Tested**: Yes - via xfstests generic/363 (standard filesystem test
  suite)
- **Reviewed**: Has maintainer sign-off (Namjae Jeon)
- **Pattern**: Fix follows the same approach used by other mature
  filesystems (ext4, xfs, etc.) for handling post-EOF page cache

### 7. DEPENDENCY CHECK

- Uses only existing kernel APIs (`truncate_pagecache()`,
  `i_size_read()`)
- No dependencies on other commits
- Functions being modified (`exfat_cont_expand`,
  `exfat_file_write_iter`) exist in stable kernels

---

## Summary

**What problem does this solve?**
Data integrity bug where mmap writes beyond EOF incorrectly persist
after file extension, violating filesystem semantics.

**Does it meet stable kernel rules?**
- ✅ Obviously correct - uses standard pattern from other filesystems
- ✅ Fixes real bug - detected by xfstests, affects real users
- ✅ Important issue - data integrity is critical for filesystems
- ✅ Small and contained - 3 lines, 1 file
- ✅ No new features - pure bug fix
- ✅ Should apply cleanly - no dependencies

**Risk vs Benefit:**
- **Risk**: Very low - small change using well-tested APIs
- **Benefit**: Fixes data integrity issue on widely-used filesystem
  (exfat used on removable media)

**Concerns:**
- No explicit `Cc: stable` tag, but maintainer may not have considered
  it necessary
- No `Fixes:` tag, so unclear when bug was introduced (likely present
  since exfat's initial inclusion)

This is a clear-cut data integrity bug fix with minimal risk. The fix is
small, surgical, uses standard kernel APIs, and follows the same pattern
used by mature filesystems like ext4 and xfs. Data integrity issues in
filesystems should be fixed in stable trees to protect users from silent
data corruption.

**YES**

 fs/exfat/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index adc37b4d7fc2d..536c8078f0c19 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -25,6 +25,8 @@ static int exfat_cont_expand(struct inode *inode, loff_t size)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	struct exfat_chain clu;
 
+	truncate_pagecache(inode, i_size_read(inode));
+
 	ret = inode_newsize_ok(inode, size);
 	if (ret)
 		return ret;
@@ -639,6 +641,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 	inode_lock(inode);
 
+	if (pos > i_size_read(inode))
+		truncate_pagecache(inode, i_size_read(inode));
+
 	valid_size = ei->valid_size;
 
 	ret = generic_write_checks(iocb, iter);
-- 
2.51.0


