Return-Path: <linux-fsdevel+bounces-53826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3096EAF8093
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F675838B1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB012F3C1F;
	Thu,  3 Jul 2025 18:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG57Wpsj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674552989B6;
	Thu,  3 Jul 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568648; cv=none; b=HA3S9asj6woSW3dDR01U/XK9lXHDGGAcNEJZUmZWr7rrwwVvBsQ5WhFceHIdXQflN6B5o2f7iqXWUGIS370264QE1aONxiDpMPVDPA9tlsbfnNSX02lI6KWV/idzpgiq4r4tAg90S75b5gbKizrIwysFseoyNj6lJpbxasM53bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568648; c=relaxed/simple;
	bh=SM8Xj4dnyYwoGjDXor6hvaRx7QAO8yyyxbfokVYE+S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qha20TER0Jd9W50ULEVLB2UNy3aIWhc8TJU3mrTvvoS63/rTuu2SQ0QB98y13RyHajXJRB+IJVF5QXFEF4qwDOSkuuVW0q1mfR5bphRfTHVAFh3OqdbYUkeLMCmQilnb4FA7rOZMVDTeOXfZZyKVMlfcBVtj9frLFA9f2gHnAhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG57Wpsj; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-735a6d7c5b1so152492a34.2;
        Thu, 03 Jul 2025 11:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568645; x=1752173445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJswZ+V2KGwmP5G+n4PEaC6MizB6DbX3hqjndqhvdZU=;
        b=fG57WpsjFDlEaFgTdBlpaUv7z8CQ2uDkKVmc0EtgNUIiG9peGxt0LFxwTPA59MNMmk
         LXP0wGnvew6eE3Jqm5lzR953aHnqrv6YrZuDTRYcyvHPdBA7blS5FrPf9SvWMQrcEsf8
         Cqszh2jPf+qtXuTsxS4xZFBaB8GHYx3BAuuYoFTdd29J72Lcc0I6/ZzDTMUH2JllXZ/L
         WJcLwHz0oLxoznZ8100t+s3L2K8UKNXq5Bk3jJJBKEkv1/v4VRCZwp+UV+RZ/KDrDHsT
         rHdCxhsiWB1ya4rKe8ANUTuJ4w85waRlDPVlBiUhNO1TdGCquJFS5mk9aQ8AO426jEjR
         FsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568645; x=1752173445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJswZ+V2KGwmP5G+n4PEaC6MizB6DbX3hqjndqhvdZU=;
        b=GJAOm3PA9q5CnFzJbEbUCkw3nZY83rCywh3ZLG4JjTSYocjSQuv1R2ygxQcRtsYNGF
         1DB3d2RBSlfVnCfH/TdPPxCZvchHNgxjeREu1qjmA9bCgDjWCVYToCLbNQGJ9tsCxtJY
         5LQP9E93hGe9OK57yU/FssLu6poBAboKV3XfRA8O1gSkKDkqYlKgbk/M7BjOc9mfbfm2
         Yw+28eaxsDYx+LhSrLWb3eP/5kCXTBK7SrKUigaaDp0p5nRCq8oljDlRTLsN9cUp9gEx
         FLvhzggFofvdtvIj/n8H4APRNu1FCKOFWo7ggQ7o0HQXD8xkdJAKP+yOwQoHIO5G9I3j
         4mdA==
X-Forwarded-Encrypted: i=1; AJvYcCUUl8pz7wJoyWYTrytMy8RkgY+Varnlt2OLOiSchLkOMCZiH6znjwQOWKbKe5r6gwC7f+abnFfu40HD46/j@vger.kernel.org, AJvYcCV4FvidpTWus+7Xx9vB1nxB7OuoVEkJ3BgK3sRucEvf7ytQQqyPKNNd5vBPiiipVKpZgmwLDDUJkoZxyFvh6A==@vger.kernel.org, AJvYcCWHXwHLCa0xachH+ORCQsT2OKRQGtY4GgLZNRGRGg4W1YKd7LhZp1rd2UfQf+/uMJrdoexesWj+gLs=@vger.kernel.org, AJvYcCWQ64a5RtEy2nxGMrqmZsHHi5AolDTcGoWogNFT5Qeo2dLMQT+os1qp6wUZq82pIX8EbC+z39GOExJl@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo+KPIrCAEjTpkQ1O8CtHuE2cib82PATicnBjTu2PFI//ZrfQD
	1FAVn8/D0m7e+YQdsmbo1nQpQdFdjObUNDEwuUnTBuvQq1CS81l+W0uxifizMfX3
X-Gm-Gg: ASbGnctLzD0cNFVFJtzRJpigf3TGyY7OPAL/9E7owVrGzmiyYMVKTHTCDvtGl0SPpD/
	Gu0rHbolWkxeL3Z77nLhuHNW1W6vciX2PqkM7ryZ79u/1WxWQNNRmJZeQ5upHFh1OJbEQhn29V0
	wXxgXj7dDhUVY9Hyh6oP2kvtz3mrMc38s9H7Cf7odMtt8Nj2lZ/cbDrPdngCYjfo/xJqu9CDg5f
	4zVKvdWVNuVbORpPzTeePv4xprAs40SW5YtQhxcBcj5D+Spkgk5HiM4fGJxRDTCh8KppRtYoBZp
	DZIyxYrxnuKb00mamIXDCFBQAqE2NcCSgaGw67RP/A9vtZyjWKj6Zw2cVTuvCZ7nXvFHfEu4JCA
	hlUoxfy64WtJhevrO0BLfgMNM
X-Google-Smtp-Source: AGHT+IGf6EnisMiDGZyZbVSv29Y7ewVQGRvUqtA17icw2gxtyfeO9BNRhEvAJBrTRu+vFRFvecQ+Zw==
X-Received: by 2002:a05:6830:2c07:b0:727:24ab:3e4 with SMTP id 46e09a7af769-73c8c248e02mr2426451a34.9.1751568645493;
        Thu, 03 Jul 2025 11:50:45 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:45 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
	Bernd Schubert <bschubert@ddn.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	John Groves <john@groves.net>
Subject: [RFC V2 03/18] dev_dax_iomap: Save the kva from memremap
Date: Thu,  3 Jul 2025 13:50:17 -0500
Message-Id: <20250703185032.46568-4-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250703185032.46568-1-john@groves.net>
References: <20250703185032.46568-1-john@groves.net>
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
index 0867115aeef2..2a6b07813f9f 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -81,6 +81,7 @@ struct dev_dax_range {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	void *virt_addr;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 29f61771fef0..583150478dcc 100644
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
2.49.0


