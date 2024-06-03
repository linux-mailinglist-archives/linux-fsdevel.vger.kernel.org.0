Return-Path: <linux-fsdevel+bounces-20875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CFD8FA676
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 01:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EAFD281F98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 23:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C8213F432;
	Mon,  3 Jun 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p3b0apQe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+49gCML"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2274013D60F;
	Mon,  3 Jun 2024 23:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717457103; cv=none; b=QPmsv+Vbi/iLM1h646CdbZN9e62WoguK2tR6zFyeKVmb1HPRd4ZRvaKnSjtrh6gkWRQMoSWboiGhvHR0tjCugm0RXKzdYukzlhCEpcITTnbUJGz6hOCkHIflskLnsilSD/eQAPzURdzY0bWE8WVxqe8QqGtwi3YZI/MhjX1YbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717457103; c=relaxed/simple;
	bh=pchBdNX+BmV4rvRNTuOxcexxXxAppL6xw8kp2sflklw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hB3ZWn0hI9MCbYBi6fQXwUPFtWB7jar1RI2Jxf3vx5WTRALop37acmsUMRGkL7+suUhEpcJH3yUJE4iq4cx9jyqvw3oJ3q2gc7RrEz2+WFYxQskfpwqXZzkCZNEydlzCIZYmKFZ/IOIBZT+cI5mM4QQjGhSzjS2ysptDftlJuoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p3b0apQe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+49gCML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zafvitEOgF5mld5sjHSWRZF0NYguns43RcruL3VlP+g=;
	b=p3b0apQet3+byj/c+ay4whwYOricKXpiRJt8AoHBquQEtVv7lnlGii6YVC9+3X3xFPGY+U
	xkXYpnVt6bOIEN9EgkDTB5k785x6l9+L3HrKUK0j00+1AQnRyd8OGLIEzoGqaSu8ekzeSm
	cnCZ+Sc/Y3MhvGc12IRWfnmPXY3rXi/0JMdcxksDht+QLiON0jn0cDSLJ1CUcLUJol3t7f
	6z4kN5sl/GliKR8fpHjCeE/RKe2XEJj0lKGkv1tCPPoK0uIeSNCLG7jAoOnVU5Yrn/Pl+y
	SKhAo3L2/6XmeJqC39yeerAkUjBkHDbr1NSHnibzqQJuM7tnPYZCF7ZP0/GL9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717457099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zafvitEOgF5mld5sjHSWRZF0NYguns43RcruL3VlP+g=;
	b=i+49gCMLWrGQ2olf0QT+rdl1809ipl0Wqh/rhwHcdXXic75ST1Bx25axeY228r7T3a3WGb
	qGRjEMT3CvTm9OCA==
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH printk v2 13/18] proc: consoles: Add notation to c_start/c_stop
Date: Tue,  4 Jun 2024 01:30:48 +0206
Message-Id: <20240603232453.33992-14-john.ogness@linutronix.de>
In-Reply-To: <20240603232453.33992-1-john.ogness@linutronix.de>
References: <20240603232453.33992-1-john.ogness@linutronix.de>
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


