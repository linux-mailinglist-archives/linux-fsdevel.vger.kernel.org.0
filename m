Return-Path: <linux-fsdevel+bounces-54675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E50B021D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FD53A52BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427312ED161;
	Fri, 11 Jul 2025 16:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VjT8zQE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VANr30i1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2VjT8zQE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VANr30i1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093771754B
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251535; cv=none; b=hDRnrqCx6w6fs3D7RcABntvzSiYCDAOiyNz7YwarexF2jhzQ8cfntf/vLCis5B5JE2WXraq2LdDkdGYa+gC/c0Y/7EHh5E3lumSmAQ1oIptv8MSIR5rQMGi6rezfPciNu1nrJIXzMvqfkaWVVBmjRQZdZNiIR0x0/8qObSSguPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251535; c=relaxed/simple;
	bh=cdZuEh4Dk+/Xi2fTOZRQxovM+RzBRb1FW6MBEN4Icws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bt134BfLClFayguuXAqXKymc7llGwyQzU0t6ScTSPtCzgcREFt1cnaM0X57ETR/0i9WOnLtJNPjTMexlY0+pClUPldU/g0/F0XIsFO6/2RZvW0xFw0i+S9pH0lDDIoNZ3tGN+yKnyEWvy67XMd2kDShIf+ni3wtvBEJxfwulKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VjT8zQE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VANr30i1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2VjT8zQE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VANr30i1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 16D6B1F79A;
	Fri, 11 Jul 2025 16:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752251532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+3HFNjXjHREl6hvy4YGDTeevGivV8BudVSskYuO9E4=;
	b=2VjT8zQEVCOKpggM5SvF9lRgZIIuHKddyLQHYbBt2GpfTnw7GXqK+E5UZ4pJMEHXR4vYo6
	hNTTCj7NuA+m5ZNh9vCtA2kecehSa9qXm1HLP2/tWWzEHIjmcJxjt6XqCylN+vkZD/mEHY
	c6bF2olUt+njLmCyOgtUuYIKxKT+evU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752251532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+3HFNjXjHREl6hvy4YGDTeevGivV8BudVSskYuO9E4=;
	b=VANr30i1CuUa4IF13xYNodiqWR4qgkr0YW1HLYkSsArhzmbagQG4i+kP6CHdegRvMbT65J
	tf+f6+tyIAHCZmDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2VjT8zQE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VANr30i1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752251532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+3HFNjXjHREl6hvy4YGDTeevGivV8BudVSskYuO9E4=;
	b=2VjT8zQEVCOKpggM5SvF9lRgZIIuHKddyLQHYbBt2GpfTnw7GXqK+E5UZ4pJMEHXR4vYo6
	hNTTCj7NuA+m5ZNh9vCtA2kecehSa9qXm1HLP2/tWWzEHIjmcJxjt6XqCylN+vkZD/mEHY
	c6bF2olUt+njLmCyOgtUuYIKxKT+evU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752251532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8+3HFNjXjHREl6hvy4YGDTeevGivV8BudVSskYuO9E4=;
	b=VANr30i1CuUa4IF13xYNodiqWR4qgkr0YW1HLYkSsArhzmbagQG4i+kP6CHdegRvMbT65J
	tf+f6+tyIAHCZmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05FA81388B;
	Fri, 11 Jul 2025 16:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6iUUAYw8cWiSeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 16:32:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A693CA099A; Fri, 11 Jul 2025 18:32:11 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-block@vger.kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Subject: [PATCH] loop: Avoid updating block size under exclusive owner
