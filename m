Return-Path: <linux-fsdevel+bounces-32278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7764E9A2F9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E5F41C24B01
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EC51D86CD;
	Thu, 17 Oct 2024 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rFGh7F72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BDA1D63D0;
	Thu, 17 Oct 2024 21:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729199724; cv=none; b=a1y0CVFpv1QP/tODZJdUUXQlG1pr130aEMMYlvucHScaRa4EFCv286RhUc7tHVB/Y4/egtTiVZu0yDfPS2dieTQ2vnvUUUQ2XqxJEaIrikXv7D1GTmBq0XgoABcnrbFPm2SS0e465sagNZ7JwOh23NxFx+dOvp6fmupJF2EQFbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729199724; c=relaxed/simple;
	bh=lIKjHZVxn2d3EPQndwbRFNmNRE+uHzdfnpkcxGf1Ux4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyOtCQnf8QrYsZZAuaQE9pjqI3H8eqt/dyM8rLbZ6AvFrxWWACj33d48lMAc9JZu0kdXy+jBJXJvyN13PU3w86POqn8ywpdv8TQVGvbgf9JwXipEcL1VjO0FIishnOd8+SP2OgksCdGKlf3Uw4C8lcibAPUKfXP8Nr9AsRirNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rFGh7F72; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3hvCbxaGpjuy/8mKuNk4raktjM7ym+WOJ0WuAMToJIY=; b=rFGh7F72T1e2LF40VcDyS01cCo
	eV4JHySyjs8V6HuP9VsfgfvKDZh3qkUFZtoMb7CkheRjh7q6UNDjgaMG82BDMfsNIjW5mp8p7BkEh
	0CCS2GT21AB9IQeU8qQfXuwCbR0gvwD2WFJbxDRYY7EMuaJBMb/TuIsYRRhXjNdVDtGa9K+g14j5+
	xrzMm39McihVEhZ5FMOkh0iCo+cXaPKL830+q4wp8C7UOf3GM5iq8RQiWVXSfgSTAZ6Co/ZZNKqu9
	gyHyH9ffFmul0YrTYklSBjL4CSzCkZYAHpKqpunTPyHDiVxxcmCprzkfYTm1zoo9ysubJzfMnx2ko
	622Hqlsw==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1t1Xq1-00Bnlc-L9; Thu, 17 Oct 2024 23:15:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 17 Oct 2024 18:14:18 -0300
Subject: [PATCH v7 8/9] tmpfs: Expose filesystem features via sysfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241017-tonyk-tmpfs-v7-8-a9c056f8391f@igalia.com>
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
In-Reply-To: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Gabriel Krisman Bertazi <krisman@suse.de>
X-Mailer: b4 0.14.2

Expose filesystem features through sysfs, so userspace can query if
tmpfs support casefold.

This follows the same setup as defined by ext4 and f2fs to expose
casefold support to userspace.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
Reviewed-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 mm/shmem.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8d206e492e7d51dad4bfe1b36426e0064b612dad..7bd7ca5777af70c5a226daa20970781c638e34ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5543,3 +5543,40 @@ struct page *shmem_read_mapping_page_gfp(struct address_space *mapping,
 	return page;
 }
 EXPORT_SYMBOL_GPL(shmem_read_mapping_page_gfp);
+
+#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
+#if IS_ENABLED(CONFIG_UNICODE)
+static DEVICE_STRING_ATTR_RO(casefold, 0444, "supported");
+#endif
+
+static struct attribute *tmpfs_attributes[] = {
+#if IS_ENABLED(CONFIG_UNICODE)
+	&dev_attr_casefold.attr.attr,
+#endif
+	NULL
+};
+
+static const struct attribute_group tmpfs_attribute_group = {
+	.attrs = tmpfs_attributes,
+	.name = "features"
+};
+
+static struct kobject *tmpfs_kobj;
+
+static int __init tmpfs_sysfs_init(void)
+{
+	int ret;
+
+	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
+	if (!tmpfs_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
+	if (ret)
+		kobject_put(tmpfs_kobj);
+
+	return ret;
+}
+
+fs_initcall(tmpfs_sysfs_init);
+#endif /* CONFIG_SYSFS && CONFIG_TMPFS */

-- 
2.47.0


