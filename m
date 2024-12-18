Return-Path: <linux-fsdevel+bounces-37766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039CD9F7002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 23:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D781893EB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 22:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECE51FCD1F;
	Wed, 18 Dec 2024 22:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEVilTUT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936F31FC7C5
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 22:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734560852; cv=none; b=CHFfqu59REIg7cVynPAh/8XCKcygARM4v6inGoRP2iYAY6vmzbddmLMPN8LeKsSMojycHeI44Xz6dbooijU2ShEP2TyqyWREXodjd4eDDy1gZOH26GwqVS0EMw8AgmwpHc8EZRYTx9U19BKh56I02lqeIl/qbeLeyoUP7s6/oo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734560852; c=relaxed/simple;
	bh=lRNSMiB/9Fl1NSyos3odsFHpo01K6p3fG7YlyR81ODs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvkuYv0L9dHm3qBZkwv775zmY++D41NiCbcJ8RPP6iZVDWrSysc9YYgJ2HOuJtzJs73y3qqtw+JvsQPRdI+SgdeC/Iova3RYMFbPOzpBH7QZR4pdN/Ks05j5okrkeKBJrieyIQrRYspdhsJl6dKMa55e98+SG8ixTuozRssmqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HEVilTUT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6f14626c5d3so1595347b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 14:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734560849; x=1735165649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJxClIbYoiDmP4Vx6vopU9i/iNYeol7ozMiBYaXiU8I=;
        b=HEVilTUTWVIO6ElIXhxEjqwQ547IQNkzx0m4GYodAbz63sj6wp/CWJ8fGxGwPsT5MO
         IxOu1ANcuzbcT2gvWvTjqAGfECSJ7s/FRf0aRONRvxsshU+KmrKCJ4iHsK0KgjnRG0gx
         RH8LCLZ9gsIzURmppBeF/G7kooNORkqYqyFkljNJJWkb8FxvFcFaJds8xV2Ns7dZ2klV
         wiBybyS2T0YzTqvlkmgsqPujwrwlmsHlS0fjDFu1Wfl0l75H+ZMcYQDNBjY5EynZE7Ur
         wR1pYs65CnCeMirta34PkexOjv6s84Ay1Vbx8a9t6vzl2SAGv4PfH/kWZ1r2xk8iTN+J
         6aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734560849; x=1735165649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJxClIbYoiDmP4Vx6vopU9i/iNYeol7ozMiBYaXiU8I=;
        b=gvnnTCZvPZnM1tBNen6ju1nvGuMO5OCV39Ef9hLTcXCBFNjCgZcs55xVWfTrKozqPc
         YqH5zB1+wtZo1LD46qrxEB4AoQ9RGT2yvA2cJu40d8Z9Yoq9WZ+5583+VQc2IRtejSir
         gFP1MjZhJ+VVEjDmUARQXgenVQV7qEsOAUJyYpPvtJNsVZy65cQ2C42rX9rqtw6qThrZ
         1PZ6WNAMa6LlKflY/AnouwWddsYzS2IDpuY3l2UnFRQ09Iuu7k1BO7RegRydOntlKYU4
         M3scfBBEaTyAAIqnkTmW3dVjMVsL4wzOUnHVgOLST+5wrHa0BKnRIX++VNOFmyQD9F/Y
         5kYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY+LBGl6dALH3i2ZZTQEMCzChYcXBaYuDxldo+jjQziyFgPFiIpylRw0JGt1UtNurH2fedz4JAu4PSsC22@vger.kernel.org
X-Gm-Message-State: AOJu0YyptWXcj6dXARcKNszQBz9BhVxTMMi2/OGLSQbxar8aBcSyQQT4
	1C+/MMLYcByTbXm/Zt4DJEKR/Qj3FKpfho306lDCZjvhjQ0tk+7V
X-Gm-Gg: ASbGnctlDSTcegMaTGGHE43wpwSbsYEiRB7g9Rzov5TJYJgS0S5l3kwfEYvYZwHIAzD
	gZfhwWZ38GlnsARdwXFuJgXpAnDcsL3Yz5OiyDN3p1TjGHpGe6gWKqD6ZbWeWlVLcjI8hyun160
	P2UuY7n0B3ku5S130fA7XULFZjjpTNSilOj4m7hYwZBFXNAnsxATfopvabXtxBqPKC8syRS2bw+
	mzT/x4FGFercrbmssMxKxgTPp93IuJuJx8CYqBTB95db45QaWrt0cI=
X-Google-Smtp-Source: AGHT+IE0Sj8Zhaq1zRefD1QN6xx+rWEhY//mf5xaf8/dYJXynpxBbU77zQdS5XE+aOBeLxg1pk84PQ==
X-Received: by 2002:a05:690c:ed2:b0:6e2:1527:446b with SMTP id 00721157ae682-6f3ccc29354mr36263757b3.3.1734560849462;
        Wed, 18 Dec 2024 14:27:29 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:73::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f288fc5059sm26375117b3.5.2024.12.18.14.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 14:27:29 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v11 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Wed, 18 Dec 2024 14:26:30 -0800
Message-ID: <20241218222630.99920-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241218222630.99920-1-joannelkoong@gmail.com>
References: <20241218222630.99920-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new sysctls, "default_request_timeout" and
"max_request_timeout". These control how long (in seconds) a server can
take to reply to a request. If the server does not reply by the timeout,
then the connection will be aborted. The upper bound on these sysctl
values is U32_MAX.

