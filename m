Return-Path: <linux-fsdevel+bounces-11347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA43852CAD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67C428A2FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1411954670;
	Tue, 13 Feb 2024 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="ENbwnnNB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473053E18;
	Tue, 13 Feb 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817092; cv=none; b=izdmjXkaM/kC5zsWSuNzk6M0EJoeA0vMclFtecLa3imYfYWpBLwu4t3s9qo4HUUU0sRFjfGAClIrHHEdNePRTGmje8kJQXp8/mFNFpKeQkeW6m0xVrKK5doarWampHtzkcs2UzbfXqBbkrcKolgzGlWDqcdZiQf4C2cUtudwDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817092; c=relaxed/simple;
	bh=ua/0/Cz1VYv5tIBaRlFGPxVYgrAUWB1V+tD6GkDOKdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ss3A6nmehEvto6mhjjaqqEhFl88FR8NDq2nKrK0Ty3rczB/T48jy8aCuLJiOFyTS3cpdXHrwVzSDrfo6++mDvVZcw2HxjLhl/cQuO8RZJPJvLm0KM1yszY3VCr2SpnbsFi27S2OVZlfgeO3OLMcxKeFFQLvG5BMSkuEujWKah7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=ENbwnnNB; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TYx8H2fChz9sSH;
	Tue, 13 Feb 2024 10:38:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1707817087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ydvUqzYBcKzyH4ZGo5x0A9m5vNe3qnV9Z0vpVQaGpLg=;
	b=ENbwnnNBjOlMkTNsWgmN/QeJZ4bByf9vXC2SH9MWslItb5E3wLNJdxS5OYwgUczoQQxGFa
	jJLfvCUFWE4S4XIaf/gyJsxDpV54gpCGO6Q09Hr3W1Zl8hpSte2SCg/NxBVzt13u5b+rtn
	u9QhTF7FnDJlW3xsb7G6zptXw5QVnwjAOVIogxhjlYniqe0K1ORrtaGBSqFIq7XIZecY9G
	asCnrkLcVOePpZAFLxRLQb3P4hXMoiEeVmElnhxfjx+/5h/OFo9SJwBVx77eiPLb+MoeAw
	aa/PQKwI9st5rNiozYJhatwuGinu3iv/klvwOtrhhlSPwM2BtJQuDhCzDDR5jA==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: mcgrof@kernel.org,
	gost.dev@samsung.com,
	akpm@linux-foundation.org,
	kbusch@kernel.org,
	djwong@kernel.org,
	chandan.babu@oracle.com,
	p.raghav@samsung.com,
	linux-kernel@vger.kernel.org,
	hare@suse.de,
	willy@infradead.org,
	linux-mm@kvack.org,
	david@fromorbit.com
Subject: [RFC v2 14/14] xfs: enable block size larger than page size support
Date: Tue, 13 Feb 2024 10:37:13 +0100
Message-ID: <20240213093713.1753368-15-kernel@pankajraghav.com>
In-Reply-To: <20240213093713.1753368-1-kernel@pankajraghav.com>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TYx8H2fChz9sSH

From: Pankaj Raghav <p.raghav@samsung.com>

Page cache now has the ability to have a minimum order when allocating
a folio which is a prerequisite to add support for block size > page
size. Enable it in XFS under CONFIG_XFS_LBS.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/xfs/xfs_icache.c | 8 ++++++--
 fs/xfs/xfs_super.c  | 8 +++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index dba514a2c84d..9de81caf7ad4 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -73,6 +73,7 @@ xfs_inode_alloc(
 	xfs_ino_t		ino)
 {
 	struct xfs_inode	*ip;
+	int			min_order = 0;
 
 	/*
 	 * XXX: If this didn't occur in transactions, we could drop GFP_NOFAIL
@@ -88,7 +89,8 @@ xfs_inode_alloc(
 	/* VFS doesn't initialise i_mode or i_state! */
 	VFS_I(ip)->i_mode = 0;
 	VFS_I(ip)->i_state = 0;
-	mapping_set_large_folios(VFS_I(ip)->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(VFS_I(ip)->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 
 	XFS_STATS_INC(mp, vn_active);
 	ASSERT(atomic_read(&ip->i_pincount) == 0);
@@ -313,6 +315,7 @@ xfs_reinit_inode(
 	dev_t			dev = inode->i_rdev;
 	kuid_t			uid = inode->i_uid;
 	kgid_t			gid = inode->i_gid;
+	int			min_order = 0;
 
 	error = inode_init_always(mp->m_super, inode);
 
@@ -323,7 +326,8 @@ xfs_reinit_inode(
 	inode->i_rdev = dev;
 	inode->i_uid = uid;
 	inode->i_gid = gid;
-	mapping_set_large_folios(inode->i_mapping);
+	min_order = max(min_order, ilog2(mp->m_sb.sb_blocksize) - PAGE_SHIFT);
+	mapping_set_folio_orders(inode->i_mapping, min_order, MAX_PAGECACHE_ORDER);
 	return error;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 5a2512d20bd0..6a3f0f6727eb 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1625,13 +1625,11 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
-	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
+	if (!IS_ENABLED(CONFIG_XFS_LBS) && mp->m_sb.sb_blocksize > PAGE_SIZE) {
 		xfs_warn(mp,
 		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
+		"Only pagesize (%ld) or less will currently work. "
+		"Enable Experimental CONFIG_XFS_LBS for this support",
 				mp->m_sb.sb_blocksize, PAGE_SIZE);
 		error = -ENOSYS;
 		goto out_free_sb;
-- 
2.43.0


