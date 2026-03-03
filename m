Return-Path: <linux-fsdevel+bounces-79105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LWvA85SpmkbOAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:17:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD621E8688
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 04:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99EB630E3FA0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 03:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B054382288;
	Tue,  3 Mar 2026 03:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="loPR6UjU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9775837DE84;
	Tue,  3 Mar 2026 03:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507752; cv=none; b=Kki324UQHG5J2NRy9R7FBzK+Y5bmSXmK7iE1y/ZQ67HjDjzxOyWpS1ZXg26Bcpm0G2AIag+Ge5DxOolj/vWVPcJnb/RLOeID8JKSBudOe8V4tEbWUNxmYsJptGIy1qkz3I/3BHJPtLbZrwkfIo1VdXcUb6zS1EJqb4X9OAQvPpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507752; c=relaxed/simple;
	bh=8B+R8dwddxja26oLC4AinePqXHd6MjXL921jpmJgrlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYfdwgCu8E6xD1KEJkVxxFmcCGyjrPhaARAwcGbcEqbwl+rLhpaMw1kHSoLE43uXCNa9eM2zE30rNX6b7ILmujHmHbF3g+VJk+0wtosGCIgTG5DvqCbx6f9M3dEUzlqaRWVHiGoH0gHXxGL+kTApl1XOazV7Ogspc6vR0YQymT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=loPR6UjU; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=8d
	Zd8C/M0MqLRH9zbAMQbAVx9Qkc5/D3OtnivlKzTa0=; b=loPR6UjU4r0jvtG6Y9
	1Vyn76tiqzDjlXJTUT0YDYKHt19eu6BebAAjVRMVEoU50UJGX7z0X0TUbuKFGYs1
	nMqbAEQBL7V0aPBpAdNHn6v9RaGzzpsOSl+hXENFkDOZT4Xdn2wKh0pzMHVFTq98
	aENF4MbNxAgzkmcpmTXzoYzoQ=
Received: from czl-ubuntu-pc.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAXh6xQUqZpOLCWQw--.188S8;
	Tue, 03 Mar 2026 11:15:34 +0800 (CST)
From: Chi Zhiling <chizhiling@163.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Yuezhang Mo <yuezhang.mo@sony.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: [PATCH v2 6/6] exfat: fix error handling for FAT table operations
Date: Tue,  3 Mar 2026 11:14:09 +0800
Message-ID: <20260303031409.129136-7-chizhiling@163.com>
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
X-CM-TRANSID:PygvCgAXh6xQUqZpOLCWQw--.188S8
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryfXF45GFW8uryDAFW8JFb_yoWrWryrpF
	W5Ga95Jr4qqa4Dur17tr4qv3WFvrn7Kay5CrWrA3ZYq3yqyw1v9ryUtryYva1DKa1vgr4j
	kF4Ygr45WwnxWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j2XdUUUUUU=
X-CM-SenderInfo: hfkl6xxlol0wi6rwjhhfrp/xtbC9xatS2mmUlaMEQAA3R
X-Rspamd-Queue-Id: 7AD621E8688
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
	TAGGED_FROM(0.00)[bounces-79105-lists,linux-fsdevel=lfdr.de];
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

Fix three error handling issues in FAT table operations:

1. Fix exfat_update_bh() to properly return errors from sync_dirty_buffer
2. Fix exfat_end_bh() to properly return errors from exfat_update_bh()
   and exfat_mirror_bh()
3. Fix ignored return values from exfat_chain_cont_cluster() in inode.c
   and namei.c

These fixes ensure that FAT table write errors are properly propagated
to the caller instead of being silently ignored.

Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
---
 fs/exfat/exfat_fs.h | 2 +-
 fs/exfat/fatent.c   | 8 ++++----
 fs/exfat/inode.c    | 5 +++--
 fs/exfat/misc.c     | 8 ++++++--
 fs/exfat/namei.c    | 3 ++-
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 090f25d1a418..9fed9fb33cae 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -584,7 +584,7 @@ void exfat_set_entry_time(struct exfat_sb_info *sbi, struct timespec64 *ts,
 		u8 *tz, __le16 *time, __le16 *date, u8 *time_cs);
 u16 exfat_calc_chksum16(void *data, int len, u16 chksum, int type);
 u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type);
