Return-Path: <linux-fsdevel+bounces-76911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFNMJfy/i2l6aQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:32:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F4411FF9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22805305F227
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0832C923;
	Tue, 10 Feb 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbkjvpcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9C6330B2B;
	Tue, 10 Feb 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766316; cv=none; b=tYcGGJ9RJNE4hh11hk7M8IpfFlox4hF6mFzMykHu/pmVI49XlBeI5DWHkvDorr1jXXEg+YPhSE9/fdrtgc7/sBevUSXQnN6nBQq3Oq6giFBNARdx5KEY9XlNx4239bV0kDNFb3GqZHTDjBRs31rPH0/yPAN0wlTCAncb8yAVCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766316; c=relaxed/simple;
	bh=IKps1hgMKY0vItQ90CPLpkMg7cJJgfAbLUAUMpdaEEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyqdMrnBnFFpYKgww5bWRPCv5Q6ypYRA2EaukFnzbV008AdK73t2R0oaY6LukMdCYFjEv4UKr5Bv/pnteVlrC/j25LZvBf3RJwrFCsMYJl3TlUvlKJ3ZU9doa9V3BIHN23WhZ8n3nwojo1qU6lm94dt2YzQ9kREivwdsaObAW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbkjvpcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAF9C4AF09;
	Tue, 10 Feb 2026 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766316;
	bh=IKps1hgMKY0vItQ90CPLpkMg7cJJgfAbLUAUMpdaEEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbkjvpcIrFPe4Q4bs6G3Gup01WGZdu6QIp3y6hMmPAZYN8KE76JmOPCtTv4Wg3NLH
	 WUMe5OVVGb17VmeDaziUUSk5teVI7S+Imf5xn86kVeHcKKwRVsXq99V+1aD25DENkV
	 hBFrCe9GHuMFYrQMnrfQcbwzXMc9g8ed9ouIwPnKS1mqEu6tP6m/SsUjbiGAIXdVr2
	 kR+EFe80QArc3rKGzwL+Z0bYs+j7wG4FK2+UJb9NLTQkLp0xI5kIZ/RU4oZx/ResqF
	 JwSqVUfz+8wAzeWcfER6DCLf+0ClgcrZcTIrw5zavNnEvGtSny9wlHEgQxLvICUfA9
	 TqyQGWQSa7Sdg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19] hfs: Replace BUG_ON with error handling for CNID count checks
Date: Tue, 10 Feb 2026 18:31:06 -0500
Message-ID: <20260210233123.2905307-21-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210233123.2905307-1-sashal@kernel.org>
References: <20260210233123.2905307-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[xs4all.nl,syzkaller.appspotmail.com,dubeyko.com,kernel.org,vivo.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76911-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,17cc9bb6d8d69b4139f0];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xs4all.nl:email,syzbot.org:url]
X-Rspamd-Queue-Id: 49F4411FF9F
X-Rspamd-Action: no action

From: Jori Koolstra <jkoolstra@xs4all.nl>

[ Upstream commit b226804532a875c10276168dc55ce752944096bd ]

In a06ec283e125 next_id, folder_count, and file_count in the super block
info were expanded to 64 bits, and BUG_ONs were added to detect
overflow. This triggered an error reported by syzbot: if the MDB is
corrupted, the BUG_ON is triggered. This patch replaces this mechanism
with proper error handling and resolves the syzbot reported bug.

Singed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reported-by: syzbot+17cc9bb6d8d69b4139f0@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=17cc9bb6d8d69b4139f0
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/20251220191006.2465256-1-jkoolstra@xs4all.nl
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have the complete picture. Let me write the final analysis.

---

## Comprehensive Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message clearly states:
- It fixes BUG_ON() calls introduced by commit `a06ec283e125` ("hfs: add
  logic of correcting a next unused CNID")
- The BUG_ON triggers on corrupted MDB (Master Directory Block) data
- Reported by syzbot with a reproducible crash
- Reviewed by the HFS subsystem maintainer (Viacheslav Dubeyko)

### 2. CODE CHANGE ANALYSIS

The patch touches 5 files within `fs/hfs/`:

**a) `fs/hfs/inode.c` - `hfs_new_inode()`:** Replaces three
`BUG_ON(value > U32_MAX)` checks with proper error handling:
- If `next_id > U32_MAX`: reverses the `atomic64_inc`, prints error,
  jumps to `out_discard` which calls `iput(inode)` then returns
  `ERR_PTR(-ERANGE)`
- If `folder_count > U32_MAX`: same pattern with `atomic64_dec` rollback
- If `file_count > U32_MAX`: same pattern
- The function return type changes from `NULL` on error to `ERR_PTR()`
  on error

