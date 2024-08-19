Return-Path: <linux-fsdevel+bounces-26226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EA295634A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 07:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3490B1F215C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 05:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A877B14A4F9;
	Mon, 19 Aug 2024 05:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q4UOQzW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DhqnJEJ7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q4UOQzW1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DhqnJEJ7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78223154C14;
	Mon, 19 Aug 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724045848; cv=none; b=beQ+dLOVAk7ZkoFgXfKl4cOVKLrrGKJgDY+qYxQp1IEf9JeC8tUQt29fAjF0Fkob7KZl4HkPoyZKUAmLLv3sPxxtyJuCuEVyaJh7pQ156UU+nqWoNKM/PRehSD3LJexbNGZuT5j4OFsBTLwaYm1DG6EjoD1r90heyKUiCzTKC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724045848; c=relaxed/simple;
	bh=+b7nmQ4Sr2Sg9L4LCj11wIQ6G6RwWM5O4aYEDZmDUZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ4G38QORUR0xhx4GxSjBBr0G59fPAnUraOIjhlR7LsHD5BU9Lc+jpYIZDtZ1PAvZyMFVZ1q3QGGD5Ypz5WPi+RtKkr25t0f0aD4qaBudk67g1u6gU6dyvnnM2KOekaOu5pkYrw9SWXSh2AFShj8pClsUr1K5MqFQs6D+SscTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q4UOQzW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DhqnJEJ7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q4UOQzW1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DhqnJEJ7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8894B21AF5;
	Mon, 19 Aug 2024 05:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP1OxRACFCi3CeZXPSAq2tmZvmlqIkYwyzh7BNYf83o=;
	b=Q4UOQzW1s5LqoZvh2oq5egHzU8I+hrwEZV+sBOKVUcLZHcR1XX1AXsx8MkHqfXBWbBKfA+
	TBEjJuuD4pgzOhVLJORPkQs4K8YB1FzslNBdFYiqvkafzJh65ATZuujjm5TE+5t+tJqwPZ
	krBVOX5uHzbAXvR4ZaecdXdinGINKko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP1OxRACFCi3CeZXPSAq2tmZvmlqIkYwyzh7BNYf83o=;
	b=DhqnJEJ7lvw1jq9xCt9jza5DLqTfx5rSLq+rqA7vVkbwigk9JGEXrHwJTR7N+PZrZRlwWV
	LTUtgoDWJ3+2txDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q4UOQzW1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DhqnJEJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724045844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP1OxRACFCi3CeZXPSAq2tmZvmlqIkYwyzh7BNYf83o=;
	b=Q4UOQzW1s5LqoZvh2oq5egHzU8I+hrwEZV+sBOKVUcLZHcR1XX1AXsx8MkHqfXBWbBKfA+
	TBEjJuuD4pgzOhVLJORPkQs4K8YB1FzslNBdFYiqvkafzJh65ATZuujjm5TE+5t+tJqwPZ
	krBVOX5uHzbAXvR4ZaecdXdinGINKko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724045844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wP1OxRACFCi3CeZXPSAq2tmZvmlqIkYwyzh7BNYf83o=;
	b=DhqnJEJ7lvw1jq9xCt9jza5DLqTfx5rSLq+rqA7vVkbwigk9JGEXrHwJTR7N+PZrZRlwWV
	LTUtgoDWJ3+2txDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA7681397F;
	Mon, 19 Aug 2024 05:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yunoGxLawmYCYgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 19 Aug 2024 05:37:22 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/9] block/pktdvd: switch congestion waiting to ___wait_var_event()
Date: Mon, 19 Aug 2024 15:20:40 +1000
Message-ID: <20240819053605.11706-7-neilb@suse.de>
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
X-Rspamd-Queue-Id: 8894B21AF5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -5.01

Rather than having an open-coded wait event loop, use
__var_wait_event().
This fixes a bug as the existing loop doesn't call finish_wait().

Also add missing memory barrier before wake_up_var().

Signed-off-by: NeilBrown <neilb@suse.de>
---
 drivers/block/pktcdvd.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 7cece5884b9c..273fbe05d80f 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1210,6 +1210,7 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 	if (pd->congested &&
 	    pd->bio_queue_size <= pd->write_congestion_off) {
 		pd->congested = false;
+		smp_mb();
 		wake_up_var(&pd->congested);
 	}
 	spin_unlock(&pd->lock);
@@ -2383,20 +2384,16 @@ static void pkt_make_request_write(struct bio *bio)
 	spin_lock(&pd->lock);
 	if (pd->write_congestion_on > 0
 	    && pd->bio_queue_size >= pd->write_congestion_on) {
-		struct wait_bit_queue_entry wqe;
 
-		init_wait_var_entry(&wqe, &pd->congested, 0);
-		for (;;) {
-			prepare_to_wait_event(__var_waitqueue(&pd->congested),
-					      &wqe.wq_entry,
-					      TASK_UNINTERRUPTIBLE);
-			if (pd->bio_queue_size <= pd->write_congestion_off)
-				break;
-			pd->congested = true;
-			spin_unlock(&pd->lock);
-			schedule();
-			spin_lock(&pd->lock);
-		}
+		___wait_var_event(&pd->congested,
+				  pd->bio_queue_size <= pd->write_congestion_off,
+				  TASK_UNINTERRUPTIBLE, 0, 0,
+				  ({ pd->congested = true;
+				    spin_unlock(&pd->lock);
+				    schedule();
+				    spin_lock(&pd->lock);
+				  })
+		);
 	}
 	spin_unlock(&pd->lock);
 
-- 
2.44.0


