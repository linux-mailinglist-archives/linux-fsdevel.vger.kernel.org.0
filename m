Return-Path: <linux-fsdevel+bounces-65812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5016C12389
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 01:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93570581E38
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Oct 2025 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C321DF246;
	Tue, 28 Oct 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKHwZLFQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7C1EC01B;
	Tue, 28 Oct 2025 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761612023; cv=none; b=jg6RnSYFYLUgx2UYCfNuzOVXbYa7SrgRWAxuNpa8pWPilWCtarcLiyWF5ITjv8Ck3QA9LO4sVy7HKoLAYygUZDg3NJr8VqNObE6DG+D/3IQH/HDfmo7p87DSX8u3RRHheeAnRKrY8H157erPsJrYjVFEIcC2VGVk7AlJIfL0RvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761612023; c=relaxed/simple;
	bh=E7pIPM+tWW3Z7U4FqepvC0V+Rdiwd9IgrrN3d6Fw16g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqG1/LeFJehF5+H926mbYN9SkhqLA+3MUk/NBY0r4ORLnmTd6ZF8fdfDqOuvvn60Qf/yVFfPtbNceMSsPfiq9cKptqon0p7IjUAqK6xNEpIqYqDQVqg1ny1IuXaCHumiCAY0ZIIZBx4PEa6WRez5UTg5TW2v5NAI8mkRlBbYnOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKHwZLFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6954C4CEFB;
	Tue, 28 Oct 2025 00:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761612023;
	bh=E7pIPM+tWW3Z7U4FqepvC0V+Rdiwd9IgrrN3d6Fw16g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dKHwZLFQz+foO52YD5n1/bFKaO5XEj/Xu6536s8CwVrmk5Av+zrM6fCLAqI8g7dbs
	 pJsYu1iEWwNYIX+5N6dmYFbXZU1XEZlMHUs/WnRRlSdSgA/Ihhdqn8BN4FDvocQOiz
	 J94vIvUww41hdQhpdg/6T1tehWiMCM1tuXQfSr8k/cOonWwG3jKhSNIIUgdn+kE/2U
	 vkDMQe9RnClBN2T79xzh5B402qhxJHdP0sEa8aRJtcyj6Z43truN5rUB8z0A/BKdvp
	 zhHg+2ZUCGiwivi6zZGQPQUFGyCkxUodMeW6XgAcKlFWLkG8cTUv8IVX/KSF9/Kixu
	 hwHpb5qNj/S1A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>,
	Andrey Albershteyn <aalbersh@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17] fs: return EOPNOTSUPP from file_setattr/file_getattr syscalls
Date: Mon, 27 Oct 2025 20:39:02 -0400
Message-ID: <20251028003940.884625-18-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028003940.884625-1-sashal@kernel.org>
References: <20251028003940.884625-1-sashal@kernel.org>
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

From: Andrey Albershteyn <aalbersh@redhat.com>

[ Upstream commit d90ad28e8aa482e397150e22f3762173d918a724 ]

These syscalls call to vfs_fileattr_get/set functions which return
ENOIOCTLCMD if filesystem doesn't support setting file attribute on an
inode. For syscalls EOPNOTSUPP would be more appropriate return error.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## ANSWER: YES

This commit should be backported to stable kernel trees (specifically
6.17.x).

## Extensive Analysis

### 1. Code Changes Analysis

The commit adds error code translation at two syscall boundaries in
`fs/file_attr.c`:

**In `file_getattr` syscall (line 418):**
```c
error = vfs_fileattr_get(filepath.dentry, &fa);
+if (error == -ENOIOCTLCMD || error == -ENOTTY)
+    error = -EOPNOTSUPP;
if (error)
    return error;
```

**In `file_setattr` syscall (line 484):**
```c
error = vfs_fileattr_set(mnt_idmap(filepath.mnt), filepath.dentry, &fa);
+if (error == -ENOIOCTLCMD || error == -ENOTTY)
+    error = -EOPNOTSUPP;
mnt_drop_write(filepath.mnt);
```

These are minimal, surgical changes that translate internal kernel error
codes to appropriate user-space error codes.

### 2. Semantic Analysis Tools Used

**Tools utilized:**
- `mcp__semcode__find_function`: Located the syscalls and vfs functions
- `mcp__semcode__find_callers`: Identified all callers of
  vfs_fileattr_get/set (5 and 4 callers respectively)
- `Read`, `Grep`, `Bash`: Examined code and git history
- Git history analysis: Traced the evolution of this fix

**Key findings from tool usage:**

**Call graph analysis:**
- `vfs_fileattr_get` is called by:
  - `file_getattr` syscall (the fix location)
  - `ioctl_fsgetxattr`, `ioctl_getflags` (ioctl handlers)
  - `ovl_real_fileattr_get`, `ecryptfs_fileattr_get` (filesystem
    wrappers)

