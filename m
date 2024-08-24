Return-Path: <linux-fsdevel+bounces-27044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482195DF6C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9939B2125F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A07F7DA8F;
	Sat, 24 Aug 2024 18:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHT0hnV0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008D57DA61
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522717; cv=none; b=MkpLoObcYaayAluuFvbHj/Zr60FvzRGJfJzY3ZHe2+SAKD4ZX0IMN4gtXN8Fa0iX2t79UjH/AxThWuewPjmfsDPraGaKBMJzah3e7jQqWCYhF+O/BxeQErIeiMds8LlRnClMZ9XS6EUOLx0jlGeKk/p2OZ117dyv/f29lHxmbVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522717; c=relaxed/simple;
	bh=yx2TTPkWQYx/+NBdt0PltJw5AhCZpih5oQlFHWE9ZOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IniXNMDFVYdyXrH4sZfN7eSmuZGnIDKQwGsSeERT9HLTMLYLDlh0JHe92ypmSd82sW2veAtTf9kFYAypfgIFfa9R4BSu4HraY/fLiII4GbEJGgnBhrMEXGxIBFDR+ShfX+HI18Fv1YJEbP4gCR8YNMWd4bmOGrR3ExX6PLM8v48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHT0hnV0; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4/6BjvYC74gmac1jn75OzS49TGeIbW4Qt8X6sz89g0E=;
	b=jHT0hnV05iv296p3WrQnyV/nbjPukwVJE4DnQqUOpalgUVp344jeS19T8AaczEAFomWJM/
	Q/JMvlw1B8IFHtWtSWdsRwEpkejQh0e04qd7eVG6eoKT7aDbD/AqMUcIIb4SgnYAZXrT/u
	pAW9/ji9lDAxlqSVZJOOrHVx+JF8/MI=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 10/10] fs: super_cache_to_text()
Date: Sat, 24 Aug 2024 14:04:52 -0400
Message-ID: <20240824180454.3160385-11-kent.overstreet@linux.dev>
In-Reply-To: <20240824180454.3160385-1-kent.overstreet@linux.dev>
References: <20240824180454.3160385-1-kent.overstreet@linux.dev>
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


