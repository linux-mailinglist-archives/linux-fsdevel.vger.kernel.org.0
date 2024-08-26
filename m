Return-Path: <linux-fsdevel+bounces-27093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44695E919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E653281B9B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CFC12C81F;
	Mon, 26 Aug 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAf0dvnq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYIkUSL8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XAf0dvnq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IYIkUSL8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0C1127B57;
	Mon, 26 Aug 2024 06:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654258; cv=none; b=mnEmNdjt09qodlUjCbzel4YNpq9iy97jnhNqXmrk2Tc3kaYDviNyW03Wi/ulPebUJw/hrhXQkmJexQ/u4dU3DEcVUBa/yQZY9aMiXwK4x0R2dAcsYlnP+o9eviVVGEGFjzebOLaugvqrzPVm1L8e7ZRWn1idSndiEZcxkhDzjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654258; c=relaxed/simple;
	bh=tqIW5ADrxqpprsFVkY4P7BaM5PA32jHUVg6V7x/C0sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dfc9eJPIqyD19b6mRWQ0OxYHgjssbyevWG61BNJlL/Vk3lpxnX7a5TDVtSCMrGx5tnup0IK5gGx/oGN7IGH/HBg41ISWgYkdi/aSu2anZZ2lDyaHLNhADpf2vLYd9CdiG0HeeMYhMrEOa2fCbGAyZTqViGs2PMpaxOXerHbPYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAf0dvnq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYIkUSL8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XAf0dvnq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IYIkUSL8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B30D1F83B;
	Mon, 26 Aug 2024 06:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYvuABek3Hw1EehHXYAISUiDFC3hNIfdi0ZgD0cyZSo=;
	b=XAf0dvnqWsbdNw6yQ9fxEyB/MiRfJuGrNXJsMZqG7bc/440LDw1UyJwwv0ZhiaV0CVexz4
	GkAZAtPNtjzxekYM/Ob54wzUBDOExFnQczYT8zGZqVPRSLdj+C4w/zZXjKJQhWSFhvlHz0
	OzHZSBGcCqOQg5zhx9sdJ9v2Sde1we4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYvuABek3Hw1EehHXYAISUiDFC3hNIfdi0ZgD0cyZSo=;
	b=IYIkUSL8GMdEDsuk/+W/JDeuqvdfwlLUaWq6s6hpCFTWxVhoiz0X5+2KpKZ1KGC2FxrNiR
	XrIey972DLCVE+Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654254; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYvuABek3Hw1EehHXYAISUiDFC3hNIfdi0ZgD0cyZSo=;
	b=XAf0dvnqWsbdNw6yQ9fxEyB/MiRfJuGrNXJsMZqG7bc/440LDw1UyJwwv0ZhiaV0CVexz4
	GkAZAtPNtjzxekYM/Ob54wzUBDOExFnQczYT8zGZqVPRSLdj+C4w/zZXjKJQhWSFhvlHz0
	OzHZSBGcCqOQg5zhx9sdJ9v2Sde1we4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654254;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYvuABek3Hw1EehHXYAISUiDFC3hNIfdi0ZgD0cyZSo=;
	b=IYIkUSL8GMdEDsuk/+W/JDeuqvdfwlLUaWq6s6hpCFTWxVhoiz0X5+2KpKZ1KGC2FxrNiR
	XrIey972DLCVE+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2EDE13724;
	Mon, 26 Aug 2024 06:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6wyeJasizGY2OAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:31 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] sched: Improve documentation for wake_up_bit/wait_on_bit family of functions
Date: Mon, 26 Aug 2024 16:31:00 +1000
Message-ID: <20240826063659.15327-4-neilb@suse.de>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO

This patch revises the documention for wake_up_bit(),
clear_and_wake_up_bit(), and all the wait_on_bit() family of functions.

The new documentation places less emphasis on the pool of waitqueues
used (an implementation details) and focuses instead on details of how
the functions behave.

The barriers included in the wait functions and clear_and_wake_up_bit()
and those required for wake_up_bit() are spelled out more clearly.

The error statuses returned are given explicitly.

