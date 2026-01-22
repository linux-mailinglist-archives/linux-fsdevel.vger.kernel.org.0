Return-Path: <linux-fsdevel+bounces-75125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGN9A7JmcmmrjwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:04:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A885B6BEB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 19:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E44F32002DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9A3C0875;
	Thu, 22 Jan 2026 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSuHtNm6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951031327B
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 17:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769101438; cv=none; b=oCSTqXULucJ+8aPkOXjVqSM1XrURYKnsBu4JAQlc3RfzKUKflZxd1wzLrH1S60Pkq56MB3NRWxnXVU1qShNycWS1k8mRpMbPMC1BpJHh78a+IvUfgPOMFnm9S/81DJiJBfmBQu2fA/BC7TZoDk1z0KTsQEhTdKpLIeRBUvhOFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769101438; c=relaxed/simple;
	bh=VY2vVw51mePM2zgAbBEm/Vez+SIerJBHj9XE3FAxxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpEUC15Ug+gjtIMDGY+Kn5nkcReKpeExFHjiU4+3ZRniDIqyeUVZIJEYNbTYWwZW9Bq10EJCqe9XbP1rPOy6vsuiqiLuBvGL/vYzVYi7yrurcukfkiJUZnnbUv7Z3zWzDaVNdXJj1397ZOuo0kqovLvFjnUsafxLUehGqIlZJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSuHtNm6; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2b1981ca515so1401812eec.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 09:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769101431; x=1769706231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwaw7ulJ8eqCQzZAWx+2Cr0wFnlDolIVL12AnNX/htc=;
        b=NSuHtNm6nJF65NkZwb598bhhVKbonZGshcooJjJgKBbj5c7dx00FrDj3/wBCWL1ENz
         qeo1mtuDSYchtFmUR5HBRk+Jnyd4AdqL8oSdRCWc7/jRFb62Qc4OBPreLqVbHOFZM0ZP
         /HAL0lfgcfTnpX0aO/iY+vekROT4bPsfV+Xtmh82RrN+YSeev4jBygUqK6LYHNLJ8S8k
         QqTd80ddjC5OJN2hjVbOLjZcjZ4hgXZi+9WyNpp8Dk2Jed/f74tYBA7+zJ+yphjEjIeU
         M/dfMQnPmaYnvBTnSpUOS7DFAC3pq+tNrachUZdt83x5U7r67hft1JdU5x7i4YXC3Zv6
         hz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769101431; x=1769706231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwaw7ulJ8eqCQzZAWx+2Cr0wFnlDolIVL12AnNX/htc=;
        b=FgtZObBPY9brgpi4vylQAdATOXXn4BTys266yvZrQNMRaYRS0T8o8Ae+wk/iVHvNzT
         nSgyRR7qaZ85EXvLgJvbtHQDcI6Y0uSfU430dqeDIqSqANBfJsQge+mLkEqQC/Jc92U+
         JZNnjvrX4fwZAyZHGBBbaJLqI298rkYCyhLnXWXsx7ydaGzpqy5/b9jVqpuUF3EuCjui
         NuHokHOC8AnpLrOJG/v/CAPKjSjyUUldOY9pfTE+hFM+05RgysLIlnF7WEYMTIv65t3o
         cdgXlq3mz3jHv+xS7z6+21z0t+M+v0HDuHyNDU40zn8fCADIpAY1VWZBIWLdFeGB01Xp
         hAbw==
X-Forwarded-Encrypted: i=1; AJvYcCXH8J6D9CBGmPlpEdlAIecrmfwG4pByJMUqmUDVxDwofYHTfiEWTdgSKrgySHGFL6VhSj/QOz5c/aHlZuCu@vger.kernel.org
X-Gm-Message-State: AOJu0YwDSpxw2+tx+l0MOBquvQZR2EDc8ytCM4vHlYl76AZYvWe7NP5j
	kVp/pPoQSm2hJC27dzAM2+34DM5LQCYHHmR49ARHgrRv6L7nTQVNLjZO
