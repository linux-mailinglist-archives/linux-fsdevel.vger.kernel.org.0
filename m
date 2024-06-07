Return-Path: <linux-fsdevel+bounces-21189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C789900355
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 14:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324D5285CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 12:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658919306D;
	Fri,  7 Jun 2024 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="iab/r7sh";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="WCklOibq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC680190672;
	Fri,  7 Jun 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717762876; cv=none; b=ddp/T+L9nolHrYhayFNSlJW9KCJHUZgGH7L6FGa+rtJW7/wMhUX5Cp+BFlSk8xkrvzj4J6I3SK9xS1bm0DEoTra0k3kWuRA6BTSepm5kTW2snUoTMzzUGMH5jasRmAnxphNWMJebv1QQplgeT5g+qHKLoFb85GRBsbD+yQg7U5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717762876; c=relaxed/simple;
	bh=y6qWtrpkZqusAAapvB5X4IkDLdvvSpaWslGRSO8ceWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZLYU2n1Z3RxvoYxmWVsyTbwVAr2KvJqh22m2a5A3Xu4ONjQyxP9hSddYr1D3jQvcpcN8cUbeLTfXGd1Pn5QCGMhSgqCqw8bW8tErNvON2Ln87mBiiZ1n5Zr0Z8rQNL9gOvwa1AgKeUWPoka3/FxJIMxqTMDKh1x1cTLeTJvU58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=iab/r7sh; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=WCklOibq; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 7783F20F5;
	Fri,  7 Jun 2024 12:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762090;
	bh=ieQyW4z66ZKq7WPGZB3WJThiQlHeD3ZBUU4O1S8w13s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iab/r7shxZyQcEZAZhvreSkg/ZGQn4CL76lO4lkbkJyhuybFXLA/+IhZ3CAc+t8GX
	 QG0cQB2szYLpaWxDUt5vEgowTo7cJqk3HPu6Dit2GeKoqfal/i5Kvjm5OhUGXagNGD
	 Vxb28F9WTsGGB6z7iY0fHNoHd+zYoyLsVR/U/f8A=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 5979A195;
	Fri,  7 Jun 2024 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1717762564;
	bh=ieQyW4z66ZKq7WPGZB3WJThiQlHeD3ZBUU4O1S8w13s=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WCklOibqwPSdIbcMRQNVCfzy9nhwd48pD81SaZ3CajC+WPoic8oO7TgIwXEgTHCU8
	 dwaWBiMrVBLd7ne+8s8exygyJChsN4xg5onItl8aq35xv/Gbll2taT0M6mOzyreUSA
	 4wkc6UzrUxZEFfj38yIwuPYTIejd250CwZm3elOY=
Received: from ntfs3vm.paragon-software.com (192.168.211.95) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Jun 2024 15:16:03 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 01/18] fs/ntfs3: Remove unused function
Date: Fri, 7 Jun 2024 15:15:31 +0300
Message-ID: <20240607121548.18818-2-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
References: <20240607121548.18818-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

At the moment, the function turned out to be unused, so I removed it.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/inode.c   | 30 ------------------------------
 fs/ntfs3/ntfs_fs.h |  1 -
 2 files changed, 31 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 0f1664db94ad..6dc51faeef8d 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1097,36 +1097,6 @@ int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 	return ret;
 }
 
-int inode_write_data(struct inode *inode, const void *data, size_t bytes)
-{
-	pgoff_t idx;
-
-	/* Write non resident data. */
-	for (idx = 0; bytes; idx++) {
-		size_t op = bytes > PAGE_SIZE ? PAGE_SIZE : bytes;
-		struct page *page = ntfs_map_page(inode->i_mapping, idx);
-
-		if (IS_ERR(page))
-			return PTR_ERR(page);
-
-		lock_page(page);
-		WARN_ON(!PageUptodate(page));
-		ClearPageUptodate(page);
-
-		memcpy(page_address(page), data, op);
-
-		flush_dcache_page(page);
-		SetPageUptodate(page);
-		unlock_page(page);
-
-		ntfs_unmap_page(page);
-
-		bytes -= op;
-		data = Add2Ptr(data, PAGE_SIZE);
-	}
-	return 0;
-}
-
 /*
  * ntfs_reparse_bytes
  *
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index f9ed6d2b065d..ee0c1b76e812 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -716,7 +716,6 @@ int ntfs3_write_inode(struct inode *inode, struct writeback_control *wbc);
 int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
-int inode_write_data(struct inode *inode, const void *data, size_t bytes);
 int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, const struct cpu_str *uni,
 		      umode_t mode, dev_t dev, const char *symname, u32 size,
-- 
2.34.1


