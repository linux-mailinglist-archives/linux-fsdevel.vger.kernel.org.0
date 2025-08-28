Return-Path: <linux-fsdevel+bounces-59564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113FDB3AE1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7CE583E12
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4B72F4A12;
	Thu, 28 Aug 2025 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ixbKGZQ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980F2D0C72
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422495; cv=none; b=CO8JD6qdhr8BMQstEn6V/xGT/73IVq0wVI20rmvo77r3amGphuzA6qWeqlE32Odffb08aGHxF5aQfbkOsCuCL9Ixipjn5CedXtJma4FedUQHlgpLDsy4sRygy7gzYB9w/nmIIme3A8WvQyJmf345RTFFRF0nIbldPlarQcW6Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422495; c=relaxed/simple;
	bh=h6pBioabdTedoY8fwwLRxyfwIr1ccISK5lML3k7nXaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GP6uvSgpENH4TZSJN0jUfBHklciCCpi/hUZqK/qIfItgrqiH6ftVvm02zmTGJhiXfdK/GU9cbu4C/ugtWyeBnjhVW+PuReBiESHBM0WFOUFTjdMNifICoqADiYE1ScsmZDJxXuI13JljE+UBFJHwlo/0ibdmIK6KSy0MVhTd8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ixbKGZQ2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yYpr5v9GVA7cqWsh/igoPblGT6TAcvHCpe1NznheFO4=; b=ixbKGZQ2RhPnKd9bIM7PuNBqpB
	/xOKzTFS+slJiPkSmZnhNRP7EDUQzPvtFSFFXvTNyo7UtwqPr+vr7kRNqOuF2Cv68PisiLmolhi5S
	eLl6ilKxjDGaRHZXl/XcPMIFIP+VOwINxv/1AJOTFyIj/f/YtUkMmBKyh05q5YO9FfVNjyp6q9GXc
	Ht/CgNgOCmLQPUsi4mI7cy1YgcTqtFYS1vgLeSLc3CBBHAovDTuLSr3xekZg2eqNK+51oZK8Kjwku
	MisEtcjxcHM1KjIkepKrlGBsGl3ISGwGrmVjnJHSwUMGhX/nnjkclxBMUcnUxMuJekw//MrDMOsCO
	BlyDxN5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj1-0000000F266-10fz;
	Thu, 28 Aug 2025 23:08:11 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 33/63] don't bother passing new_path->dentry to can_move_mount_beneath()
Date: Fri, 29 Aug 2025 00:07:36 +0100
Message-ID: <20250828230806.3582485-33-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 02bc5294071a..085877bfaa5e 100644
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
@@ -3618,7 +3617,7 @@ static int do_move_mount(struct path *old_path,
 	}
 
 	if (beneath) {
-		err = can_move_mount_beneath(old, new_path, mp.mp);
+		err = can_move_mount_beneath(old, real_mount(new_path->mnt), mp.mp);
 		if (err)
 			return err;
 	}
-- 
2.47.2


