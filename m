Return-Path: <linux-fsdevel+bounces-12611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A4861A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3A2869E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9052B1474A3;
	Fri, 23 Feb 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kblba6uZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5211146E73;
	Fri, 23 Feb 2024 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710187; cv=none; b=qIg4X7dKk8PIv2iHd/hv4NhFrmh4JQ+el5a4IKErVmhUKghjDKPNcCf0iw/TTUBVe+ETgP8+4Av5GmJTtplVlG5UfxO3tFAqg/5cTxoMnYckjWD/krm3Wad9KABbu174q7gJ1WMkiXWwCu+IveWBavwYu2pRoYaZFIGeqE5tBgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710187; c=relaxed/simple;
	bh=fyP1dnJB44f2zHUX/KhaAT1o3vyBlQVFBHhanjGgGrc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrs165MEFjjYoxj4SasJfvKYn73blJid5Z1Tb21O2t0rp02d37GysPQ4ug4N6ERDNsZOR+IatAhuUyJ3OKX7Kw+fb0rMaMCIRPKP4taArQW1eG37gjShsqQbFuKfEYL8ouFLeoCaXDJ6Z9c2G9t9lSBVIyqJJmxDfeSwdXzdj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kblba6uZ; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-214def5da12so565684fac.2;
        Fri, 23 Feb 2024 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710183; x=1709314983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QSU63xn35q5xIC/F3LPxUfwI8O4W4i8duNVDi3MdIz8=;
        b=Kblba6uZvvzHH/u0thHlvp4XF21RgBoWCGYeVk7p5IKsU5mMwGiQwsELa21KEL19KQ
         EpWHPC7+LkCzmcyQgel2mylFnWSXwKXIJNylgeBecfmGgzbAi/lDaVDJO6HV8Kp17daB
         L5c9QuhmK5oIPqZpchLVI/f46aYrT5cicU2Ce8DzE9M2GucJz72Lx/zODiR6RzCIBWzr
         QgymlA0U00P8CmUKCpupvKurqsqYrAIdeWBqiNZeoBZ/bgMqeVb2UNIYF8VOicIDPEHF
         BK6YFPYZg8+MfJ+SVTTqR7iZ9bcScyKjIMwyBJzJ8foCSQTp7YUI7qdcY2422qXEbxGe
         aRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710183; x=1709314983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QSU63xn35q5xIC/F3LPxUfwI8O4W4i8duNVDi3MdIz8=;
        b=HuacQlLpLJGkMRL/Wbb6nW20eIKZ68Q4Sc6rAM/ZTiLNQ9otyQPsPDsSVrWVVKyq/9
         tx/M3tOx+gKn4kwYxCgjVRFBd6DGBDiZj5Fwrnqv4Z2LYzipAkMZPw6BSMqh6PlTTfa2
         FSkv6Mim7S5gPoKYChypG7tNvyygejgbcp1KRbZRk5YPiUYNMEYKv6HXMoRJW5DMMx/a
         kKg50tFvvqbPsavhk+zFYX3XKvnkF6xK7Gyf7NgpFymqwoeJ8kfIvnjZbygyTRmCVJPp
         SzOHJHKvVGySX5QrI3Kw3lqWAABYTVDn59etX3gAMA1Idbd/ux1dpFXBGRvJvxE7kpIW
         pgng==
X-Forwarded-Encrypted: i=1; AJvYcCXpZb9OeqKonUxEOhTBzicp+aj1LPKwmI2Ld9Xh5MTLDnlTLzHjkT8J4ja6gBIFZrIpHD7ogvtxqPuOQae38B/GUXvZAhRZrFN5e/PHavYEORt0oJM8DmjyrkZphngNHJ74T4lQ2E5cv7vqD4z3g0+mzz58pMWLdpoMp+PGtAqQ3QU6owgeZbp/wmQxAzLvBBk/dZTxVPaoZSZXyVMf7wcvvw==
X-Gm-Message-State: AOJu0Yy6fjNzBUX/HaoYEGgYNp0GjfEDZwno6tDKN4dvLkjpcTYmyqYW
	4Jt9FZ2IAIUunx+9HOqM2Y82keS2JNIT2NXcmueir+jBOvEGW+Yw
