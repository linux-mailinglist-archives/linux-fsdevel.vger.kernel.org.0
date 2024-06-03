Return-Path: <linux-fsdevel+bounces-20873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC538FA666
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 01:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94CE91C21A66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 23:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78DD13D28B;
	Mon,  3 Jun 2024 23:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nkm/6N/z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/EjlJVvg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A00983CD8;
	Mon,  3 Jun 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457098; cv=none; b=ZUu9dx42BmMJO99SUzrYEf3gcazN0sx/7VxXs+Vig3gCZ+8j2PI/kFUmS3krP5Kflb9iokX8eHK/CF8W14q99phCPx7bAuiG3QeYzPpoY3uDJ4dWP2oF526Kd2Fgufl4IRdjCFKe776+o9OAKSg96Sa6QV8upVuedeMy0jQ6rLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457098; c=relaxed/simple;
	bh=xEijcAO2AhGEVfNLJuthJe2r8sxc48zcP+LRMU6em88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GJqWrzhDHA4rB1iRcQojPTF6mkIba633EOPnrq5WcE1x1po94bRUS9qJ6/CAH2JVcfAloJmd7Uhgcw4jtU4/7YvusDZ7kNxtlutXP/Z+EQOM4I5Xci9vd0/lfQAwPTlkbfcfEbskQ4tuQt8g+KXfSwbZEbNg/UEJ7YLgqVdtUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nkm/6N/z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/EjlJVvg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LeID2lqZO2NfvUDbTydXHW7F5KBd3prAyYph5If2D2k=;
	b=nkm/6N/zwJHmyPt6qIc5rDHq38x2vgLf4FBqzcs5Od8hS7gRsAorY6cIRVEWI7iuLRMfqm
	n1XN2ogwQ+5Pr3NcoqsHiJcLGNGWiFjTO6sbTnmf5rPIuno98QCV3ytdXHJOJ9u7x4coQl
	wmzsAf7n7DiVN27PNt24lJBOb8kJTtj7wQaE+XMXMMUza4irxMjbC5Cz2JvrMBLlav2Qno
	ALabOpQCHumIWbhN+70/fDh8VO3TVyuJu9Q7Hh7rt399lAQXFB6WKfUCp4XPeUJ2YwIQ2A
	amMVUigMEf6GH5PQJE01w73Fa/11KSthkG86fNkpNldw8dEfdPcXE+fxVsCGjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LeID2lqZO2NfvUDbTydXHW7F5KBd3prAyYph5If2D2k=;
	b=/EjlJVvgqFM8pAjjycMP/r4jHdn7kuIzmk8rkU2X/AM16jN+Sz775gDOBWcLZxA/CTkBUd
	90+xxfvxfd54iwAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sreenath Vijayan <sreenath.vijayan@sony.com>,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>,
	Tomas Mudrunka <tomas.mudrunka@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Xiongwei Song <xiongwei.song@windriver.com>
Subject: [PATCH printk v2 00/18] add threaded printing + the rest
Date: Tue,  4 Jun 2024 01:30:35 +0206
Message-Id: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of a series to implement threaded console printing as well
as some other minor pieces (such as proc and sysfs support). This
series is only a subset of the original v1 [0]. In particular, this
series represents patches 11, 12, 15 of the v1 series. For information
about the motivation of the nbcon consoles, please read the cover
letter of v1.

This series provides the remaining pieces of the printk rework. All
other components are either already mainline or are currently in
linux-next. In particular this series does:

- Implement dedicated printing threads per nbcon console.

- Implement "threadprintk" boot argument to force threading of legacy
  consoles.

- Implement nbcon support for proc and sysfs console-related files.

- Provide a new helper function nbcon_reacquire() to allow nbcon
  console drivers to reacquire ownership.

Note that this series does *not* provide an nbcon console driver. That
will come in a follow-up series.

Also note that the first 3 patches of the series are either already
mainline or are queued for 6.11. They are included in this series for
completeness when applied to the printk for-next branch.

Much has changed since v1 and the patches no longer correlate
1:1. Here is an attempt to list the changes:

- Implement a special dedicated thread to force threading of legacy
  console drivers.

- Add "threadprintk" boot argument to force threading of legacy
  console drivers. (For PREEMPT_RT, this is automatically enabled.)

- Add sparse notation for console_srcu_read_lock/unlock().

- Define a dedicated wait queue for the legacy thread.

- Stop threads on shutdown/reboot for a clean transition to atomic
  printing.

- Print a replay message when a higher priority printer context takes
  over another printer context.

- Reset lockdep context for legacy printing on !PREEMPT_RT to avoid
  false positive lockdep splats.

- Use write_thread() callback if printing from console_flush_all() and
  @do_cond_resched is 1.

- Do not allocate separate pbufs for printing threads. Use the same
  pbufs that the atomic printer uses.

- Wake printing threads without considering nbcon lock state.

- Implement rcuwait_has_sleeper() to check for waiting tasks instead
  of using a custom atomic variable @kthread_waiting.

John Ogness

[0] https://lore.kernel.org/lkml/20230302195618.156940-1-john.ogness@linutronix.de

John Ogness (13):
  printk: Atomic print in printk context on shutdown
  printk: nbcon: Add context to console_is_usable()
  printk: nbcon: Stop threads on shutdown/reboot
  printk: nbcon: Start printing threads
  printk: Provide helper for message prepending
  printk: nbcon: Show replay message on takeover
  printk: Add kthread for all legacy consoles
  proc: consoles: Add notation to c_start/c_stop
  proc: Add nbcon support for /proc/consoles
  tty: sysfs: Add nbcon support for 'active'
  printk: Provide threadprintk boot argument
  printk: Avoid false positive lockdep report for legacy printing
  printk: nbcon: Add function for printers to reacquire ownership

Sreenath Vijayan (3):
  printk: Add function to replay kernel log on consoles
  tty/sysrq: Replay kernel log messages on consoles via sysrq
  printk: Rename console_replay_all() and update context

Thomas Gleixner (2):
  printk: nbcon: Introduce printing kthreads
  printk: nbcon: Add printer thread wakeups

 .../admin-guide/kernel-parameters.txt         |  12 +
 Documentation/admin-guide/sysrq.rst           |   9 +
 drivers/tty/sysrq.c                           |  13 +-
 drivers/tty/tty_io.c                          |   9 +-
 fs/proc/consoles.c                            |  16 +-
 include/linux/console.h                       |  38 ++
 include/linux/printk.h                        |   6 +-
 kernel/printk/internal.h                      |  55 +-
 kernel/printk/nbcon.c                         | 421 ++++++++++++++-
 kernel/printk/printk.c                        | 482 +++++++++++++++---
 10 files changed, 945 insertions(+), 116 deletions(-)


base-commit: f3760c80d06a838495185c0fe341c043e6495142
-- 
2.39.2


