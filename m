Return-Path: <linux-fsdevel+bounces-68913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5759BC68333
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 09:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D902434900B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 08:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8D30FC04;
	Tue, 18 Nov 2025 08:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iBJzTgqi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D63030EF82;
	Tue, 18 Nov 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763454406; cv=none; b=ofLgc4bhaVPrm5qFIzmaIoyG+GcRvpNfXYJcpAGzH2j4sEZWjSogSWCAmwlgcgAixxZqBFh49IlCwqQtDSIP9kebKPYfd4V4KsRiaYPaJzYGrr2L3kAWMl4FDWUsRlcJXWvmfzuyb+ow1fZgwZxxAw6/fFlXwMcO682b+oDN3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763454406; c=relaxed/simple;
	bh=4gg5VKImBGmYgPHL0iIJTSRE65yrULHZ2zCk5PapxfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPttZX8ugMGduORgye8Y0gYnWHJN6cfXx9xomZaXt8Qnz+PiaU3mQy1Mm+bZUhtL7zA6c1RwgdCpgKueXGnzZKuZxQOzA921nAB16MOtR7yOYouFySMRhxNLRGTOxmFVn43xXfdyCbBZWgUcHOvklyfkyJXhwNy2uM+AdzeVmNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iBJzTgqi; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=yb
	KPUqQ1A+oPrBVH99WIJIcNNPghHfyNmGDMMwRDSe4=; b=iBJzTgqiry3a7YweYm
	EBoD2bLS77N3zU9iquRHVhxVUH0JGfug9fI10SXRUoeD6O3bf+tqmmS8Qd6hlNAj
	g4Mtw8HA5feb0eaoBnza70BuzA7qq3AOtpMYE6stdR28TnO2ki5wBRz+qWnhaLii
	yuI6R+eCphPWWg6cv3AhvrpOI=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAnu_KILRxpyC6zEQ--.29019S3;
	Tue, 18 Nov 2025 16:25:44 +0800 (CST)
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
Subject: [RFC PATCH 1/7] exfat: add cache option for __exfat_ent_get
Date: Tue, 18 Nov 2025 16:22:02 +0800
Message-ID: <20251118082208.1034186-2-chizhiling@163.com>
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
X-CM-TRANSID:PigvCgAnu_KILRxpyC6zEQ--.29019S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XFyrZFy8WF1DKFy3Arb_yoW8Zr1Dpr
	ZxK34fKr4UX3WIvwnFyrs5Zw1fC397GFykG3y5Cw4fJF98trs5ZFyxtryYqF4xG3y8AFyY
	vF18tF1rCwsrWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzFALUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/1tbiFAMKnWkcJbehNgAEs0

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
index 825083634ba2..f9c5d3485865 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -36,18 +36,21 @@ static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
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
+		if (!bh)
+			return -EIO;
+	}
 
 	*content = le32_to_cpu(*(__le32 *)(&bh->b_data[off]));
 
@@ -55,7 +58,10 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	if (*content > EXFAT_BAD_CLUSTER)
 		*content = EXFAT_EOF_CLUSTER;
 
-	brelse(bh);
+	if (last)
+		*last = bh;
+	else
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


