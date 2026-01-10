Return-Path: <linux-fsdevel+bounces-73116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFB0D0CE8F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 05:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C6D30657B6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835E284670;
	Sat, 10 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uIeicvqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1A25DAEA;
	Sat, 10 Jan 2026 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017664; cv=none; b=hcgjFevz7ShA5wECXeoutP5Hh36/A6c+Gwdk4h9UBTSzVBpLZvldBuJO6XbRRPczoKwkRLGEObICW0592bBPc1m9B7JEWpHbQZ3fqpUPjzFCT2T6WWmUGfFu2QgOFw5kG7FU2Pk6G5M1gFXjNbQJ5ToA9Fu049N3mHjmjVYv5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017664; c=relaxed/simple;
	bh=1z70lKRknlSdqIBwT8PCoJx1AjZFc/zasivWeZ/Xl+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjxAJTtsWwhEQpibRkTCtWT4qCzMANowJaSYkOYjfqcnqBM3L5n1HGLhTgoX6N9II1ZzeCJpeF0W8LU85uY1+igPVbCN0AVibi2SywVC4ES34flxrbo0w5f/EaJfmHzGLHEFnemzsItsuqlAlG3nkM554BijPlj6zoL5reioKIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uIeicvqc; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=C4O95Yl5s9/wxYDLNk10/lpMX9to528i2PgDiiXFfe4=; b=uIeicvqcAdjQez8e5XGTZuq3uz
	6pS0Ua/0N3dsxZ2P0OYuhho5eQYhm8j5ts0/CncmYHbn2ywGNTTy5KC3FHlhWVGZn2wyYThkjwQQ0
	cE0FyzqFQ2kKz1tX0H6hqCLWfhEb0ON24pcs/3/u/pkkck/NsFbbQl/3HMm01OEdHVC7dlv5T46Qb
	nR1lUjs3EuFSE1COSZX0yzMLd/O8jVHjHoFsVjoX/6y5oBwuyQWrixRMI2puUEPJv46OI20VFefKP
	3zW/jVVbFNBDQlVmIihiNwNBe/IGLJldpZ27pFYSW9GvdZhX3I8upLGg45KAl59J/3Psr+vg0vJ3M
	Z2X0m9Ww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1veQB8-000000085Zh-4B9a;
	Sat, 10 Jan 2026 04:02:19 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/15] turn bh_cachep static-duration
Date: Sat, 10 Jan 2026 04:02:08 +0000
Message-ID: <20260110040217.1927971-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/buffer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 838c0c571022..c8ec1b440880 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -50,6 +50,7 @@
 #include <linux/fscrypt.h>
 #include <linux/fsverity.h>
 #include <linux/sched/isolation.h>
+#include <linux/slab-static.h>
 
 #include "internal.h"
 
@@ -2990,7 +2991,8 @@ EXPORT_SYMBOL(try_to_free_buffers);
 /*
  * Buffer-head allocation
  */
-static struct kmem_cache *bh_cachep __ro_after_init;
+static struct kmem_cache_opaque bh_cache;
+#define bh_cachep to_kmem_cache(&bh_cache)
 
 /*
  * Once the number of bh's in the machine exceeds this level, we start
@@ -3149,7 +3151,7 @@ void __init buffer_init(void)
 	unsigned long nrpages;
 	int ret;
 
-	bh_cachep = KMEM_CACHE(buffer_head,
+	KMEM_CACHE_SETUP(bh_cachep, buffer_head,
 				SLAB_RECLAIM_ACCOUNT|SLAB_PANIC);
 	/*
 	 * Limit the bh occupancy to 10% of ZONE_NORMAL
-- 
2.47.3


