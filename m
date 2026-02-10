Return-Path: <linux-fsdevel+bounces-76908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ6LKd/Ai2l6aQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:35:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4D1120125
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 00:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 625C630D8E5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 23:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170C313287;
	Tue, 10 Feb 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLNNS+Lu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0AE330320;
	Tue, 10 Feb 2026 23:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766312; cv=none; b=XOIk7CesWLwRaOjbMmKOQuY0wS5diJw6Dk3QQNo1hlBYhGOvyGCPO1wvxobBAbAYVGmdoM5hAe+dYx6pf245D1kdvGxFwtHBKdfG5l0sdpyP21IqTNqhmkwGjUAigdxFbaye8VhPESZERewhozEwCYAHjEI0d9YTqQlJNlXzUOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766312; c=relaxed/simple;
	bh=pHLQ7g6BAmHX92nJatKDdVeSH8Lk8THTaSmzsP+WyaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dggy/QtDxCw8dVFOtdznbWN8hYUyWgi4tqpDTJZmn7GLu0dBBV8ojEt2i7mBJ76nUz0pdGHkCO9mSg9fZzH3/FgfIalm0XibdcFV4f4ISWXUXngUI7RrHX4B21hGHTHBfReuFOHcP8wWUzCocm/rAy//tUPclTd1B4PcM4IsuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLNNS+Lu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52490C19423;
	Tue, 10 Feb 2026 23:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766312;
	bh=pHLQ7g6BAmHX92nJatKDdVeSH8Lk8THTaSmzsP+WyaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lLNNS+LukH1IMfX4IRgvriqMpzp+CV/CVzWn2Rr/WmcWvB6jYn/FX4A1GxNE4ISnJ
	 W6q6e3XsgTnRY17VPh4IH4WmpCSElubUkAngFiFlwbeLKYHcItcIi+GSGELQhrXH43
	 xXfe6uyBnVfJvMAlV/JqrXfVb7TYOsB8zJjL/CGM8HY68BVsMKaDTJqm1S2qUDVL0M
	 5BCNHSloLS9LCfRmajw+2DfBMaOUlUrrMPGSO1GeAJncoQ8hn+wFXl4JY62sHGgr9o
	 ItP6NLjqqlK9QHy1OwTiEyQ0wHlt57Y8cuYQVT6qj6EuH+/qe3XLpgbFj13G1sTkdq
	 YHLnraSAQwwgA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] hfsplus: pretend special inodes as regular files
Date: Tue, 10 Feb 2026 18:31:03 -0500
Message-ID: <20260210233123.2905307-18-sashal@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-76908-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,895c23f6917da440ed0d];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dubeyko.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: CE4D1120125
X-Rspamd-Action: no action

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit ed8889ca21b6ab37bc1435c4009ce37a79acb9e6 ]

Since commit af153bb63a33 ("vfs: catch invalid modes in may_open()")
requires any inode be one of S_IFDIR/S_IFLNK/S_IFREG/S_IFCHR/S_IFBLK/
S_IFIFO/S_IFSOCK type, use S_IFREG for special inodes.

Reported-by: syzbot <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=895c23f6917da440ed0d
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/r/d0a07b1b-8b73-4002-8e29-e2bd56871262@I-love.SAKURA.ne.jp
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Now I have a complete picture. Let me compile my analysis.

---

## Detailed Analysis

### 1. Commit Message Analysis

The commit message is clear: HFS+ special/system inodes (catalog, extent
overflow, allocation bitmap, startup, and attributes files) never have
`i_mode` set, leaving it at 0 after `iget_locked()`. This violates the
new VFS requirement (from `af153bb63a33`) that all inodes must have a
valid `S_IF*` type when opened via `may_open()`.

The commit is reported by syzbot with a concrete reproducer and a link
to the syzkaller bug tracker. It's reviewed and signed off by the HFS+
maintainer Viacheslav Dubeyko.

### 2. Code Change Analysis

The fix is a single statement added to `hfsplus_system_read_inode()` in
`fs/hfsplus/super.c`:

```c
inode->i_mode = S_IFREG;
```

This is placed after the switch statement that reads the fork data for
each special inode type (HFSPLUS_EXT_CNID, HFSPLUS_CAT_CNID,
HFSPLUS_ALLOC_CNID, HFSPLUS_START_CNID, HFSPLUS_ATTR_CNID).

**The bug mechanism**: When `hfsplus_iget()` is called for a system
inode (inode number < `HFSPLUS_FIRSTUSER_CNID` and !=
`HFSPLUS_ROOT_CNID`), it calls `hfsplus_system_read_inode()`. This
function sets up the fork data and address space operations but **never
sets `i_mode`**. The `i_mode` remains 0 (the default from
`iget_locked()` → `alloc_inode()`). Zero is not a valid file type - it
doesn't match any of S_IFDIR, S_IFLNK, S_IFREG, S_IFCHR, S_IFBLK,
S_IFIFO, or S_IFSOCK.

When this inode is later opened via a userspace `openat()` syscall
(triggered by syzbot with a crafted filesystem), `may_open()` is called:

