Return-Path: <linux-fsdevel+bounces-60109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DA4B41404
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C94168A87
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F62DCF71;
	Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="StuCNvbx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70B2D7DE4
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875355; cv=none; b=tqGc9JBdlaLSEz8D2IgFBT0NB/ENvz0XkLqVdEjmKhKBultm/bYnsnht8bomsUUFnH4Kvo+oKxdftAfc4N1BtsPhKKK7Y7rpch9CLSueHx7TcyIo6FztXblZPHKbmOJFt8sdR6myU488zo1VD1WSXSBqKNrNsLmcGA1GAcCuxos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875355; c=relaxed/simple;
	bh=vEwUOOFT/p7YcjnV6G3prGzoNd1Ibqm9W3Ada9ny4Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pObyYSwNcVBRyx7cChvNrFO2CbvcTDjmwkWcc1AUAozsywPLfyQkANrgPoXdBo+NPN6FPJSS07yzgvMUxe0hXfmf/KDcn30vW21MTwAGY35Laa44QtW7JNKvlycM1kjoKQ8nvDZ9akG5fc4+sX2ejg2RD4cp3ioYklaHVWO4OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=StuCNvbx; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/DUW8bVbSDn/luPlzfK9AEMWGeEWgjN5Z1jNkwoA3Cw=; b=StuCNvbxqUO20YGzgjPmGL3iSL
	Fbyw7Kzc7TmAW3FP9dCyDVc91dk5k4oAJnv0bmIMlNyaI2VHoQK9BPgYFQ2ffYR4KQrKN856W20LM
	02hYtTNg7SnlfikaxGFuUznKeN9e8aHP5raDfe9QB5CEhiIBPBmpdFSVY3z9DawZawHKCr2qcnc4v
	drFmIyQJJW5w35WwaB+4lRMyGrlOaM9GJimu5ZG9HvY26eIMYYb8E6XDXgdxdFuaQJZSkSu9pfsuG
	sq7xNzrpiaaPqbIxhwOoS02viPG8nsl9GApz4uCPKKgDDOAiu2bdRDwBUQ5vKbBoZWLeaqW0T+qGB
	tb453Hng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXE-0000000ApJm-0srN;
	Wed, 03 Sep 2025 04:55:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 59/63] simplify the callers of mnt_unhold_writers()
Date: Wed,  3 Sep 2025 05:55:27 +0100
Message-ID: <20250903045537.2579614-66-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
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


