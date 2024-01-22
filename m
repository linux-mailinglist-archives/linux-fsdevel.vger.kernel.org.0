Return-Path: <linux-fsdevel+bounces-8444-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789978369F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 17:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BAAF1F2590F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jan 2024 16:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A34712F5BA;
	Mon, 22 Jan 2024 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foA8sehM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206112F5A8;
	Mon, 22 Jan 2024 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936396; cv=none; b=gvic44bOc2jqvrD+9r/C/FL5SNN9PN8PSAJ3hWABveC7rJgk4HUTnT3QsZHnxI1sWFEn3hkXZYlkBL+VUs7FZuEErNuXczkOzz9T58X/noQv01asM+N4w/o6v8YxJXKQzbj0FEtAybghYVo0UIXiSpEI6n2lqr7Vxz41jG100rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936396; c=relaxed/simple;
	bh=Z1WXDcDy73sgWFiRjFk8n/YIWxWnWBcmlLF83yFybvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZxo+vOakAfSWOBvEZVGoZXAG/LmopXnNVJlM6Sdksc8neRbyTcSs4g7F/WYPjMFi8RIIlbQlaJW69L1LzcvsmNiFSTvWw1YLm03uVVWy1u8IRj9nx5rDxwoyY0IT42OBb+yaLrG3g3xBR+K7Y9bjEKaPRj2JXOKcReOvtNquhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foA8sehM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD97FC43390;
	Mon, 22 Jan 2024 15:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936395;
	bh=Z1WXDcDy73sgWFiRjFk8n/YIWxWnWBcmlLF83yFybvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=foA8sehMtBLUflL8CmU4M9zpKHunJtNMwBcqfHmNooKBUmChYPkkO2zvnMiKgn+MV
	 IcTKcQeRCeErshwGh/z7AbwJtF7vC107XjTSn9hkpym+wmJp8Xku+TveeDgaiqRkKp
	 HyaB7CCCo9c9qVR1u8aq8pHIQYnpxLJCTuBPzwN6ZwaoBgDMcBCEzvccuQLtavGUSj
	 CT0jNyAi+py+UdYvf990d7Y7y6zOt1NqsJCIR2+HnFaxOF0ofPHxfwsFvgD73kUT0r
	 7WbkKDQJLfJNrz+dSXhFuW434VN4JqsYD4m16IA79iqQs/eHxSk3Dp4EO5YNOrHHyP
	 X01sB3HpZSp0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/35] fast_dput(): handle underflows gracefully
Date: Mon, 22 Jan 2024 10:12:02 -0500
Message-ID: <20240122151302.995456-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index cf871a81f4fd..422c440b492a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -762,12 +762,12 @@ static inline bool fast_dput(struct dentry *dentry)
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
@@ -825,6 +825,7 @@ static inline bool fast_dput(struct dentry *dentry)
 	 * else could have killed it and marked it dead. Either way, we
 	 * don't need to do anything else.
 	 */
+locked:
 	if (dentry->d_lockref.count) {
 		spin_unlock(&dentry->d_lock);
 		return true;
-- 
2.43.0


