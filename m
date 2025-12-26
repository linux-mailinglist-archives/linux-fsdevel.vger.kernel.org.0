Return-Path: <linux-fsdevel+bounces-72103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F634CDE8FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37FAA302C22C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF63314B7C;
	Fri, 26 Dec 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kGsHo69a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E148A291864;
	Fri, 26 Dec 2025 09:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742340; cv=none; b=slk3vaQhGxtHDt64JYEh2KmbB8vsCdcMxfngkSS+/exZ34nsnaNf0HccJ/yptn8czmEbifqAv8OXlvuy2wNqRGLctisGr4R0dA4OgI0xaGcQ8lxVL9WUfDTsnm7a4I4kOfKBDoa8RjM1eonu6hmK3h+9FQuDcZgIA92Y1z+LAIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742340; c=relaxed/simple;
	bh=p7J1A3k1PpQP8t2VLMhQe+7FnsV9LZt/G8cGNkFQSdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sh/ggaRdeA0bq3IlI0Z+ohLY0VFaUWsunnl/+57Qzu27dYa3RNiAHo1dnYNV9Kes/b2DI6W56vU9zUTPdBvACVCO1B9UcIAmb4uBst1EpDEU8nsPtZykxbrx2IkEoxlyN2zzF3RZL1rnQ9nujWqOZ7PgJWgOkS5FQcoYEWLwe/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kGsHo69a; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=2z
	Kn3M2El0UGziHuxP9HkuCQv8bFi5A/9Zv8bRNdnds=; b=kGsHo69aQ6K/nbUAB9
	+1wIe9EDo0JO3noJAI3k0nP/rJyvdSBtMgSVtvEzzOiyXoGDV1B76L6lKyF36e5x
	IiwCt4JtNQSiE/5dcpPzPhhchMHsDGh01teHyhSYO4wfhFa71uZZh44h9MZlbmbn
	oOw4oRJ2zCE5XsoCPuYrdUaek=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S5;
	Fri, 26 Dec 2025 17:44:51 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 3/9] exfat: reuse cache to improve exfat_get_cluster
Date: Fri, 26 Dec 2025 17:44:34 +0800
Message-ID: <20251226094440.455563-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226094440.455563-1-chizhiling@163.com>
References: <20251226094440.455563-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4ftrW3Aw1fWF15Jwb_yoW8WF13pr
	ZxKay5t3yrA3929w4rKFn3Z3WS9FZ7JF4UGay3A3Wjkryvyr4F9r17Kr9xA3WrJw4kuF4Y
	9ryrK3WUurnrG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqYLkUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BNI5WlOWROBRAAA3u

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get supports cache buffer head, we can use this option to
reduce sb_bread calls when fetching consecutive entries.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 61af3fa05ab7..4161b983b6af 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -241,6 +241,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned int limit = sbi->num_clusters;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
 	unsigned int content;
 
@@ -284,11 +285,11 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			exfat_fs_error(sb,
 				"detected the cluster chain loop (i_pos %u)",
 				(*fclus));
-			return -EIO;
+			goto err;
 		}
 
-		if (exfat_ent_get(sb, *dclus, &content, NULL))
-			return -EIO;
+		if (exfat_ent_get(sb, *dclus, &content, &bh))
+			goto err;
 
 		*last_dclus = *dclus;
 		*dclus = content;
@@ -299,7 +300,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 				exfat_fs_error(sb,
 				       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
 				       *fclus, (*last_dclus));
-				return -EIO;
+				goto err;
 			}
 
 			break;
@@ -309,6 +310,10 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			cache_init(&cid, *fclus, *dclus);
 	}
 
+	brelse(bh);
 	exfat_cache_add(inode, &cid);
 	return 0;
+err:
+	brelse(bh);
+	return -EIO;
 }
-- 
2.43.0


