Return-Path: <linux-fsdevel+bounces-27286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308196006E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EAAF283395
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7A1154C0A;
	Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q8APdDqs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fj9J9HDK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E58143C72;
	Tue, 27 Aug 2024 04:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733822; cv=none; b=EarNkumpgv746qe34sKlZeNZzXA0hrdPcdbvbUuLYRtg+GviNkd1qXucoaDToQ4371E6/l9wJSpERdyZzONYldV2G3sQ+MPZu7KyGxN7ntfDBdo2cWnhPYoH502TXypE0KkxWdLLyRWOUoL+qUEQmfa/3H6cxeA0icCuTS0ocmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733822; c=relaxed/simple;
	bh=RuhFMyH0buaWaNTtg4qur9A9+lQbBJQXU2dz3dvH8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKNSz2O/WnAg8wnrZ9pmsUQpfLDipoPty3YVU5CBIetr5ZuSP4xjIIlS5xGNgsH7gONJOS7gEAkr8rMx1SwYgsU2mEJB4/HTCWfBoUaz72zkK09EhfFIMXcpAjrkkAbu7Dhm7FPIkSkrVT93nT1BibujSNctiTzaLSq6iGvGND4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q8APdDqs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fj9J9HDK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=Q8APdDqsYwyyTz3NGIPG4KO34QZmED7z2WtSy+9wdgKqZcRaEL4lOdDyBiyovwWorP/oGu
	jbUMTFYG4l5OysJNscTNUpd+qzDbvOlRzCAZmoSSKJdwP8byvEooYsSVIxoa6XDyy29LeE
	CwW4Fw3b+0XqhhD5XSTeuojk6fs8+V+KD1qW1eP/FZEwKGTYpqjISR81Q5Mp4fQH8yT9zF
	eSsDYT65ZDqvsqBoBOOV0yEhT9b8Qva9/rR4YUTZzPj9RASzUrymejfY+09ZUlAu1nkzJn
	E0umIgohdNmhURsB4OCGduMDIsIsItvhZMzGp/Xj349DzMK5DuKTPuJ3jylnow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=fj9J9HDKzzFIOutqa1XueBnfkqeAm/yuaALXi0VXaMdysgQ5p6yeczyohat6aVkMn3PvVO
	uAe07MtNGKTE3mAw==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v4 13/17] proc: Add nbcon support for /proc/consoles
Date: Tue, 27 Aug 2024 06:49:29 +0206
Message-Id: <20240827044333.88596-14-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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
Reviewed-by: Petr Mladek <pmladek@suse.com>
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


