Return-Path: <linux-fsdevel+bounces-59591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A45B3AE3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117A6189BA85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7EC13002DC;
	Thu, 28 Aug 2025 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WG9estF8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA12FB99B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422500; cv=none; b=m7XJzFaH66BZUdqwc5U5LK3Jeg1oUXwstp7tfl3kSMn5JSq9obWJD9VOppVUvfBaoiDV4/ZX/dX4iRg1/t23tiyS6Cpm9J6IEgjUipIm9XL8nRE8zILIUctsVzmDYo6ejlLlum8Vi9OyeIYMn0LX/g1xSYdtMM/pIkMLJSS4fd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422500; c=relaxed/simple;
	bh=OUNvqriYm3jLExAznfg6EXDjLh6RKV6Ote5tIWorekE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmBsest3QcRWQGCfh+aFgi+RoHWZW09xdao4Utp4KGNTJnhMzAdPM3bdLSkm8T/vvfM/0VV6p2OiXufQ4tNIJdUzpnIZK6oWyrSuqN3+JgiTn/Mv1YKqngal+4c6xAC7jRO9NuGIP59kD7rRL/TtiH26hwueM5zI2WboJOxvXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WG9estF8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=HiCW+skO3+x7nLRIB3URti1YcVAa6Xt6m4FnjfZq6Wc=; b=WG9estF8TJbBWjJci+TWfZmPrj
	FVktZcUBscavL6lHoChC1mXzYLJeBVbiGBjVi1XwE1ci/UFCDPxzTgkqUN51n6R5o3ssbPCGseqq7
	k4rtVMQC2IUHO/j2Ie8qf0TTmbckw9FofkXoIT6reBiarRgDGYzd1Qooy03imMBjAcv7+oKYzYlHD
	5jWx6OifRnsHUKRk4w8JxdTzagUKbQOOD052F6QLStfMdsci5U+Mxfc2GBz6f3DI5GoFQPeq1NCHE
	rF9KaoaMH0dQC4NwyXN5unl4JN7mfu+M2s1yCEMrmGEwFdPLCqsOggse5U/bscZvGlbQMg0k2Mdxz
	6QEDLfQQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj6-0000000F2C0-2dWK;
	Thu, 28 Aug 2025 23:08:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 62/63] simplify the callers of mnt_unhold_writers()
Date: Fri, 29 Aug 2025 00:08:05 +0100
Message-ID: <20250828230806.3582485-62-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

The logics in cleanup on failure in mount_setattr_prepare() is simplified
by having the mnt_hold_writers() failure followed by advancing m to the
next node in the tree before leaving the loop.

And since all calls are preceded by the same check that flag has been set
and the function is inlined, let's just shift the check into it.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f9c9c69a815b..6b439e5e5a27 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -714,13 +714,14 @@ static inline int mnt_hold_writers(struct mount *mnt)
  * Stop preventing write access to @mnt allowing callers to gain write access
  * to @mnt again.
  *
- * This function can only be called after a successful call to
- * mnt_hold_writers().
+ * This function can only be called after a call to mnt_hold_writers().
  *
  * Context: This function expects lock_mount_hash() to be held.
  */
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
+	if (!(mnt->mnt_pprev_for_sb & WRITE_HOLD))
+		return;
 	/*
 	 * MNT_READONLY must become visible before ~WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
@@ -4793,8 +4794,10 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 
 		if (!mnt_allow_writers(kattr, m)) {
 			err = mnt_hold_writers(m);
-			if (err)
+			if (err) {
+				m = next_mnt(m, mnt);
 				break;
+			}
 		}
 
 		if (!(kattr->kflags & MOUNT_KATTR_RECURSE))
@@ -4802,25 +4805,9 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 	}
 
 	if (err) {
-		struct mount *p;
-
-		/*
-		 * If we had to call mnt_hold_writers() WRITE_HOLD will
-		 * be set in @mnt_flags. The loop unsets WRITE_HOLD for all
-		 * mounts and needs to take care to include the first mount.
-		 */
-		for (p = mnt; p; p = next_mnt(p, mnt)) {
-			/* If we had to hold writers unblock them. */
-			if (p->mnt_pprev_for_sb & WRITE_HOLD)
-				mnt_unhold_writers(p);
-
-			/*
-			 * We're done once the first mount we changed got
-			 * WRITE_HOLD unset.
-			 */
-			if (p == m)
-				break;
-		}
+		/* undo all mnt_hold_writers() we'd done */
+		for (struct mount *p = mnt; p != m; p = next_mnt(p, mnt))
+			mnt_unhold_writers(p);
 	}
 	return err;
 }
@@ -4851,8 +4838,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 		WRITE_ONCE(m->mnt.mnt_flags, flags);
 
 		/* If we had to hold writers unblock them. */
-		if (mnt->mnt_pprev_for_sb & WRITE_HOLD)
-			mnt_unhold_writers(m);
+		mnt_unhold_writers(m);
 
 		if (kattr->propagation)
 			change_mnt_propagation(m, kattr->propagation);
-- 
2.47.2


