Return-Path: <linux-fsdevel+bounces-8592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C22B83929A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C12128AD1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8912D6027C;
	Tue, 23 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sB2l91+F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9HvmEOsb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sB2l91+F";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9HvmEOsb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6955FDBA;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=EZnIsRYZrofPtdA2cvHV/tYtB2b3gLLGcUqHUnIBsXVFm9LM1v2hMQEF+8PbD1Cazr5EyN3aPfIiSKZLjTUdeD2xMqyA7PAjdqoj6/PCeDSu2DynDRMI5YuBFHOnQL4FU/KnezTmXyvwxQ06Lj9Qdg2P9vGOJhE75N0ZCC5hY/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=YBiQ8/ge7B0Cy2nRMqM5Ufe9ziq5MOCh7BlnVIaFXDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VS6PKEP4ZD7E7HcNqiv9stlTtV0bHxRjrYrE/iZr5YksNWcr0XFyj9L6Qvjp219KYoUVafeuTDYhOrJQz6OI1MuUSJZqMUCNNuWQjlaljcbA/5zbkR34AuF48WGhgEq43eWcfqddvID52qwK5nvljlTs8nejEYzO1VpbDaY7qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sB2l91+F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9HvmEOsb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sB2l91+F; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9HvmEOsb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 11AFC1FD81;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8WIyV3lKxgxbFCSvhGPHax9kDia3vCA/+e3zP7Jyq4=;
	b=sB2l91+FuTVjeyed8qpaEwKM2Rdb/yYqLC2wrEHxiEkIcHEHcBwdvYQIzG7jrtwWKbXbjs
	pM3bA0hJH3hRTvrN3W6dwN8NXWta6ScVrhHsOe95Lcf0jp6P1AOQkeIVcxv616d11xqIZW
	XqhDlDxfrjGQJS2K48YvYzWucGst44M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8WIyV3lKxgxbFCSvhGPHax9kDia3vCA/+e3zP7Jyq4=;
	b=9HvmEOsbCvYRS3RvBN2XOVmNZJihYSpanBdQw6KuPE0/DlRiUlNQQdPIRJKbsBOjZkoXKW
	lkaHk1w5WTv3eMCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8WIyV3lKxgxbFCSvhGPHax9kDia3vCA/+e3zP7Jyq4=;
	b=sB2l91+FuTVjeyed8qpaEwKM2Rdb/yYqLC2wrEHxiEkIcHEHcBwdvYQIzG7jrtwWKbXbjs
	pM3bA0hJH3hRTvrN3W6dwN8NXWta6ScVrhHsOe95Lcf0jp6P1AOQkeIVcxv616d11xqIZW
	XqhDlDxfrjGQJS2K48YvYzWucGst44M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8WIyV3lKxgxbFCSvhGPHax9kDia3vCA/+e3zP7Jyq4=;
	b=9HvmEOsbCvYRS3RvBN2XOVmNZJihYSpanBdQw6KuPE0/DlRiUlNQQdPIRJKbsBOjZkoXKW
	lkaHk1w5WTv3eMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013D0139B9;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zVtPAGbar2WtdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1AC11A080F; Tue, 23 Jan 2024 16:25:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] quota: Drop GFP_NOFS instances under dquot->dq_lock and dqio_sem