The fact that the wait_on_bit_lock function set the bit is made more
obvious.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 159 +++++++++++++++++++++------------------
 kernel/sched/wait_bit.c  |  37 +++++----
 2 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 48e123839892..b792a92a036e 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -53,19 +53,21 @@ extern int bit_wait_io_timeout(struct wait_bit_key *key, int mode);
 
 /**
  * wait_on_bit - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit.
- * For instance, if one were to have waiters on a bitflag, one would
- * call wait_on_bit() in threads waiting for the bit to clear.
- * One uses wait_on_bit() where one is waiting for the bit to clear,
- * but has no intention of setting it.
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the target bit, even
+ * if other processed on the same queue are woken for other bits.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit(unsigned long *word, int bit, unsigned mode)
@@ -80,17 +82,20 @@ wait_on_bit(unsigned long *word, int bit, unsigned mode)
 
 /**
  * wait_on_bit_io - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared.  This is similar to wait_on_bit(), but calls
- * io_schedule() instead of schedule() for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls io_schedule() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
@@ -104,19 +109,24 @@ wait_on_bit_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_timeout - wait for a bit to be cleared or a timeout elapses
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_timeout - wait for a bit to be cleared or a timeout to elapse
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  * @mode: the task state to sleep in
  * @timeout: timeout, in jiffies
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared. This is similar to wait_on_bit(), except also takes a
- * timeout parameter.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared, or for a timeout to expire.  The
+ * clearing of the bit must be signalled with wake_up_bit(), often as
+ * clear_and_wake_up_bit().
  *
- * Returned value will be zero if the bit was cleared before the
- * @timeout elapsed, or non-zero if the @timeout elapsed or process
- * received a signal and the mode permitted wakeup on that signal.
+ * This is similar to wait_on_bit(), except it also takes a timeout
+ * parameter.
+ *
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or %-EINTR if the process received a
+ * signal and the mode permitted wake up on that signal, or %-EAGAIN if the
+ * timeout elapsed.
  */
 static inline int
 wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
