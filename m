Return-Path: <linux-fsdevel+bounces-52984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E35BAE91D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F9A77AF3CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15682FA639;
	Wed, 25 Jun 2025 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H/Hr1Is/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30E32F431E;
	Wed, 25 Jun 2025 23:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893197; cv=none; b=D4Hbi6/gZPCRhN+9JuqviKIMIFUl3UntGPihlAh5cGtMThc5D+FuuW/s7QRLo7LB0eUVrB3Xxz0wVz0/jSfJ6k+/jkmS9X/PkYHX4ODHNwkuKHRxkCFFCmNnMMQSI4yn4XMA8/JdWNlLUN2U5D/FVaxc3yJKsZvb01mCJ9dsQLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893197; c=relaxed/simple;
	bh=mwgMJbIMd1cGCE56ZD9loB+RHx1P8Kz4vvhCxEjNYMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVlQK5FGCijh1LwyPf5J7pscg6c+kxopjQ3R8b6GBaKLB6xahaMW+beKAypmjuaHZ28P0Tfi7rTUddp61Z2zZBBL3+5uNlX+o7zvClj2BBxHBRQm4CAMfq+sNH8vjaKUflKaqiTqzB0l0nuw0OeHqbMoT+iY7Q0EYc89kA/I9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H/Hr1Is/; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 94E64C00280D;
	Wed, 25 Jun 2025 16:13:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 94E64C00280D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750893188;
	bh=mwgMJbIMd1cGCE56ZD9loB+RHx1P8Kz4vvhCxEjNYMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H/Hr1Is/YTl+Gjszyje15GJJ65krWUazF6z+3b4W0kxHa5UpZJoBFhttdHtZOOnoC
	 VsU33v4CCkxBdbH1bzQa35+AULxg9vKMM5Yi6K+FQp2qTYnEX4Vsq4lNbVDMmx8puB
	 3/7/p7UaQ7tYgXJ0xih1VhCFtGJZ2OeOwzlI/UVM=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id CE7FC18000853;
	Wed, 25 Jun 2025 16:13:07 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Kieran Bingham <kbingham@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kuan-Ying Lee <kuan-ying.lee@canonical.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Etienne Buira <etienne.buira@free.fr>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Illia Ostapyshyn <illia@yshyn.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-mm@kvack.org (open list:PER-CPU MEMORY ALLOCATOR),
	linux-pm@vger.kernel.org (open list:GENERIC PM DOMAINS),
	kasan-dev@googlegroups.com (open list:KASAN),
	maple-tree@lists.infradead.org (open list:MAPLE TREE),
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT),
	linux-fsdevel@vger.kernel.org (open list:PROC FILESYSTEM)
Subject: [PATCH 05/16] MAINTAINERS: Include interrupts.py under IRQ SUBSYSTEM entry
Date: Wed, 25 Jun 2025 16:10:42 -0700
Message-ID: <20250625231053.1134589-6-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
References: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the GDB scripts file under scripts/gdb/linux/interrupts.py under
the IRQ SUBSYSTEM entry since it parses internal data structures that
depend upon that subsystem.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfb0d60ef069..e1eda0d9d671 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12803,6 +12803,7 @@ F:	include/linux/irqnr.h
 F:	include/linux/irqreturn.h
 F:	kernel/irq/
 F:	lib/group_cpus.c
+F:	scripts/gdb/linux/interrupts.py
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
2.43.0


