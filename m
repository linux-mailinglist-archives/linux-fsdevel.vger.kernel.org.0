Return-Path: <linux-fsdevel+bounces-26225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76CD6956348
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F2D1F227DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEED152517;
	Mon, 19 Aug 2024 05:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GtdM9Gik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K9U8BCkB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GtdM9Gik";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="K9U8BCkB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3711314F9D5;
	Mon, 19 Aug 2024 05:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045838; cv=none; b=deqvD2PUgdcxGIpSoc0LpGkEegjreivWvQUlHiJSiB1+RXeNfezfCXJbzUDTMkYThKspxEly1tMj5OwFj9UcERAiTsviR3dYFJgSdJNgKtJZKhsJS4BG1v0wpUwZNU/uF3Sjp4TJ/SYKvfHp4VfmN06z/Hy4+fT6zonXhfo4JgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045838; c=relaxed/simple;
	bh=p+2eYszvjeDRh02VS9vlzU4X00hqz0hlvvh8NqQF+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dhMgNKQToPZiGIbGYRKUgZ02fJ0TrQX+rFsrvSmtf/kL83bf6f/YAY/bK0Jbos3slPZ5XPNA0377tyhWtq97eWQhZfJkHrVq6W+hx871VOHcaaXzAHtXdKsEMck2bBSrMgGFWX88uFhw8Znf1RCWF1wFX9qRgWv71AQ4MvJVvpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GtdM9Gik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K9U8BCkB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GtdM9Gik; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=K9U8BCkB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 564B01FE4C;
	Mon, 19 Aug 2024 05:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ITmCsqCLDIRP3HBMUg4mi1uCfxSxsm+7TIJdoo9tk=;
	b=GtdM9GikltCh7iWzAz1RrhnZ7oclD9uC+i0htLqBIeIZYQzf54xq5Dt4tsOwHVbaJX/GRG
	Cbr0CDDHNywmmCTS2SvCFlyw3/t+jjRCpZd5+atZBXA92AZ8I3pm8vagicQh6FCPM2hjKE
	iLAIrnpxDeNg9kMTZ71YvE47xlF4PAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ITmCsqCLDIRP3HBMUg4mi1uCfxSxsm+7TIJdoo9tk=;
	b=K9U8BCkBj5c1OGutvh9BnV8oUGdwwJ2OyCMt8En3Xxm1Ll8Dpr7vMNYGIdG3WPhO4L0+NK
	JSYze9xYzqfVXFBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GtdM9Gik;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K9U8BCkB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ITmCsqCLDIRP3HBMUg4mi1uCfxSxsm+7TIJdoo9tk=;
	b=GtdM9GikltCh7iWzAz1RrhnZ7oclD9uC+i0htLqBIeIZYQzf54xq5Dt4tsOwHVbaJX/GRG
	Cbr0CDDHNywmmCTS2SvCFlyw3/t+jjRCpZd5+atZBXA92AZ8I3pm8vagicQh6FCPM2hjKE
	iLAIrnpxDeNg9kMTZ71YvE47xlF4PAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045835;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x7ITmCsqCLDIRP3HBMUg4mi1uCfxSxsm+7TIJdoo9tk=;
	b=K9U8BCkBj5c1OGutvh9BnV8oUGdwwJ2OyCMt8En3Xxm1Ll8Dpr7vMNYGIdG3WPhO4L0+NK
	JSYze9xYzqfVXFBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88B501397F;
	Mon, 19 Aug 2024 05:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GT7IDwnawmb5YQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:37:13 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/9] Block: switch bd_prepare_to_claim to use ___wait_var_event()
Date: Mon, 19 Aug 2024 15:20:39 +1000
Message-ID: <20240819053605.11706-6-neilb@suse.de>
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
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 564B01FE4C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.01

bd_prepare_to_claim() current uses a bit waitqueue with a matching
wake_up_bit() in bd_clear_claiming().  However it is really waiting on a
"var", not a "bit".

So change to wake_up_var(), and use ___wait_var_event() for the waiting.
Using the triple-underscore version allows us to drop the mutex across
the schedule() call.

Add a missing memory barrier before the wake_up_var() call.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 block/bdev.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c5507b6f63b8..d804c91c651b 100644
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
@@ -535,33 +535,23 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
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
-
-	/* if claiming is already in progress, wait for it to finish */
-	if (whole->bd_claiming) {
-		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
-		DEFINE_WAIT(wait);
 
-		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
-		mutex_unlock(&bdev_lock);
-		schedule();
-		finish_wait(wq, &wait);
-		goto retry;
-	}
+	mutex_lock(&bdev_lock);
+	___wait_var_event(&whole->bd_claiming,
+			  (err = bd_may_claim(bdev, holder, hops)) != 0 || !whole->bd_claiming,
+			  TASK_UNINTERRUPTIBLE, 0, 0,
+			  mutex_unlock(&bdev_lock); schedule(); mutex_lock(&bdev_lock));
 
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
 
@@ -571,7 +561,8 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
-	wake_up_bit(&whole->bd_claiming, 0);
+	smp_mb();
+	wake_up_var(&whole->bd_claiming);
 }
 
 /**
-- 
2.44.0


