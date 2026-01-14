Return-Path: <linux-fsdevel+bounces-73694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB5D1EB0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D49A300AAC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9007D395245;
	Wed, 14 Jan 2026 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DHPupvco"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F39E38A28D;
	Wed, 14 Jan 2026 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393093; cv=none; b=Pkh5RCFYOjNk81EZr515hHYZcQFFExy8v2bzGnYnAnEhyPzEjE6morcP1SHrnAxS33TefeB85KLaKjrADsG9SVzdFNLUyPrZjoCw746Tl33w+pk0orJfFnTt0aH3jzdogUcvgvm3Q6hoauJaLb9PPcazYCvaSmCdN1AzRJtfahw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393093; c=relaxed/simple;
	bh=5CPnencKtvcQWuRvkrQVcepJuJk42Lwa9FBjfMpnkWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POC18WXBa+cP4QKbPKxrm8jjG1mZpJbQGG5RBHqNcB9u6rov8pXPihlZ6FdR+pHGEwvg0Bzf8yalhjbZftzrYjwfAZ60ZeNvO4xypCKwhgaIsUfLODeNzeUx6b469UBO42UZer0OXf3cgVupMs1LutHvS1vUF0ktrjxsZhTYk1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DHPupvco; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UI
	fjRH6grVewKiAQNlqkmnbVW08mAABKdCzAln6lWgM=; b=DHPupvcoNJ0e0qUyqk
	F6H5+7aqDeXodfz2MvWavn2Tz5n80bu+4/wpch/SDQ6FfPxfcaDQrvSu/RzsxnEc
	+yISpJBox7gOO577T+N9hVOEHimuM2UquOIhPq8wolU7jinhK1ODzxUsginpehOw
	UuMvCqRwIlCQOJe1Lr6nw8yEc=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnj1NuiWdpGyITGQ--.2745S2;
	Wed, 14 Jan 2026 20:17:51 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 11/13] exfat: tweak cluster cache to support zero offset
Date: Wed, 14 Jan 2026 20:17:47 +0800
Message-ID: <20260114121747.616098-1-chizhiling@163.com>
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
X-CM-TRANSID:_____wDnj1NuiWdpGyITGQ--.2745S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFWUWw47KrW5ury8Wr1rJFb_yoW8Xr4DpF
	W7ta45Grs3ZasrCa18tFn2vayrWa97Ka17Ja1UGw1Ykr1qkr40qwnFyrnIv3WDKw48CrsF
	qFyru3WUur9xGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joE_NUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2w+xT2lniW-P1QAA3Y

From: Chi Zhiling <chizhiling@kylinos.cn>

The current cache mechanism does not support reading clusters starting
from a file offset of zero. This patch enables that feature in
preparation for subsequent reads of contiguous clusters from offset zero.

1. support finding clusters with zero offset.
2. allow clusters with zero offset to be cached.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


