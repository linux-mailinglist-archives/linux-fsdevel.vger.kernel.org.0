Return-Path: <linux-fsdevel+bounces-24901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363FD94654F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9DE828393B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757913D8B2;
	Fri,  2 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGv1WaCx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4B13D504;
	Fri,  2 Aug 2024 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635125; cv=none; b=A0dRF2cHoqPf9XkIEInNwIz3JSMw3ToRefuiQWlOBL6BnJlyxLDTLnlt3GWD8BS0eqTzvLnl59jQKDxZbeYZtRlUTQ+v0Gdbpd4WHIErrhiQMIKuQtBrGCz9NmYk312Z57kF+kmA5v7Y94kNElzg7ZLDA95ABQRZcna82FcAqWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635125; c=relaxed/simple;
	bh=9E9fR9YI/6HM/keRPtqoAkea05ZS6v/bw14Wsy6B4E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VGjCidROfqIK7/X3cjHNxvcF6rGxaek8QPd2d/nxkyESCNeYmtI8DFh3idUzYGRTdXxq6JENqRXcJEVLLSpBmDOQtAcUWnHRFy9qciKkdn08dDA4Wfzm45kRBpVd6J4yr0sL5C/Pdauq81PNILBG9Kks9t7xA1WkZ+i/9E++BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGv1WaCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803AEC4AF10;
	Fri,  2 Aug 2024 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635125;
	bh=9E9fR9YI/6HM/keRPtqoAkea05ZS6v/bw14Wsy6B4E4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MGv1WaCxaf2gT1lRVaz6IRpZZutNCuP4mM9VIqT4aPtGILTlcPt/hl7rmIyipx4lD
	 7tfLldpBfZtFg6jI0Xbr/nCbwPTiKVUWxkfzvqfKQC5PueRc9t9KIojjzTpQT4FF1N
	 hN5J2DpHZAHZbk9vdb0xoLe9YlBH0CGw8ctFviZrGF2LnVODPgKEIknnqWcDFMoTxe
	 Bqj9wzWA7JkmGGUASKynfrmpmSUnAMw1itpzwJICP+q8MyQYMxEEZrZD8/lUI3f0lU
	 ZHznyM/QlmVGZNuXmiNnQlD1hBu7CsK6HaP0nqy0oj679rhb52WVUNtAIAzgPw0p9a
	 6QgMf3d8Wd9zA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 02 Aug 2024 17:45:04 -0400
Subject: [PATCH RFC 3/4] lockref: rework CMPXCHG_LOOP to handle contention
 better
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-openfast-v1-3-a1cff2a33063@kernel.org>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
In-Reply-To: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5030; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=9E9fR9YI/6HM/keRPtqoAkea05ZS6v/bw14Wsy6B4E4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmrVNx4uFmosPNS1siz4exI/ZfMzFBWC3I64yDO
 gPHgx9OtnuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZq1TcQAKCRAADmhBGVaC
 FQJOEADPeMaaFdNdsEzwQU3XPKWqf1DE8A7TajeLSe+KhYbKV2o40Q6AHMOQ+R2FMF01H9T2DFD
 HgeffqIomj0W8mUODdbWRd2zvtSP5bc2ofG1nZ4s7gHnde9zZL6hDe/arIJ821uGKVkzpnxd4Tp
 TpWZI5cqLM7tBHWoIYtdGQ1Xk4uEDh6JlegJdXJQ1EcDI08IhYflyCCwneFDQhDvZblB1fwCMcB
 /oqaPNMEWo43ilvy6u21JJwceDhC+zQoOA1AysMhtuedlFjuicXQ1DKREAKsiBWtbI2ExWGXNGn
 yYPm9PYp2YgVP3MZeTWsvdguv2BwzWs3d+jdKvBHcGN9fCPuBV23yrF3uS8hRgcJYPg2nY2+oxH
 JYeAcUZYk6DxvkC48tg9CQDEufEK1OojN9wVYiWjlDhzlVZHOgbjsDpENvu1vJryKahKYCWjkZy
 YrAQjI+VAaZlyyZnXEbexo0QoFyerTAexxxlsQ5fafSfg8DO/7odYfL6oXKnFn4nSvKXkqJJnNQ
 ngugncp060mBTJBBPgY3KDUwv4o70XNMLAzlMS2ktYMArCmuMTT4J2wk0WsnktRqDlhpI6NM4iJ
 nRMWB9yu2v8Mxl82MTEDd8g8rh5y3hbDcmIeH3i9UtUZ0in/eULfC/oEJXvLlcRa4DMMs9P8LVQ
 wShaph306be5EWg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

In a later patch, we want to change the open(..., O_CREAT) codepath to
avoid taking the inode->i_rwsem for write when the dentry already exists.
When we tested that initially, the performance devolved significantly
due to contention for the parent's d_lockref spinlock.

There are two problems with lockrefs today: First, once any concurrent
task takes the spinlock, they all end up taking the spinlock, which is
much more costly than a single cmpxchg operation. The second problem is
that once any task fails to cmpxchg 100 times, it falls back to the
spinlock. The upshot there is that even moderate contention can cause a
fallback to serialized spinlocking, which worsens performance.

