Return-Path: <linux-fsdevel+bounces-8596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0398392A0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D04B28B673
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB45FDBA;
	Tue, 23 Jan 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJDmpX/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o40rHqGA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJDmpX/y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o40rHqGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994E5FDA8;
	Tue, 23 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023533; cv=none; b=sapM0S33VNICf/SBfVvvEYc0oj6YsvuJixxmKShttXfuIza10geORqZDNJyDVkQGFye4qlkd9qS3lsiX6kAft9VHzy6HT8a6vk3hybZR/qu0XbKnCzuzfmHOCZQyLBmR/UbWqxY/0BbiPXG9VaIiVrE7xY0d+/i+7eeR+AdnHZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023533; c=relaxed/simple;
	bh=TA5BPdD0GKz3pUY1LakUIlXiQ3qA7movn4dWR/ip1iM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tatK9wqobnpomqNwQcIfXDOX6bzwFaHWUjcxywEt1fpsdW8EkVUrjztJNlnyqhkwquWV22Sr7d+Hd4vCO8FrJO7PUqd9uCjnwQU/Ufv5f9awvb4UhR808l4qA6ZbSoSCkLYqPq7ZL5Uj2yUy3iRdIzheL7wmwc7rkiRoh7i0eg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJDmpX/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o40rHqGA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJDmpX/y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o40rHqGA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 151BD222DE;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXDxWbIvZOBQ+DKqskKrDxaYczxXIMvzmbB9x2BRSJI=;
	b=QJDmpX/yjyOahSqZwwCJ6wPUeRF6eXxitY3144zQqLoFMYnshjJ7RP5jcFzTBnZXv9RlfD
	JjXz81PVI4yk9Bjzypvhcf//XCHSWdRbZlvmdsmGiJ+9wVwDl7+IZW9EY8jyAIADyIEJNV
	PQtecP2R9GMQaquSHVF7cr3dvegOemw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXDxWbIvZOBQ+DKqskKrDxaYczxXIMvzmbB9x2BRSJI=;
	b=o40rHqGAqyZi0L+AEuHLtJKjZm+ZdEOWV+ZsB8J6pRW7UumMESNX84OgaiSbYtM7j19zUI
	9678kbh41ZwoQcCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXDxWbIvZOBQ+DKqskKrDxaYczxXIMvzmbB9x2BRSJI=;
	b=QJDmpX/yjyOahSqZwwCJ6wPUeRF6eXxitY3144zQqLoFMYnshjJ7RP5jcFzTBnZXv9RlfD
	JjXz81PVI4yk9Bjzypvhcf//XCHSWdRbZlvmdsmGiJ+9wVwDl7+IZW9EY8jyAIADyIEJNV
	PQtecP2R9GMQaquSHVF7cr3dvegOemw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xXDxWbIvZOBQ+DKqskKrDxaYczxXIMvzmbB9x2BRSJI=;
	b=o40rHqGAqyZi0L+AEuHLtJKjZm+ZdEOWV+ZsB8J6pRW7UumMESNX84OgaiSbYtM7j19zUI
	9678kbh41ZwoQcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03243139CB;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SkvTAGbar2WudQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 12D61A080E; Tue, 23 Jan 2024 16:25:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] quota: Set nofs allocation context when acquiring dqio_sem
Date: Tue, 23 Jan 2024 16:25:07 +0100
Message-Id: <20240123152520.4294-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9902; i=jack@suse.cz; h=from:subject; bh=TA5BPdD0GKz3pUY1LakUIlXiQ3qA7movn4dWR/ip1iM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pTvLxt8gGbGkEEgk/IB41mOrDBBMRm7kcSg0FE p+wZv8uJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aUwAKCRCcnaoHP2RA2S8GCA CVIHchAmr5+zfFF/eQ7jkkEX+gWRWlt+4Mk/Cg/PQ+DU7aFComhr8BP5q5XoFkhlHIlN9ibHZw37zC YwaTO9WKz7er/rZcRAvupSFToIGx1dJI3nUMOE40xGNJwYj+FQACB3n0ppf2NPhOPouaRedVhw+OgJ KCDelqpjpJkAjj21YfrvRENrYS44t+q7cjrypevYa0JBxV1dCjT3Yt4nq8/nqjW7+gCiJOeVX5cNWA j/qDUCuDGQFhNyMlg2J3UhsVnuFgl5nVycWC0YRZMrFVnpigaUtg9b8o+KlJbIKhMTr/G2MRieGBuE +DP1AokBH6cDQ/SQF2C0mnstWVrOKJ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="QJDmpX/y";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o40rHqGA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: 151BD222DE
X-Spam-Flag: NO

