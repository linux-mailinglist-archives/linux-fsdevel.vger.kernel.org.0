Return-Path: <linux-fsdevel+bounces-12598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301CB861A2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 18:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD151C255C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 17:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B73A13DB82;
	Fri, 23 Feb 2024 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNXRp9Tu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157C13B79C;
	Fri, 23 Feb 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710149; cv=none; b=iyfvBZeVKvLF3OtL1kfraY7BrNBSWI+C2vY4JoKQBMZ3FmVJJt8HSxTtww85UZuLleHYD33xKAQs6W3bvBwcAd13P4HMMvzHtqfgCLp+iI5r6falrbt56JPM8AZRGuUNtcnISVPRbsTDdVr489U6aDAHAVtB3rjcO5mw6g6RE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710149; c=relaxed/simple;
	bh=ZbfxtKf+CEH2wGLH6RSoWosZOiwKXV+zrcJLYgSF8z4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UEA71qbFr8XkMv+eJudeq2ZUS6E3nL59gK04iZ1WgSC9B+iq/EubzyozYpXjsxyGfLiD1ePt19LpYb/hWufF87yr4bPtMpZGCpu3RZR4JxiVWSbs5U8P27mpwRZUlvSER0Hf0m3nO5oC9AJtaAK6JOlj88kiJxAabnFCMW64Hv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JNXRp9Tu; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5a054dfee60so104007eaf.0;
        Fri, 23 Feb 2024 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708710146; x=1709314946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ysyvhoe9WrIZCAbrcazj2rYc9hMFHO2LJz+Ed7fxvok=;
        b=JNXRp9TuTBXuGqd+mbQ47m3Dt32jh312w1lODbdhyhrTNl37wiHO8j7i29Jby2PvF2
         0jWpybYMcdCk8V/j2Sqh93pYQkRq9EgZzyuF3n7NsSzfwdzWGA7kvaGHtD/tNPxiMXQ5
         aZ3Vyr7usIUIisLTL1lHVhBInL3ChMUqoggI1yiq16KkLze+p9poC+CZ9VetJZVi9TfD
         G+X+C4msXeaI0JL+ih2A03bYLyMq0MwNzGaO13Fp/uX8PsQwUr6YiO++/RtY1Q6CCpvc
         9uqheIz7sx/jp3WxjdiBqxVzzQ3XscxNU1NHkLDVAGnrRtnxGh6BYnalxr0pRVC7rQh+
         iUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710146; x=1709314946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ysyvhoe9WrIZCAbrcazj2rYc9hMFHO2LJz+Ed7fxvok=;
        b=JXUcaIRK0p6CqmFWvpEJNQfx51S8uEcWANR6u9huAn3jGey5FcSKuf/mXZ+GgCv+Dm
         sbOWe4SpWTIumI/EZV9KUC0HO9Zc6HFTZ9aVH1sIOAhRMGMfT7qY7k4/frmMrYOCfx1g
         ZJ+N9oqSTj+yN+ybpFy5dovfCDZWHCi1tzm65a56mCuptDEmsTcW+MkBpA/pqH4CP+ny
         WeTIDLHguuwn4eA56H4Iwe6uWtnE5zfJZLj+y2cz02FQTyGQoWtK2jw4LAdNe6/3T5Kv
         6NhTd33wSRczoE9G1yL3QpL/wgtkme7Y9DvEAYHc4nP22BSIAI3encqZfS7PF9xdhEfE
         qxLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeEJJMlk13KsB5LwXKnDVRa1irr0uL3SXRHF0lKkzaTXiA19hS5TuGE3aoUTtckLMq/PeWqNrJluwfm0EoXdff1BNZ3m1iNATlgTkMgP/tHUqYpwrjIHzn7MQ0wFQ87ksPmiTlxfMd+9ATjW99iGoueVzT/Cu1lK6Wcd/HhLwCa+yjX3ZLxJygK3S8Yoe4CrlprzR6idlws0vn+s9AmCKLIA==
X-Gm-Message-State: AOJu0YxDdx5/NSX33PjBV5wH0pw2TWllmEjTA8Q5N/izBQOdRt68ASnZ
	NDHMxZydfsgqzhc8pygKgXBX2Hb6VlMkeLhEkqn+urK6bPYWjZ8N
X-Google-Smtp-Source: AGHT+IG/GUeqabU8ZjvZRSRCOteowuLlcjS4ESz2/EbniniNL6YMrlAifUs32d0i0+teK0sbm9sTzw==
X-Received: by 2002:a05:6870:9108:b0:21f:c734:5b56 with SMTP id o8-20020a056870910800b0021fc7345b56mr99136oae.4.1708710146231;
        Fri, 23 Feb 2024 09:42:26 -0800 (PST)
Received: from localhost.localdomain (070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id rb7-20020a056871618700b0021f6a2bd4b9sm1257803oab.3.2024.02.23.09.42.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Feb 2024 09:42:26 -0800 (PST)
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
Subject: [RFC PATCH 03/20] dev_dax_iomap: Move dax_pgoff_to_phys from device.c to bus.c since both need it now
Date: Fri, 23 Feb 2024 11:41:47 -0600
Message-Id: <8d062903cded81cba05cc703f61160a0edb4578a.1708709155.git.john@groves.net>
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

bus.c can't call functions in device.c - that creates a circular linkage
dependency.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c    | 24 ++++++++++++++++++++++++
 drivers/dax/device.c | 23 -----------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1ff1ab5fa105..664e8c1b9930 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1325,6 +1325,30 @@ static const struct device_type dev_dax_type = {
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
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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