This patch changes CMPXCHG_LOOP in 2 ways:

First, change the loop to spin instead of falling back to a locked
codepath when the spinlock is held. Once the lock is released, allow the
task to continue trying its cmpxchg loop as before instead of taking the
lock. Second, don't allow the cmpxchg loop to give up after 100 retries.
Just continue infinitely.

This greatly reduces contention on the lockref when there are large
numbers of concurrent increments and decrements occurring.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 lib/lockref.c | 85 ++++++++++++++++++++++-------------------------------------
 1 file changed, 32 insertions(+), 53 deletions(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index 2afe4c5d8919..b76941043fe9 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -8,22 +8,25 @@
  * Note that the "cmpxchg()" reloads the "old" value for the
  * failure case.
  */
-#define CMPXCHG_LOOP(CODE, SUCCESS) do {					\
-	int retry = 100;							\
-	struct lockref old;							\
-	BUILD_BUG_ON(sizeof(old) != 8);						\
-	old.lock_count = READ_ONCE(lockref->lock_count);			\
-	while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {  	\
-		struct lockref new = old;					\
-		CODE								\
-		if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
-						 &old.lock_count,		\
-						 new.lock_count))) {		\
-			SUCCESS;						\
-		}								\
-		if (!--retry)							\
-			break;							\
-	}									\
+#define CMPXCHG_LOOP(CODE, SUCCESS) do {						\
+	struct lockref old;								\
+	BUILD_BUG_ON(sizeof(old) != 8);							\
+	old.lock_count = READ_ONCE(lockref->lock_count);				\
+	for (;;) {									\
+		struct lockref new = old;						\
+											\
+		if (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {	\
+			CODE								\
+			if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,		\
+							 &old.lock_count,		\
+							 new.lock_count))) {		\
+				SUCCESS;						\
+			}								\
+		} else {								\
+			cpu_relax();							\
+			old.lock_count = READ_ONCE(lockref->lock_count);		\
+		}									\
+	}										\
 } while (0)
 
 #else
@@ -46,10 +49,8 @@ void lockref_get(struct lockref *lockref)
 	,
 		return;
 	);
-
-	spin_lock(&lockref->lock);
-	lockref->count++;
-	spin_unlock(&lockref->lock);
+	/* should never get here */
+	WARN_ON_ONCE(1);
 }
 EXPORT_SYMBOL(lockref_get);
 
@@ -60,8 +61,6 @@ EXPORT_SYMBOL(lockref_get);
  */
 int lockref_get_not_zero(struct lockref *lockref)
 {
-	int retval;
-
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count <= 0)
@@ -69,15 +68,9 @@ int lockref_get_not_zero(struct lockref *lockref)
 	,
 		return 1;
 	);
-
-	spin_lock(&lockref->lock);
-	retval = 0;
-	if (lockref->count > 0) {
-		lockref->count++;
-		retval = 1;
-	}
-	spin_unlock(&lockref->lock);
-	return retval;
+	/* should never get here */
+	WARN_ON_ONCE(1);
+	return -1;
 }
 EXPORT_SYMBOL(lockref_get_not_zero);
 
@@ -88,8 +81,6 @@ EXPORT_SYMBOL(lockref_get_not_zero);
  */
 int lockref_put_not_zero(struct lockref *lockref)
 {
-	int retval;
-
 	CMPXCHG_LOOP(
 		new.count--;
 		if (old.count <= 1)
@@ -97,15 +88,9 @@ int lockref_put_not_zero(struct lockref *lockref)
 	,
 		return 1;
 	);
-
-	spin_lock(&lockref->lock);
-	retval = 0;
-	if (lockref->count > 1) {
-		lockref->count--;
-		retval = 1;
-	}
-	spin_unlock(&lockref->lock);
-	return retval;
+	/* should never get here */
+	WARN_ON_ONCE(1);
+	return -1;
 }
 EXPORT_SYMBOL(lockref_put_not_zero);
 
@@ -125,6 +110,8 @@ int lockref_put_return(struct lockref *lockref)
 	,
 		return new.count;
 	);
+	/* should never get here */
+	WARN_ON_ONCE(1);
 	return -1;
 }
 EXPORT_SYMBOL(lockref_put_return);
@@ -171,8 +158,6 @@ EXPORT_SYMBOL(lockref_mark_dead);
  */
 int lockref_get_not_dead(struct lockref *lockref)
 {
-	int retval;
-
 	CMPXCHG_LOOP(
 		new.count++;
 		if (old.count < 0)
@@ -180,14 +165,8 @@ int lockref_get_not_dead(struct lockref *lockref)
 	,
 		return 1;
 	);
-
-	spin_lock(&lockref->lock);
-	retval = 0;
-	if (lockref->count >= 0) {
-		lockref->count++;
-		retval = 1;
-	}
-	spin_unlock(&lockref->lock);
-	return retval;
+	/* should never get here */
+	WARN_ON_ONCE(1);
+	return -1;
 }
 EXPORT_SYMBOL(lockref_get_not_dead);

-- 
2.45.2


