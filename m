Return-Path: <linux-fsdevel+bounces-12604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DC7861A48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 009361F276E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC43142631;
	Fri, 23 Feb 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVhNsN97"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EC61420B7;
	Fri, 23 Feb 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710166; cv=none; b=MERb+r7lOLrf9VHQp6XUC2ALygQ4U8HiQ21Hte6EtgXBp0x50QQaLs4DjS/9kJUf+z7PuRbe336vVxDFZLDGIKIC3MsngUk6WVMg/kELWEJ+TCiFyg8EQguQxciAWsIz8nuGal6tbmGSXH2LErXqyIpu0VCcYGvB9fuglQutmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710166; c=relaxed/simple;
	bh=S1dC3s+Bdbdiu4CM5vBZY74+9xIlFu6uaw2o1TRdOz4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TS6UxjzySeHdi6vIUDl5CvPHhOUDAIiTw9xvnf/ay2odGfSy/fFGMC24t29/GchOsAZnqPZCH3PN6VPK89/ktFxSwZZKKxup7fjWv6AlEeXhR0KovEOCFTEpHarwHrcVrK2YJ/aTRwkt3TqsQdvCPQcGjBc9mo8MnB6R6z2LfbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVhNsN97; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e48153c13aso376309a34.3;
        Fri, 23 Feb 2024 09:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710163; x=1709314963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLMqFBWl5LhzqIjuwu8LKub75LEQmCe/d881zRdnRFA=;
        b=gVhNsN97llH4yH8WHCGFnWphxLofXGQHtAtKFUk56jAzoonI9IuVOSz1Yn+PTowWdy
         wncfx5eTfxymR8tpynaNptRfY+PG6uXf6VD7/UJlebI3WPAzWvfYVMLua0VFJjcMOZL2
         HOiWimTrGAhOnIHrkG35L1I9eQoTf0RLjJK5KHkrqzm41vQeUPITmGI0W3AvnEChvyEN
         ley+0Mkhp77QrCv/P1xYTZnLqwQrSvUPGH60uw/Vh8gsfEOIs4Ee+mChNOB+hCS5kuIY
         oQipNq3dfxwUoXugTMSyKCvjoWG/zZ6cPUvztQG+FSY69Jka2dAlHUfHIr42kI8SbQqs
         3Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710163; x=1709314963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLMqFBWl5LhzqIjuwu8LKub75LEQmCe/d881zRdnRFA=;
        b=mQDpu1fv1SWNVmwltJZ5Nxyf9XLdjmY9CrvhCa3P7uBxz3CRSQXxR818DMNVbtT2E5
         oBwhhTWjW6z25VbPG8Jd/61xn1TiVZ547gRGYEJzNttjpSdP3E4MbVy9exe22P2IU2Oi
         t2PwGS8us7sLSSS+by3gNfMTCiPvdqwOrUIKm0B8YQCJUH1YF1d8cJL2NowBm3GuJsF+
         TkrJWfMzxwVWTmyxwSsFp/1ObzSkchFNYgh/9DR+MagWxDfZyBsWK3va4uY7y6EXw8o5
         o9a+kD/GBlY75urgX1VFspIykZWYjIEWE2B/YJ0RKs3v0/6HURu1VUnlKT7pmiGM0qJ3
         eiHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfvyZKI76QCY0BHd2aUMjclqJAMvgQjvHDK67Dsfec/huVJ+GqFycnI/OhBZSBUpceCZrMgVCnac5qJzFigUOff/BOOtPNT5wLf1vFbAP0JzDU4ku+lYWOW0Bph0KRkwG6pM5d6qdaMm/nch9EXfonS9IZvHO4wKlEO+yzHXeMgR4pfLtT4NySq4X9XZblvD3NRM05v56ggpvXvd4Z5R/mQw==
X-Gm-Message-State: AOJu0Yx0pVZRJ1HveKrTCb07u5iU+cs/Z74KSC/gzyIGqld0A76pF/gf
	1zJBNxMLY7/90QgMqgBrYH2ifaeWB6gkhO4GplSvjmMEu9WS4Tsg
X-Google-Smtp-Source: AGHT+IH367Vw2L7iZdROKuLaJXvWJMZ5u7D0rUCk0PqnXp7KzR8fKSXYm9C614LmvLpJXYiq76cSvQ==
X-Received: by 2002:a05:6870:55cd:b0:21e:e81e:36ef with SMTP id qk13-20020a05687055cd00b0021ee81e36efmr552160oac.36.1708710163445;
        Fri, 23 Feb 2024 09:42:43 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:43 -0800 (PST)
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
Subject: [RFC PATCH 09/20] famfs: Add super_operations
Date: Fri, 23 Feb 2024 11:41:53 -0600
Message-Id: <537f836056c141ae093c42b9623d20de919083b1.1708709155.git.john@groves.net>
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

Introduce the famfs superblock operations

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_inode.c | 72 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 fs/famfs/famfs_inode.c

diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
new file mode 100644
index 000000000000..3329aff000d1
--- /dev/null
+++ b/fs/famfs/famfs_inode.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * famfs - dax file system for shared fabric-attached memory
+ *
+ * Copyright 2023-2024 Micron Technology, inc
+ *
+ * This file system, originally based on ramfs the dax support from xfs,
+ * is intended to allow multiple host systems to mount a common file system
+ * view of dax files that map to shared memory.
+ */
+
+#include <linux/fs.h>
+#include <linux/pagemap.h>
+#include <linux/highmem.h>
+#include <linux/time.h>
+#include <linux/init.h>
+#include <linux/string.h>
+#include <linux/backing-dev.h>
+#include <linux/sched.h>
+#include <linux/parser.h>
+#include <linux/magic.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/seq_file.h>
+#include <linux/dax.h>
+#include <linux/hugetlb.h>
+#include <linux/uio.h>
+#include <linux/iomap.h>
+#include <linux/path.h>
+#include <linux/namei.h>
+#include <linux/pfn_t.h>
+#include <linux/blkdev.h>
+
+#include "famfs_internal.h"
+
+#define FAMFS_DEFAULT_MODE	0755
+
+static const struct super_operations famfs_ops;
+static const struct inode_operations famfs_file_inode_operations;
+static const struct inode_operations famfs_dir_inode_operations;
+
+/**********************************************************************************
+ * famfs super_operations
+ *
+ * TODO: implement a famfs_statfs() that shows size, free and available space, etc.
+ */
+
+/**
+ * famfs_show_options() - Display the mount options in /proc/mounts.
+ */
+static int famfs_show_options(
+	struct seq_file *m,
+	struct dentry   *root)
+{
+	struct famfs_fs_info *fsi = root->d_sb->s_fs_info;
+
+	if (fsi->mount_opts.mode != FAMFS_DEFAULT_MODE)
+		seq_printf(m, ",mode=%o", fsi->mount_opts.mode);
+
+	return 0;
+}
+
+static const struct super_operations famfs_ops = {
+	.statfs		= simple_statfs,
+	.drop_inode	= generic_delete_inode,
+	.show_options	= famfs_show_options,
+};
+
+
+MODULE_LICENSE("GPL");
-- 
2.43.0


