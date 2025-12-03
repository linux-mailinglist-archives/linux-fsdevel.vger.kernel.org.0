Return-Path: <linux-fsdevel+bounces-70596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B25CA18EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17C2B30052F9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 20:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4B313E21;
	Wed,  3 Dec 2025 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoHeMvJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B896312810;
	Wed,  3 Dec 2025 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764793723; cv=none; b=jsgsUAkZQjAVTVMHHzIjSnBdYT2PxiUc5G840QJeXCIkmYUx6AwIScXw0h4hLzqOwqpEs01x7ZuPPrnau4GT2a3GOAZL772ZEjVIy99Qn5VIvnIjz1SZOBch88vrfIFl2s6PEBkdgRgqUl2kjmg3rGr0/JUN/+nt4r0aek40ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764793723; c=relaxed/simple;
	bh=EQjsHMGdKmIGw29kAODr0IsEEyMyRjBoCfAPrhdPGX4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C6ZO/W1ZmVvukmFXyl4yooRnqlqfY3Q6tpyEek6mHd1jhUvwU2U26VbUeCVfOLrPczVm6dgJwmK6Sca/krckubN9MnQQ9WgVilHDIwkwbnl9nWcla2OOkdO6eJV+e1ckbGgs8RJeKoGT5RG9kEm2eaagN0wLS0Ix2y78TqpaXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoHeMvJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3ECC4CEFB;
	Wed,  3 Dec 2025 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764793723;
	bh=EQjsHMGdKmIGw29kAODr0IsEEyMyRjBoCfAPrhdPGX4=;
	h=From:To:Cc:Subject:Date:From;
	b=BoHeMvJ7GGbYld7icBuGMMrOQnl/FWElLBXfK9Z15B1o4sS8yYAoSQJ8rOL5rNDKv
	 /ju+nMIgTnoF4+0Uadd4nraeFedjIA1Mei73PA8DL43arg3/ZQwTefCaf4Ja43MrE/
	 v5ZcIV7bjnxC0jik9nmYXl0YJasD/vTNTTBiJLhHIOJHpv4K7KJ0pbJCEbvMPyN8ck
	 Up3o8rdSaYMITC+CWHbMKwks7z72DLe1eYoWBbM2kE8r0+yXHSD1CILYR3g7uOYdYn
	 gVv2zOtXQ51mYl4g+E29Fulq/HHle41uXwqu7giFy7svSOkJVAElaWZyyQnpTgcd+u
	 t2uSuM0e7aSHg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Joanne Koong <joannelkoong@gmail.com>,
	syzbot@syzkaller.appspotmail.com,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-6.6] iomap: adjust read range correctly for non-block-aligned positions
Date: Wed,  3 Dec 2025 15:28:38 -0500
Message-ID: <20251203202839.819850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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

From: Joanne Koong <joannelkoong@gmail.com>

[ Upstream commit 7aa6bc3e8766990824f66ca76c19596ce10daf3e ]

iomap_adjust_read_range() assumes that the position and length passed in
are block-aligned. This is not always the case however, as shown in the
syzbot generated case for erofs. This causes too many bytes to be
skipped for uptodate blocks, which results in returning the incorrect
position and length to read in. If all the blocks are uptodate, this
underflows length and returns a position beyond the folio.

Fix the calculation to also take into account the block offset when
calculating how many bytes can be skipped for uptodate blocks.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have all the information needed for a comprehensive analysis. Let
me compile my findings.

---

## COMPREHENSIVE ANALYSIS: iomap_adjust_read_range() Bug Fix

### 1. COMMIT MESSAGE ANALYSIS

**Subject:** `iomap: adjust read range correctly for non-block-aligned
positions`

**Key Points from Message:**
- The function `iomap_adjust_read_range()` **assumes block-aligned
  positions**, but this assumption is violated
- Bug was discovered via **syzbot testing with erofs** filesystem
- Causes "too many bytes to be skipped for uptodate blocks"
- Results in **incorrect position and length to read**
- If all blocks are uptodate: **underflows length** and **returns
  position beyond the folio**

