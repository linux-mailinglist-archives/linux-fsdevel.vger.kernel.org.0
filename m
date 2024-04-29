Return-Path: <linux-fsdevel+bounces-18125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4768B5F8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FDD1F233CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B559286ADB;
	Mon, 29 Apr 2024 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noS+FCZf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D1783CBA;
	Mon, 29 Apr 2024 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410304; cv=none; b=CzgzEJ7jmVub9Yrb2FmAhkh64C9JTAOCfLugMYk00IDeVuhQk3csPB4Bbb3fEPE8qacYWZOzWVL0u1Xnl50WdCB7w65lHi1pSzsozomcQhyOLdyVhTNQTGxjKP1THXEP7oPbBf8BFA5mZh5ZrDHAYULW6dWvLbOoPCF7xnM98ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410304; c=relaxed/simple;
	bh=MF/nGBkB6SU7LTC2q8o8OtAo1cFLHGL5yhdgeaFsrRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IwKGU/CwuqsxGMNV8czlk+dBnQQPaFZSDoOS/WONjexFp0bi0UKRxr5TlUVkbPgczm4VhmGGLRPNfksEYmKQzniy4HqgKzsibPK09cEJ6dxuL63paE3nMJ7fFmAoZ6UQVEoPZtZf4jvUitUoCUxG+dFDr439zmRsMKTxYpUG+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noS+FCZf; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-233e41de0caso2419874fac.0;
        Mon, 29 Apr 2024 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410302; x=1715015102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpFg6AryW/38Pe75AIWbtaiD3q42kDFfLzhRRyJ/+BY=;
        b=noS+FCZfnjEr1mJkWyrlqMcMg4Lc26M2FVS3V8ATUE/GwYS3tokAGOBi2ll/xJSjWj
         rozvlDkTCcAgLYTarVLWs5A9QC2IAcFUS9MgFEOYQxdWIOqAPxAoRXAKYZQ+VAhL2b15
         Ok7o60wZKQxkN/Ik5+Ug4s4Z8SBh3649cbb0A1fNQeeVC6EjEtdsdCZzWsX6KjJvfkEB
         VnpEvMSyvyFQwkLEAhvZHMwlR7pXLMGMTY+KmChs3aJ6EYPQ3CVVkH04uC+/eRQx8TH4
         UK1FMjzbacWLpAwc8WFf9dAAGqCcoqlhhtgf2G9afihGf4lst42vkhB6n5bNg1zsQjnO
         hFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410302; x=1715015102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BpFg6AryW/38Pe75AIWbtaiD3q42kDFfLzhRRyJ/+BY=;
        b=kSH2ZKW9L89oRuoQ8mLxugrB+W1Pih4qWUcWzkD7vHfZ1mZnaGsQxyWFxEt8/UP82Q
         0Ya4FWnDxVlI8mEdFjrCnu984I/Tj6n6I63lfywCXf2zYBI8EamsZY819/GDTNBU5SEK
         Y61GEewrr3O2EkUt8wpuHhK2d12xMKIgGEc+k8xrwoAm3YqbkHnBAHDmPqT+RwbuiC0T
         aLc7mb/bKl1FjBZg+ZCN0SROuL0KVsy/HKVvkulbXASujye5WxHWAomhI7G1hnQQHhbV
         qHeTgMA/q0nabXZwb7ZpCWJll8cTjTbMKlrmO7DwIQVFsYG7bm4ymvFhYiwL5mwBOeDJ
         Cu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWKA09u7LVoE99y5RqSQ9fqWcV/ez6hKygMwEGnlkvcu6ng/ZeaHoYqO+uEDf/JLbhp44beXJm0kzEoipkEX3wWgPl5SV1c7UsxdvqTwIKmh/Mc9vZXt6SdPbahphdcoeb2X5Qga5QKWQ==
X-Gm-Message-State: AOJu0Ywi8/8uxqy5hYFQVfRKpHrluG23zu7ElsxGv5XgHDCNuI1cdpAu
	o0L7qDO/nYRyu/3cbFvJMKSSGoghOVrtRjO4lFJQNxatckD9D0Wh
X-Google-Smtp-Source: AGHT+IFVJywrgMfv62xcHp0KCFD6JQ/TzPkywYZ5Go7vHf3u7Bi5WE1VU9aozhj5LAVxYHRlvKWs8w==
X-Received: by 2002:a05:6870:224f:b0:23c:ad86:9935 with SMTP id j15-20020a056870224f00b0023cad869935mr3417616oaf.45.1714410301811;
        Mon, 29 Apr 2024 10:05:01 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.04.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:05:01 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Cc: John Groves <jgroves@micron.com>,
	john@jagalactic.com,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>,
	dave.hansen@linux.intel.com,
	gregory.price@memverge.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Jerome Glisse <jglisse@google.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	Eishan Mirakhur <emirakhur@micron.com>,
	Ravi Shankar <venkataravis@micron.com>,
	Srinivasulu Thanneeru <sthanneeru@micron.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Steve French <stfrench@microsoft.com>,
	Nathan Lynch <nathanl@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Julien Panis <jpanis@baylibre.com>,
	Stanislav Fomichev <sdf@google.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	John Groves <john@groves.net>
Subject: [RFC PATCH v2 04/12] dev_dax_iomap: Save the kva from memremap
Date: Mon, 29 Apr 2024 12:04:20 -0500
Message-Id: <c46bfb93584b726bae920ce25972470015256d25.1714409084.git.john@groves.net>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1714409084.git.john@groves.net>
References: <cover.1714409084.git.john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the kva from memremap because we need it for iomap rw support.

Prior to famfs, there were no iomap users of /dev/dax - so the virtual
address from memremap was not needed.

Also: in some cases dev_dax_probe() is called with the first
dev_dax->range offset past the start of pgmap[0].range. In those cases
we need to add the difference to virt_addr in order to have the physaddr's
in dev_dax->ranges match dev_dax->virt_addr.

This happens with devdax devices that started as pmem and got converted
to devdax. I'm not sure whether the offset is due to label storage, or
page tables, but this works in all known cases.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h |  1 +
 drivers/dax/device.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aea..df5b3d975df4 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -63,6 +63,7 @@ struct dax_mapping {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	void *virt_addr;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 40ba660013cf..17323b5f6f57 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -372,6 +372,7 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
 	struct dax_device *dax_dev = dev_dax->dax_dev;
 	struct device *dev = &dev_dax->dev;
 	struct dev_pagemap *pgmap;
+	u64 data_offset = 0;
 	struct inode *inode;
 	struct cdev *cdev;
 	void *addr;
@@ -426,6 +427,20 @@ static int dev_dax_probe(struct dev_dax *dev_dax)
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
+	/* Detect whether the data is at a non-zero offset into the memory */
+	if (pgmap->range.start != dev_dax->ranges[0].range.start) {
+		u64 phys = dev_dax->ranges[0].range.start;
+		u64 pgmap_phys = dev_dax->pgmap[0].range.start;
+		u64 vmemmap_shift = dev_dax->pgmap[0].vmemmap_shift;
+
+		if (!WARN_ON(pgmap_phys > phys))
+			data_offset = phys - pgmap_phys;
+
+		pr_debug("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx shift=%llx\n",
+		       __func__, phys, pgmap_phys, data_offset, vmemmap_shift);
+	}
+	dev_dax->virt_addr = addr + data_offset;
+
 	inode = dax_inode(dax_dev);
 	cdev = inode->i_cdev;
 	cdev_init(cdev, &dax_fops);
-- 
2.43.0


