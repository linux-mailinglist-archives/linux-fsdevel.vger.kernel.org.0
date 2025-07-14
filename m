Return-Path: <linux-fsdevel+bounces-54807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E80B03781
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 09:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C65175BD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B076622E3FA;
	Mon, 14 Jul 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyJRr3Io"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B4A2AD11;
	Mon, 14 Jul 2025 07:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476669; cv=none; b=Ko50zKc5VJU75/r3Cuuq/TKwrvsFDqWlMBaabpwiX28ktEzeXiFSBlc9WYQdbCLVg1sfKmqYp1u6LxrtKcH/GgL6L8aEWcyS2YBqfOC1AlQPeBAafaRjpWY00mZxNieIxJXYgTCP0igx1/9zRu0b9QlyaJ10Y2GImFnvwgxsA6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476669; c=relaxed/simple;
	bh=S+d+uDOVmZMeGwAb3G8dI6hH7XghKaZlr8ojUnkqvQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kV3vNMR4VANVXtF0DfUa0uMD5ZS8cRtfoKH3PMefktjKPHRGtbVBkHKAvnf3cj/OVOySLL8Px0fvV6Pa/qCH020rejoSr6pUpfb1if9KN4tNFmcusorXtDUpQQ6Dbm4Gx3PO50MatfszYph29PJdWy2W+anca/4+KIXVVzzWQ7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyJRr3Io; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-748d982e92cso2493541b3a.1;
        Mon, 14 Jul 2025 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752476667; x=1753081467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXySA/F3TyrII8A8Wc+3P9gLDgYeryVPrBWtmOEb9+c=;
        b=SyJRr3Io9NXTPLeJPE+ufaIR2YXFh40YhtWD13NN4WuPxSoWAIRDhaWKygplZ8EXC7
         RkxY4UMtXv1JQgUCijGQ+ra5GBKoJXLbVYDW86HSkpS+YTXu8UoilU31JgSDmspOW73m
         PDfYLgWt3eYb1WazBE9c5yTdmuhB1UZdjA6ZOArDi6KBtXeXHEqv10XDS+OM8lKtmwMo
         gxXYKFr40qPlJHHhXgluR/fby6y3HzBNd9/eEkYoTKzVMqtePmHs3mHxAluXmT42xtI/
         4nev5jTPzIVkokxUEI2uKJzfhm7Uvz7WU6D0nJNOI+3XtUI6RFYuCNdbJsuYBF9Nx1ke
         U3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476667; x=1753081467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXySA/F3TyrII8A8Wc+3P9gLDgYeryVPrBWtmOEb9+c=;
        b=H9gsT7IUxkaQ/xO8vi9puKwMAXdXgmrmgWVZirDmh+Y7epYlH93OEeKGrqU/NZ/kY1
         trMXhASI7tazUAgepWF15ePEc5HD/laIdKxTBubaNh58BWmBrmi3iKoCyLLCARjMPUEQ
         91Ba9Hv0ckA4illE/H/3gHrOre27wwUJJMJf4KNwkeYPkCm+90TmfxF+wtsqY7l9RUVj
         yysKJZLgaD+AFruXQ5gYgzmkd3XoSGBZwGM7UJdvoqPvY/3JGKGSQhW5ZTtiKmeyy4tO
         6NfEA/vU+cRzZDwCZN+nMAP0/9r6GRFskt2a7Hrp3EUDQFjvgqUy7Vnhb1d7YMR4iVPD
         C4vw==
X-Gm-Message-State: AOJu0YyRuAqwvdO5rVA4D3pCb/oKVj+iEJ+EgK4LmmeTi6m6BjmVDmqo
	dxsg0GJYYeGaLK0lzsF4C05qjRkEAXKPSCrH/tYDqkLRrbl3vRc3sKfzzPb9NVbN
X-Gm-Gg: ASbGncs85y4VX5DQUG72Si/ncB9W27stmPt2OCuTR8w2ettZD20BMqRm7cmm7BCnyQr
	iCbEwsf5cx/pm+m2sGyaoiwz6S2Tl2IfyJ19HF7k3TNHbGjydDXXt9syCubeXf0zuHykFsT2eN4
	dJUoyvfldq4FUuxp1JeZSe2dHLmy6mxknld/m2A+EPJVXXO/M0DxEGx9AD8hgJDNgmAW/PXpVUc
	WDSiJenySXpQTwKFImdYk3D8EC10tQuPLQwY185gx7zV8fPnS75wuXVAiIOeqXRQ+Q5g6V9jH4l
	1yGxJ06QxNuoXkoGRM6wmgBlERIUK7U2za082HICxhu2hk6imO4Y3fCt+O482DGdZPBUs+/GDUr
	tI8llTHvaCjt6PrR7F49e8DWEG8HqGqkF8OyBVt/nPbyoewp4dZiK9WZFkFcqSIsMw3V3
