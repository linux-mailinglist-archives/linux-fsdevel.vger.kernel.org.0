Return-Path: <linux-fsdevel+bounces-12602-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF06861A3B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07E91C256AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7C140E3E;
	Fri, 23 Feb 2024 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlkukNzF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D8134CCA;
	Fri, 23 Feb 2024 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710159; cv=none; b=uuD9fOXe8U8rn4GZZ1CCk+JjFdXaJVYO1XlPTaqI6lurNwElI0l90GT/nVse+1/qGAl7yweDO7WGDiaXcacee9iN8rXltHMMtKRwMkpcNB1qXluwbeg7kINTCuDFcO3bKBfEA/RQAUU8MtfjFfR13Ph3h6oJr2k33qCOK1rmH+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710159; c=relaxed/simple;
	bh=k/M1Z1IjBAm6hPnaoO3KF5w8PO6H65N7SDu9f4q8Yyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lCaKxVBLXRZOhc8vQ7Jg1j3ouSkhvS/680WIWg9uZyo+d2gzcf9j+GhTbybttf12t4yHfAPvkGZcdD8GIOB11RSAbr08rBevDR/ajVmaaorDLn+JZYi4iT3sETU/skL/dydTCs2hrt6ElVU/tOog6lKDj3iiHlZdPxik8SH9lRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlkukNzF; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c0485fc8b8so732687b6e.3;
        Fri, 23 Feb 2024 09:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710157; x=1709314957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8B3WSC/oB5J5WuE4nqPN1CLkkErOjaE3oAAMcrX2mc=;
        b=mlkukNzFe37zJH1XsixpIgC0kTccfUOxicNqp8cmIYl8L3iy6hGvTCFElisTmkGf1X
         Lt3WfzDg18giGJUKeO+i7spfFcl82v8Hu1FAms1D1DRGHNd2G4osS3WiVC6pqG+1G8C7
         sppSiRBkFurrJHgJy52tYpU/Jq51pbmO6Qf+Sdy0TMpYGxBPCWZ+t9JMhy0qDUkF4ysY
         dIveZXgGgeuQ1mnUXwqCMloUbm1Ki0hhiUFc+KRPAtm2dKNfT/FfEtPqP4NwKgxsXc0R
         hLnX9XvpDDQxZ0erQ6ZLAR/ehIqhgWXsFCKnIwLb9pORs+zXf9hRLUYJfmbTdbMU+pug
         BVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710157; x=1709314957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z8B3WSC/oB5J5WuE4nqPN1CLkkErOjaE3oAAMcrX2mc=;
        b=p0topPIHt7Sgzo78B++IB/Jk72JT9062BVBgzY5+i1Dx78989mQstKqaN0ZvdoiWyc
         JkZ5OTymNp2jdSoxfS6nYjlQ1OAbAr+D4qnBohUP+kli3yvU6OmDZjLXofyQPv8VHeNa
         CsdF7x4nY/CgsZtjiS4whclAx+IFVp/AF9I0Lkd6MPzokcwVclo5Y9ThnxeBkPI9ScAW
         dLhCDuarR62hfOu4+9IfQJkRt33sCfRcaZ4GeZBxlLXnF651aVoexhjLsfzu8Bt7pUOi
         I1mxyQXB3kkq+d5u2FCCnXlg56Un4cpRNwi3ii4vjzLRMgDNwq59SM078PvwtcRaDAy8
         re6w==
X-Forwarded-Encrypted: i=1; AJvYcCUn/vyOB3KxzMfW7Kc2wDWE0moRRNhHnEnHvF9yS+1f4zLZNAYNM2tzwLFp3KUV4Z1opCWKgb0a0xq40Ia/OPH8Dqsjf/92nLUhLtqNK+XG7HHQd5TDm5gy74rjcOkl+a8CsUu0KySD6+llZQiEYFJzdDfDtOf+j1jv0rXTi3yS4pWJn5COPL6t4Fdw4F/aJN7dFrzQ8T1dXpn4D3fH9YyGLA==
X-Gm-Message-State: AOJu0Yx8o+FnLooIMGAMIgvtFf0pU6UakOE9mX4Iip8mb85MGUP5aXNO
	CcnZLM/7cPSkhXhd2QuT+9uumEvNToJQOtPCMmx4so7XVXPElTSt
X-Google-Smtp-Source: AGHT+IEj8V1jRM+L2D+9halnV4FZjeOEtT0OxuoIXcJr1ybp9rMmGgfQ+zJi9Q54i2o5gJWGfNSg3w==
X-Received: by 2002:a05:6871:7805:b0:21e:8cdb:1030 with SMTP id oy5-20020a056871780500b0021e8cdb1030mr638921oac.24.1708710157291;
        Fri, 23 Feb 2024 09:42:37 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:37 -0800 (PST)
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
Subject: [RFC PATCH 07/20] famfs: Add include/linux/famfs_ioctl.h
Date: Fri, 23 Feb 2024 11:41:51 -0600
Message-Id: <b40ca30e4bf689249a8c237909d9a7aaca9861e4.1708709155.git.john@groves.net>
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

Add uapi include file for famfs. The famfs user space uses ioctl on
individual files to pass in mapping information and file size. This
would be hard to do via sysfs or other means, since it's
file-specific.

Signed-off-by: John Groves <john@groves.net>
---
 include/uapi/linux/famfs_ioctl.h | 56 ++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 include/uapi/linux/famfs_ioctl.h

diff --git a/include/uapi/linux/famfs_ioctl.h b/include/uapi/linux/famfs_ioctl.h
new file mode 100644
index 000000000000..6b3e6452d02f
--- /dev/null
+++ b/include/uapi/linux/famfs_ioctl.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, Inc.
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+#ifndef FAMFS_IOCTL_H
+#define FAMFS_IOCTL_H
+
+#include <linux/ioctl.h>
+#include <linux/uuid.h>
+
+#define FAMFS_MAX_EXTENTS 2
+
+enum extent_type {
+	SIMPLE_DAX_EXTENT = 13,
+	INVALID_EXTENT_TYPE,
+};
+
+struct famfs_extent {
+	__u64              offset;
+	__u64              len;
+};
+
+enum famfs_file_type {
+	FAMFS_REG,
+	FAMFS_SUPERBLOCK,
+	FAMFS_LOG,
+};
+
+/**
+ * struct famfs_ioc_map
+ *
+ * This is the metadata that indicates where the memory is for a famfs file
+ */
+struct famfs_ioc_map {
+	enum extent_type          extent_type;
+	enum famfs_file_type      file_type;
+	__u64                     file_size;
+	__u64                     ext_list_count;
+	struct famfs_extent       ext_list[FAMFS_MAX_EXTENTS];
+};
+
+#define FAMFSIOC_MAGIC 'u'
+
+/* famfs file ioctl opcodes */
+#define FAMFSIOC_MAP_CREATE    _IOW(FAMFSIOC_MAGIC, 1, struct famfs_ioc_map)
+#define FAMFSIOC_MAP_GET       _IOR(FAMFSIOC_MAGIC, 2, struct famfs_ioc_map)
+#define FAMFSIOC_MAP_GETEXT    _IOR(FAMFSIOC_MAGIC, 3, struct famfs_extent)
+#define FAMFSIOC_NOP           _IO(FAMFSIOC_MAGIC,  4)
+
+#endif /* FAMFS_IOCTL_H */
-- 
2.43.0


