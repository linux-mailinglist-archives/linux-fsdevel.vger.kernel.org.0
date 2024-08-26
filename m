Return-Path: <linux-fsdevel+bounces-27091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20C95E913
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3AE1C2087C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9BF84A36;
	Mon, 26 Aug 2024 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iq3DZ8T0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZnxHgty0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iq3DZ8T0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZnxHgty0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A309A83CA0;
	Mon, 26 Aug 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654247; cv=none; b=RGNBOGQKbABM7r8m4uOKl0rCrd/OEKzwfkgbk3RTBMa1EQf5aMTpwTbiJwcXwiYee0koYj6wsMKfJuIqsWlnC3ATyxMApdGw2JJ+AYMgLKWYy9mE+JlIwVfOu5Cc2Zf4ba4wAOB7W6Hw5D0XibwC4KAXpBrUjKmk2QRDZewIKXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654247; c=relaxed/simple;
	bh=UNa/mbC3OpcW1lOX4b6toj/OKSZTmT1AmounDSZjksA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtUBMkzL39z7aYBdlP87YEvvDT8tLmX+4liBNWOG14nqE3O493Z0ncUZkqouA+6NiFREK8bFXmWaT5ekETmetTRlwSCX4g+fmlX3KmveI+K3kcciPyf9gwUCYvfFoM5ncWcip/OEwEGumNGEUwGPW8NoWrWJLFKc7f7TyPkmWuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iq3DZ8T0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZnxHgty0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iq3DZ8T0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZnxHgty0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B034C1F83B;
	Mon, 26 Aug 2024 06:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ7qqMqYr+coZy8gdEZ03r7ExQ3wOPQZ6PCEnVK5cfk=;
	b=Iq3DZ8T0D8QI2VPD2ma24FBKYAsOiLhbEFr1q40IGm6ZxrSnY24NiW/oXHiEtSqJESe8ZA
	RDE4bT0UKzciqrOW9NUT3uqYw7606VFg6CgXHYvOYdw+AKx8YJVb9V/9LnFUbrk8BGYjFu
	bELJFgLV1JtXmbgcQJFA17g8qBxMNYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ7qqMqYr+coZy8gdEZ03r7ExQ3wOPQZ6PCEnVK5cfk=;
	b=ZnxHgty0wfoXE/vEHhAXtciT6D5BdI45QeZqrzrlqfPsBS5HwP6lhiQ20o/pGobEo4IRXW
	/TqjJHqkG6enhPCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Iq3DZ8T0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZnxHgty0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ7qqMqYr+coZy8gdEZ03r7ExQ3wOPQZ6PCEnVK5cfk=;
	b=Iq3DZ8T0D8QI2VPD2ma24FBKYAsOiLhbEFr1q40IGm6ZxrSnY24NiW/oXHiEtSqJESe8ZA
	RDE4bT0UKzciqrOW9NUT3uqYw7606VFg6CgXHYvOYdw+AKx8YJVb9V/9LnFUbrk8BGYjFu
	bELJFgLV1JtXmbgcQJFA17g8qBxMNYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654242;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zZ7qqMqYr+coZy8gdEZ03r7ExQ3wOPQZ6PCEnVK5cfk=;
	b=ZnxHgty0wfoXE/vEHhAXtciT6D5BdI45QeZqrzrlqfPsBS5HwP6lhiQ20o/pGobEo4IRXW
	/TqjJHqkG6enhPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DBEA13724;
	Mon, 26 Aug 2024 06:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 06rRAKAizGYnOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:20 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: change wait on bd_claiming to use a var_waitqueue, not a bit_waitqueue
Date: Mon, 26 Aug 2024 16:30:58 +1000
Message-ID: <20240826063659.15327-2-neilb@suse.de>
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
X-Rspamd-Queue-Id: B034C1F83B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

bd_prepare_to_claim() waits for a var to change, not for a bit to be
cleared.
So change from bit_waitqueue() to __var_waitqueue() and correspondingly
use wake_up_var().
This will allow a future patch which change the "bit" function to expect
an "unsigned long *" instead of "void *".

Signed-off-by: NeilBrown <neilb@suse.de>
---
 block/bdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c5507b6f63b8..21e688fb6449 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -548,7 +548,7 @@ int bd_prepare_to_claim(struct block_device *bdev, void *holder,
 
 	/* if claiming is already in progress, wait for it to finish */
 	if (whole->bd_claiming) {
-		wait_queue_head_t *wq = bit_waitqueue(&whole->bd_claiming, 0);
+		wait_queue_head_t *wq = __var_waitqueue(&whole->bd_claiming);
 		DEFINE_WAIT(wait);
 
 		prepare_to_wait(wq, &wait, TASK_UNINTERRUPTIBLE);
@@ -571,7 +571,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 	/* tell others that we're done */
 	BUG_ON(whole->bd_claiming != holder);
 	whole->bd_claiming = NULL;
-	wake_up_bit(&whole->bd_claiming, 0);
+	wake_up_var(&whole->bd_claiming);
 }
 
 /**
-- 
2.44.0


