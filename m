Return-Path: <linux-fsdevel+bounces-59543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70405B3AE04
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0C21C27F82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE032EA498;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="V9IeN82Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146C2D061A
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422492; cv=none; b=FPbBVFVxE7IfP2+OfX+4gZRduE5IMdNjSs3NhXv5c7XmlzZgIlHx5LY3axNvxaJE3S8YojbeVFheUA26tsS3hz5HZaQhaK5RwOs3jVHhyTpybT6Ps55lvfNnOM6mlhonfxFCDa2V/VXWaY2EMZD1Ocf0vV8qGBYeMX0m/ps/zv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422492; c=relaxed/simple;
	bh=YOFDeNDrIhsCzrSLdjrzy5CThW0Lpmy9/FA8aiGTDRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EtOEaUND4e2/J6DRzS4yJZG68geTVBszhiPB4m/KTp9mSLVvmaI9/EPsZG4sNGudNBHqORU9U4B0ECv84MCkQoG6h+b/VHEUvI3pnPEBKl2eWxDOs8hdsGDKqJRKEIlikxzqSeK0MnMPFyllGSMv5QptHRbJMNAMthcxMOF7QNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=V9IeN82Y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=uyfuQOv8jV/n/o6UMa+1KdXqTk7SB8XAIdl/PD9VJxw=; b=V9IeN82YJQG7TVBSOGWu0hlwuf
	HjTPc1bm5xoXnDYJCUQda1twSG36dVI4VC9RJmtHrlxHGv3Cyr9UP3zjhX5rH5G/ayjEnFlgTmVKa
	faZeTZdWGTJ4Aoq5NrWftUldwpeVQFi15rbFjbq88Oa1FNSMUgvw4K1vyFLIu48zRatkdHl/sgTMv
	CrJ0o8sdtVA5LtcHLZ6dd2W0gQnkw5SqPfpZZ5v6RG8B/ZMPviSN+OJF01ZQVHshtguO0ncozyuLO
	2AkeaJJMJT+QOd1hfnQRF+vJL8UvqAhTqLSkNskdyHCotU0PRf68cif/dQkuoxWwR3hn1NKBC3Qkq
	96mAMr6Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F21p-3cXR;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 08/63] mark_mounts_for_expiry(): use guards
Date: Fri, 29 Aug 2025 00:07:11 +0100
Message-ID: <20250828230806.3582485-8-viro@zeniv.linux.org.uk>
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

Clean fit; guards can't be weaker due to umount_tree() calls.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 13e2f3837a26..898a6b7307e4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3886,8 +3886,8 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	if (list_empty(mounts))
 		return;
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
 
 	/* extract from the expiration list every vfsmount that matches the
 	 * following criteria:
@@ -3909,8 +3909,6 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 		touch_mnt_namespace(mnt->mnt_ns);
 		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
-	unlock_mount_hash();
-	namespace_unlock();
 }
 
 EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
-- 
2.47.2


