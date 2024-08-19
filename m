Return-Path: <linux-fsdevel+bounces-26224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 220CA956346
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD43E28152E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C4156C65;
	Mon, 19 Aug 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i8YCrN2o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X7eo8tED";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i8YCrN2o";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X7eo8tED"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E17156C72;
	Mon, 19 Aug 2024 05:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045819; cv=none; b=jnY8tT/NIL4GJ4t0B/0QRxGxNTQ37wnifQiXYylvQML9WLapC6yKlj4MY65Y5y4kh5HwOUv4YHiYwhH2myQ9rIWksPYTbhfeyGklbdiBmeiuKRk3YsxE0rvCNk+RmnJMoAY2U4TvV36dPZq3k03pnss/U/yiFsRuG3P21ARxRN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045819; c=relaxed/simple;
	bh=qkvnfihnnudBczAmw9nIzQM3KZliITv23fW1fQvEDhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVxOhVQhsrjOHdO0KPGtDKOgxVGqn61vRBSH4tdOkOM1yTmhEdPDHvglhD6C90eFDo9pi62Jb8Rle8TVnlZ3EVajtGOQD/Xza89o5W65IohNJB0a6S+hxVKb6ddb0RjGPXsnvGbGILN7vvfEVCE2Kydw/05vjVPViBIycgIfHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i8YCrN2o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X7eo8tED; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i8YCrN2o; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X7eo8tED; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 286C01FE4B;
	Mon, 19 Aug 2024 05:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcAE783VP5HFboAUF/EwJO+4f2CO60O/Exe7z7U4hY=;
	b=i8YCrN2o+CCOGHHUBBp1mq2ssVzsGdy7SpspNgs20Bfli/6e62DxhZo/w8oaJzrPQChv3a
	PfIVAWb8gnI7T0OLm3xbQ4kSw1OOtMZ6A5ZuN/vjsQklkSiOfKw2EnF0xzU93tWuj2Zh6P
	6blB3eliar/Uo6QnRddkcdqC4cIuwLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcAE783VP5HFboAUF/EwJO+4f2CO60O/Exe7z7U4hY=;
	b=X7eo8tEDzD+q/7kj0JxrJ8vZUXtr1y3205muEAUYzlEewG90Szv49or4I49XvkVpsgHxiw
	E0dG+uj9IxXb29CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcAE783VP5HFboAUF/EwJO+4f2CO60O/Exe7z7U4hY=;
	b=i8YCrN2o+CCOGHHUBBp1mq2ssVzsGdy7SpspNgs20Bfli/6e62DxhZo/w8oaJzrPQChv3a
	PfIVAWb8gnI7T0OLm3xbQ4kSw1OOtMZ6A5ZuN/vjsQklkSiOfKw2EnF0xzU93tWuj2Zh6P
	6blB3eliar/Uo6QnRddkcdqC4cIuwLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPcAE783VP5HFboAUF/EwJO+4f2CO60O/Exe7z7U4hY=;
	b=X7eo8tEDzD+q/7kj0JxrJ8vZUXtr1y3205muEAUYzlEewG90Szv49or4I49XvkVpsgHxiw
	E0dG+uj9IxXb29CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A58B1397F;
	Mon, 19 Aug 2024 05:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oP1jBPXZwmboYQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:36:53 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/9] Use wait_var_event() instead of I_DIO_WAKEUP
Date: Mon, 19 Aug 2024 15:20:38 +1000
Message-ID: <20240819053605.11706-5-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240819053605.11706-1-neilb@suse.de>
References: <20240819053605.11706-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

inode_dio_wait() is essentially an open-coded version of
wait_var_event().  Similarly inode_dio_wait_interruptible() is an
open-coded version of wait_var_event_interruptible().

If we switch to waiting on the var, instead of an imaginary bit, the
code is more transparent, is shorter, and we can discard I_DIO_WAKEUP.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/inode.c         | 16 ++--------------
 fs/netfs/locking.c | 19 ++-----------------
 include/linux/fs.h |  7 +------
 3 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..91bb2f80fa03 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2467,18 +2467,6 @@ EXPORT_SYMBOL(inode_owner_or_capable);
 /*
  * Direct i/o helper functions
  */
-static void __inode_dio_wait(struct inode *inode)
-{
-	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
-	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
-
-	do {
-		prepare_to_wait(wq, &q.wq_entry, TASK_UNINTERRUPTIBLE);
-		if (atomic_read(&inode->i_dio_count))
-			schedule();
-	} while (atomic_read(&inode->i_dio_count));
-	finish_wait(wq, &q.wq_entry);
-}
 
 /**
  * inode_dio_wait - wait for outstanding DIO requests to finish
@@ -2492,8 +2480,8 @@ static void __inode_dio_wait(struct inode *inode)
  */
 void inode_dio_wait(struct inode *inode)
 {
-	if (atomic_read(&inode->i_dio_count))
-		__inode_dio_wait(inode);
+	wait_var_event(&inode->i_dio_count,
+		       atomic_read(&inode->i_dio_count) == 0);
 }
 EXPORT_SYMBOL(inode_dio_wait);
 
diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
index 75dc52a49b3a..c171a0a48ed0 100644
--- a/fs/netfs/locking.c
+++ b/fs/netfs/locking.c
@@ -21,23 +21,8 @@
  */
 static int inode_dio_wait_interruptible(struct inode *inode)
 {
-	if (!atomic_read(&inode->i_dio_count))
-		return 0;
-
-	wait_queue_head_t *wq = bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP);
-	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
-
-	for (;;) {
-		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
-		if (!atomic_read(&inode->i_dio_count))
-			break;
-		if (signal_pending(current))
-			break;
-		schedule();
-	}
-	finish_wait(wq, &q.wq_entry);
-
-	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
+	return wait_var_event_interruptible(&inode->i_dio_count,
+					    !atomic_read(&inode->i_dio_count));
 }
 
 /* Call with exclusively locked inode->i_rwsem */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..fc1b68134cbf 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2372,8 +2372,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_REFERENCED		Marks the inode as recently references on the LRU list.
  *
- * I_DIO_WAKEUP		Never set.  Only used as a key for wait_on_bit().
- *
  * I_WB_SWITCH		Cgroup bdi_writeback switching in progress.  Used to
  *			synchronize competing switching instances and to tell
  *			wb stat updates to grab the i_pages lock.  See
@@ -2405,8 +2403,6 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define __I_SYNC		7
 #define I_SYNC			(1 << __I_SYNC)
 #define I_REFERENCED		(1 << 8)
-#define __I_DIO_WAKEUP		9
-#define I_DIO_WAKEUP		(1 << __I_DIO_WAKEUP)
 #define I_LINKABLE		(1 << 10)
 #define I_DIRTY_TIME		(1 << 11)
 #define I_WB_SWITCH		(1 << 13)
@@ -3237,8 +3233,7 @@ static inline void inode_dio_begin(struct inode *inode)
  */
 static inline void inode_dio_end(struct inode *inode)
 {
-	if (atomic_dec_and_test(&inode->i_dio_count))
-		wake_up_bit(&inode->i_state, __I_DIO_WAKEUP);
+	atomic_dec_and_wake_up_var(&inode->i_dio_count);
 }
 
 extern void inode_set_flags(struct inode *inode, unsigned int flags,
-- 
2.44.0


