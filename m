Return-Path: <linux-fsdevel+bounces-46747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F26A94A38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2268016F5C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14323155330;
	Mon, 21 Apr 2025 01:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcVjzU+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCEE1459EA;
	Mon, 21 Apr 2025 01:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199246; cv=none; b=qWLhXLVUAakv6qOcTi+P66f6lI60FQ4lvHFBKO+dx0n1xPzPj4AxbX/6ggKWk4WT3xh4tNK1Fq8KBCEAFU7Zm0+iltArHiESBWXlThJ1GiOjG3iWrAfkw19qOKbn3wKSE9CEssPvRFwjR2Y2ZXHU+6heCk8+0oYWVKh/xuOIlC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199246; c=relaxed/simple;
	bh=SM8Xj4dnyYwoGjDXor6hvaRx7QAO8yyyxbfokVYE+S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l0qv1Qr9j/o9FGSs/vM5K8SFE3sYRk5Ow4BsqLv25L719/ydWxxSb5bG1gq760KZueRBTOfo/hqPGvC6x/zPVu1rwQFfjSnfnQLk3qMVh70ebx8kTryC8IbWKhNI2RIC/t9i8Jnlp4WDWlbqAJEQIBsforktP7oCbhOUjcEZg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcVjzU+E; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c7336ed99so1045352a34.0;
        Sun, 20 Apr 2025 18:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199244; x=1745804044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJswZ+V2KGwmP5G+n4PEaC6MizB6DbX3hqjndqhvdZU=;
        b=EcVjzU+EIvfAhyqloKxOahWMMzSFl30w7oB54xxnBZ5o+ohQQlE/nRlbkQU5g8DFxo
         0rytWycHUpB3c/n79wucHA+NePH5yEhIHIV3gvXM9SIWmf6yvfxGpv0rkTIhK+tZYW28
         BvPw68wHhCLSXQRNKcoQN2ecccbuVZou2Nc6q+rpLRZIjNxEwz8GuoQ2GIUWN9bb3vyu
         SRDwZBDb/U4pjf6Qs13PcqJo8R7VV7y6FcdnLoEJAIAE2PrNKrGVkTmecKSdWpBKwgbr
         i9f12HO3whly7F5tiNW8kMEwdxdNwIGyXpvFbJmhksmHbC8BLoG4pmJTm3liBb5LigXe
         9jPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199244; x=1745804044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJswZ+V2KGwmP5G+n4PEaC6MizB6DbX3hqjndqhvdZU=;
        b=AuLat9tawGycWs1YAIwl1oYMlCooGdOYd9eyWu/8zHEhRLQakkGxVTPP/cB1WcQRd+
         KalNVhW5l9HvTpa8tMzbGGQLNjd8HxTAQTW1cNQhUaTVLh48NpTJHIZC6H31mzgX1qtD
         g55CsBwF6ou2kD8JIZZRcPraWZkMLUD54Ksl6fORgDVCGfEzeET5qvlZqyZqEP1qo649
         +ahSla9a9MEpNWOJpZ4qkxbhT/vWcmDa8wbBmcRJtTByOHgxvi3hBNFgW++Wli9hGRY4
         4EbLHDdkXj9uwepXR7Vhe7Q8K5DFhw9cILWsBx+w/iXUxe6HKmvDbzYVn+PpP2FqTp5o
         QWHg==
X-Forwarded-Encrypted: i=1; AJvYcCUssHqnfEDFweGzvXgdCUas4PTXzIgk2442V+ZN2HDfwmfp7vKk9L/X4nwMeXSbITcJZJSDH8Vlep46E6zAqQ==@vger.kernel.org, AJvYcCV7gdTL0hoq6gYyYVylIJ1nPa8d/hChHxTxj9lw5ms/f1hfnqxNmMUOBAOUQ7cBelfQgxAhkiYElQwhT5rG@vger.kernel.org, AJvYcCX8+k7fv/ZvV3RjSTR7hiW3MqjZds4xoM5T4U8vu+/+VnJlRrKKSk3jSd6Wzl+rpGzxKHOTzavInw8=@vger.kernel.org, AJvYcCX9cpjtSVJIBpnIU2OAY+yoV2DhJZT4Uw9lo6lI6K3JzqRIc2o1N7apNhQaD3XoeMdNyowQP6Rm+EmH@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sV8NIaVseZikIpw17m9liDjNOOi6gtEQpgN/v0s1GYLYRKPr
	E11cBQ96Wl21X+gg6E9xl/L6ooFe4RUP+12/WYAFY7+jxHnk/LTt
X-Gm-Gg: ASbGnctpaVPNoExg9ozIbUEf3F7CzcGOGfDThWRgTTSV+h1iC3R/WII5dArOkn/C1M3
	1ZfSP7yF3rwVv9q4HfdEeig4U/I1g9YX1n80OWCACaoJo6/M7LMOYZKPPZ++EjMWFFpVgjrFWWi
	uwu8WE0Et5bpYeL4XyTWSUTwbFvNWSTjGHYV5v2AZafXnxDoQ42pv1rea7JIbBhXD5akU+//aUs
	2FEj0Q3TDPCuwGIUBgyPkVY3hGC15A4x8vjal2IY/qpK5v9WQrfxxgWLrIVLXGWA8plEFgGollS
	ELmixLO9GSlPKkZMuFhkBZyLjgTm0ilcI+2/Ma4oot4/ptpf/1tC3jzLT1uB/1uqJddEbQ==
X-Google-Smtp-Source: AGHT+IHRSyjVpRQa2MLAEuuQnotFbd3RCybPdxGlv+ddIkS2NgjbTnLA8P/hoj1HDXSaxjqDyXt1wQ==
X-Received: by 2002:a05:6830:71a6:b0:72b:8c4b:8ef2 with SMTP id 46e09a7af769-7300635568amr5548316a34.24.1745199243747;
        Sun, 20 Apr 2025 18:34:03 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.34.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:34:03 -0700 (PDT)
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
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>,
	Brian Foster <bfoster@redhat.com>,
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
Subject: [RFC PATCH 03/19] dev_dax_iomap: Save the kva from memremap
Date: Sun, 20 Apr 2025 20:33:30 -0500
Message-Id: <20250421013346.32530-4-john@groves.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250421013346.32530-1-john@groves.net>
References: <20250421013346.32530-1-john@groves.net>
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


