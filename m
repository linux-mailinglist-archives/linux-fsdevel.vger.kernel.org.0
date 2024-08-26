Return-Path: <linux-fsdevel+bounces-27094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9790F95E91C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 08:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2DA1F21BD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 06:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28312EBE7;
	Mon, 26 Aug 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxyLyDUG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YiQ0NLlK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BxyLyDUG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YiQ0NLlK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2812D1FA;
	Mon, 26 Aug 2024 06:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724654264; cv=none; b=VvZ2tdLeOhF59c7W0zJASbsTlHFAjhDdHfvviBZ/Ce+hlS/YjJcX7hlARTUIodmm64+J2EFWlTUMu/bjzlOer9irqxfnPVybpph5ancavMpIhNVHR490HFhwT6Q1wAGDyKmkYRSgU3bgC8EuILBnVg3wK6rmQEiF0/3OBkMgjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724654264; c=relaxed/simple;
	bh=ke81x9eako5vW+VuRFxe+EXuYh5rkIDZYI5NtrObd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7IdgDGbMOEO4WL7mbaKsS6o/AqESpoP/OAmMMYtnbvGHJNrP0al3scmIaR1ITSRaCb6D5vRu2wax8oWastW6bHpFVSmhECw+noUzJGL4p8YqmdvzMoGZ9D7JRasJ5Y06DrvsiAb77PwLjCHx4rfQv2XOhn95N0wR8R4x5xRLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxyLyDUG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YiQ0NLlK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BxyLyDUG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YiQ0NLlK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 723802191F;
	Mon, 26 Aug 2024 06:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H+YqLG+AMKGCcjtLQ3+u471leznMZwzGQZIx8eoU+Y=;
	b=BxyLyDUGFHtpej19yaKifO4TO8wLR70iqAMrd3XgAShu8jGzDpQ03wXKqLxsJeAj0PVssV
	vI/Vf6jAlp5W0RRa6RCBa2i294CK0cA7F+VrcqTzrAU+MBQt71UD/s/62hTh1Fz2ubVree
	kacpQNOBn6lIjbS9MSTrNtM79cNuur4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H+YqLG+AMKGCcjtLQ3+u471leznMZwzGQZIx8eoU+Y=;
	b=YiQ0NLlKId+1/ZU4PPYnmXZPbETyfpRbbJSXAUZC3kLzwXTH/Pc3MBFbWoqt3FdlsG+xnw
	//Ta0jyWMhAVePDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724654260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H+YqLG+AMKGCcjtLQ3+u471leznMZwzGQZIx8eoU+Y=;
	b=BxyLyDUGFHtpej19yaKifO4TO8wLR70iqAMrd3XgAShu8jGzDpQ03wXKqLxsJeAj0PVssV
	vI/Vf6jAlp5W0RRa6RCBa2i294CK0cA7F+VrcqTzrAU+MBQt71UD/s/62hTh1Fz2ubVree
	kacpQNOBn6lIjbS9MSTrNtM79cNuur4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724654260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2H+YqLG+AMKGCcjtLQ3+u471leznMZwzGQZIx8eoU+Y=;
	b=YiQ0NLlKId+1/ZU4PPYnmXZPbETyfpRbbJSXAUZC3kLzwXTH/Pc3MBFbWoqt3FdlsG+xnw
	//Ta0jyWMhAVePDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BC7C13724;
	Mon, 26 Aug 2024 06:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FfKcLLEizGZHOAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 26 Aug 2024 06:37:37 +0000
From: NeilBrown <neilb@suse.de>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/7] sched: Document wait_var_event() family of functions and wake_up_var()
Date: Mon, 26 Aug 2024 16:31:01 +1000
Message-ID: <20240826063659.15327-5-neilb@suse.de>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

wake_up_var(), wait_var_event() and related interfaces are not
documented but have important ordering requirements.  This patch adds
documentation and makes these requirements explicit.

