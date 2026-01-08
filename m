Return-Path: <linux-fsdevel+bounces-72786-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02FD01E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3144134476B4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEED37F115;
	Thu,  8 Jan 2026 07:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="kK/T/Aik"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0A037C0F7;
	Thu,  8 Jan 2026 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858645; cv=none; b=RYI5yK6OLl43iqkQuztaw0tQJLWy1Nj56vOjyEcEVxUICrzsIyuNVuqs/yUdP2mOiveOpM5Yi6G/Uc1OyIb7DYSEVLTBicztjJjWk7GqG9c7o92Bv94lK96NbOKAFKEDAdB5bn36g9cLbQx6oTjtPGjoRB7spwBIuc3zqLaItUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858645; c=relaxed/simple;
	bh=HE6V/0UOeMQBZ0hAssNLXUXr473VmjRYbRgFeXZFWKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LMeJcY2vB0fBzT+0ueiA+iEqnhV4j7EaqJc37oV+0wFDFc8CE/c+L2D5W3CbwaxgAuBmy9zXpnScGKHs4Pld8se95H0MLAnYJFrsZXmy+8sBmjNN/wcC9Dx5qeHGR7Jv9zSpz2yAIJ1YG0DPf6A1akvkuMIyCPC/bfRzjDoLlsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=kK/T/Aik; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ja
	9ucSkOs+cj53nJ8yIQf/xYVaM4E7I6IgI47koblVM=; b=kK/T/AikOzw31aeK9v
	sQe4e6GP3m6Y6vPmbA6eMklw/roeLqwyRX+Lx1wDXRwtvChI+KM0wUDHkgwR7rLi
	dNRxfIO9Kqwv3Cb4Tp+CF5hvpDyRfGsTWT0wZw9QUxCjMWXz21MClqNNCqc00tiy
	XDJxTF7/9HsBfekFit10v9Liw=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S9;
	Thu, 08 Jan 2026 15:50:08 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 07/13] exfat: reduce the number of parameters for exfat_get_cluster()
Date: Thu,  8 Jan 2026 15:49:23 +0800
Message-ID: <20260108074929.356683-8-chizhiling@163.com>
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
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy5AryrGr45Jr1UKr1Dtrb_yoW5tFW3pr
	ZrKa48tay3Zayv9w48tr4kZa4S93Z7GayUJ3y3Aryqkr90yr409F1qyr9IyFyrGw4kua1j
	9FyYgw1j9rsrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2uWdUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xC2VGlfYbBtdgAA35

From: Chi Zhiling <chizhiling@kylinos.cn>

Remove parameter 'fclus' and 'allow_eof':

- The fclus parameter is changed to a local variable as it is not
  needed to be returned.

- The passed allow_eof parameter was always 1, remove it and the
  associated error handling.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c    | 27 +++++++++------------------
 fs/exfat/exfat_fs.h |  3 +--
 fs/exfat/inode.c    |  5 +----
 3 files changed, 11 insertions(+), 24 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index d51737498ee4..b806e7f5b00f 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -234,13 +234,12 @@ static inline void cache_init(struct exfat_cache_id *cid,
 }
 
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *fclus, unsigned int *dclus,
-		unsigned int *last_dclus, int allow_eof)
+		unsigned int *dclus, unsigned int *last_dclus)
 {
 	struct super_block *sb = inode->i_sb;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_cache_id cid;
-	unsigned int content;
+	unsigned int content, fclus;
 
 	if (ei->start_clu == EXFAT_FREE_CLUSTER) {
 		exfat_fs_error(sb,
@@ -249,7 +248,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return -EIO;
 	}
 
-	*fclus = 0;
+	fclus = 0;
 	*dclus = ei->start_clu;
 	*last_dclus = *dclus;
 
@@ -260,32 +259,24 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
-	exfat_cache_lookup(inode, cluster, &cid, fclus, dclus);
+	exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
 
-	if (*fclus == cluster)
+	if (fclus == cluster)
 		return 0;
 
-	while (*fclus < cluster) {
+	while (fclus < cluster) {
 		if (exfat_ent_get(sb, *dclus, &content, NULL))
 			return -EIO;
 
 		*last_dclus = *dclus;
 		*dclus = content;
-		(*fclus)++;
-
-		if (content == EXFAT_EOF_CLUSTER) {
-			if (!allow_eof) {
-				exfat_fs_error(sb,
-				       "invalid cluster chain (i_pos %u, last_clus 0x%08x is EOF)",
-				       *fclus, (*last_dclus));
-				return -EIO;
-			}
+		fclus++;
 
+		if (content == EXFAT_EOF_CLUSTER)
 			break;
-		}
 
 		if (!cache_contiguous(&cid, *dclus))
-			cache_init(&cid, *fclus, *dclus);
+			cache_init(&cid, fclus, *dclus);
 	}
 
 	exfat_cache_add(inode, &cid);
diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index f7f25e0600c7..e58d8eed5495 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -486,8 +486,7 @@ int exfat_cache_init(void);
 void exfat_cache_shutdown(void);
 void exfat_cache_inval_inode(struct inode *inode);
 int exfat_get_cluster(struct inode *inode, unsigned int cluster,
-		unsigned int *fclus, unsigned int *dclus,
-		unsigned int *last_dclus, int allow_eof);
+		unsigned int *dclus, unsigned int *last_dclus);
 
 /* dir.c */
 extern const struct inode_operations exfat_dir_inode_operations;
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f9501c3a3666..55984585526e 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -157,13 +157,10 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				*clu += clu_offset;
 		}
 	} else if (ei->type == TYPE_FILE) {
-		unsigned int fclus = 0;
 		int err = exfat_get_cluster(inode, clu_offset,
-				&fclus, clu, &last_clu, 1);
+				clu, &last_clu);
 		if (err)
 			return -EIO;
-
-		clu_offset -= fclus;
 	} else {
 		/* hint information */
 		if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
-- 
2.43.0


