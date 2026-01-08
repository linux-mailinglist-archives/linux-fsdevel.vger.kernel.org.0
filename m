Return-Path: <linux-fsdevel+bounces-72696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B98D007A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 01:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B91F5302FA26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678D1DF25F;
	Thu,  8 Jan 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpkLMg67"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC681D88AC;
	Thu,  8 Jan 2026 00:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767832823; cv=none; b=FC6b61U3k1QlSxOIt/uDd40HnwQviAocXQGmbo175SUrbByzFe+nHrtTb/AFun4dQomoHzE/qwdUtTn87AhLv5D1kSgXlHC0OCLSjKOFsMAvpvaYN1Bhabv1ieH7R7IGsXmIfsRBnMlC+jgQQl2p53YcmH+ktIRN/bpj+OaJBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767832823; c=relaxed/simple;
	bh=ufX26wPcT9h8u+917a2WeyPNlD+S3MRAy3DvI7S8pjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxctK9U5ydlejroXwLB0BoTcz9oaYb3uxnVu+5kesAz4VV8OLlL9UXq/oP+k0GLTaeNoONPQMB/0ev9dq/BkhxwYkuM5Rgy+nCCIuvSmXjK+FUjLOfGfo6lid43hN0pt5a9Gd7yOv30F2Q8mVBWi5D9E7sQp4v09aOBB/joi2JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpkLMg67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5743FC19422;
	Thu,  8 Jan 2026 00:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767832823;
	bh=ufX26wPcT9h8u+917a2WeyPNlD+S3MRAy3DvI7S8pjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tpkLMg67u/m3m+PxVAvAwnfTeFKXdtI8bZcHTGlqT6jDUayXDNNwTUHcjg1Zd51jO
	 K/skWDrS8yhVh3XZ+Ym9a4jURkdCElgWpeafWYgwyhuo1yUoxRW2PtZYWqDBiRNPTU
	 MG9zVU6NJjlgPSy04Q9Xaabm/KRB8SL2meUhlLo6rseZY1W7EoodLLagtfm0swHcZP
	 BDl6FxFR423uuvdLOObToqk5zZHTD2Cl7+kXM/lJj4KC+utkpwsyJ+mfRi65vyjhho
	 wjHimNzyBN5Z6wyeV0zM8/HJ16aTFZbQ0ghipA6KtaLwv9UoDo7Sx1SGtN/V0R097l
	 EUfCTDU7iVZtg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 2/6] fs: export pin_insert and pin_remove for modular filesystems
Date: Wed,  7 Jan 2026 19:40:12 -0500
Message-ID: <20260108004016.3907158-3-cel@kernel.org>
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

Modular filesystems currently have no notification mechanism for
mount teardown. When an NFS export is unexported then unmounted,
NFSD cannot detect this event to revoke associated state, state
which holds open file references that pin the mount.

The existing fs_pin infrastructure provides unmount callbacks, but
pin_insert() and pin_remove() lack EXPORT_SYMBOL_GPL(), restricting
this facility to built-in subsystems. This restriction appears
historical rather than intentional; fs_pin.h is already a public
header, and the mechanism's purpose (coordinating mount lifetimes
with filesystem state) applies equally to modular subsystems.

Export both symbols with EXPORT_SYMBOL_GPL() to permit modular
filesystems to register fs_pin callbacks. NFSD requires this to
revoke NFSv4 delegations, layouts, and open state when the
underlying filesystem is unmounted, preventing use-after-free
conditions in the state tracking layer.

Reviewed-by: NeilBrown <neil@brown.name>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/fs_pin.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/fs/fs_pin.c b/fs/fs_pin.c
index 47ef3c71ce90..972f34558b97 100644
--- a/fs/fs_pin.c
+++ b/fs/fs_pin.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <linux/export.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
@@ -7,6 +8,15 @@
 
 static DEFINE_SPINLOCK(pin_lock);
 
+/**
+ * pin_remove - detach an fs_pin from its mount and superblock
+ * @pin: the pin to remove
+ *
+ * Removes @pin from the mount and superblock pin lists and marks it
+ * done. Must be called from the pin's kill callback before returning.
+ * The caller must keep @pin valid until this function returns; after
+ * that, VFS will not reference @pin again.
+ */
 void pin_remove(struct fs_pin *pin)
 {
 	spin_lock(&pin_lock);
@@ -18,7 +28,17 @@ void pin_remove(struct fs_pin *pin)
 	wake_up_locked(&pin->wait);
 	spin_unlock_irq(&pin->wait.lock);
 }
+EXPORT_SYMBOL_GPL(pin_remove);
 
+/**
+ * pin_insert - register an fs_pin for unmount notification
+ * @pin: the pin to register (must be initialized with init_fs_pin())
+ * @m: the vfsmount to monitor
+ *
+ * Registers @pin to receive notification when @m is unmounted. When
+ * unmount occurs, the pin's kill callback is invoked with the RCU
+ * read lock held. The callback must call pin_remove() before returning.
+ */
 void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 {
 	spin_lock(&pin_lock);
@@ -26,6 +46,7 @@ void pin_insert(struct fs_pin *pin, struct vfsmount *m)
 	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
 	spin_unlock(&pin_lock);
 }
+EXPORT_SYMBOL_GPL(pin_insert);
 
 void pin_kill(struct fs_pin *p)
 {
-- 
2.52.0


