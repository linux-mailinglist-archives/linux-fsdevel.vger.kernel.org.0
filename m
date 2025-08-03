Return-Path: <linux-fsdevel+bounces-56581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F13B195DF
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4904B16DF87
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAFC221FD4;
	Sun,  3 Aug 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAqQTUDd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BFD205502;
	Sun,  3 Aug 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256027; cv=none; b=TCVgiKSDKXJT3OPp5CLll03Pws8HtLqDXweFqpcw8bpzULLO8i8L4l7irEqiZzLmXks8vJGgTI/F+sEr6bRD4gzivyDoZmvXkkZrhJ28ZQtGVUBvCVb1WhFuN+kmOvIDj5Nl1eq0CVKi65m48PHb9PPET8bYarrLQ5fC9ET4Mas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256027; c=relaxed/simple;
	bh=6pWjck7ahXUX00bGEZQBEL3LDn7XtPev5LD5qV7xrd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRyt3U4QXoJ3JJzK86APjKwg9eMyiUlXURc3TDDkJn403Dkqwh4bu+Jm5PlRjn3D0cZBHbj1YxeBtpS4xKzBfn/Ph5kqFgROTnntcXQGA/j7lRpxvtpULYQDY9GmDC4+UFfA3lsca1uCiRHKeGzxTfa9sDQ4/C2zbN4j2AIM9cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAqQTUDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C72C4CEF8;
	Sun,  3 Aug 2025 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256027;
	bh=6pWjck7ahXUX00bGEZQBEL3LDn7XtPev5LD5qV7xrd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nAqQTUDdkXTXOJLWkzKQzEjc7cNdt9TEhRMAlCN5rB7Hh3Bp0xdIOTsSyp/uSgyAF
	 EpNtXCLxP6VkM+mTliDtxI+d7paVaSDNhw7WOcBhWlQST8+3KjW9Lkq96LXx90ycP6
	 1BN33D7iVCPhiTFEhqWD6enG2j1XTBJWM5DF3M3P2+AfcA1ApNsjDEV7P/uQgNWOl0
	 jdMAAA23RYn6L+mEWOXTv2kpJV6+Hbs7ujHNCqa60ovoy5znLsK13+hYQdEP9Yc3Bp
	 QLaWKyoJED7hb50twIRVCFfRziR2PT7zZyE4jgt42m2KIHLBSOH63gu5fcVHG92O39
	 ottDE9TomLquQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+169de184e9defe7fe709@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 20/31] better lockdep annotations for simple_recursive_removal()
Date: Sun,  3 Aug 2025 17:19:23 -0400
Message-Id: <20250803211935.3547048-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803211935.3547048-1-sashal@kernel.org>
References: <20250803211935.3547048-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.41
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 2a8061ee5e41034eb14170ec4517b5583dbeff9f ]

We want a class that nests outside of I_MUTEX_NORMAL (for the sake of
callbacks that might want to lock the victim) and inside I_MUTEX_PARENT
(so that a variant of that could be used with parent of the victim
held locked by the caller).

In reality, simple_recursive_removal()
	* never holds two locks at once
	* holds the lock on parent of dentry passed to callback
	* is used only on the trees with fixed topology, so the depths
are not changing.

So the locking order is actually fine.

AFAICS, the best solution is to assign I_MUTEX_CHILD to the locks
grabbed by that thing.

Reported-by: syzbot+169de184e9defe7fe709@syzkaller.appspotmail.com
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees for the
following reasons:

1. **Fixes a lockdep warning reported by syzbot**: The commit message
   explicitly mentions "Reported-by:
   syzbot+169de184e9defe7fe709@syzkaller.appspotmail.com", indicating
   this fixes a real issue detected by kernel testing infrastructure.

2. **Small and contained fix**: The change is minimal - only 2 lines
   changed, replacing `inode_lock(inode)` with `inode_lock_nested(inode,
   I_MUTEX_CHILD)` in two locations. This is exactly the type of
   targeted fix suitable for stable backports.

3. **Fixes incorrect lockdep annotations**: The commit corrects lockdep
   annotations without changing actual runtime behavior. According to
   the commit message, "the locking order is actually fine" - this is
   purely fixing false positive lockdep warnings that could mask real
   locking issues.

4. **No functional changes**: The code only changes lockdep annotations
   by using `inode_lock_nested()` with `I_MUTEX_CHILD` instead of plain
   `inode_lock()`. This doesn't change the actual locking behavior, just
   tells lockdep about the correct locking hierarchy.

5. **Prevents false positives in debugging**: False lockdep warnings can
   obscure real locking problems and make kernel debugging more
   difficult. Fixing these annotations helps maintain the effectiveness
   of lockdep as a debugging tool.

6. **Used by multiple filesystems**: Based on my grep results,
   `simple_recursive_removal()` is used by several filesystems including
   debugfs, tracefs, efivarfs, fuse, and nfsd. A lockdep false positive
   here could affect debugging across multiple subsystems.

7. **Low risk**: Since this only changes lockdep annotations and not
   actual locking behavior, the risk of regression is minimal. The worst
   case would be if the annotation was wrong, which would just result in
   lockdep warnings again.

The commit follows stable kernel rules by being a targeted fix for a
specific issue (lockdep false positive) without introducing new features
or architectural changes.

 fs/libfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3cb49463a849..874324167849 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -608,7 +608,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_CHILD);
 		if (d_is_dir(this))
 			inode->i_flags |= S_DEAD;
 		while ((child = find_next_child(this, victim)) == NULL) {
@@ -620,7 +620,7 @@ void simple_recursive_removal(struct dentry *dentry,
 			victim = this;
 			this = this->d_parent;
 			inode = this->d_inode;
-			inode_lock(inode);
+			inode_lock_nested(inode, I_MUTEX_CHILD);
 			if (simple_positive(victim)) {
 				d_invalidate(victim);	// avoid lost mounts
 				if (d_is_dir(victim))
-- 
2.39.5


