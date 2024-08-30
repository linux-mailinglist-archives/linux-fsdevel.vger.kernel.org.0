Return-Path: <linux-fsdevel+bounces-28064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFA596657C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C06E285CC8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4B21BA87D;
	Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AhPQ4/Yb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bXjWNwX2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A061B81C8;
	Fri, 30 Aug 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031770; cv=none; b=G1fyfgKS8E3LE410sKqoSz5qnfoJJUV5mmDimR+TO7bKtgwsWVOUDI7t43w2WEyFfi4HYebgi+7UU7/i7hi2ixH8x8exI2uYK7fepmwT7NUiN5UJ8RERozd1+rGZAx268erXQqHZy+5+gXZX5HiSw0Of8qaGLm5r3ATIx8pCx4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031770; c=relaxed/simple;
	bh=z7t14psmClgJPnrTS3FePajFlnKKHKwtWJNjr7MCP1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=beLn/asMseaeZYeWuM1aCSFaDSWE5e2n81nZC+j8OXiwcIqDPm+5/OGWngaf6hHH9Y5rrMOlnSl3DK+trMTeboOvId51KOBCwfQmdfFa1sIVMfkXpzlkn1rOexmcyL2kozTfepW/7qtAofFHs+cLTtxZW7J8drzugyKu0W8teEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AhPQ4/Yb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bXjWNwX2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=AhPQ4/YbnRSYX4pxChB3fh7UI8eXL78WxqmtKljMc+kv4/bbX33gtmG2vIasuPf8+x/PGl
	Cb+9D2pG809ZcAuSxEhm4tM90KlakS+IQ5DDBXRBEUJPP83CExlUctayfMxjibudw/aRoy
	V+oVEVfZRex1E4M3GmjsyLnbKKQNykyIfAGdCE7yXdZorQ0QbEY4f0/7xmp8adEjkYxntN
	hrH29QXqTmLaJOyTvhOIKeeLjO1mAn2Tem1nPXYdwYqzR90doRDfs8PXoqPOvqm8tW85Tz
	PHPdATj4tSKNUycP9jgzfP9NhQ7ANLH85UzIfqYHBBgTmg5VQ8ONLwUCJFIbSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=bXjWNwX2LfGnK3EeHs2nLrCjHY04PI6gjMaRBS/hleAuB6BPV//wGEMBaqQAgd2a+pez0O
	GzI546dbUlG/TmAQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v5 12/17] proc: consoles: Add notation to c_start/c_stop
Date: Fri, 30 Aug 2024 17:35:11 +0206
Message-Id: <20240830152916.10136-13-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs/proc/consoles.c:78:13: warning: context imbalance in 'c_start'
	- wrong count at exit
fs/proc/consoles.c:104:13: warning: context imbalance in 'c_stop'
	- unexpected unlock

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 fs/proc/consoles.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/proc/consoles.c b/fs/proc/consoles.c
index e0758fe7936d..7036fdfa0bec 100644
--- a/fs/proc/consoles.c
+++ b/fs/proc/consoles.c
@@ -68,6 +68,7 @@ static int show_console_dev(struct seq_file *m, void *v)
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
+	__acquires(&console_mutex)
 {
 	struct console *con;
 	loff_t off = 0;
@@ -94,6 +95,7 @@ static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 }
 
 static void c_stop(struct seq_file *m, void *v)
+	__releases(&console_mutex)
 {
 	console_list_unlock();
 }
-- 
2.39.2


