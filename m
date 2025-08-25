Return-Path: <linux-fsdevel+bounces-58931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54484B33575
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 478524E25C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F858283FE6;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="UKJ4l+dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805C625A357
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=jhfCaTfRLWvi9D+j3QvlT02PU3TPXml7Ey22C6aQh/ZqO1EqFcBD2yLHTUJcSyt7HIm375UKjhPd7ljJxEjuOSr/BR/PvNx5RRYQHI+6tiEBG9DpFYOcIvd/1GvpjVThZkuGihuMxYZmmv0L/RITEGbiP3LV5GG7X6s4q/Oj2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=QLFUWM/DL9ahOJA7cLgfjWPvxmUahoATJDF9ya38QlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTRlvzwzchtqdiu88mxFuQptSNAo0Q/9sgo+5+e5NEaiWlxlJsw6XLK7KiAwX16bCAHsQEav+e9o23YI+xPQKizrCe8pcbXJmT+m5/Q2yWV8H8bDMo6T5UxNgXGbQlp/DxL6csj5GCYvRCVhNXEjn6pZDKCrZ4pqztwOiVUN0kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=UKJ4l+dg; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Hu8tMiEiWI+Z/aAK2DSkePkRb/62Nj4/vbot0SXVUyc=; b=UKJ4l+dgsobN007ZIEt/C2xNxj
	5PNRtSl6W7yZ7iYk3SoV0PFYQ97yrdj1sFnXDDzTxsXpeLSQ89Nze527khk4BmuR35nKPox7LfS48
	2H79g42NMRFY7oAqwLFbL93ctEw8r7oatZJMLYjludzStrali2myqmqOojHEZ5P0Y/pmf4vpKeomt
	XPIfwTTbyS3yFAGLq8kzjI6+JcbuuplnveYDOwyZu87QgXUwCZ6Inw0L4ssvO/lq6FFfzx0b3KeJp
	PLaydt25nnC4uDCFYAMZOV/PO+SWZS9hM2w5My/JcFEXPKq09MAFXrtaOS9DBX+VKI4gaqqHSKUB2
	T4rXtS/g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3n-00000006TD5-2no9;
	Mon, 25 Aug 2025 04:43:59 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 32/52] don't bother passing new_path->dentry to can_move_mount_beneath()
Date: Mon, 25 Aug 2025 05:43:35 +0100
Message-ID: <20250825044355.1541941-32-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 494433d2e04b..7d51763fc76c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3451,8 +3451,8 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
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
@@ -3468,11 +3468,10 @@ static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
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
@@ -3619,7 +3618,7 @@ static int do_move_mount(struct path *old_path,
 	}
 
 	if (beneath) {
-		err = can_move_mount_beneath(old, new_path, mp.mp);
+		err = can_move_mount_beneath(old, real_mount(new_path->mnt), mp.mp);
 		if (err)
 			return err;
 	}
-- 
2.47.2


