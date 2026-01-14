Return-Path: <linux-fsdevel+bounces-73683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACED1EAE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10DCC30640D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5585A396D31;
	Wed, 14 Jan 2026 12:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bVgX1Msk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D173D393DF0;
	Wed, 14 Jan 2026 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768392823; cv=none; b=oZ+jtTt89l5N/jPTbF+A4GFpjVP+5QRtlaRZ9XKxpHyUsaGxaPUfbftGuRxjp6Wv2RsmrGIhejrEwGsDztYSLBXalGTDn3664m4n+6+FLJTLGbCwuLRNQtM4342IdRunhSb+Njs3yBkCgMcKQiIdSruoDppmS1VslCdDjyqwq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768392823; c=relaxed/simple;
	bh=NW/VGH2Sry/Q+Tqpiz0QPIfYXbyj+zH9xmXmp1swjOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZMxFu4IowpGnClS0k6PpF2sl6efszBEFXV9tWKpIIjWhYU5t5ksnU2vXGflHxwNVxth48Supaok1gkLFdBgHrT4bs5YjEZV1YchIF+9wBx9kPssM+HLcRIbSWsgBzHrV3WSmImOfFXlZdIk+dpaDr9w18ifDpZwWDftKwZuDMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bVgX1Msk; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=IL
	d38vwGbbZHuYFWPWdYhYKP11kWC8j3xNXdzwzfSj8=; b=bVgX1MskjKpHpsJLh9
	sWTOaj1j1M/BKTXruAPOxD/9qrqp0uXw84Rc2zr5uFySh9cYgbbOnuSJbvZ/n1Qi
	C4fmrdbIHViUIqFSLblpg3Rb+ZpemzVhC9OoE0l7ckkgiIiA+cqLQR76FR3jKdQj
	Y0HqHfGoFlN0HibmYq8YTxqtY=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wAXybtbiGdpFdouGQ--.5056S6;
	Wed, 14 Jan 2026 20:13:18 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>,
	Yuezhang Mo <Yuezhang.Mo@sony.com>
Subject: [PATCH v3 04/13] exfat: improve exfat_find_last_cluster
Date: Wed, 14 Jan 2026 20:12:40 +0800
Message-ID: <20260114121250.615064-5-chizhiling@163.com>
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
X-CM-TRANSID:_____wAXybtbiGdpFdouGQ--.5056S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jw4UAryfCr15ur4rZFy8AFb_yoW8Jr1kpF
	WUCa15KrWrX3Wku3WUJFs3Z3Wfu3WxKF95CFW5Aw1Yy3s0qrnYyFy3tryayF4kJa1UKF1a
	gr1YgF1j9wsxGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UR6wtUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9x5tC2lniF56XQAA3w

From: Chi Zhiling <chizhiling@kylinos.cn>

Since exfat_ent_get support cache buffer head, let's apply it to
exfat_find_last_cluster.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
Reviewed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
---
 fs/exfat/fatent.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index f060eab2f2f2..71ee16479c43 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -296,6 +296,7 @@ int exfat_free_cluster(struct inode *inode, struct exfat_chain *p_chain)
 int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 		unsigned int *ret_clu)
 {
+	struct buffer_head *bh = NULL;
 	unsigned int clu, next;
 	unsigned int count = 0;
 
@@ -308,10 +309,11 @@ int exfat_find_last_cluster(struct super_block *sb, struct exfat_chain *p_chain,
 	do {
 		count++;
 		clu = next;
-		if (exfat_ent_get(sb, clu, &next, NULL))
+		if (exfat_ent_get(sb, clu, &next, &bh))
 			return -EIO;
 	} while (next != EXFAT_EOF_CLUSTER && count <= p_chain->size);
 
+	brelse(bh);
 	if (p_chain->size != count) {
 		exfat_fs_error(sb,
 			"bogus directory size (clus : ondisk(%d) != counted(%d))",
-- 
2.43.0


