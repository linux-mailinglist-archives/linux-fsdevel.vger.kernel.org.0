Return-Path: <linux-fsdevel+bounces-79102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHWRIZFSpmkbOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:16:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116411E8653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43D6B305E9C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 03:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB77E37DE8C;
	Tue,  3 Mar 2026 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="nVA5AFcB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D5037CD29;
	Tue,  3 Mar 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507751; cv=none; b=ISCajUDxOkjevvHfkr+fzDKRocdwuMNahcdoLLbgGGanWNhRZKftCHcaBlH1beOCLYzDV1OLS91mGFpJzz81Jrnox+BrgNjyDxJI5X3StVG99ss1Hbc0joqXeMvnpshfatIYKzBuFp+1CosCa1Cjz8giPjd9BSaWX5BZO/LM41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507751; c=relaxed/simple;
	bh=w8rNkWEjUFCXjSAhc3cIFAG542b2c3mihzEDpHI9qfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tDBvD+LorvcV5rijQrv0/eNFMqtAq6fFCps8JPQa1SurgJdVDwaWWT2Epzbw4GwA+eT1Y6GxLFJIbVxl4bM/K7+Hk+4kehNsrc71TMAt1LeekkIwLm78dVFGnFMIU4uCRZaDA+Xst2XQ7UTzJHyxGgPBg4qBpiH1cyZOrPyVnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=nVA5AFcB; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ZL
	gy4MSlrRZC+zc/j95iZRJF8V8QJqf5zvBN0CeFOkQ=; b=nVA5AFcBaZsbMjh45q
	ixuwskp/2G0t72/HC0TatB++vsjmn5QBs6on1ixVXK/u15kK/Z+YlYkPATlXsIEn
	ZFgQ35pfKP88AI3IDKAJ7FH+twZPwdaRe4g9kFSYEZ0DcJ3YQB8sYcCIeAEiPGMZ
	Jr2lt2Z20Tu5ODcfdscNSpg+s=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S7;
	Tue, 03 Mar 2026 11:15:34 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 5/6] exfat: optimize exfat_chain_cont_cluster with cached buffer heads
Date: Tue,  3 Mar 2026 11:14:08 +0800
Message-ID: <20260303031409.129136-6-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303031409.129136-1-chizhiling@163.com>
References: <20260303031409.129136-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFy8tFyDXr48KF15tw1DKFg_yoWrJr1fpF
	ZIka93tr4UJ3ZFv3Z7tw4kXr1fC397J3WkGa13G34fAr90yFnY9ry8Kry8try0kayDuFyY
	vF4UtF15CwnrWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xatS2mmUlaMBgAA3G
X-Rspamd-Queue-Id: 116411E8653
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79102-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[chizhiling@163.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Action: no action

From: Chi Zhiling <chizhiling@kylinos.cn>

When converting files from NO_FAT_CHAIN to FAT_CHAIN format, profiling
reveals significant time spent in mark_buffer_dirty() and exfat_mirror_bh()
operations. This overhead occurs because each FAT entry modification
triggers a full block dirty marking and mirroring operation.

For consecutive clusters that reside in the same block, optimize by caching
the buffer head and performing dirty marking only once at the end of the
block's modifications.

Performance improvements for converting a 30GB file:

| Cluster Size | Before Patch | After Patch | Speedup |
|--------------|--------------|-------------|---------|
| 512 bytes    | 4.243s       | 1.866s      | 2.27x   |
| 4KB          | 0.863s       | 0.236s      | 3.66x   |
| 32KB         | 0.069s       | 0.034s      | 2.03x   |
| 256KB        | 0.012s       | 0.006s      | 2.00x   |

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 49 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 4177a933e0be..a973aa4de57b 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -32,6 +32,17 @@ static int exfat_mirror_bh(struct super_block *sb, struct buffer_head *bh)
 	return err;
 }
 
+static int exfat_end_bh(struct super_block *sb, struct buffer_head *bh)
+{
+	int err;
+
+	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
+	err = exfat_mirror_bh(sb, bh);
+	brelse(bh);
+
+	return err;
+}
+
 static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 		unsigned int *content, struct buffer_head **last)
 {
@@ -62,29 +73,40 @@ static int __exfat_ent_get(struct super_block *sb, unsigned int loc,
 	return 0;
 }
 
-int exfat_ent_set(struct super_block *sb, unsigned int loc,
-		unsigned int content)
+static int __exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content, struct buffer_head **cache)
 {
-	unsigned int off;
 	sector_t sec;
 	__le32 *fat_entry;
-	struct buffer_head *bh;
+	struct buffer_head *bh = cache ? *cache : NULL;
+	unsigned int off;
 
 	sec = FAT_ENT_OFFSET_SECTOR(sb, loc);
 	off = FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc);
 
-	bh = sb_bread(sb, sec);
-	if (!bh)
-		return -EIO;
+	if (!bh || bh->b_blocknr != sec || !buffer_uptodate(bh)) {
+		if (bh)
+			exfat_end_bh(sb, bh);
+		bh = sb_bread(sb, sec);
+		if (cache)
+			*cache = bh;
+		if (unlikely(!bh))
+			return -EIO;
+	}
 
 	fat_entry = (__le32 *)&(bh->b_data[off]);
 	*fat_entry = cpu_to_le32(content);
-	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
-	exfat_mirror_bh(sb, bh);
-	brelse(bh);
+	if (!cache)
+		exfat_end_bh(sb, bh);
 	return 0;
 }
 
+int exfat_ent_set(struct super_block *sb, unsigned int loc,
+		unsigned int content)
+{
+	return __exfat_ent_set(sb, loc, content, NULL);
+}
+
 /*
  * Caller must release the buffer_head if no error return.
  */
@@ -170,6 +192,7 @@ int exfat_blk_readahead(struct super_block *sb, sector_t sec,
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		unsigned int len)
 {
+	struct buffer_head *bh = NULL;
 	sector_t sec, end, ra;
 	blkcnt_t ra_cnt = 0;
 
@@ -183,14 +206,16 @@ int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		sec = FAT_ENT_OFFSET_SECTOR(sb, chain);
 		exfat_blk_readahead(sb, sec, &ra, &ra_cnt, end);
 
-		if (exfat_ent_set(sb, chain, chain + 1))
+		if (__exfat_ent_set(sb, chain, chain + 1, &bh))
 			return -EIO;
 		chain++;
 		len--;
 	}
 
-	if (exfat_ent_set(sb, chain, EXFAT_EOF_CLUSTER))
+	if (__exfat_ent_set(sb, chain, EXFAT_EOF_CLUSTER, &bh))
 		return -EIO;
+
+	exfat_end_bh(sb, bh);
 	return 0;
 }
 
-- 
2.43.0


