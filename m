Return-Path: <linux-fsdevel+bounces-72795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DFD01B77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 10:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72BFD3708985
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061023803DB;
	Thu,  8 Jan 2026 07:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XOrDxPyf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5651637E2F9;
	Thu,  8 Jan 2026 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767858655; cv=none; b=BKVRfYPwItgsPqIWeEnzamvi+MGhZCHVq22/sr1FJFp1MwFUpAdLBICqT/xo11B+3NpR92xXIB3YU703NPoGPmUKv6XIxLZzXftss9WSTHLTd+AYkm1g78ys8Cyz0ejfoB/oEd98m4ATqtrbpUBZeUrmuhx3QsK+vM2KGvbBic4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767858655; c=relaxed/simple;
	bh=Xb8C2JLdNadFXnGNd/14DTutB+ouyLvTF+ynAxnMW9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hN7Cl3cZz+7XJVxF1b29d1PM2+xNYjy5lAqepu5luAdVIN8N7aHVFd1qKT9NyF2rb3EBA5HZGMNyQe/6qye5a/yLNEkk8Od3o0zqUCtLbg9EmGkIakp7LV+R0Zi7eb55Vafkoc8puH5nHgwK6fVUtJ1JMgwbCmIM5+Y5fVJUizs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XOrDxPyf; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0v
	htbSvbnQVcK4ilcpDDyTdPLbheiLDwPIzUu6QCadA=; b=XOrDxPyfJGoHGnD9wE
	VSd143scrrdvBUaOrCZDxtFerP72jkIbVxnnZzbeWZRg/pXbsi7ADsOygVUclOZ+
	e9IXMAeB5JMyB3plX6v3vGY8s0SajAnbzkhcqQn4f3R67EfLNmqgj6Wme6FpBv/K
	VNMHZeFYr6y6rv1g413/3LpwE=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBH6+WpYV9pdSx_Eg--.889S3;
	Thu, 08 Jan 2026 15:50:06 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 01/13] exfat: add cache option for __exfat_ent_get
Date: Thu,  8 Jan 2026 15:49:17 +0800
Message-ID: <20260108074929.356683-2-chizhiling@163.com>
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
X-CM-TRANSID:_____wBH6+WpYV9pdSx_Eg--.889S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XFyrZFy8WF1DKFy3Arb_yoW8Zry5pr
	ZxK34fKr4UX3W2v3ZFyrs5Zw1rC397GFyDGw45Cws3Jryrtr4kZryxtryYqF4xJ3y8AFWY
	vF1UtF15CwsrWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzhFxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3A61U2lfYa4AnQAA3Q

From: Chi Zhiling <chizhiling@kylinos.cn>

When multiple entries are obtained consecutively, these entries are mostly
stored adjacent to each other. this patch introduces a "last" parameter to
cache the last opened buffer head, and reuse it when possible, which
reduces the number of sb_bread() calls.

When the passed parameter "last" is NULL, it means cache option is
disabled, the behavior unchanged as it was.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index c9c5f2e3a05e..0cfbc0b435bd 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -36,18 +36,23 @@ static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
 }
 
 static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
-		unsigned int *content)
+		unsigned int *content, struct buffer_head **last)
 {
 	unsigned int off;
 	sector_t sec;
-	struct buffer_head *bh;
+	struct buffer_head *bh = last ? *last : NULL;
 
 	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
 	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
 
-	bh = sb_bread(sb, sec);
-	if (!bh)
-		return -EIO;
+	if (!bh || bh->b_blocknr != sec || !buffer_uptodate(bh)) {
+		brelse(bh);
+		bh = sb_bread(sb, sec);
+		if (last)
+			*last = bh;
+		if (unlikely(!bh))
+			return -EIO;
+	}
 
 	*content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
 
@@ -55,7 +60,8 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	if (*content > EXFAT_BAD_CLUSTER)
 		*content = EXFAT_EOF_CLUSTER;
 
-	brelse(bh);
+	if (!last)
+		brelse(bh);
 	return 0;
 }
 
@@ -95,7 +101,7 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 		return -EIO;
 	}
 
-	err = __exfat_ent_get(sb, loc, content);
+	err = __exfat_ent_get(sb, loc, content, NULL);
 	if (err) {
 		exfat_fs_error_ratelimit(sb,
 			"failed to access to FAT (entry 0x%08x, err:%d)",
-- 
2.43.0


