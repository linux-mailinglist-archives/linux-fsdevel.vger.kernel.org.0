Return-Path: <linux-fsdevel+bounces-50855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC234AD05BE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F2BF16D50D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3028428B7EA;
	Fri,  6 Jun 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhxmssMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6DD289372;
	Fri,  6 Jun 2025 15:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224598; cv=none; b=W9kLIJMFXaPrDNsTqoxxazQT5rPbDyGObFuiY1ljAlsx38I37HGeqc6bn3qrBsCVFC0gSkMFildB6Ykq2duqaakjvJr2XsAtx0QjPa+HrZTNZTm6Xr7/x8GPqZ+nNiZe/cadsp4IWWz1UtFNx4lVYxbWmvQIODGUeLHNqzI2GGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224598; c=relaxed/simple;
	bh=Du+OIFmDYpT0PLZ44mTQ6dci9Q3kfI+a8D+BUNxaBOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0B6VvzLp75nHjpKF+6L4+9kFCJLaN0UD/zilrAlF5Gfg0ocT8FI+TCW02HcnyzoiGng+agbg0j94mJ8d/otLekJLsVfwRdqmCFu8s2Qy83ZcKA1SFQhqr5UCMpsp+9CrkblU1vQa+kPuFONuSEJ6bVPKb0kOt027r800pPaweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhxmssMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74539C4CEF3;
	Fri,  6 Jun 2025 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224598;
	bh=Du+OIFmDYpT0PLZ44mTQ6dci9Q3kfI+a8D+BUNxaBOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bhxmssMvMB5kdyFcRzDU8RaqQV7WeWKVxMuE0qLMImVZnLuK4gy1tyWkbdtjLsO/l
	 XAPY0/ozJbRzxz9ODGW5sSIpkwhmB2M/PpW+Gg9exr+fOT254+Jjt5Qh50oKFRX4bs
	 F5zJWoYZHywJvlv5/y3Z9kAzO1RNpBEdOt+dfTl3iuYq4PF49ci2CHAd0ScZnJyvXM
	 GSB9yuA6qaazwVCFGPzKv3SCjyWDX2JMHzLSvSLf6+rufxoEk4XybG2/vAOXVH7XiY
	 wbWxCwCs99/Ge0uZzFM1CaH3fM8ozGGVeesmLvRWAcF7Cx9bR6zdGPDgVnnMnsy7aR
	 8frDq3HvjyJuA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guang Yuan Wu <gwu@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 12/15] fuse: fix race between concurrent setattrs from multiple nodes
Date: Fri,  6 Jun 2025 11:42:55 -0400
Message-Id: <20250606154259.547394-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154259.547394-1-sashal@kernel.org>
References: <20250606154259.547394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.32
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Guang Yuan Wu <gwu@ddn.com>

[ Upstream commit 69efbff69f89c9b2b72c4d82ad8b59706add768a ]

When mounting a user-space filesystem on multiple clients, after
concurrent ->setattr() calls from different node, stale inode
attributes may be cached in some node.

This is caused by fuse_setattr() racing with
fuse_reverse_inval_inode().

When filesystem server receives setattr request, the client node
with valid iattr cached will be required to update the fuse_inode's
attr_version and invalidate the cache by fuse_reverse_inval_inode(),
and at the next call to ->getattr() they will be fetched from user
space.

The race scenario is:
1. client-1 sends setattr (iattr-1) request to server
2. client-1 receives the reply from server
3. before client-1 updates iattr-1 to the cached attributes by
   fuse_change_attributes_common(), server receives another setattr
   (iattr-2) request from client-2
4. server requests client-1 to update the inode attr_version and
   invalidate the cached iattr, and iattr-1 becomes staled
5. client-2 receives the reply from server, and caches iattr-2
6. continue with step 2, client-1 invokes
   fuse_change_attributes_common(), and caches iattr-1

The issue has been observed from concurrent of chmod, chown, or
truncate, which all invoke ->setattr() call.

The solution is to use fuse_inode's attr_version to check whether
the attributes have been modified during the setattr request's
lifetime.  If so, mark the attributes as invalid in the function
fuse_change_attributes_common().

