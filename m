Return-Path: <linux-fsdevel+bounces-27033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 994A895DF5E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C888E1C20D35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D661C4CB5B;
	Sat, 24 Aug 2024 18:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q6qKwqNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894003D967
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522705; cv=none; b=uZGiFm7eXU0rIkYyfvGW8+a856QbptEXCmgJSpppqPDdoAKFg30qhgU2/u5cMR7Re4xB5tq8U3dh+n/DTb0rdJ9JwgkwRy0sEB4XttOWhXBjDYW5ESMcZLs7gkLXOkpt1md90pY+HiQytxNkBJXvF/1+J48LNLxNnhazEpGaOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522705; c=relaxed/simple;
	bh=7ftgbG7YU5N4/Vex8PaCGNxpD2EdwiW27SRDpAcTz/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DbdN1bv+W2cM+zfLYh/p0oyN73KtCqUkZ/jxUGoGSbLZOPt1dcKrdA2oTYHAqfUSGpALsUYXNJBlkmVxwTG0PMn6ngRfPtk6Ae8qBcMf0hr6EM2IZmZFJSZHMOUFcBfg7y2URRZB1gYwHPOc4mfFYo92ZyA25DC8Q+maQeLRC2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q6qKwqNP; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dFIqub/H0W/jxga81Z+QEFiTVGOHm6eupVbndlDP2Ws=;
	b=Q6qKwqNPbQdMXO91E17ud1nSwXMWpQpn1MRznjpFkvQQ3xsCKLgl8vFVLJsl1iPMp/tX5f
	N1S2sNX68BlXsS0E51fvQ6BLLgD1TdK75tYqA4UGE9HLcyEU03TWY3SNG+z25xaQyIfIal
	EUuqL0JckNc88mPEzJBqA8euMdRe2vc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 00/10] shrinker debugging, .to_text() report
Date: Sat, 24 Aug 2024 14:04:42 -0400
Message-ID: <20240824180454.3160385-1-kent.overstreet@linux.dev>
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


