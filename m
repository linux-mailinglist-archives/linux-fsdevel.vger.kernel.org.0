Return-Path: <linux-fsdevel+bounces-27055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B463495DFC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 500CBB21A90
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA1B143C46;
	Sat, 24 Aug 2024 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uLTTvEzA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D6EAD2F
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526641; cv=none; b=A5CYSoN360fLWFtGsOLXy27oamCK2WoVZTx1KSEfg95McA1/4Ez6/IIHn2yVdyhe881UiFv/A+LMy0drz+S/GhOCCi9zp8t6Y7rKLZjocKwz5TG3Birh5E2VxxEN/w9nMVsZfr7XIyJdxOCirUMveu2Ab7wU5xOgoIkJA00ddiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526641; c=relaxed/simple;
	bh=yx2TTPkWQYx/+NBdt0PltJw5AhCZpih5oQlFHWE9ZOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jfJp1krXwHrRCuclz1B3WhZdayddzL3JDwDD0rPOiiUCPuLDhBQhquO8YLOHxEOFmp0nFekqrw4gIbbAq7p7fNkgGnje95Va7rlhzwLMB61+MvUow+NOmcTOeY5u57LKyni/XEbMP13FVjW11WcvNQylhXLfUr9dWcCTLC14cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uLTTvEzA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/6BjvYC74gmac1jn75OzS49TGeIbW4Qt8X6sz89g0E=;
	b=uLTTvEzAmARYGg6WMItjxULIrOooAHWcR1U1Iq5IWriDIXInrJPfTm7cifzOilxCeEAm2U
	5IZXCh2j9e45pp9trnFvC3jeTQXWCfhgFsuZf/WIY7+metYuj+pGV7w7VUPQA5h7y/Yo5r
	z4rS4OOztEOz0kMF8FXMpgTNMw7IC4w=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 10/10] fs: super_cache_to_text()
Date: Sat, 24 Aug 2024 15:10:17 -0400
Message-ID: <20240824191020.3170516-11-kent.overstreet@linux.dev>
In-Reply-To: <20240824191020.3170516-1-kent.overstreet@linux.dev>
References: <20240824191020.3170516-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Implement shrinker.to_text() for the superblock shrinker: print out nr
of dentries and inodes, total and shrinkable.

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/super.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index 5b0fea6ff1cd..d3e43127e311 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/seq_buf.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -270,6 +271,16 @@ static unsigned long super_cache_count(struct shrinker *shrink,
 	return total_objects;
 }
 
+static void super_cache_to_text(struct seq_buf *out, struct shrinker *shrink)
+{
+	struct super_block *sb = shrink->private_data;
+
+	seq_buf_printf(out, "inodes:   total %zu shrinkable %lu\n",
+		       per_cpu_sum(sb->s_inodes_nr), list_lru_count(&sb->s_inode_lru));
+	seq_buf_printf(out, "dentries: toal %zu shrinkbale %lu\n",
+		       per_cpu_sum(sb->s_dentry_nr), list_lru_count(&sb->s_dentry_lru));
+}
+
 static void destroy_super_work(struct work_struct *work)
 {
 	struct super_block *s = container_of(work, struct super_block,
@@ -394,6 +405,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 
 	s->s_shrink->scan_objects = super_cache_scan;
 	s->s_shrink->count_objects = super_cache_count;
+	s->s_shrink->to_text = super_cache_to_text;
 	s->s_shrink->batch = 1024;
 	s->s_shrink->private_data = s;
 
-- 
2.45.2


