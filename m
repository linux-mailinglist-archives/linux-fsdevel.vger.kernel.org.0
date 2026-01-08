Return-Path: <linux-fsdevel+bounces-72799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7BD0413B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF9BE315978B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5338F941;
	Thu,  8 Jan 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AcC97m1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1C37A487;
	Thu,  8 Jan 2026 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859227; cv=none; b=TRfhry6iOGxzh31RuLVK5CREdMrqlDr9N327mWuXp89K3lzxMKN+R+IWG7FbEjNZ0S3jh7QFF2MIm4UHGzrYuP0EWFa/Tbm6gey8to6+kCSLBfrrpVxwW9Y3pNWqcMeCvn15zkCCJJonmjeavih2YaZNo40o1YdfQaZ7IshMFi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859227; c=relaxed/simple;
	bh=KFDjjHQMGONb8J4b+tYkWmQRkxoUUJuQ0opPNpvCJw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5RwKf6u3kX1l6R83FLh9ukuhUEyTvbvZqQhj1fBsxsPBpebRMGbnI36vjon31NmmI0+YK8xtMSGpWKLOaogVgf6dtPEqYMLKcidt1hi5k+MHfMqLVovJxhwgws92xRSZvAe6sWm75LzWIRJFp/chkYIpAs3ypl8ItbnlpGFQe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AcC97m1z; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bB
	T8zRUkdsq1H29xCJ8P//81vCZnZtxN26jIYlLDdrY=; b=AcC97m1zO7/sv91eDA
	usHg+CbLOtaQp9ucdx53TkYt/h1Y0YCIBvbLQ9qw6Z3Sl35MTyNe1EdfhXTItllJ
	fRnxE7DNaUlJUj9IyymJSfmnsWRz4Jpf6TFMDGnCWf+ApK2tRSw17eBChMOi2EK6
	WClVKD0wC1FWJxY/qQVnCvGr0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3Jz_tY19p97UbFg--.6618S3;
	Thu, 08 Jan 2026 15:59:42 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 12/13] exfat: return the start of next cache in exfat_cache_lookup
Date: Thu,  8 Jan 2026 15:59:37 +0800
Message-ID: <20260108075938.360282-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108075938.360282-1-chizhiling@163.com>
References: <20260108074929.356683-1-chizhiling@163.com>
 <20260108075938.360282-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Jz_tY19p97UbFg--.6618S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFW8ZrW7ZFWUGr1DJFyxXwb_yoWrGr4Dpr
	Wxt3W5Jrs3Z347Jw4ftrs7Z34ruFWkGF47J343Gwn8Crn0kr4rurnrArnIyFWDKw18WF4a
	qr4rKw1Uur4DJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzMKZUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC+A5G42lfY+6OdgAA3Q

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


