Return-Path: <linux-fsdevel+bounces-27097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C565F95E928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6711F20E8F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C0413C677;
	Mon, 26 Aug 2024 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RntaQXJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Fq6KpsS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RntaQXJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Fq6KpsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23E13BC35;
	Mon, 26 Aug 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654281; cv=none; b=i7WHJ81wECCLUZJXcpUj14c/gq/zhsmSHsg9WDzs0VnJqonzTo4szmwDJmpm8vyu1Z7tmr8aQ2IC/Z9yJRq2X79ZCB6LmBOdVIUvdCVhzOKyDkWztQO74AujxO4GLwIuPmBZBVQfcoR4A2+dFDj/1+iGIquMojL1lucwCoj1vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654281; c=relaxed/simple;
	bh=8YiS0NVbpntah7NlxqDrvjOjb4m/yskhqzU/Dcc31JQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrF4mLB3MYkarSGyu4PeR8P+fUCxuaBZQmGZjSUtAcKAHBVBVx++2q3lbIg4zwB9f5Qlr78itbbOGXcUSoj8y0dUlIM/JleLn8EzLJxMPTj0Y8I/7M90zPQtq5oFqkfjL6aPMyw12eIZfs+Zk5VuDwN6sm0bP5lR+dBGYmlUvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RntaQXJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Fq6KpsS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RntaQXJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Fq6KpsS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDA2721A9F;
	Mon, 26 Aug 2024 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZDV6v6nuwIxH+xFPpK0scrQAAGNBkk5VdIq6lbCH+0=;
	b=RntaQXJBBX+DVQyQCKn2+wVpQEsk0ZAhNxWvGhqKFtKbLcyef+dqrhyHuPXWs1zmfZ8M+x
	zIk3J+uXZ6orS/q8t51eSuQ74i6Rd0+GWfhImaiJCQXApQrnCewgbSxr8ArmrXI7m+cfb4
	V8hbX2usSoGSWzkor+WMknP/1i3GFso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZDV6v6nuwIxH+xFPpK0scrQAAGNBkk5VdIq6lbCH+0=;
	b=7Fq6KpsSIq2jqNgoz+Zg7JBheXbHo97zLZHuoRHzxz4/L1VSHLccsc8C3AFgf5OTZCUK6M
	MO3IThti+bZ34KBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZDV6v6nuwIxH+xFPpK0scrQAAGNBkk5VdIq6lbCH+0=;
	b=RntaQXJBBX+DVQyQCKn2+wVpQEsk0ZAhNxWvGhqKFtKbLcyef+dqrhyHuPXWs1zmfZ8M+x
	zIk3J+uXZ6orS/q8t51eSuQ74i6Rd0+GWfhImaiJCQXApQrnCewgbSxr8ArmrXI7m+cfb4
	V8hbX2usSoGSWzkor+WMknP/1i3GFso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ZDV6v6nuwIxH+xFPpK0scrQAAGNBkk5VdIq6lbCH+0=;
	b=7Fq6KpsSIq2jqNgoz+Zg7JBheXbHo97zLZHuoRHzxz4/L1VSHLccsc8C3AFgf5OTZCUK6M
	MO3IThti+bZ34KBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EE8713724;
	Mon, 26 Aug 2024 06:37:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +pZxCcMizGZkOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:55 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 7/7] Block: switch bd_prepare_to_claim to use wait_var_event_mutex()
Date: Mon, 26 Aug 2024 16:31:04 +1000
Message-ID: <20240826063659.15327-8-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240826063659.15327-1-neilb@suse.de>
References: <20240826063659.15327-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

bd_prepare_to_claim() contains an open-coded version of the new
wait_var_event_mutex().
Change it to use that function and re-organise the code to benefit from
this change.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 block/bdev.c | 49 +++++++++++++++++++------------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 21e688fb6449..6e827ee02e7d 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -487,10 +487,10 @@ long nr_blockdev_pages(void)
  * Test whether @bdev can be claimed by @holder.
  *
  * RETURNS:
- * %true if @bdev can be claimed, %false otherwise.
+ * %0 if @bdev can be claimed, %-EBUSY otherwise.
  */
-static bool bd_may_claim(struct block_device *bdev, void *holder,
-		const struct blk_holder_ops *hops)
+static int bd_may_claim(struct block_device *bdev, void *holder,
+			const struct blk_holder_ops *hops)
 {
 	struct block_device *whole = bdev_whole(bdev);
 
@@ -503,9 +503,9 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
 		if (bdev->bd_holder == holder) {
 			if (WARN_ON_ONCE(bdev->bd_holder_ops != hops))
 				return false;
-			return true;
+			return 0;
 		}
-		return false;
+		return -EBUSY;
 	}
 
 	/*
@@ -514,8 +514,8 @@ static bool bd_may_claim(struct block_device *bdev, void *holder,
 	 */
 	if (whole != bdev &&
 	    whole->bd_holder && whole->bd_holder != bd_may_claim)
-		return false;
-	return true;
+		return -EBUSY;
+	return 0;
 }
 
 /**
@@ -535,43 +535,32 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 		const struct blk_holder_ops *hops)
 {
 	struct block_device *whole = bdev_whole(bdev);
+	int err = 0;
 
 	if (WARN_ON_ONCE(!holder))
 		return -EINVAL;
-retry:
-	mutex_lock(&bdev_lock);
-	/* if someone else claimed, fail */
-	if (!bd_may_claim(bdev, holder, hops)) {
-		mutex_unlock(&bdev_lock);
-		return -EBUSY;
-	}
 
-	/* if claiming is already in progress, wait for it to finish */
-	if (whole->bd_claiming) {
-		wait_queue_head_t *wq = __var_waitqueue(&whole->bd_claiming);
-		DEFINE_WAIT(wait);
-
-		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-		mutex_unlock(&bdev_lock);
-		schedule();
-		finish_wait(wq, &wait);
-		goto retry;
-	}
+	mutex_lock(&bdev_lock);
+	wait_var_event_mutex(&whole->bd_claiming,
+			     (err = bd_may_claim(bdev, holder, hops)) != 0 ||
+			     whole->bd_claiming == NULL,
+			     &bdev_lock);
 
-	/* yay, all mine */
-	whole->bd_claiming = holder;
+	/* if someone else claimed, fail */
+	if (!err)
+		/* yay, all mine */
+		whole->bd_claiming = holder;
 	mutex_unlock(&bdev_lock);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
 
 static void bd_clear_claiming(struct block_device *whole, void *holder)
 {
-	lockdep_assert_held(&bdev_lock);
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
-	wake_up_var(&whole->bd_claiming);
+	wake_up_var_locked(&whole->bd_claiming, &bdev_lock);
 }
 
 /**
-- 
2.44.0