dqio_sem can be acquired during inode reclaim through dquot_drop() ->
dqput() -> dquot_release() -> write_file_info() context. In some cases
(most notably through dquot_get_next_id()) it can be acquired without
holding dquot->dq_lock (which already sets nofs allocation context). So
we need to set nofs allocation context when acquiring it as well.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ocfs2/quota_global.c | 12 ++++++++++++
 fs/ocfs2/quota_local.c  |  3 +++
 fs/quota/quota_v1.c     |  6 ++++++
 fs/quota/quota_v2.c     | 18 ++++++++++++++++++
 4 files changed, 39 insertions(+)

diff --git a/fs/ocfs2/quota_global.c b/fs/ocfs2/quota_global.c
index dc9f76ab7e13..0575c2d060eb 100644
--- a/fs/ocfs2/quota_global.c
+++ b/fs/ocfs2/quota_global.c
@@ -447,14 +447,17 @@ int ocfs2_global_write_info(struct super_block *sb, int type)
 	int err;
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct ocfs2_mem_dqinfo *info = dqopt->info[type].dqi_priv;
+	unsigned int memalloc;
 
 	down_write(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	err = ocfs2_qinfo_lock(info, 1);
 	if (err < 0)
 		goto out_sem;
 	err = __ocfs2_global_write_info(sb, type);
 	ocfs2_qinfo_unlock(info, 1);
 out_sem:
+	memalloc_nofs_restore(memalloc);
 	up_write(&dqopt->dqio_sem);
 	return err;
 }
@@ -601,6 +604,7 @@ static int ocfs2_sync_dquot_helper(struct dquot *dquot, unsigned long type)
 	struct ocfs2_mem_dqinfo *oinfo = sb_dqinfo(sb, type)->dqi_priv;
 	struct ocfs2_super *osb = OCFS2_SB(sb);
 	int status = 0;