```4175:4232:fs/namei.c
static int may_open(struct mnt_idmap *idmap, const struct path *path,
                    int acc_mode, int flag)
{
        // ...
        switch (inode->i_mode & S_IFMT) {
        case S_IFLNK:
        // ...
        case S_IFREG:
        // ...
        default:
                VFS_BUG_ON_INODE(!IS_ANON_FILE(inode), inode);
        }
```

With `i_mode = 0`, the switch falls to the default case, and since HFS+
special inodes aren't anonymous files, `VFS_BUG_ON_INODE` triggers →
**kernel BUG** (crash). This is confirmed by the syzbot crash report
showing `kernel BUG at fs/namei.c:3474` with a full stack trace through
`may_open` → `do_open` → `path_openat` → `do_filp_open` →
`do_sys_openat2` → `__x64_sys_openat`.

### 3. Relationship to Other Fixes

This is **NOT a duplicate** of `005d4b0d33f6` ("hfsplus: Verify inode
mode when loading from disk"). That fix addresses a DIFFERENT code path:

- `005d4b0d33f6` fixes `hfsplus_get_perms()` in `fs/hfsplus/inode.c` -
  validates mode for **user/root inodes** loaded from disk (corrupted
  on-disk mode)
- The commit we're analyzing fixes `hfsplus_system_read_inode()` in
  `fs/hfsplus/super.c` - sets mode for **special/system inodes** that
  never go through `hfsplus_get_perms()` at all

In `hfsplus_iget()`, the two paths are clearly separated:
- `inode->i_ino >= HFSPLUS_FIRSTUSER_CNID || inode->i_ino ==
  HFSPLUS_ROOT_CNID` → `hfsplus_cat_read_inode()` →
  `hfsplus_get_perms()` (fixed by `005d4b0d33f6`)
- Otherwise → `hfsplus_system_read_inode()` (fixed by THIS commit)

Confirmed via grep: there is literally NO `i_mode` reference in
`fs/hfsplus/super.c` currently.

### 4. CONFIG_DEBUG_VFS Dependency

The `VFS_BUG_ON_INODE` macro is only active when `CONFIG_DEBUG_VFS` is
enabled. Without it, it's compiled to `BUILD_BUG_ON_INVALID(cond)` which
is a no-op at runtime. `CONFIG_DEBUG_VFS` was introduced alongside
`af153bb63a33` in v6.15 (commit `8b17e540969a`).

So the **crash** only occurs on kernels 6.15+ with `CONFIG_DEBUG_VFS`
enabled. However, having `i_mode = 0` is technically incorrect on ALL
kernel versions - any code checking inode type would get wrong results
for these inodes.

### 5. Scope and Risk Assessment

- **Lines changed**: 6 (including comment) - effectively 1 functional
  line
- **Files touched**: 1 (`fs/hfsplus/super.c`)
- **Risk**: Essentially zero. Setting `S_IFREG` on internal filesystem
  inodes that previously had no type is strictly an improvement. These
  inodes are filesystem metadata (btrees, allocation bitmap) - they are
  file-like data structures, so `S_IFREG` is appropriate.
- **No behavioral regression**: The fix doesn't change how the
  filesystem operates; it only ensures the inode has a valid VFS-level
  type.

### 6. User Impact

- **Who's affected**: Anyone mounting HFS+ filesystems on kernels 6.15+
  with `CONFIG_DEBUG_VFS`
- **Severity**: Kernel BUG/crash - system goes down
- **Trigger**: syzbot demonstrated this with crafted filesystem images,
  but it could potentially also be triggered with corrupted real HFS+
  volumes
- **syzbot confirmed**: 17,716 crashes recorded, reproducible with C
  reproducer

### 7. Stability Indicators

- Reviewed-by: Viacheslav Dubeyko (HFS+ maintainer)
- Signed-off-by: Viacheslav Dubeyko (maintainer)
- syzbot reported with concrete reproducer
- Part of a series of similar fixes across multiple filesystems (bfs,
  cramfs, isofs, jfs, minixfs, nilfs2, ntfs3, squashfs) - the ntfs3
  equivalent `4e8011ffec79` is already merged

### 8. Dependencies

The prerequisite VFS commit `af153bb63a33` exists in 6.15+. For older
stable trees (6.14 and below), the `VFS_BUG_ON_INODE` doesn't exist, so
the crash won't happen. However, the fix itself applies cleanly
regardless of version since `hfsplus_system_read_inode()` has been
stable for many years. Setting a proper i_mode is correct behavior
independently of the VFS debug check.

### Conclusion

This is a clear **YES** for stable backporting:
- Fixes a syzbot-reported kernel BUG (crash) - 17,716 crash instances
  recorded
- The fix is one functional line: `inode->i_mode = S_IFREG;`
- Zero risk of regression
- Obviously correct - internal inodes should have a valid file type
- Reviewed and accepted by the subsystem maintainer
- Complements the already-merged `005d4b0d33f6` by covering a different
  code path
- Part of a broader class of fixes across multiple filesystems for the
  same VFS requirement

**YES**

 fs/hfsplus/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0a..7f327b777ece8 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -53,6 +53,12 @@ static int hfsplus_system_read_inode(struct inode *inode)
 		return -EIO;
 	}
 
+	/*
+	 * Assign a dummy file type, for may_open() requires that
+	 * an inode has a valid file type.
+	 */
+	inode->i_mode = S_IFREG;
+
 	return 0;
 }
 
-- 
2.51.0


