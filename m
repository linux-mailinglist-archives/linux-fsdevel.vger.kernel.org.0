Return-Path: <linux-fsdevel+bounces-37403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC749F1C1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D0317A047F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB69B1CD2C;
	Sat, 14 Dec 2024 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxnqefhR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB721C36
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143381; cv=none; b=l+sFQ8C/iBY22vfODvsL0ONysWZxdSt0MPjHadIrYNx3u8M+NQCWUeb9xnxi6eD74SybCx/NERxhKlFL0wi1lGquwyLAOOUGFFCeiHEhe//66mVftfKIl0A9YYmEnD29rOVx7NXPoPm0k3zrGFAxyqRBn/l8X8jVdLDyTOLA9sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143381; c=relaxed/simple;
	bh=lRNSMiB/9Fl1NSyos3odsFHpo01K6p3fG7YlyR81ODs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpgroqMlv6DPIQe3U4Y/BbWLCJ5KUL/XPslq1aP5UDpG5D5U8ibQxJ1aLazalqeSmxWwIvEE6mIRdSNjP87RWdxiMF96dQPW5xkKcewhIleTSWZc2aKtyohiRwumVC1PI/21fgll5Hoew2RuJmdK1XdTObRKnSpfJ8qW51Ct7A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxnqefhR; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3983426f80so1563654276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734143378; x=1734748178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJxClIbYoiDmP4Vx6vopU9i/iNYeol7ozMiBYaXiU8I=;
        b=CxnqefhRvc0sSe6C/NK5LC2yv9wsB3fzdiFCqr7seGqSI1tDf16QssCMKpuiLfRHXQ
         MnXh2t+oRkYTJJhRHl3wL9l8gjm9QiZyXB+V01jdTbS9NmE8JvRinCBIq+/3r5m66ceJ
         wFxgbUjCkSNXP+LuIKYF7I16RLilkPfe21g3CKt1pII4+eS/QE95U3eQUemxgFD6JutX
         lq+bmpU6WMkgySuauLWuS6E/dYKf72SpSlpcDm5ed/EYrGV05THP9HoR6povOIV0uETK
         Tcujxzt3ZT/nbVPAuY0ij+31IIjPu9VGumzDTGruwM9LVqpl/iGhb/AyxE939dFOM/V/
         E90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143378; x=1734748178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJxClIbYoiDmP4Vx6vopU9i/iNYeol7ozMiBYaXiU8I=;
        b=i54/yqJK8HSHwEPVXl2SojvkwzRwhivfPaEc9IFn4Ui/oiT81PrGU1eJSZkjPgG7up
         Ol1+YAA/n3+wXIIOGONzEU15EBUcIG7Qm5cnuI+TzASRcYwq1SWuICYDUShamvn9FXVO
         +1+rO3VU885NiW1CdCYGn9Dla5lp2LFqO5MWSgWN7aHR3tlwU8ZjsIdTnbEQR6jTQVwM
         O3evrjjgI4Z6Ziq1+lYnx4jrtdXyKMMGNuPRZYKbot+nn9sGA0ZX3mvmCZ0+g0DLH9O6
         kyrUo3wTNlek6LuhIzr6YCaAq414iGQZ2BMd/EeJMDh14xHdrQ1hFecOgAIWw8Iaqc8M
         evFA==
X-Forwarded-Encrypted: i=1; AJvYcCWVkqUzRe9fbwBmF4A3zYUWG3GEdLFPkT3QU0Cv6PCtmgllldAFfAoHMbm2InlrI3Dfj1OaWW7TweFKEUV0@vger.kernel.org
X-Gm-Message-State: AOJu0YxYIUR4JdzIRhYttwVUnFmVDp0nItBZ6iw2dtZJBs4mxcGu7zBq
	dMvHCfqT0k0vb6ymyIUXr+GrZT5xV5gGgB4OZJh5FtC8FY0EScucnT0l0g==
X-Gm-Gg: ASbGnctD4IWlo5QrLTqlZylfjnMk2f+Q7UE1yGWLUwY3K4/LXbQ6Hq0gvPPS+U/t9Az
	sJmT3mT6Z9ulXt1ZKegDXZJ/leqBYDLxKnuzxT90ELzHpw8jK7oPh7hF4eizZnG8rKQhvs+erJZ
	ODgpsJSW1viIcJO7fJT9u+zd3oQH4LoRjH2NtEfK8xQcfoVZjuc5ENWr8ORqZvmmaMBHnETIYMH
	RwthKBwpDMkS9Cgq/HPiHwzRA3d2hnNqi17QUBulE2QORvYASjMunbDTxJtUxhpC2kN7vSSiIbl
	CYf56UQaGbWD
X-Google-Smtp-Source: AGHT+IEi79Wrc+hsUqLhhb5tn56OdzvgaDnse859JyuHgs59k4vEyfL9Uu32Soe0BIhHw0EIrZHtrg==
X-Received: by 2002:a05:6902:118b:b0:e3a:398f:6720 with SMTP id 3f1490d57ef6-e4350102a4cmr4612595276.38.1734143378358;
        Fri, 13 Dec 2024 18:29:38 -0800 (PST)
Received: from localhost (fwdproxy-nha-000.fbsv.net. [2a03:2880:25ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e470e54d912sm193050276.60.2024.12.13.18.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:29:38 -0800 (PST)
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
Subject: [PATCH v10 2/2] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Fri, 13 Dec 2024 18:28:27 -0800
Message-ID: <20241214022827.1773071-3-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241214022827.1773071-1-joannelkoong@gmail.com>
References: <20241214022827.1773071-1-joannelkoong@gmail.com>
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


