Return-Path: <linux-fsdevel+bounces-27096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F34395E925
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80B331F21A53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F6313B286;
	Mon, 26 Aug 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpGzYT14";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LHg/qG22";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qpGzYT14";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LHg/qG22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8913AD20;
	Mon, 26 Aug 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654276; cv=none; b=j/vNwVcibV64RJv5VVbhK881fP/0U+AdEcDhDPmQ9GN27PxDAkYAldbSzA7FWQ/oC3qTIpdVHlxfaZKpBa7mO4CFleOyP4Y3DRY+ukeOP7APmxaTlfVyM5fJCHb2Px2DtfSCUNWEc4ERkhR+oVi1OzFxy4NRYlHChNtYMAOx+Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654276; c=relaxed/simple;
	bh=FOPU1HH/l0j8p6Wo0j6Drs9hqwTjhvd9gMs7xPvcH+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/QA4ZLs5jRXhgQ4NAsWRQXksg2gzP3e0P7UaylB0/UWqpqkm7xqRgIgHA5jzmSNFQTtEUaNTFkrwjIOo3Wr8dzaeMgzXBmoSF0oTP3wVKPOUkWIVKGc55afksa6PjaDd+ER5JXzB1lP8/CcjrxXRQkbCVNvQ7NJa/rvZt+4dz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpGzYT14; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LHg/qG22; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qpGzYT14; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LHg/qG22; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1ACAA2191F;
	Mon, 26 Aug 2024 06:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zP2lU5ekTkep4e4EmZFqowgaxbTDfBEoEodX4TNVIk=;
	b=qpGzYT14bW7WGlNiLRFlnY/FPHgfzHtopG+hEeJ2baSUWPFjcuG2+dOhQMbz6R6s9bzxDk
	OXDFMTQD62g7kuks+UvDbtKRoh31zIGHXF18BlQZB1YlMuCpuemY6fXR9FqsAPljn7PC/X
	ZvXrzUe3lzwKVL98qQNUaicbC6Uk1lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zP2lU5ekTkep4e4EmZFqowgaxbTDfBEoEodX4TNVIk=;
	b=LHg/qG22PN4DESzHFBUev2oRC+BNPK1DThSzPZA4CWk/ur965Qipf/ykZJpY3hUUuW1iYg
	z3B9WZKwph/VuMAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zP2lU5ekTkep4e4EmZFqowgaxbTDfBEoEodX4TNVIk=;
	b=qpGzYT14bW7WGlNiLRFlnY/FPHgfzHtopG+hEeJ2baSUWPFjcuG2+dOhQMbz6R6s9bzxDk
	OXDFMTQD62g7kuks+UvDbtKRoh31zIGHXF18BlQZB1YlMuCpuemY6fXR9FqsAPljn7PC/X
	ZvXrzUe3lzwKVL98qQNUaicbC6Uk1lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654272;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zP2lU5ekTkep4e4EmZFqowgaxbTDfBEoEodX4TNVIk=;
	b=LHg/qG22PN4DESzHFBUev2oRC+BNPK1DThSzPZA4CWk/ur965Qipf/ykZJpY3hUUuW1iYg
	z3B9WZKwph/VuMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5B7013724;
	Mon, 26 Aug 2024 06:37:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bt/lFr0izGZYOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:49 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/7] sched: Add wait/wake interface for variable updated under a lock.
Date: Mon, 26 Aug 2024 16:31:03 +1000
Message-ID: <20240826063659.15327-7-neilb@suse.de>
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
	BAYES_HAM(-3.00)[99.99%];
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

Sometimes we need to wait for a condition to be true which must be
testing while holding a lock.  Correspondingly the condition is made
true while holing the lock and the wake up is sent under the lock.

This patch provides wake and wait interfaces which can be used for this
situation when the lock is either a mutex or a spinlock.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 69 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index c1675457c077..6995a0d89ebd 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -401,6 +401,75 @@ do {									\
 	__ret;								\
 })
 
+/**
+ * wait_var_event_spinlock - wait for a variable to be updated under a spinlock
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @lock: the spinlock which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a spinlock.  The variables assessed in the condition will normal be updated
+ * under the same spinlock, and the wake up should be signalled with
+ * wake_up_var_locked() under the same spinlock.
+ *
+ * This is similar to wait_var_event(), but assume a spinlock is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given lock is held and the lock will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_spinlock(var, condition, lock)			\
+do {									\
+	might_sleep();							\
+	if (condition)							\
+		break;							\
+	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			  spin_unlock(lock); schedule(); spin_lock(lock)); \
+} while (0)
+
+/**
+ * wait_var_event_mutex - wait for a variable to be updated under a mutex
+ * @var: the address of the variable being waited on
+ * @condition: condition to wait for
+ * @mutex: the mutex which protects updates to the variable
+ *
+ * Wait for a condition which can only be reliably tested while holding
+ * a mutex.  The variables assessed in the condition will normal be
+ * updated under the same mutex, and the wake up should be signalled
+ * with wake_up_var_locked() under the same mutex.
+ *
+ * This is similar to wait_var_event(), but assume a mutex is held
+ * while calling this function and while updating the variable.
+ *
+ * This must be called while the given mutex is held and the mutex will be
+ * dropped when schedule() is called to wait for a wake up, and will be
+ * reclaimed before testing the condition again.
+ */
+#define wait_var_event_mutex(var, condition, mutex)			\
+do {									\
+	might_sleep();							\
+	if (condition)							\
+		break;							\
+	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
+			  mutex_unlock(mutex); schedule(); mutex_lock(mutex)); \
+} while (0)
+
+/**
+ * wake_up_var_locked - wake up waits for a variable while holding a spinlock or mutex
+ * @var: the address of the variable being waited on
+ * @lock: The spinlock or mutex what protects the variable
+ *
+ * Send a wake up for the given variable which should be waited for with
+ * wait_var_event_spinlock() or wait_var_event_mutex().  Unlike wake_up_var(),
+ * no extra barriers are needed as the locking provides sufficient sequencing.
+ */
+#define wake_up_var_locked(var, lock)					\
+do {									\
+	lockdep_assert_held(lock);					\
+	wake_up_var(var);						\
+} while (0)
+
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
  * @bit: the bit of the word being waited on
-- 
2.44.0


