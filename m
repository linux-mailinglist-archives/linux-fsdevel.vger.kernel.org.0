Return-Path: <linux-fsdevel+bounces-72105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85879CDE8E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 10:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0862300BD9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Dec 2025 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147353195EF;
	Fri, 26 Dec 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CvDIGtZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36D4314D12;
	Fri, 26 Dec 2025 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766742342; cv=none; b=hJW7gK+8EbxUV9Hu7kqI6A7es5wdx6GTeUSAB7vQZPoFbqwGGsysb6Cs1QLjmBZ+jul612cHOsp6zEPJ8zY2/5f3nd8NqZsqpKIEfNxuN2+f8dhqkepT7e6rwUhh8zWS+Qs/2WNsJjqwTQXT7T5XDa1unVq0JlGtqzlxL/Qa/us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766742342; c=relaxed/simple;
	bh=Xb8C2JLdNadFXnGNd/14DTutB+ouyLvTF+ynAxnMW9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXS+V3srleGVk7hgEt4R931h5KGpnt5spGm+PE7OmfKRXDim4B0bTHPNk/AzwmX6QvHhREprsm4BU22JzTbF6AdNMwJSnE0rYhxLXMmriq24vLnQNee/Vavdqz02F+jpmpuKF9qid9a4XLDxPpcTfHWrAWb8Wh6iF7Tqpx3Qenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CvDIGtZV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0v
	htbSvbnQVcK4ilcpDDyTdPLbheiLDwPIzUu6QCadA=; b=CvDIGtZVkBYLyVrzFe
	0LXMhQROtoPXVr4L72bvG5/Lh9hCWhDOkn7ej2Y1a3pbejy3hjgm8XKj1gXXfCms
	5Xd5hnR52GlPySWxkwcyaheGEnM49iU+Dv6/uNvSlHbvUvtvyLZRfpMbfKEifJG0
	WbwhQx818NbPscwX7tWUBotas=
Received: from chi-Redmi-Book.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCnlXIPWU5p9JFCJA--.53S3;
	Fri, 26 Dec 2025 17:44:50 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 1/9] exfat: add cache option for __exfat_ent_get
Date: Fri, 26 Dec 2025 17:44:32 +0800
Message-ID: <20251226094440.455563-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251226094440.455563-1-chizhiling@163.com>
References: <20251226094440.455563-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCnlXIPWU5p9JFCJA--.53S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF13XFyrZFy8WF1DKFy3Arb_yoW8Zry5pr
	ZxK34fKr4UX3W2v3ZFyrs5Zw1rC397GFyDGw45Cws3Jryrtr4kZryxtryYqF4xJ3y8AFWY
	vF1UtF15CwsrWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz2NtUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xNI5WlOWROHCgAA3p

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