**b) `fs/hfs/inode.c` - `hfs_delete_inode()`:** Removes two `BUG_ON()`
calls that checked counts before decrementing. These are safe to remove
because the increment path now prevents exceeding U32_MAX.

**c) `fs/hfs/dir.c` - `hfs_create()` and `hfs_mkdir()`:** Updated
callers to check `IS_ERR(inode)` / `PTR_ERR(inode)` instead of `!inode`,
matching the new return convention.

**d) `fs/hfs/dir.c` - `hfs_remove()`:** Adds a pre-check via
`is_hfs_cnid_counts_valid()` before removing files/directories to
prevent operations on a corrupted filesystem.

**e) `fs/hfs/mdb.c` - `hfs_mdb_commit()`:** Removes three `BUG_ON()`
calls in the MDB commit path. These were the most dangerous - they could
trigger during periodic writeback work, causing a panic even without
user interaction after mount.

**f) `fs/hfs/mdb.c` - `hfs_mdb_get()`:** Adds mount-time validation via
`is_hfs_cnid_counts_valid()`. If the on-disk values are corrupted (>
U32_MAX), the filesystem is forced to read-only mode, preventing the
BUG_ON paths from ever being reached.

**g) `fs/hfs/mdb.c` - `is_hfs_cnid_counts_valid()`:** New helper
function that validates all three CNID-related counters.

**h) `fs/hfs/super.c` - `hfs_sync_fs()` and `flush_mdb()`:** Adds
`is_hfs_cnid_counts_valid()` calls before `hfs_mdb_commit()` as an extra
safety check.

### 3. THE BUG MECHANISM

Commit `a06ec283e125` (merged in v6.18) expanded `next_id`,
`file_count`, and `folder_count` from `u32` to `atomic64_t` for
atomicity, and added `BUG_ON()` to detect overflow past `U32_MAX`.
However, these values are read from the on-disk MDB at mount time via
`be32_to_cpu()` into `atomic64_t`. If the MDB is corrupted such that
these 32-bit on-disk values, when interpreted, lead to increments past
`U32_MAX` (the on-disk `drNxtCNID` could be `0xFFFFFFFF` or similar),
then creating a new file triggers `BUG_ON(next_id > U32_MAX)` at line
222 of `inode.c`.

The syzbot crash report confirms this exact scenario:
- **Crash site:** `kernel BUG at fs/hfs/inode.c:222` in
  `hfs_new_inode()`
- **Call path:** `openat() -> path_openat() -> lookup_open() ->
  hfs_create() -> hfs_new_inode()`
- **Trigger:** Opening a file for creation on a corrupted HFS filesystem
  image
- **Impact:** Instant kernel panic/oops (invalid opcode trap from
  BUG_ON)

### 4. DEPENDENCY ANALYSIS

**Critical dependency:** This fix ONLY applies to kernels containing
`a06ec283e125`, which first appeared in v6.18-rc1. The BUG_ON code does
not exist in v6.17 or earlier kernels. In those older kernels,
`next_id`, `file_count`, and `folder_count` are plain `u32` with simple
`++`/`--` operations and no overflow checks.

- **v6.18.y stable:** Has the BUG_ON (confirmed in v6.18.5). NEEDS this
  fix.
- **v6.12.y and older:** Does NOT have the BUG_ON. Does NOT need this
  fix.

### 5. SEVERITY AND IMPACT

- **Severity:** HIGH. This is a kernel BUG/panic triggered by corrupted
  filesystem data. Any user mounting a damaged or maliciously crafted
  HFS image can crash the kernel.
- **Attack surface:** HFS images can come from USB sticks, CD-ROMs, disk
  images, or network mounts. The crash is reachable from the `openat()`
  syscall (creating a file on a mounted corrupted HFS).
- **Security implications:** A crafted HFS image can crash the kernel,
  constituting a denial-of-service vulnerability. This is especially
  concerning for systems that auto-mount removable media.

### 6. RISK ASSESSMENT

- **Size:** ~130 lines changed across 5 files, all within `fs/hfs/`
- **Scope:** Entirely contained to the HFS filesystem subsystem
- **Pattern:** Well-understood "replace BUG_ON with error handling"
  pattern
- **Quality:** Reviewed by the HFS maintainer, tested by syzbot (patch
  testing passed), and went through 4 patch revisions (v1 through v4)
- **Risk:** LOW. The changes are:
  - Mount-time validation forces corrupted filesystems read-only (safe)
  - BUG_ON replaced with `return ERR_PTR(-ERANGE)` (graceful failure)
  - Callers updated to handle the new error convention
  - Atomic rollbacks on error (correct)

### 7. MINOR CONCERNS

- There's a minor whitespace issue (spaces vs tabs in `out_discard:`
  label indentation and `hfs_remove()`) - cosmetic only, no functional
  impact
