Return-Path: <linux-fsdevel+bounces-24088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302A6939312
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 19:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A83191F224C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 17:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65AF16EC1C;
	Mon, 22 Jul 2024 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CI1ha6sg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mozUhsV3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E916DEC9;
	Mon, 22 Jul 2024 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668789; cv=none; b=cw1TsvYzkY3nc08l/APhhy2Iee2lLCwmpeAssl+FkBzkIQVmolbUolDp5RRfIRvzNgRzLHPsBaUlOY+6D8Y5ozgIruesbZdQ7T7bnCoI0cZSJHXaBlz9KCGmoTNMJfNyP8tUipuAfDU4ywjPPYc0Kzf25HrUEZQXNBBYjSfCLmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668789; c=relaxed/simple;
	bh=S24rbS1dBhsPsAQ26UaebUrV3Y8oAluEK00ubLfEFAc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ACf2Y6BvdDCz2wBfSNsGUNkid4eRaWLvqVp/FdXDmSiDbzc9SRQocM4QVJX6XAb4pkRL25UIeSeKu2eRY+4saIZX5ZzBTnBrV9zk7zMgbtM50P7bHRHNVo1hGOKUxaymfhYM107rEu3yd9JsS6pfWiY4tn6rTko6a1QU1TnCvdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CI1ha6sg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mozUhsV3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/zuXBjx2k6ssMbDQrerlXcnzbXlUZ31BP+oqNurGDpo=;
	b=CI1ha6sgzLA9v/lPInPoUWs+9Kt93Vrhp33sLH75LxlH9az92Rrw1EqLwoYR1uAgCYeT0q
	ctXuS1TSH5+mrMtbk/OLbd1IXd1XQxYIrfYrL+rieVs53KUc13SH6YvZpyGKgfP25Rn1VA
	kxIl7ypu1x2qLjm/F/TfsWneVkUQq85ebK414rPOsh7JaGVlHXK4/XFJz8ngrr6T9CuquK
	ypXALdGhtgqgN4zHGlcWTPWF7oGeFSk4aRhkEuRd1FdtiqNx0x9nP7c2r/Uc1BXago0hUi
	DlWbiVLJJoZPSA/0rvCL6dQmQSjMjJugwpMOYeDh2KiOkFo42w8lr8N3haSGbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/zuXBjx2k6ssMbDQrerlXcnzbXlUZ31BP+oqNurGDpo=;
	b=mozUhsV3hJPWAgpEE9KsBfbLiSHpbgwG9u1Ugg/tJzdPQBhf71I3eR7rEOEUBqdQmy6pH0
	qQiexVKWPabvrWBQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v3 00/19] add threaded printing + the rest
Date: Mon, 22 Jul 2024 19:25:20 +0206
Message-Id: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v3 of a series to implement threaded console printing as
well as some other minor pieces (such as proc and sysfs support). v2
is here [0].

For information about the motivation of the nbcon consoles, please
read the cover letter of the original v1 [1].

This series provides the remaining pieces of the printk rework. All
other components are either already mainline or are currently in
linux-next. In particular this series does:

- Implement dedicated printing threads per nbcon console.

- Implement forced threading of legacy consoles for PREEMPT_RT.

- Implement nbcon support for proc and sysfs console-related files.

- Provide a new helper function nbcon_reacquire_nobuf() to allow
  nbcon console drivers to reacquire ownership.

Note that this series does *not* provide an nbcon console driver.
That will come in a follow-up series.

Here are the main changes since v2:

- Drop the patch for "threadprintk" boot arg for !PREEMPT_RT.

- Rename variables and functions:

force_printkthreads()		-> force_legacy_kthread()
nbcon_reacquire()		-> nbcon_reacquire_nobuf()
nbcon_wake_threads()		-> nbcon_wake_kthreads()
nbcon_legacy_kthread_func()	-> legacy_kthread_func()
wake_up_legacy_kthread()	-> legacy_kthread_wake()
@printk_threads_enabled		-> @printk_kthreads_running
@nbcon_legacy_kthread		-> @printk_legacy_kthread

- Introduce @printk_kthreads_ready to flag when it is allowed to
  create kthreads.

