Return-Path: <linux-fsdevel+bounces-68917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D828EC6834E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BC8C0359399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69AD311946;
	Tue, 18 Nov 2025 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="K7Op5jgB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9E2D641C;
	Tue, 18 Nov 2025 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454413; cv=none; b=RItDNZ7gmFWJNHqRtDi8g3U/x/LE0sfZtafPOQmwcbJ5oo1vPjq1NG1O4A40zS0X8J+5ZXv5hYDeMi1txeMUxQxb8hUlnceqwkvgBH82gFBeXBcqsh56ALl+6e31M0Z3rtNAz2kHa0oBGh04B3sOic62oVAbb5ahZr8uHgb5M/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454413; c=relaxed/simple;
	bh=83CUkqg3DKZvhqPz7BeX2UXkFHH04US6sL7GjVRTLQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWkauelo4AG+ZPQs8BMa9J7J2sHlEmrn6ePAQPBb0DdBjkWWUhk870jZQDewF/s6FU2yeyV3ss0ZPhkk2GqUvSSDepZC7cMT7Uj+Z0fnQxH3U5BNxKph73Wxu0rEHfxFOu28++AvG+4UKWBAneHt0uUDWt5qXj+kpqVRy94UxgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=K7Op5jgB; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=U0
	7yPNefwy1OYQZSIN4NA7Tac2w5lWyx5VcfQ4rt6EI=; b=K7Op5jgBAj3tIU6Pnq
	qp89i4N/LWOMAsgybDgYxbcaowgtQovP4RUAhTGZ4lhwED2miA3SibaNawigFVEu
	M3McD/jIzBdOuHnDrgRed/6u8lwG2pQTNlYYzXziZhNr0+4B/WmwS909knaG/7k9
	wdQO1Td05YF3L1twxz/qPTIGU=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S5;
	Tue, 18 Nov 2025 16:25:45 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [RFC PATCH 3/7] exfat: reuse cache to improve exfat_get_cluster
Date: Tue, 18 Nov 2025 16:22:04 +0800
Message-ID: <20251118082208.1034186-4-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118082208.1034186-1-chizhiling@163.com>
References: <20251118082208.1034186-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15Gr4ftr4fXF43GF43GFg_yoW8Wr4kpr
	Z8KayUtrW5A397uw48KFn3Z3WS9FZ7Ja1UGa13A3Wjkryqyr4F9r17Kr9xA3WrJw48uF4Y
	9r15K3WUurnrG3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqOJnUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbBcxEKnWkcJZTfwgAAss

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get supports cache buffer head, we can use this option to
reduce sb_bread calls when fetching consecutive entries.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/cache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/cache.c b/fs/exfat/cache.c
index 61af3fa05ab7..a5e6858e5a20 100644
--- a/fs/exfat/cache.c
+++ b/fs/exfat/cache.c
@@ -241,6 +241,7 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 	unsigned int limit = sbi->num_clusters;
 	struct exfat_inode_info *ei = EXFAT_I(inode);
+	struct buffer_head *bh = NULL;
 	struct exfat_cache_id cid;
 	unsigned int content;
 
@@ -284,10 +285,10 @@ int exfat_get_cluster(struct inode *inode, unsigned int cluster,
 			exfat_fs_error(sb,
 				"detected the cluster chain loop (i_pos %u)",
 				(*fclus));
-			return -EIO;
+			goto err;
 		}
 
-		if (exfat_ent_get(sb, *dclus, &content, NULL))
+		if (exfat_ent_get(sb, *dclus, &content, &bh))
 			return -EIO;
 
 		*last_dclus = *dclus;
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


