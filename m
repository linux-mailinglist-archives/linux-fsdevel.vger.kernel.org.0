Return-Path: <linux-fsdevel+bounces-59556-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D599B3AE11
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6C5838ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209382F0C7E;
	Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Cn8h8Qv9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8612D0C7B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=t0eYMnkVzM/rIz02VIoK02ng8zcoBEc6bmZMyozNZTWnLBKOZIVKcjPo5ODrqwe3PMUN6667tGr+HhoD1vqYuSkJRVkLq7as8jC2ZCkNW3NrstdsH+UZmrEGj4QLkez3CuamH9xxwz5RhhxVnsfwtoOogcSkvSqhyWEY82fd7dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=NB9TuKdhZkW45GLoScYcrHUUjbqPbB0kYiTyDiyyTIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYhCszMsC8Q4PDGMpw306//n0qJ913DsYIhi/piMOmA7kz7aEaGMyIzLnXlYEEQ/eFzRl8fC/Pi2yVyqkBGfwQXQVeiVVdHsbIqRzqlKX6DIeCBuInxgO4h0/FtVmUVQr52dBYUjoJYQASOhSavfmSTyuesIuhfazLm3+Wz9Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Cn8h8Qv9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T9WU3UY9XMueTbTN4JxpURvbXOw+hVVs9tkva/RfYYQ=; b=Cn8h8Qv9NF1htMFwG6bbD0WSOF
	zfDc7DBav9ddGPhJg9I+9ulgucHoDYgpnhbSmhwg6k6NDGtZb238TIw6KXvBTnTCqSy4uqdaw6Vpq
	1tpPZzq9KVDqMeC3V67IzZ1iZo7kS50qzMdVlOSVsBEnwH+ls6HSh8V2QNdJwHf1Hoa3oNxaewwWN
	iC4v8XNMvGGFoHwiSL/EOhHPqEpSRBRi1rNxVNBXajA8UoG52VkKnbYOu+zVo4pfQnmIlNLNieIRA
	X6GrCTVMRb0bkwMooNvRhu9fsdZ/r1zRpFNjcpp7CvcB6bYJVrQtJL/IHUZJdJBFmVQ35QxCI5o1Y
	lTZ800lQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22E-0k2C;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 11/63] check_for_nsfs_mounts(): no need to take locks
Date: Fri, 29 Aug 2025 00:07:14 +0100
Message-ID: <20250828230806.3582485-11-viro@zeniv.linux.org.uk>
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

Currently we are taking mount_writer; what that function needs is
either mount_locked_reader (we are not changing anything, we just
want to iterate through the subtree) or namespace_shared and
a reference held by caller on the root of subtree - that's also
enough to stabilize the topology.

The thing is, all callers are already holding at least namespace_shared
as well as a reference to the root of subtree.

Let's make the callers provide locking warranties - don't mess with
mount_lock in check_for_nsfs_mounts() itself and document the locking
requirements.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a5d37b97088f..59948cbf9c47 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2402,21 +2402,15 @@ bool has_locked_children(struct mount *mnt, struct dentry *dentry)
  * specified subtree.  Such references can act as pins for mount namespaces
  * that aren't checked by the mount-cycle checking code, thereby allowing
  * cycles to be made.
+ *
+ * locks: mount_locked_reader || namespace_shared && pinned(subtree)
  */
 static bool check_for_nsfs_mounts(struct mount *subtree)
 {
-	struct mount *p;
-	bool ret = false;
-
-	lock_mount_hash();
-	for (p = subtree; p; p = next_mnt(p, subtree))
+	for (struct mount *p = subtree; p; p = next_mnt(p, subtree))
 		if (mnt_ns_loop(p->mnt.mnt_root))
-			goto out;
-
-	ret = true;
-out:
-	unlock_mount_hash();
-	return ret;
+			return false;
+	return true;
 }
 
 /**
-- 
2.47.2


