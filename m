Return-Path: <linux-fsdevel+bounces-50853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF350AD057D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630FA188CE4A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 15:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252BC289826;
	Fri,  6 Jun 2025 15:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti99aA+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DD276048;
	Fri,  6 Jun 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749224533; cv=none; b=qAIDdo/ogCch+bCs5UMrkR8MjzrF2+yAD4KbjTR+gyjYmRj5/tnuAKCtwurXTQBYCs0SEQlXzQz+YuOVzt8IHGZLA8CQVxlZ+vJU04M3jWHaYuzN7kKUd6od8D2I8/8nqS5iEjc7lmzck02ZB71qGyLgL/Z3dMKmHtL/YhzUoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749224533; c=relaxed/simple;
	bh=9hFt2gLDKKNBP4ADXOIlCT++toK7zAWB/0iKvdnBE48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eg08hF1BjzES6Yuy3YxlZOmuY2J6aUpAMIMetxeH8z8c8xhD3MBNNynRtGYC+IzzABfKnTvR+pz69ed/l+5Rbg3PtVfLvkMQOya5hl8Hung3HXBYp1bXia1p8Msepw8IH1wit/6Z0fsFoymfDryPAzaqCTAZf2tFl6DO6Yo+a5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti99aA+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E3CC4CEF4;
	Fri,  6 Jun 2025 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749224533;
	bh=9hFt2gLDKKNBP4ADXOIlCT++toK7zAWB/0iKvdnBE48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ti99aA+BXGx1hm37qfXnrkTLKYEoIe5GSqux8LS9yn2zPKe2yTrwUUDl5c+mqDSHS
	 2ljJC6A3oQS5asw2jaUPXa+AuBu+MCPxloYHggzLhXkSe/oRCJKJWDpRDZGTRzs2eg
	 dmGs5WSsaJk0nNbAZ6meMUnZJTa+YFe3DT/SB4QHWcAvDcabpMeB8RHgbjX9+7ZacA
	 WilkXgnk00CMJAWDfWXrH+4+Exkp3FDdYJ10Bbrc4ljFrCvjcIW8AFL8O4HRpsKJhg
	 290OlPXZnDqSLz5kPysx50A71YgJleiw7qkroO+VR0g3KWd1gU4LNjVvk+xaraBQL9
	 pHhnajOCU08gA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Guang Yuan Wu <gwu@ddn.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 17/21] fuse: fix race between concurrent setattrs from multiple nodes
Date: Fri,  6 Jun 2025 11:41:42 -0400
Message-Id: <20250606154147.546388-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250606154147.546388-1-sashal@kernel.org>
References: <20250606154147.546388-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.1
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
index 83ac192e7fdd1..fa90309030e21 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1946,6 +1946,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 	bool trust_local_cmtime = is_wb;
 	bool fault_blocked = false;
+	u64 attr_version;
 
 	if (!fc->default_permissions)
 		attr->ia_valid |= ATTR_FORCE;
@@ -2030,6 +2031,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (fc->handle_killpriv_v2 && !capable(CAP_FSETID))
 			inarg.valid |= FATTR_KILL_SUIDGID;
 	}
+
+	attr_version = fuse_get_attr_version(fm->fc);
 	fuse_setattr_fill(fc, &args, inode, &inarg, &outarg);
 	err = fuse_simple_request(fm, &args);
 	if (err) {
@@ -2055,6 +2058,14 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
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


