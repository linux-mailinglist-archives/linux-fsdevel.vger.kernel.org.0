Return-Path: <linux-fsdevel+bounces-39872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BABA19A93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 22:57:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F2B1889371
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2025 21:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DDF1C9DE5;
	Wed, 22 Jan 2025 21:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNB5UZP6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F411C6889
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 21:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737583020; cv=none; b=X5mlZBv0vjEVZWNc/VHMELpvoU+c7S5H8Cwd6gty+PdSwi2LK1xUKXPxjnqkOi3rkjEvMcBrDbNMzh/LOytAqOEP8lMsq2S26rfHGd6142RXbltc8BcU5RUTrja3cVTmqL/RMjH91cy04LP+F/OsnKAAI9hkvSU6YK5IrZCMRV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737583020; c=relaxed/simple;
	bh=g13YcPeDhhq2NuW90MaLFbqQrlXt2F5RYHMRQMyAhzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZmGvIQNeC7MbithpBXvadwic6hftqIBhb/IvDjod6SQmyO7NLe09dkwck47avQioJ5XJARB89ovJwlEQ3hbFYrXKj+sHv1pOdkHzRfxa4MduiNOBEq4CZ6nk3+Q6TDXcQ2z80othcYZak6jxxU0xyNKWzcKFSfjX9RoNJfd16g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNB5UZP6; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e5447fae695so416724276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737583017; x=1738187817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms24zaSLaQOivVyWKgDydjCdhS+914WXBy/w4wzVD6o=;
        b=WNB5UZP6HnAleX3xHE8B0a+4fW1vwNGaahj6aOdyTPjM1RT+hQa7qUeC8IWcV7hORd
         B4O20elHcWQsRH3z/FHiOSn3G3eBQiuKdd0oJA0Y4c4uD4s5mIw0TggFhMcTM5deQapR
         7oFuABgFaLJXBEGhxaZqBkm5qbD6+qQernMEMfIMqTcP1J3QrZkWqgUwuWmktlwaFeoQ
         mfXrPIXK/98YtObSNFrt0y1Fh2yRdFMqQSgsobqZMHUFaJz16xJG+Z0Zio3DZGI92KuO
         ERHsUc9UOyYOdl2pY+yL+Wi1Buv+X2jfEfKxTvzOSihWH126OXmYWEbnzRQCB/EjbPwM
         KV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737583017; x=1738187817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms24zaSLaQOivVyWKgDydjCdhS+914WXBy/w4wzVD6o=;
        b=rrTS8mLKhnE+WUhjBGxb9mFUBp1L8yVz5MGC4FBZ7wo6aTrDZ7cAdQ9FN2h2Q4AbiX
         Urlm40AxJPqwpnrvFfubAQXvkbLOJ+qf3oIqWm/qOmEfsexDo0Hdl53JG8DOHDW6jUa3
         TDGPdHvsi/wkmLYWrTTYyku1vwEflMD3ok9LoWcxASAUBVdHR+bZ5xjC5eVPylTfALOS
         woM8GeMbYhRdEQllSg01R5WdSxhf7klQiCO/cM4FvpTkCHW6ZqWJRZ/6CaQHy0L2hiHy
         tpB/ciHj7wMGHEb8Vf8hfA9qmmoHr/ksLZGeFzCeFMHBUeFz84Zdzw15TPPgL8bsc/a3
         7r8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzyLoxys5143Z1TAXp6aBJd17pb7Qnp8uHPwHSjTZUMTtqCCiCTh9E/CV+1Ze3fwfDdQhdAKLxr6TLpGfC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5MSeDBkLWCPZ5HDHvzaNMC9huWSOmr9JlMwG6W/OmmICDBkMG
	cNMAAIvrt3KwV/wu0L6vcooN1INpdj4KGOMeRQDWgugoKWxVqi1bZxOWJg==
X-Gm-Gg: ASbGncsb8+FaYBcDAcJ04iWS804Cx2+Yw40yyDKC7u/oWximU241BMHvX6V7IASddqa
	QuJlk7HazqUAOs4vbdMz/ZwvcKFc5s0GklCyKpSwpI0+h0lB1h/kSR5f17DifOcGyp3j+rTWSgX
	GNa/xHAWgYLdaXtzbBqqod+9XsKGEOT4i+OYl+TchwEEVNYm/iJUY81qmDA/0XYl/lMr+F0crA0
	MDupu9kQZIjAGjQPEgyyB2qLFaZNUrReWFh7SCTCyqAeIaHhEWTD73M1vfrB7ikNLmu
X-Google-Smtp-Source: AGHT+IG94HQHk4aSn3lHe/A1wGLNFWOfEQ380QsrIENQ+feF7pU2jDse3I8AwqcLsb/jzlvwVtrsuw==
X-Received: by 2002:a05:690c:6806:b0:6ef:5cd2:49bb with SMTP id 00721157ae682-6f6eb9296a5mr193679377b3.30.1737583017459;
        Wed, 22 Jan 2025 13:56:57 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:70::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63fd612sm21863167b3.28.2025.01.22.13.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 13:56:57 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Wed, 22 Jan 2025 13:55:28 -0800
