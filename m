Return-Path: <linux-fsdevel+bounces-27045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC8C95DFB6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273A8282958
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAE61FFC;
	Sat, 24 Aug 2024 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZ4wABTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0848A558BC
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Aug 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724526632; cv=none; b=Zf1UXW7xsI1jrQsvl6V3uRmdLnjtQ07daYFlva0kcP6XnsbVsoadj43Wg20GlI45uXZTQvNxAKWWXESw2ZcrEgBY90y5d/yiJUzXEmaJN2PmNCSpSlrAbwaUm5aKPa4MaJ8/u/KzGAjiPRmFtnqeluDtOSMF3BotqPXVjGU8n5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724526632; c=relaxed/simple;
	bh=dTn8qEYS+s/QZfynwJqRJ0yufElOQv3URjcdgqiU2zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIIv6BC1n+c5gnOyQmindKMbgI6wIuueH5VeYR95gSdt3BSRHDQQ45XP+3GLOweV5bXZrMpH36J48BxVwSCzfTESday9dC4olfMheJ79rbEWqvdDZB404X0qOgaxlT23+uFr5agwDFvEko4Q11D7Hv4DJ0b34uEx52Zd1XTDSUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZ4wABTa; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724526628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4DTT9AInmX29fCUItJ/fQQQ+2P1VUsJ4Sn1mHHvlmQ=;
	b=xZ4wABTa6vq9Jts/HvTDzs72F9781v3Yg3ujOS8GOgj0WFCPwq6S9/orkPTgPVCY4WSYa5
	gDzPJ5Ixpp0Fqgwr1wM1P5LQvy6SVpl8XcxOR7KKH0UOUDyANYepoPgZYCcda1oZaaNMGu
	k2LZBiYiqsm6IX5U40ahz8xqUJE54r4=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: david@fromorbit.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 01/10] seq_buf: seq_buf_human_readable_u64()
Date: Sat, 24 Aug 2024 15:10:08 -0400
Message-ID: <20240824191020.3170516-2-kent.overstreet@linux.dev>
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