- Rename lockdep map functions with updated comments to hopefully
  better clarify their purpose.

- The write_thread() callback is now mandatory. write_atomic()
  remains optional. (This also simplifies the changes to
  drivers/tty/tty_io.c and fs/proc/consoles.c.)

- Merge nbcon_init() into nbcon_alloc(). This simplifies the rules
  and more closely resembles the legacy registration.

- Introduce struct console_flush_type to inform which flushing type
  to use.

- Introduce flushing type macro printk_get_console_flush_type() for
  non-emergency CPU states.

- Introduce flushing type macro
  printk_get_emergency_console_flush_type() for emergency CPU
  states.

- Remove @printing_via_unlock macro since there is now the flushing
  type macros.

- Replace _all_ flushing decisions with calls to new flushing type
  macros.

- Introduce helper function nbcon_write_context_set_buf() for
  setting up the write context for nbcon printers.

- In nbcon and legacy kthread functions, do not check for spurious
  signals.

- In nbcon_kthread_func(), check for kthread_should_stop() inside
  the printing loop.

- In nbcon_kthread_func(), add cond_resched() inside the printing
  loop.

- In rcuwait_has_sleeper(), avoid unnecessary RCU dereference.

- In nbcon_wake_kthreads(), do not try to wake if kthreads are not
  fully available.

- In nbcon_legacy_emit_next_record(), split the atomic/thread cases
  before and after printing.

- Use suggested alternative implementation for
  console_prepend_message().

- Move all functions to start/stop kthreads into printk.c.

- Introduce printk_kthreads_check_locked() to start/stop kthreads if
  needed when the console list has changed.

- Unregister nbcon console if the related kthread printer cannot be
  created.

- On failure to start the legacy kthread, unregister all legacy
  consoles.

- If all legacy consoles unregister, stop legacy kthread.

- If all nbcon consoles unregister, clear @nbcon_kthreads_running.

- On shutdown, clear @nbcon_kthreads_running.

- In unregister_console_locked(), flush the console before
  unregistering.

- Let pr_flush() fail if called _very_ early.

- Do not wake nbcon kthreads in printk_trigger_flush().

- In console_try_replay_all(), add support for the legacy kthread.

- Refactor the series to hopefully provide a cleaner transition to
  the final desired stand.

- Split -20 nice for kthreads into a separate patch.

- Rewrite many comments and commit messages as requested.

John Ogness

[0] https://lore.kernel.org/lkml/20240603232453.33992-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (18):
  printk: nbcon: Clarify nbcon_get_default_prio() context
  printk: nbcon: Consolidate alloc() and init()
  printk: nbcon: Add function for printers to reacquire ownership
  printk: nbcon: Clarify rules of the owner/waiter matching
  printk: Fail pr_flush() if before SYSTEM_SCHEDULING
  printk: Flush console on unregister_console()
  printk: Add helpers for flush type logic
  printk: nbcon: Add context to usable() and emit()
  printk: nbcon: Use thread callback if in task context for legacy
  printk: nbcon: Rely on kthreads for normal operation
  printk: Provide helper for message prepending
  printk: nbcon: Show replay message on takeover
  proc: consoles: Add notation to c_start/c_stop
  proc: Add nbcon support for /proc/consoles
  tty: sysfs: Add nbcon support for 'active'
  printk: Implement legacy printer kthread for PREEMPT_RT
  printk: nbcon: Assign nice -20 for printing threads
  printk: Avoid false positive lockdep report for legacy printing

Thomas Gleixner (1):
  printk: nbcon: Introduce printer kthreads

 drivers/tty/tty_io.c     |   2 +-
 fs/proc/consoles.c       |   7 +-
 include/linux/console.h  |  50 +++-
 kernel/printk/internal.h | 159 ++++++++++-
 kernel/printk/nbcon.c    | 530 ++++++++++++++++++++++++++++++-----
 kernel/printk/printk.c   | 588 +++++++++++++++++++++++++++++++--------
 6 files changed, 1137 insertions(+), 199 deletions(-)


base-commit: b18703ea7157f62f02eb0ceb11f6fa0138e90adc
-- 
2.39.2


