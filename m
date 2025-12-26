Return-Path: <linux-fsdevel+bounces-72101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEEFCDE8D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860CE300CCE6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE53831576C;
	Fri, 26 Dec 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="S5CxqTyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4FB7640E;
	Fri, 26 Dec 2025 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742339; cv=none; b=almz8ETNqMqi8XA191G9UKi4z3xv2IluFJtDSu4Hdsz36nC+7kFRVRAxWOLQU+TH1WT+BzVf3VWjCUcEk1ehQd6xJTT6+1C3ma5rSGYpxVzsF0gWAYujHauWaLn1HJeMQhQoliVR6AHiYP7dQpRYNRJRIW1NEJPXWuIjiC8PYiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742339; c=relaxed/simple;
	bh=Tokd7pF/jDlONJOJuFx6h8nJ4mrtbxR7j0Ky9FMdiD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEFQHqWfcQ15cIOSST36UdpD2IzOUlY21FhsndNpgs+6Xkt3s3A4mwLSTsRkM5gLmkey7cANqjo3pkQ1FTjVbSox9UMaQTSxSt1mO3f5ecvtG1FkUQp3eQ5j6CEyvX3eTA4mfd6eghtRZeGf49gPerZvOcRuKHPZePvRXLgc0ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=S5CxqTyi; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=el
	zMfq9IHeX1Psy38gcRlurD9UoTomtRfBJj6fK48OM=; b=S5CxqTyiax1dZDOzzd
	d+7wi885tl3Jm9cwTfvd+l67N6ARVSGGyxp9WcYDR3nOMNe7oCH4U+888iL2VxDA
	0sh+PrsaGT74TZxtfr8x+8U0+0zsWH11MFqX8xEBc/uJYFoufv+eVcaC4YQhco1n
	hBaGYTBCw5+JuuziJb+M7Lu4c=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S9;
	Fri, 26 Dec 2025 17:44:53 +0800 (CST)
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
Subject: [PATCH v1 7/9] exfat: tweak exfat_cache_lookup to support zero offset cluster
Date: Fri, 26 Dec 2025 17:44:38 +0800
Message-ID: <20251226094440.455563-8-chizhiling@163.com>
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
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S9
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWDZrW7GF1fJw43Cw13XFb_yoW5GFykpF
	W7Kay5trs3ZayDCw48tws7Z34fua4kKF47Jw17Gw15Cryqyr40gF1DArnxAF4UGw48Cw42
	qF1rKw17ursrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnJ5OUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+BZJ5mlOWRaBdQAA3d

From: Chi Zhiling <chizhiling@kylinos.cn>

The current cache mechanism does not support reading clusters from zero
file offset, so this patch modifies the exfat_cache_lookup function to
enable the cache to support multiple contiguous clusters which starting
from a zero offset, preparing for subsequent reads of contiguous clusters
from the zero offset.

Additionally, this patch removes unreachable WARN debugging code.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 43a6aa87c55d..57a66c067394 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -80,19 +80,19 @@ static inline void exfat_cache_update_lru(struct inode *inode,
 		list_move(&cache->cache_list, &ei->cache_lru);
 }
 
-static unsigned int exfat_cache_lookup(struct inode *inode,
+static bool exfat_cache_lookup(struct inode *inode,
 		unsigned int fclus, struct exfat_cache_id *cid,
 		unsigned int *cached_fclus, unsigned int *cached_dclus)
 {
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	static struct exfat_cache nohit = { .fcluster = 0, };
 	struct exfat_cache *hit = &nohit, *p;
-	unsigned int offset = EXFAT_EOF_CLUSTER;
+	unsigned int offset;
 
 	spin_lock(&ei->cache_lru_lock);
 	list_for_each_entry(p, &ei->cache_lru, cache_list) {
 		/* Find the cache of "fclus" or nearest cache. */
-		if (p->fcluster <= fclus && hit->fcluster < p->fcluster) {
+		if (p->fcluster <= fclus && hit->fcluster <= p->fcluster) {
 			hit = p;
 			if (hit->fcluster + hit->nr_contig < fclus) {
 				offset = hit->nr_contig;
@@ -114,7 +114,7 @@ static unsigned int exfat_cache_lookup(struct inode *inode,
 	}
 	spin_unlock(&ei->cache_lru_lock);
 
-	return offset;
+	return hit != &nohit;
 }
 
 static struct exfat_cache *exfat_cache_merge(struct inode *inode,
@@ -261,19 +261,8 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	if (cluster == 0 || *dclus == EXFAT_EOF_CLUSTER)
 		return 0;
 
-	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
-
-	if (exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus) ==
-			EXFAT_EOF_CLUSTER) {
-		/*
-		 * dummy, always not contiguous
-		 * This is reinitialized by cache_init(), later.
-		 */
-		WARN_ON(cid.id != EXFAT_CACHE_VALID ||
-			cid.fcluster != EXFAT_EOF_CLUSTER ||
-			cid.dcluster != EXFAT_EOF_CLUSTER ||
-			cid.nr_contig != 0);
-	}
+	cache_init(&cid, fclus, *dclus);
+	exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
 
 	if (fclus == cluster)
 		return 0;
-- 
2.43.0