X-Google-Smtp-Source: AGHT+IHYLhdAVNB79UcBgLmrX8iHEz3pdisd9nD17jHPXDhHA28rwXuN54PUoWNin6tsA8ziv8tebw==
X-Received: by 2002:a05:6870:f6a1:b0:21e:9b99:53d8 with SMTP id el33-20020a056870f6a100b0021e9b9953d8mr563209oab.22.1708710183097;
        Fri, 23 Feb 2024 09:43:03 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.43.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:02 -0800 (PST)
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
Subject: [RFC PATCH 16/20] famfs: Add fault counters
Date: Fri, 23 Feb 2024 11:42:00 -0600
Message-Id: <43245b463f00506016b8c39c0252faf62bd73e35.1708709155.git.john@groves.net>
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

One of the key requirements for famfs is that it service vma faults
efficiently. Our metadata helps - the search order is n for n extents,
and n is usually 1. But we can still observe gnarly lock contention
in mm if PTE faults are happening. This commit introduces fault counters
that can be enabled and read via /sys/fs/famfs/...

These counters have proved useful in troubleshooting situations where
PTE faults were happening instead of PMD. No performance impact when
disabled.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_file.c     | 97 +++++++++++++++++++++++++++++++++++++++
 fs/famfs/famfs_internal.h | 73 +++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/fs/famfs/famfs_file.c b/fs/famfs/famfs_file.c
index fd42d5966982..a626f8a89790 100644
--- a/fs/famfs/famfs_file.c
+++ b/fs/famfs/famfs_file.c
@@ -19,6 +19,100 @@
 #include <uapi/linux/famfs_ioctl.h>
 #include "famfs_internal.h"
 
