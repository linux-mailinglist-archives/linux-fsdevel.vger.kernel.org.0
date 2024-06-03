Return-Path: <linux-fsdevel+bounces-20874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F18FA674
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 01:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2472895FD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 23:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A18213E888;
	Mon,  3 Jun 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Knm8ZSQX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O1KZyvD1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74513D62C;
	Mon,  3 Jun 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457103; cv=none; b=LG0fAq/r+s9zvHZWDiHYccjE+zuDbNyDMYifxcoY6qgqiIG4FRUGKTYcH2DWunmC7eZpFWzTekpMU2XYOrrKKBEfp0QKrPAh1ZMWncgvt6MYLs3zPiYX8CQz7aU8Hh7Gz2Pi0O8hbgP7oi16AkBhWlzXwXdGiwgQuvhfuMgLRok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457103; c=relaxed/simple;
	bh=y/8/D5lsvEkXT9odzpG9/skVj8B2WhjdY/3Pwb613Oc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dtPXxs2gO/e48Bt2VwFaUllGqwW/nhqV0WNkxGNqOWQc1rLXz/G15TC6q/3LrGaFMp+ji6pT5/mEWATLls9aWIQ2Oc2uch9K75yZ172+3FUB+huCAPp/jDJIXgteU/wGt8YySR+t6xnBGa7aq0oFcbLEA7lwXSxQIgJtNXaxeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Knm8ZSQX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O1KZyvD1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IscutLuG042H8NAY0r6UeOoPwuGyiJXascNGHAe7SFU=;
	b=Knm8ZSQXG50rKc0ym0n8q5eWNbowd5+U6leS1YNRc3IcWa9at7lDz4Ebe34xrKgAkdpuhO
	psPTIMCbufR+xCayk5DgtYqDGIPGV/jJ/uBJH1eL5qL87Uu+ExU9Eae0cvSlK1PI1/xLId
	MKloKy2XIs+hrq9O7BYj+AmeeoUt0Ugps1L0yvtW/V7qAksEsoVt19a/TFNmao+4awW6jI
	Yz4I3V+CQv+WVD8HyAwq6sxX74iT/mgAHsidlhZAcs9ngo0k5HO0gomDOBLLsEUK8ke6EV
	+6aSusu4JiFjR166/LKiQSltT7UynuvsfIRA/LeOBsast3o1KuAaA9KnNFTQ1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IscutLuG042H8NAY0r6UeOoPwuGyiJXascNGHAe7SFU=;
	b=O1KZyvD1W3n12Nu49nRKux3bZH/acg+7k9G3b8E8sGV3aVZ4J/lXjB3lfJxyvKSORASpO+
	m6L+kP00tRrCGHAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v2 14/18] proc: Add nbcon support for /proc/consoles
Date: Tue,  4 Jun 2024 01:30:49 +0206
Message-Id: <20240603232453.33992-15-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update /proc/consoles output to show 'W' if an nbcon write
callback is implemented (write_atomic or write_thread).

Also update /proc/consoles output to show 'N' if it is an
nbcon console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 fs/proc/consoles.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index 7036fdfa0bec..c3c01ec2273c 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -21,12 +21,14 @@ static int show_console_dev(struct seq_file *m, void *v)
 		{ CON_ENABLED,		'E' },
 		{ CON_CONSDEV,		'C' },
 		{ CON_BOOT,		'B' },
+		{ CON_NBCON,		'N' },
 		{ CON_PRINTBUFFER,	'p' },
 		{ CON_BRL,		'b' },
 		{ CON_ANYTIME,		'a' },
 	};
 	char flags[ARRAY_SIZE(con_flags) + 1];
 	struct console *con = v;
+	char con_write = '-';
 	unsigned int a;
 	dev_t dev = 0;
 
@@ -57,9 +59,15 @@ static int show_console_dev(struct seq_file *m, void *v)
 	seq_setwidth(m, 21 - 1);
 	seq_printf(m, "%s%d", con->name, con->index);
 	seq_pad(m, ' ');
-	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-',
-			con->write ? 'W' : '-', con->unblank ? 'U' : '-',
-			flags);
+	if (con->flags & CON_NBCON) {
+		if (con->write_atomic || con->write_thread)
+			con_write = 'W';
+	} else {
+		if (con->write)
+			con_write = 'W';
+	}
+	seq_printf(m, "%c%c%c (%s)", con->read ? 'R' : '-', con_write,
+		   con->unblank ? 'U' : '-', flags);
 	if (dev)
 		seq_printf(m, " %4d:%d", MAJOR(dev), MINOR(dev));
 
-- 
2.39.2


