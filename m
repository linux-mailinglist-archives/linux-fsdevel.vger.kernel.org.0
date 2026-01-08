Return-Path: <linux-fsdevel+bounces-72798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E8649D04138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E170303272E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797DB38F944;
	Thu,  8 Jan 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DCKGIA2l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922C038E126;
	Thu,  8 Jan 2026 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859227; cv=none; b=r2sVDMzEarTDDxjaCV55M1tAuglmlV1oJlPGqfDOfmWsQORqtMllzxgMwOrXzyyUwWsoqm39ddMx8q7RlGUT93segh1vX/s9Hx5ZAzjxRRNhf3ko/jFPaqZEXoEbx/TNwX2UDSEd6OQ56tXSA9/L4oIi8UDzVveMkLbbPolBAS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859227; c=relaxed/simple;
	bh=OL2HtuEf945mhs+DpsnOA++7TdiGb/pYLjCVrkg4R8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNiMtIWMF+je0giTUP5ooX4dxxm6ZP7BpjDsWdFSnTufim1T7/TOocHXp2oohfPumYizqvbCNivgxCzaa91cnL3sBf0Qv0AH2WbeUnWMSgAtJTGk1vAInTdZzWZI0iOjnLajIOxRMSybgo/6yGE4CEwJGg2rTEW9HeDUC86hIrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DCKGIA2l; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=vW
	wcXn2bgcjhiqS9sBeHCFRyzwnGiAocMyaEXUjnLrE=; b=DCKGIA2lTZHPbadx2f
	nzH2MJb6qzvQJBiwqeRdMgtr30MYTXvBqGH0cqliftj8MsEOddGrjQKrssuQCW+r
	aPf1L7U2jSthBywrLhIIeq2abnV+GXN39cboEdDk+CL2MQSNJM5lgcXUUULc6Y5y
	A+VGmMYQfUBw7JKCdW0xbu6Cc=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3Jz_tY19p97UbFg--.6618S2;
	Thu, 08 Jan 2026 15:59:41 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 11/13] exfat: tweak cluster cache to support zero offset
Date: Thu,  8 Jan 2026 15:59:36 +0800
Message-ID: <20260108075938.360282-1-chizhiling@163.com>
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
X-CM-TRANSID:_____wD3Jz_tY19p97UbFg--.6618S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWUWw47KrW5uF43trWDArb_yoW8Gw45pF
	W7ta45Grs3Za4DCa18tr1vva4rWa4kKF47J3W7Gw1Ykr1DCr40qw1DArnIy3WDKw48ArsF
	qr1ru3W5ur9xGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnHUgUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3A5G42lfY+4mmAAA3y

From: Chi Zhiling <chizhiling@kylinos.cn>

The current cache mechanism does not support reading clusters starting
from a file offset of zero. This patch enables that feature in
preparation for subsequent reads of contiguous clusters from offset zero.

1. modify exfat_cache_lookup() to find clusters with offset zero.
2. allow clusters with zero offset to be cached.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 025b39b7a9ac..73147e153c2c 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -92,7 +92,7 @@ static unsigned int exfat_cache_lookup(struct inode *inode,
 	spin_lock(&ei->cache_lru_lock);
 	list_for_each_entry(p, &ei->cache_lru, cache_list) {
 		/* Find the cache of "fclus" or nearest cache. */
-		if (p->fcluster <= fclus && hit->fcluster < p->fcluster) {
+		if (p->fcluster <= fclus && hit->fcluster <= p->fcluster) {
 			hit = p;
 			if (hit->fcluster + hit->nr_contig < fclus) {
 				offset = hit->nr_contig;
@@ -259,7 +259,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	if (cluster == 0 || *dclus == EXFAT_EOF_CLUSTER)
 		return 0;
 
-	cache_init(&cid, EXFAT_EOF_CLUSTER, EXFAT_EOF_CLUSTER);
+	cache_init(&cid, fclus, *dclus);
 	exfat_cache_lookup(inode, cluster, &cid, &fclus, dclus);
 
 	if (fclus == cluster)
-- 
2.43.0


