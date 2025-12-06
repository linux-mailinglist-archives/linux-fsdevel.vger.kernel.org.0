Return-Path: <linux-fsdevel+bounces-70940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE990CAA7BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9ACC2300EDE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795462566D3;
	Sat,  6 Dec 2025 14:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q7++xVIU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29031F30A9;
	Sat,  6 Dec 2025 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029805; cv=none; b=WOjbMzT1fQrkz7gqIh5vxRrW0DGUUevTbRSiSzVGsBMeBpdoTMUnkJRjy8P6DHj2JMszny8nCz5Dl/U0aDCFDqrUG6lf7PhIEldDB0ALjE4lKxvi1/mfC2KMjJOiSWX6FTREp4fwevVybu9Zp9meqsi1pNjsl1Rtw71NOiI8h/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029805; c=relaxed/simple;
	bh=Lelg716SCuCBRQsIrBzYR0/pjER/M5f4vAd3JX5ZAFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0tuWrnF2DwBMxkCoW3tOxPAOlLVOX+OT3WHgMZ8uz+rEMX7xPIOhwJ3e3rwAKuVnzCYi7/JsobF/vyWFQ4aolnHbfPrwjbp456Ig5qlrge5CG9qWGlw7Tbi6jB1qUY+NzRcPEvRCcWOAkfmMhFwoPKcptbhTenOznIOogjoJZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q7++xVIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0EE9C113D0;
	Sat,  6 Dec 2025 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029805;
	bh=Lelg716SCuCBRQsIrBzYR0/pjER/M5f4vAd3JX5ZAFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q7++xVIUfvzo63s2fpIcGn6cfaqfR019TIeCVTS0qY8mi6Rgo+duyjx5xrlHuhzpJ
	 BYBVHOVRrSkaE4i+PtRp9aCGA/i+GRfVE8o9ss3ZtopXWHjZ1c9YfJwcWU/mQVMz7Y
	 eSFzdf/ho+0Us5Eywx90mwvYPFkVXL/89TsbFg9QdX6F2iwTzmH2Fzk6uMPPj8aheQ
	 ZKvtpQXNmPEZQGep6CoPTH84tRug4jLxW1aa3lB92MqDtUHdws5vVivvQc4vE+XMZs
	 kyBWhuPps5shcFwHcLQ8aClmeQJZy/5Q3MUA93dOWJXazKHwo6kpf2f55ESyoNn/So
	 brEkmh6RK2mdA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] hfsplus: Verify inode mode when loading from disk
Date: Sat,  6 Dec 2025 09:02:19 -0500
Message-ID: <20251206140252.645973-14-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251206140252.645973-1-sashal@kernel.org>
References: <20251206140252.645973-1-sashal@kernel.org>
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

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 005d4b0d33f6b4a23d382b7930f7a96b95b01f39 ]

syzbot is reporting that S_IFMT bits of inode->i_mode can become bogus when
the S_IFMT bits of the 16bits "mode" field loaded from disk are corrupted.

According to [1], the permissions field was treated as reserved in Mac OS
8 and 9. According to [2], the reserved field was explicitly initialized
with 0, and that field must remain 0 as long as reserved. Therefore, when
the "mode" field is not 0 (i.e. no longer reserved), the file must be
S_IFDIR if dir == 1, and the file must be one of S_IFREG/S_IFLNK/S_IFCHR/
S_IFBLK/S_IFIFO/S_IFSOCK if dir == 0.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Link: https://developer.apple.com/library/archive/technotes/tn/tn1150.html#HFSPlusPermissions [1]
Link: https://developer.apple.com/library/archive/technotes/tn/tn1150.html#ReservedAndPadFields [2]
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/04ded9f9-73fb-496c-bfa5-89c4f5d1d7bb@I-love.SAKURA.ne.jp
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis of hfsplus: Verify inode mode when loading from disk

### 1. COMMIT MESSAGE ANALYSIS

**Key indicators:**
- **Reported-by: syzbot** - This is a real bug found by automated
  fuzzing
- **Closes:** link to syzkaller bug report confirms this is a genuine
  issue
- **Reviewed-by:** present from the HFS+ maintainer (Viacheslav Dubeyko)
- **No "Cc: stable@vger.kernel.org"** tag
- **No "Fixes:" tag** - bug appears to exist since original HFS+
  implementation

The commit describes that corrupted S_IFMT bits in the on-disk "mode"
field can cause inode->i_mode to become bogus when loaded from disk. The
commit message references Apple technical documentation explaining the
expected values for the mode field.

### 2. CODE CHANGE ANALYSIS

The fix modifies `hfsplus_get_perms()` in two ways:

**a) Adds validation logic (the core fix):**
```c
if (dir) {
    if (mode && !S_ISDIR(mode))
        goto bad_type;
} else if (mode) {
    switch (mode & S_IFMT) {
    case S_IFREG:
    case S_IFLNK:
    case S_IFCHR:
    case S_IFBLK:
    case S_IFIFO:
    case S_IFSOCK:
        break;
    default:
        goto bad_type;
    }
}
```
This validates that:
- For directories (`dir=1`): mode must be 0 or actually be a directory
  type
- For files (`dir=0`): mode must be 0 or one of the valid file types
  (regular, symlink, char/block device, FIFO, socket)

**b) Changes return type from `void` to `int`:**
- Returns -EIO on invalid mode with an error message
- Callers (`hfsplus_cat_read_inode`) now check the return value and
  propagate errors