Date: Tue, 23 Jan 2024 16:25:08 +0100
Message-Id: <20240123152520.4294-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5634; i=jack@suse.cz; h=from:subject; bh=YBiQ8/ge7B0Cy2nRMqM5Ufe9ziq5MOCh7BlnVIaFXDk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pTqJyC9l3eERdlefPakLL+cFswto4FqJf/5rH7 7lR804iJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aUwAKCRCcnaoHP2RA2XhMB/ 9oRJZmPqwsfDmk+ssiShGGcBKNORJNFlqiGbwaRUBBgowKps7UpxF/GodL6ZIV2/8qkiPq1VJIl3yX jXPT29jQMrAlkNaMubA9IMhjBble01hHDydt3G06+iBr6qdsSZgYpPc13e8H1YWt2DWKX7ZiXDfo7Z 0ou47UWkV+nQtl3UumRFVgplUcoEWPy+oXBrZMVtC7gOsZhvMQRlNNY+QfXTl1G9ke0Tx7Sb+6SHMN dV80KrdRSXeYDdu/U+cBHbmehAu8z1pGtJFicY5luNT4RYdi8sEQaqlXqgdsTKALvSC2oKEq25LPni d4UgWv8Z5S6bn4rJ0qdd9n27kcRtEw
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Quota code acquires dquot->dq_lock whenever reading / writing dquot.
When reading / writing quota info we hold dqio_sem.  Since these locks
can be acquired during inode reclaim (through dquot_drop() -> dqput() ->
dquot_release()) we are setting nofs allocation context whenever
acquiring these locks. Hence there's no need to use GFP_NOFS allocations
in quota code doing IO. Just switch it to GFP_KERNEL.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/quota_tree.c | 24 ++++++++++++------------
 fs/quota/quota_v2.c   |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index 0f1493e0f6d0..ef0461542d3a 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -108,7 +108,7 @@ static int check_dquot_block_header(struct qtree_mem_dqinfo *info,
 /* Remove empty block from list and return it */
 static int get_free_dqblk(struct qtree_mem_dqinfo *info)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	int ret, blk;
 
@@ -160,7 +160,7 @@ static int put_free_dqblk(struct qtree_mem_dqinfo *info, char *buf, uint blk)
 static int remove_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 			       uint blk)
 {
-	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	uint nextblk = le32_to_cpu(dh->dqdh_next_free);
 	uint prevblk = le32_to_cpu(dh->dqdh_prev_free);
@@ -207,7 +207,7 @@ static int remove_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 static int insert_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 			       uint blk)
 {
-	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	int err;
 
@@ -255,7 +255,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 {
 	uint blk, i;
 	struct qt_disk_dqdbheader *dh;
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	char *ddquot;
 
 	*err = 0;
@@ -329,7 +329,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			  uint *treeblk, int depth)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
 	uint newblk;
@@ -410,7 +410,7 @@ int qtree_write_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 	int type = dquot->dq_id.type;
 	struct super_block *sb = dquot->dq_sb;
 	ssize_t ret;
-	char *ddquot = kmalloc(info->dqi_entry_size, GFP_NOFS);
+	char *ddquot = kmalloc(info->dqi_entry_size, GFP_KERNEL);
 
 	if (!ddquot)
 		return -ENOMEM;
@@ -449,7 +449,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			uint blk)
 {
 	struct qt_disk_dqdbheader *dh;
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	int ret = 0;
 
 	if (!buf)
@@ -513,7 +513,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		       uint *blk, int depth)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	int ret = 0;
 	uint newblk;
 	__le32 *ref = (__le32 *)buf;
@@ -577,7 +577,7 @@ EXPORT_SYMBOL(qtree_delete_dquot);
 static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 				 struct dquot *dquot, uint blk)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	loff_t ret = 0;
 	int i;
 	char *ddquot;
@@ -615,7 +615,7 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 				struct dquot *dquot, uint blk, int depth)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
 
@@ -684,7 +684,7 @@ int qtree_read_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 		}
 		dquot->dq_off = offset;
 	}
-	ddquot = kmalloc(info->dqi_entry_size, GFP_NOFS);
+	ddquot = kmalloc(info->dqi_entry_size, GFP_KERNEL);
 	if (!ddquot)
 		return -ENOMEM;
 	ret = sb->s_op->quota_read(sb, type, ddquot, info->dqi_entry_size,
@@ -728,7 +728,7 @@ EXPORT_SYMBOL(qtree_release_dquot);
 static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
 			unsigned int blk, int depth)
 {
-	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_KERNEL);
 	__le32 *ref = (__le32 *)buf;
 	ssize_t ret;
 	unsigned int epb = info->dqi_usable_bs >> 2;
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index 48e0d610ceef..5eb0de8e7e40 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -121,7 +121,7 @@ static int v2_read_file_info(struct super_block *sb, int type)
 			ret = -EIO;
 		goto out;
 	}
-	info->dqi_priv = kmalloc(sizeof(struct qtree_mem_dqinfo), GFP_NOFS);
+	info->dqi_priv = kmalloc(sizeof(struct qtree_mem_dqinfo), GFP_KERNEL);
 	if (!info->dqi_priv) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.35.3


