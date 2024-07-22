Return-Path: <linux-fsdevel+bounces-24089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB5A93931E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 19:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CBF1F224D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C24217164D;
	Mon, 22 Jul 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3F2w50B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nA7DJV8+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0196116F8F8;
	Mon, 22 Jul 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721668794; cv=none; b=Iu3OtKSCuVdXF1KUG2w0z9+Ed2d1zmFv/y+RRqZKnEDZOBUWUo/fuDsgHyYePUtEmy3+nMJRGlGORQ/o2Hq4AUgPhEvuiS5Gz0xu8NDsv0gwpuwy6MQ7XnRjLWnv3fJYzjnK+LU4+ICJXzB9qbHSp2SEdycMbehbluSy1Z2/5JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721668794; c=relaxed/simple;
	bh=c8qynhdzyIK/U/Ozfr3U3Wi9LTUUnTpnQRxfUcOyN88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oAgxEFI345jDd6j/cfPphuMDzo6dpKjnrturlNTVm91EzUj/3a73mSza+dYTuBDov8TCe4ii2S73izOMD/cmSrvgbgdeMjNAqizHS78W+LCC3i0zG8WVdTLqWrkkBlcJps/BG5N5c4zcEpH+IjcGizE/cgKdWUnsqBQmZHs3qTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3F2w50B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nA7DJV8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=So0AzHFpVy4lGb5Smj06XEnjo7Cib55zsw/bkGnKvh0=;
	b=t3F2w50BDxOJT4XMTwPy6mfz98fT2EhAPOdRbLrYyQiGSwT3aN7VbGlMowgDJAI0sTCQyH
	OAO/MFwgI+0tU3cmOCxb+/hio2GsCHV0lSBa8HMmFQNJ3YV1f5EJU9BcrWGARpQOPMVR6D
	IOVr96hceCB0moS/KrSJb8r+6jkcFJ0mKxTxzZgSERBZFPuG1MTxlRmHtz4bIBg9QzMdc/
	+fWKrE7kU/pPyoGxUzY7wbJHfvfXfmO3wGw4bMw7VtXh/6oqXvXBjm3t7WVQRmvXMqtGRR
	GgS6J/U9gkzX6sizZsKF3FzunYAqkNfzvr3oMDCeK6rJWeoeLWg+HO6PViGhtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721668785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=So0AzHFpVy4lGb5Smj06XEnjo7Cib55zsw/bkGnKvh0=;
	b=nA7DJV8+ncEMoS+2E9sdHMrpJs84fRaXOOaFI2fcdQ06fMejOsqoFdOyjvgS07c4Y6OTAO
	hIwELXssm39yJPBw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v3 15/19] proc: Add nbcon support for /proc/consoles
Date: Mon, 22 Jul 2024 19:25:35 +0206
Message-Id: <20240722171939.3349410-16-john.ogness@linutronix.de>
In-Reply-To: <20240722171939.3349410-1-john.ogness@linutronix.de>
References: <20240722171939.3349410-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update /proc/consoles output to show 'W' if an nbcon console is
registered. Since the write_thread() callback is mandatory, it
enough just to check if it is an nbcon console.

Also update /proc/consoles output to show 'N' if it is an
nbcon console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/proc/consoles.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 7036fdfa0bec..b7cab1ad990d 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,6 +21,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NBCON,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
@@ -58,8 +59,8 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
 	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
-			con->write ? 'W' : '-', con->unblank ? 'U' : '-',
-			flags);
+		   ((con->flags & CON_NBCON) || con->write) ? 'W' : '-',
+		   con->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
 
-- 
2.39.2


