Return-Path: <linux-fsdevel+bounces-23625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 406D59301BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D74F9B216EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2024 21:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A323351C21;
	Fri, 12 Jul 2024 21:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VmAgXu1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F46BA2E;
	Fri, 12 Jul 2024 21:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821157; cv=none; b=gZdbPLUciU3ky2Fa/Coo6zcFM2KaAssrPcYUALOi5Uoog8Nz4MsQ2lE54/rm9aDK9cYK7Bl63TWZzq1esSiDBM9nqQsZIrtiDiIZzzwDKhGTrL7Ez2HH0L3cv6M0hmaXZ0Sfe7ZPTTvtFD0sUi9k430YS21o8lhxLdCTOGMsmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821157; c=relaxed/simple;
	bh=5U0cBbanT80LXMxVb9Ookx7PdC/5es8wJ8tF2S12pwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y6SE8U9g9ggZ98lpxkqKI0XNU14tmkuedJa7CPfBdm++pZxX6pNvrzKinDNQUPDBMVB42ndY3SxZYvFTLFs5xxvX0W7b/v2+NLQaAHPaGLHRdYpYW1lOENyyDvRR0UDihi3qAP9osnbdfcPlTGXIevWIf0IAdm7aqhLANsq3ne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VmAgXu1r; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from xps-8930.corp.microsoft.com (unknown [131.107.160.48])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2591020B7165;
	Fri, 12 Jul 2024 14:52:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2591020B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1720821155;
	bh=eHr8WwKDOcEjp7b6WIE3GryqDegtAKq8kVAnn5nr2xo=;
	h=From:To:Cc:Subject:Date:From;
	b=VmAgXu1r2HrEzEnyN+4oOnb/poIF7I78+1DqtfH3by3DmZZ9JgTQJcuEBRtOS7uFv
	 Fm37C5q0pzge5bu2mhtDrExv3TROQ6c58RFMNKezAfZy3LRXHCA8tpuBQPXrVBSlry
	 WjU01Qt0PRjkZf2N6vMUBnEhgK7UZi3ORmRXHqSc=
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
Subject: [PATCH v2 0/1] binfmt_elf, coredump: Log the reason of the failed core dumps
Date: Fri, 12 Jul 2024 14:50:55 -0700
Message-ID: <20240712215223.605363-1-romank@linux.microsoft.com>
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

[V2]
  - Used _ratelimited to avoid spamming the system log
  - Added comm and PID to the log messages
  - Added logging to the failure paths in dump_interrupted, dump_skip, and dump_emit
  - Fixed compiler warnings produced when CONFIG_COREDUMP is disabled

[V1]
  https://lore.kernel.org/all/20240617234133.1167523-1-romank@linux.microsoft.com/

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

Roman Kisel (1):
  binfmt_elf, coredump: Log the reason of the failed core dumps

 fs/binfmt_elf.c          |  60 ++++++++++++++++-----
 fs/coredump.c            | 109 ++++++++++++++++++++++++++++++++-------
 include/linux/coredump.h |   8 ++-
 kernel/signal.c          |  22 +++++++-
 4 files changed, 165 insertions(+), 34 deletions(-)


base-commit: 831bcbcead6668ebf20b64fdb27518f1362ace3a
-- 
2.45.2


