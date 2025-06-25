Return-Path: <linux-fsdevel+bounces-52993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78078AE91F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119BC6A3AE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7232FE32A;
	Wed, 25 Jun 2025 23:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PWBNHzoA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C272FC007;
	Wed, 25 Jun 2025 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893200; cv=none; b=s1lRFCyK0wtktPDLrl9fdwae9T8+GMhUvxCqGGjX1t/wGeixrEllOow8fUhai0yAJARpgex2fFmTdDfCH8vRoqFOVRFl4qFTOlBUgLzwB6+iSOgaOVmIkNhnGZZc5X21vfs+Y+8Mmpm0Uq/qkp/z+lXR6EV4BsNfPlWngq7ziQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893200; c=relaxed/simple;
	bh=XJoC/bt6+FtN6jqC6QYxmy2PNMGvL/1LKD50rxTxXms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7R8p/VFGNf4YOiB4z41KUpXsC0aZt/GHscPXs0FKUPAhV1d0Pd4NqpficVWwngD8tz7TERsIeWfxQvOgkfSX/a5ivi0SUFlhJu2KZ5ZpZDc8t2+AazSsMSOfdewCLmN6N96iu0k1vl9RA3caFBK3cels9MBKkU7j1gQ7KfHexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PWBNHzoA; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2953BC002828;
	Wed, 25 Jun 2025 16:13:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2953BC002828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750893191;
	bh=XJoC/bt6+FtN6jqC6QYxmy2PNMGvL/1LKD50rxTxXms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PWBNHzoAGs/yb7c+ibxdzX0yfVSNfJ37+iCMXSuNQUO30e7GboUeun+O4Swj/52Oc
	 cYI06Fbt/c7I8ejMdZTqPRYULqFBiyymvCQg3JuQ5GgeomwAKqnP04UTRnbOF3MRBS
	 YHRvnCEFEgSbcPcBiSiJQm+c4vHsn9olmZFyQ+yE=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 8FC3318000530;
	Wed, 25 Jun 2025 16:13:10 -0700 (PDT)
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
Subject: [PATCH 10/16] MAINTAINERS: Include cpus.py under PER-CPU MEMORY ALLOCATOR entry
Date: Wed, 25 Jun 2025 16:10:47 -0700
Message-ID: <20250625231053.1134589-11-florian.fainelli@broadcom.com>
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

Include the GDB scripts file under scripts/gdb/linux/cpus.py under the
PER-CPU MEMORY ALLOCATOR subsystem since it parses internal data
structures that depend upon that subsystem.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7aca81142520..687f2b7cd382 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19525,6 +19525,7 @@ F:	arch/*/include/asm/percpu.h
 F:	include/linux/percpu*.h
 F:	lib/percpu*.c
 F:	mm/percpu*.c
+F:	scripts/gdb/linux/cpus.py
 
 PER-TASK DELAY ACCOUNTING
 M:	Balbir Singh <bsingharora@gmail.com>
-- 
2.43.0