Message-ID: <20250122215528.1270478-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250122215528.1270478-1-joannelkoong@gmail.com>
References: <20250122215528.1270478-1-joannelkoong@gmail.com>
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
values is 65535.

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

$ echo 65536 | sudo tee /proc/sys/fs/fuse/default_request_timeout
tee: /proc/sys/fs/fuse/default_request_timeout: Invalid argument

$ echo 65535 | sudo tee /proc/sys/fs/fuse/default_request_timeout
65535

$ sysctl -a | grep fuse.default_request_timeout
fs.fuse.default_request_timeout = 65535

$ echo 0 | sudo tee /proc/sys/fs/fuse/default_request_timeout
0

$ sysctl -a | grep fuse.default_request_timeout
fs.fuse.default_request_timeout = 0

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 10 +++++++++
 fs/fuse/inode.c                         | 28 +++++++++++++++++++++++--
 fs/fuse/sysctl.c                        | 24 +++++++++++++++++++++
 4 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index f5ec6c9312e1..35aeb30bed8b 100644
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
+The maximum value that can be set is 65535.
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
+is 65535.
+
+For timeouts, if the server does not respond to the request by the time
+the set timeout elapses, then the connection to the fuse server will be aborted.
+Please note that the timeouts are not 100% precise (eg you may set 60 seconds but
+the timeout may kick in after 70 seconds). The upper margin of error for the
+timeout is roughly FUSE_TIMEOUT_TIMER_FREQ seconds.
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 1321cc4ed2ab..e5114831798f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -49,6 +49,16 @@ extern const unsigned long fuse_timeout_timer_freq;
 
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
index 79ebeb60015c..4e36d99fae52 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -37,6 +37,9 @@ DEFINE_MUTEX(fuse_mutex);
 static int set_global_limit(const char *val, const struct kernel_param *kp);
 
 unsigned int fuse_max_pages_limit = 256;
+/* default is no timeout */
+unsigned int fuse_default_req_timeout = 0;
+unsigned int fuse_max_req_timeout = 0;
 
 unsigned max_user_bgreq;
 module_param_call(max_user_bgreq, set_global_limit, param_get_uint,
@@ -1268,6 +1271,24 @@ static void set_request_timeout(struct fuse_conn *fc, unsigned int timeout)
 			   fuse_timeout_timer_freq);
 }
 
+static void init_server_timeout(struct fuse_conn *fc, unsigned int timeout)
+{
+	if (!timeout && !fuse_max_req_timeout && !fuse_default_req_timeout)
+		return;
+
+	if (!timeout)
+		timeout = fuse_default_req_timeout;
+
+	if (fuse_max_req_timeout) {
+		if (timeout)
+			timeout = min(fuse_max_req_timeout, timeout);
+		else
+			timeout = fuse_max_req_timeout;
+	}
+
+	set_request_timeout(fc, timeout);
+}
+
 struct fuse_init_args {
 	struct fuse_args args;
 	struct fuse_init_in in;
@@ -1286,6 +1307,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		ok = false;
 	else {
 		unsigned long ra_pages;
+		unsigned int timeout = 0;
 
 		process_init_limits(fc, arg);
 
@@ -1404,14 +1426,16 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
 				fc->io_uring = 1;
 
-			if ((flags & FUSE_REQUEST_TIMEOUT) && arg->request_timeout)
-				set_request_timeout(fc, arg->request_timeout);
+			if (flags & FUSE_REQUEST_TIMEOUT)
+				timeout = arg->request_timeout;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
 			fc->no_flock = 1;
 		}
 
+		init_server_timeout(fc, timeout);
+
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
 		fc->minor = arg->minor;
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
index b272bb333005..3d542ef9d889 100644
--- a/fs/fuse/sysctl.c
+++ b/fs/fuse/sysctl.c
@@ -13,6 +13,12 @@ static struct ctl_table_header *fuse_table_header;
 /* Bound by fuse_init_out max_pages, which is a u16 */
 static unsigned int sysctl_fuse_max_pages_limit = 65535;
 
+/*
+ * fuse_init_out request timeouts are u16.
+ * This goes up to ~18 hours, which is plenty for a timeout.
+ */
+static unsigned int sysctl_fuse_req_timeout_limit = 65535;
+
 static struct ctl_table fuse_sysctl_table[] = {
 	{
 		.procname	= "max_pages_limit",
@@ -23,6 +29,24 @@ static struct ctl_table fuse_sysctl_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &sysctl_fuse_max_pages_limit,
 	},
+	{
+		.procname	= "default_request_timeout",
+		.data		= &fuse_default_req_timeout,
+		.maxlen		= sizeof(fuse_default_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_req_timeout_limit,
+	},
+	{
+		.procname	= "max_request_timeout",
+		.data		= &fuse_max_req_timeout,
+		.maxlen		= sizeof(fuse_max_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_req_timeout_limit,
+	},
 };
 
 int fuse_sysctl_register(void)
-- 
2.43.5


