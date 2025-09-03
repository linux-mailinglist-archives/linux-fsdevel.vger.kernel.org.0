Return-Path: <linux-fsdevel+bounces-60070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670EEB413DE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FAFC681736
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACFB2D8383;
	Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QUlVIj47"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0328726D
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875346; cv=none; b=Y/VGnN6pOg2zymycVQENojkbm3qoHk1ITpVEspywn+EQP7xbCekpwIGjQkjaxmT2Qk6nVJUaXGlUosVxEfEj4H37DOpWgG/FqRNU1Mb6fFbVgk5v2jYgLxT4CT8cWq9VzCv4BVA2eAt2oEVmJjLztZAteTQsI2Yurrew7P6nCS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875346; c=relaxed/simple;
	bh=m/coEnNbH+P7SylpfJg8DyX7lDlWzw9afVduL5nIfGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EWfl4ZcM7ZpS6helXvn28RZ4iwvpGEUfdtfOYOG8qDG6dfwItP7997SqqfLhVlZhBJgSqJUk+gk7Ji2cekJae0gZqXdnKC+y9XLcu6hFIBmE19LCw8uSicBEeiWhGpnf598ZtZyDRDoShdkP5n8NsPJPfrb/ohSplrVlEEnwuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QUlVIj47; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=CZHBGSSTTw1zKK6/3B3cf90IWt/OO6Vekbco0kTSI3E=; b=QUlVIj47P0aYo4Xy12GncbvsXz
	R8mym4c8E++vKL4GOCKG58sWefZ8WTarOuRDQ0nbelaJVzN4fvlN/NtARQsZZVoAXS6KJJloV3ut0
	/w30ayiyNB/3f+pkWBHd7VXpnT+njaojkIb+itWQ97TyX2nZuY2e/+mD6KmyF65xnNWKMK+j0KsAu
	JbKowwzBhc1JzONVWcHBdpemsfl0AZImGycAZYelpXf41Gk/cH58dGrny4Y308IfPYYxcgTVRfT6A
	Pn+SDOCauAKEb+GrkaI+txJEAIckscvdoAuW9QPL/qTYg6uBoWtHgvJBPUBcTCgJFsJhrJWFGDqLR
	BacnPx6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap8k-1Xvi;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 21/65] move_mount(2): take sanity checks in 'beneath' case into do_lock_mount()
Date: Wed,  3 Sep 2025 05:54:42 +0100
Message-ID: <20250903045537.2579614-21-viro@zeniv.linux.org.uk>
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

We want to mount beneath the given location.  For that operation to
make sense, location must be the root of some mount that has something
under it.  Currently we let it proceed if those requirements are not met,
with rather meaningless results, and have that bogosity caught further
down the road; let's fail early instead - do_lock_mount() doesn't make
sense unless those conditions hold, and checking them there makes
things simpler.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 74c67ea1b5a8..86c6dd432b13 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2768,12 +2768,19 @@ static int do_lock_mount(struct path *path, struct pinned_mountpoint *pinned, bo
 	struct path under = {};
 	int err = -ENOENT;
 
+	if (unlikely(beneath) && !path_mounted(path))
+		return -EINVAL;
+
 	for (;;) {
 		struct mount *m = real_mount(mnt);
 
 		if (beneath) {
 			path_put(&under);
 			read_seqlock_excl(&mount_lock);
+			if (unlikely(!mnt_has_parent(m))) {
+				read_sequnlock_excl(&mount_lock);
+				return -EINVAL;
+			}
 			under.mnt = mntget(&m->mnt_parent->mnt);
 			under.dentry = dget(m->mnt_mountpoint);
 			read_sequnlock_excl(&mount_lock);
@@ -3437,8 +3444,6 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * @to:   mount under which to mount
  * @mp:   mountpoint of @to
  *
- * - Make sure that @to->dentry is actually the root of a mount under
- *   which we can mount another mount.
  * - Make sure that nothing can be mounted beneath the caller's current
  *   root or the rootfs of the namespace.
  * - Make sure that the caller can unmount the topmost mount ensuring
@@ -3459,12 +3464,6 @@ static int can_move_mount_beneath(struct mount *mnt_from,
 	struct mount *mnt_to = real_mount(to->mnt),
 		     *parent_mnt_to = mnt_to->mnt_parent;
 
-	if (!mnt_has_parent(mnt_to))
-		return -EINVAL;
-
-	if (!path_mounted(to))
-		return -EINVAL;
-
 	if (IS_MNT_LOCKED(mnt_to))
 		return -EINVAL;
 
-- 
2.47.2


