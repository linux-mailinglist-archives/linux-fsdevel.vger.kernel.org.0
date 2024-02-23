Return-Path: <linux-fsdevel+bounces-12603-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB94F861A43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589B11F276AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE947139575;
	Fri, 23 Feb 2024 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9DbGu/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A287C140E5C;
	Fri, 23 Feb 2024 17:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710163; cv=none; b=Xph9suXFw6voPqUqtbJOpgyFyWQXBEocTxjl3Wzhg0tobBhg8y45NEzJyx9ogFcpS6Z9sw1zTu12nwrDL++Yfm5Qci9Q6Fq65q+Nc2VsGAhvItWg5Ns3NC22ofPsxQDaBS7KUx9J6VmLHUXZUxtxr5+JJvzViIbxIE5mdHC9sPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710163; c=relaxed/simple;
	bh=nLyr4TWhalrsSTbLBLYPk/fSOipP3b9UOzjhAi8tqKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nwTcn6YiHy6jN618bJXo+3MeHN/dhQAbfAuKXj8A3l0dfl2FKr5OPQSP1WLlnGu5xNEpkbrAOdY3fkyZSSilZrXSaC6uDVzhlXvQVjEjBk5lrH5AETYw3ScU0tZyMNBjSytq/bVEZOjPZFvzjA3oWg8GR97bXU8L18tiVnrZqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9DbGu/t; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-21f5ab945e9so475953fac.0;
        Fri, 23 Feb 2024 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710160; x=1709314960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxhluQ29UqTfdm4fCVn38u2knnwILBZPsWmaO804tyk=;
        b=W9DbGu/tbMxbUQA2KRGjXS1SVzTHby5ZFaJWANvV29fy0gqQhwrNjX8GO0zdNRsXLP
         4s7G+KJ84yC80cpcz66wdDAaErlwN4oT06sRWyh1qXZtqJpYl0aHdsKWt/zDDyRXrX+O
         1A/hgTe0gpylhcBXFud8I+QQG6ZXdGA4QGUFKADgvXa7M1jqpAZGUv5+JsXom/H3C/+m
         hLWalNHeN8QYn6wo92XKCwJcvbCUw7VqmW7ZWBvchRYlvOpg1blMMSG6ewsKMkHKvFwW
         v1qzsfROKodaWyqUDPzN+mulAs0tCkPV0naIJKEqHZnuEf28iCNwBZHO7Oy7V/ScAqS1
         pjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710160; x=1709314960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DxhluQ29UqTfdm4fCVn38u2knnwILBZPsWmaO804tyk=;
        b=sdKh2EzV5IOTAhJkb+6jbFtO63sF2UN1i37zm97BbN7JoGbWl8jePPljJYHf8YR4ID
         aar0PC2m0hV0IwF7O5rJ+1avJnnuSnND7JeGuDvdOp0v7yz+ZA5/PQjZ29Q+Cp4knk13
         fUbHF5yUpa9gm/V/8cO5GmpQ3ZxwMrYbYKSaYKpVozj3zZa6ouP57eK2pvzndek/N1+f
         80zm4oyxBaClMR1V629TUOZO1t3vX/m6tY1F1BtsqngkOmijW8bv/ikHs6jtMBS+HG93
         ouyG1V8Bht+uqAwNN/9gIn5HTu3BRABaBSxSd4pbMRZ/SfrxO3XKP3YTOtGuB42e4r63
         yvrw==
X-Forwarded-Encrypted: i=1; AJvYcCWrvD2hIVs1rJC9B6Nw32RashM7rP+dlqAx3zsdXltun5tLIbGTz9HFPDgRd0IZVjDH71nZ7QeeE5odFcAhmVOYx6kYfWCKjWswlINL+/4r1j2kC7dCNEMomyyvg3dqxPqgvmY4FZ8CSJlNdRLLjXRkhKLZ+U2ALt00xNjk1hqEbdoNyi0qeVy8+7P7IXEHe0dBdJdceGF+MOfNzpoa7jM9Sw==
X-Gm-Message-State: AOJu0Yy+TfUZpV1aNtctV5ru160CGCNGL2qGCC6iR5VGGzyonvGNhTCz
	LtKdLfY3w3XPhoHuJSs+xw14ab7V4D/Lu5R5NFgMH6EPh0CSHb7x
X-Google-Smtp-Source: AGHT+IG3mwMd0pVehrQmhoVUcYCZorVKFr87H6SZPXCfzXGnZuw6mwbcqWG+G90doupdIHyrTEyd5A==
X-Received: by 2002:a05:6870:61cd:b0:21f:c2a4:6fe7 with SMTP id b13-20020a05687061cd00b0021fc2a46fe7mr230781oah.28.1708710160647;
        Fri, 23 Feb 2024 09:42:40 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:40 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John@Groves.net,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	John Groves <john@groves.net>
Subject: [RFC PATCH 08/20] famfs: Add famfs_internal.h
Date: Fri, 23 Feb 2024 11:41:52 -0600
Message-Id: <13556dbbd8d0f51bc31e3bdec796283fe85c6baf.1708709155.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <cover.1708709155.git.john@groves.net>
References: <cover.1708709155.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the famfs_internal.h include file. This contains internal data
structures such as the per-file metadata structure (famfs_file_meta)
and extent formats.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_internal.h | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 fs/famfs/famfs_internal.h

diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
new file mode 100644
index 000000000000..af3990d43305
--- /dev/null
+++ b/fs/famfs/famfs_internal.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+#ifndef FAMFS_INTERNAL_H
+#define FAMFS_INTERNAL_H
+
+#include <linux/atomic.h>
+#include <linux/famfs_ioctl.h>
+
+#define FAMFS_MAGIC 0x87b282ff
+
+#define FAMFS_BLKDEV_MODE (FMODE_READ|FMODE_WRITE)
+
+extern const struct file_operations      famfs_file_operations;
+
+/*
+ * Each famfs dax file has this hanging from its inode->i_private.
+ */
+struct famfs_file_meta {
+	int                   error;
+	enum famfs_file_type  file_type;
+	size_t                file_size;
+	enum extent_type      tfs_extent_type;
+	size_t                tfs_extent_ct;
+	struct famfs_extent   tfs_extents[];  /* flexible array */
+};
+
+struct famfs_mount_opts {
+	umode_t mode;
+};
+
+extern const struct iomap_ops             famfs_iomap_ops;
+extern const struct vm_operations_struct  famfs_file_vm_ops;
+
+#define ROOTDEV_STRLEN 80
+
+struct famfs_fs_info {
+	struct famfs_mount_opts  mount_opts;
+	struct file             *dax_filp;
+	struct dax_device       *dax_devp;
+	struct bdev_handle      *bdev_handle;
+	struct list_head         fsi_list;
+	char                    *rootdev;
+};
+
+#endif /* FAMFS_INTERNAL_H */
-- 
2.43.0


