Return-Path: <linux-fsdevel+bounces-73690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADFCD1EAB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93CFD3017107
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B0B397AA5;
	Wed, 14 Jan 2026 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Qb/YuNtx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270A397AA3;
	Wed, 14 Jan 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392838; cv=none; b=hQBTD6wuqyZbQRk2Qs4VGCpyuclJy/blqE3x1HdaZVrucCMVAL8KFkOaeyCJZXLmX0oNfPZ93qbr6uO1GRUWtFz553QNwjz7zbAWb2pUnPvpVXIWmbbdEypYOS0+UEHL/RYgtuabmywHSxRMitNtV2czj0QbgIo1zJxC1bbsAp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392838; c=relaxed/simple;
	bh=KDXCotxwONhP6zSVi8AxEprmMBsQQ9R3cNSremX6cQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBk22WJtM/fepFZMJ6djBwQRg6rovq1yZQbbJHfhL09IibA2e5xibtDxkrmZY2S+i8USlUyN3x6WT+oGawY+b3Z5FYSOjySf6HknrIvYGKDid+zGsXxytufUiI3ei3WHAacFz2KTOa2iNV0wCB1azTVIM2hrH7YhKveU/xMJnKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Qb/YuNtx; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=o2HGJiUZh+JR18pAIXg9PAYBhKH/qnGqd4T6Crk2TrI=;
	b=Qb/YuNtxOzxIwuRKSEFRgH8u+Wwa2esWCXBeXVWLMUYPe6ThYLfQvAQcQpAokt
	0bc2wxq6puhf4V2ErLWXuuDwXOoTLw5Ttumc/voFa39P7B98jLTYdLUWM/Ou6QDB
	iuHETwtMH+FE9EebIDh+EzmW5tipX1gh5Slgf6U0TQWPQ=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S7;
	Wed, 14 Jan 2026 20:13:19 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 05/13] exfat: remove the check for infinite cluster chain loop
Date: Wed, 14 Jan 2026 20:12:41 +0800
Message-ID: <20260114121250.615064-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260114121250.615064-1-chizhiling@163.com>
References: <20260114121250.615064-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13Kr1DCr17tFy8uFWxWFg_yoW8XFWDpr
	WxKa15trW3J34Duw48trn7Xa4Skas7JF4xJan3G3Wjkw4qyrsYkrnxtr90kF98Gw1kWa1Y
	gr1Ygw4UuwnxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3B9tC2lniF+35wAA3s

From: Chi Zhiling <chizhiling@kylinos.cn>

The infinite cluster chain loop check is not work because the
loop will terminate when fclus reaches the parameter cluster,
and the parameter cluster value is never greater than
ei->valid_size.

The following relationship holds:
'fclus' < 'cluster' ≤ ei->valid_size ≤ sb->num_clusters

The check would only be triggered if a cluster number greater than
sb->num_clusters is passed, but no caller currently does this.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/cache.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 61af3fa05ab7..0ee4bff1cb35 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -238,8 +238,6 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		unsigned int *last_dclus, int allow_eof)
 {
 	struct super_block *sb = inode->i_sb;
-	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	unsigned int limit = sbi->num_clusters;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
 	struct exfat_cache_id cid;
 	unsigned int content;
@@ -279,14 +277,6 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 		return 0;
 
 	while (*fclus < cluster) {
-		/* prevent the infinite loop of cluster chain */
-		if (*fclus > limit) {
-			exfat_fs_error(sb,
-				"detected the cluster chain loop (i_pos %u)",
-				(*fclus));
-			return -EIO;
-		}
-
 		if (exfat_ent_get(sb, *dclus, &content, NULL))
 			return -EIO;
 
-- 
2.43.0


