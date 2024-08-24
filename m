Return-Path: <linux-fsdevel+bounces-27034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD695DF5F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 20:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8871F214E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 18:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7A156B72;
	Sat, 24 Aug 2024 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HAaML1t1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B062C433A2
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522706; cv=none; b=bsVLfvJ70WtPrT2Ev6PFzhst5Y1j8n1udc8YU+Dv7c4D2aBh/lD5V3PnWwzUUKU5sZMs9E9tO2wWQcWXOeVHqO8UN+A+lK4II6iSHi4SCg/81EzKJNYCKL1fL5kk1fURyHTOPQlY6DnIQ6Q1YYm8WpGXspfO53z+IHC2ZuSJ7E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522706; c=relaxed/simple;
	bh=dTn8qEYS+s/QZfynwJqRJ0yufElOQv3URjcdgqiU2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C3eadjwxhGK96vfuA5aK2NQgZjQ0N74ztbUx26uTxRwLfyN4n4MTsdAn6xsP6wHtbRWW79hQtogtknPVMux6YkkxoK3nYqX8AZndHFJbYsmvCD26x3ZBOFE6YaFiRTXErBLHbuiF34czuvoK1e/7102EyysCZebbtwPzht5rLvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HAaML1t1; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724522702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4DTT9AInmX29fCUItJ/fQQQ+2P1VUsJ4Sn1mHHvlmQ=;
	b=HAaML1t1RV19xB12Xqwl4Rmu43uMqkE1khFSE0/turbXOvDnpQOsKjX1AcZWmsX0vsX2yO
	JyeNNLt5AEc7bMxo7/FTrn7IBF9BnP73eaPmCmuQF5ZqMScLv50ysRdKDVd7ptzJfmPn9J
	/yj9/filyYtaTXi+EhlAW37MIZ/fwrg=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 01/10] seq_buf: seq_buf_human_readable_u64()
Date: Sat, 24 Aug 2024 14:04:43 -0400
Message-ID: <20240824180454.3160385-2-kent.overstreet@linux.dev>
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

This adds a seq_buf wrapper for string_get_size().

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/seq_buf.h |  4 ++++
 lib/seq_buf.c           | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
index fe41da005970..1cba369e1821 100644
--- a/include/linux/seq_buf.h
+++ b/include/linux/seq_buf.h
@@ -173,4 +173,8 @@ seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
 
 void seq_buf_do_printk(struct seq_buf *s, const char *lvl);
 
+enum string_size_units;
+void seq_buf_human_readable_u64(struct seq_buf *s, u64 v,
+				const enum string_size_units units);
+
 #endif /* _LINUX_SEQ_BUF_H */
diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index f3f3436d60a9..3c41ca83a0c3 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -436,3 +436,13 @@ int seq_buf_hex_dump(struct seq_buf *s, const char *prefix_str, int prefix_type,
 	}
 	return 0;
 }
+
+void seq_buf_human_readable_u64(struct seq_buf *s, u64 v, const enum string_size_units units)
+{
+	char *buf;
+	size_t size = seq_buf_get_buf(s, &buf);
+	int wrote = string_get_size(v, 1, units, buf, size);
+
+	seq_buf_commit(s, wrote);
+}
+EXPORT_SYMBOL(seq_buf_human_readable_u64);
-- 
2.45.2