Signed-off-by: Guang Yuan Wu <gwu@ddn.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Now I have enough context to analyze this commit. Let me examine the
core changes and understand the race condition:

**YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Bug Analysis

**1. Race Condition Description:**
The commit fixes a serious race condition in FUSE between
`fuse_setattr()` and `fuse_reverse_inval_inode()` when multiple clients
mount the same filesystem. The race occurs when:

1. Client-1 sends setattr request to server
2. Client-1 receives reply but before applying attributes via
   `fuse_change_attributes_common()`
3. Server receives another setattr from client-2
4. Server calls `fuse_reverse_inval_inode()` on client-1, which bumps
   `attr_version` (line 567 in inode.c: `fi->attr_version =
   atomic64_inc_return(&fc->attr_version)`)
5. Client-1 continues with step 2, applying now-stale attributes

**2. Code Changes Analysis:**

The fix adds two key changes to `fuse_do_setattr()` in fs/fuse/dir.c:

```c
+       u64 attr_version;
...
+       attr_version = fuse_get_attr_version(fm->fc);
        fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
        err = fuse_simple_request(fm, &args);
...
+       if (fi->attr_version > attr_version) {
+               /*
+                * Apply attributes, for example for fsnotify_change(),
but set
+                * attribute timeout to zero.
+                */
+               outarg.attr_valid = outarg.attr_valid_nsec = 0;
+       }
```

This captures the `attr_version` before the request and checks if it
changed during the request lifetime. If it did, the fix sets the
attribute timeout to zero, effectively marking them invalid.

## Backport Criteria Assessment

**1. Important Bug Fix:** ✅ YES
- Fixes data consistency issues in multi-client FUSE scenarios
- Can cause stale cached attributes (file size, permissions, timestamps)
- Affects critical operations: chmod, chown, truncate

**2. Minimal and Contained:** ✅ YES
- Very small change: ~10 lines added
- Localized to `fuse_do_setattr()` function only
- No architectural changes

**3. Low Regression Risk:** ✅ YES
- Uses existing FUSE infrastructure (`attr_version` mechanism)
- Conservative approach: when in doubt, invalidate attributes
- No changes to external APIs or data structures

**4. Critical Subsystem:** ✅ MODERATE CONCERN, BUT ACCEPTABLE
- FUSE is important but this is a targeted fix
- Only affects multi-client scenarios
- Doesn't change core VFS interactions

**5. Clear Side Effects:** ✅ MINIMAL
- May cause slightly more GETATTR requests when races occur
- But this is the correct behavior for consistency

## Comparison with Similar Commits

This commit follows the same pattern as similar commit #1 (marked YES
for backport), which also:
- Fixed attribute cache consistency in FUSE
- Used the `attr_version` mechanism
- Made minimal, targeted changes
- Fixed race conditions between operations

Unlike commits #2-#5 (marked NO), this commit:
- Doesn't introduce new features or optimizations
- Doesn't change architectural patterns
- Fixes a clear data corruption/consistency bug

## Conclusion

This commit perfectly fits stable tree criteria: it fixes an important
multi-client data consistency bug with minimal risk through a small,
well-contained change. The race condition can lead to stale file
attributes being cached, which is a serious issue for applications
relying on accurate metadata. The fix follows established FUSE patterns
and is conservative in approach.

 fs/fuse/dir.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ff543dc09130e..ce7324d0d9ed1 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1921,6 +1921,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
+	u64 attr_version;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -2005,6 +2006,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
+
+	attr_version = fuse_get_attr_version(fm->fc);
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (err) {
@@ -2030,6 +2033,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		/* FIXME: clear I_DIRTY_SYNC? */
 	}
 
+	if (fi->attr_version > attr_version) {
+		/*
+		 * Apply attributes, for example for fsnotify_change(), but set
+		 * attribute timeout to zero.
+		 */
+		outarg.attr_valid = outarg.attr_valid_nsec = 0;
+	}
+
 	fuse_change_attributes_common(inode, &outarg.attr, NULL,
 				      ATTR_TIMEOUT(&outarg),
 				      fuse_get_cache_mask(inode));
-- 
2.39.5