+	unsigned int memalloc;
 
 	trace_ocfs2_sync_dquot_helper(from_kqid(&init_user_ns, dquot->dq_id),
 				      dquot->dq_id.type,
@@ -618,6 +622,7 @@ static int ocfs2_sync_dquot_helper(struct dquot *dquot, unsigned long type)
 		goto out_ilock;
 	}
 	down_write(&sb_dqopt(sb)->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	status = ocfs2_sync_dquot(dquot);
 	if (status < 0)
 		mlog_errno(status);
@@ -625,6 +630,7 @@ static int ocfs2_sync_dquot_helper(struct dquot *dquot, unsigned long type)
 	status = ocfs2_local_write_dquot(dquot);
 	if (status < 0)
 		mlog_errno(status);
+	memalloc_nofs_restore(memalloc);
 	up_write(&sb_dqopt(sb)->dqio_sem);
 	ocfs2_commit_trans(osb, handle);
 out_ilock:
@@ -662,6 +668,7 @@ static int ocfs2_write_dquot(struct dquot *dquot)
 	handle_t *handle;
 	struct ocfs2_super *osb = OCFS2_SB(dquot->dq_sb);
 	int status = 0;
+	unsigned int memalloc;
 
 	trace_ocfs2_write_dquot(from_kqid(&init_user_ns, dquot->dq_id),
 				dquot->dq_id.type);
@@ -673,7 +680,9 @@ static int ocfs2_write_dquot(struct dquot *dquot)
 		goto out;
 	}
 	down_write(&sb_dqopt(dquot->dq_sb)->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	status = ocfs2_local_write_dquot(dquot);
+	memalloc_nofs_restore(memalloc);
 	up_write(&sb_dqopt(dquot->dq_sb)->dqio_sem);
 	ocfs2_commit_trans(osb, handle);
 out:
@@ -920,6 +929,7 @@ static int ocfs2_mark_dquot_dirty(struct dquot *dquot)
 	struct ocfs2_mem_dqinfo *oinfo = sb_dqinfo(sb, type)->dqi_priv;
 	handle_t *handle;
 	struct ocfs2_super *osb = OCFS2_SB(sb);
+	unsigned int memalloc;
 
 	trace_ocfs2_mark_dquot_dirty(from_kqid(&init_user_ns, dquot->dq_id),
 				     type);
@@ -946,6 +956,7 @@ static int ocfs2_mark_dquot_dirty(struct dquot *dquot)
 		goto out_ilock;
 	}
 	down_write(&sb_dqopt(sb)->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	status = ocfs2_sync_dquot(dquot);
 	if (status < 0) {
 		mlog_errno(status);
@@ -954,6 +965,7 @@ static int ocfs2_mark_dquot_dirty(struct dquot *dquot)
 	/* Now write updated local dquot structure */
 	status = ocfs2_local_write_dquot(dquot);
 out_dlock:
+	memalloc_nofs_restore(memalloc);
 	up_write(&sb_dqopt(sb)->dqio_sem);
 	ocfs2_commit_trans(osb, handle);
 out_ilock:
diff --git a/fs/ocfs2/quota_local.c b/fs/ocfs2/quota_local.c
index e09842fc9d4d..8ce462c64c51 100644
--- a/fs/ocfs2/quota_local.c
+++ b/fs/ocfs2/quota_local.c
@@ -470,6 +470,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 	int bit, chunk;
 	struct ocfs2_recovery_chunk *rchunk, *next;
 	qsize_t spacechange, inodechange;
+	unsigned int memalloc;
 
 	trace_ocfs2_recover_local_quota_file((unsigned long)lqinode->i_ino, type);
 
@@ -521,6 +522,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 				goto out_drop_lock;
 			}
 			down_write(&sb_dqopt(sb)->dqio_sem);
+			memalloc = memalloc_nofs_save();
 			spin_lock(&dquot->dq_dqb_lock);
 			/* Add usage from quota entry into quota changes
 			 * of our node. Auxiliary variables are important
@@ -553,6 +555,7 @@ static int ocfs2_recover_local_quota_file(struct inode *lqinode,
 			unlock_buffer(qbh);
 			ocfs2_journal_dirty(handle, qbh);
 out_commit:
+			memalloc_nofs_restore(memalloc);
 			up_write(&sb_dqopt(sb)->dqio_sem);
 			ocfs2_commit_trans(OCFS2_SB(sb), handle);
 out_drop_lock:
diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index a0db3f195e95..3f3e8acc05db 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -160,9 +160,11 @@ static int v1_read_file_info(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct v1_disk_dqblk dqblk;
+	unsigned int memalloc;
 	int ret;
 
 	down_read(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = sb->s_op->quota_read(sb, type, (char *)&dqblk,
 				sizeof(struct v1_disk_dqblk), v1_dqoff(0));
 	if (ret != sizeof(struct v1_disk_dqblk)) {
@@ -179,6 +181,7 @@ static int v1_read_file_info(struct super_block *sb, int type)
 	dqopt->info[type].dqi_bgrace =
 			dqblk.dqb_btime ? dqblk.dqb_btime : MAX_DQ_TIME;
 out:
+	memalloc_nofs_restore(memalloc);
 	up_read(&dqopt->dqio_sem);
 	return ret;
 }
@@ -187,9 +190,11 @@ static int v1_write_file_info(struct super_block *sb, int type)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
 	struct v1_disk_dqblk dqblk;
+	unsigned int memalloc;
 	int ret;
 
 	down_write(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = sb->s_op->quota_read(sb, type, (char *)&dqblk,
 				sizeof(struct v1_disk_dqblk), v1_dqoff(0));
 	if (ret != sizeof(struct v1_disk_dqblk)) {
@@ -209,6 +214,7 @@ static int v1_write_file_info(struct super_block *sb, int type)
 	else if (ret >= 0)
 		ret = -EIO;
 out:
+	memalloc_nofs_restore(memalloc);
 	up_write(&dqopt->dqio_sem);
 	return ret;
 }
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index ae99e7b88205..48e0d610ceef 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -96,9 +96,11 @@ static int v2_read_file_info(struct super_block *sb, int type)
 	struct qtree_mem_dqinfo *qinfo;
 	ssize_t size;
 	unsigned int version;
+	unsigned int memalloc;
 	int ret;
 
 	down_read(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = v2_read_header(sb, type, &dqhead);
 	if (ret < 0)
 		goto out;
@@ -183,6 +185,7 @@ static int v2_read_file_info(struct super_block *sb, int type)
 		info->dqi_priv = NULL;
 	}
 out:
+	memalloc_nofs_restore(memalloc);
 	up_read(&dqopt->dqio_sem);
 	return ret;
 }
@@ -195,8 +198,10 @@ static int v2_write_file_info(struct super_block *sb, int type)
 	struct mem_dqinfo *info = &dqopt->info[type];
 	struct qtree_mem_dqinfo *qinfo = info->dqi_priv;
 	ssize_t size;
+	unsigned int memalloc;
 
 	down_write(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	spin_lock(&dq_data_lock);
 	info->dqi_flags &= ~DQF_INFO_DIRTY;
 	dinfo.dqi_bgrace = cpu_to_le32(info->dqi_bgrace);
@@ -209,6 +214,7 @@ static int v2_write_file_info(struct super_block *sb, int type)
 	dinfo.dqi_free_entry = cpu_to_le32(qinfo->dqi_free_entry);
 	size = sb->s_op->quota_write(sb, type, (char *)&dinfo,
 	       sizeof(struct v2_disk_dqinfo), V2_DQINFOOFF);
+	memalloc_nofs_restore(memalloc);
 	up_write(&dqopt->dqio_sem);
 	if (size != sizeof(struct v2_disk_dqinfo)) {
 		quota_error(sb, "Can't write info structure");
@@ -328,11 +334,14 @@ static int v2_read_dquot(struct dquot *dquot)
 {
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 	int ret;
+	unsigned int memalloc;
 
 	down_read(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = qtree_read_dquot(
 			sb_dqinfo(dquot->dq_sb, dquot->dq_id.type)->dqi_priv,
 			dquot);
+	memalloc_nofs_restore(memalloc);
 	up_read(&dqopt->dqio_sem);
 	return ret;
 }
@@ -342,6 +351,7 @@ static int v2_write_dquot(struct dquot *dquot)
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
 	int ret;
 	bool alloc = false;
+	unsigned int memalloc;
 
 	/*
 	 * If space for dquot is already allocated, we don't need any
@@ -355,9 +365,11 @@ static int v2_write_dquot(struct dquot *dquot)
 	} else {
 		down_read(&dqopt->dqio_sem);
 	}
+	memalloc = memalloc_nofs_save();
 	ret = qtree_write_dquot(
 			sb_dqinfo(dquot->dq_sb, dquot->dq_id.type)->dqi_priv,
 			dquot);
+	memalloc_nofs_restore(memalloc);
 	if (alloc)
 		up_write(&dqopt->dqio_sem);
 	else
@@ -368,10 +380,13 @@ static int v2_write_dquot(struct dquot *dquot)
 static int v2_release_dquot(struct dquot *dquot)
 {
 	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	unsigned int memalloc;
 	int ret;
 
 	down_write(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = qtree_release_dquot(sb_dqinfo(dquot->dq_sb, dquot->dq_id.type)->dqi_priv, dquot);
+	memalloc_nofs_restore(memalloc);
 	up_write(&dqopt->dqio_sem);
 
 	return ret;
@@ -386,10 +401,13 @@ static int v2_free_file_info(struct super_block *sb, int type)
 static int v2_get_next_id(struct super_block *sb, struct kqid *qid)
 {
 	struct quota_info *dqopt = sb_dqopt(sb);
+	unsigned int memalloc;
 	int ret;
 
 	down_read(&dqopt->dqio_sem);
+	memalloc = memalloc_nofs_save();
 	ret = qtree_get_next_id(sb_dqinfo(sb, qid->type)->dqi_priv, qid);
+	memalloc_nofs_restore(memalloc);
 	up_read(&dqopt->dqio_sem);
 	return ret;
 }
-- 
2.35.3