X-Google-Smtp-Source: AGHT+IGq8vrmOng+X1/5gThNMlUcVO0qTpfTQHbvHaFS8/ljmJLHwIagTjIijz1Xj31UAeWHUIAxvQ==
X-Received: by 2002:a05:6a00:3928:b0:736:4e67:d631 with SMTP id d2e1a72fcca58-74ee333d0cdmr16915181b3a.23.1752476666451;
        Mon, 14 Jul 2025 00:04:26 -0700 (PDT)
Received: from oslab.amer.dell.com.oslab.amer.dell.com ([132.237.156.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f46a57sm9216003b3a.112.2025.07.14.00.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 00:04:26 -0700 (PDT)
From: Prabhakar Pujeri <prabhakar.pujeri@gmail.com>
X-Google-Original-From: Prabhakar Pujeri <prabhakar.pujeri@dell.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	prabhakar.pujeri@gmail.com,
	Prabhakar Pujeri <prabhakar.pujeri@dell.com>
Subject: [PATCH] fs: warn on mount propagation in unprivileged user namespaces
Date: Mon, 14 Jul 2025 03:05:56 -0400
Message-ID: <20250714070556.343824-1-prabhakar.pujeri@dell.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mount propagation operations in unprivileged user namespaces can bypass isolation. Add a pr_warn_once warning in mount(2) and mount_setattr(2) when MS_SHARED, MS_SLAVE, or MS_UNBINDABLE propagation flags are used without CAP_SYS_ADMIN. Document the warning in sharedsubtree.rst with an explanation why it is emitted and how to avoid it.
---
 Documentation/filesystems/sharedsubtree.rst | 13 ++++++++++++-
 fs/namespace.c                              | 17 +++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/sharedsubtree.rst b/Documentation/filesystems/sharedsubtree.rst
index 1cf56489ed48..714f2ac1cdda 100644
--- a/Documentation/filesystems/sharedsubtree.rst
+++ b/Documentation/filesystems/sharedsubtree.rst
@@ -717,7 +717,18 @@ replicas continue to be exactly same.
 
 			mkdir -p /tmp/m1
 
-			mount --rbind /root /tmp/m1
+		mount --rbind /root /tmp/m1
+
+	Q4. Why do I sometimes see a kernel warning when using --make-shared,
+	    --make-slave, or --make-unbindable in an unprivileged user namespace?
+
+	    In an unprivileged user namespace (where CAP_SYS_ADMIN is not held),
+	    mount propagation operations can inadvertently bypass namespace
+	    isolation by sharing mount events with other namespaces. To help
+	    prevent subtle security or isolation issues, the kernel emits a
+	    one-time warning (pr_warn_once) when it detects propagation flags
+	    in such contexts. Avoid propagation flags or perform mounts in a
+	    properly privileged namespace to suppress this warning.
 
 		      the new tree now looks like this::
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 54c59e091919..e2f3911c2878 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4447,6 +4447,15 @@ SYSCALL_DEFINE5(mount, char __user *, dev_name, char __user *, dir_name,
 	if (IS_ERR(options))
 		goto out_data;
 
+	/*
+	 * Warn when using mount propagation flags in an unprivileged user namespace.
+	 * Propagation operations in an unprivileged namespace can bypass isolation.
+	 */
+	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN) &&
+	    (flags & (MS_SHARED | MS_SLAVE | MS_UNBINDABLE))) {
+		pr_warn_once("mount: unprivileged mount propagation may bypass namespace isolation\n");
+	}
+
 	ret = do_mount(kernel_dev, dir_name, kernel_type, flags, options);
 
 	kfree(options);
@@ -5275,6 +5284,14 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	if (err <= 0)
 		return err;
 
+	/*
+	 * Warn when changing mount propagation in an unprivileged user namespace.
+	 */
+	if (!ns_capable(current_user_ns(), CAP_SYS_ADMIN) &&
+	    (kattr.propagation & MOUNT_SETATTR_PROPAGATION_FLAGS)) {
+		pr_warn_once("mount: unprivileged mount propagation may bypass namespace isolation\n");
+	}
+
 	err = user_path_at(dfd, path, kattr.lookup_flags, &target);
 	if (!err) {
 		err = do_mount_setattr(&target, &kattr);
-- 
2.49.0


