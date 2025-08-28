Return-Path: <linux-fsdevel+bounces-59541-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E2B3AE02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6767582A62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BDC2E7BDC;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OPPeuZuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003722D12E7
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422491; cv=none; b=Op1PelR8KFM+9Y4FSjl6aZ3TJnZkX4Ajuwsg12Z2/7CgRIUvaaNGmZfL31q/OGiWRVX2TIWD138a75gpqcG5bcp+VYXPaXLB2muMkTmplkX7vsUypNU00LhX5ii/qeAyr4mG21EAtR2TNgHnTIVQRewCPELX4S0t0XNwuhE+i2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422491; c=relaxed/simple;
	bh=gsSUOZw7jNMxBkUk+4lpSubWwvIP/F2PKDiEfZ3N5B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MttZfch/3Kll0AwE+NiY3ajSlm8LYux18HxFyMevQIPBtLhhCzR0fVEkX6kwMoLuWe3gzBib9y4NhkY8o12VXRG9fFaE9HePlaOfvLDH5TqdkM4SB2qvSq5rKZw0pq8+ZN8Dn/zJWnyyD150O8LfT52kki3LuHyOoOCpZ8DBmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OPPeuZuM; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ZKWxMF9T2R2ZoDUVhm++vq7dmv8Wicqkw+jSTFohJJI=; b=OPPeuZuMN2aTGnc7rSl3OdRehe
	3iqUTdQq16H5Zcpya0M8kH1zr2s8eMebPOw2QftljZ37xEeIhoRPUAFWgko10Z6YRgocN80QNU6oz
	u+abIY6V9NpvR5aMyfigPlNZZeNQmo3qgMUDUm4+8VJXv1MYZssgINTLNMkOk2z9WXZ9q/kR845jY
	pEhIsJbsJv/gpTLpftkIulPrEtq3lHETsne9P5JEWmQgMP/3c0Rmw2I4npgZediOkOYnj7+POEClP
	mn3GYBekVyNGeWb3ym6Iv5+KlVHcnSZzlTgTePFWraG1V4Tbl9CuuXVoFizyvB2lmugcLac2IxU9T
	YX6KRK0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F22w-2CaV;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 16/63] current_chrooted(): don't bother with follow_down_one()
Date: Fri, 29 Aug 2025 00:07:19 +0100
Message-ID: <20250828230806.3582485-16-viro@zeniv.linux.org.uk>
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

All we need here is to follow ->overmount on root mount of namespace...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6aabf0045389..cf680fbf015e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6194,24 +6194,22 @@ bool our_mnt(struct vfsmount *mnt)
 bool current_chrooted(void)
 {
 	/* Does the current process have a non-standard root */
-	struct path ns_root;
+	struct mount *root = current->nsproxy->mnt_ns->root;
 	struct path fs_root;
 	bool chrooted;
 
+	get_fs_root(current->fs, &fs_root);
+
 	/* Find the namespace root */
-	ns_root.mnt = &current->nsproxy->mnt_ns->root->mnt;
-	ns_root.dentry = ns_root.mnt->mnt_root;
-	path_get(&ns_root);
-	while (d_mountpoint(ns_root.dentry) && follow_down_one(&ns_root))
-		;
+	read_seqlock_excl(&mount_lock);
 
-	get_fs_root(current->fs, &fs_root);
+	while (unlikely(root->overmount))
+		root = root->overmount;
 
-	chrooted = !path_equal(&fs_root, &ns_root);
+	chrooted = fs_root.mnt != &root->mnt || !path_mounted(&fs_root);
 
+	read_sequnlock_excl(&mount_lock);
 	path_put(&fs_root);
-	path_put(&ns_root);
-
 	return chrooted;
 }
 
-- 
2.47.2


