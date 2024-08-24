Return-Path: <linux-fsdevel+bounces-27038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C60F95DF63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28643282296
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90044AEF4;
	Sat, 24 Aug 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nrvZEHYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926C45B5D6
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522712; cv=none; b=h2gZOli1ocKhAxxlfZh+Rt5kuIacBzpzBsiQVqQHXP/XMlt4FX1KO0G6+EqTxdqtIq1afbCTHpe1Tqp0kQ9+7lXs1yAfJYUiIf390PePS7GmZg0/eP81Xp2ZlbxSz7Irkz30JXxN7kZBniicBvr2M8Ydep1py7e6PwmVowFj43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522712; c=relaxed/simple;
	bh=xGx7k72dOsxVpNPgYQ7HlZnqmZykbb4VYIPThTwk2QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZyUWUWbEXEDgZfUSz3w8WLLEwUrJ/ehFe60TyVc/brS3m4NnW1gpPNaHmAI3AAkczL32MiRvXduPSgOIOqVkXNodLsc46YeUhAN4TRi5Zf0ICY/SP5NTLLii1EH7AIWwWNTjgLiYENGvrqISIg6qXan8HInZ6lohM5Tw9HVo1Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nrvZEHYX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLXUgRI7sBHgtq1Zgi7tzIKwC1ZgZVmc7Lbaw9gZGks=;
	b=nrvZEHYXNFvA8rCqvynWGC+kjUcfqJ7Zuty2GRIw8qamn3CulrbGOwzM+BLMhWG6h2dKVN
	YOFQLR9npIKlzbsdclDlqy4Jb/AY6Ek4tGVq06P7gBYNg+dglfdaEdoTWFJYTBmTNt54X5
	b1JWkRkFWs3pBsqp8i42721xC/3zhwg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 05/10] mm: shrinker: Add shrinker_to_text() to debugfs interface
Date: Sat, 24 Aug 2024 14:04:47 -0400
Message-ID: <20240824180454.3160385-6-kent.overstreet@linux.dev>
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

Previously, we added shrinker_to_text() and hooked it up to the OOM
report - now, the same report is available via debugfs.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 mm/shrinker_debug.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 12ea5486a3e9..39342aa9f4ca 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -2,6 +2,7 @@
 #include <linux/idr.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
+#include <linux/seq_buf.h>
 #include <linux/seq_file.h>
 #include <linux/shrinker.h>
 #include <linux/memcontrol.h>
@@ -159,6 +160,21 @@ static const struct file_operations shrinker_debugfs_scan_fops = {
 	.write	 = shrinker_debugfs_scan_write,
 };
 
+static int shrinker_debugfs_report_show(struct seq_file *m, void *v)
+{
+	struct shrinker *shrinker = m->private;
+	char *bufp;
+	size_t buflen = seq_get_buf(m, &bufp);
+	struct seq_buf out;
+
+	seq_buf_init(&out, bufp, buflen);
+	shrinker_to_text(&out, shrinker);
+	seq_commit(m, seq_buf_used(&out));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(shrinker_debugfs_report);
+
 int shrinker_debugfs_add(struct shrinker *shrinker)
 {
 	struct dentry *entry;
@@ -190,6 +206,8 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 			    &shrinker_debugfs_count_fops);
 	debugfs_create_file("scan", 0220, entry, shrinker,
 			    &shrinker_debugfs_scan_fops);
+	debugfs_create_file("report", 0440, entry, shrinker,
+			    &shrinker_debugfs_report_fops);
 	return 0;
 }
 
-- 
2.45.2