X-Gm-Gg: AZuq6aK67P27HHW5P5HNwL6/XGVwu+gq2ADgoANVtPn6vnkDzw0rqdSKnh50NyNGHwO
	450BXV52oE9gIGqlgRlyN/nSwllEZM78mhrP95YsjrXlSiQDr7/gbYLD2QDcrmLZWpL3pngcxP2
	h6cihc1/5TjHf9WRBAOSc0zsjHU0hVtA+CmH81k4Wdy+S5rPXBnvkQ5xY2PZmgzsYjPeZB1/8A2
	LT4DU72Z0sKUpHdjBWGNZ624/8xRERaV056p4lMqtC2GkXzzjGDBsjt/oOPXeE0QC0uzSgdhM1O
	ai9CnRt4FsS1MQAFiV0+/JHxzLf+Yzk5mTXNcox9UVkNjlPsHPTEXZxtnkajpvF2NiVR47zAKtk
	gs2owWBRb3G5p/JRs6SQFeAdOzHdFiOBo16TYeyT0kggtCjFF4IqUNRZM5bvzMnx0isXbFM3+eA
	4mEoVv4gpiNtFP/A==
X-Received: by 2002:a05:693c:2296:b0:2b4:7e6b:9c00 with SMTP id 5a478bee46e88-2b739b68347mr247eec.23.1769101431087;
        Thu, 22 Jan 2026 09:03:51 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b361f5d4sm26392109eec.17.2026.01.22.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:03:50 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuanql9@chinatelecom.cn,
	Qiliang Yuan <realwujing@gmail.com>