- `vfs_fileattr_set` is called by:
  - `file_setattr` syscall (the fix location)
  - `ioctl_fssetxattr`, `ioctl_setflags` (ioctl handlers)
  - `ovl_real_fileattr_set`, `ecryptfs_fileattr_set` (filesystem
    wrappers)

**Impact scope:**
- The fix ONLY affects the two new syscalls
- Does NOT affect existing ioctl interfaces (critical - this was why the
  earlier vfs-level fix was reverted)
- overlayfs already converts -ENOIOCTLCMD to -ENOTTY internally
  (fs/overlayfs/inode.c:724)

### 3. Critical Bug Analysis

**Error code verification:**
- `-ENOIOCTLCMD` (error 515) is defined in `include/linux/errno.h` - a
  **kernel-internal header**
- It is **NOT** in `include/uapi/` directories (user-space API)
- This confirms -ENOIOCTLCMD should **NEVER** reach user-space - it's a
  kernel implementation detail
- `-ENOTTY` (error 25) is valid for user-space but semantically
  inappropriate for non-ioctl syscalls
- `-EOPNOTSUPP` is the correct POSIX error for "operation not supported"

### 4. Historical Context Analysis

Git history reveals a carefully considered approach:

1. **v6.17-rc1 (June 2025)**: New syscalls introduced (commit
   be7efb2d20d67)
2. **v6.17-rc1 (June 2025)**: First fix attempt at vfs level (commit
   474b155adf392)
3. **October 2025**: Vfs fix reverted due to regression in
   `ioctl_setflags()` (commit 4dd5b5ac089bb)
   - Problem: Filesystems use -EOPNOTSUPP to indicate unsupported flags
   - Vfs-level translation caused error code confusion for ioctls
4. **October 2025**: Current fix at syscall level (commit d90ad28e8aa48)
   - Merged in v6.18-rc2
   - Does NOT affect ioctl behavior
   - Solves the problem without regressions

### 5. Backport Suitability Assessment

**STRONG YES indicators:**

✅ **Fixes real user-impacting bug**: Internal error codes leak to user-
space
✅ **Minimal risk**: Only 4 lines changed, pure error code translation
✅ **Well-tested approach**: Previous vfs-level fix was reverted; this
approach is proven safer
✅ **Affects recent feature**: Syscalls introduced in v6.17, so 6.17.x
needs this fix
✅ **Active usage**: XFS already using these syscalls (commits
0239bd9fa445a, 8a221004fe528)
✅ **Reviewed by experts**: Jan Kara and Arnd Bergmann reviewed
✅ **No follow-up fixes or reverts**: The commit stands without issues
✅ **Stable tree precedent**: Related revert was already backported
(commit 0cfb126205ecc)

**Current status:**
- Fix merged in v6.18-rc2
- **NOT present** in current 6.17.5 stable tree (verified via `git
  merge-base`)
- Syscalls present in 6.17.x but returning wrong error codes

### 6. Why No Explicit Stable Tag?

The commit lacks `Cc: stable@vger.kernel.org` or `Fixes:` tags, likely
because:
- The syscalls are brand new (only in v6.17)
- Maintainers may have expected it to flow naturally to stable
- Limited user-space adoption at the time meant low immediate impact

However, this doesn't diminish the need for backporting - it prevents
the bug from becoming entrenched as applications start using these
syscalls.

### 7. Compliance with Stable Tree Rules

✅ **Bug fix**: Yes - fixes ABI violation (internal error code exposure)
✅ **Important**: Yes - affects syscall interface correctness
✅ **Obvious and correct**: Yes - simple error code translation
✅ **Tested**: Yes - in mainline since v6.18-rc2
✅ **Minimal**: Yes - only 4 lines
✅ **No new features**: Correct - only fixes existing functionality
✅ **No architectural changes**: Correct - localized syscall boundary fix

### Conclusion

This is an excellent backport candidate that fixes a genuine ABI bug
(kernel-internal error codes leaking to user-space) in newly introduced
syscalls. The fix is minimal, safe, well-reviewed, and specifically
targets the 6.17.x stable tree where the bug exists. Backporting now
prevents applications from depending on incorrect error codes.

 fs/file_attr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 460b2dd21a852..1dcec88c06805 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -416,6 +416,8 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	}
 
 	error = vfs_fileattr_get(filepath.dentry, &fa);
+	if (error == -ENOIOCTLCMD || error == -ENOTTY)
+		error = -EOPNOTSUPP;
 	if (error)
 		return error;
 
@@ -483,6 +485,8 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	if (!error) {
 		error = vfs_fileattr_set(mnt_idmap(filepath.mnt),
 					 filepath.dentry, &fa);
+		if (error == -ENOIOCTLCMD || error == -ENOTTY)
+			error = -EOPNOTSUPP;
 		mnt_drop_write(filepath.mnt);
 	}
 
-- 
2.51.0


