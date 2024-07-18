Return-Path: <linux-fsdevel+bounces-23951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FD7935189
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 20:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C268728327C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB61459E8;
	Thu, 18 Jul 2024 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GmwrRovv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CB6433BB;
	Thu, 18 Jul 2024 18:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327281; cv=none; b=JzbkXYYew2FHK6UglNxV5/0W7Y+56rjr+3ibixu++sX1NwwslxEjGQFcjucht3N01QDMBEYR8CZRRaTC0onIWGY24tBwlNianlXUq5DmbgF8NJ4yfiddQxFI555DSiFqZ9sY7SEEvaKXb0uV/WikENsaH+ZBb2R6KlOl8rL2Jm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327281; c=relaxed/simple;
	bh=hZyF2n4zvDbkE8xmXmYsyVlC6BuY3EzE/k2+UQxUxSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lv1UmjuHMACNaO8lQbtPRXPkvJRpOD047kut4S5N7oG/3QDs2PZPclPOqHlb5qxv/xr/JmwtFij7dzTTakv32ZRmfkOCzPUEqjb7bL3Qj1+YPmqCCmkGQbyTHOh+XU5//7i1HznabL2J51vsQn5h1M1L8BxChkjB36ZytvQU7OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GmwrRovv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8D90920B7165;
	Thu, 18 Jul 2024 11:27:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8D90920B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1721327273;
	bh=tWFTp6/TaiSj5baOvog3g4oCKccEeVRvAgRU79qP/5M=;
	h=From:To:Cc:Subject:Date:From;
	b=GmwrRovv9Ub2VtlQ6cT3eB7EocZLsWfF5u0DytxzSG0N5d4wVIjA+z3VhnjrNgoOl
	 CW3DPk1VsVokqT8nua+nXyNlcOeuZdeHu4GeEIxlgjKuPgXl3DfUw9uOInyOKUEj77
	 nZqcPck2AAxC70h9ZPh9aMUCrM1z3R78nHnzRmq4=
From: Roman Kisel <romank@linux.microsoft.com>
To: akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	ardb@kernel.org,
	bigeasy@linutronix.de,
	brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	keescook@chromium.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	nagvijay@microsoft.com,
	oleg@redhat.com,
	tandersen@netflix.com,
	vincent.whitchurch@axis.com,
	viro@zeniv.linux.org.uk
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v3 0/2] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Thu, 18 Jul 2024 11:27:23 -0700
Message-ID: <20240718182743.1959160-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A powerful way to diagnose crashes is to analyze the core dump produced upon
the failure. Missing or malformed core dump files hinder these investigations.
I'd like to propose changes that add logging as to why the kernel would not
finish writing out the core dump file.

To help in diagnosing the user mode helper not writing out the entire coredump
contents, the changes also log short statistics on the dump collection. I'd
advocate for keeping this at the info level on these grounds.

For validation, I built the kernel and a simple user space to exercize the new
code.

[V3]
  - Standartized the existing logging to report TGID and comm consistently
  - Fixed compiler warnings for the 32-bit systems (used %zd in the format strings)

[V2]
  https://lore.kernel.org/all/20240712215223.605363-1-romank@linux.microsoft.com/
  - Used _ratelimited to avoid spamming the system log
  - Added comm and PID to the log messages
  - Added logging to the failure paths in dump_interrupted, dump_skip, and dump_emit
  - Fixed compiler warnings produced when CONFIG_COREDUMP is disabled

[V1]
  https://lore.kernel.org/all/20240617234133.1167523-1-romank@linux.microsoft.com/

Roman Kisel (2):
  coredump: Standartize and fix logging
  binfmt_elf, coredump: Log the reason of the failed core dumps

 fs/binfmt_elf.c          |  48 +++++++++----
 fs/coredump.c            | 150 +++++++++++++++++++++++++++------------
 include/linux/coredump.h |  30 +++++++-
 kernel/signal.c          |  21 +++++-
 4 files changed, 188 insertions(+), 61 deletions(-)


base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
-- 
2.45.2


