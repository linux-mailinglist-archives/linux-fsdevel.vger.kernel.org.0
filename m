Return-Path: <linux-fsdevel+bounces-58915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E7B33577
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0FE817C585
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2627FB3E;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KpjysKAz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756D8265637
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=pzut6Un9z1XhPN/iImLIld+g3XmCelIuA3HF7L3VslpcjDlFpWrRXtlyWEtlyevpjGv0p/Aiy60v2cx43g7ZrSxIVfN2UG7Bi4HeODMU7meY/O0LVivsQsSAZSQKCUIXaWH20r+q2cXN8YvNpBokJ1ZoSWfT7N4ErIItrAkyiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=5mWUG2MQmnlbCc3mBB92ghPcd4qlwsiWqW5QcsxljY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StVvga/mcxymIaf1XmjFuHETCQNAJYurY5HM61o4rB9uggWeOwZQG9ErDGY4HtIKZEe9hnxwM+eULgAymtMnc23fBNcvmX0dBZ6C3A31J0SSSjlKH4Fax0OhS500f3uctaa0w1qM9+96vItqiD5ghVlL1rtX4rEKz1qJ5AkbiNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KpjysKAz; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8peaoEnfSFTDaxY8imdG9hK4tZd1nuH0vJbZ8mMdlbA=; b=KpjysKAzxK23+Zqtr/dKn/Qp2F
	x+psvg6RBdWcSC06R4WZ4B8SYYqtDi5Pc9fC6iDbNzqLseduO1Guipo9dWO3gqCHGcGntXv7Wp6QF
	pY8n0M786KVZmTBmYyQcWXTV+kB3aVKKosAMb//Hlan4CKHkiY4HZs4OqJvrnSphEUwS5pwo6LQ/S
	wvFuN4YKSxsFYgCYSQ3gDGXd55P75IgLBt2FL/+4tUGaEoeeKXQsGHPNXuPSpB21N+000jH9IQh58
	YUQJlzaRWxn3uBqJGhutVR5d9JUP+DVpjFDYGNRDbML0jb4MCFU9H1v6rY9OScRdRoGrr3ZV96ZTp
	mohiiB/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006T9j-0BDH;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 11/52] check_for_nsfs_mounts(): no need to take locks
Date: Mon, 25 Aug 2025 05:43:14 +0100
Message-ID: <20250825044355.1541941-11-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
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


