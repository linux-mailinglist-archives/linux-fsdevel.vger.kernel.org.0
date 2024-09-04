Return-Path: <linux-fsdevel+bounces-28548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445E96BBB2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5131FB2B8AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0041D9D65;
	Wed,  4 Sep 2024 12:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBb/PTn3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2tUMTPiB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459E1D86F3;
	Wed,  4 Sep 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451545; cv=none; b=lLismciZ232LaM9LVLXnkWWj7NtWzJmTt4l0plJL9eyY6MbBFKx2QB+dNd4VNkGizpYn2nx1HLID+T1e3lAIL5xS3S7qLX2oDu6CfAFM91/RnMhivk3NfUiyqcBZt8XxQBT9fpjzpSIp5rW8QMI6r43rz+702XFa8bDqFcjsSOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451545; c=relaxed/simple;
	bh=z7t14psmClgJPnrTS3FePajFlnKKHKwtWJNjr7MCP1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gi7cb6iKajuL0d++AhAswROqQoWdJjb2KOe9u/XXHU1t+06m6S6TtA4J2qHfSx2xtKc8hH/tUInQ53J4h2RjqICovi8eS0vB+DUwXS25Nut3kz2pixqpx+PZWLEy/d2e3TW4ddrIxtnZ24JK/t58sQMoj0W+ZJ7FD9SpqpFsWgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBb/PTn3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2tUMTPiB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=cBb/PTn3Z2+LWK06cDOJnlCypIwxHKCE3qE3bZDkeS8rYf2ROmlI7y2Sk+WhVIFTvOyKKE
	yUcEWgWeTVv876Ko6T7+CMxznFhwQiszdjt6V7g52Ny46GEEDk6/3z25GWGrKlSIKsZ0xg
	6GnVMMul3+g8dRkmy8pxSyWmH4HXbk+2EG3D9Grw5azTBVPIhz+7F4HExiCq6qvDDmKVER
	1886Hc3unUpAsRhKooGaoTNplBOX3beLbWVyGcZX/EQJxho0QZ4s1JkFZwIzuYwz8c0vHQ
	jD4CAq/mFiDojsjPhuTcKxibU0+kkuPPhYLa1Fpw3FVgju13Zgvf2ZEcsaG9sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1Oi5xduOOsbRA26g1GCX0jTw6STXCrfhNtn4TB0hdM=;
	b=2tUMTPiBeSE0oAwEfbV7pUbuqboXxvPn/TEQyqzC4tvcEvT1XCtEGvuitW0o7jx8TIluly
	lk9lWbys2UEMjqAg==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v6 12/17] proc: consoles: Add notation to c_start/c_stop
Date: Wed,  4 Sep 2024 14:11:31 +0206
Message-Id: <20240904120536.115780-13-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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


