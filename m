Return-Path: <linux-fsdevel+bounces-8448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 208C9836B30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D6A1F21C86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702BE14F526;
	Mon, 22 Jan 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1UXf3CR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53514F520;
	Mon, 22 Jan 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936712; cv=none; b=I8a5AWPbK7Mfm8wsW+XCGtBoL18ou1yCxsGl0jp3OeAxlHzvdtdgcO31ltSCZaUVWWM4ecXKuWBVztKis3+zswmpoAFp/XMFiiQ0W+kPptWhALkyDWZGGgcNgVis8OMFAdM2VKUUsiDzsz3aZhgZkA6e/sykgk3aUB/mSR1swoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936712; c=relaxed/simple;
	bh=ALKaufZN6SDBuhIIQFi0lxfUswU/xWTH+N5nXXJl2FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOCgm+WWAQpAXxg1REDU1gk63vjVWlICsJ+G7ybARH75AtnTRg1iF8B+sr2QDseVNHUdMra45cvfMdKBIYSB+p6hdAygq1+w/7J/yYdyV0NOHHcn9xemlOVuM8QLjGF1EjSGy/0OWXDGeH1KTK94xafiLFFqd9KPD8Jrz+OQYYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1UXf3CR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94918C43399;
	Mon, 22 Jan 2024 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936712;
	bh=ALKaufZN6SDBuhIIQFi0lxfUswU/xWTH+N5nXXJl2FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o1UXf3CRuQeUaoPmztnHHi1Mef+XA9rA6dKZ2NzeMkzqxxxd2A0FQEcNpHYdEINWg
	 720kLlred4P+XM1Kus+ShiVDU/CECsapcCtMC5Bg1DbwwWGt7v4zW//qhXwVk5BbnP
	 c/xSqccKbk1zIY4EFFi6FjH8yBGmebzU2mGz525au8bbVPiX27245dJZgbsUScedPM
	 iHIf/T0T3sJvVj4AcvZI4GeQgbdWQMvGOH32BwfF58ZyYmv9tYMfKhgY+gdZ1Vbvdj
	 D4T5TgA0b6FL9G2VgmCOwpY3Rw4NSXDJm/kGmczSss/nNoyaRqn2eH8jhT9uBxTGY0
	 93tOt5RMrYj6A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 04/23] fast_dput(): handle underflows gracefully
Date: Mon, 22 Jan 2024 10:17:44 -0500
Message-ID: <20240122151823.997644-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 504e08cebe1d4e1efe25f915234f646e74a364a8 ]

If refcount is less than 1, we should just warn, unlock dentry and
return true, so that the caller doesn't try to do anything else.

Taking care of that leaves the rest of "lockref_put_return() has
failed" case equivalent to "decrement refcount and rejoin the
normal slow path after the point where we grab ->d_lock".

NOTE: lockref_put_return() is strictly a fastpath thing - unlike
the rest of lockref primitives, it does not contain a fallback.
Caller (and it looks like fast_dput() is the only legitimate one
in the entire kernel) has to do that itself.  Reasons for
lockref_put_return() failures:
	* ->d_lock held by somebody
	* refcount <= 0
	* ... or an architecture not supporting lockref use of
cmpxchg - sparc, anything non-SMP, config with spinlock debugging...

We could add a fallback, but it would be a clumsy API - we'd have
to distinguish between:
	(1) refcount > 1 - decremented, lock not held on return
	(2) refcount < 1 - left alone, probably no sense to hold the lock
	(3) refcount is 1, no cmphxcg - decremented, lock held on return
	(4) refcount is 1, cmphxcg supported - decremented, lock *NOT* held
	    on return.
We want to return with no lock held in case (4); that's the whole point of that
thing.  We very much do not want to have the fallback in case (3) return without
a lock, since the caller might have to retake it in that case.
So it wouldn't be more convenient than doing the fallback in the caller and
it would be very easy to screw up, especially since the test coverage would
suck - no way to test (3) and (4) on the same kernel build.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dcache.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1897833a4668..4d96eb591f5d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -727,12 +727,12 @@ static inline bool fast_dput(struct dentry *dentry)
 	 */
 	if (unlikely(ret < 0)) {
 		spin_lock(&dentry->d_lock);
-		if (dentry->d_lockref.count > 1) {
-			dentry->d_lockref.count--;
+		if (WARN_ON_ONCE(dentry->d_lockref.count <= 0)) {
 			spin_unlock(&dentry->d_lock);
 			return true;
 		}
-		return false;
+		dentry->d_lockref.count--;
+		goto locked;
 	}
 
 	/*
@@ -783,6 +783,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
+locked:
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
 		return true;
-- 
2.43.0