**Root cause:** The original code blindly trusted the mode field from
disk without validating that the S_IFMT bits are consistent with the
directory flag.

### 3. CLASSIFICATION

- **Type:** Bug fix (input validation)
- **Security relevance:** Yes - crafted filesystem images could trigger
  this
- **Category:** Filesystem robustness/hardening against corrupted data

### 4. SCOPE AND RISK ASSESSMENT

| Aspect | Assessment |
|--------|------------|
| Lines changed | ~30+ additions, moderate size |
| Files touched | 1 file (fs/hfsplus/inode.c) |
| Complexity | Low - straightforward validation logic |
| Regression risk | **LOW** - only rejects clearly invalid data |

The validation is conservative and follows Apple's official HFS+
specification. It only rejects modes that are definitively wrong.

### 5. USER IMPACT

- **Affected users:** Those mounting HFS+ filesystems (macOS external
  drives, dual-boot setups)
- **Trigger:** Mounting a corrupted or maliciously crafted HFS+
  filesystem image
- **Impact of bug:** Bogus inode mode can lead to undefined kernel
  behavior when processing the inode
- **Impact of fix:** Graceful rejection with -EIO instead of corrupted
  internal state

### 6. STABILITY INDICATORS

- Reviewed by subsystem maintainer ✓
- Clean, standalone fix with no dependencies ✓
- The modified functions exist in older stable kernels ✓
- No unusual code patterns or risky constructs ✓

### 7. DEPENDENCY CHECK

This is a standalone fix. The `hfsplus_get_perms` and
`hfsplus_cat_read_inode` functions exist in all stable trees where HFS+
is supported.

---

## Summary

**What it fixes:** Prevents corrupted or maliciously crafted HFS+
filesystem images from causing bogus inode modes to be loaded into the
kernel.

**Why it matters for stable:** This is a defensive fix that prevents
accepting corrupted data, which could lead to undefined behavior. syzbot
found this bug, indicating it can be triggered by crafted input - a
potential security concern.

**Meets stable criteria:**
- ✓ Obviously correct (validates according to Apple's HFS+
  specification)
- ✓ Fixes a real bug that affects users (syzbot found it with crafted
  images)
- ✓ Small and contained (single file, ~30 lines of validation)
- ✓ Low regression risk (only rejects clearly invalid data)
- ✗ No explicit stable tag (author didn't request it)

**Risk vs Benefit:**
- **Risk:** Very low - adds validation that only rejects invalid data
- **Benefit:** Prevents kernel from operating on corrupted inode modes
  from crafted/corrupted filesystems

The lack of explicit stable tags suggests the author may not have
intended this for stable, but the fix clearly meets stable criteria as a
filesystem robustness fix against corrupted input. Filesystem fixes for
handling crafted/corrupted data are generally appropriate for stable
trees.

**YES**

 fs/hfsplus/inode.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index b51a411ecd237..e290e417ed3a7 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -180,13 +180,29 @@ const struct dentry_operations hfsplus_dentry_operations = {
 	.d_compare    = hfsplus_compare_dentry,
 };
 
-static void hfsplus_get_perms(struct inode *inode,
-		struct hfsplus_perm *perms, int dir)
+static int hfsplus_get_perms(struct inode *inode,
+			     struct hfsplus_perm *perms, int dir)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	u16 mode;
 
 	mode = be16_to_cpu(perms->mode);
+	if (dir) {
+		if (mode && !S_ISDIR(mode))
+			goto bad_type;
+	} else if (mode) {
+		switch (mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFLNK:
+		case S_IFCHR:
+		case S_IFBLK:
+		case S_IFIFO:
+		case S_IFSOCK:
+			break;
+		default:
+			goto bad_type;
+		}
+	}
 
 	i_uid_write(inode, be32_to_cpu(perms->owner));
 	if ((test_bit(HFSPLUS_SB_UID, &sbi->flags)) || (!i_uid_read(inode) && !mode))
@@ -212,6 +228,10 @@ static void hfsplus_get_perms(struct inode *inode,
 		inode->i_flags |= S_APPEND;
 	else
 		inode->i_flags &= ~S_APPEND;
+	return 0;
+bad_type:
+	pr_err("invalid file type 0%04o for inode %lu\n", mode, inode->i_ino);
+	return -EIO;
 }
 
 static int hfsplus_file_open(struct inode *inode, struct file *file)
@@ -516,7 +536,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 		}
 		hfs_bnode_read(fd->bnode, &entry, fd->entryoffset,
 					sizeof(struct hfsplus_cat_folder));
-		hfsplus_get_perms(inode, &folder->permissions, 1);
+		res = hfsplus_get_perms(inode, &folder->permissions, 1);
+		if (res)
+			goto out;
 		set_nlink(inode, 1);
 		inode->i_size = 2 + be32_to_cpu(folder->valence);
 		inode_set_atime_to_ts(inode, hfsp_mt2ut(folder->access_date));
@@ -545,7 +567,9 @@ int hfsplus_cat_read_inode(struct inode *inode, struct hfs_find_data *fd)
 
 		hfsplus_inode_read_fork(inode, HFSPLUS_IS_RSRC(inode) ?
 					&file->rsrc_fork : &file->data_fork);
-		hfsplus_get_perms(inode, &file->permissions, 0);
+		res = hfsplus_get_perms(inode, &file->permissions, 0);
+		if (res)
+			goto out;
 		set_nlink(inode, 1);
 		if (S_ISREG(inode->i_mode)) {
 			if (file->permissions.dev)
-- 
2.51.0


