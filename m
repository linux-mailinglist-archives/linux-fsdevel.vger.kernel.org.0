Return-Path: <linux-fsdevel+bounces-50854-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31949AD05AE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF60118892B4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3968289800;
	Fri,  6 Jun 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJU4D+3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515C8289801;
	Fri,  6 Jun 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224570; cv=none; b=Z+0g3ywne5nsW25w8XY4vVCnWDIr6sj1ZeQPfE9vhiNNOp31olr6kWweRgudCLhRoWaNFt+z0NMMgnOllk5NOYZWAzDBwoTZqEad09cal0zbyzA6srHu7KWk+4qTkwvHyrylkpvRa2KgzPI2ORSYnWBulottAvf4xVjt038ygDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224570; c=relaxed/simple;
	bh=6s/uLHbUl0a87lz+0uOU6qLfFpLzObXa00d/06+8Dtg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MV/XurUiM6VSnIrHmORnQE7W8AshdyEGrhGHeMaP/Vw4EeBb0m3SAm29hdPUku/bAAS0f8dzbzFKSW0sn8cPoERqL6RcDAh2r6C6v65LBxYtQw7E/fOIS7zpJbItiZ/ygDNYUs0XN/mwugF4GZdOHdkbS+x4wc9ePu2EiojQ0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJU4D+3G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356BFC4CEEB;
	Fri,  6 Jun 2025 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224570;
	bh=6s/uLHbUl0a87lz+0uOU6qLfFpLzObXa00d/06+8Dtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJU4D+3Gs0jBHLj/chriDXGvRz+onADFdsV1Zq47oxHZOA54AVy37vKbG22z2Tlr2
	 namN2X/9PnYpuEsEGoVcmZvPSPcWRQ4/A1rCRXyUJKP7DxlKtMcb4ur7TijgvtdC70
	 eI2KlyOfjnSb6iSWarV4qyQ0IdJrmTu5FyNwjbZueJLfRBLtlJ/kDLpA3o1jd3KV23
	 cOXbqF5lxPbzGSohhB/BCut4xWyuNTrndmYppYyVjARyYzras0wcQbfSxov1QX24MO
	 kXA+ugtKJnMRKbboXmdHVpUuGgOtexPasjcE7HdVBrye9x0GCCHiQXqZzBi5bWfYtJ
	 Pk6/+CFo0gcwg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guang Yuan Wu <gwu@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 16/19] fuse: fix race between concurrent setattrs from multiple nodes
Date: Fri,  6 Jun 2025 11:42:22 -0400
Message-Id: <20250606154225.546969-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154225.546969-1-sashal@kernel.org>
References: <20250606154225.546969-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.10
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
index 8f699c67561fa..2775e95c8e8c3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1925,6 +1925,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
+	u64 attr_version;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -2009,6 +2010,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
+
+	attr_version = fuse_get_attr_version(fm->fc);
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (err) {
@@ -2034,6 +2037,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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
 				      fuse_get_cache_mask(inode), 0);
-- 
2.39.5


