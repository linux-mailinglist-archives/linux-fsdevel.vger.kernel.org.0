Return-Path: <linux-fsdevel+bounces-72792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA7CD01A86
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 09:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E98F3045CFE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7E33803DD;
	Thu,  8 Jan 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MZlA+mpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48237E2EF;
	Thu,  8 Jan 2026 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858651; cv=none; b=cTnFAnaPOe/tiZGyqfn5uJmTJlfHRSlGIXHrjYi11OUiFr37V7m9E5UjeQ0AakZHa4zsPEPxHv4HDSE8xCWVfTaZgYCxwYM0+boHeyNNolflJ3xCBEriljF+/+4D+lYDvRyi3DjdzOsxYOarSgnlxMFxpDVhynvebFHTs6LSwkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858651; c=relaxed/simple;
	bh=RopLWtVceLC7tS2lI+xLxV4kiKSasNVefJ1AW0lNyQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPGCp1zBzSKVBNTSefPZ/lYC5X+Vts75nWvxTpkUxz76UVGIrErHtVjN2lzIRZb/yRU+CpbVlVgIA3WSX2hks70PXnBMbgTp5XRFD2gZvUG77P6Y5bhjgV+fBuY6Q4UjOtlAWm7FYF5UkX7e9YMeRrUgJlinL6//Q4o98hleXNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MZlA+mpt; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Bn
	zvrHIhkgHewKuMTs6hq6c/gumgF+tqmP1yexiiRwo=; b=MZlA+mptqERJh8hjMd
	Tu8hQ+VQdOSMHBGPwe47XJJ48PDCr/QTx+zAUQxYfKYepSMAQ/B/nZCC+qjBabvA
	knWQvGb/z2D2bxNETtBtPUjqrx6JEfqasYHh6qE9QIQZoMks9K0FFVAgHkr26yNK
	bZCwrJbWxelEhTo+Il391VV8s=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S10;
	Thu, 08 Jan 2026 15:50:08 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 08/13] exfat: reuse cache to improve exfat_get_cluster
Date: Thu,  8 Jan 2026 15:49:24 +0800
Message-ID: <20260108074929.356683-9-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108074929.356683-1-chizhiling@163.com>
References: <20260108074929.356683-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S10
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw4UArW7KFy7Aw43XFy3XFb_yoWkKrc_Ww
	1v9rWjgryYqa1fKrsrCw43KFZa9a18Cr1jkr1xAF17X39rJrZ3AF1DZasFyrW7Kr4fGF9x
	ZrWktrn3t3W0kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0ebyJUUUUU==
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BC2VGlfYbBpTAAA3I

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get supports cache buffer head, we can use this option to
reduce sb_bread calls when fetching consecutive entries.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index b806e7f5b00f..025b39b7a9ac 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -238,6 +238,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
 	unsigned int content, fclus;
 
@@ -265,7 +266,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	while (fclus < cluster) {
-		if (exfat_ent_get(sb, *dclus, &content, NULL))
+		if (exfat_ent_get(sb, *dclus, &content, &bh))
 			return -EIO;
 
 		*last_dclus = *dclus;
@@ -279,6 +280,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			cache_init(&cid, fclus, *dclus);
 	}
 
+	brelse(bh);
 	exfat_cache_add(inode, &cid);
 	return 0;
 }
-- 
2.43.0


