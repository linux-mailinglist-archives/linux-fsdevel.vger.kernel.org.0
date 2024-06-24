Return-Path: <linux-fsdevel+bounces-22253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EB9152E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 17:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21A1E281F96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 15:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373CB19DF45;
	Mon, 24 Jun 2024 15:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Lmd6tAnv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A719D8BC
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244249; cv=none; b=PZq1eZxS0Mc1R+BZi+L8JjAiKp/tav5gt/g/ZBwiRt49b4fqI9wo6KRfd7y2S3B4GzP8ah/hrmSUdnNdZ8CSfWU9w14dLfZhYYsJ3xWBenImoqx6O+Shpu9wTcb9HpWLodSFwgectgsf0PvnLcdm72GXH+6uGe7pI5bMWpt41o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244249; c=relaxed/simple;
	bh=UNoAuN2n5KhnVagp3Pwrk7e62KXgFGLdI/OS8bbvPnI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRXULM2oLhcspsoOp5KFjjETCV6jrKMMnTDAEXZi53+6ecVAIMmfOFqCahj4vvQDVfwZsAHgWimPjXm32kYjC3LrH7NEXtgMVQ2CGPc4ZoexGogM7xUDFmnCP1unJbABygdvVaA4Fu/fsaO6qRNMRHJ1DsArBXeQFpjsxiwkROM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Lmd6tAnv; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4652349276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 08:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719244247; x=1719849047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X08K0+5ubUz+4Dtb/n6m51W7n5tM+ufs3byELYmxH1A=;
        b=Lmd6tAnvQlSaaLdSThQi2sSlJc+tf2rVtZOzGLfyRHlt9BZzOqWVQacK7TMqTQ6AYv
         OfHAS+dxn3r8RzlBlmAfaz1cZNjVcM3pJe6rnjpdPQhXBq6af9CscArkY8v868sVxpOk
         Uq1MeZHipxTr6SQtpjjhnXrgumg6NEqQfzQaPTfNRvP/50P7P9aPdxVoLVsH89s5cpt7
         SG8ZxtVCRlNby6MjrKhwRcoApcekihgusHOXICKuHNLVyyn2VjpJAJGk+JVhynmGydeB
         jh7wPqLtqBiZWAG/BQvUlBGxqkKU6v7whyimHeLbZlDi8sUalZ+jdT3LN5L9l+4cqpJT
         igmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244247; x=1719849047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X08K0+5ubUz+4Dtb/n6m51W7n5tM+ufs3byELYmxH1A=;
        b=etgDPBstJf46dTC1JKvfs31dtFgYLvA9pLLw/yBU7FLnalf8Qi/gezxsUME2OUdR2n
         yi2+lMy3EcsAeMU6Qhyh6Hzv550eZU+SXFQ7RwiQ8ZbZUdRKu6CyAOFXLkmEGzIHG460
         0LhptfdWo36BnqOc3zEaOauRnxG190CNI6bC2LlIvkhE2YWKUIH7XWllbIvCgTe3NOLk
         lpiF6JQsGXi4I0X2fuf63N25Ydhbq0RF12tUyE6ftyujy/VH446s6kKI1SXmEK9Gz9e5
         WgGnNo5UGz5Q1aIeYxFEid01+1LgL87ce2eKV027p7EfKiK4+6o4z9EOTM/MmW9dSpoz
         LvVA==
X-Gm-Message-State: AOJu0YzFmMYLOULBW0gD4nmHpe+htKpZUiH6u+DFmTZsJZ3mLoVCBg8x
	muigCU+YG6PB7mUEilP+d7dMAA0s1sPW4TM+57I9w0ReB1t4HtC+dQ6W+6dp5dgKCRxHuFj86T2
	R
X-Google-Smtp-Source: AGHT+IGGDpNMWAqjctL7iQDQzsUjtxHg2UtzjpHu2kOO+8ymSyyqZQkqGrzwLsMAmWrMYfFWvbwPmA==
X-Received: by 2002:a25:a503:0:b0:dfe:73d8:4593 with SMTP id 3f1490d57ef6-e02fc34f307mr5325972276.48.1719244247035;
        Mon, 24 Jun 2024 08:50:47 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e02e6116e09sm3291522276.11.2024.06.24.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 08:50:46 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	brauner@kernel.org,
	kernel-team@fb.com
Subject: [PATCH 7/8] fs: add an ioctl to get the mnt ns id from nsfs
Date: Mon, 24 Jun 2024 11:49:50 -0400
Message-ID: <180449959d5a756af7306d6bda55f41b9d53e3cb.1719243756.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to utilize the listmount() and statmount() extensions that
allow us to call them on different namespaces we need a way to get the
mnt namespace id from user space.  Add an ioctl to nsfs that will allow
us to extract the mnt namespace id in order to make these new extensions
usable.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/nsfs.c                 | 14 ++++++++++++++
 include/uapi/linux/nsfs.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 07e22a15ef02..af352dadffe1 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -12,6 +12,7 @@
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
 
+#include "mount.h"
 #include "internal.h"
 
 static struct vfsmount *nsfs_mnt;
@@ -143,6 +144,19 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		argp = (uid_t __user *) arg;
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
+	case NS_GET_MNTNS_ID: {
+		struct mnt_namespace *mnt_ns;
+		__u64 __user *idp;
+		__u64 id;
+
+		if (ns->ops->type != CLONE_NEWNS)
+			return -EINVAL;
+
+		mnt_ns = container_of(ns, struct mnt_namespace, ns);
+		idp = (__u64 __user *)arg;
+		id = mnt_ns->seq;
+		return put_user(id, idp);
+	}
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a0c8552b64ee..56e8b1639b98 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -15,5 +15,7 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Get the id for a mount namespace */
+#define NS_GET_MNTNS_ID		_IO(NSIO, 0x5)
 
 #endif /* __LINUX_NSFS_H */
-- 
2.43.0


