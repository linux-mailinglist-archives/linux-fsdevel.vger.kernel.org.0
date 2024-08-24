Return-Path: <linux-fsdevel+bounces-27046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9193A95DFB7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F681C20D50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AEB7DA92;
	Sat, 24 Aug 2024 19:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PPFcy32u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14B053365
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526634; cv=none; b=OqoFmCp4h0XbWu8vwKcJ9+u7pPESfa5zkEER3ozHFKNzvFzOfJg28FuGAGBSTn5320CBfxjSIuxzIxUxmgBil5G4FoqtBHKN00+zqRJqUxSKV8iDhOJ+WaYTtRE+aHbE2ODePbYmoEQ1QDeFjNrfFk9OJO3nOQ38toZ6YKvZGiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526634; c=relaxed/simple;
	bh=7ftgbG7YU5N4/Vex8PaCGNxpD2EdwiW27SRDpAcTz/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNsm7SNQ4V6VVX3jAQ15UedDjtuvPLwRHidbb0xN1kpXMW7rJ51P3IqpjMK7qt8nKDKfFiG+Qil7cTD7OgzCuzf50D4rIa9DIldIJbegv4/PVqxb8ohNxcEZscI7D0B66A6YpVPbwlCgF9HO4q4w9pFeTWriG+rTzWYJGLHB18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PPFcy32u; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dFIqub/H0W/jxga81Z+QEFiTVGOHm6eupVbndlDP2Ws=;
	b=PPFcy32u+C4HIbkrM5qfR/gYiBkAIpkzJuI4bHbkvdt3Ikx0DobluDrFUa46Ya/wSK97JV
	F6vOL2WDPz+gtBNUWjWxGGebrWlwIaOxUfTCGJqsBx7wmfZaICqbd77whqMMyDFZcHHSZH
	DJLWvGNRWDLSkIVYQ0c/aL3cISSCRyo=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 00/10] shrinker debugging, .to_text() report (resend)
Date: Sat, 24 Aug 2024 15:10:07 -0400
Message-ID: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

recently new OOMs have been cropping up, and reclaim is implicated, so
I've had to dust off these patches.

nothing significant has changed since the last time I posted, and they
have been valuable - Dave, think we can get them in?

Kent Overstreet (10):
  seq_buf: seq_buf_human_readable_u64()
  mm: shrinker: Add a .to_text() method for shrinkers
  mm: shrinker: Add new stats for .to_text()
  mm: Centralize & improve oom reporting in show_mem.c
  mm: shrinker: Add shrinker_to_text() to debugfs interface
  bcachefs: shrinker.to_text() methods
  percpu: per_cpu_sum()
  fs: Add super_block->s_inodes_nr
  fs/dcache: Add per-sb accounting for nr dentries
  fs: super_cache_to_text()

 fs/bcachefs/btree_cache.c     | 13 +++++
 fs/bcachefs/btree_key_cache.c | 14 ++++++
 fs/bcachefs/util.h            | 10 ----
 fs/dcache.c                   | 18 ++-----
 fs/inode.c                    |  2 +
 fs/super.c                    | 25 ++++++++++
 include/linux/fs.h            |  2 +
 include/linux/percpu.h        | 10 ++++
 include/linux/seq_buf.h       |  4 ++
 include/linux/shrinker.h      | 13 ++++-
 lib/seq_buf.c                 | 10 ++++
 mm/oom_kill.c                 | 23 ---------
 mm/show_mem.c                 | 43 ++++++++++++++++
 mm/shrinker.c                 | 94 ++++++++++++++++++++++++++++++++++-
 mm/shrinker_debug.c           | 18 +++++++
 mm/slab.h                     |  6 ++-
 mm/slab_common.c              | 52 +++++++++++++++----
 17 files changed, 298 insertions(+), 59 deletions(-)

-- 
2.45.2


