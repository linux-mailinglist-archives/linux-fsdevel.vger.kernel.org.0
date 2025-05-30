Return-Path: <linux-fsdevel+bounces-50177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCE6AC8AEE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 11:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2F01BC6103
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 09:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C085A221DBA;
	Fri, 30 May 2025 09:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="QMN/uMDJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8528E7
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 09:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748597493; cv=none; b=uDmFemV8gEx0oicowNNIz0RtpJozOym3cvFaE5x6qnErHotnz3oWXxnRV/h9s/aqKSFSfwUWMHCc0omISFW+1pqUi0np/IxSAf+KQxPwk8Wpkt49qlZIdUsxAT12+KnqZ2wNt6FzyTVUMPNNTF26AjmsZffEoY1asZnjTK57WBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748597493; c=relaxed/simple;
	bh=CSDCXobBWZhtRTJYQJOr5+LQO5QZF5XuFGMveHLRtkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqOeal2+/EsmNGtwnAB+vOAzGg290CE2+dF+qmoO8buSBg/HiaJkQsIlrKVqXXVq3Lm+m3DPBh4A0PjHnKVnC/3leyV1a/NVJEW1fTNOTaAuwNUKVur9rN0xWt0AjQdIQfUC3Dzxvw1YBqIC4i4xPQIKVVqsJmOPQK7xym6pdiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=QMN/uMDJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1505841b3a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1748597491; x=1749202291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWr/E1U9MoZB6J4RM+OE8fwerNiGURyoNSQ2TTxCRRo=;
        b=QMN/uMDJAC+cia0D5Uie7ylDSB8V955tA2GjAZEnP/hpfefNtYZ2IY9p7iwvn3gjI/
         y5nHUjhDjU7dtFQyJkLpP7cilJVsUFSds/l+kvPKRTW/6Ovy1bYNpnvZdgEJ9lQ7Wmb6
         DQipz4gUfcFAB15jSSj6KTRpqTq5auBHaRUOTfIzpQUcMVWimE9wD9DmOijdlRvEg04P
         SvIxTF1nIqA9QIu8kxTJwkl/ANtRZsdPSI3GZfdSyL4r96RjnGHu4Vxni0w7VpDUpldH
         Szljcpzm05jHfapokWUMaZ8sdnRyXtpaIy0yx4Bd051fqrT6zKzazXQeUtiFLx1YM+C7
         SiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748597491; x=1749202291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWr/E1U9MoZB6J4RM+OE8fwerNiGURyoNSQ2TTxCRRo=;
        b=pNp5q2+bUKjYauxUNtJ0Oxh6Q+y6hjT7hpRZbxB/n0GW253Ewz+ceMAei9I2fauMQ/
         aSBP3CNQ9k1nmxGpV/ubolmVVH9CS/5YPJg5/UzuP/tqp9Yu/x6ZGQiUduR0nZf46CLm
         dWpxpVg6Bt0RJ89uZQPxpzVWPZ7rshppSiE+CG+nBGdejqjhFmFZEX4x8aciszkEA85e
         +TQfBiK7mUttDGmzPzM9DLiHl9nPU73F4GJ1R5c4I5UdMnEC3/JJj0DlAzqlikd/SFU6
         WEhimxCEeFrTht1ksgWKM3DEAlSLZrsQXmEf7yt4vzD+Hbx5syAqGEVNkWqtmakVQvVT
         2qxw==
X-Forwarded-Encrypted: i=1; AJvYcCXmCRxSMv76R+n0c0y00IHS2KVJReCOrnrMVu8GcNxGzwTNbX6r8/Lang/UcBb4z9kZVMf4cd4VkZQgG7O/@vger.kernel.org
X-Gm-Message-State: AOJu0YysNeDx10tx1TKr/tIbXAGROxOEQldXi3N9bAjXB9EPnv04uVza
	BBLdbiszLZ+jiT30ZyrKCMggTbSTgZCmJevoKJHmsBIPcVmKY2BLfWLE0SUedr5NCpg=
X-Gm-Gg: ASbGnctmDCpyAcsxyWaDLIBBfbsTZv70Dytxy42qg6ibBOAj6L5LK1+WqtiWps5kD6q
	7Dtak+/habM9F/tR+U4N8273wo8HgpewqE9PgYOEFUCkectfR1mlhXj+o7/zKjSvV3Qy2wbEaDq
	g7rYG1WJzirp1wZ2zVO2sSJ+NLbwHBmHDD8jXiyQy8gP/AyxOia4K7bqKeazHl6vJLth8N07bUE
	rNoBZbPJxa8BYAOGSpzF/HBcdNPw8lbcc0TMmi21z5cuZYLOWMfOdgNRPX4Ws9/8eGZgTIOzE6I
	cEPkH4PxnZTpt/49wcJ5gk1ADYb785qP2Oo7AFU9S3YT2D4Yh9mKidvmbXcaeQ8OQY/1kaHFi6o
	TJsS1+HK+HLLJe5HYQEl8BXuOe2kgT6M=
