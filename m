Return-Path: <linux-fsdevel+bounces-79108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WH3tN1NTpmkbOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:19:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A40C1E871C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31EAA3129789
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 03:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C582937DE89;
	Tue,  3 Mar 2026 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qTkR0DGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60150382360;
	Tue,  3 Mar 2026 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507766; cv=none; b=J3v3R+8VnlwnN3hIdHnGcbboqWoyY9njZr0eAQj1iwUThrnBrVhNaTLRLuzEziiIXHAQwkaKJmMh5Ca40vE3NlzQtgP4G8DEOqo31i0+0B8A6ibkbAVrrYUjdWg2kVVudu5Zqp3Bpxx38bi7qJdBUkxqiKW33kZ4oJoB6B+iRMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507766; c=relaxed/simple;
	bh=6cVp/PPkcqEjPu27yrav/1pqN6AkX3qOYMtENqKmNx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GpXbngMbGsiuXV0ZT4mB0vOgAcHxxe340CC3568nvqqJIdSWcMcioM1vvM4EDUo48ycEc5s3/y0wdPnZX7OWH9Sw+3kT+n7v1R7j4W6ObWzjbxra5t4yDzVTtn8f2iH1DP9q7WXW1sKVJ074npkwFIJl4E0oHrX0TxWTAB+Dh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qTkR0DGx; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=0A
	PR0ZvepNK5RtXn2wLzshvwXPKV4FDoQ0qE6qOSS2M=; b=qTkR0DGxAlORtPGK0v
	FFZcCmlYqnCzPnX1agr8wlbpSzKL/Owzvq1E6e7T9EDETExgL8uxG4b1oMsZqo6A
	DXKOEySMHw1qwpa3yasalL5azPdnHt96fa3ApVa+9+Bp1Mmue/Xjla4zGado/ZI4
	xmYwxMPM4wv4fuzQR5nxlhYts=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S4;
	Tue, 03 Mar 2026 11:15:33 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 2/6] exfat: use readahead helper in exfat_allocate_bitmap
Date: Tue,  3 Mar 2026 11:14:05 +0800
Message-ID: <20260303031409.129136-3-chizhiling@163.com>
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
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7trWrAr18XFy3tw17uF13XFb_yoW8CryfpF
	47Ga17KrW5Xr1UWws8Ga40ga1fu34rGFy3GrWIv3s8urn3KrnI9FyvgFyUZFy2kas5JF40
	vwn0kr15Zws7ua7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDtxfUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xWtS2mmUlWL6wAA3s
X-Rspamd-Queue-Id: 4A40C1E871C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-79108-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Chi Zhiling <chizhiling@kylinos.cn>

Use the newly added exfat_blk_readahead() helper in exfat_allocate_bitmap()
to simplify the code. This eliminates the duplicate inline readahead logic
and uses the unified readahead interface.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/balloc.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
index 3a32f49f9dbd..625f2f14d4fe 100644
--- a/fs/exfat/balloc.c
+++ b/fs/exfat/balloc.c
@@ -74,11 +74,10 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 		struct exfat_dentry *ep)
 {
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
-	struct blk_plug plug;
 	long long map_size;
 	unsigned int i, j, need_map_size;
-	sector_t sector;
-	unsigned int max_ra_count;
+	sector_t sector, end, ra;
+	blkcnt_t ra_cnt = 0;
 
 	sbi->map_clu = le32_to_cpu(ep->dentry.bitmap.start_clu);
 	map_size = le64_to_cpu(ep->dentry.bitmap.size);
@@ -100,17 +99,12 @@ static int exfat_allocate_bitmap(struct super_block *sb,
 	if (!sbi->vol_amap)
 		return -ENOMEM;
 
-	sector = exfat_cluster_to_sector(sbi, sbi->map_clu);
-	max_ra_count = min(sb->s_bdi->ra_pages, sb->s_bdi->io_pages) <<
-		(PAGE_SHIFT - sb->s_blocksize_bits);
+	sector = ra = exfat_cluster_to_sector(sbi, sbi->map_clu);
+	end = sector + sbi->map_sectors - 1;
+
 	for (i = 0; i < sbi->map_sectors; i++) {
 		/* Trigger the next readahead in advance. */
-		if (max_ra_count && 0 == (i % max_ra_count)) {
-			blk_start_plug(&plug);
-			for (j = i; j < min(max_ra_count, sbi->map_sectors - i) + i; j++)
-				sb_breadahead(sb, sector + j);
-			blk_finish_plug(&plug);
-		}
+		exfat_blk_readahead(sb, sector + i, &ra, &ra_cnt, end);
 
 		sbi->vol_amap[i] = sb_bread(sb, sector + i);
 		if (!sbi->vol_amap[i])
-- 
2.43.0