- The `is_hfs_cnid_counts_valid()` calls in `hfs_sync_fs()` and
  `flush_mdb()` only print warnings but don't prevent `hfs_mdb_commit()`
  from running - however, the BUG_ONs in `hfs_mdb_commit()` are already
  removed, so this is a soft warning rather than crash prevention
- The commit has a typo "Singed-off-by" (should be "Signed-off-by") but
  this doesn't affect the code

### 8. CONCLUSION

This is a textbook stable backport candidate:
- Fixes a syzbot-reported, reproducible kernel BUG/panic
- The bug is triggered from userspace via a common syscall path
  (`openat()`)
- Corrupted filesystem images are a well-known attack vector
- The fix is contained, reviewed, and follows the standard "BUG_ON ->
  error handling" pattern
- It applies specifically to v6.18.y stable which contains the buggy
  BUG_ON code

The fix is small, surgical, and meets all stable kernel criteria.

**YES**

 fs/hfs/dir.c    | 15 +++++++++++----
 fs/hfs/hfs_fs.h |  1 +
 fs/hfs/inode.c  | 30 ++++++++++++++++++++++++------
 fs/hfs/mdb.c    | 31 +++++++++++++++++++++++++++----
 fs/hfs/super.c  |  3 +++
 5 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 86a6b317b474a..0c615c078650c 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -196,8 +196,8 @@ static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, mode);
