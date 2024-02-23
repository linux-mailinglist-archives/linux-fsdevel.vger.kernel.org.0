Return-Path: <linux-fsdevel+bounces-12613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD9861A6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B1421F279D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7169A1493A3;
	Fri, 23 Feb 2024 17:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7qQZgWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA6B148FFE;
	Fri, 23 Feb 2024 17:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710191; cv=none; b=mSe+R1qKalQYO3lKzaIjQz5g/5hp3Uadc8ntUlsKZr/3NiL0kuPH6NG73HAOBtDXtc41F70zinKfxbouuEDqfLJBHtIZmFFThf/OSiCL8BKYzuMQrawMrD01F4558xpIzEnMyNmyT653FUeNmM+6MrbEowjoSq6tRPhQjqv//Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710191; c=relaxed/simple;
	bh=Ezvg1m83Vs64xk30SW6VrHXVsjwp8rUkX/UFmrsqfhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o/PBsx975/18qJc8Vpfe7zvUROT/G0WD4Kdo9lE/BvZjOzpG2abHvTQ7wLI3OijVE0/2ZyHV9SiZeKSHH2WvadKcaUtVYLORu2PtZBAGWSezmFb1883vGS7HPWxjNTB5DHs9RthlU/21pPz+gzpsrpuIFpBFZPhZpdvOo8WgcJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7qQZgWz; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-21f70f72fb5so627965fac.1;
        Fri, 23 Feb 2024 09:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710188; x=1709314988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bZOoCwgmIQtQYNMOXLY20KATST0iJmwj9uPACUep5Q=;
        b=X7qQZgWzBIE9jwXC5zCeDjTt7OjUF4eYruUOH0k+3dTt4eaZJzZkSxsNIlRup5bBzI
         e5//3eaYPyue9OyU3/amXI2j+IDwxXQjeugPqAb1akZxaFFivwNTLtEaM+GefxbUQbu2
         hOF3dGM4OdmeElbZgrp/h2wFX7LyhNvDHAPKCv4QlA4eEZ2Nlz453iBXdQnWt+wBNE46
         cITfkdx0vlY4hyDz8n5g+EhKPgm0OlvGauC8ipbgOMyDQsvQ7nm/zPj/zKM6UiTAUknt
         Brlu2inEL9py4Fq01hAgxDDQyc1Qn2Hgf5NIfx/0N8uYUb5cwjvzL7fIg5iJOUt9I7MJ
         ZwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710188; x=1709314988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bZOoCwgmIQtQYNMOXLY20KATST0iJmwj9uPACUep5Q=;
        b=E9eOFVV5+3pT485hRcN5SvlUjUe157iy5XWr8Q7ZLuEzu15jB2EVNmdMofTU7+B1gm
         pQcMP18gVgWlV7F+Ui+3Bdm5barBseBvhiUKZDF6r4mzJ25Q+ApQxoWvZUrLmEBDfuZ3
         gTSI6GbZUvsR1zbGeeNvXuMg4HrQQooCuw33mWHjw2OdYCoJ9Mm0ULmlIs7jYalZLB0Q
         vR7PqKzx4qPUIwfE6nJ8AUFxCPQ8B6gSy5x7ylWXdksNpBCdmMZQC3nhi3CsqMvYE0q9
         PfytcfqQhGkLES2cNwr5lA7Mk9kFw5AfF/eZqmilgpkP/e4cr3011OqVV8Nd/qreZ94w
         FWdw==
X-Forwarded-Encrypted: i=1; AJvYcCWT+C8AgbnYMeD/oKjDK9vHPPaWJovLj7DlSX4CN7rdfZxh/SKAIgDq7I22W2uv/MjFehN/ajiMLfCwC/w4rkkIOhsBPULdPgdc8CESJwdFv2td+QBNtVna06zP+A8169mGsVJ98rG9uaGumd9uHNuBe5ox96d5aiT1itwk46YiHsMN6GlqcUoBxQVIPEnTpjXoB7dMnRLtyaMPcG8BHN+qaQ==
X-Gm-Message-State: AOJu0YyPC3P3G3tUAU2jWOHCj7P21zbJYLEcJIGQ6ZTJMhHv80h0DYjw
	ouLFkdgkWJDpwtYCj8ROUWhXCOo00iIR9rFHXZYGHN9ezXBmTTwf
