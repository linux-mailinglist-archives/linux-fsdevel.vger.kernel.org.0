Return-Path: <linux-fsdevel+bounces-52994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFE8AE9200
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Jun 2025 01:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCC556A2A47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC14302071;
	Wed, 25 Jun 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UR97XCXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986842FC00E;
	Wed, 25 Jun 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893204; cv=none; b=CB5Xa7ceLGVvGWcN9yLQ7CWASNbpgH7WDoKIVezCc2Ojnflb6mnjBlxV3amGrRLi/2/tBVE98saanFC+Mqv6x5i3ngLBLSh2ioPEqhfwLf+oQ49QMbrDst4OnCn81JUMNI1cRCSl0UGVCMZcTWypSaVqEp1xBsJd/y25WxmDSUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893204; c=relaxed/simple;
	bh=eXXly6tGtLsmBw6lCsjPx67mhmn8LroQ0FK0/kx/LVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NxoYecoMRuGTZ0iv7iTq3zxv6x71iAEzDp0nPAYsNuEu55sT2n8TAp5USRxkU3T6lLaBpqrFC6phrXh/8RAXa4WNlu341l3B2bxmANX61v0V7knz4K7jT0+Fe6TM21GT8coKNnP+XWatWK7Zi2ZZfCsUUmoAPd3/nssKUZyJ2ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UR97XCXw; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A7625C0008FB;
	Wed, 25 Jun 2025 16:13:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A7625C0008FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1750893185;
	bh=eXXly6tGtLsmBw6lCsjPx67mhmn8LroQ0FK0/kx/LVI=;
	h=From:To:Cc:Subject:Date:From;
	b=UR97XCXwWrJw0/aZBRZo/JKVPotWwFEtsL/aBtlB+wSvXPeiozPpG/asFdd7RsmCD
	 ZrJTjRqAGOSX92XJSvbjLZmxUW41+X04+ZfXVAhAmwDCaz8pMOlnUtFZCnUuN46tY0
	 OPI+4xZv2jMbUM4YdCDuYZWzTizLn195LslcPdVw=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 215DC18000530;
	Wed, 25 Jun 2025 16:13:05 -0700 (PDT)
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
Subject: [PATCH 00/16] MAINTAINERS: Include GDB scripts under their relevant subsystems
Date: Wed, 25 Jun 2025 16:10:37 -0700
Message-ID: <20250625231053.1134589-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux has a number of very useful GDB scripts under scripts/gdb/linux/*
that provide OS awareness for debuggers and allows for debugging of a
variety of data structures (lists, timers, radix tree, mapletree, etc.)
as well as subsystems (clocks, devices, classes, busses, etc.).

These scripts are typically maintained in isolation from the subsystem
that they parse the data structures and symbols of, which can lead to
people playing catch up with fixing bugs or updating the script to work
with updates made to the internal APIs/objects etc. Here are some
recents examples:

https://lore.kernel.org/all/20250601055027.3661480-1-tony.ambardar@gmail.com/
https://lore.kernel.org/all/20250619225105.320729-1-florian.fainelli@broadcom.com/
https://lore.kernel.org/all/20250625021020.1056930-1-florian.fainelli@broadcom.com/

This patch series is intentionally split such that each subsystem
maintainer can decide whether to accept the extra
review/maintenance/guidance that can be offered when GDB scripts are
being updated or added.

Thanks!

Florian Fainelli (16):
  MAINTAINERS: Include clk.py under COMMON CLK FRAMEWORK entry
  MAINTAINERS: Include device.py under DRIVER CORE entry
  MAINTAINERS: Include genpd.py under GENERIC PM DOMAINS entry
  MAINTAINERS: Include radixtree.py under GENERIC RADIX TREE entry
  MAINTAINERS: Include interrupts.py under IRQ SUBSYSTEM entry
  MAINTAINERS: Include kasan.py under KASAN entry
  MAINTAINERS: Include mapletree.py under MAPLE TREE entry
  MAINTAINERS: Include GDB scripts under MEMORY MANAGEMENT entry
  MAINTAINERS: Include modules.py under MODULE SUPPORT entry
  MAINTAINERS: Include cpus.py under PER-CPU MEMORY ALLOCATOR entry
  MAINTAINERS: Include timerlist.py under POSIX CLOCKS and TIMERS entry
  MAINTAINERS: Include dmesg.py under PRINTK entry
  MAINTAINERS: Include proc.py under PROC FILESYSTEM entry
  MAINTAINERS: Include vmalloc.py under VMALLOC entry
  MAINTAINERS: Include xarray.py under XARRAY entry
  MAINTAINERS: Include vfs.py under FILESYSTEMS entry

 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

-- 
2.43.0


