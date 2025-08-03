Return-Path: <linux-fsdevel+bounces-56588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A582DB195F9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 23:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FBD173FE6
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Aug 2025 21:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D408421CA1E;
	Sun,  3 Aug 2025 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igVAFN8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B249204592;
	Sun,  3 Aug 2025 21:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754256068; cv=none; b=ROH2/DfokfsmCkzx1Wl+EgzQlJwFxzVeii+h16IUDqGz5itlWTPvjmKsRWeTkg3OuZnvoptCHVGrYJDJTArwWP6SlP6BFRFi2jlVGkVCs2UKxEzRimbcVG9QyIxOuCEJFES8TclwkjME+jicRM64J+xi36HfkTncF5nYZYNU33M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754256068; c=relaxed/simple;
	bh=7249Z87x3BhR9dYHxco/DKcjT9jMKVpA65JxApM3NXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nob393JGoQoWKmkLVU/6AZ2N3taMmt4YnU7VuBsY1hOAMDjjTkK9Ki2tJpq6Rpdq11z8KdjttQhYDlNqbQkDZPkdUFAhdYihS5ybiFpXzF3nf/B2w5xy/HQZluqkY7N8sd1GchV9GasHwppQMEwj3Pl4HofIynZjJzkBCw9AkUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igVAFN8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6511AC4CEF9;
	Sun,  3 Aug 2025 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754256067;
	bh=7249Z87x3BhR9dYHxco/DKcjT9jMKVpA65JxApM3NXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=igVAFN8JKD6tZkBKh0iPHYtCRVql+B+uQchrTFWnB+nOYNBHeJudO5o7JAim9xep6
	 9DtHeoCxvNZlcMipLwwS+Qdg1Rx8WXrngX0MITU2ya1JIqbfTCvUg7FVJgLyvAOyR0
	 NeiQ+sxtJwu1BUDoKOLOx+Gda1S0nqJoi33a4LsRabLIzmG4Fz7y1+PEjMyR+kn/Df
	 1gVJhbLxsuBj+3T/rXeQomK+SaN7+fe1med/68kPy/bL5rBylvvPSO4P4hUKJ2quFT
	 o6UuWF6vR87UTkb/AQKhQA/0/XlMful5dvuSz42MFKU/4MwWZrUBlRIwEFsAPFi5Dx
	 RurfAwsDliS1Q==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	syzbot+169de184e9defe7fe709@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/23] better lockdep annotations for simple_recursive_removal()
Date: Sun,  3 Aug 2025 17:20:22 -0400
Message-Id: <20250803212031.3547641-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250803212031.3547641-1-sashal@kernel.org>
References: <20250803212031.3547641-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.101
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
index f5566964aa7d..b913ab238cc1 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -610,7 +610,7 @@ void simple_recursive_removal(struct dentry *dentry,
 		struct dentry *victim = NULL, *child;
 		struct inode *inode = this->d_inode;
 
-		inode_lock(inode);
+		inode_lock_nested(inode, I_MUTEX_CHILD);
 		if (d_is_dir(this))
 			inode->i_flags |= S_DEAD;
 		while ((child = find_next_child(this, victim)) == NULL) {
@@ -622,7 +622,7 @@ void simple_recursive_removal(struct dentry *dentry,
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