X-Google-Smtp-Source: AGHT+IHUEsDV7yeQRAIvTjc09WAn3P29Hi3DwkwU1/8Dctv6Vii+QtA1pfrR/mdognmcuCPTsC2TYg==
X-Received: by 2002:a05:6870:95a8:b0:21e:87ce:87c4 with SMTP id k40-20020a05687095a800b0021e87ce87c4mr572812oao.13.1708710188345;
        Fri, 23 Feb 2024 09:43:08 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.43.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:43:08 -0800 (PST)
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
Subject: [RFC PATCH 18/20] famfs: Support character dax via the dev_dax_iomap patch
Date: Fri, 23 Feb 2024 11:42:02 -0600
Message-Id: <fa06095b6a05a26a0a016768b2e2b70663163eeb.1708709155.git.john@groves.net>
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

This commit introduces the ability to open a character /dev/dax device
instead of a block /dev/pmem device. This rests on the dev_dax_iomap
patches earlier in this series.

Signed-off-by: John Groves <john@groves.net>
---
 fs/famfs/famfs_inode.c | 97 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 10 deletions(-)

diff --git a/fs/famfs/famfs_inode.c b/fs/famfs/famfs_inode.c
index 0d659820e8ff..7d65ac497147 100644
--- a/fs/famfs/famfs_inode.c
+++ b/fs/famfs/famfs_inode.c
@@ -215,6 +215,93 @@ static const struct super_operations famfs_ops = {
 	.show_options	= famfs_show_options,
 };
 
+/*****************************************************************************/
+
+#if defined(CONFIG_DEV_DAX_IOMAP)
+
+/*
+ * famfs dax_operations  (for char dax)
+ */
+static int
+famfs_dax_notify_failure(struct dax_device *dax_dev, u64 offset,
+			u64 len, int mf_flags)
+{
+	pr_err("%s: offset %lld len %llu flags %x\n", __func__,
+	       offset, len, mf_flags);
+	return -EOPNOTSUPP;
+}
+
+static const struct dax_holder_operations famfs_dax_holder_ops = {
+	.notify_failure		= famfs_dax_notify_failure,
+};
+
+/*****************************************************************************/
+
+/**
+ * famfs_open_char_device()
+ *
+ * Open a /dev/dax device. This only works in kernels with the dev_dax_iomap patch
+ */
+static int
+famfs_open_char_device(
+	struct super_block *sb,
+	struct fs_context  *fc)
+{
+	struct famfs_fs_info *fsi = sb->s_fs_info;
+	struct dax_device    *dax_devp;
+	struct inode         *daxdev_inode;
+
+	int rc = 0;
+
+	pr_notice("%s: Opening character dax device %s\n", __func__, fc->source);
+
+	fsi->dax_filp = filp_open(fc->source, O_RDWR, 0);
+	if (IS_ERR(fsi->dax_filp)) {
+		pr_err("%s: failed to open dax device %s\n",
+		       __func__, fc->source);
+		fsi->dax_filp = NULL;
+		return PTR_ERR(fsi->dax_filp);
+	}
+
+	daxdev_inode = file_inode(fsi->dax_filp);
+	dax_devp     = inode_dax(daxdev_inode);
+	if (IS_ERR(dax_devp)) {
+		pr_err("%s: unable to get daxdev from inode for %s\n",
+		       __func__, fc->source);
+		rc = -ENODEV;
+		goto char_err;
+	}
+
+	rc = fs_dax_get(dax_devp, fsi, &famfs_dax_holder_ops);
+	if (rc) {
+		pr_info("%s: err attaching famfs_dax_holder_ops\n", __func__);
+		goto char_err;
+	}
+
+	fsi->bdev_handle = NULL;
+	fsi->dax_devp = dax_devp;
+
+	return 0;
+
+char_err:
+	filp_close(fsi->dax_filp, NULL);
+	return rc;
+}
+
+#else /* CONFIG_DEV_DAX_IOMAP */
+static int
+famfs_open_char_device(
+	struct super_block *sb,
+	struct fs_context  *fc)
+{
+	pr_err("%s: Root device is %s, but your kernel does not support famfs on /dev/dax\n",
+	       __func__, fc->source);
+	return -ENODEV;
+}
+
+
+#endif /* CONFIG_DEV_DAX_IOMAP */
+
 /***************************************************************************************
  * dax_holder_operations for block dax
  */
@@ -236,16 +323,6 @@ const struct dax_holder_operations famfs_blk_dax_holder_ops = {
 	.notify_failure		= famfs_blk_dax_notify_failure,
 };
 
-static int
-famfs_open_char_device(
-	struct super_block *sb,
-	struct fs_context  *fc)
-{
-	pr_err("%s: Root device is %s, but your kernel does not support famfs on /dev/dax\n",
-	       __func__, fc->source);
-	return -ENODEV;
-}
-
 /**
  * famfs_open_device()
  *
-- 
2.43.0


