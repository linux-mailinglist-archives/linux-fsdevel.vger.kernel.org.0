Return-Path: <linux-fsdevel+bounces-27285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F093496006B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F05B1C218D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 04:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01915383F;
	Tue, 27 Aug 2024 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BHB3UogT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YfJpvM+q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C9F13D8A2;
	Tue, 27 Aug 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724733821; cv=none; b=TOubZwGYsW3W2HqLwFFU4PmAiily8Nk5Jw/ArY2v5EXC7jHhZW7L6lbZ9l0EDbm6AsPm/O/E5HbtA4ys+ahRuTkw1V3K88nnLI+gS+gEY4kIdddtlkaVYWvx3Xn3Mu7Pp7DWca8MeP940XuBnSRri+nEUAFdnf2PCXL6MlSpMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724733821; c=relaxed/simple;
	bh=z7t14psmClgJPnrTS3FePajFlnKKHKwtWJNjr7MCP1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CxmqMbn5FitQQBs73deh1JoH+n4LdHEZNOAlhbo+VH5EeVCvb4k/o9ehNL5uFWsDtrsicbtp77x2nIe/czmNQNjNBOtHnoywR6IO/8PAsYwTjR4WDf7QbYXhcYvICHLQ2WyPv6hUOmMYbnYgamcNQZjUtQ4QJqRjpnLUgC6Lt4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BHB3UogT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YfJpvM+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=BHB3UogTvftKlqiCKPrWz/uqzB8i501qPGPrOUCO/KK9FZzSXn/MNpZkRKD3iyRrM7xHvM
	2KTB/PzwAA2Ktocwj11i56wcFFmuaL470kaaPZQO/b7So+4Pr8KzUekWlpR0a7P61j8BjQ
	crhRE9uCrApEPAc0ckbZXQX+2sU5CTcWe1nk2aWVgO44MaXDE67cIPiP8Pp8O2jKZLpiWn
	diu+ITjipAImhAMxdSweN6JSx74njGfNUKm/wKKfia2OS0tzG3S3ioxUBW2ylLUVNZ5H3i
	yDPpdb+cIULtgL83vWDhleU++I6kODJAoR2lfR9sQacT+2GEYx2gSBrbTf1D7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724733818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=YfJpvM+qlaS5nH8RYoGUUKn/HJ9rbTrZQ/42yE25b1FZhcdB9bTplV23zkuZEkrtTdApRY
	rriFHnYCuilDAiBg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v4 12/17] proc: consoles: Add notation to c_start/c_stop
Date: Tue, 27 Aug 2024 06:49:28 +0206
Message-Id: <20240827044333.88596-13-john.ogness@linutronix.de>
In-Reply-To: <20240827044333.88596-1-john.ogness@linutronix.de>
References: <20240827044333.88596-1-john.ogness@linutronix.de>
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


