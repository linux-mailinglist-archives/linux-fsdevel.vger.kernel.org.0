Return-Path: <linux-fsdevel+bounces-73695-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC66D1EB25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE96430146D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96734399009;
	Wed, 14 Jan 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ePEbt6Qg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E994E396D23;
	Wed, 14 Jan 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393105; cv=none; b=jnlep1wYOvyohvmpRki1effDXJp0ggg+ELlUfMXWDQmCErf4lXgD8FDcSzQ1/kcSIkIkgS2pj5mU36qGjIPhC3a2r0R3Y/9Zwg+N+vslMuuMqUbw7yB35i5mn38MuQ5MLNPiC2MTGNuMWdBy78IhmaOahCsQohdeVyzrYdksyTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393105; c=relaxed/simple;
	bh=fnGVWejw8CBd4O40/UTXEaVE5/JOd8E0KH2F7dASF1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3gnlkJx6vkZziqPcmzSDX8akJxtVo7NfJamv6BYJW2Cnh7TLm2TeFI6Etou1H5LYL8whUDVBHm9Ufd2mG3BXueHSI4dU2g2J5ggvlmUnsOtkfPw//YXiWIkQzipiGVNyXCZqpzeZ0TjdMNHrjF1PngffptDTi82+GKc3Oyca54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ePEbt6Qg; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=1G
	jRKHO+YzW588aUda2BoS5KFPmuHGwkOhmS06xeg2k=; b=ePEbt6Qg0MiRsRMiud
	UlmTBVMgqUXqqR3SgvjlBDw2+Kk3Yfg7YuQiJCC2JGyHzaeqmm9zxVYNGQh39OIJ
	CiewDlyxEKZmH2o9lfYthkp1o6mf7njHptq6Vy3QoyQ1sw7DApmw52lUMKL1Z7ig
	g1se++e7l2l9yr5Uvnchgo/1M=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wAnDqx4iWdpb3z5Fw--.339S2;
	Wed, 14 Jan 2026 20:18:01 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 12/13] exfat: return the start of next cache in exfat_cache_lookup
Date: Wed, 14 Jan 2026 20:17:58 +0800
Message-ID: <20260114121758.616122-1-chizhiling@163.com>
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
X-CM-TRANSID:_____wAnDqx4iWdpb3z5Fw--.339S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW8ZrW7ZFWUGr1DJFyxXwb_yoWrGFy5pr
	Wxt3W5Jrs3Z347Ga1ftrs7Z34ruaykGF47J343Gwn8Crn09r4rurnrArnIyFWDKw18WF4a
	qr45Kw1Uur4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joksgUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3Bm0UmlniXnIVwAA3C

From: Chi Zhiling <chizhiling@kylinos.cn>

Change exfat_cache_lookup to return the cluster number of the last
cluster before the next cache (i.e., the end of the current cache range)
or the given 'end' if there is no next cache. This allows the caller to
know whether the next cluster after the current cache is cached.

The function signature is changed to accept an 'end' parameter, which
is the upper bound of the search range. The function now stops early
if it finds a cache that starts within the current cache's tail, meaning
caches are contiguous. The return value is the cluster number at which
the next cache starts (minus one) or the original 'end' if no next cache
is found.

The new behavior is illustrated as follows:

cache:  [ccccccc-------ccccccccc]
search: [..................]
return:               ^

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/cache.c | 49 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 73147e153c2c..5cdeac014a3d 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -80,41 +80,66 @@ static inline void exfat_cache_update_lru(struct inode *inode,
 		list_move(&cache->cache_list, &ei->cache_lru);
 }
 
-static unsigned int exfat_cache_lookup(struct inode *inode,
-		unsigned int fclus, struct exfat_cache_id *cid,
+/*
+ * Find the cache that covers or precedes 'fclus' and return the last
+ * cluster before the next cache range.
+ */
+static inline unsigned int
+exfat_cache_lookup(struct inode *inode, struct exfat_cache_id *cid,
+		unsigned int fclus, unsigned int end,
 		unsigned int *cached_fclus, unsigned int *cached_dclus)
 {
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	static struct exfat_cache nohit = { .fcluster = 0, };
 	struct exfat_cache *hit = &nohit, *p;
-	unsigned int offset = EXFAT_EOF_CLUSTER;
+	unsigned int tail = 0;		/* End boundary of hit cache */
 
+	/*
+	 * Search range [fclus, end]. Stop early if:
+	 * 1. Cache covers entire range, or
+	 * 2. Next cache starts at current cache tail
+	 */
 	spin_lock(&ei->cache_lru_lock);
 	list_for_each_entry(p, &ei->cache_lru, cache_list) {
 		/* Find the cache of "fclus" or nearest cache. */
-		if (p->fcluster <= fclus && hit->fcluster <= p->fcluster) {
+		if (p->fcluster <= fclus) {
+			if (p->fcluster < hit->fcluster)
+				continue;
+
 			hit = p;
-			if (hit->fcluster + hit->nr_contig < fclus) {
-				offset = hit->nr_contig;
-			} else {
-				offset = fclus - hit->fcluster;
+			tail = hit->fcluster + hit->nr_contig;
+
+			/* Current cache covers [fclus, end] completely */
+			if (tail >= end)
+				break;
+		} else if (p->fcluster <= end) {
+			end = p->fcluster - 1;
+
+			/*
+			 * If we have a hit and next cache starts within/at
+			 * its tail, caches are contiguous, stop searching.
+			 */
+			if (tail && tail >= end)
 				break;
-			}
 		}
 	}
 	if (hit != &nohit) {
-		exfat_cache_update_lru(inode, hit);
+		unsigned int offset;
 
+		exfat_cache_update_lru(inode, hit);
 		cid->id = ei->cache_valid_id;
 		cid->nr_contig = hit->nr_contig;
 		cid->fcluster = hit->fcluster;
 		cid->dcluster = hit->dcluster;
+
+		offset = min(cid->nr_contig, fclus - cid->fcluster);
 		*cached_fclus = cid->fcluster + offset;
 		*cached_dclus = cid->dcluster + offset;
 	}
 	spin_unlock(&ei->cache_lru_lock);
 
-	return offset;
+	/* Return next cache start or 'end' if no more caches */
+	return end;
 }
 
 static struct exfat_cache *exfat_cache_merge(struct inode *inode,
@@ -260,7 +285,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	cache_init(&cid, fclus, *dclus);
-	exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
+	exfat_cache_lookup(inode, &cid, cluster, cluster, &fclus, dclus);
 
 	if (fclus == cluster)
 		return 0;
-- 
2.43.0