X-Google-Smtp-Source: AGHT+IHWxhBqxJC7pLUfy1wWPlfI3PTo1BKYuowDxnWEkooeR6TUqW9HSM93HT5AUTV5EBB5Y+mNrQ==
X-Received: by 2002:a17:90b:48d2:b0:311:ad7f:3281 with SMTP id 98e67ed59e1d1-3125036ba85mr2606005a91.12.1748597490626;
        Fri, 30 May 2025 02:31:30 -0700 (PDT)
Received: from FQ627FTG20.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e29f7b8sm838724a91.2.2025.05.30.02.31.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 30 May 2025 02:31:30 -0700 (PDT)
From: Bo Li <libo.gcs85@bytedance.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	kees@kernel.org,
	akpm@linux-foundation.org,
	david@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	peterz@infradead.org
Cc: dietmar.eggemann@arm.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	jannh@google.com,
	pfalcato@suse.de,
	riel@surriel.com,
	harry.yoo@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	duanxiongchun@bytedance.com,
	yinhongbo@bytedance.com,
	dengliang.1214@bytedance.com,
	xieyongji@bytedance.com,
	chaiwen.cc@bytedance.com,
	songmuchun@bytedance.com,
	yuanzhu@bytedance.com,
	chengguozhu@bytedance.com,
	sunjiadong.lff@bytedance.com,
	Bo Li <libo.gcs85@bytedance.com>
Subject: [RFC v2 12/35] RPAL: enable service disable notification
Date: Fri, 30 May 2025 17:27:40 +0800
Message-Id: <20a49e36e1efc99b1489d81eb7b5fe8787fcee4c.1748594840.git.libo.gcs85@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a service is disabled, all services that request this service need
to be notified.

This patch use poll functions of file to implement such notification.
When a service is disabled, it will notify all services that request it
by set bit in others services' dead_key_bitmap. And the poll function
will then issue a poll epoll event, other services can aware the service
has been disabled.

The key of disabled service can be read from the proc file.

Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
---
 arch/x86/rpal/proc.c    | 61 +++++++++++++++++++++++++++++++++++++++++
 arch/x86/rpal/service.c | 37 +++++++++++++++++++++++--
 include/linux/rpal.h    | 10 +++++++
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/arch/x86/rpal/proc.c b/arch/x86/rpal/proc.c
index f001afd40562..16ac9612bfc5 100644
--- a/arch/x86/rpal/proc.c
+++ b/arch/x86/rpal/proc.c
@@ -8,6 +8,7 @@
 
 #include <linux/rpal.h>
 #include <linux/proc_fs.h>
+#include <linux/poll.h>
 
 #include "internal.h"
 
@@ -82,10 +83,70 @@ static long rpal_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+static ssize_t rpal_read(struct file *file, char __user *buf, size_t count,
+		  loff_t *pos)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_poll_data *rpd;
+	u64 released_keys[MAX_REQUEST_SERVICE];
+	unsigned long flags;
+	int nr_key = 0;
+	int nr_byte = 0;
+	int idx;
+
+	if (!cur)
+		return -EINVAL;
+
+	rpd = &cur->rpd;
+
+	spin_lock_irqsave(&rpd->poll_lock, flags);
+	idx = find_first_bit(rpd->dead_key_bitmap, RPAL_NR_ID);
+	while (idx < RPAL_NR_ID) {
+		released_keys[nr_key++] = rpd->dead_keys[idx];
+		idx = find_next_bit(rpd->dead_key_bitmap, RPAL_NR_ID, idx + 1);
+	}
+	spin_unlock_irqrestore(&rpd->poll_lock, flags);
+	nr_byte = nr_key * sizeof(u64);
+
+	if (copy_to_user(buf, released_keys, nr_byte)) {
+		nr_byte = -EAGAIN;
+		goto out;
+	}
+out:
+	return nr_byte;
+}
+
+static __poll_t rpal_poll(struct file *filep, struct poll_table_struct *wait)
+{
+	struct rpal_service *cur = rpal_current_service();
+	struct rpal_poll_data *rpd;
+	unsigned long flags;
+	__poll_t mask = 0;
+
+	if (unlikely(!cur)) {
+		rpal_err("Not a rpal service\n");
+		goto out;
+	}
+
+	rpd = &cur->rpd;
+
+	poll_wait(filep, &rpd->rpal_waitqueue, wait);
+
+	spin_lock_irqsave(&rpd->poll_lock, flags);
+	if (find_first_bit(rpd->dead_key_bitmap, RPAL_NR_ID) < RPAL_NR_ID)
+		mask |= EPOLLIN | EPOLLRDNORM;
+	spin_unlock_irqrestore(&rpd->poll_lock, flags);
+
+out:
+	return mask;
+}
+
 const struct proc_ops proc_rpal_operations = {
 	.proc_open = rpal_open,
+	.proc_read = rpal_read,
 	.proc_ioctl = rpal_ioctl,
 	.proc_mmap = rpal_mmap,
+	.proc_poll = rpal_poll,
 };
 
 static int __init proc_rpal_init(void)
