Return-Path: <linux-fsdevel+bounces-27092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E5E95E916
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB2C28122E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE6B85654;
	Mon, 26 Aug 2024 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hKQI9g1a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Plctls6E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feVj+ca3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5tXCOgQk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE9378281;
	Mon, 26 Aug 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654254; cv=none; b=ul/AhMmQNjw53dXUBZXyTSpu3iDm50m45cW70OZA3zHBnSXFWrnhvkRezL9gOCP9bbgu6b0Ph6S2qjbUs4ZpPCUZyfr6M02UvvjXKAqYDlVW6Ge2kpjIj3ySbD9ahSSuhbFWyZAvJ5KkPPAvCKnHQSm1HdVmUAe/mHB93QQA3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654254; c=relaxed/simple;
	bh=dCfrj2kl/kt6Z0EursSTPCaFyKyHLEP3r1+tiEaiX/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c34kEPxuesTAvB4d8aFViom2urmKKPP0l9fHvZEelge/QQCT/bxb2GxKkvueELlml6Udtzp79Ft+ToXx5s9tdjO5+1kSwJl2EjZPNwrprFsa6ZyoXJR5yZEwwBK0925VF7fNfLhdkU3sHaD4oO0xPzXqNZgTVUF2qgXnNElbQOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hKQI9g1a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Plctls6E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feVj+ca3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5tXCOgQk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79C201F83C;
	Mon, 26 Aug 2024 06:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0AazAjBEO6XKGRkZKBGDcwpbW2z3s1AfVJ8MobowfA=;
	b=hKQI9g1aKnqt6W8jKElhuNxWf2AZrKt13XWPlH03wdCs31IyCzGqNyHrVK/8IHsz+2sWmX
	9KaNuovItl8riJAKx+haZr02bBDC27jmgfbut7boLFCtnec8ntZUuBkZJjHdHB7EVYGVnm
	0Ewi3j2K1XUpy2xRQCVc/ZRMmpWP31A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654249;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0AazAjBEO6XKGRkZKBGDcwpbW2z3s1AfVJ8MobowfA=;
	b=Plctls6EhleJATCQteKNd2mK21Q0OatyyZKBFJFHxqZDB5ijt/SzA2W/6VaEHLF9GqmVfe
	4JET8VNsaYHYN2Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=feVj+ca3;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5tXCOgQk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0AazAjBEO6XKGRkZKBGDcwpbW2z3s1AfVJ8MobowfA=;
	b=feVj+ca3cKLAPyHGMESo/vAKYcmbHxV8IBOIfDm50M/t0xlYVAFj0glhfOWTrs4Wh9YE2e
	qD4SHY5a3AqpfCHOpflVKii7W4GKXqyL7poU2Lp8JGrFfGtEjzXcmWx49k0tA3yxX68ESM
	I/WvKTFp3MnK3jZWUbmbeHSk6nPhQ0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654248;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0AazAjBEO6XKGRkZKBGDcwpbW2z3s1AfVJ8MobowfA=;
	b=5tXCOgQky77les9DRmk7JkoV0dAMj/S0kueQcU9ApE4D1w5ei7PhxcTNqdx4vTUJnHfIs5
	sK1p+eQnB9WChCAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A1A613724;
	Mon, 26 Aug 2024 06:37:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d0NvMKUizGYtOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:25 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/7] sched: change wake_up_bit() and related function to expect unsigned long *
Date: Mon, 26 Aug 2024 16:30:59 +1000
Message-ID: <20240826063659.15327-3-neilb@suse.de>
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
X-Rspamd-Queue-Id: 79C201F83C
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

wake_up_bit() currently allows a "void *".  While this isn't strictly a
problem as the address is never dereferenced, it is inconsistent with
the corresponding wait_var_event() which requires "unsigned long *" and
does dereference the pointer.

And code that needs to wait for a change in something other than an
unsigned long would be better served by wake_up_var().

This patch changes all related "void *" to "unsigned long *".

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 16 ++++++++--------
 kernel/sched/wait_bit.c  | 12 ++++++------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 7725b7579b78..48e123839892 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -8,7 +8,7 @@
 #include <linux/wait.h>
 
 struct wait_bit_key {
-	void			*flags;
+	unsigned long		*flags;
 	int			bit_nr;
 	unsigned long		timeout;
 };
