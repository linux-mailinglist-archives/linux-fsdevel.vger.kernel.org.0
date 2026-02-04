Return-Path: <linux-fsdevel+bounces-76260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPFaEibygmmWfQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:15:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1670E2945
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 08:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DF7630185B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 07:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3765B38551C;
	Wed,  4 Feb 2026 07:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="osS5b438"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ADF313546;
	Wed,  4 Feb 2026 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189345; cv=none; b=Z17xjMdD8KNCl0qMP297ZYn0YeRLbTU8sEo02FtUS5yvYWpkoYL0fnl5xRrcREBj9zKLdV77ss7ssIUYZBq4iK9lNBDVwa/HaCSSE0adwH7ahTcXivst7T+jnQqekVIiVWlTewjHDroXJ5RddjvLOZbTvlfgaYslc8srCZNwd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189345; c=relaxed/simple;
	bh=NYNeCRLV6ZEdY68BjJ2sAr6dRQ2tkDiACVjebo1IOB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPci0anW0h6Wg7GNTXqeXRehh0sHFk2EcPlKXwSD4Nwadou/iulmztl+oRsBGriCovjqlQsCkbSeBT1Bf8Zmag+M1Fvqc9PK2YJIiBW0g9Oeld0w9b1wACgQCtyZ0BsVZB7uNYbTLVuz/e0EDfV3yRYCGRoPvp0v3iIW3Nyd550=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=osS5b438; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=E/
	9fHCNe+H4gmmA4LGtv0N0cs93nINJi0IGoaOluvDg=; b=osS5b438vyr1BbupJ6
	Y2GliYXbgFTSZ1RE77H+wi3XZEHWkmcE57YSx9bGSLUXIdP9lXLoh/g/FITZ27YM
	5ESKrYp8/2JECrzSi4HY89/nbfsgrd860kH/mVXC7b17+RGtfVSPgW7Ph6a2XQoj
	EL4+/eTY5/v2BU5YC7cQrl2Hs=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgB3TegF8oJpYIHPNw--.186S3;
	Wed, 04 Feb 2026 15:15:20 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v1 1/3] exfat: add block readahead in exfat_chain_cont_cluster
Date: Wed,  4 Feb 2026 15:14:33 +0800
Message-ID: <20260204071435.602246-2-chizhiling@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204071435.602246-1-chizhiling@163.com>
References: <20260204071435.602246-1-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgB3TegF8oJpYIHPNw--.186S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw18GFWftrWUZr1kZryrJFb_yoW5uFWkpa
	nxCayftrWUGa47Ww4fKw1kJ3Wru3s7Gry5Gry3ur1rAryavrs3ur9rKryFqFWkt3y5Wa1j
	qF4YvFWjkrZrW37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzyIUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3Am5V2mC8glMpQAA3C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-76260-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1670E2945
X-Rspamd-Action: no action

From: Chi Zhiling <chizhiling@kylinos.cn>

The conversion from NO_FAT_CHAIN format to FAT_CHAIN format occurs
when the file cannot allocate contiguous space. When the file to be
converted is very large, this process can take a long time.

This patch introduces simple readahead to read all the blocks in
advance, as these blocks are consecutive.

Test in an empty exfat filesystem:
dd if=/dev/zero of=/mnt/file bs=1M count=30k
dd if=/dev/zero of=/mnt/file2 bs=1M count=1
time cat /mnt/file2 >> /mnt/file

| cluster size | before patch | after patch |
| ------------ | ------------ | ----------- |
| 512          | 47.667s      | 4.316s      |
| 4k           | 6.436s       | 0.541s      |
| 32k          | 0.758s       | 0.071s      |
| 256k         | 0.117s       | 0.011s      |

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h |  9 +++++++--
 fs/exfat/fatent.c   | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 2dbed5f8ec26..5a3cdf725846 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -10,6 +10,7 @@
 #include <linux/ratelimit.h>
 #include <linux/nls.h>
 #include <linux/blkdev.h>
+#include <linux/backing-dev.h>
 #include <uapi/linux/exfat.h>
 
 #define EXFAT_ROOT_INO		1
@@ -79,6 +80,10 @@ enum {
 #define EXFAT_HINT_NONE		-1
 #define EXFAT_MIN_SUBDIR	2
 
+#define EXFAT_BLK_RA_SIZE(sb)		\
+(min((sb)->s_bdi->ra_pages, (sb)->s_bdi->io_pages) \
+	 << (PAGE_SHIFT - sb->s_blocksize_bits))
+
 /*
  * helpers for cluster size to byte conversion.
  */
@@ -117,9 +122,9 @@ enum {
 #define FAT_ENT_SIZE (4)
 #define FAT_ENT_SIZE_BITS (2)
 #define FAT_ENT_OFFSET_SECTOR(sb, loc) (EXFAT_SB(sb)->FAT1_start_sector + \
-	(((u64)loc << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
+	(((u64)(loc) << FAT_ENT_SIZE_BITS) >> sb->s_blocksize_bits))
 #define FAT_ENT_OFFSET_BYTE_IN_SECTOR(sb, loc)	\
-	((loc << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
+	(((loc) << FAT_ENT_SIZE_BITS) & (sb->s_blocksize - 1))
 
 /*
  * helpers for bitmap.
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 71ee16479c43..0c17621587d5 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -142,13 +142,51 @@ int exfat_ent_get(struct super_block *sb, unsigned int loc,
 	return -EIO;
 }
 
+static int exfat_blk_readahead(struct super_block *sb, sector_t sec,
+		sector_t *ra, blkcnt_t *ra_cnt, sector_t end)
+{
+	struct blk_plug plug;
+
+	if (sec < *ra)
+		return 0;
+
+	*ra += *ra_cnt;
+
+	/* No blocks left (or only the last block), skip readahead. */
+	if (*ra >= end)
+		return 0;
+
+	*ra_cnt = min(end - *ra + 1, EXFAT_BLK_RA_SIZE(sb));
+	if (*ra_cnt == 0) {
+		/* Move 'ra' to the end to disable readahead. */
+		*ra = end;
+		return 0;
+	}
+
+	blk_start_plug(&plug);
+	for (unsigned int i = 0; i < *ra_cnt; i++)
+		sb_breadahead(sb, *ra + i);
+	blk_finish_plug(&plug);
+	return 0;
+}
+
 int exfat_chain_cont_cluster(struct super_block *sb, unsigned int chain,
 		unsigned int len)
 {
+	sector_t sec, end, ra;
+	blkcnt_t ra_cnt;
+
 	if (!len)
 		return 0;
 
+	ra_cnt = 0;
+	ra = FAT_ENT_OFFSET_SECTOR(sb, chain);
+	end = FAT_ENT_OFFSET_SECTOR(sb, chain + len - 1);
+
 	while (len > 1) {
+		sec = FAT_ENT_OFFSET_SECTOR(sb, chain);
+		exfat_blk_readahead(sb, sec, &ra, &ra_cnt, end);
+
 		if (exfat_ent_set(sb, chain, chain + 1))
 			return -EIO;
 		chain++;
-- 
2.43.0