The return values for those wait_var_event_* functions which return a
value are documented.  Note that these are, perhaps surprisingly,
sometimes different from comparable wait_on_bit() functions.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/wait_bit.h | 71 ++++++++++++++++++++++++++++++++++++++++
 kernel/sched/wait_bit.c  | 30 +++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index b792a92a036e..ca5c6e70f908 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -282,6 +282,22 @@ __out:	__ret;								\
 	___wait_var_event(var, condition, TASK_UNINTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true, only re-checking when a wake up is
+ * received for the given @var (an arbitrary kernel address which need
+ * not be directly related to the given condition, but usually is).
+ *
+ * The process will wait on a waitqueue selected by hash from a shared
+ * pool.  It will only be woken on a wake_up for the given address.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event(var, condition)					\
 do {									\
 	might_sleep();							\
@@ -294,6 +310,24 @@ do {									\
 	___wait_var_event(var, condition, TASK_KILLABLE, 0, 0,		\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a fatal signal to be received,
+ * only re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is
+ * 0 if the condition became true, or %-ERESTARTSYS if a fatal signal
+ * was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_killable(var, condition)				\
 ({									\
 	int __ret = 0;							\
@@ -308,6 +342,26 @@ do {									\
 			  TASK_UNINTERRUPTIBLE, 0, timeout,		\
 			  __ret = schedule_timeout(__ret))
 
+/**
+ * wait_var_event_timeout - wait for a variable to be updated or a timeout to expire
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ * @timeout: maximum time to wait in jiffies
+ *
+ * Wait for a @condition to be true or a timeout to expire, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the timeout expired and the condition was still false, or the
+ * remaining time left in the timeout (but at least 1) if the condition
+ * was found to be true.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_timeout(var, condition, timeout)			\
 ({									\
 	long __ret = timeout;						\
@@ -321,6 +375,23 @@ do {									\
 	___wait_var_event(var, condition, TASK_INTERRUPTIBLE, 0, 0,	\
 			  schedule())
 
+/**
+ * wait_var_event_killable - wait for a variable to be updated and notified
+ * @var: the address of variable being waited on
+ * @condition: the condition to wait for
+ *
+ * Wait for a @condition to be true or a signal to be received, only
+ * re-checking the condition when a wake up is received for the given
+ * @var (an arbitrary kernel address which need not be directly related
+ * to the given condition, but usually is).
+ *
+ * This is similar to wait_var_event() but returns a value which is 0 if
+ * the condition became true, or %-ERESTARTSYS if a signal was received.
+ *
+ * The condition should normally use smp_load_acquire() or a similarly
+ * ordered access to ensure that any changes to memory made before the
+ * condition became true will be visible after the wait completes.
+ */
 #define wait_var_event_interruptible(var, condition)			\
 ({									\
 	int __ret = 0;							\
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 247997e1c9c4..d7ac2ec09f8f 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -199,6 +199,36 @@ void init_wait_var_entry(struct wait_bit_queue_entry *wbq_entry, void *var, int
 }
 EXPORT_SYMBOL(init_wait_var_entry);
 
+/**
+ * wake_up_var - wake up waiters on a variable (kernel address)
+ * @var: the address of the variable being waited on
+ *
+ * Wake up any process waiting in wait_var_event() or similar for the
+ * given variable to change.  wait_var_event() can be waiting for an
+ * arbitrary condition to be true and associates that condition with an
+ * address.  Calling wake_up_var() suggests that the condition has been
+ * made true, but does not strictly require the condtion to use the
+ * address given.
+ *
+ * The wake-up is sent to tasks in a waitqueue selected by hash from a
+ * shared pool.  Only those tasks on that queue which have requested
+ * wake_up on this specific address will be woken.
+ *
+ * In order for this to function properly there must be a full memory
+ * barrier after the variable is updated (or more accurately, after the
+ * condtion waited on has been made to be true) and before this function
+ * is called.  If the variable was updated atomically, such as a by
+ * atomic_dec() then smb_mb__after_atomic() can be used.  If the
+ * variable was updated by a fully ordered operation such as
+ * atomic_dec_and_test() then no extra barrier is required.  Othwewise
+ * smb_mb() is needed.
+ *
+ * Normally the variable should be updated (the condition should be made
+ * to be true) by an operation with RELEASE semantics such as
+ * smp_store_release() so that any changes to memory made before the
+ * variable was update are guaranteed to be visible after the matching
+ * wait_var_event() completes.
+ */
 void wake_up_var(void *var)
 {
 	__wake_up_bit(__var_waitqueue(var), var, -1);
-- 
2.44.0