@@ -132,19 +142,21 @@ wait_on_bit_timeout(unsigned long *word, int bit, unsigned mode,
 
 /**
  * wait_on_bit_action - wait for a bit to be cleared
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * @word: the address containing the bit waited on
+ * @bit: the bit at that address being waited on
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared, and allow the waiting action to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * Wait for the given bit in an unsigned long or bitmap (see DECLARE_BITMAP())
+ * to be cleared.  The clearing of the bit must be signalled with
+ * wake_up_bit(), often as clear_and_wake_up_bit().
+ *
+ * This is similar to wait_on_bit(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returned value will be zero if the bit was cleared, or non-zero
- * if the process received a signal and the mode permitted wakeup
- * on that signal.
+ * Returned value will be zero if the bit was cleared in which case the
+ * call has ACQUIRE semantics, or the error code returned by @action if
+ * that call returned non-zero.
  */
 static inline int
 wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -157,23 +169,22 @@ wait_on_bit_action(unsigned long *word, int bit, wait_bit_action_f *action,
 }
 
 /**
- * wait_on_bit_lock - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hashtable's accessor API that waits on a bit
- * when one intends to set it, for instance, trying to lock bitflags.
- * For instance, if one were to have waiters trying to set bitflag
- * and waiting for it to clear before setting it, one would call
- * wait_on_bit() in threads waiting to be able to set the bit.
- * One uses wait_on_bit_lock() where one is waiting for the bit to
- * clear with the intention of setting it, and when done, clearing it.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * This is similar to wait_on_bit(), but sets the bit before returning.
+ *
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or %-EINTR if the process received a signal and
+ * the mode permitted wake up on that signal.
  */
 static inline int
 wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
@@ -185,15 +196,18 @@ wait_on_bit_lock(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_io - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_io - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to atomically set it.  This is similar
- * to wait_on_bit(), but calls io_schedule() instead of schedule()
- * for the actual waiting.
+ * Wait for the given bit in an unsigned long or bitmap (see
+ * DECLARE_BITMAP()) to be cleared.  The clearing of the bit must be
+ * signalled with wake_up_bit(), often as clear_and_wake_up_bit().  As
+ * soon as it is clear, atomically set it and return.
+ *
+ * This is similar to wait_on_bit_lock(), but calls io_schedule() instead
+ * of schedule().
  *
  * Returns zero if the bit was (eventually) found to be clear and was
  * set.  Returns non-zero if a signal was delivered to the process and
@@ -209,21 +223,19 @@ wait_on_bit_lock_io(unsigned long *word, int bit, unsigned mode)
 }
 
 /**
- * wait_on_bit_lock_action - wait for a bit to be cleared, when wanting to set it
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wait_on_bit_lock_action - wait for a bit to be cleared, then set it
+ * @word: the address containing the bit being waited on
+ * @bit: the bit of the word being waited on and set
  * @action: the function used to sleep, which may take special actions
  * @mode: the task state to sleep in
  *
- * Use the standard hashed waitqueue table to wait for a bit
- * to be cleared and then to set it, and allow the waiting action
- * to be specified.
- * This is like wait_on_bit() but allows fine control of how the waiting
- * is done.
+ * This is similar to wait_on_bit_lock(), but calls @action() instead of
+ * schedule() for the actual waiting.
  *
- * Returns zero if the bit was (eventually) found to be clear and was
- * set.  Returns non-zero if a signal was delivered to the process and
- * the @mode allows that signal to wake the process.
+ * Returned value will be zero if the bit was successfully set in which
+ * case the call has the same memory sequencing semantics as
+ * test_and_clear_bit(), or the error code returned by @action if that
+ * call returned non-zero.
  */
 static inline int
 wait_on_bit_lock_action(unsigned long *word, int bit, wait_bit_action_f *action,
@@ -320,12 +332,13 @@ do {									\
 
 /**
  * clear_and_wake_up_bit - clear a bit and wake up anyone waiting on that bit
- *
  * @bit: the bit of the word being waited on
- * @word: the word being waited on, a kernel virtual address
+ * @word: the address containing the bit being waited on
  *
- * You can use this helper if bitflags are manipulated atomically rather than
- * non-atomically under a lock.
+ * The designated bit is cleared and any tasks waiting in wait_on_bit()
+ * or similar will be woken.  This call has RELEASE semantics so that
+ * any changes to memory made before this call are guaranteed to be visible
+ * after the corresponding wait_on_bit() completes.
  */
 static inline void clear_and_wake_up_bit(int bit, unsigned long *word)
 {
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 058b0e18727e..247997e1c9c4 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -128,21 +128,32 @@ void __wake_up_bit(struct wait_queue_head *wq_head, unsigned long *word, int bit
 EXPORT_SYMBOL(__wake_up_bit);
 
 /**
- * wake_up_bit - wake up a waiter on a bit
- * @word: the word being waited on, a kernel virtual address
- * @bit: the bit of the word being waited on
+ * wake_up_bit - wake up waiters on a bit
+ * @word: the address containing the bit being waited on
+ * @bit: the bit at that address being waited on
  *
- * There is a standard hashed waitqueue table for generic use. This
- * is the part of the hash-table's accessor API that wakes up waiters
- * on a bit. For instance, if one were to have waiters on a bitflag,
- * one would call wake_up_bit() after clearing the bit.
+ * Wake up any process waiting in wait_on_bit() or similar for the
+ * given bit to be cleared.
  *
- * In order for this to function properly, as it uses waitqueue_active()
- * internally, some kind of memory barrier must be done prior to calling
- * this. Typically, this will be smp_mb__after_atomic(), but in some
- * cases where bitflags are manipulated non-atomically under a lock, one
- * may need to use a less regular barrier, such fs/inode.c's smp_mb(),
- * because spin_unlock() does not guarantee a memory barrier.
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address and bit will be woken, and only if the
+ * bit is clear.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the bit is cleared and before this function is called.
+ * If the bit was cleared atomically, such as a by clear_bit() then
+ * smb_mb__after_atomic() can be used, othwewise smb_mb() is needed.
+ *
+ * If, however, the wait_on_bit is performed under a lock, such as with
+ * wait_on_bit_action() where the action drops and reclaims the lock
+ * around schedule(), and if this wake_up_bit() call happens under the
+ * same lock, then no barrier is required.
+ *
+ * Normally the bit should be cleared by an operation with RELEASE
+ * semantics so that any changes to memory made before the bit is
+ * cleared are guaranteed to be visible after the matching wait_on_bit()
+ * completes.
  */
 void wake_up_bit(unsigned long *word, int bit)
 {
-- 
2.44.0