diff --git a/arch/x86/rpal/service.c b/arch/x86/rpal/service.c
index 16a2155873a1..f490ab07301d 100644
--- a/arch/x86/rpal/service.c
+++ b/arch/x86/rpal/service.c
@@ -181,6 +181,9 @@ struct rpal_service *rpal_register_service(void)
 	atomic_set(&rs->req_avail_cnt, MAX_REQUEST_SERVICE);
 	bitmap_zero(rs->requested_service_bitmap, RPAL_NR_ID);
 	spin_lock_init(&rs->lock);
+	spin_lock_init(&rs->rpd.poll_lock);
+	bitmap_zero(rs->rpd.dead_key_bitmap, RPAL_NR_ID);
+	init_waitqueue_head(&rs->rpd.rpal_waitqueue);
 
 	rs->bad_service = false;
 	rs->base = calculate_base_address(rs->id);
@@ -296,6 +299,7 @@ static void remove_mapped_service(struct rpal_service *rs, int id, int type_bit)
 
 	clear_bit(type_bit, &node->type);
 	if (type_bit == RPAL_REQUEST_MAP) {
+		clear_bit(id, rs->rpd.dead_key_bitmap);
 		clear_requested_service_bitmap(rs, id);
 		atomic_inc(&rs->req_avail_cnt);
 	}
@@ -424,15 +428,30 @@ static int release_service(struct rpal_service *cur, struct rpal_service *tgt)
 	return 0;
 }
 
+static void rpal_notify_disable(struct rpal_poll_data *rpd, u64 key, int id)
+{
+	unsigned long flags;
+	bool need_wake = false;
+
+	spin_lock_irqsave(&rpd->poll_lock, flags);
+	if (!test_bit(id, rpd->dead_key_bitmap)) {
+		need_wake = true;
+		rpd->dead_keys[id] = key;
+		set_bit(id, rpd->dead_key_bitmap);
+	}
+	spin_unlock_irqrestore(&rpd->poll_lock, flags);
+	if (need_wake)
+		wake_up_interruptible(&rpd->rpal_waitqueue);
+}
+
 static void rpal_release_service_all(void)
 {
 	struct rpal_service *cur = rpal_current_service();
 	struct rpal_service *tgt;
+	struct rpal_mapped_service *node;
 	int ret, i;
 
 	rpal_for_each_requested_service(cur, i) {
-		struct rpal_mapped_service *node;
-
 		if (i == cur->id)
 			continue;
 		node = rpal_get_mapped_node(cur, i);
@@ -449,6 +468,20 @@ static void rpal_release_service_all(void)
 		}
 		rpal_put_service(tgt);
 	}
+
+	for (i = 0; i < RPAL_NR_ID; i++) {
+		if (i == cur->id)
+			continue;
+
+		node = rpal_get_mapped_node(cur, i);
+		tgt = rpal_get_service(node->rs);
+		if (!tgt)
+			continue;
+
+		if (test_bit(RPAL_REVERSE_MAP, &node->type))
+			rpal_notify_disable(&tgt->rpd, cur->key, cur->id);
+		rpal_put_service(tgt);
+	}
 }
 
 int rpal_release_service(u64 key)
diff --git a/include/linux/rpal.h b/include/linux/rpal.h
index 1fe177523a36..b9622f0235bf 100644
--- a/include/linux/rpal.h
+++ b/include/linux/rpal.h
@@ -107,6 +107,13 @@ struct rpal_mapped_service {
 	struct rpal_service *rs;
 };
 
+struct rpal_poll_data {
+	spinlock_t poll_lock;
+	u64 dead_keys[RPAL_NR_ID];
+	DECLARE_BITMAP(dead_key_bitmap, RPAL_NR_ID);
+	wait_queue_head_t rpal_waitqueue;
+};
+
 /*
  * Each RPAL process (a.k.a RPAL service) should have a pointer to
  * struct rpal_service in all its tasks' task_struct.
@@ -161,6 +168,9 @@ struct rpal_service {
 	struct rpal_mapped_service service_map[RPAL_NR_ID];
 	DECLARE_BITMAP(requested_service_bitmap, RPAL_NR_ID);
 
+	/* Notify service is released by others */
+	struct rpal_poll_data rpd;
+
 	/* delayed service put work */
 	struct delayed_work delayed_put_work;
 
-- 
2.20.1