**Tags Analysis:**
- ✅ `Tested-by: syzbot@syzkaller.appspotmail.com` - Automated testing
  confirmed
- ✅ `Reviewed-by: Brian Foster <bfoster@redhat.com>` - Red Hat
  filesystem expert
- ✅ `Reviewed-by: Christoph Hellwig <hch@lst.de>` - Major iomap author
- ✅ `Signed-off-by: Christian Brauner <brauner@kernel.org>` - VFS
  maintainer
- ❌ **No `Cc: stable@vger.kernel.org`** tag
- ❌ **No `Fixes:` tag** pointing to original buggy commit

### 2. CODE CHANGE ANALYSIS

**Bug Location:** `fs/iomap/buffered-io.c`, function
`iomap_adjust_read_range()`

**The Buggy Code (lines 246-253 before fix):**
```c
for (i = first; i <= last; i++) {
    if (!ifs_block_is_uptodate(ifs, i))
        break;
    *pos += block_size;      // Bug: assumes pos is block-aligned
    poff += block_size;
    plen -= block_size;
    first++;
}
```

**Technical Root Cause:**
When `*pos` has a sub-block offset (e.g., `pos = 512` in a 1024-byte
block):
- `first = poff >> block_bits` computes the block index correctly (block
  0)
- But the loop skips a full `block_size` per block, ignoring the offset

**Example demonstrating the bug:**
- Block size: 1024 bytes
- Position: 512 (half-way into block 0)
- Block 0 is uptodate

**Old buggy calculation:**
- Skip full 1024 bytes → `pos = 1536`, overshoots by 512 bytes
- `plen -= 1024` → underflows if `plen < 1024`

**Fixed calculation:**
```c
blocks_skipped = i - first;
if (blocks_skipped) {
    unsigned long block_offset = *pos & (block_size - 1);  // = 512
    unsigned bytes_skipped =
        (blocks_skipped << block_bits) - block_offset;      // = 1024 -
512 = 512
    *pos += bytes_skipped;   // Correct: pos = 1024
    poff += bytes_skipped;
    plen -= bytes_skipped;
}
```

**Consequences of the Bug:**
1. **Integer underflow**: `plen` becomes huge (wraps around as unsigned)
2. **Position beyond folio**: `*pos` can point past the folio boundary
3. **Incorrect read ranges**: Wrong data read, potential corruption
4. **Potential crashes**: Invalid memory access from bad ranges

### 3. CLASSIFICATION

- **Type:** BUG FIX (arithmetic/logic error causing incorrect
  calculations)
- **NOT:** Feature addition, cleanup, or optimization
- **Severity:** HIGH - affects filesystem data integrity
- **Scope:** Core iomap buffered I/O infrastructure

### 4. SCOPE AND RISK ASSESSMENT

**Change Size:**
- 13 insertions, 6 deletions
- Single file: `fs/iomap/buffered-io.c`
- Localized to one function

**Risk Level:** LOW
- Fix is mathematically straightforward
- Does not change control flow significantly
- Well-reviewed by iomap experts
- Tested by syzbot

**Affected Subsystem:** `fs/iomap/` - mature, widely-used infrastructure

**Affected Filesystems:** Multiple major filesystems use iomap:
- **XFS** - Primary enterprise Linux filesystem
- **GFS2** - Cluster filesystem
- **erofs** - Read-only filesystem (Android)
- **zonefs** - Zoned storage filesystem
- **fuse** - User-space filesystems

### 5. USER IMPACT

**Who is affected?**
- ALL users of XFS, GFS2, erofs, zonefs, and fuse filesystems
- Particularly affects systems with:
  - Block sizes smaller than page size
  - Partial folio reads/writes at non-block-aligned offsets

**How severe?**
- Can cause **incorrect data reads**
- Potential **data corruption** in read paths
- Possible **kernel crashes** from invalid memory access
- **Data integrity** issues for critical filesystems