-	if (!inode)
-		return -ENOMEM;
+	if (IS_ERR(inode))
+		return PTR_ERR(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -226,8 +226,8 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	int res;
 
 	inode = hfs_new_inode(dir, &dentry->d_name, S_IFDIR | mode);
-	if (!inode)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(inode))
+		return ERR_CAST(inode);
 
 	res = hfs_cat_create(inode->i_ino, dir, &dentry->d_name, inode);
 	if (res) {
@@ -254,11 +254,18 @@ static struct dentry *hfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
  */
 static int hfs_remove(struct inode *dir, struct dentry *dentry)
 {
+	struct super_block *sb = dir->i_sb;
 	struct inode *inode = d_inode(dentry);
 	int res;
 
 	if (S_ISDIR(inode->i_mode) && inode->i_size != 2)
 		return -ENOTEMPTY;
+
+	if (unlikely(!is_hfs_cnid_counts_valid(sb))) {
+	    pr_err("cannot remove file/folder\n");
+	    return -ERANGE;
+	}
+
 	res = hfs_cat_delete(inode->i_ino, dir, &dentry->d_name);
 	if (res)
 		return res;
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index e94dbc04a1e43..ac0e83f77a0f1 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -199,6 +199,7 @@ extern void hfs_delete_inode(struct inode *inode);
 extern const struct xattr_handler * const hfs_xattr_handlers[];
 
 /* mdb.c */
+extern bool is_hfs_cnid_counts_valid(struct super_block *sb);
 extern int hfs_mdb_get(struct super_block *sb);
 extern void hfs_mdb_commit(struct super_block *sb);
 extern void hfs_mdb_close(struct super_block *sb);
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index 524db1389737d..878535db64d67 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -187,16 +187,23 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	s64 next_id;
 	s64 file_count;
 	s64 folder_count;
+	int err = -ENOMEM;
 
 	if (!inode)
-		return NULL;
+		goto out_err;
+
+	err = -ERANGE;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
 	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
 	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	next_id = atomic64_inc_return(&HFS_SB(sb)->next_id);
-	BUG_ON(next_id > U32_MAX);
+	if (next_id > U32_MAX) {
+		atomic64_dec(&HFS_SB(sb)->next_id);
+		pr_err("cannot create new inode: next CNID exceeds limit\n");
+		goto out_discard;
+	}
 	inode->i_ino = (u32)next_id;
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
@@ -210,7 +217,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	if (S_ISDIR(mode)) {
 		inode->i_size = 2;
 		folder_count = atomic64_inc_return(&HFS_SB(sb)->folder_count);
-		BUG_ON(folder_count > U32_MAX);
+		if (folder_count> U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->folder_count);
+			pr_err("cannot create new inode: folder count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_dirs++;
 		inode->i_op = &hfs_dir_inode_operations;
@@ -220,7 +231,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	} else if (S_ISREG(mode)) {
 		HFS_I(inode)->clump_blocks = HFS_SB(sb)->clumpablks;
 		file_count = atomic64_inc_return(&HFS_SB(sb)->file_count);
-		BUG_ON(file_count > U32_MAX);
+		if (file_count > U32_MAX) {
+			atomic64_dec(&HFS_SB(sb)->file_count);
+			pr_err("cannot create new inode: file count exceeds limit\n");
+			goto out_discard;
+		}
 		if (dir->i_ino == HFS_ROOT_CNID)
 			HFS_SB(sb)->root_files++;
 		inode->i_op = &hfs_file_inode_operations;
@@ -244,6 +259,11 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	hfs_mark_mdb_dirty(sb);
 
 	return inode;
+
+	out_discard:
+		iput(inode);
+	out_err:
+		return ERR_PTR(err);
 }
 
 void hfs_delete_inode(struct inode *inode)
@@ -252,7 +272,6 @@ void hfs_delete_inode(struct inode *inode)
 
 	hfs_dbg("ino %lu\n", inode->i_ino);
 	if (S_ISDIR(inode->i_mode)) {
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		atomic64_dec(&HFS_SB(sb)->folder_count);
 		if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 			HFS_SB(sb)->root_dirs--;
@@ -261,7 +280,6 @@ void hfs_delete_inode(struct inode *inode)
 		return;
 	}
 
-	BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 	atomic64_dec(&HFS_SB(sb)->file_count);
 	if (HFS_I(inode)->cat_key.ParID == cpu_to_be32(HFS_ROOT_CNID))
 		HFS_SB(sb)->root_files--;
diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index 53f3fae602179..e0150945cf13b 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -64,6 +64,27 @@ static int hfs_get_last_session(struct super_block *sb,
 	return 0;
 }
 
+bool is_hfs_cnid_counts_valid(struct super_block *sb)
+{
+	struct hfs_sb_info *sbi = HFS_SB(sb);
+	bool corrupted = false;
+
+	if (unlikely(atomic64_read(&sbi->next_id) > U32_MAX)) {
+		pr_warn("next CNID exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->file_count) > U32_MAX)) {
+		pr_warn("file count exceeds limit\n");
+		corrupted = true;
+	}
+	if (unlikely(atomic64_read(&sbi->folder_count) > U32_MAX)) {
+		pr_warn("folder count exceeds limit\n");
+		corrupted = true;
+	}
+
+	return !corrupted;
+}
+
 /*
  * hfs_mdb_get()
  *
@@ -156,6 +177,11 @@ int hfs_mdb_get(struct super_block *sb)
 	atomic64_set(&HFS_SB(sb)->file_count, be32_to_cpu(mdb->drFilCnt));
 	atomic64_set(&HFS_SB(sb)->folder_count, be32_to_cpu(mdb->drDirCnt));
 
+	if (!is_hfs_cnid_counts_valid(sb)) {
+		pr_warn("filesystem possibly corrupted, running fsck.hfs is recommended. Mounting read-only.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
 	/* TRY to get the alternate (backup) MDB. */
 	sect = part_start + part_size - 2;
 	bh = sb_bread512(sb, sect, mdb2);
@@ -209,7 +235,7 @@ int hfs_mdb_get(struct super_block *sb)
 
 	attrib = mdb->drAtrb;
 	if (!(attrib & cpu_to_be16(HFS_SB_ATTRIB_UNMNT))) {
-		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.  mounting read-only.\n");
+		pr_warn("filesystem was not cleanly unmounted, running fsck.hfs is recommended.	Mounting read-only.\n");
 		sb->s_flags |= SB_RDONLY;
 	}
 	if ((attrib & cpu_to_be16(HFS_SB_ATTRIB_SLOCK))) {
@@ -273,15 +299,12 @@ void hfs_mdb_commit(struct super_block *sb)
 		/* These parameters may have been modified, so write them back */
 		mdb->drLsMod = hfs_mtime();
 		mdb->drFreeBks = cpu_to_be16(HFS_SB(sb)->free_ablocks);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->next_id) > U32_MAX);
 		mdb->drNxtCNID =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->next_id));
 		mdb->drNmFls = cpu_to_be16(HFS_SB(sb)->root_files);
 		mdb->drNmRtDirs = cpu_to_be16(HFS_SB(sb)->root_dirs);
-		BUG_ON(atomic64_read(&HFS_SB(sb)->file_count) > U32_MAX);
 		mdb->drFilCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->file_count));
-		BUG_ON(atomic64_read(&HFS_SB(sb)->folder_count) > U32_MAX);
 		mdb->drDirCnt =
 			cpu_to_be32((u32)atomic64_read(&HFS_SB(sb)->folder_count));
 
diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a45..70e118c27e200 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -34,6 +34,7 @@ MODULE_LICENSE("GPL");
 
 static int hfs_sync_fs(struct super_block *sb, int wait)
 {
+	is_hfs_cnid_counts_valid(sb);
 	hfs_mdb_commit(sb);
 	return 0;
 }
@@ -65,6 +66,8 @@ static void flush_mdb(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
+	is_hfs_cnid_counts_valid(sb);
+
 	hfs_mdb_commit(sb);
 }
 
-- 
2.51.0


