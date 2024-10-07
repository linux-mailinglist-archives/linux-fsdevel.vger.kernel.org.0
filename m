Return-Path: <linux-fsdevel+bounces-31250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62FD993671
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 20:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BF51F236CE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 18:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9D51DE2D4;
	Mon,  7 Oct 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbBXZySo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72B1DDC16
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Oct 2024 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728326641; cv=none; b=Tp+EjT9e1YhlPrZeYVmkxVUjKOv5O8M8WPQPxaI5cXfMbuJpzCmx00CHwPuAFoh74QE86Ue+5ZZVjCvWJVZm01SBuumWx8Kud4TC6AU1riFy65pLvMUWIeN0oGjFAQkEcOrB6fZAaiibh4LWSa+RBpDfsBHyO4Stezz1jjQH1vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728326641; c=relaxed/simple;
	bh=MD9Ko94AekHs0oA7dCCeh4rO74jyzy0vOcYhvi9kBZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfZib4ZMUO8yx4pFE9mkC3hW5JszAvcH6Ag6ijX1161BvSRXO/NHq/b98gkBBNvMDuP1+ACKEXOTCfMOmMiFURXmVSjOHu8Ds/tcSgLSXIZx20/2sY7cgn6WcgB4T58vzHSGkxPIO0uBYwCeI35J4wl/tBpVYP4LLAsO8jfvBu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbBXZySo; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e2b9e945b9so39118977b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2024 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728326639; x=1728931439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9gI/opjWzmtcdYedJ8bqx5X0aUu+tMVNICX91qp24A=;
        b=VbBXZySonVRKrMLuh5m4dP3h0fLNrLUamFUc8mLtFfevwWrVKxXFNuWvs6XCT73tR6
         JZYzSu5YofpNTrX63L8bNmCfkfSWqfAL2cawG9BSquzWwwJ9KKPlkbOYq+z/nffvKZqd
         yyArHOKyMLqYdpw+fSIi7ibS1Oxlqm9BOKTbveaiRDFUeUnUllaoQkxcB2K0qb6fM8cX
         rJ+GONhD1QhcKTqqg84buo+SODGgPP4iqBplgHs4oQzf77JfsTp08oDoDklmd6myYEGs
         jI4XfYtq7d7n1eFzxvMEPy0f1f0SFxNS1L1rajm7jrjZLnwrX+QJJj3TaJE5ZSyxVFSH
         aOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728326639; x=1728931439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C9gI/opjWzmtcdYedJ8bqx5X0aUu+tMVNICX91qp24A=;
        b=J+bquPnriKsz81yyKzkOvKd+nctTsMwAFoNNWO2NwNoc6n+HSMST1ZUzPmzfpOKaX/
         kESJaMYyGpX5HhdvHWIQBusrHtUNClkQn32M6rMvpaVtjuN6kZpgq2D5juaIgOysPqFY
         xmjkaMF4lhLqHM5KJc0NeDL/8CINjc6EGowU7h/C522UOoG4ewzE8dVmibew86KzbJiD
         Xu8fz2v6y0EG3LuH+vmuvO6zqrQ8/S+k22D/PNSo6h6L2z7KNssGIBlxXIwYqm0Vfs8j
         Y/Ksff6yQdalST8ooS7v0NPoNInooshWE/UKKg7BQrC56ZGkEXaS29MGZU+eS7lapqM1
         XBsg==
X-Forwarded-Encrypted: i=1; AJvYcCWCOUpD6sbpPQYvJdvF+3VKfVIB4AlgqqpTJ7bIW/o25+9X+iOLpqD/r6/LIA1hum/lx7tHyXVyjqPTsHDc@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66eju0lAQ3ZPJHmbrrtYL4majVAwDyLUF/yOi5V+P0zc3UlMa
	IfSdX4sfcjMSSCL3XmpXCijQMgs+rvhywFIdCa7r7BIZreiJ2YPPlwktuA==
X-Google-Smtp-Source: AGHT+IEvVuD2ac0D2az/IB57PEzO4obnZ0CGFPyWLFLo2NOj0LULcHmi0I7hrsRHUjacZtPO8JlcLw==
X-Received: by 2002:a05:690c:c94:b0:672:e49d:430e with SMTP id 00721157ae682-6e2c6ffbcd2mr105868587b3.15.1728326638778;
        Mon, 07 Oct 2024 11:43:58 -0700 (PDT)
