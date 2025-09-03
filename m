Return-Path: <linux-fsdevel+bounces-60049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D16F8B413C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2FC1BA1230
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAC32D6624;
	Wed,  3 Sep 2025 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="k75IBlU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967D21771B
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875343; cv=none; b=ss3+2GnhguE/9z8DGIEQgSdIvWW9u3MadmFMPL0iXxK7HpT7/iy1s8UQJQ3nu/yac+K+fNPlEM56lddOotNrUwJslXApInWDhBH9RhGRrCTuQC1jkXN85yX1lBYgr2DuDXgV0SJoPEWiSoKHe4g06H/QlXVcfEMT5600wXRsCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875343; c=relaxed/simple;
	bh=NB9TuKdhZkW45GLoScYcrHUUjbqPbB0kYiTyDiyyTIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HJalwBOkm1evTYh98XhsMLl1a6iREmtQ2wkF8qapngSke/B9pCbYgpXW6LLsHcr9ULVH7BP9lTmpsolUfNwsyExwWrbZHQE/zru2A+H4qZj9kfqu09700AgS5IWstVJP/itGQKMPYztS1kiUi6LgVLv5YEV7e2CRD8L9cmCJEHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=k75IBlU7; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=T9WU3UY9XMueTbTN4JxpURvbXOw+hVVs9tkva/RfYYQ=; b=k75IBlU7MBKU8JRYJHX1PT0jUZ
	YSPY9sIpxrNiyIkE0VELfi6WmyRGMumOuRjOlfiCaG+ZDXfhkItsf5QptX4Ogtj/4/xsybhD1ZCe+
	wXQjqaSSu0Huul1GxBTPJasw4+zi6k6eKi7YnFfUri088KuWnINgrfFMGzctMVGipZCiynbhJ7/zA
	JsT2Syz3+aifNuXuFx/9CJmQD3SD0eszzDfvDMgKM6RxFH13UxmN/IKPRi3iJf3y0aC8lS1GKlK9k
	ybuDzGZrF6xQon8ICMaRW76vUlO2NcV4vIdw/RlolV5ykeQT0FMVww8L16l8xH5lwAMm1uGcGQg4K
	nao3++5w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX2-0000000Ap74-0ym3;
	Wed, 03 Sep 2025 04:55:40 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 11/65] check_for_nsfs_mounts(): no need to take locks
Date: Wed,  3 Sep 2025 05:54:32 +0100
Message-ID: <20250903045537.2579614-11-viro@zeniv.linux.org.uk>
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