"default_request_timeout" sets the default timeout if no timeout is
specified by the fuse server on mount. 0 (default) indicates no default
timeout should be enforced. If the server did specify a timeout, then
default_request_timeout will be ignored.

"max_request_timeout" sets the max amount of time the server may take to
reply to a request. 0 (default) indicates no maximum timeout. If
max_request_timeout is set and the fuse server attempts to set a
timeout greater than max_request_timeout, the system will use
max_request_timeout as the timeout. Similarly, if default_request_timeout
is greater than max_request_timeout, the system will use
max_request_timeout as the timeout. If the server does not request a
timeout and default_request_timeout is set to 0 but max_request_timeout
is set, then the timeout will be max_request_timeout.

Please note that these timeouts are not 100% precise. The request may
take roughly an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max
timeout due to how it's internally implemented.

$ sysctl -a | grep fuse.default_request_timeout
fs.fuse.default_request_timeout = 0

$ echo 4294967296 | sudo tee /proc/sys/fs/fuse/default_request_timeout
tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument

$ echo 4294967295 | sudo tee /proc/sys/fs/fuse/default_request_timeout
4294967295

$ sysctl -a | grep fuse.default_request_timeout
fs.fuse.default_request_timeout = 4294967295

$ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
0

$ sysctl -a | grep fuse.default_request_timeout
fs.fuse.default_request_timeout = 0

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 Documentation/admin-guide/sysctl/fs.rst | 25 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 10 ++++++++++
 fs/fuse/inode.c                         | 16 ++++++++++++++--
 fs/fuse/sysctl.c                        | 14 ++++++++++++++
 4 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f5ec6c9312e1..12169a5e19dd 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -347,3 +347,28 @@ filesystems:
 ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
 setting/getting the maximum number of pages that can be used for servicing
 requests in FUSE.
+
+``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
+setting/getting the default timeout (in seconds) for a fuse server to
+reply to a kernel-issued request in the event where the server did not
+specify a timeout at mount. If the server set a timeout,
+then default_request_timeout will be ignored.  The default
+"default_request_timeout" is set to 0. 0 indicates no default timeout.
+The maximum value that can be set is U32_MAX.
+
+``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
+setting/getting the maximum timeout (in seconds) for a fuse server to
+reply to a kernel-issued request. A value greater than 0 automatically opts
+the server into a timeout that will be set to at most "max_request_timeout",
+even if the server did not specify a timeout and default_request_timeout is
+set to 0. If max_request_timeout is greater than 0 and the server set a timeout
+greater than max_request_timeout or default_request_timeout is set to a value
+greater than max_request_timeout, the system will use max_request_timeout as the
+timeout. 0 indicates no max request timeout. The maximum value that can be set
+is U32_MAX.
+
+For the timeouts, if the server does not respond to the request by the time
+the set timeout elapses, then the connection to the fuse server will be aborted.
+Please note that the timeouts are not 100% precise (eg you may set 60 seconds but
+the timeout may kick in after 70 seconds). The upper margin of error for the
+timeout is roughly FUSE_TIMEOUT_TIMER_FREQ seconds.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 26eb00e5f043..310885b51087 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,6 +46,16 @@
 
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
+/*
+ * Default timeout (in seconds) for the server to reply to a request
+ * before the connection is aborted, if no timeout was specified on mount.
+ */
+extern unsigned int fuse_default_req_timeout;
+/*
+ * Max timeout (in seconds) for the server to reply to a request before
+ * the connection is aborted.
+ */
+extern unsigned int fuse_max_req_timeout;
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 02dac88d922e..9f0be79eab74 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -36,6 +36,9 @@ DEFINE_MUTEX(fuse_mutex);
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
 unsigned int fuse_max_pages_limit = 256;
+/* default is no timeout */
+unsigned int fuse_default_req_timeout = 0;
+unsigned int fuse_max_req_timeout = 0;
 
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
@@ -1733,8 +1736,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
 {
-	if (ctx->req_timeout) {
-		if (check_mul_overflow(ctx->req_timeout, HZ, &fc->timeout.req_timeout))
+	unsigned int timeout = ctx->req_timeout ?: fuse_default_req_timeout;
+
+	if (fuse_max_req_timeout) {
+		if (!timeout)
+			timeout = fuse_max_req_timeout;
+		else
+			timeout = min(timeout, fuse_max_req_timeout);
+	}
+
+	if (timeout) {
+		if (check_mul_overflow(timeout, HZ, &fc->timeout.req_timeout))
 			fc->timeout.req_timeout = ULONG_MAX;
 
 		INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
index b272bb333005..5017059513f1 100644
--- a/fs/fuse/sysctl.c
+++ b/fs/fuse/sysctl.c
@@ -23,6 +23,20 @@ static struct ctl_table fuse_sysctl_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &sysctl_fuse_max_pages_limit,
 	},
+	{
+		.procname	= "default_request_timeout",
+		.data		= &fuse_default_req_timeout,
+		.maxlen		= sizeof(fuse_default_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
+	{
+		.procname	= "max_request_timeout",
+		.data		= &fuse_max_req_timeout,
+		.maxlen		= sizeof(fuse_max_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec,
+	},
 };
 
 int fuse_sysctl_register(void)
-- 
2.43.5


