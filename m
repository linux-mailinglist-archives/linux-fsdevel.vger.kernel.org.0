Return-Path: <linux-fsdevel+bounces-73691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B39D1EB40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD30830E9D7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280D397AA2;
	Wed, 14 Jan 2026 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ViobYtjC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEFF396D1A;
	Wed, 14 Jan 2026 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392843; cv=none; b=uyeVmSyWyYUOlKlivlMakfRgFH40nz15t6fq8Ofjh7n1lLt9wkOkdtUWL4dRoE6MULnWt+S7GNGmblUTd8azl4/QuO70u7vGhd4o8oYBUgY2tHs0oqSOij5cmac+l7NRx3z76DKsifdNfw5601mBATDjSvYP5yuc4VGV52B8nK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392843; c=relaxed/simple;
	bh=XiQcVI8iyJjioFbqheRyXGGGJfydAW9lCxKIUrohHcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awqG8Ap1rbcTkWSQNMmxV6IrKWLoNYv656U01JDFNztHjfgJSdnLc8FMiAisDP9WnHCcZeZSmgDhZ3ymoexx4cCP/YR9VMEKvLtEBPjEYtAxHdMngbNSIcVGt5SIAjSsPC3OP/1C6iQSuxXaR0jWKh/dbeLCtfMTsKgsSyrtDvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ViobYtjC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Nd
	W1o9/NUG6DMBFpSt0Qe8w80cOjc3DMl1FZTjd3HAo=; b=ViobYtjC58qV/gVsoc
	vOTURytuHqKVASXWNfsCT5hXvJuUH1jrltD8R8ZI7Jh+xSb2gXxRTsM2f+UToSuE
	GjGrWF1CJjuf4dcoj9Y+WxvjgWF/kG9Rc/MbHuFwa/qmALl+9BtYgDAgX4a2Xz/6
	IeTNXSW4hPFTFDD/5acCftaw8=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S10;
	Wed, 14 Jan 2026 20:13:20 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 08/13] exfat: reuse cache to improve exfat_get_cluster
Date: Wed, 14 Jan 2026 20:12:44 +0800
Message-ID: <20260114121250.615064-9-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
References: <20260114121250.615064-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S10
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4UArW7KFy7Ar4DAr48Crg_yoW8JrWxpr
	WUKa1UJrWrX3s7uw48tF4kZr4F9as7GF4UJa1UAr1UAryqyr1F9F17tF9Iy3WrAw4kur4a
	9FyrKw4j9wnrGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2JP_UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2wFuDGlniGHAFgAA3J

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get supports cache buffer head, we can use this option to
reduce sb_bread calls when fetching consecutive entries.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