Date: Fri, 11 Jul 2025 18:32:03 +0200
Message-ID: <20250711163202.19623-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3277; i=jack@suse.cz; h=from:subject; bh=cdZuEh4Dk+/Xi2fTOZRQxovM+RzBRb1FW6MBEN4Icws=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGDIKbZq0xH0Ml+s1mUn/FXh44vuGfB7/6WemZT/fv/SJRXZ0 +Oc9nYzGLAyMHAyyYoosqyMval+bZ9S1NVRDBmYQKxPIFAYuTgGYyJE37P+TzLkNtVn5K1Q9Umaq3T Vmcb4tyOvXYsYcLfHv9g9F9zVruARylmxL8Gx73a307cwFM9/kww0b8vqYHvX33H2TnVeYsO+NW0RF KsOmd0cUjl7aWW4kFO6cOtNdIZ/HrHijk2bAKdYZ1wwucvbN27p4kRvXZfMu06WeZyz/7+FrF/9270 Ostl1ml45ORWBlp5amyvXZvl33u5tr76znST50+oRf0to8n2afbSZCK3Ris+7MjpqnMo+lK+Sf5s/+ L65hUjq2EwOyugu3PAk1khb9cHXhXN6anJo32VfsI6N+MsSzMxh+4O86wRg/98EH3obLLcIX2wOjKu es+vb1lH1Gx6ctQVE7E7Ok87oA
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 16D6B1F79A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[01ef7a8da81a975e1ccd];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -1.51

Syzbot came up with a reproducer where a loop device block size is
changed underneath a mounted filesystem. This causes a mismatch between
the block device block size and the block size stored in the superblock
causing confusion in various places such as fs/buffer.c. The particular
issue triggered by syzbot was a warning in __getblk_slow() due to
requested buffer size not matching block device block size.

Fix the problem by getting exclusive hold of the loop device to change
its block size. This fails if somebody (such as filesystem) has already
an exclusive ownership of the block device and thus prevents modifying
the loop device under some exclusive owner which doesn't expect it.

Reported-by: syzbot+01ef7a8da81a975e1ccd@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/loop.c | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 500840e4a74e..5cc72770e253 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1432,17 +1432,34 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 	return 0;
 }
 
-static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
+static int loop_set_block_size(struct loop_device *lo, blk_mode_t mode,
+			       struct block_device *bdev, unsigned long arg)
 {
 	struct queue_limits lim;
 	unsigned int memflags;
 	int err = 0;
 
-	if (lo->lo_state != Lo_bound)
-		return -ENXIO;
+	/*
+	 * If we don't hold exclusive handle for the device, upgrade to it
+	 * here to avoid changing device under exclusive owner.
+	 */
+	if (!(mode & BLK_OPEN_EXCL)) {
+		err = bd_prepare_to_claim(bdev, loop_set_block_size, NULL);
+		if (err)
+			return err;
+	}
+
+	err = mutex_lock_killable(&lo->lo_mutex);
+	if (err)
+		goto abort_claim;
+
+	if (lo->lo_state != Lo_bound) {
+		err = -ENXIO;
+		goto unlock;
+	}
 
 	if (lo->lo_queue->limits.logical_block_size == arg)
-		return 0;
+		goto unlock;
 
 	sync_blockdev(lo->lo_device);
 	invalidate_bdev(lo->lo_device);
@@ -1455,6 +1472,11 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	loop_update_dio(lo);
 	blk_mq_unfreeze_queue(lo->lo_queue, memflags);
 
+unlock:
+	mutex_unlock(&lo->lo_mutex);
+abort_claim:
+	if (!(mode & BLK_OPEN_EXCL))
+		bd_abort_claiming(bdev, loop_set_block_size);
 	return err;
 }
 
@@ -1473,9 +1495,6 @@ static int lo_simple_ioctl(struct loop_device *lo, unsigned int cmd,
 	case LOOP_SET_DIRECT_IO:
 		err = loop_set_dio(lo, arg);
 		break;
-	case LOOP_SET_BLOCK_SIZE:
-		err = loop_set_block_size(lo, arg);
-		break;
 	default:
 		err = -EINVAL;
 	}
@@ -1530,9 +1549,12 @@ static int lo_ioctl(struct block_device *bdev, blk_mode_t mode,
 		break;
 	case LOOP_GET_STATUS64:
 		return loop_get_status64(lo, argp);
+	case LOOP_SET_BLOCK_SIZE:
+		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		return loop_set_block_size(lo, mode, bdev, arg);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
-	case LOOP_SET_BLOCK_SIZE:
 		if (!(mode & BLK_OPEN_WRITE) && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
 		fallthrough;
-- 
2.43.0


