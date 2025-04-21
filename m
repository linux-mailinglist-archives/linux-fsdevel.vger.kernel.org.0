Return-Path: <linux-fsdevel+bounces-46745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1D7A94A2F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 03:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE5A3B035A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 01:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E74612F399;
	Mon, 21 Apr 2025 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7wo08gL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604173176;
	Mon, 21 Apr 2025 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745199241; cv=none; b=C+nJp3bGRK5+rY/13UAd3wBL4NZBqgzwB1y1SYbcSRHKDssmjMxpY/k7ZQ3Ysa/tbBCMu2TgPOWbDgWTKRkgjfvAjhqu8aqmTC55oPFeXCVxYlMT2/ue+hoOXKAZlyUFBGyN02JtDuvwIw4IXJHOYTscbZlu54i4kU/yYhr1mFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745199241; c=relaxed/simple;
	bh=r7zU/NI6k0w2nK9GLUrhezJkiaHouNNrUAqAk2AR65M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VXiAb9C72aiWHor4OH42r88I2ubqgOfb2TutnsnuWXRa+mnjhhFHiRPcU9HOQqKg+T9XVVDTJfmYmSyRSLk2Vf2GZewLbEFTZEUMFks9GJtNlkxK24IrkXez+LsNcGd4ltjZB8LAxHJV6xxEN/UP/U9Qwe8zAMn7aQkqtlzxJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7wo08gL; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72bb97260ceso1235611a34.1;
        Sun, 20 Apr 2025 18:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745199238; x=1745804038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TgC0a/U5AW9OV2eqK8aHn6K3OlQMlAMMt+8AXwopR0=;
        b=A7wo08gLFUB8loQKCQOwE8hNHMoZiB0swSWh8EEIrzq2ZIWHrSYE+0nK6IsWB7JNqb
         KkjypUCxqrFxvnw9wzDSf/SOJh2zPugd6eHBcXn7w+gGrEFZmWdXIBtn0Lz7DzIUeQVH
         bX+UX+NsMCPuvtTw6/nnTQREt/915BzuYVfZ8aAsRBsjFVrgH5YC30SWbxpptExLo/3G
         gBsRxs8k3nYssjHV/jGFaH1DwOfqRHUkXmGDPzjNuMnpk3Qny0igHz8Ya4LNfBtf0sTN
         v9+Na1B9IguRZjQh+Vi/fezOrfeiZ3XClswBJDavtR6GmxBpCqSVJpmas97xMarPfUil
         zOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745199238; x=1745804038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+TgC0a/U5AW9OV2eqK8aHn6K3OlQMlAMMt+8AXwopR0=;
        b=P0XcXkKVCMoUDasG1oP/dLVX2ZEGNtsKlTg2WlF15OK7srJnjtuVYthrFk6/sN4ktU
         k8NeLDoQilUemxODaQsEM4aInW6mmWwMnjbPeeSgDaBuiJkk1+kJMN1h8joIHoLjOGMi
         3eZqirdY+9gnH45+iXAdFLqp7BRBmVjFE9Sug1vi59CE89YNias8b6SEHaGRf6cq5p3z
         ufxm1pbbRrAh7OPmpHSdyx2W78tLZ6OvOjQ87pPNHVNA0I7CRvUn+aCz7Qo0DgQHhDpe
         4YeqcDpghzI74aRw76PODYxhRNKCAaClAuOUtAs/dm8YN7NQNHhm+nWv8AzfdHbFmDus
         KasQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9urrWTnzLjhMe8u9PqY7gBEmyAj6r9w3xDrvc/FjzI297sh4P7wvA0BOWYcjoKuSIMQ1Uzgz2j45m@vger.kernel.org, AJvYcCW6hpZUSwC+Jr2vvV5b8PcLO/Mtd0s6axjwsDHDKM0XEkfCAVeJ0U1wC/ztbpESlizWbIGfDLBxwpdlHpjd3g==@vger.kernel.org, AJvYcCW7YhiHXsvjY/299sO6o4et0Lrhk4cAKpMnC4lEX5xWdkFMj6egsg8QAftaJtr8zndrOAeDJiT9pkX+Q3tz@vger.kernel.org, AJvYcCXsgquvG7HCBI5w/YNrNxRGLZPUkRfroAZ12aWSZ5ruVbvBpsiSiE6x4PVMSIq98MXTAZFBDYNIgMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHid3krvPxdeRpjDvsrWQqsJODm2hZDY4q1YnnxJuA2WPy7hdV
	Hsg3EGXZQll2b9dxcZxfc7+UqDFU4/OIFpw/V2L7a3Ft5XKMVK5K
X-Gm-Gg: ASbGnctyfVLzUtdA4gteD5hCqWUzl5AYacVw7zukA2UFWLm2rZCML0uzBpGkX+Z5Csj
	W+crD60mfGovTIlyRMsR6V5nZpyOh6ilNBFOVBiC+YWJYc4qaEdTMV5mSu2vW4r1L5HIFvkx0lG
	8qxkwoduPbTDC/JLVXPaQhHlbTKgbNq1BT9nSUTPOY5nMfvRpV2fXxaCUtW6qkBsiFMfLKWZMXB
	R39SLGVT0lRXBw/fRhJLLuqEbT+vx2ZyV9vT3PV9Ssn3nKZwq040cOCSqc3IrGTTAjkxIHi0Quy
	gQDPH6+jpqXfSO87wVI4Z62inmq6SjVrmHHYW+Vl0iZr4HHZadysGM6yiS9GinaLPQFS6g==
X-Google-Smtp-Source: AGHT+IFBx0fNmEgiQthzAlpMH4F40IVe6eGZu2FBLlSysev0+wG7SqfOtkvNjIGeE/XEwgNUmsfiWQ==
X-Received: by 2002:a05:6830:3483:b0:727:4576:36f9 with SMTP id 46e09a7af769-730061e81edmr6260327a34.3.1745199238227;
        Sun, 20 Apr 2025 18:33:58 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a8f7:1b36:93ce:8dbf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1267588a34.66.2025.04.20.18.33.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 20 Apr 2025 18:33:57 -0700 (PDT)
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
Subject: [RFC PATCH 01/19] dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
Date: Sun, 20 Apr 2025 20:33:28 -0500
Message-Id: <20250421013346.32530-2-john@groves.net>
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
index fde29e0ad68b..9d9a4ae7bbc0 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -1417,6 +1417,30 @@ static const struct device_type dev_dax_type = {
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
index 6d74e62bbee0..29f61771fef0 100644
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
2.49.0


