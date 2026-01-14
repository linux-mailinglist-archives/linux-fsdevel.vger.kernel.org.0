Return-Path: <linux-fsdevel+bounces-73693-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA70D1EADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A11A4301E69D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA8D39526E;
	Wed, 14 Jan 2026 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RBduyib9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5591C37C104;
	Wed, 14 Jan 2026 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392952; cv=none; b=ac6Ww8VTskP0jgt5xrjrpZIw94qFCcsfiK5M7LIhqfyoqyB2nNOCq8JzX8qSZ0U8Enhf3gHCKd5Gz4yHVQvuaMtY2eJS0QqsNEDNgrwPoQItPxISdoseuaund+GMJFf5+V5f/mHDgQc3oyanQG1GVOPhkcsP0Y2/GIG2KN4tDkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392952; c=relaxed/simple;
	bh=kFA90oIXr+aBGkIf+9o0bpUAsXrYNksrybzcbm+Yj3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRinP+BCTO2kidNyK9Fxk3yo96J7GECJmF1nBd2s95UPp+pBY4R2Q/21yUjU7U8BWNNJaGOmEE0S5WfLcu1ihlFxCvtC1uI3LoulEKn9JzsoWQ9ITXpQR1iWSm/aHACvLAU7/aEbLu3/Hr+65CFVEWybrdeRyVqmSBI+CxbVgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RBduyib9; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=B0
	Yc94LlFx90W4ro8+TYnrF+5U2is51KIPdGBdhy1Gc=; b=RBduyib9EuceBBrKnh
	pwfy/UMQUFaeYKD3LhXrQdg5EnGJGm181PvO+R5h8Uj4jLfyMGhky2+X3HD2pK6u
	SGskdpD4LhFKxYciL7+zvcDoPvLdkS35N4rdLStDwd9jd8zYNrZASto7yRSOiqmu
	x0aDpG65Q77PatpavZrfx+czs=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S11;
	Wed, 14 Jan 2026 20:13:21 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 09/13] exfat: remove handling of non-file types in exfat_map_cluster
Date: Wed, 14 Jan 2026 20:12:45 +0800
Message-ID: <20260114121250.615064-10-chizhiling@163.com>
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
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S11
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw1fXF1fXF13Ar1DuFWxZwb_yoW8Gry7pr
	srGa4kKFWrXay7KF40gFs3Z343G3Z7GrWkXFW7Ar15Kr9Yyr1FvanFkr1xC3WUC3y8CFWY
	g3W3Gr4a9rnxGFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2NtxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3AFuDGlniGG3-gAA3R

From: Chi Zhiling <chizhiling@kylinos.cn>

Yuezhang said: "exfat_map_cluster() is only used for files. The code
in this 'else' block is never executed and can be cleaned up."

Suggested-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


