Return-Path: <linux-fsdevel+bounces-71035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6DCCB1D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76B62310C39C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 03:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145FF30F92A;
	Wed, 10 Dec 2025 03:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p6HQufDj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2630F7EA;
	Wed, 10 Dec 2025 03:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765338601; cv=none; b=mkRYhDEDpNYwgx7Yl8xw2CX38y0Lo4MgkiKzillhgTRiJdGe1F9xks49t1Naf/u9GLyYErJNGJeWv+t1pMxBs0jX06w54EjiFwFB2PCLureAbcZX3dUCxh8OS9e3XQdbqNJ/8nBrQM4N4S9+k9fBfYBo5rWSl4p88N8f0e2Ro9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765338601; c=relaxed/simple;
	bh=dtBe4ZIWbdUoOjPy9kYiz1klL3x1V5OPTh9KCCye5sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWc7VwqOGej9EBRkFF/rtVSoPss7jrxSC050v4z4v+FdDCyoVnBZuwHgbMivxlIDrLjzl3gLSMG2kYx8rqiTT/ryns1ZVBvslyyW4z5klTA5DAbMJEZQtWMnAy2qy54EQaSpFZ4IsPgWh484z5Vcoc8fxDs2fXv7GZ/sEzsDcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p6HQufDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F65C4CEF1;
	Wed, 10 Dec 2025 03:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765338601;
	bh=dtBe4ZIWbdUoOjPy9kYiz1klL3x1V5OPTh9KCCye5sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p6HQufDjvfHY6fBuFO6bymPEm8S6QZSqBKvBmgw/7nkfr3jeidckFP0t0BKT7INYh
	 AJuPGgTcD1029ufTbl244MuyjoI57wE82ekWGlMqC2yXgjsPj67t7flVkGAhx/+mqG
	 fyZMHEsiVDX6AxZLthmJ0U0E784C52U87uhdAuXATMSp96AD2pNou+vEu26a6w1sQu
	 UWBkMDFVW3nPohGSRE+L1/UdcR4ofsuOr/o6Nt4HvKf6YYMwaZLe/naElQa/rbjjJ4
	 E8oozIBJi0+B3n830TlpP46FEkMctB5BlUZb4iS3G3JcJRc2Vxd7X6q1a97Bhu6b6m
	 A12SoLoxrmF2g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Yuezhang Mo <Yuezhang.Mo@sony.com>,
	kernel test robot <oliver.sang@intel.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sj1557.seo@samsung.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] exfat: fix remount failure in different process environments
Date: Tue,  9 Dec 2025 22:49:00 -0500
Message-ID: <20251210034915.2268617-19-sashal@kernel.org>
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

[ Upstream commit 51fc7b4ce10ccab8ea5e4876bcdc42cf5202a0ef ]

The kernel test robot reported that the exFAT remount operation
failed. The reason for the failure was that the process's umask
is different between mount and remount, causing fs_fmask and
fs_dmask are changed.

Potentially, both gid and uid may also be changed. Therefore, when
initializing fs_context for remount, inherit these mount options
from the options used during mount.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202511251637.81670f5c-lkp@intel.com
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Commit Analysis: exfat: fix remount failure in different process
environments

### 1. COMMIT MESSAGE ANALYSIS

**Subject**: Contains "fix" keyword indicating a bug fix for remount
failures.

**Key details from message**:
- Reported by kernel test robot - this is a real, reproducible issue
- Root cause: When remounting, the process's umask may differ from the
  original mount, causing `fs_fmask` and `fs_dmask` to unexpectedly
  change
- The same issue applies to `gid` and `uid`
- Has `Closes:` link to the bug report

**Missing tags**:
- No `Cc: stable@vger.kernel.org`
- No `Fixes:` tag indicating when the bug was introduced

### 2. CODE CHANGE ANALYSIS

**The Bug**:
```c
// BEFORE: Always uses current process values
sbi->options.fs_uid = current_uid();
sbi->options.fs_gid = current_gid();
sbi->options.fs_fmask = current->fs->umask;
sbi->options.fs_dmask = current->fs->umask;
```

When `exfat_init_fs_context()` is called for a remount operation, it was
incorrectly initializing uid/gid/fmask/dmask from the **current
process** rather than preserving the existing mount options. If the
process performing the remount has a different umask (or runs as a
different user), the options change unexpectedly, causing remount
validation failures.

