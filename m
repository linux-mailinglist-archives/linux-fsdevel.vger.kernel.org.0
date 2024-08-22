Return-Path: <linux-fsdevel+bounces-26801-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F12395BB3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A84F1C231D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E432C1CCEF2;
	Thu, 22 Aug 2024 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="jRvcmCFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE961CCB5B;
	Thu, 22 Aug 2024 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724342491; cv=none; b=lqb76mR1P6CnTQJzeQoCwP/FRVx+V22LaRgtcUf8es5SikL1wSMn7l99KW9YKufmkTKq0Voi4KR3wDzXNwxTkds4wXyCamIvfdygPkaW/cvVgGyL1BKJnSwUc6qtAT+e88FFPDZqW7P/gLgXWDaSJnuoppTl91jQU3cH8N7uDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724342491; c=relaxed/simple;
	bh=PBmxHSB0BbqJCQbppwrNYV21XadlSZwahuh22MfyQPQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BaaM6hFHs526WlwMMnLnSEO9aTvj/lRGx/LZSKoXQHcrMdzuek7aG4Pcy5lOP8SoAHGIK+8t9pv+engstRkUa7wZRIIPpQMiSPN8BUUqht/F1g+yyBeGalav3wKW9JvMY1/1wp0EYa2SoqzHStWaAlxjOu/h0JwWufBKnQp9o38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=jRvcmCFn; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3D8C421D6;
	Thu, 22 Aug 2024 15:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1724341463;
	bh=uOtKXY2rRKGu6oE/l23bWJJvohMGVSqv/2n+peneH+k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jRvcmCFnY+e4Z+kuw5HUQyNNy/BgPzLe2Z+ZLSXSinQ338Vm2GXpchdNRl7R3kwry
	 1Z7/HpKPEU4qhe5/oolKTDAcnNE2g6KGNaaov573NFejpF2wA1655Ruf4+D+7Z/1oO
	 rTNlfmu6VZjLfAAw0Ggc/FVPJzvCGv06G1VZmF6o=
Received: from ntfs3vm.paragon-software.com (192.168.211.133) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 22 Aug 2024 18:52:19 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 02/14] fs/ntfs3: Optimize large writes into sparse file
Date: Thu, 22 Aug 2024 18:51:55 +0300
Message-ID: <20240822155207.600355-3-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
References: <20240822155207.600355-1-almaz.alexandrovich@paragon-software.com>
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

Optimized cluster allocation by allocating a large chunk in advance
before writing, instead of allocating during the writing process
by clusters.
Essentially replicates the logic of fallocate.

Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/file.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index cddc51f9a93b..d31eae611fe0 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -408,6 +408,42 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 		err = 0;
 	}
 
+	if (file && is_sparsed(ni)) {
+		/*
+		 * This code optimizes large writes to sparse file.
+		 * TODO: merge this fragment with fallocate fragment.
+		 */
+		struct ntfs_sb_info *sbi = ni->mi.sbi;
+		CLST vcn = pos >> sbi->cluster_bits;
+		CLST cend = bytes_to_cluster(sbi, end);
+		CLST cend_v = bytes_to_cluster(sbi, ni->i_valid);
+		CLST lcn, clen;
+		bool new;
+
+		if (cend_v > cend)
+			cend_v = cend;
+
+		/*
+		 * Allocate and zero new clusters.
+		 * Zeroing these clusters may be too long.
+		 */
+		for (; vcn < cend_v; vcn += clen) {
+			err = attr_data_get_block(ni, vcn, cend_v - vcn, &lcn,
+						  &clen, &new, true);
+			if (err)
+				goto out;
+		}
+		/*
+		 * Allocate but not zero new clusters.
+		 */
+		for (; vcn < cend; vcn += clen) {
+			err = attr_data_get_block(ni, vcn, cend - vcn, &lcn,
+						  &clen, &new, false);
+			if (err)
+				goto out;
+		}
+	}
+
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
-- 
2.34.1