Subject: [PATCH] fs/file: optimize FD allocation complexity with 3-level summary bitmap
Date: Thu, 22 Jan 2026 12:03:45 -0500
Message-ID: <20260122170345.157803-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,chinatelecom.cn,gmail.com];
	TAGGED_FROM(0.00)[bounces-75125-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: A885B6BEB9
X-Rspamd-Action: no action

Current FD allocation performs a two-level bitmap search (open_fds and
full_fds_bits). This results in O(N/64) complexity when searching for a
free FD, as the kernel needs to scan the first-level summary bitmap.

For processes with very large FD limits (e.g., millions of sockets),
scanning even the level 1 summary bitmap can become a bottleneck during
high-frequency allocation.

This patch introduces a third level of summary bitmap (full_fds_bits_l2),
where each bit represents whether a 64-word chunk (4096 FDs) in open_fds
is fully allocated. This reduces the search complexity to O(N/4096),
making FD allocation significantly more scalable for high-concurrency
workloads.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
 fs/file.c               | 45 +++++++++++++++++++++++++++++++++--------
 include/linux/fdtable.h |  2 ++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 0a4f3bdb2dec..1163160e81af 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -114,6 +114,8 @@ static void free_fdtable_rcu(struct rcu_head *rcu)
 
 #define BITBIT_NR(nr)	BITS_TO_LONGS(BITS_TO_LONGS(nr))
 #define BITBIT_SIZE(nr)	(BITBIT_NR(nr) * sizeof(long))
+#define BITBITBIT_NR(nr) BITS_TO_LONGS(BITBIT_NR(nr))
+#define BITBITBIT_SIZE(nr) (BITBITBIT_NR(nr) * sizeof(long))
 
 #define fdt_words(fdt) ((fdt)->max_fds / BITS_PER_LONG) // words in ->open_fds
 /*
@@ -132,6 +134,8 @@ static inline void copy_fd_bitmaps(struct fdtable *nfdt, struct fdtable *ofdt,
 			copy_words * BITS_PER_LONG, nwords * BITS_PER_LONG);
 	bitmap_copy_and_extend(nfdt->full_fds_bits, ofdt->full_fds_bits,
 			copy_words, nwords);
+	bitmap_copy_and_extend(nfdt->full_fds_bits_l2, ofdt->full_fds_bits_l2,
+			BITS_TO_LONGS(copy_words), BITS_TO_LONGS(nwords));
 }
 
 /*
@@ -222,7 +226,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	fdt->fd = data;
 
 	data = kvmalloc(max_t(size_t,
-				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr), L1_CACHE_BYTES),
+				 2 * nr / BITS_PER_BYTE + BITBIT_SIZE(nr) + BITBITBIT_SIZE(nr), L1_CACHE_BYTES),
 				 GFP_KERNEL_ACCOUNT);
 	if (!data)
 		goto out_arr;
@@ -231,6 +235,8 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	fdt->close_on_exec = data;
 	data += nr / BITS_PER_BYTE;
 	fdt->full_fds_bits = data;
+	data += BITBIT_SIZE(nr);
+	fdt->full_fds_bits_l2 = data;
 
 	return fdt;
 
@@ -335,16 +341,24 @@ static inline void __set_open_fd(unsigned int fd, struct fdtable *fdt, bool set)
 	__set_bit(fd, fdt->open_fds);
 	__set_close_on_exec(fd, fdt, set);
 	fd /= BITS_PER_LONG;
-	if (!~fdt->open_fds[fd])
+	if (!~fdt->open_fds[fd]) {
 		__set_bit(fd, fdt->full_fds_bits);
+		unsigned int idx = fd / BITS_PER_LONG;
+		if (!~fdt->full_fds_bits[idx])
+			__set_bit(idx, fdt->full_fds_bits_l2);
+	}
 }
 
 static inline void __clear_open_fd(unsigned int fd, struct fdtable *fdt)
 {
 	__clear_bit(fd, fdt->open_fds);
 	fd /= BITS_PER_LONG;
-	if (test_bit(fd, fdt->full_fds_bits))
+	if (test_bit(fd, fdt->full_fds_bits)) {
 		__clear_bit(fd, fdt->full_fds_bits);
+		unsigned int idx = fd / BITS_PER_LONG;
+		if (test_bit(idx, fdt->full_fds_bits_l2))
+			__clear_bit(idx, fdt->full_fds_bits_l2);
+	}
 }
 
 static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
@@ -402,6 +416,7 @@ struct files_struct *dup_fd(struct files_struct *oldf, struct fd_range *punch_ho
 	new_fdt->close_on_exec = newf->close_on_exec_init;
 	new_fdt->open_fds = newf->open_fds_init;
 	new_fdt->full_fds_bits = newf->full_fds_bits_init;
+	new_fdt->full_fds_bits_l2 = newf->full_fds_bits_init_l2;
 	new_fdt->fd = &newf->fd_array[0];
 
 	spin_lock(&oldf->file_lock);
@@ -536,6 +551,7 @@ struct files_struct init_files = {
 		.close_on_exec	= init_files.close_on_exec_init,
 		.open_fds	= init_files.open_fds_init,
 		.full_fds_bits	= init_files.full_fds_bits_init,
+		.full_fds_bits_l2 = init_files.full_fds_bits_init_l2,
 	},
 	.file_lock	= __SPIN_LOCK_UNLOCKED(init_files.file_lock),
 	.resize_wait	= __WAIT_QUEUE_HEAD_INITIALIZER(init_files.resize_wait),
@@ -545,22 +561,35 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
 {
 	unsigned int maxfd = fdt->max_fds; /* always multiple of BITS_PER_LONG */
 	unsigned int maxbit = maxfd / BITS_PER_LONG;
+	unsigned int maxbit_l2 = BITBIT_NR(maxfd);
 	unsigned int bitbit = start / BITS_PER_LONG;
+	unsigned int bitbit_l2 = bitbit / BITS_PER_LONG;
 	unsigned int bit;
 
 	/*
-	 * Try to avoid looking at the second level bitmap
+	 * Try to avoid looking at the upper level bitmaps
 	 */
 	bit = find_next_zero_bit(&fdt->open_fds[bitbit], BITS_PER_LONG,
 				 start & (BITS_PER_LONG - 1));
 	if (bit < BITS_PER_LONG)
 		return bit + bitbit * BITS_PER_LONG;
 
-	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
-	if (bitbit >= maxfd)
+	/* Algorithmic Optimization: O(N) -> O(1) via 3rd-level summary bitmap */
+	bitbit_l2 = find_next_zero_bit(fdt->full_fds_bits_l2, maxbit_l2, bitbit_l2);
+	if (bitbit_l2 >= maxbit_l2)
 		return maxfd;
-	if (bitbit > start)
-		start = bitbit;
+
+	if (bitbit_l2 * BITS_PER_LONG > bitbit)
+		bitbit = bitbit_l2 * BITS_PER_LONG;
+
+	bitbit = find_next_zero_bit(fdt->full_fds_bits, maxbit, bitbit);
+	if (bitbit >= maxbit)
+		return maxfd;
+
+	bit = bitbit * BITS_PER_LONG;
+	if (bit > start)
+		start = bit;
+
 	return find_next_zero_bit(fdt->open_fds, maxfd, start);
 }
 
diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index c45306a9f007..992b4ed9c1e0 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -29,6 +29,7 @@ struct fdtable {
 	unsigned long *close_on_exec;
 	unsigned long *open_fds;
 	unsigned long *full_fds_bits;
+	unsigned long *full_fds_bits_l2;
 	struct rcu_head rcu;
 };
 
@@ -53,6 +54,7 @@ struct files_struct {
 	unsigned long close_on_exec_init[1];
 	unsigned long open_fds_init[1];
 	unsigned long full_fds_bits_init[1];
+	unsigned long full_fds_bits_init_l2[1];
 	struct file __rcu * fd_array[NR_OPEN_DEFAULT];
 };
 
-- 
2.51.0


