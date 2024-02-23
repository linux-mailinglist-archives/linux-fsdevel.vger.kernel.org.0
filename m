Return-Path: <linux-fsdevel+bounces-12612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918B861A69
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8F81C2167D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9A11487CD;
	Fri, 23 Feb 2024 17:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdHUXzDV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E424146E93;
	Fri, 23 Feb 2024 17:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710188; cv=none; b=Oifi9VWst+AeuKyHA0CkeiI9s6d9UDP0VJlfcPhvCa+3anBfFaAP8KhVT1r+2dXEpGzcN8EOIp7y0cK/kWc4F/LpCt6YGtghF2inaSJ7l4iCKxJNwKtc4Rvn7rWI0XMPQpWEqRHk7+c+08zKfOIEVhIFwPsvGQ5/0oUlBm2m+II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710188; c=relaxed/simple;
	bh=yRp5u9MQR7i0pHHhigFRLMC5jxEA/cmL4WRIc6/6wyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hvrwlirk9sQ8nMFNADXm5ZfrNc3pXGU4OqdQgMP+Spi3dgj+sXt4DiVck3MneobCWFUUqunfG29I4Elka2zVB3Z3jXlSJ2cw3ne7BDiOpOAeTE+6VvauW9QLRlpIvRwtguKGVdu5/6+CylgH7dS8bNGGrbiJplT8qeDKIpm3d1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdHUXzDV; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-21e45ece781so686304fac.0;
        Fri, 23 Feb 2024 09:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710186; x=1709314986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHor3u3W+wuqia7Ht/WsFpCY9Rk+dRiHPG2C9ZesKqY=;
        b=mdHUXzDVJCiDjqYn0nPSeSTXTyhjUwBe9aEeIMkJVkGkRilnZ0qN4sYDIv+3y1LqNA
         UOES1l4aodgvqhBioTL4WImbTLyrZJ7almah4vP8g9lenuDGQP9AOZuj8Y8zF92FHJSE
         gJR20WV0WWEsGMahZaPisf33Wsr+B31CGGM0OfJE4XYAAi+34Ht8kBWk9LT4TMPpKdQT
         RB+8NMrbCLqQqxzVrXmdBn2hRDpESICgh4im4Mcjeu0DJKgZQgnl6qQuT0XGNWtXQYPe
         GM6s1ut0bV8K6M1k8YQzc/FT1+MESEkf2GJAGaJk+8cqcEIn/sps3M33xzRs953un2IK
         q5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710186; x=1709314986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OHor3u3W+wuqia7Ht/WsFpCY9Rk+dRiHPG2C9ZesKqY=;
        b=VKVZnYnIKj+OQ9cIcTdRAtIBg0DzVz0Pktgq0aMKOM+qhgwfuk8LUwPgQgE6GxMtTE
         R2Dm/h9WWgrv5Nto+KV8tkgPaTqSdS2FQXaVKj3GkWQi5J/ajgo3VTQFGXj1mZ2+H93K
         a3FjEvTOQj2o/9F3r/XfmEoRWLZqP7VyLACPNKcadZdw5MLzmKL7rrwcvmKRVUoDwnyD
         E+qQhFk3uXB/1RmqfAYTatHUcjCWHy07tNSQ3HSsMAkfqSEglcO9Xt/2bCmavZCpbSki
         QeBZA5/UI/wSsJ57/hf2BR0XGY1jtHmkF+XJIGIDW8JWzNvV4Q4Ic5nx7MDg0KPFMm13
         y+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWYzS8kQmLIeMM4+GtluWcl9BRq4cESm+noeV2iSrAAgD2Izq0U8ItX1ixNSZL41p6MPOBw3SVaTzBC0PqR+zbZGKxRuSUfDQAmbqSQ+/8Njt2VqVi0dlH4vy978kzxSmYa9Z+FuDM5kFTJFwOQDpSCxUFTmGv78Ny1F9VV+9ZIlmVbnn/jB00kK5F5oEt8JPvP9CXA8EinkiG+Lw+Rz2e22w==
X-Gm-Message-State: AOJu0YxwznGYU0GLLQFYnUNX7vYvw4Tfbbn8O/5p3/VQK67pcwYeJnY1
	wVh4FOFWVQo93OpjqO9134TwqdJGaM7q79PzsVrqXk8Nu8/UK4vW
X-Google-Smtp-Source: AGHT+IHNnKVpb62Lo5a6C8MsXucHX7a5scGCwnDEKNG9/0OIPbmHNqpRkF5qcIHHDdwtWWcx7RJCLQ==
X-Received: by 2002:a05:6870:d109:b0:21e:e9bd:afa9 with SMTP id e9-20020a056870d10900b0021ee9bdafa9mr558439oac.21.1708710185753;
        Fri, 23 Feb 2024 09:43:05 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.43.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:05 -0800 (PST)
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
Subject: [RFC PATCH 17/20] famfs: Add module stuff
Date: Fri, 23 Feb 2024 11:42:01 -0600
Message-Id: <e633fb92d3c20ba446e60c2c161cf07074aef374.1708709155.git.john@groves.net>
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

This commit introduces the module init and exit machinery for famfs.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_inode.c | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
index ab46ec50b70d..0d659820e8ff 100644
--- a/fs/famfs/famfs_inode.c
+++ b/fs/famfs/famfs_inode.c
@@ -462,4 +462,48 @@ static struct file_system_type famfs_fs_type = {
 	.fs_flags	  = FS_USERNS_MOUNT,
 };
 
+/*****************************************************************************************
+ * Module stuff
+ */
+static struct kobject *famfs_kobj;
+
+static int __init init_famfs_fs(void)
+{
+	int rc;
+
+#if defined(CONFIG_DEV_DAX_IOMAP)
+	pr_notice("%s: Your kernel supports famfs on /dev/dax\n", __func__);
+#else
+	pr_notice("%s: Your kernel does not support famfs on /dev/dax\n", __func__);
+#endif
+	famfs_kobj = kobject_create_and_add(MODULE_NAME, fs_kobj);
+	if (!famfs_kobj) {
+		pr_warn("Failed to create kobject\n");
+		return -ENOMEM;
+	}
+
+	rc = sysfs_create_group(famfs_kobj, &famfs_attr_group);
+	if (rc) {
+		kobject_put(famfs_kobj);
+		pr_warn("%s: Failed to create sysfs group\n", __func__);
+		return rc;
+	}
+
+	return register_filesystem(&famfs_fs_type);
+}
+
+static void
+__exit famfs_exit(void)
+{
+	sysfs_remove_group(famfs_kobj,  &famfs_attr_group);
+	kobject_put(famfs_kobj);
+	unregister_filesystem(&famfs_fs_type);
+	pr_info("%s: unregistered\n", __func__);
+}
+
+
+fs_initcall(init_famfs_fs);
+module_exit(famfs_exit);
+
+MODULE_AUTHOR("John Groves, Micron Technology");
 MODULE_LICENSE("GPL");
-- 
2.43.0