-void exfat_update_bh(struct buffer_head *bh, int sync);
+int exfat_update_bh(struct buffer_head *bh, int sync);
 int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync);
 void exfat_chain_set(struct exfat_chain *ec, unsigned int dir,
 		unsigned int size, unsigned char flags);
diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
index a973aa4de57b..f2e5d5dde393 100644
--- a/fs/exfat/fatent.c
+++ b/fs/exfat/fatent.c
@@ -25,7 +25,7 @@ static int exfat_mirror_bh(struct super_block *sb, struct buffer_head *bh)
 		if (!c_bh)
 			return -ENOMEM;
 		memcpy(c_bh->b_data, bh->b_data, sb->s_blocksize);
-		exfat_update_bh(c_bh, sb->s_flags & SB_SYNCHRONOUS);
+		err = exfat_update_bh(c_bh, sb->s_flags & SB_SYNCHRONOUS);
 		brelse(c_bh);
 	}
 
@@ -36,10 +36,10 @@ static int exfat_end_bh(struct super_block *sb, struct buffer_head *bh)
 {
 	int err;
 
-	exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
-	err = exfat_mirror_bh(sb, bh);
+	err = exfat_update_bh(bh, sb->s_flags & SB_SYNCHRONOUS);
+	if (!err)
+		err = exfat_mirror_bh(sb, bh);
 	brelse(bh);
-
 	return err;
 }
 
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 2fb2d2d5d503..cb13a197eee9 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -204,8 +204,9 @@ static int exfat_map_cluster(struct inode *inode, unsigned int clu_offset,
 				 * so fat-chain should be synced with
 				 * alloc-bitmap
 				 */
-				exfat_chain_cont_cluster(sb, ei->start_clu,
-					num_clusters);
+				if (exfat_chain_cont_cluster(sb, ei->start_clu,
+						num_clusters))
+					return -EIO;
 				ei->flags = ALLOC_FAT_CHAIN;
 			}
 			if (new_clu.flags == ALLOC_FAT_CHAIN)
diff --git a/fs/exfat/misc.c b/fs/exfat/misc.c
index fa8459828046..6f11a96a4ffa 100644
--- a/fs/exfat/misc.c
+++ b/fs/exfat/misc.c
@@ -161,13 +161,17 @@ u32 exfat_calc_chksum32(void *data, int len, u32 chksum, int type)
 	return chksum;
 }
 
-void exfat_update_bh(struct buffer_head *bh, int sync)
+int exfat_update_bh(struct buffer_head *bh, int sync)
 {
+	int err = 0;
+
 	set_buffer_uptodate(bh);
 	mark_buffer_dirty(bh);
 
 	if (sync)
-		sync_dirty_buffer(bh);
+		err = sync_dirty_buffer(bh);
+
+	return err;
 }
 
 int exfat_update_bhs(struct buffer_head **bhs, int nr_bhs, int sync)
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index 670116ae9ec8..ef2a3488c1b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -365,7 +365,8 @@ int exfat_find_empty_entry(struct inode *inode,
 			/* no-fat-chain bit is disabled,
 			 * so fat-chain should be synced with alloc-bitmap
 			 */
-			exfat_chain_cont_cluster(sb, p_dir->dir, p_dir->size);
+			if (exfat_chain_cont_cluster(sb, p_dir->dir, p_dir->size))
+				return -EIO;
 			p_dir->flags = ALLOC_FAT_CHAIN;
 			hint_femp.cur.flags = ALLOC_FAT_CHAIN;
 		}
-- 
2.43.0