@@ -23,14 +23,14 @@ struct wait_bit_queue_entry {
 
 typedef int wait_bit_action_f(struct wait_bit_key *key, int mode);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit);
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit);
 int __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
 int __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_entry, wait_bit_action_f *action, unsigned int mode);
-void wake_up_bit(void *word, int bit);
-int out_of_line_wait_on_bit(void *word, int, wait_bit_action_f *action, unsigned int mode);
-int out_of_line_wait_on_bit_timeout(void *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
-int out_of_line_wait_on_bit_lock(void *word, int, wait_bit_action_f *action, unsigned int mode);
-struct wait_queue_head *bit_waitqueue(void *word, int bit);
+void wake_up_bit(unsigned long *word, int bit);
+int out_of_line_wait_on_bit(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+int out_of_line_wait_on_bit_timeout(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode, unsigned long timeout);
+int out_of_line_wait_on_bit_lock(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
+struct wait_queue_head *bit_waitqueue(unsigned long *word, int bit);
 extern void __init wait_bit_init(void);
 
 int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
@@ -327,7 +327,7 @@ do {									\
  * You can use this helper if bitflags are manipulated atomically rather than
  * non-atomically under a lock.
  */
-static inline void clear_and_wake_up_bit(int bit, void *word)
+static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
 	clear_bit_unlock(bit, word);
 	/* See wake_up_bit() for which memory barrier you need to use. */
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 134d7112ef71..058b0e18727e 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -9,7 +9,7 @@
 
 static wait_queue_head_t bit_wait_table[WAIT_TABLE_SIZE] __cacheline_aligned;
 
-wait_queue_head_t *bit_waitqueue(void *word, int bit)
+wait_queue_head_t *bit_waitqueue(unsigned long *word, int bit)
 {
 	const int shift = BITS_PER_LONG == 32 ? 5 : 6;
 	unsigned long val = (unsigned long)word << shift | bit;
@@ -55,7 +55,7 @@ __wait_on_bit(struct wait_queue_head *wq_head, struct wait_bit_queue_entry *wbq_
 }
 EXPORT_SYMBOL(__wait_on_bit);
 
-int __sched out_of_line_wait_on_bit(void *word, int bit,
+int __sched out_of_line_wait_on_bit(unsigned long *word, int bit,
 				    wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -66,7 +66,7 @@ int __sched out_of_line_wait_on_bit(void *word, int bit,
 EXPORT_SYMBOL(out_of_line_wait_on_bit);
 
 int __sched out_of_line_wait_on_bit_timeout(
-	void *word, int bit, wait_bit_action_f *action,
+	unsigned long *word, int bit, wait_bit_action_f *action,
 	unsigned mode, unsigned long timeout)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -108,7 +108,7 @@ __wait_on_bit_lock(struct wait_queue_head *wq_head, struct wait_bit_queue_entry
 }
 EXPORT_SYMBOL(__wait_on_bit_lock);
 
-int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
+int __sched out_of_line_wait_on_bit_lock(unsigned long *word, int bit,
 					 wait_bit_action_f *action, unsigned mode)
 {
 	struct wait_queue_head *wq_head = bit_waitqueue(word, bit);
@@ -118,7 +118,7 @@ int __sched out_of_line_wait_on_bit_lock(void *word, int bit,
 }
 EXPORT_SYMBOL(out_of_line_wait_on_bit_lock);
 
-void __wake_up_bit(struct wait_queue_head *wq_head, void *word, int bit)
+void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit)
 {
 	struct wait_bit_key key = __WAIT_BIT_KEY_INITIALIZER(word, bit);
 
@@ -144,7 +144,7 @@ EXPORT_SYMBOL(__wake_up_bit);
  * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
  * because spin_unlock() does not guarantee a memory barrier.
  */
-void wake_up_bit(void *word, int bit)
+void wake_up_bit(unsigned long *word, int bit)
 {
 	__wake_up_bit(bit_waitqueue(word, bit), word, bit);
 }
-- 
2.44.0


