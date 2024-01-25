Return-Path: <linux-fsdevel+bounces-8958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E077283C899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A32289D35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1D813BEB1;
	Thu, 25 Jan 2024 16:44:16 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC161339BA;
	Thu, 25 Jan 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201055; cv=none; b=Fe8jbOPRBGULVbKcttZ+en0iUgdlQq22Ud8EjBRDgtg2QVb6oI9tYD0tg3utYiBPcLW8xmQsWpwjtBtLXFwYLxPNCsnRLbbabgLLqWVausT+mEMxk05PYoj5Wzj3q4fuy1yI+U4D+vAzBE/nXhWv+0rctE68BiTfVbvFevMWrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201055; c=relaxed/simple;
	bh=7/IUb3XLktUN45V9JyajrdKMq9EZsYTVNnF5KRHa0mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrSv7I40ltwjMpiJJODirVCL+wr0RaLJ/CISXYhDP+Zn2gki4wkeonhKUculqDJmesiDXcIL2FT9ONiAUZD1MBSFmOXrWBkcmBbPZr/zBDwxKCyAbBC4qEOmIXFUUEAvTjmNzczHTiReSPxjwTTJGzwu2fHLyVjiV6iMt/fCum8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48AE015BF;
	Thu, 25 Jan 2024 08:44:58 -0800 (PST)
Received: from e121798.cable.virginm.net (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5846F3F5A1;
	Thu, 25 Jan 2024 08:44:08 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	oliver.upton@linux.dev,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	arnd@arndb.de,
	akpm@linux-foundation.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	mhiramat@kernel.org,
	rppt@kernel.org,
	hughd@google.com
Cc: pcc@google.com,
	steven.price@arm.com,
	anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com,
	david@redhat.com,
	eugenis@google.com,
	kcc@google.com,
	hyesoo.yu@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC v3 15/35] of: fdt: Add of_flat_read_u32()
Date: Thu, 25 Jan 2024 16:42:36 +0000
Message-Id: <20240125164256.4147-16-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125164256.4147-1-alexandru.elisei@arm.com>
References: <20240125164256.4147-1-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the function of_flat_read_u32() to return the value of a property as
an u32.

Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---

Changes since rfc v2:

* New patch, suggested by Rob Herring.

 drivers/of/fdt.c       | 21 +++++++++++++++++++++
 include/linux/of_fdt.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..dfcd79fd5fd9 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -755,6 +755,27 @@ const void *__init of_get_flat_dt_prop(unsigned long node, const char *name,
 	return fdt_getprop(initial_boot_params, node, name, size);
 }
 
+/*
+ * of_flat_read_u32 - Return the value of the given property as an u32.
+ *
+ * @node: device node from which the property value is to be read
+ * @propname: name of the property
+ * @out_value: the value of the property
+ * @return: 0 on success, -EINVAL if property does not exist
+ */
+int __init of_flat_read_u32(unsigned long node, const char *propname,
+			    u32 *out_value)
+{
+	const __be32 *reg;
+
+	reg = of_get_flat_dt_prop(node, propname, NULL);
+	if (!reg)
+		return -EINVAL;
+
+	*out_value = be32_to_cpup(reg);
+	return 0;
+}
+
 /**
  * of_fdt_is_compatible - Return true if given node from the given blob has
  * compat in its compatible list
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 0e26f8c3b10e..d7901699061b 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -57,6 +57,8 @@ extern const void *of_get_flat_dt_prop(unsigned long node, const char *name,
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
 extern unsigned long of_get_flat_dt_root(void);
 extern uint32_t of_get_flat_dt_phandle(unsigned long node);
+extern int of_flat_read_u32(unsigned long node, const char *propname,
+			    u32 *out_value);
 
 extern int early_init_dt_scan_chosen(char *cmdline);
 extern int early_init_dt_scan_memory(void);
-- 
2.43.0