+/***************************************************************************************
+ * filemap_fault counters
+ *
+ * The counters and the fault_count_enable file live at
+ * /sys/fs/famfs/
+ */
+struct famfs_fault_counters ffc;
+static int fault_count_enable;
+
+static ssize_t
+fault_count_enable_show(struct kobject *kobj,
+			struct kobj_attribute *attr,
+			char *buf)
+{
+	return sprintf(buf, "%d\n", fault_count_enable);
+}
+
+static ssize_t
+fault_count_enable_store(struct kobject        *kobj,
+			 struct kobj_attribute *attr,
+			 const char            *buf,
+			 size_t                 count)
+{
+	int value;
+	int rc;
+
+	rc = sscanf(buf, "%d", &value);
+	if (rc != 1)
+		return 0;
+
+	if (value > 0) /* clear fault counters when enabling, but not when disabling */
+		famfs_clear_fault_counters(&ffc);
+
+	fault_count_enable = value;
+	return count;
+}
+
+/* Individual fault counters are read-only */
+static ssize_t
+fault_count_pte_show(struct kobject *kobj,
+		     struct kobj_attribute *attr,
+		     char *buf)
+{
+	return sprintf(buf, "%llu", famfs_pte_fault_ct(&ffc));
+}
+
+static ssize_t
+fault_count_pmd_show(struct kobject *kobj,
+		     struct kobj_attribute *attr,
+		     char *buf)
+{
+	return sprintf(buf, "%llu", famfs_pmd_fault_ct(&ffc));
+}
+
+static ssize_t
+fault_count_pud_show(struct kobject *kobj,
+		     struct kobj_attribute *attr,
+		     char *buf)
+{
+	return sprintf(buf, "%llu", famfs_pud_fault_ct(&ffc));
+}
+
+static struct kobj_attribute fault_count_enable_attribute = __ATTR(fault_count_enable,
+								   0660,
+								   fault_count_enable_show,
+								   fault_count_enable_store);
+static struct kobj_attribute fault_count_pte_attribute = __ATTR(pte_fault_ct,
+								0440,
+								fault_count_pte_show,
+								NULL);
+static struct kobj_attribute fault_count_pmd_attribute = __ATTR(pmd_fault_ct,
+								0440,
+								fault_count_pmd_show,
+								NULL);
+static struct kobj_attribute fault_count_pud_attribute = __ATTR(pud_fault_ct,
+								0440,
+								fault_count_pud_show,
+								NULL);
+
+
+static struct attribute *attrs[] = {
+	&fault_count_enable_attribute.attr,
+	&fault_count_pte_attribute.attr,
+	&fault_count_pmd_attribute.attr,
+	&fault_count_pud_attribute.attr,
+	NULL,
+};
+
+struct attribute_group famfs_attr_group = {
+	.attrs = attrs,
+};
+
+/* End fault counters */
+
 /**
  * famfs_map_meta_alloc() - Allocate famfs file metadata
  * @mapp:       Pointer to an mcache_map_meta pointer
@@ -525,6 +619,9 @@ __famfs_filemap_fault(
 	if (IS_DAX(inode)) {
 		pfn_t pfn;
 
+		if (fault_count_enable)
+			famfs_inc_fault_counter_by_order(&ffc, pe_size);
+
 		ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &famfs_iomap_ops);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
diff --git a/fs/famfs/famfs_internal.h b/fs/famfs/famfs_internal.h
index af3990d43305..987cb172a149 100644
--- a/fs/famfs/famfs_internal.h
+++ b/fs/famfs/famfs_internal.h
@@ -50,4 +50,77 @@ struct famfs_fs_info {
 	char                    *rootdev;
 };
 
+/*
+ * filemap_fault counters
+ */
+extern struct attribute_group famfs_attr_group;
+
+enum famfs_fault {
+	FAMFS_PTE = 0,
+	FAMFS_PMD,
+	FAMFS_PUD,
+	FAMFS_NUM_FAULT_TYPES,
+};
+
+static inline int valid_fault_type(int type)
+{
+	if (unlikely(type < 0 || type > FAMFS_PUD))
+		return 0;
+	return 1;
+}
+
+struct famfs_fault_counters {
+	atomic64_t fault_ct[FAMFS_NUM_FAULT_TYPES];
+};
+
+extern struct famfs_fault_counters ffc;
+
+static inline void famfs_clear_fault_counters(struct famfs_fault_counters *fc)
+{
+	int i;
+
+	for (i = 0; i < FAMFS_NUM_FAULT_TYPES; i++)
+		atomic64_set(&fc->fault_ct[i], 0);
+}
+
+static inline void famfs_inc_fault_counter(struct famfs_fault_counters *fc,
+					   enum famfs_fault type)
+{
+	if (valid_fault_type(type))
+		atomic64_inc(&fc->fault_ct[type]);
+}
+
+static inline void famfs_inc_fault_counter_by_order(struct famfs_fault_counters *fc, int order)
+{
+	int pgf = -1;
+
+	switch (order) {
+	case 0:
+		pgf = FAMFS_PTE;
+		break;
+	case PMD_ORDER:
+		pgf = FAMFS_PMD;
+		break;
+	case PUD_ORDER:
+		pgf = FAMFS_PUD;
+		break;
+	}
+	famfs_inc_fault_counter(fc, pgf);
+}
+
+static inline u64 famfs_pte_fault_ct(struct famfs_fault_counters *fc)
+{
+	return atomic64_read(&fc->fault_ct[FAMFS_PTE]);
+}
+
+static inline u64 famfs_pmd_fault_ct(struct famfs_fault_counters *fc)
+{
+	return atomic64_read(&fc->fault_ct[FAMFS_PMD]);
+}
+
+static inline u64 famfs_pud_fault_ct(struct famfs_fault_counters *fc)
+{
+	return atomic64_read(&fc->fault_ct[FAMFS_PUD]);
+}
+
 #endif /* FAMFS_INTERNAL_H */
-- 
2.43.0