Received: from localhost (fwdproxy-nha-112.fbsv.net. [2a03:2880:25ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d926b44esm11402767b3.16.2024.10.07.11.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 11:43:58 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v7 3/3] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Mon,  7 Oct 2024 11:42:58 -0700
Message-ID: <20241007184258.2837492-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241007184258.2837492-1-joannelkoong@gmail.com>
References: <20241007184258.2837492-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce two new sysctls, "default_request_timeout" and
"max_request_timeout". These control how long (in minutes) a server can
take to reply to a request. If the server does not reply by the timeout,
then the connection will be aborted.

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
take an extra FUSE_TIMEOUT_TIMER_FREQ seconds beyond the set max timeout
due to how it's internally implemented.

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
---
 Documentation/admin-guide/sysctl/fs.rst | 27 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 10 +++++++++
 fs/fuse/inode.c                         | 16 +++++++++++++--
 fs/fuse/sysctl.c                        | 20 ++++++++++++++++++
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index fa25d7e718b3..790a34291467 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -342,3 +342,30 @@ filesystems:
 ``/proc/sys/fs/fuse/max_pages_limit`` is a read/write file for
 setting/getting the maximum number of pages that can be used for servicing
 requests in FUSE.
+
+``/proc/sys/fs/fuse/default_request_timeout`` is a read/write file for
+setting/getting the default timeout (in minutes) for a fuse server to
+reply to a kernel-issued request in the event where the server did not
+specify a timeout at mount. If the server set a timeout,
+then default_request_timeout will be ignored.  The default
+"default_request_timeout" is set to 0. 0 indicates a no-op (eg
+requests will not have a default request timeout set if no timeout was
+specified by the server).
+
+``/proc/sys/fs/fuse/max_request_timeout`` is a read/write file for
+setting/getting the maximum timeout (in minutes) for a fuse server to
+reply to a kernel-issued request. A value greater than 0 automatically opts
+the server into a timeout that will be at most "max_request_timeout", even if
+the server did not specify a timeout and default_request_timeout is set to 0.
+If max_request_timeout is greater than 0 and the server set a timeout greater
+than max_request_timeout or default_request_timeout is set to a value greater
+than max_request_timeout, the system will use max_request_timeout as the
+timeout. 0 indicates a no-op (eg requests will not have an upper bound on the
+timeout and if the server did not request a timeout and default_request_timeout
+was not set, there will be no timeout).
+
+Please note that for the timeout options, if the server does not respond to
+the request by the time the timeout elapses, then the connection to the fuse
+server will be aborted. Please also note that the timeouts are not 100%
+precise (eg you may set 10 minutes but the timeout may kick in after 11
+minutes).
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 4c3998c28519..b9f75e23ca17 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -46,6 +46,16 @@
 
 /** Maximum of max_pages received in init_out */
 extern unsigned int fuse_max_pages_limit;
+/*
+ * Default timeout (in minutes) for the server to reply to a request
+ * before the connection is aborted, if no timeout was specified on mount.
+ */
+extern unsigned int fuse_default_req_timeout;
+/*
+ * Max timeout (in minutes) for the server to reply to a request before
+ * the connection is aborted.
+ */
+extern unsigned int fuse_max_req_timeout;
 
 /** List of active connections */
 extern struct list_head fuse_conn_list;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e5c7a214a222..40656f60d7ac 100644
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
@@ -1701,8 +1704,17 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 static void fuse_init_fc_timeout(struct fuse_conn *fc, struct fuse_fs_context *ctx)
 {
-	if (ctx->req_timeout) {
-		if (check_mul_overflow(ctx->req_timeout * 60, HZ, &fc->timeout.req_timeout))
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
+		if (check_mul_overflow(timeout * 60, HZ, &fc->timeout.req_timeout))
 			fc->timeout.req_timeout = U32_MAX;
 		INIT_LIST_HEAD(&fc->timeout.list);
 		spin_lock_init(&fc->timeout.lock);
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
index b272bb333005..e70b5269c16d 100644
--- a/fs/fuse/sysctl.c
+++ b/fs/fuse/sysctl.c
@@ -13,6 +13,8 @@ static struct ctl_table_header *fuse_table_header;
 /* Bound by fuse_init_out max_pages, which is a u16 */
 static unsigned int sysctl_fuse_max_pages_limit = 65535;
 
+static unsigned int sysctl_fuse_max_req_timeout_limit = U16_MAX;
+
 static struct ctl_table fuse_sysctl_table[] = {
 	{
 		.procname	= "max_pages_limit",
@@ -23,6 +25,24 @@ static struct ctl_table fuse_sysctl_table[] = {
 		.extra1		= SYSCTL_ONE,
 		.extra2		= &sysctl_fuse_max_pages_limit,
 	},
+	{
+		.procname	= "default_request_timeout",
+		.data		= &fuse_default_req_timeout,
+		.maxlen		= sizeof(fuse_default_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_max_req_timeout_limit,
+	},
+	{
+		.procname	= "max_request_timeout",
+		.data		= &fuse_max_req_timeout,
+		.maxlen		= sizeof(fuse_max_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1         = SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_max_req_timeout_limit,
+	},
 };
 
 int fuse_sysctl_register(void)
-- 
2.43.5


