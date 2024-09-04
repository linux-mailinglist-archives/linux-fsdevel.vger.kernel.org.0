Return-Path: <linux-fsdevel+bounces-28547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D6096BB8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB301C232A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F032D1D7E23;
	Wed,  4 Sep 2024 12:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTuknbrN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ry9ae7zJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2AD1D79AC;
	Wed,  4 Sep 2024 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451540; cv=none; b=ty38PwJUT3hBip8h8aqexdJP3V8fFMGjMS13NUYkNVrO9udLyo9mIAIB/ZiSbch8k9Fo9i3ep1bYYDbs1aWyQ/BkIswZgK8k1EMLQtKGWLj/DveCf3vXf4vf/HnPwRukU8VeFgHI1M5ZJjbgP9obTByogyhTvxnRZeMw330uHB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451540; c=relaxed/simple;
	bh=AluXlLMLUiosq5okUXrQbIUwFREMxfFBRwRD+cg6JNY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UgBu/M/1lOua1vXXvPtxZGqVXuXR12h53E//YUHUTaW4BQvckQxHyBZ8eK3+PrFalQoRHLfr9JPxhQvTJ5DTrdt2OxPdtWDCE6TVSlmSlvjv6jduL5qH/Um9YCZZ9ziJOcGURAJmwyVWp4q7gFLRTmGVs/1V9Rl4VW6ItBu5xyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTuknbrN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ry9ae7zJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Hw9KX0aDsRCvtt79V/opkkqT87C26On3Pt3xup9fqA=;
	b=pTuknbrNwWG8hP66O0ZwPZU0gN+D10ZzumBtgEGDQod+hHJTYtL/UtX5XCxdeQzWGw6NvD
	zeQ8gfk6lrGw+9J3M5O05i2tseQr8TV9TPSMUj6cm4sy7fOMX7FX+JSRdf/pQCOjGgRoIJ
	NQEWMRntCw0KIL1THWS6ANSjoSXq1KE4t/2w4Rs05QSBA/rW/LJZxnzjNClQ6wkbiGb6JA
	mqZYbShDyNJxfsDmPevynORjT5+95Bk6MHEPwch5qWKGZ8kfwMU2SWYhaW9r3Is5hLMRVY
	5Ap/jBkNKgw/HRFvIpazYo2rkhwP/pqWYuuMTjCzoadlWw84agzUmdauG5tNfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Hw9KX0aDsRCvtt79V/opkkqT87C26On3Pt3xup9fqA=;
	b=Ry9ae7zJcnI6y8LJouuKGpar6/93DfW4mXKrj+F7/bVTCDeFNVozryHcJS/7ftm3ylejqg
	yM5im2yzFLsxiwBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH printk v6 00/17] add threaded printing + the rest
Date: Wed,  4 Sep 2024 14:11:19 +0206
Message-Id: <20240904120536.115780-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v6 of a series to implement threaded console printing
as well as some other minor pieces (such as proc and sysfs
recognition of nbcon consoles). v5 is here [0].

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

Here are the changes since v5:

- In nbcon_kthreads_wake(), skip !CON_NBCON consoles.

- In console_flush_all(), also skip nbcon consoles if
  ft.nbcon_atomic == true and improve comments explaining
  why.

- In legacy_kthread_should_wakeup(), also skip nbcon consoles
  if ft.nbcon_atomic == true and improve comments explaining
  why.

John Ogness

[0] https://lore.kernel.org/lkml/20240830152916.10136-1-john.ogness@linutronix.de

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
 kernel/printk/nbcon.c             | 507 +++++++++++++++++++++++++-----
 kernel/printk/printk.c            | 467 ++++++++++++++++++++++++---
 kernel/printk/printk_ringbuffer.h |   2 +
 kernel/printk/printk_safe.c       |   4 +-
 8 files changed, 986 insertions(+), 133 deletions(-)


base-commit: d33d5e683b0d3b4f5fc6a49ce17583f8ca663944
-- 
2.39.2


