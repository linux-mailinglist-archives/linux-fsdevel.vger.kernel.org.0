Return-Path: <linux-fsdevel+bounces-60075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9477FB413E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11859681837
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8C2D877E;
	Wed,  3 Sep 2025 04:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="J+1y7Bnm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E242D73B0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875347; cv=none; b=Tp5caG0zaB0YhjKChtx6R4YIEKAykdIQgpGdj0MIF9/g77yV1zc+0UdjTsAkY+Oxp7oSX1xGUd5zUUw0g0k5a07AmcrdAUHPXBKFs+D5Jc4XE3WP7lGSnFB3cOZgSi4b6t0CF35rCuCbYTw5roAQUUGHaqE2kaQ+YBT1KJRCKYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875347; c=relaxed/simple;
	bh=d0Kb5SH42WCatMXi6aEBgKzMxDxVcUBn42J9Rw6BEaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quWwDiwuTcj0uVeEcaJEJVaIBLhPl2opgKC2gRGQ+MyAvnyzr3w547JVopgNOVA4RWrucR/T2Au9j6j1tqPh5gT/MMAI4RlT2kxNpLz6wiO0YTjcY059YfgevQtSxi92ruroOi55yvJjePRF1wwUzN0U28EhPpQ7bFrTBKilE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=J+1y7Bnm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BowZ+Bx9ITVLMKzlUpCsEkKCz6wg1kh95VGk61erJgg=; b=J+1y7Bnm1omJ3MjRexn0lyfYSd
	zQrBX1CEYvQe9Lat2Sa2rXVZ/gLioAVf+wIG1A4yEzsCR938Y8rHk1MO5zlUj91P/aNmW627akvmk
	9htP5Vgc6Sp0uGqdl0ryIA9fGnRSPAHNfeYSoXHGQt6xflZ8k7Z3O/bK+/kLnMrwqAvJVPLKiwpBT
	l4pVq0pED8KGHce7/7Dn+rMQD5FEkkhsw0FO2TPmN6nsfeY7Xfr6UVHyglvaKoBbxEzXqQW24ADiZ
	17X8+y/OaMiHTdTab1sRvMeHVqBCb0B0ihJmdwZrwrhGOVzz3XSV8YqkYu1B2JODWmtMhMD8gh1Z3
	tYciJivw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX5-0000000ApB3-2aQX;
	Wed, 03 Sep 2025 04:55:43 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 33/65] don't bother passing new_path->dentry to can_move_mount_beneath()
Date: Wed,  3 Sep 2025 05:54:55 +0100
Message-ID: <20250903045537.2579614-34-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 02bc5294071a..b81677a4232f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3450,8 +3450,8 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
 /**
  * can_move_mount_beneath - check that we can mount beneath the top mount
  * @mnt_from: mount we are trying to move
- * @to:   mount under which to mount
- * @mp:   mountpoint of @to
+ * @mnt_to:   mount under which to mount
+ * @mp:   mountpoint of @mnt_to
  *
  * - Make sure that nothing can be mounted beneath the caller's current
  *   root or the rootfs of the namespace.
@@ -3467,11 +3467,10 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
  * Return: On success 0, and on error a negative error code is returned.
  */
 static int can_move_mount_beneath(struct mount *mnt_from,
-				  const struct path *to,
+				  struct mount *mnt_to,
 				  const struct mountpoint *mp)
 {
-	struct mount *mnt_to = real_mount(to->mnt),
-		     *parent_mnt_to = mnt_to->mnt_parent;
+	struct mount *parent_mnt_to = mnt_to->mnt_parent;
 
 	if (IS_MNT_LOCKED(mnt_to))
 		return -EINVAL;
@@ -3618,7 +3617,9 @@ static int do_move_mount(struct path *old_path,
 	}
 
 	if (beneath) {
-		err = can_move_mount_beneath(old, new_path, mp.mp);
+		struct mount *over = real_mount(new_path->mnt);
+
+		err = can_move_mount_beneath(old, over, mp.mp);
 		if (err)
 			return err;
 	}
-- 
2.47.2


