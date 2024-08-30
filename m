Return-Path: <linux-fsdevel+bounces-28063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 525D3966573
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 074901F23C6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86A1B5ED6;
	Fri, 30 Aug 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZ5J/hWe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDjSQVuM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA71B2EC2;
	Fri, 30 Aug 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031766; cv=none; b=abCDhbGHEQJkYEfELBmSE/DSaxLhCWtc3yy2Jd52U0V4GcJqW/jKUhPGXZEHjJ8hWIYcNLoE6XwH7tR2+th4XsBxhG9UhXqv+ObN3OG9TxMtCXgnzuJcGRGjk8tI+nS5tJ4SuntyIy+mvmOYRK+wdgiRbmlGqexiQy0tbug3POw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031766; c=relaxed/simple;
	bh=L65dIVCQsA3YEQ+epYP0GMz7az8+WBN2eBvhQlPRoEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J5685xWVoHowa51dUQ3MKkiSWZG32wtF6e16xc7+lRQy72APk7rcPObxgy77MwZ5UEvj6bzJU6wEf59N013N9CW2ONPNPXvXERDmNDGT9wpvXqEIStF9/10HRFTUhLjDEw0ueVQXK0hE24heiXZ0wzLJteSOVVBH8wZ2aQ/Zllc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZ5J/hWe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDjSQVuM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vR1IcGcO4X3GJ9y3yerSnFs54fwhhftvCVldJT0Dsjg=;
	b=OZ5J/hWeqzI9/J/suXmCtftj2bkJmgZkjDA3MqC//S8rWbw04Gx2hlCGlnowxuAZJKBKDo
	bRfO76Lv/tMjhSmh1Q/UdLTs2lW4DaU2xB0DTpL0bB/FZJoDL/rrrl5xSFiO34cE2xoI4w
	GN/ie92RNdNL/F71FtZjFCaKeU/oTIbSaS/nLqESqFFPX/aj2Bzwspdh+LN77qLrdHD9Zy
	a0HTgs6WAbvvLbvfaPGv6n76Tmu6NHdNLOUx76I9gVozn7tIqVG6yA9hTc92IQJQoqBUm0
	sEoY05zvnfHTJrzwDHuTskm5bInID+bCSmAqxlclwU1PHgV1rhsBtPB8yFPKvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vR1IcGcO4X3GJ9y3yerSnFs54fwhhftvCVldJT0Dsjg=;
	b=GDjSQVuMlXT6r0Miwt04f1N7brPYutKIY9enj6pwc1BrXCPA8i+Wlqi7PAAw5mPpdF/nAM
	KdT7U7BmDx/mhvCw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v5 00/17] add threaded printing + the rest
Date: Fri, 30 Aug 2024 17:34:59 +0206
Message-Id: <20240830152916.10136-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v5 of a series to implement threaded console printing
as well as some other minor pieces (such as proc and sysfs
recognition of nbcon consoles). v4 is here [0].

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

Here are the changes since v4:

- For nbcon_kthread_create(), add more explanations about the
  context and rules to the kerneldoc.

- In nbcon_alloc(), clear con->pbufs on failure.

- Remove legacy_kthread_wake() and add its functionality to
  wake_up_klogd_work_func() since it was the only call site.

- In console_start(), allow triggering the legacy loop if it is
  an nbcon. There might be a registered boot console.

- In __pr_flush(), add atomic flushing before wait loop.

- In console_try_replay_all(), add atomic flushing.

John Ogness

[0] https://lore.kernel.org/lkml/20240827044333.88596-1-john.ogness@linutronix.de

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
 kernel/printk/nbcon.c             | 504 +++++++++++++++++++++++++-----
 kernel/printk/printk.c            | 465 ++++++++++++++++++++++++---
 kernel/printk/printk_ringbuffer.h |   2 +
 kernel/printk/printk_safe.c       |   4 +-
 8 files changed, 981 insertions(+), 133 deletions(-)


base-commit: 59cd94ef80094857f0d0085daa2e32badc4cddf4
-- 
2.39.2


