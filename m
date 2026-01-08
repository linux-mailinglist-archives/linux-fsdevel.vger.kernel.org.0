Return-Path: <linux-fsdevel+bounces-72697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7387D00797
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF9A83023D3D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48B1A23B6;
	Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZT2XRAa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AC21DF736;
	Thu,  8 Jan 2026 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832824; cv=none; b=aevyo/SOlg17vgwMi12rWhLF4MjRNz87PnCX27y7JR/1hIYQzB+kEkmmdhvn37z6Ss23/Y6muuz1JzHbeUwInzKs/s5DeJKQI8h0Rr0ExEvJFHOwomJRDY5O8fiTK6zbHyg8KUsfQ4zQ5xKcOUTQcpiH5CiXXmrOIaUNqhPdo8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832824; c=relaxed/simple;
	bh=FJR666ifPCTBMDk8QZYsLmkY8Mcbe8hRsomORSB+lgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vis6aAKrASomWLu/xv0Dt9c/3VNLd5EpBAfEZQGXKToVGPhPCbsjcOULvW5c5IJzC24ar4mOKmXUz5AS8l++MWfllPEZk0Y6nGDEr19D7IaGuMRl8qb9EPcdlxh5pXojcG65C84T4m2wgfEyS+ocxtMXQBW2CLCyM8frE7eoffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZT2XRAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49668C19421;
	Thu,  8 Jan 2026 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832823;
	bh=FJR666ifPCTBMDk8QZYsLmkY8Mcbe8hRsomORSB+lgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZT2XRAabD5l/cnLMCeywA5PwIR3K4oJ8cpHSOg/j85ebf/6oqk1lD5LZ0sb/oBL4
	 sx2z+bUnRDZmbf8qEI1M/TlXB29+4Ookb6l8KP+IvsmCebOG+EGjMfOnUAto9CRujM
	 bzvbQqMbgoJnWDoRI795nyCURQJmsEYuLlpzzt1ln5qHHBttqY7fXnTlPgUtG8coOY
	 9pvVGecYEyydc1EDVgZjOZtVfWqyH4i6v0Pa4XHGFtqeQzpFl9+Oznzsqg1y44n4jQ
	 bP4nk4PJEIflvqVAhTe/V8bunlIt9xqflCaonDiyLFFPba+mRgCURlyUukg6ro9hUY
	 iQtUzHZFlz/hg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 3/6] fs: add pin_insert_sb() for superblock-only pins
Date: Wed,  7 Jan 2026 19:40:13 -0500
Message-ID: <20260108004016.3907158-4-cel@kernel.org>
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

The fs_pin mechanism notifies interested subsystems when a filesystem
is remounted read-only or unmounted. Currently, BSD process accounting
uses this to halt accounting when the target filesystem goes away.
Registered pins receive callbacks from both group_pin_kill() (during
remount read-only) and mnt_pin_kill() (during mount teardown).

NFSD maintains NFSv4 client state associated with the superblocks
of exported filesystems. Revoking this state during unmount requires
lock ordering that conflicts with mnt_pin_kill() context:
mnt_pin_kill() runs during cleanup_mnt() with namespace locks held,
but NFSD's state revocation path acquires these same locks for mount
table lookups, creating AB-BA deadlock potential.

Add pin_insert_sb() to register pins on the superblock's s_pins
list only. Pins registered this way do not receive mnt_pin_kill()
callbacks during mount teardown.

After pin insertion, checking SB_ACTIVE detects racing unmounts.
When the superblock remains active, normal unmount cleanup occurs
through the subsystem's own shutdown path (outside the problematic
locking context) without pin callbacks.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fs_pin.c            | 29 +++++++++++++++++++++++++++++
 include/linux/fs_pin.h |  1 +
 2 files changed, 30 insertions(+)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 972f34558b97..7204b4a5891f 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -48,6 +48,35 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 }
 EXPORT_SYMBOL_GPL(pin_insert);
 
+/**
+ * pin_insert_sb - register an fs_pin on the superblock only
+ * @pin: the pin to register (must be initialized with init_fs_pin())
+ * @m: the vfsmount whose superblock to monitor
+ *
+ * Registers @pin on the superblock's s_pins list only. Callbacks arrive
+ * only from group_pin_kill() (invoked during remount read-only), not
+ * from mnt_pin_kill() (invoked during mount namespace teardown).
+ *
+ * Use this instead of pin_insert() when mnt_pin_kill() callbacks would
+ * execute in problematic locking contexts. Because mnt_pin_kill() runs
+ * during cleanup_mnt(), callbacks cannot acquire locks also taken during
+ * mount table operations without risking AB-BA deadlock.
+ *
+ * After insertion, check SB_ACTIVE to detect racing unmounts. If clear,
+ * call pin_remove() and abort. Normal unmount cleanup then occurs through
+ * subsystem-specific shutdown paths without pin callback involvement.
+ *
+ * The callback must call pin_remove() before returning. Callbacks execute
+ * with the RCU read lock held.
+ */
+void pin_insert_sb(struct fs_pin *pin, struct vfsmount *m)
+{
+	spin_lock(&pin_lock);
+	hlist_add_head(&pin->s_list, &m->mnt_sb->s_pins);
+	spin_unlock(&pin_lock);
+}
+EXPORT_SYMBOL_GPL(pin_insert_sb);
+
 void pin_kill(struct fs_pin *p)
 {
 	wait_queue_entry_t wait;
diff --git a/include/linux/fs_pin.h b/include/linux/fs_pin.h
index bdd09fd2520c..24c55329b15f 100644
--- a/include/linux/fs_pin.h
+++ b/include/linux/fs_pin.h
@@ -21,4 +21,5 @@ static inline void init_fs_pin(struct fs_pin *p, void (*kill)(struct fs_pin *))
 
 void pin_remove(struct fs_pin *);
 void pin_insert(struct fs_pin *, struct vfsmount *);
+void pin_insert_sb(struct fs_pin *, struct vfsmount *);
 void pin_kill(struct fs_pin *);
-- 
2.52.0


