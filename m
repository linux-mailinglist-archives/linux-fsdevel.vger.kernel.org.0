Return-Path: <linux-fsdevel+bounces-34841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EA29C9250
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 20:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17960B2D17E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 19:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1937E1ABECA;
	Thu, 14 Nov 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9TE25O5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B81ABEBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731611637; cv=none; b=GK/Y49hF7KcDlo/gdl/z6FrebrLFtgK6ualaQTeyvkKA5TYEkrWf47ZadhxUG0W3xjpRrjkWb9P571WxCIRuZp0EQZ8DlJDl9N0UpTd/pOj41f/4jXIWKm6do2kzhwD2hSg9Hwnulg7QbWf/bDT0hj08jgIHi7T7rR/VrUZElTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731611637; c=relaxed/simple;
	bh=yGjq2THbmv9V+Y9hO2p8tlo7MFsMcJM2+0aeHs/zKWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhDyyN8sJoICpc0SIsCWlAdhq0cQuOP1OuQ7IPamCTLfeUksfs+845V2kLOgtES8rdbsvpBKB4IYoF06nXuKd06d2Ifw/I312Datxfv7h0cWjlFhdPRBISJ08lxyurcsGnfyO9Ch52xJukI/5SDaRU8/9F+gBqPm15+Vh1Tvsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9TE25O5; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6ea7c9227bfso11514487b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731611635; x=1732216435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAQF0WkcxGB4AMW/MmznpwNgMYPbmkZ5lpmeYrrfBhA=;
        b=K9TE25O5DEyMz5pfePhlFEo8hgvyEoSXfoabyDICyRvELSJA8pMq5Ri51HSruhi8/h
         kibipoj9DQ/ihUWbXn7dO7PHlOK1gCgRQDYtlC2l2KsRu6evPX/YUldKNgzYyIrm+WX8
         dgwNgAtEMhb555Lt6tZmXyyAhKNtuaImp/P/9lqM+DdXMVdSD72/2cHbrHx0BKAoLqIk
         C9xspu0AJr574UlxX2HQEyBX70PYTmcXNwy53SeByg3diiSjv4FSdaJZh1TnerdslVqA
         E7Zt79zQouOsxRsgUPacPfaGkGtYz43AUw9AeywEUmBTB9dQbN8GbNhVCa8oRtCma2Kd
         trJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731611635; x=1732216435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SAQF0WkcxGB4AMW/MmznpwNgMYPbmkZ5lpmeYrrfBhA=;
        b=ZI+cl6D8fMQPT4Q8ZnRSL+YsItX8tsl2h2TP059788Zx+kwKGTdVsFvSiiuFMQwk5f
         Qw1t9m2hxvVyiA/JeHVg4acaVp5ocW9NEjN5nIDlA3aU858lBNevAXzqo0fsD9nrDkno
         KFC56/mMV51OKz+GUJTFTVmyXzfXu7wz7FFwAzkBhcUKDoV+kg2S8olKcMlJVhqOMmlj
         6oPQ1b+oWtceoXnpF9ecTinMLxjFcjl+GlEq5NK442qBk3pF5Dtlj18gu8uKI4yhgXHW
         LHCA1iuLVQKLicGMB0uM6/9x+f10Db+/qRAgqnsynK2jkQbsnIKVpW2h9DmDgsHtFqMf
         IQdA==
X-Forwarded-Encrypted: i=1; AJvYcCW/d+7BhHEZL/vJdyxI2jOpQBHYl1dU4285LPPUuEL6gg977CKTLTF9djFAUb09oKSMvgyHSuO9OvrJkwOz@vger.kernel.org
X-Gm-Message-State: AOJu0YwRf9y0r0IY0R71IKs/1Joo7JU/AbOsKGpPMK8jnaDlbQfEvp0q
	9TltjQ4K9nFqYlM8/3ZCkdkVpwdJFw8Y4Q64ulcnewPN3Z8fZT/u
X-Google-Smtp-Source: AGHT+IGiKOemj4DhFvPKGQlPs9pOnNjxhkgQPv56vNm1ewN/4uPArYUPGy8/+kQYNaPZWv8m4qrzUg==
X-Received: by 2002:a05:690c:6207:b0:6ea:84e9:15fb with SMTP id 00721157ae682-6ee55c263e8mr459787b3.24.1731611634614;
        Thu, 14 Nov 2024 11:13:54 -0800 (PST)
Received: from localhost (fwdproxy-nha-014.fbsv.net. [2a03:2880:25ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee444124e2sm3783077b3.85.2024.11.14.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 11:13:54 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	kernel-team@meta.com,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH RESEND v9 3/3] fuse: add default_request_timeout and max_request_timeout sysctls
Date: Thu, 14 Nov 2024 11:13:32 -0800
Message-ID: <20241114191332.669127-4-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241114191332.669127-1-joannelkoong@gmail.com>
References: <20241114191332.669127-1-joannelkoong@gmail.com>
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
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
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
index 9092201c4e0b..e82ddff8d752 100644
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
index ee006f09cd04..1e7cc6509e42 100644
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
 			fc->timeout.req_timeout = ULONG_MAX;
 		timer_setup(&fc->timeout.timer, fuse_check_timeout, 0);
 		mod_timer(&fc->timeout.timer, jiffies + FUSE_TIMEOUT_TIMER_FREQ);
diff --git a/fs/fuse/sysctl.c b/fs/fuse/sysctl.c
index b272bb333005..6a9094e17950 100644
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
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_max_req_timeout_limit,
+	},
+	{
+		.procname	= "max_request_timeout",
+		.data		= &fuse_max_req_timeout,
+		.maxlen		= sizeof(fuse_max_req_timeout),
+		.mode		= 0644,
+		.proc_handler	= proc_douintvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &sysctl_fuse_max_req_timeout_limit,
+	},
 };
 
 int fuse_sysctl_register(void)
-- 
2.43.5


