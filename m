Return-Path: <linux-fsdevel+bounces-27284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E819960063
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 939241C21983
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC057BB15;
	Tue, 27 Aug 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zww+1GNW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uGFvzhw6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D4D2556F;
	Tue, 27 Aug 2024 04:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733817; cv=none; b=P4QB4Pn4Gn9EuiETn2asGy1+/HGLnsiIqCL4NzjguDP8y2+ksL4NuOyfw0k3R5mB4wCKc4u2pAVkKNlOD0p+znVGUdunZvQIIxjm6PeK3ZS/QkLt5bHr1Fq5pxwteScyDFjs8rjB/VMLBdz+RvlysA7b8JScmdZtIMRrmjQDF0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733817; c=relaxed/simple;
	bh=iE4oJmx5KMeRGmQOeUnPi42T5gHuozbRW3Nn37jNwCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f/qbeZ1xOVz7IXl5RM+cfMBhxub8tvTEQzW+RA1DdinBYQN303ab3pUD0I/wdnj/t/Jp4pEH4GndLGyzhZJcY8IGj1z51bIGBZPcCOpJCfVhxxsuM3JDY7hYhS4mSeUrvOeA6Ek4XGFyDurInKujt6l6Jwh7nIzvO3T3Sh5XdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zww+1GNW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uGFvzhw6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bEph2JLNkrgzvqkb/rQPwb3piPWDeWtDcD49+gKxbIk=;
	b=Zww+1GNWZCQ2EeVkR+jriujIpYgDUrUBkL5Cu/lJ+oHgiIyO1xPmI3vC+rUAVtZ8OpMYfP
	gdiwGZoSNCKn2yguEDQjT/kc8zgbui3YOPpqURF6p3yOzBRcWHzvZ6yXWuIBDm01zoY6hU
	Vjz19VAOmhjgFqWCkco0lL4iIC8CESpVr+TX60i0tp8TWJntCTecPZJsOiivNvw3GxNBSs
	P8tNxbIKH4kYaWnmzGc5yhuujct661t8hHRuw5DwXUT21GtJJ8SvEHk0TdiwF1bGjJ6zfL
	wFRDtO11tZnmuv7hSkB5hqX3F3kW7FiM9hRPft1VxJcry27bFSXPl04z4b37jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bEph2JLNkrgzvqkb/rQPwb3piPWDeWtDcD49+gKxbIk=;
	b=uGFvzhw6gMsSzKR+ONLNEOSzgEV+Pk/Z2XYt8cGWNFHeHhblfSTrbW7VWKc0nyNv0qbUYm
	nN9xFIqj+0CPLRDg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v4 00/17] add threaded printing + the rest
Date: Tue, 27 Aug 2024 06:49:16 +0206
Message-Id: <20240827044333.88596-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v4 of a series to implement threaded console printing
as well as some other minor pieces (such as proc and sysfs
recognition of nbcon consoles). v3 is here [0].

For information about the motivation of the nbcon consoles,
please read the cover letter of the original v1 [1].

This series provides the remaining pieces of the printk
rework. All other components are either already mainline or are
currently in linux-next. In particular this series does:

- Implement dedicated printing threads per nbcon console.

- Implement forced threading of legacy consoles for PREEMPT_RT.

- Implement nbcon support for proc and sysfs console-related
  files.

- Provide a new helper function nbcon_reacquire_nobuf() to
  allow nbcon console drivers to reacquire ownership.

Note that this series does *not* provide an nbcon console
driver. That will come in a follow-up series.

Here are the changes since v3:

- In nbcon_enter_unsafe()/nbcon_exit_unsafe(), clear the write
  context buffer if ownership was lost.

- In nbcon_emit_next_record(), add a comment that lost
  ownership is detected when entering unsafe.

- For patch 02/17 ("printk: Fail pr_flush() if before
  SYSTEM_SCHEDULING"), update commit message as requested.

- For patch 04/17 ("printk: nbcon: Add context to usable() and
  emit()"), remove redundant error checking from
  nbcon_emit_next_record().

- In nbcon_alloc(), initialize @nbcon_seq to the highest
  possible value to avoid printing until the correct value is
  known.

- In nbcon_emit_next_record(), add a comment reminding that
  write_thread() is mandatory and already checked.

- In nbcon_alloc(), use WARN_ON() instead of a custom error
  message.

- Relocate nbcon_atomic_emit_one() above nbcon_kthread_func()
  so that it can be shared.

- Rename nbcon_wake_kthreads() to nbcon_kthreads_wake().

- Move device_lock()/device_unlock() usage inside
  nbcon_emit_one().

- Use nbcon_emit_one() for nbcon_legacy_emit_next_record() and
  nbcon_kthread_func().

- For patch 08/17 ("printk: nbcon: Use thread callback if in
  task context for legacy"), mention in the commit message
  about consolidating legacy and kthread printing.

- In console_is_usable(), add a comment explaining why
  @printk_kthreads_running is not checked for !use_atomic.

- In nbcon_atomic_flush_pending_con() and
  nbcon_device_release(), check for !ft.nbcon_offload to
  continue flushing.

- In console_start(), find out if it is an nbcon console while
  holding the console_list_lock. This avoids the need to take
  the console_srcu_read_unlock later in the function.

- In is_printk_deferred(), check force_legacy_kthread().

John Ogness

[0] https://lore.kernel.org/lkml/20240722171939.3349410-1-john.ogness@linutronix.de

[1] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (16):
  printk: nbcon: Add function for printers to reacquire ownership
  printk: Fail pr_flush() if before SYSTEM_SCHEDULING
  printk: Flush console on unregister_console()
  printk: nbcon: Add context to usable() and emit()
  printk: nbcon: Init @nbcon_seq to highest possible
  printk: nbcon: Relocate nbcon_atomic_emit_one()
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

 drivers/tty/tty_io.c              |   2 +-
 fs/proc/consoles.c                |   7 +-
 include/linux/console.h           |  48 +++
 kernel/printk/internal.h          |  82 ++++-
 kernel/printk/nbcon.c             | 497 +++++++++++++++++++++++++-----
 kernel/printk/printk.c            | 467 ++++++++++++++++++++++++----
 kernel/printk/printk_ringbuffer.h |   2 +
 kernel/printk/printk_safe.c       |   4 +-
 8 files changed, 976 insertions(+), 133 deletions(-)


base-commit: 59cd94ef80094857f0d0085daa2e32badc4cddf4
-- 
2.39.2


