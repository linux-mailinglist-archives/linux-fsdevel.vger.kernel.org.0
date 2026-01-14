Return-Path: <linux-fsdevel+bounces-73685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB8D1EAF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F019B30B0973
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31306397AB6;
	Wed, 14 Jan 2026 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Hhe/ZZVD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A035BDD9;
	Wed, 14 Jan 2026 12:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392824; cv=none; b=FysqlsfsnWncs4uO9qdkg/QdbwGpAN1lUaP3FOENVryX5tFj61AGattu/OiaZqWXL2a3xylbXuXJOeeSre/iyrBtCMHVOOAMPo8N8WCMqPoufEwpdm7oDc+eefeCrkPT3ZZ24Bgsecd+0rtyaWrgp2Kz28n/U6pDlE7kM86Mtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392824; c=relaxed/simple;
	bh=wSHkmJtxa0bvUNFSipEAHSRDbWgO6APGZwVjSWO54y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSWldLgVu2+0aBKBZRQFr1qc7vaVnp58xbjYLRrDrWZqTU/xodR0Ck2i6Nzw92lbZzXhcI7hhPHoMVaGay9a45A611GCz4M/QBg5eQ11sKvRbHJkYmAJvKXlNWjJJV+sZrrTTTrvP481Sjnhhmsxegbmmx1JUxfjDz729Lat1cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Hhe/ZZVD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9z
	VD//8PA5fsQMoyhVWewQB2gVZ6awGsGvMm6NPrBhg=; b=Hhe/ZZVDQnzyUUeNEG
	Pq27W+Wmj+grYvx2HVK05EvtMA8C1HZEi6QrJGaJ3I3RhY4rezQq+vr2rumsFCly
	5Oxt+fDhgzGP+j8s0y+inbhbe2fWaVwcQRaZ+E+CxKH1AbOBLTxEkdmKMczHtK8x
	kVY73sfgnHoAxVcFV0EdcyTng=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S3;
	Wed, 14 Jan 2026 20:13:17 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 01/13] exfat: add cache option for __exfat_ent_get
Date: Wed, 14 Jan 2026 20:12:37 +0800
Message-ID: <20260114121250.615064-2-chizhiling@163.com>
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
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XFyrZFy8WF1kXrW5ZFb_yoW8ZFy3pr
	ZxK34fKr4UX3W293ZFyrs5Z3WrCa97GFykGay5Cws3Jryrtr1kZryxtryYvF4xJ3y8AFyY
	vF1UKF1rCwnrWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzhFxUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC2x5tC2lniF6-6gAA3u

From: Chi Zhiling <chizhiling@kylinos.cn>

When multiple entries are obtained consecutively, these entries are mostly
stored adjacent to each other. this patch introduces a "last" parameter to
cache the last opened buffer head, and reuse it when possible, which
reduces the number of sb_bread() calls.

When the passed parameter "last" is NULL, it means cache option is
disabled, the behavior unchanged as it was.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
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


