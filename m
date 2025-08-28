Return-Path: <linux-fsdevel+bounces-59537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FAB3ADFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A05583850
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394202D0606;
	Thu, 28 Aug 2025 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EGZKhy4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166C2D0C67
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=WOeRF3JQrjVkMMHMACpOguR4t9aMIOefiByTAjl+gy3Y5VxczlbexNiVSdp1mtK5FWR3DZxA3R/SzIFBbqlg2xp5gBaWer7uAC0hcBf2jM7IdzFZl+1yY6cdYO6139ahZubONgZu54KkqxTFfKoxDjc4pVDgccTJFb3tNdBDrNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=0r+mqVfLFQf63EfLxjFqOFyLL9b5NyD0SoCGxhk5efE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjGf+Ql+DCbJNU5ri4FabEkL9Xvc+WfqbPhcyr329itNfKocfVweFFkcIrL0Th+nB+nnx/Yl5EPvEVFVg6BiRTx2gdUKpOvJgfOIOvkBp5HM003OpSrWxsNDPcrX/FeEhpoMVywnegHCxAZ6Q3N5DZq0RjzNG+QYiqpdOFMG5gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EGZKhy4c; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bfS8MbrTqhkcdjwqN5kbV9L1kEnF+VyoLU4fzit4rGw=; b=EGZKhy4cm15srOhM1j0d7Mb2KS
	UMUMmHunhE7fZJMuml0hvzfLgDChxWvFPRDEiq5jLDRTDBEuiTYZc9a0Dj8UKvnSqUc4xx43eWAcR
	ps0YyvZw8si4GhQUM/XxF2AgqstYH4AvUIh7ldMlu+/F+RE/9a8fLCw5oXyZb0n2AMqVfchYOx9oq
	LNrnS3dDGQ45Uj7MHV7jzmip0IVpT9aV7W4gr4e5tZzxOGous4W6INxPyB1nlmfQEpfzRdGesODLM
	+eXWzav3NOG04IyCVeBUmTgSluphSWOlcnZ6awAw/yVsrWKDq2TQL3xUYp3WF3zj1V9QU2EpNxDI1
	Lt2Q7h5A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F226-0H1t;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 10/63] mnt_already_visible(): use guards
Date: Fri, 29 Aug 2025 00:07:13 +0100
Message-ID: <20250828230806.3582485-10-viro@zeniv.linux.org.uk>
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

clean fit; namespace_shared due to iterating through ns->mounts.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 86a86be2b0ef..a5d37b97088f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6232,9 +6232,8 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 {
 	int new_flags = *new_mnt_flags;
 	struct mount *mnt, *n;
-	bool visible = false;
 
-	down_read(&namespace_sem);
+	guard(namespace_shared)();
 	rbtree_postorder_for_each_entry_safe(mnt, n, &ns->mounts, mnt_node) {
 		struct mount *child;
 		int mnt_flags;
@@ -6281,13 +6280,10 @@ static bool mnt_already_visible(struct mnt_namespace *ns,
 		/* Preserve the locked attributes */
 		*new_mnt_flags |= mnt_flags & (MNT_LOCK_READONLY | \
 					       MNT_LOCK_ATIME);
-		visible = true;
-		goto found;
+		return true;
 	next:	;
 	}
-found:
-	up_read(&namespace_sem);
-	return visible;
+	return false;
 }
 
 static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags)
-- 
2.47.2


