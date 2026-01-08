Return-Path: <linux-fsdevel+bounces-72698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C3DD007AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD0D9303C80A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D4F1E412A;
	Thu,  8 Jan 2026 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C3mtD6nw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC11C3C1F;
	Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832825; cv=none; b=XAV6QkrIhFpxK/fM7SEAHgmzo0ivb0TEqTnvSlMCXirVMApQhJrQOGF+VOQ6btPawsaJh0VrSEOfmmsuj8JYpZIlKOQPtcOjitcX54o/ExZKMjf/65saUgSQkgi11o5C1aWtLydN8fLDlhTRdqNsZOBkf/Mx5FoHDIGpJXu2BO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832825; c=relaxed/simple;
	bh=Q1f539GxBWhIir3xKKGHom58SYir/qhm7LuwaYyXcOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qw38t+25ABDHpkn6Deu0vCyR8XUhlWNQUANRU3YNr/tAAfaLcUads04z2pa2e5xQda4axi/CTrGIFblLaJgutNVnaGdzOoXE8vFnIVG4p2EK/SpS8ta76MqnSzfN0LgyK2qzK8KYMQezA7PTBQpQ/SW39tgfLvGC2OswxECGZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C3mtD6nw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0EAC19422;
	Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832824;
	bh=Q1f539GxBWhIir3xKKGHom58SYir/qhm7LuwaYyXcOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C3mtD6nw3mVPfp3UywQ8hCgr60M/1qy6AKHRjxaPftxu6SfJZgRr4D4LRDmBl4erh
	 gIMK5IBSg4Bdh88vA6gbUE5+k8R/R9kZ+mG6Hs5TQTiLtaWblvIvibTPQM+6DMvzp2
	 3vjOYyK93NNyW55SwFMxa1J79BBev9l8+IHUp04XNPPnGx26C+DuWh+qL9dbQ/sKQQ
	 0FtBxuHe4KAObMUXVXB6OOdptIpKEqZdRJ1yT6R2RP/g6ZoAcLBCVnytYq3VH/TqfH
	 rXtxPorZhaQTXhXvYCHSiASnVfxTdL9OHRlcSktn+6/1m7LtqPgClqyKyt2Yal1+0C
	 SqSTSIP9r9Zwg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/6] fs: invoke group_pin_kill() during mount teardown
Date: Wed,  7 Jan 2026 19:40:14 -0500
Message-ID: <20260108004016.3907158-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108004016.3907158-1-cel@kernel.org>
References: <20260108004016.3907158-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The group_pin_kill() function iterates the superblock's s_pins list
and invokes each pin's kill callback. Previously, this function was
called only during remount read-only (in reconfigure_super).

Add a group_pin_kill() call in cleanup_mnt() so that pins registered
via pin_insert_sb() receive callbacks during mount teardown as
well. This call runs after mnt_pin_kill() processes the per-mount
m_list, ensuring:

 - Pins registered via pin_insert() receive their callback from
   mnt_pin_kill() (which also removes them from s_list via
   pin_remove()), so group_pin_kill() skips them.

 - Pins registered via pin_insert_sb() are only on s_list, so
   mnt_pin_kill() skips them and group_pin_kill() invokes their
   callback.

This enables subsystems to use pin_insert_sb() for receiving
unmount notifications while avoiding any problematic locking context
that mnt_pin_kill() callbacks must handle.

Because group_pin_kill() operates on the superblock's s_pins list,
unmounting any mount of a filesystem--including bind mounts--triggers
callbacks for all pins registered on that superblock. For NFSD, this
means unmounting an exported bind mount revokes NFSv4 state for the
entire filesystem, even if other mounts remain.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fs_pin.c    | 14 +++++++-------
 fs/namespace.c |  2 ++
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 7204b4a5891f..54c1163a9cde 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -54,17 +54,17 @@ EXPORT_SYMBOL_GPL(pin_insert);
  * @m: the vfsmount whose superblock to monitor
  *
  * Registers @pin on the superblock's s_pins list only. Callbacks arrive
- * only from group_pin_kill() (invoked during remount read-only), not
- * from mnt_pin_kill() (invoked during mount namespace teardown).
+ * from group_pin_kill(), invoked during both remount read-only and mount
+ * teardown. Unlike pin_insert(), the pin is not added to the per-mount
+ * mnt_pins list, so mnt_pin_kill() does not invoke the callback.
  *
  * Use this instead of pin_insert() when mnt_pin_kill() callbacks would
- * execute in problematic locking contexts. Because mnt_pin_kill() runs
- * during cleanup_mnt(), callbacks cannot acquire locks also taken during
- * mount table operations without risking AB-BA deadlock.
+ * execute in problematic locking contexts. Callbacks registered via this
+ * function run from group_pin_kill() instead, which may execute under
+ * different locking conditions.
  *
  * After insertion, check SB_ACTIVE to detect racing unmounts. If clear,
- * call pin_remove() and abort. Normal unmount cleanup then occurs through
- * subsystem-specific shutdown paths without pin callback involvement.
+ * call pin_remove() and abort.
  *
  * The callback must call pin_remove() before returning. Callbacks execute
  * with the RCU read lock held.
diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..a887d45636f5 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1309,6 +1309,8 @@ static void cleanup_mnt(struct mount *mnt)
 	WARN_ON(mnt_get_writers(mnt));
 	if (unlikely(mnt->mnt_pins.first))
 		mnt_pin_kill(mnt);
+	if (unlikely(!hlist_empty(&mnt->mnt.mnt_sb->s_pins)))
+		group_pin_kill(&mnt->mnt.mnt_sb->s_pins);
 	hlist_for_each_entry_safe(m, p, &mnt->mnt_stuck_children, mnt_umount) {
 		hlist_del(&m->mnt_umount);
 		mntput(&m->mnt);
-- 
2.52.0


