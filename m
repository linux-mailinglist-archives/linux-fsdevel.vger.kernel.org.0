Return-Path: <linux-fsdevel+bounces-17385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE328ACA86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 12:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CA771C210F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 10:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC713FD71;
	Mon, 22 Apr 2024 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oTHUNRus"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1532713E405;
	Mon, 22 Apr 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713781479; cv=none; b=l0W1sCuxpLHAe/OT7QbJ7KbzytR+7QFEGCegsx37wxDr/0pYqpSc16DiGVDJ07xeqEtY51cDBJZzT6lgL3dUNDGE44lO6BVY/nF5eNqHZcSRfvwT33r6piZ8p5nndTHos1hPPrp53hzvC9Y34CShPybkx7yTOgN6oVPhc9U2WXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713781479; c=relaxed/simple;
	bh=hx1H2/KTWnm+iopGGZ2Sz91oasiY4UwfCIVVPQyi0m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tm9z1tQtdYro4iibKyE4gJbfi1GIYsXABpcEinPTe5MB3dL+HHScbmHwCs1OKIwewWkZe0w30p5+wkU26D6EBXqm1MTKP66+5F967PRmzoq4GDFw9Ex13h5uryGkB9MQOgB6ZHdwMURkHWpfqijsWHs8TqkJrWFTLDgI19JCYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oTHUNRus; arc=none smtp.client-ip=80.12.242.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id yqqPr8npHhQSByqqarJn76; Mon, 22 Apr 2024 12:24:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713781468;
	bh=+5BQBZK9oCOuonQNxMEsho7X/755sEqmuR+eW6M9akU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=oTHUNRusDFEkufBQoPYgUNC7neHCHwCZ10sQf4n3RqgRoXOB2h2yWNjjoyoFWBokz
	 Mw8L58M6MRMpi1t9BctLz8V4aZ3+H6H1dXB2ZtoGOUNDPnqZxWiAqKtSHpn4UjthCi
	 tLQdpLVZgCLERoP/zyEF9pVVlisHrRkT04AcgMUo/Bbu6RF3JkJGeZ6sDhRpR1fCUr
	 vTOm4pwngn55gQLpeEXWBxh3wRAMavBaaC2e1+WN0Lp9ANdrXaDsM8/EBh2Czdy0rE
	 vI6RTYsRf62vbh+HrochU2oFOcn3OgAIT6jbDdKuXQyfdzhirPmMoFrHdDpvoyvTv0
	 m7e0L+xEp/Meg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 22 Apr 2024 12:24:28 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David.Laight@ACULAB.COM,
	rasmus.villemoes@prevas.dk,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] seq_file: Simplify __seq_puts()
Date: Mon, 22 Apr 2024 12:24:07 +0200
Message-ID: <7cebc1412d8d1338a7e52cc9291d00f5368c14e4.1713781332.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr>
References: <a8589bffe4830dafcb9111e22acf06603fea7132.1713781332.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the implementation of the out-of-line __seq_puts() to simply be
a seq_write() call instead of duplicating the overflow/memcpy logic.

Suggested-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Changes in v2:
   - New patch

Now than most (if not all) seq_puts() calls will be turned into a
seq_write() or seq_putc() at compilation time, the added function call in
__seq_puts() should not be noticeable.

It could be even better to just remove this __seq_puts() and call
seq_write(m, s, strlen(s)) directly in seq_puts() if it can't be
optimized at compile time.
---
 fs/seq_file.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/fs/seq_file.c b/fs/seq_file.c
index 8ef0a07033ca..e676c8b0cf5d 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -671,14 +671,7 @@ EXPORT_SYMBOL(seq_putc);
 
 void __seq_puts(struct seq_file *m, const char *s)
 {
-	int len = strlen(s);
-
-	if (m->count + len >= m->size) {
-		seq_set_overflow(m);
-		return;
-	}
-	memcpy(m->buf + m->count, s, len);
-	m->count += len;
+	seq_write(m, s, strlen(s));
 }
 EXPORT_SYMBOL(__seq_puts);
 
-- 
2.44.0


