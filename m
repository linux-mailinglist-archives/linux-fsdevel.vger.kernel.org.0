Return-Path: <linux-fsdevel+bounces-28549-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AE996BBA3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33523B20AE0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CF31D9D6D;
	Wed,  4 Sep 2024 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="puXW/aJj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fr0Hu5fD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107D1D88B1;
	Wed,  4 Sep 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451545; cv=none; b=m6ixx33Jo+0AAGJUXOFkM7wkzy1VLZ5Xv/0vvBJY3zCHyGOjnLwFTnMSkhQelp+uHwXTMfXIHKcOJ+o38YNW1SsbQi2U/4EQn4YVvbisV6D0duqnSGeoMDRCRdy10var7uv/r+ymYgK1bYppeo4+8HXiONZsYxvmm9iUqHNGtM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451545; c=relaxed/simple;
	bh=RuhFMyH0buaWaNTtg4qur9A9+lQbBJQXU2dz3dvH8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzx+1pfoRmDJ73T9q5gUQtEvx+DZRHZFVm31b1YnKBIak/vDnQuD4byEdJl6LLlUUKutYHTxgfuG8H/oHkQRpwgob16nRty5+Y2Ad3VCtgyXghQUBB7dv3RqmSrvBbE239nJQ41Mn5ULFxaldxU7eezWUEnvKEaJcdGd7ld9Rrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=puXW/aJj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fr0Hu5fD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725451541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=puXW/aJjvKQzJz4B+AhMOEu3xwNnuLX+i4E9FhjF5YaQMz/klqdle61r27LKbzt19t2isA
	N4hMFxZfAxt6bf4GT0yxxnc3HAMzgEO4Y2NAiqB6IFkO+2Cpvs54FxdyrJZxfTAIlJWv/M
	NCKe74h6D6oRqy8KgVMpjfc4WH/bz1ribycT3c5dqkdzEqgswOXxymFQBIyBoV8TRe0vjz
	HsOe7A0vVC8nOesVYIFrCGNpyOK0Ur088eHlGRzr9tN1CF2Xl/W+3ZXhJDKiOgooqq2m5S
	QzHcKmo9LEVBNUUEomnNkSE2ARdUW/wQWNgrDAdBq2npH9qZuwzR6Ok4Z3+4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725451541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=Fr0Hu5fDe+isW5N7CbZuRbpWFte7IqWoF68DG9ZwJg4b4jCbeqZTNETmcMcE7GIm6Z/s4B
	MZ8Su6RioGS44qDQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v6 13/17] proc: Add nbcon support for /proc/consoles
Date: Wed,  4 Sep 2024 14:11:32 +0206
Message-Id: <20240904120536.115780-14-john.ogness@linutronix.de>
In-Reply-To: <20240904120536.115780-1-john.ogness@linutronix.de>
References: <20240904120536.115780-1-john.ogness@linutronix.de>
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


