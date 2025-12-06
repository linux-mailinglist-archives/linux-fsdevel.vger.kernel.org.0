Return-Path: <linux-fsdevel+bounces-70944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41648CAA819
	for <lists+linux-fsdevel@lfdr.de>; Sat, 06 Dec 2025 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85CC63274F2B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Dec 2025 14:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDC82FDC56;
	Sat,  6 Dec 2025 14:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgbf0HqB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56BD1A5B8A;
	Sat,  6 Dec 2025 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765029822; cv=none; b=YhJ8A7yc6qaKR3u/iafm6Xp4ANYh3RriAKeNA2DaALDTvmUgJgA4iCg3Bd1tDG1FL7/0YfwOvleedHSBRezAGEcUYC9zuhptgvHG/dsSQyiHeNiq4LQnOWI6jfNe2Eb49jzN22OL++HDueUntag3T8RhiJVAjGXQa/z3I6zp8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765029822; c=relaxed/simple;
	bh=Tz8gkfZfbuDdQFaxz8Xaau2EfIYA4RF5sGA4a+5kLvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGzPn92SwUbqD7J+j2IoDN/8HTuJdsfpN69tBKxZldlgIMlhyhOQ9d2mL2uvXmy+vJzNkMYE6zq4ZBXMaXgsoO2m30cruNSwcbYA1A/bkKM4MTfLwYO2zZze/KWG+Vdwe+gQeC7lLvedLWa0+fsgAI72+++2El0ejG0WfKvhp6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgbf0HqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B620C4CEF5;
	Sat,  6 Dec 2025 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765029821;
	bh=Tz8gkfZfbuDdQFaxz8Xaau2EfIYA4RF5sGA4a+5kLvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgbf0HqBIA/jruNmDm3ZMUWujHdGtjcWfOvH+N68r2WRlX2ZqUzh1fiOvv6hqXub/
	 FLLv76aV8PxsM/8n1CtwYgkqWVy/6x7QW9JTkinvh74sCtWtrhtRDT+TY5Cc/N7/7u
	 MG7eNv2CVLAamkgrmgxXaGyEpsx0cWqnMY1JEbQo3QTizkkXPEtF3xrNXJ2R/NPM2r
	 awNvixQOWs40KPwRy/HU/0UKTScb8js6C1+NvdQJAMaIhF9/FsJOjkdxDkFoDurD8u
	 /F6TVQsn2Isd8gHtQjzgIN0Wf3RcE9MjA4EoMt5I88f5e21Qo1Y7FRbJar7zufE256
	 1vktg7K33gnsA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.18-5.10] hfsplus: fix volume corruption issue for generic/073
Date: Sat,  6 Dec 2025 09:02:28 -0500
Message-ID: <20251206140252.645973-23-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Viacheslav Dubeyko <slava@dubeyko.com>

[ Upstream commit 24e17a29cf7537f0947f26a50f85319abd723c6c ]

The xfstests' test-case generic/073 leaves HFS+ volume
in corrupted state:

sudo ./check generic/073
FSTYP -- hfsplus
PLATFORM -- Linux/x86_64 hfsplus-testing-0001 6.17.0-rc1+ #4 SMP PREEMPT_DYNAMIC Wed Oct 1 15:02:44 PDT 2025
MKFS_OPTIONS -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/073 _check_generic_filesystem: filesystem on /dev/loop51 is inconsistent
(see XFSTESTS-2/xfstests-dev/results//generic/073.full for details)

Ran: generic/073
Failures: generic/073
Failed 1 of 1 tests

sudo fsck.hfsplus -d /dev/loop51
** /dev/loop51
Using cacheBlockSize=32K cacheTotalBlock=1024 cacheSize=32768K.
Executing fsck_hfs (version 540.1-Linux).
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
Invalid directory item count
(It should be 1 instead of 0)
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
Verify Status: VIStat = 0x0000, ABTStat = 0x0000 EBTStat = 0x0000
CBTStat = 0x0000 CatStat = 0x00004000
** Repairing volume.
** Rechecking volume.
** Checking non-journaled HFS Plus Volume.
The volume name is untitled
** Checking extents overflow file.
** Checking catalog file.
** Checking multi-linked files.
** Checking catalog hierarchy.
** Checking extended attributes file.
** Checking volume bitmap.
** Checking volume information.
** The volume untitled was repaired successfully.

The test is doing these steps on final phase:

mv $SCRATCH_MNT/testdir_1/bar $SCRATCH_MNT/testdir_2/bar
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/testdir_1
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/foo

So, we move file bar from testdir_1 into testdir_2 folder. It means that HFS+
logic decrements the number of entries in testdir_1 and increments number of
entries in testdir_2. Finally, we do fsync only for testdir_1 and foo but not
for testdir_2. As a result, this is the reason why fsck.hfsplus detects the
volume corruption afterwards.

This patch fixes the issue by means of adding the
hfsplus_cat_write_inode() call for old_dir and new_dir in
hfsplus_rename() after the successful ending of
hfsplus_rename_cat(). This method makes modification of in-core
inode objects for old_dir and new_dir but it doesn't save these
modifications in Catalog File's entries. It was expected that
hfsplus_write_inode() will save these modifications afterwards.
However, because generic/073 does fsync only for testdir_1 and foo
then testdir_2 modification hasn't beed saved into Catalog File's
entry and it was flushed without this modification. And it was
detected by fsck.hfsplus. Now, hfsplus_rename() stores in Catalog
File all modified entries and correct state of Catalog File will
be flushed during hfsplus_file_fsync() call. Finally, it makes
fsck.hfsplus happy.

sudo ./check generic/073
FSTYP         -- hfsplus
PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.18.0-rc3+ #93 SMP PREEMPT_DYNAMIC Wed Nov 12 14:37:49 PST 2025
MKFS_OPTIONS  -- /dev/loop51
MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch

generic/073 32s ...  32s
Ran: generic/073
Passed all 1 tests

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20251112232522.814038-1-slava@dubeyko.com
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my thorough analysis, here is my assessment:

---

## COMMIT ANALYSIS

### 1. PROBLEM DESCRIPTION
This commit fixes a **volume corruption issue** in HFS+ where renaming a
file between directories can lead to an inconsistent catalog file if
only one of the directories is subsequently fsync'd.

**The bug mechanism:**
1. When `hfsplus_rename()` moves a file from `old_dir` to `new_dir`, it
   calls `hfsplus_rename_cat()`
2. `hfsplus_rename_cat()` modifies both directories in memory:
   - `dst_dir->i_size++` (destination gains an entry)
   - `src_dir->i_size--` (source loses an entry)
   - Marks both dirty with `hfsplus_mark_inode_dirty()`
3. Marking dirty does NOT write to disk - it just flags for later
   writeback
4. If only one directory is fsync'd (as in xfstests generic/073), the
   other's changes may be lost
5. This creates a mismatch: the catalog file shows incorrect directory
   entry counts

**User-visible symptom:** `fsck.hfsplus` reports "Invalid directory item
count"

### 2. CODE CHANGE ANALYSIS

The fix is **extremely small and surgical** - only 5 lines added:

```c
- if (!res)
+   if (!res) {
        new_dentry->d_fsdata = old_dentry->d_fsdata;
+
+       res = hfsplus_cat_write_inode(old_dir);
+       if (!res)
+           res = hfsplus_cat_write_inode(new_dir);
+   }
```

**What it does:** After a successful rename, explicitly calls
`hfsplus_cat_write_inode()` for both directories, which writes their
catalog entries (including the valence/entry count) to the catalog file
immediately.

**Why it's correct:** `hfsplus_cat_write_inode()` is the established
function for writing directory catalog entries in HFS+. The fix ensures
both directories' updated entry counts are persisted immediately after
the rename operation.

### 3. CLASSIFICATION

| Criteria | Assessment |
|----------|------------|
| Bug type | **Filesystem corruption** - data integrity issue |
| Security | Not a CVE, but data corruption is serious |
| Cc: stable tag | **No** - maintainer didn't explicitly request
backport |
| Fixes: tag | **No** - no specific commit cited |
| User impact | HIGH for HFS+ users - volume corruption can cause data
loss |

### 4. SCOPE AND RISK ASSESSMENT

- **Lines changed:** 5 lines added
- **Files touched:** 1 file (`fs/hfsplus/dir.c`)
- **Complexity:** Very low - adds two well-established function calls
- **Bug age:** Since 2013 (commit `892f6668f3a70` introduced
  `hfsplus_rename`)
- **Risk of regression:** **LOW** - the function being called is already
  used throughout HFS+ codebase

### 5. USER IMPACT

- **Who uses HFS+?** Mac users dual-booting, legacy Apple volumes, some
  embedded systems
- **Severity:** HIGH - filesystem corruption affects data integrity
- **Reproducibility:** Easily triggered by xfstests generic/073

### 6. DEPENDENCY CHECK

- `hfsplus_cat_write_inode()` has existed since the early days of
  hfsplus
- No dependency on other recent commits
- Should apply cleanly to all stable trees that include hfsplus

---

## VERDICT

**This commit SHOULD be backported** because:

1. **Fixes a real, serious bug:** Volume corruption is a significant
   data integrity issue
2. **Obviously correct:** The fix ensures both directories are written
   after rename - this is fundamental filesystem consistency
3. **Small and contained:** Only 5 lines in a single file, using
   existing functions
4. **Low regression risk:** Uses well-established
   `hfsplus_cat_write_inode()` function
5. **Long-standing bug:** Has affected users since 2013
6. **Reproducible:** Standard xfstests test case triggers the bug
7. **Follows established patterns:** Similar to how other filesystems
   handle rename consistency

While the commit lacks explicit "Cc: stable" and "Fixes:" tags, the
stable kernel rules clearly allow important bug fixes for data
corruption issues to be backported. The fix is minimal, well-understood,
and addresses a real problem that affects HFS+ users.

Sources:
- [xfstests generic test for fsync after renaming
  directory](https://patchwork.kernel.org/project/linux-
  btrfs/patch/1459330722-3227-1-git-send-email-fdmanana@kernel.org/)
- [xfstests GitHub repository](https://github.com/kdave/xfstests)

**YES**

 fs/hfsplus/dir.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 1b3e27a0d5e03..cadf0b5f93422 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -552,8 +552,13 @@ static int hfsplus_rename(struct mnt_idmap *idmap,
 	res = hfsplus_rename_cat((u32)(unsigned long)old_dentry->d_fsdata,
 				 old_dir, &old_dentry->d_name,
 				 new_dir, &new_dentry->d_name);
-	if (!res)
+	if (!res) {
 		new_dentry->d_fsdata = old_dentry->d_fsdata;
+
+		res = hfsplus_cat_write_inode(old_dir);
+		if (!res)
+			res = hfsplus_cat_write_inode(new_dir);
+	}
 	return res;
 }
 
-- 
2.51.0


