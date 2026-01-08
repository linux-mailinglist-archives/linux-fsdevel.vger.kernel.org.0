Return-Path: <linux-fsdevel+bounces-72788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2BD01AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C355B3386CB1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D5E37F75B;
	Thu,  8 Jan 2026 07:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KYn1MCZK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A137BE7F;
	Thu,  8 Jan 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858650; cv=none; b=NgXr1NzLjlURszSWvP2qyglCAcnbhKTLTwij6oCEit9jTS8yuaWmPph1xMc220O89ib6k7caYjrQU3sQ2jfLe8tI2VhavFtEWW0YMF5z8cd6TZ3ypye8YGvQkYXe6JMMQVXOs6qOSTGSBR0ik/nig/7mCgb+BjmuRASfNHbdloc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858650; c=relaxed/simple;
	bh=qwy5WYsryk7/u5ceZx8Nqym3TssQZfowE9W3ezIsWWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejROZxa6Q8UpTakPqPdBSqgQbERHZFlz+6ZrTYE6JtwIJEkhvxNJVLIWLQSGHcDp4E7nv9a0vMeTIx/7jJD9KJb4JMXQGyb6fG9D0B4mOtbFGbnpDweuTHPqPL1FA2d/IAeZNZbKZTeUJgU5WFVffmQxToa8FJzD8BshVfTBuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KYn1MCZK; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Se
	lkJa8tRuMOUM18VkgbogIbooDqQw60hnJ00wkfYOY=; b=KYn1MCZKFIFa2BTiUE
	0UpYh3a7Yx9JJLQGy1Zdm2cDmGfQDp1sY0p1IT+N+cMelOpucqYvluvLHxpJo5t5
	k6vscLCrngUToNotpEIshnI+obxZJYmpFNbZlBjBktCuWFWK2aFHhZQU7eKMQPlm
	k1UavenGdPr0fGsjRfypTrKV0=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S11;
	Thu, 08 Jan 2026 15:50:08 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v2 09/13] exfat: remove handling of non-file types in exfat_map_cluster
Date: Thu,  8 Jan 2026 15:49:25 +0800
Message-ID: <20260108074929.356683-10-chizhiling@163.com>
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
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1fXF1fXrWDuF15uFW8Xrb_yoW8Jw1Upr
	srGa4kKay5Xay7KF40gFs3Z343J3Z7GrWDXFW7Ar1Ykr9Yyr1F9a9Fkr1xC3W8C3y8uFWY
	q3W3Gr4a9rnxGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2JP_UUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xC2VGlfYbBtkwAA3c

From: Chi Zhiling <chizhiling@kylinos.cn>

Yuezhang said: "exfat_map_cluster() is only used for files. The code
in this 'else' block is never executed and can be cleaned up."

Suggested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/inode.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 55984585526e..b714d242b238 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -156,27 +156,11 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 			else
 				*clu += clu_offset;
 		}
-	} else if (ei->type == TYPE_FILE) {
+	} else {
 		int err = exfat_get_cluster(inode, clu_offset,
 				clu, &last_clu);
 		if (err)
 			return -EIO;
-	} else {
-		/* hint information */
-		if (clu_offset > 0 && ei->hint_bmap.off != EXFAT_EOF_CLUSTER &&
-		    ei->hint_bmap.off > 0 && clu_offset >= ei->hint_bmap.off) {
-			clu_offset -= ei->hint_bmap.off;
-			/* hint_bmap.clu should be valid */
-			WARN_ON(ei->hint_bmap.clu < 2);
-			*clu = ei->hint_bmap.clu;
-		}
-
-		while (clu_offset > 0 && *clu != EXFAT_EOF_CLUSTER) {
-			last_clu = *clu;
-			if (exfat_get_next_cluster(sb, clu))
-				return -EIO;
-			clu_offset--;
-		}
 	}
 
 	if (*clu == EXFAT_EOF_CLUSTER) {
-- 
2.43.0


