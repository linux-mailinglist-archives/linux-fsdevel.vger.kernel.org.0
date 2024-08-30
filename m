Return-Path: <linux-fsdevel+bounces-28065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6687966580
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 17:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B5C285EC7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 15:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E63E1BAEDE;
	Fri, 30 Aug 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FchdMTmy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2WSGed7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84611B86D9;
	Fri, 30 Aug 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031770; cv=none; b=Fcl5BAjO1vVhrp57PADeTx+5EhAer6uaiL9w/WEyTykLlRLFeherc9Sc2uIvtT9Uih4b+9dbHQyMMwSvqvVDmgFwMrgFhxBgqWhJU17BzZnz4B9fTpveevZg0PGurWcelwSzzjizevliaKpGDwMwOKm22xtDybrgbKtpoUybNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031770; c=relaxed/simple;
	bh=RuhFMyH0buaWaNTtg4qur9A9+lQbBJQXU2dz3dvH8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMJ9nlvs+emYtyL0dzWzPd8xhWfFOi03xSmE0NGY06IWgVHg7s3u0c1YGkUpOKByP9jGx5oFxtO83E2kUDl+n9l0ItvIQOU1ViOwei6PPc0mCcu6ZLHuB7hqDJeWzWYUcd1aIfZvToEsxGSbHdSmdC1OAfDQRxi+IIA2xkF4Xis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FchdMTmy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2WSGed7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=FchdMTmyntoPE7akPOtsgrfdHuBqrDJVN0oI+pRsJok/wa/pBzXOwGm3B+PC/OACeYjw+U
	f4NBDeH3pXYkZCNjDJWnU1VImFI4OjMrtEE8aMF62I1DeNgt6WtwWiZj3XOt7oJalrLVRM
	UWu9BbWLKeFuL28bjtemoRZlChrDFsHM3UfrQ0HPJ1m+V3IGLKPOYXnXfD+CYcUkzyUJn7
	VJuaegyjVRwobtkyou4Zuy568u+GwLDaQNRrKoEY1eGXiWDl4BXBekDgw2R+8OB3ezQSDt
	0OD3uUq/NlViMbkwe4X5mWyrYgcVeI8yrbom01ZhJ5zy3OcehjhkPkfCyrrY0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725031761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SlCaONAJqxgKpAXbE82io/gLxoDWz0lN5rgg6CE37cM=;
	b=c2WSGed7ScXWBb2EWRODhDJNAc7E/zEgqm/ph1ozdffPcqNpXrD+CovpdM3jjaZWTKTRnN
	NE7961cuiQrnveBA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v5 13/17] proc: Add nbcon support for /proc/consoles
Date: Fri, 30 Aug 2024 17:35:12 +0206
Message-Id: <20240830152916.10136-14-john.ogness@linutronix.de>
In-Reply-To: <20240830152916.10136-1-john.ogness@linutronix.de>
References: <20240830152916.10136-1-john.ogness@linutronix.de>
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