**Triggered by:** syzbot (automated fuzzing) - confirms this is a real
triggerable bug

### 6. STABILITY INDICATORS

- ✅ `Tested-by: syzbot` - Confirmed fix works
- ✅ Two expert reviewers (Brian Foster, Christoph Hellwig)
- ✅ Merged by VFS maintainer (Christian Brauner)
- ⚠️ Relatively new commit (September 2025)

### 7. DEPENDENCY CHECK

**Bug Origin:** Commit `9dc55f1389f95` ("iomap: add support for sub-
pagesize buffered I/O without buffer heads") from **v4.19-rc1** (2018)

**Dependencies for backport:**
- The fix is self-contained
- May need minor adaptation for older kernels:
  - v5.x: Uses `struct iomap_page` and pages (not folios)
  - v6.x: Uses `struct iomap_folio_state` and folios
- Core logic remains the same across versions

**Related commits:**
- `8e3c15ee0d292` - Minor loop syntax change (`for` → `while`), NOT a
  dependency
- `9d875e0eef8ec` - Related fix for unaligned END offsets (separate
  issue)

### 8. HISTORICAL CONTEXT

The bug has existed for **~6 years** (since v4.19). It was latent
because:
- Most callers pass block-aligned positions
- erofs triggered an edge case with non-aligned positions
- syzbot's extensive testing exposed it

The original code assumed callers would always pass block-aligned
positions, which is a reasonable assumption violated in specific edge
cases.

---

## BACKPORT RECOMMENDATION

### Arguments FOR backporting:

1. **Fixes a real bug** discovered by automated testing (syzbot)
2. **Affects critical filesystems** (XFS, GFS2) used in production
3. **Small, surgical fix** - 13 lines added, 6 removed
4. **Low regression risk** - mathematically correct fix
5. **Expert-reviewed** by iomap maintainers
6. **Bug existed since v4.19** - all stable trees are affected
7. **Can cause data integrity issues** - serious for a filesystem bug

### Arguments AGAINST backporting:

1. **No `Cc: stable` tag** - maintainers didn't explicitly request
   backport
2. **No `Fixes:` tag** - doesn't identify the buggy commit
3. **Relatively new commit** - hasn't had extensive mainline testing yet
4. **Needs adaptation** for older kernels (page vs folio APIs)

### Conclusion:

Despite the missing stable tags, this commit should be backported
because:
- It fixes a **real, triggerable bug** found by syzbot
- The bug can cause **incorrect data reads and potential corruption**
- It affects **major filesystems** (XFS, GFS2) used in production
  environments
- The fix is **small, contained, and well-reviewed**
- The **risk of NOT fixing** (data corruption) outweighs the risk of the
  fix (minimal)

The absence of `Cc: stable` may be an oversight, as this clearly meets
stable criteria.

**YES**

 fs/iomap/buffered-io.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8b847a1e27f13..1c95a0a7b302d 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -240,17 +240,24 @@ static void iomap_adjust_read_range(struct inode *inode, struct folio *folio,
 	 * to avoid reading in already uptodate ranges.
 	 */
 	if (ifs) {
-		unsigned int i;
+		unsigned int i, blocks_skipped;
 
 		/* move forward for each leading block marked uptodate */
-		for (i = first; i <= last; i++) {
+		for (i = first; i <= last; i++)
 			if (!ifs_block_is_uptodate(ifs, i))
 				break;
-			*pos += block_size;
-			poff += block_size;
-			plen -= block_size;
-			first++;
+
+		blocks_skipped = i - first;
+		if (blocks_skipped) {
+			unsigned long block_offset = *pos & (block_size - 1);
+			unsigned bytes_skipped =
+				(blocks_skipped << block_bits) - block_offset;
+
+			*pos += bytes_skipped;
+			poff += bytes_skipped;
+			plen -= bytes_skipped;
 		}
+		first = i;
 
 		/* truncate len if we find any trailing uptodate block(s) */
 		while (++i <= last) {
-- 
2.51.0


