Return-Path: <linux-fsdevel+bounces-12599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7663861A30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 263F6B20ACA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD113DBB0;
	Fri, 23 Feb 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQeoMEGg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C0913DB80;
	Fri, 23 Feb 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710151; cv=none; b=ktyFXpHQz3OIhA5Fybgk8rbQk/MvJ6PKamw0vDECbR2HEN5oTB4xd7+t/R7Jbqx0EwUQ65oSUAKtuJs9LkzlfoikJtnzSWxj4ZuRH6APbH7msns15RK1yC94DjSH8Jp48V76c+vhCg3nNakw7YsGw5VDoU6sF2cj+gOEkUceMhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710151; c=relaxed/simple;
	bh=P4ycxMH1eLEp2A0+12tkQr5yDXMbhNTfR+V2FQ6zQjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PxAHFRN+cnNiH/juv6JWeZuuKuPUW/SoeJu2Km2cKnkdqmN5h9rJ9YboA+ne6hRHaczYka8snGUPtQ4P8GEkM4WlgFdFE432kweYP5fu2UPz+5AjDswv3k25DoUcvOZ0BGIcL8KsrnQe8PTYMoE7Gguk4NQcufo8x7GuNt/4Lvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQeoMEGg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c1884c33a9so539239b6e.2;
        Fri, 23 Feb 2024 09:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710149; x=1709314949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WJnJfeFGNikf7Cy1KZrMQXeMgUfPXb1BZJ051HZbDR4=;
        b=LQeoMEGgb9p8zmhnwOO6OakNA9uYcrRtHsF5WqvxYWpaFyumKrkY1iHc7OWvxGxsxH
         QFvLi0Sv+btRq0e5AETowRPHl0z/RL4aYiLSMbGP0pP7XjAvs7KD4D8l8QkWuYodXxn4
         15UCXuGg3/d8rTcfJezaOhbmV6pdSHP2MON3j3TSuJpr7vH0N1CO3QFE4DveIOwmN3Mq
         PEX7R6LMf3Oi+LaF/RRiL5+pru2I/WL6GLObyPAlRGXE6vqvNlz7/3KQTOYd//44pXBK
         0ofDPLpe5IQ228yd6pCskn7cjoCKe1Z0WAP+Itc49Q4L6FHyR5C/HnCtM/WugnM2yewM
         fYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710149; x=1709314949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WJnJfeFGNikf7Cy1KZrMQXeMgUfPXb1BZJ051HZbDR4=;
        b=HGIj4wPnB0CJLp6zItl6V8xGOabhIz6crcCfoE/SJdxqL8S9tD4o+suT7N/zUSO0w3
         /Dri9hgVgUBkAJ2QWCpZjwwKu6282kkn/XcCe/RQsUXqRZMgrqx3dHcqb8OijDYWNJGc
         7VS+ND3ffoB0Ekt2AtDaUNDRuSoa/DruIJisdLbsLmtM010VnbIhAF1Msyeso/Xst8sM
         rPCTpwT/4i0q4DsDZxtemKZDNDPpcUVrV9qKjnEcgwhiB+MunJdiw86cNz0lu5bl2CQC
         A/e0GcPHEev79maaW9vJ/7nyFQXHsawPDq+dbKYVn+mc3MNuSvFhv8ew0SFaSjv2iDLV
         znng==
X-Forwarded-Encrypted: i=1; AJvYcCUYg7gg7eZmo7XY8IGXbSsFwMqq3xHDdrZwpYiNpoRoJi7qoLrivm5H/69Nht/2AAZ6HEBp7HzxSKy3jBG6D81FDsDy3m4ygQKiJSJMj1McmV+1zdp7ma2/WAggcbeLD5eBxxws6vuh70Ra+6u4mRIpO4oogflGNNrFz3+2Jj/898XhtQOaKxhBhHjZBlWvMEavjYCBW73nr8cTSBkKjvLoFQ==
X-Gm-Message-State: AOJu0YwW8zhwF8ChZjb7h8vpPVf38CnP33gbUy4OoafEz8N5lhHCPHgr
	hjHB9pTLhezyjlp+1EhKSuD7ycJr7oXs344wCV4sTMOZhfD3PQG0
X-Google-Smtp-Source: AGHT+IEIopUj6ImsBlvAoK0O/1OKc+IpoiZFvcZvRep/2o4LSk5XrwSkmZ5t0MNRVaK6kXRmK59Fsw==
X-Received: by 2002:a05:6870:64a6:b0:21e:8c19:f716 with SMTP id cz38-20020a05687064a600b0021e8c19f716mr516277oab.49.1708710149191;
        Fri, 23 Feb 2024 09:42:29 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:28 -0800 (PST)
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
Subject: [RFC PATCH 04/20] dev_dax_iomap: Save the kva from memremap
Date: Fri, 23 Feb 2024 11:41:48 -0600
Message-Id: <66620f69fa3f3664d955649eba7da63fdf8d65ad.1708709155.git.john@groves.net>
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

Save the kva from memremap because we need it for iomap rw support

Prior to famfs, there were no iomap users of /dev/dax - so the virtual
address from memremap was not needed.

Also: in some cases dev_dax_probe() is called with the first
dev_dax->range offset past pgmap[0].range. In those cases we need to
add the difference to virt_addr in order to have the physaddr's in
dev_dax->ranges match dev_dax->virt_addr.

Dragons...

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/dax-private.h |  1 +
 drivers/dax/device.c      | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 446617b73aea..894eb1c66b4a 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -63,6 +63,7 @@ struct dax_mapping {
 struct dev_dax {
 	struct dax_region *region;
 	struct dax_device *dax_dev;
+	u64 virt_addr;
 	unsigned int align;
 	int target_node;
 	bool dyn_id;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 40ba660013cf..6cd79d00fe1b 100644
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
+		u64 phys = (u64)dev_dax->ranges[0].range.start;
+		u64 pgmap_phys = (u64)dev_dax->pgmap[0].range.start;
+		u64 vmemmap_shift = (u64)dev_dax->pgmap[0].vmemmap_shift;
+
+		if (!WARN_ON(pgmap_phys > phys))
+			data_offset = phys - pgmap_phys;
+
+		pr_notice("%s: offset detected phys=%llx pgmap_phys=%llx offset=%llx shift=%llx\n",
+		       __func__, phys, pgmap_phys, data_offset, vmemmap_shift);
+	}
+	dev_dax->virt_addr = (u64)addr + data_offset;
+
 	inode = dax_inode(dax_dev);
 	cdev = inode->i_cdev;
 	cdev_init(cdev, &dax_fops);
-- 
2.43.0