**The Fix**:
```c
// AFTER: Check if this is a remount and inherit existing options
if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fc->root) {
    struct super_block *sb = fc->root->d_sb;
    struct exfat_mount_options *cur_opts = &EXFAT_SB(sb)->options;

    sbi->options.fs_uid = cur_opts->fs_uid;
    sbi->options.fs_gid = cur_opts->fs_gid;
    sbi->options.fs_fmask = cur_opts->fs_fmask;
    sbi->options.fs_dmask = cur_opts->fs_dmask;
} else {
    // Original behavior for initial mount
    ...
}
```

This is the correct behavior - remount should preserve existing mount
options unless explicitly overridden by the user.

### 3. CLASSIFICATION

- **Type**: Bug fix (not a feature)
- **Category**: Filesystem correctness issue
- **Security**: Not a security issue

### 4. SCOPE AND RISK ASSESSMENT

| Metric | Value |
|--------|-------|
| Lines changed | ~15 (net +11) |
| Files touched | 1 (fs/exfat/super.c) |
| Complexity | Low - simple conditional logic |
| Risk | Low - uses well-established fs_context patterns |

The fix is surgically targeted at `exfat_init_fs_context()` and uses
standard fs_context APIs (`fc->purpose`, `fc->root`,
`FS_CONTEXT_FOR_RECONFIGURE`) that other filesystems use identically.

### 5. USER IMPACT

- **Affected users**: Anyone using exFAT filesystems who performs
  remount operations
- **Scenario**: Common when system scripts, systemd units, or root user
  (with different umask) remount a filesystem
- **Severity**: Medium - causes remount failures, but not data
  corruption
- **Real-world impact**: Yes - kernel test robot found this in automated
  testing

### 6. STABILITY INDICATORS

- Signed-off by exFAT maintainer (Namjae Jeon)
- Triggered by automated kernel testing
- Logic is straightforward and follows established patterns used by
  other filesystems

### 7. DEPENDENCY CHECK

The fix relies on:
- `fc->purpose` and `fc->root` - standard fs_context fields available
  since the fs_context API conversion
- `EXFAT_SB()` macro - existing exFAT infrastructure
- `FS_CONTEXT_FOR_RECONFIGURE` - standard kernel constant

No additional dependencies required. The fix applies to any kernel with
exFAT's fs_context implementation.

### STABLE KERNEL CRITERIA EVALUATION

| Criterion | Met? |
|-----------|------|
| Obviously correct | ✅ Yes - straightforward logic |
| Fixes real bug | ✅ Yes - reported by kernel test robot |
| Small and contained | ✅ Yes - single function, ~15 lines |
| No new features | ✅ Yes - corrects existing behavior |
| No new APIs | ✅ Yes - uses existing fs_context APIs |

### VERDICT

This commit fixes a genuine bug where exFAT remount operations fail when
the remounting process has a different umask than the original mounting
process. The fix is:

1. **Small and localized** - modifies one function in one file
2. **Obviously correct** - follows the same pattern other filesystems
   use for handling remount context initialization
3. **Low risk** - no architectural changes, just proper option
   inheritance
4. **User-impacting** - remount failures are a real usability issue

While the commit lacks explicit `Cc: stable` and `Fixes:` tags, the
nature of the fix (correcting filesystem remount behavior) and its
minimal footprint make it appropriate for stable backporting. The risk-
benefit ratio strongly favors inclusion.

**YES**

 fs/exfat/super.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 74d451f732c73..581754001128b 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -813,10 +813,21 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			DEFAULT_RATELIMIT_BURST);
 
-	sbi->options.fs_uid = current_uid();
-	sbi->options.fs_gid = current_gid();
-	sbi->options.fs_fmask = current->fs->umask;
-	sbi->options.fs_dmask = current->fs->umask;
+	if (fc->purpose == FS_CONTEXT_FOR_RECONFIGURE && fc->root) {
+		struct super_block *sb = fc->root->d_sb;
+		struct exfat_mount_options *cur_opts = &EXFAT_SB(sb)->options;
+
+		sbi->options.fs_uid = cur_opts->fs_uid;
+		sbi->options.fs_gid = cur_opts->fs_gid;
+		sbi->options.fs_fmask = cur_opts->fs_fmask;
+		sbi->options.fs_dmask = cur_opts->fs_dmask;
+	} else {
+		sbi->options.fs_uid = current_uid();
+		sbi->options.fs_gid = current_gid();
+		sbi->options.fs_fmask = current->fs->umask;
+		sbi->options.fs_dmask = current->fs->umask;
+	}
+
 	sbi->options.allow_utime = -1;
 	sbi->options.errors = EXFAT_ERRORS_RO;
 	exfat_set_iocharset(&sbi->options, exfat_default_iocharset);
-- 
2.51.0


