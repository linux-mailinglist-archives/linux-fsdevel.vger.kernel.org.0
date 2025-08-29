Return-Path: <linux-fsdevel+bounces-59610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0645EB3B2EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 08:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1026568138
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 06:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF63221F15;
	Fri, 29 Aug 2025 06:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="RVgzhU+h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9271F4634
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 06:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447480; cv=none; b=EH7uc6sdTWOVBJddnQ1HDke7+7R3JvAnN7MKdKQ+MnSpv+2z+497Xa04T8Y/HBbuwhPYUUDoE+1aOQbBapPbGYFmimKskcDyBJC6vsUtRQT5XBOz/ZfFG5KIYdPTnIVKokWu8UO+YX4tZQ7UUXcK1AIj7/0rZGfNy+Nq38j9EGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447480; c=relaxed/simple;
	bh=vEwUOOFT/p7YcjnV6G3prGzoNd1Ibqm9W3Ada9ny4Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Goohw3g1H+CCKoQQHi8Yk9FO2e/gs6tPatW+wMoUO0TLQQ372c8nrAP4J9nD/TiB++vjxNh+yCFunbS9aG93GRK0EmibjL6h5fLLaH2nlQdDw8NjhrxdlwyVboA8jCOrN0u2EioHKN1a4WgHhNxpMaigBENRNH8B3ViXS8Au6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=RVgzhU+h; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/DUW8bVbSDn/luPlzfK9AEMWGeEWgjN5Z1jNkwoA3Cw=; b=RVgzhU+hJHXuuApNnCVPVal8a2
	2GZC7n54zavnx5qaZjA+RiqPv4Tz1jWX/ZW/IwRLiAp5DUk1y90XBHsuuyRWqR2kikuULuZUuWRGA
	bEBBCiOSoETYGOO7BzE9OgmWA12IwiMnBSJGsP9+tjdTs5Pz//DzbLS+o6K3JNL6Xak/h55XbrZyT
	GrpGjET8iSeU61PT4H/VGxX+Jl12VnRfdmFJG7QfEFVDLLkKruIr2hqPnKyJ42jbbnQmWADXtTeHs
	W5WGxCjbWa2Eem2LPCUAbRUr4fZJ544Ao2oX0NT2oxvP7230AbemEMagxwBrj93wWkjn/teZDmdXZ
	2ABdYpjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ursE0-00000002n0f-1htV;
	Fri, 29 Aug 2025 06:04:36 +0000
Date: Fri, 29 Aug 2025 07:04:36 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: [59/63] simplify the callers of mnt_unhold_writers()
Message-ID: <20250829060436.GA659926@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
 <20250829001109.GB39973@ZenIV>
 <CAHk-=wg+wHJ6G0hF75tqM4e951rm7v3-B5E4G=ctK0auib-Auw@mail.gmail.com>
 <20250829060306.GC39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829060306.GC39973@ZenIV>
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
index 9e16231d4561..d8df1046e2f9 100644
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
+	if (!(mnt->mnt_flags & MNT_WRITE_HOLD))
+		return;
 	/*
 	 * MNT_READONLY must become visible before ~MNT_WRITE_HOLD, so writers
 	 * that become unheld will see MNT_READONLY.
@@ -4773,8 +4774,10 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 
 		if (!mnt_allow_writers(kattr, m)) {
 			err = mnt_hold_writers(m);
-			if (err)
+			if (err) {
+				m = next_mnt(m, mnt);
 				break;
+			}
 		}
 
 		if (!(kattr->kflags & MOUNT_KATTR_RECURSE))
@@ -4782,25 +4785,9 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 	}
 
 	if (err) {
-		struct mount *p;
-
-		/*
-		 * If we had to call mnt_hold_writers() MNT_WRITE_HOLD will
-		 * be set in @mnt_flags. The loop unsets MNT_WRITE_HOLD for all
-		 * mounts and needs to take care to include the first mount.
-		 */
-		for (p = mnt; p; p = next_mnt(p, mnt)) {
-			/* If we had to hold writers unblock them. */
-			if (p->mnt.mnt_flags & MNT_WRITE_HOLD)
-				mnt_unhold_writers(p);
-
-			/*
-			 * We're done once the first mount we changed got
-			 * MNT_WRITE_HOLD unset.
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
@@ -4831,8 +4818,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 		WRITE_ONCE(m->mnt.mnt_flags, flags);
 
 		/* If we had to hold writers unblock them. */
-		if (m->mnt.mnt_flags & MNT_WRITE_HOLD)
-			mnt_unhold_writers(m);
+		mnt_unhold_writers(m);
 
 		if (kattr->propagation)
 			change_mnt_propagation(m, kattr->propagation);
-- 
2.47.2


