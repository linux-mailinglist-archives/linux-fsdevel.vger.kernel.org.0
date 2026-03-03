Return-Path: <linux-fsdevel+bounces-79106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sD0MJNpSpmkbOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:17:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEF01E869E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 813A030EA5EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 03:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163D382290;
	Tue,  3 Mar 2026 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="UMhZfH+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AB837CD59;
	Tue,  3 Mar 2026 03:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507752; cv=none; b=Zvzjhs299IByg13yqV7ZB+0/IIFdWyfQTEkqsIwq4jQZ+7gmAkEmoDq2c/k6rShpgcd9ov0sEegkqe5YZPBjJQZ7Wt/tdi8pgwbIlhSXuCHg+CsHk7aYR99ffRHj8j1WJS0R/WLytbXuiCqnt1ZPimAJPqyZGsGLwcNjqgzp3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507752; c=relaxed/simple;
	bh=S3XS/C3umhS4PxygIwHBUUBspT4s7K00B9q9vPIy18w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqjTchB7LzNObnVNz8YYYparkJmsADnNgklH3gppZPkOqTKw61ZrtwbInunby77VVdpsNpg6K3XV1tSEUFYT3MPJtaPfRci10hvUb0KYZae6mAd653TszNg4Cg4uzeFmoXLt2CNqhXipMkh7Km8508+ZBELsLJTAv+NVX4ibuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=UMhZfH+T; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=4u
	bQFK0LEaJeIG3aAZbVDCQ8bN1lGZcO+MXK4SF9IZQ=; b=UMhZfH+T5Cqz4u5N36
	h0ScVtnI0uvtJEf8LQl+VqVMSfNaUH41s0feNTvDbjF7chvYntnSicfJcDB1NHLZ
	hawQ19NiwcieHod5DOuuIdTwKZDv1g6WO4KeYJQAtBT37Kz4r9O6++l0g1riUqy5
	63B6OOOSQD8gTZIBf7NH/g2N4=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S6;
	Tue, 03 Mar 2026 11:15:34 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 4/6] exfat: drop redundant sec parameter from exfat_mirror_bh
Date: Tue,  3 Mar 2026 11:14:07 +0800
Message-ID: <20260303031409.129136-5-chizhiling@163.com>
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
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S6
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF17XF4UCr1rCr47WrW5GFg_yoW8WF4fpa
	y5Ca93tr4jq3WDW3W7JrsYvw4Sva95JF95CrWrC3W8ZrZYyryvvFy8tFWY9a1qvasIyr1F
	g3Wjqry5JwnrGrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2ZXOUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC3BatS2mmUlaaygAA33
X-Rspamd-Queue-Id: 0AEF01E869E
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
	TAGGED_FROM(0.00)[bounces-79106-lists,linux-fsdevel=lfdr.de];
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

The sector offset can be obtained from bh->b_blocknr, so drop the
redundant sec parameter from exfat_mirror_bh(). Also clean up the
function to use exfat_update_bh() helper.

No functional changes.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/fatent.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index 9a4143f3fc0c..4177a933e0be 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -11,11 +11,11 @@
 #include "exfat_raw.h"
 #include "exfat_fs.h"
 
-static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
-		struct buffer_head *bh)
+static int exfat_mirror_bh(struct super_block *sb, struct buffer_head *bh)
 {
 	struct buffer_head *c_bh;
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	sector_t sec = bh->b_blocknr;
 	sector_t sec2;
 	int err = 0;
 
@@ -25,10 +25,7 @@ static int exfat_mirror_bh(struct super_block *sb, sector_t sec,
 		if (!c_bh)
 			return -ENOMEM;
 		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
-		set_buffer_uptodate(c_bh);
-		mark_buffer_dirty(c_bh);
-		if (sb->s_flags & SB_SYNCHRONOUS)
-			err = sync_dirty_buffer(c_bh);
+		exfat_update_bh(c_bh, sb->s_flags & SB_SYNCHRONOUS);
 		brelse(c_bh);
 	}
 
@@ -83,7 +80,7 @@ int exfat_ent_set(struct super_block *sb, unsigned int loc,
 	fat_entry = (__le32 *)&(bh->b_data[off]);
 	*fat_entry = cpu_to_le32(content);
 	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
-	exfat_mirror_bh(sb, sec, bh);
+	exfat_mirror_bh(sb, bh);
 	brelse(bh);
 	return 0;
 }
-- 
2.43.0


