Return-Path: <linux-fsdevel+bounces-25338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47D094AFB7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 038EB1C219F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B27142E67;
	Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d25azNXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WnJOsDNJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d25azNXp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WnJOsDNJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F95B13F458
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=DfxPNYTwrefrepUFE7DW3vhdDHsDB4v/wXpOFpwSajYrVMwtYk+xBL2gYZOX16ymDXjWyH1ssogArDQVWPVhxXAcl95K/ZT+2VaYxH5YxeV++WaQdiP+kdLTAsFOXK3gs313pxAn+cm+34+t2wtLB+rTLh2GpL6x/vltHGY4yFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=CVmyFXa3mb/HAQvnjdCtzo9LMs7/0fXP7KEN+Td57dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jFvDC976kKh12yYjwZxbyOr8F2TezbPADSeVLXOrXKwsOLMnDEefUbW/vx9P0WZY476uk2KiARd4PLzvxHmgpKfexdLkZlLQfK9/0TozLjjttDcgbrKBAS1YUDXW8PylPGLb6rZLLn3cNUnFNP7oj/fDZZkzZ++rRF8AQPAGe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d25azNXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WnJOsDNJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d25azNXp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WnJOsDNJ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 90CEC1FB61;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Vk7nIgsN2Hc4EVTYl3Ul+GBLt9+dT+yI/YCVuNRFQ=;
	b=d25azNXpYkPNToYSDS3GaHbQUzCRj1LDsEJ2JLDeiXQWEvZ9bCYOEbYYj4ZFpn0tl9ypi+
	RmNhcQi+Je5naL4rcb521+l1N2ivZqYSQqt3F8r5jWZqjBSfks11RfJSdJ8ks6Lklf7ZSM
	saVOILU0kKrOET74F5LpC/KvMgL5FgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Vk7nIgsN2Hc4EVTYl3Ul+GBLt9+dT+yI/YCVuNRFQ=;
	b=WnJOsDNJoIPkQ/MY1+xH9fdMGuMAT3kl9+e3rWLCFlGrw8yBhXzHfw3dWzNxxzzKWnHuGv
	qEdW5AB3f+luExAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=d25azNXp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WnJOsDNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Vk7nIgsN2Hc4EVTYl3Ul+GBLt9+dT+yI/YCVuNRFQ=;
	b=d25azNXpYkPNToYSDS3GaHbQUzCRj1LDsEJ2JLDeiXQWEvZ9bCYOEbYYj4ZFpn0tl9ypi+
	RmNhcQi+Je5naL4rcb521+l1N2ivZqYSQqt3F8r5jWZqjBSfks11RfJSdJ8ks6Lklf7ZSM
	saVOILU0kKrOET74F5LpC/KvMgL5FgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9Vk7nIgsN2Hc4EVTYl3Ul+GBLt9+dT+yI/YCVuNRFQ=;
	b=WnJOsDNJoIPkQ/MY1+xH9fdMGuMAT3kl9+e3rWLCFlGrw8yBhXzHfw3dWzNxxzzKWnHuGv
	qEdW5AB3f+luExAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D78D13B0D;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LhjRGiy9s2Z6NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D11F0A0892; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/13] fs: Teach callers of kiocb_start_write() to handle errors
Date: Wed,  7 Aug 2024 20:29:53 +0200
Message-Id: <20240807183003.23562-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894; i=jack@suse.cz; h=from:subject; bh=CVmyFXa3mb/HAQvnjdCtzo9LMs7/0fXP7KEN+Td57dg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70gHzo/iL1pbikz3ytt/Rx4eZSmvGiz5e6JAtSx 6twVihCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9IAAKCRCcnaoHP2RA2TjlB/ 9lX7eLdx+D/KzlbTmf2tM3jS89tKUDXtK7PlRlzmW8lFyqm7+3RSn1TZXHE5RdO7EOzvPBaWnadZ3a lD71962qFzkbzbYoX8U9oj0otSoM0hbhM+2SPKFStbr6HLo07UKGn4wu63vWkiMQHxqcgsKrik1h9C eWffm8C8H9r9plrEWUKct12JECPaO46lBYxfAn99MiWqWGwK7ZOC2rGzrTD/JPLzttVmHC1F56x6D7 kHM0d4Gn5v9Ubi3BjAIs2B38l2VHu/wHsx3Z2bcSHU5OqXLEfR6wwz23mTvztIsXpp8nVmuO8F6TUP CmydI/bpwngCmtIyYbSMVItEg9iVis
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 90CEC1FB61

sb_start_write() will be returning error on shutdown filesystem. Teach
callers of kiocb_start_write() to handle the error.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/aio.c           | 14 +++++++++-----
 fs/read_write.c    |  4 +++-
 include/linux/fs.h |  3 ++-
 io_uring/rw.c      |  7 +++++--
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 48d99221ff57..3b94081118bc 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1626,12 +1626,16 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 	if (ret < 0)
 		return ret;
 	ret = rw_verify_area(WRITE, file, &req->ki_pos, iov_iter_count(&iter));
-	if (!ret) {
-		if (S_ISREG(file_inode(file)->i_mode))
-			kiocb_start_write(req);
-		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, file->f_op->write_iter(req, &iter));
+	if (unlikely(ret))
+		goto out;
+	if (S_ISREG(file_inode(file)->i_mode)) {
+		ret = kiocb_start_write(req);
+		if (unlikely(ret))
+			goto out;
 	}
+	req->ki_flags |= IOCB_WRITE;
+	aio_rw_done(req, file->f_op->write_iter(req, &iter));
+out:
 	kfree(iovec);
 	return ret;
 }
diff --git a/fs/read_write.c b/fs/read_write.c
index 90e283b31ca1..12996892bb1d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -859,7 +859,9 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	kiocb_start_write(iocb);
+	ret = kiocb_start_write(iocb);
+	if (ret < 0)
+		return ret;
 	ret = file->f_op->write_iter(iocb, iter);
 	if (ret != -EIOCBQUEUED)
 		kiocb_end_write(iocb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 52841aab13fb..3ac37d9884f5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2920,7 +2920,7 @@ static inline void file_end_write(struct file *file)
  * This is a variant of sb_start_write() for async io submission.
  * Should be matched with a call to kiocb_end_write().
  */
-static inline void kiocb_start_write(struct kiocb *iocb)
+static inline int __must_check kiocb_start_write(struct kiocb *iocb)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
@@ -2930,6 +2930,7 @@ static inline void kiocb_start_write(struct kiocb *iocb)
 	 * doesn't complain about the held lock when we return to userspace.
 	 */
 	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	return 0;
 }
 
 /**
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c004d21e2f12..a9dc9f84fb60 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -1040,8 +1040,11 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(ret))
 		return ret;
 
-	if (req->flags & REQ_F_ISREG)
-		kiocb_start_write(kiocb);
+	if (req->flags & REQ_F_ISREG) {
+		ret = kiocb_start_write(kiocb);
+		if (unlikely(ret))
+			return ret;
+	}
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
-- 
2.35.3


