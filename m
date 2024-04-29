Return-Path: <linux-fsdevel+bounces-18123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBCB8B5F89
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B1041F23087
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A068664B;
	Mon, 29 Apr 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4OoeUyo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD6283CBA;
	Mon, 29 Apr 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410296; cv=none; b=cb2pfr41QqwLcgYf9kqY9sA41iVUTrMqmnvsg/5tpeKIp0m2eMuEjp46lViEWHOTdcpjMfbA0dhQTl8UaqPGtoi+dwyhFaJIWWoPTFNhv0FoyMHeHPjwareSMqdPu6Mtf6NqCe946eJLWrJk3fyIsIWAkwQoTEByWp07csdUXuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410296; c=relaxed/simple;
	bh=WMjz9J531Kmle80GG+B28JoC2U8bxRD8YtN4xwrFy4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZr0xWTpiwBUFTU4u8G+W5kS/VZlpfvoh5d9c2J1BBLxIVajMqGSqw6ffiewXYnPN5mrR2XMkiKzTq8IHza1vMCApdsQtsBPAi4bd5qX0OBXZojosDdZ0zuYUjhhlvu3fLlTHSxUHGgRKn7U9gzIDdiXqzd+G/zQhGMCgKo2agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4OoeUyo; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6ea2ac4607aso2546447a34.3;
        Mon, 29 Apr 2024 10:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714410293; x=1715015093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFzk9HeKkizf0o48ibh6kc3Q60VfzVMF4+JwNubBTrc=;
        b=c4OoeUyohJX81A95HlwPlHb2xBrXn0h8iaGZ+SSwWbAUT6jUNNlnkAQ0NoTak7wltG
         J+UGWUogef6HIUnGOl5EIDc26SiOT0OJ+Hf/cxY3Wsj6Hy+hDObXy9I1ubYKLMYV0Si0
         NutvVcHkhXNPXTfEtQYLGyn2iQM2++VLcH+QwaZr9XIcERGan1aNRsR5uksB5OHCjdMR
         3xS4wHZcchncHBhCEJiQj8jEab8nkG6AC2hXLrVkjmxsgy/Yz1VwZcl9ev5+xHVmDpG/
         ueDoOC2iCkfRifxlTGSSQJvyQw2pM4diOyaepwvbaPMrSpP4NzIVHnlBOe8/EaJ/Jr3T
         rnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714410293; x=1715015093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yFzk9HeKkizf0o48ibh6kc3Q60VfzVMF4+JwNubBTrc=;
        b=F3Y0ltsh5Wn7QAWAT0hJroTnFPnhR/oE6QK9JLSIM/wORJTtSHLqwIYO8ukuiFtzpl
         eBId6IhcdZ666/p5O8LGzCBeElmFm9jlODZ8g/IYO/b6vdQBrXx34KJheRhIICNmnzH9
         9Ze4gRiCv8Z/7f8A86zwLPZMFXTOF0Z1maQFgrqlMnBRw5ZoEo584pc/m+xXs1UBiVSJ
         ydjpMrU3SnGFJmK/wHkDs9tj31PAGwhdvI5Rms/gIBZDLgiPP2T+GL2d+msRQbSorU8I
         niASvbD3XSD7XTm8/BnpCXMf/pZ/sZ+e4dLUmyb8wTs3huiqCVWGiJB14KArOoDKu8Ij
         rcow==
X-Forwarded-Encrypted: i=1; AJvYcCVz1slq/qfWas9nqp1OlC2lX/aKXzwblwQnffbeqYTutG8PwasWvaCrHBa6pDDRd1ZS3hTKOEfXRIVE6NUmvkaesoQS7p1K4sT3OcNgA44T6LcFg06i44lYTWhNRc1g/0QLChfWrtrfOA==
X-Gm-Message-State: AOJu0YxWB78NVNqK0oeH5PwIMsnvdskekbI4eP5ZqB4lxPk5eef+w4Qv
	1SukKfzNfP5zqVzGTfmzeZhpm1mgALZHHlnHahf7BV1OzptVSmgm
X-Google-Smtp-Source: AGHT+IH1LmxDBYpYdV8qfbKzAt1ETJgRjycszT1zAA1fNj6kpgVTUiKrSaeYD5ARjcBkfK0lW4EGeg==
X-Received: by 2002:a05:6830:4a2:b0:6eb:7c52:fd19 with SMTP id l2-20020a05683004a200b006eb7c52fd19mr12585723otd.16.1714410292768;
        Mon, 29 Apr 2024 10:04:52 -0700 (PDT)
Received: from localhost.localdomain ([70.114.203.196])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d6201000000b006ea20712e66sm4074448otj.17.2024.04.29.10.04.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Apr 2024 10:04:52 -0700 (PDT)
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
Subject: [RFC PATCH v2 02/12] dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
Date: Mon, 29 Apr 2024 12:04:18 -0500
Message-Id: <552c86dd6c3c4252994a94e23bad2cb95e3ed392.1714409084.git.john@groves.net>
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

No changes to the function - just moved it.

dev_dax_iomap needs to call this function from
drivers/dax/bus.c.

drivers/dax/bus.c can't call functions in drivers/dax/device.c -
that creates a circular linkage dependency - but device.c can
call functions in bus.c. Also exports dax_pgoff_to_phys() since
both bus.c and device.c now call it.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c    | 24 ++++++++++++++++++++++++
 drivers/dax/device.c | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 797e1ebff299..f894272beab8 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1447,6 +1447,30 @@ static const struct device_type dev_dax_type = {
 	.groups = dax_attribute_groups,
 };
 
+/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c  */
+__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
+			      unsigned long size)
+{
+	int i;
+
+	for (i = 0; i < dev_dax->nr_range; i++) {
+		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
+		struct range *range = &dax_range->range;
+		unsigned long long pgoff_end;
+		phys_addr_t phys;
+
+		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
+		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
+			continue;
+		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
+		if (phys + size - 1 <= range->end)
+			return phys;
+		break;
+	}
+	return -1;
+}
+EXPORT_SYMBOL_GPL(dax_pgoff_to_phys);
+
 static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
 {
 	struct dax_region *dax_region = data->dax_region;
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 93ebedc5ec8c..40ba660013cf 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -50,29 +50,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 	return 0;
 }
 
-/* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
-__weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
-		unsigned long size)
-{
-	int i;
-
-	for (i = 0; i < dev_dax->nr_range; i++) {
-		struct dev_dax_range *dax_range = &dev_dax->ranges[i];
-		struct range *range = &dax_range->range;
-		unsigned long long pgoff_end;
-		phys_addr_t phys;
-
-		pgoff_end = dax_range->pgoff + PHYS_PFN(range_len(range)) - 1;
-		if (pgoff < dax_range->pgoff || pgoff > pgoff_end)
-			continue;
-		phys = PFN_PHYS(pgoff - dax_range->pgoff) + range->start;
-		if (phys + size - 1 <= range->end)
-			return phys;
-		break;
-	}
-	return -1;
-}
-
 static void dax_set_mapping(struct vm_fault *vmf, pfn_t pfn,
 			      unsigned long fault_size)
 {
-- 
2.43.0


