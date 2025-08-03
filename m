Return-Path: <linux-fsdevel+bounces-56606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4852B1965E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE68A1894ECE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462F522DFA5;
	Sun,  3 Aug 2025 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSENBMmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33F921B9DE;
	Sun,  3 Aug 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256183; cv=none; b=nfTDUEHi1ESNIC4RxuWMp2pp5vG1UzYGVSFsIw0+8CwzP4ZULUeB4IY3vlfX5vXOiQU8unTY+gVeMMyVzhJCjNcgliv307+htYZSmCB7GDdmvvAxlI2z7AJg5WlfTMybpOXw5NuGoSdD2wIX1ePV/I2IE2xL5ni1bgM+7F1PqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256183; c=relaxed/simple;
	bh=RfqUE8+XW0CA3kUVRsiotWPPZalepZ84GNOtVUu/4XQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YR993rnU9bfirclb0nJEVknf70+jspwJmGPWrM0HH9MgalksQWxg+DcdmoW81awpZk6b2Zpy3aWdN5ojG+rAr7y3qApMCQNRXWCAmDURw6HZUeTc2vDGruWsNY7dzvQAeRkSP0Nmp403oW48WAuyrFH4mNe82A2ye1NFk+oio/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSENBMmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26B69C4CEEB;
	Sun,  3 Aug 2025 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256183;
	bh=RfqUE8+XW0CA3kUVRsiotWPPZalepZ84GNOtVUu/4XQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uSENBMmItHBUaHJ/jJ5yDFBbHpMGAHiA+bwuRVXIZzx2H0W0e/NAHFttG4dQDzzSj
	 mEXi+uVnRXM+ecE1Ca19We6Of8Y8APb322EedNPRWvPU94YibaKjHh1xrzj7FwQcPd
	 d63r7lZeL2QsSj/5PFResXS/VL1kP553CLzIhtPno+YW163w+R/8b3n/l6YEWknJNR
	 Stq6qzNO1111zxYV+BuCLy7VN2SRj3W0JwndNoU6TE6BVjh+oZICaO1vMm6VY7TiS+
	 5Wxjhd7zJ5Ic6DU4AtSwiNC9PPeMCi8nHsCqS9fvuhx6ql8yzx6C9JoHn0PfWrPvtZ
	 kM+Wzy7aKxnvw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+169de184e9defe7fe709@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 09/11] better lockdep annotations for simple_recursive_removal()
Date: Sun,  3 Aug 2025 17:22:39 -0400
Message-Id: <20250803212242.3549318-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212242.3549318-1-sashal@kernel.org>
References: <20250803212242.3549318-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
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
index aa0fbd720409..c6ed6c58dee6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -272,7 +272,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_CHILD);
 		if (d_is_dir(this))
 			inode->i_flags |= S_DEAD;
 		while ((child = find_next_child(this, victim)) == NULL) {
@@ -284,7 +284,7 @@ void simple_recursive_removal(struct dentry *dentry,
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


