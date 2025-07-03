Return-Path: <linux-fsdevel+bounces-53824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B0CAF808B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4669C4A5B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 18:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D532F2C41;
	Thu,  3 Jul 2025 18:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rm7AkplL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400ED1C5F08;
	Thu,  3 Jul 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751568643; cv=none; b=CIJg/tfcWFLAKF6o/IcSKnhkZSQi3tNpfrMRKpZH5uKlOgIjzxvHNrMYgLxO7pyR55tNI99u2gC0RvHN7cY+sXEsuV2HmrbK5vtYIp2s08jAUSRr1L2ljtC/6VD4L2DIZZUaKtPY2jM+n6RWANsjyoQefeESbZShvxxsHVBgI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751568643; c=relaxed/simple;
	bh=r7zU/NI6k0w2nK9GLUrhezJkiaHouNNrUAqAk2AR65M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bfEeFWVJXbThRHzG6JY0YMMajLCiPE5k9aKo7PPzpSxxoNQMLEyJDPw8YDH6tR2dhJU9b5vo4EdQkXJUJWUOJMzpuidwbzK3+x2nsnYnctVXLaaLeOsOLilcJWugtde4aRYaC0Vvc7+tnSEP+FGQu9uicXFjxU0wHON2uV8wgak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rm7AkplL; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-73a8d0e3822so140869a34.2;
        Thu, 03 Jul 2025 11:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751568640; x=1752173440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+TgC0a/U5AW9OV2eqK8aHn6K3OlQMlAMMt+8AXwopR0=;
        b=Rm7AkplLu4wGTMQIB7Wm2tb5yA7YLMTf9U57qbrjhm3dCel/vvL+vV2vJI1c/IkdWC
         hIuPpUZJ1cvGFspWSHzI0pEsVbLzYb05kVtDZNT+aAFG9DThiNITZxNanoL5goPkWjw0
         QegdJy5jxFumdJe1h3fPpmIIYuxstRxGg2sS5g3CvcRbD0xDoEw7smZAJb6AN5q1qqZR
         9F3+hXJeOclNWwi1LERi1MXloQ4xBW9zWl97o1YpTri+WhtP+kVSHahvcIHPruiAvtvd
         rOmSlP42wpQI/LRm3gxpIjFOoUbYHz3YgOLb2TUEKhZch9OJ92DEmMzNsnKtWh94u66s
         axDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751568640; x=1752173440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+TgC0a/U5AW9OV2eqK8aHn6K3OlQMlAMMt+8AXwopR0=;
        b=I6DMORXXSysqSGWxCTPOYUCdSHrlSWGbjzbfNiTY6Wv9bSJEUQ56Xh4DRt684YAKN2
         Osz30dpaHqure/wUDe2KTRSclurOJ5S0i+dSiieknccTq7GGfHxnwHcskUBqpCKXt1hG
         n/vnpqjLMjOUvb2FhhJLjNLE1HX5S56olVPHmrBBG6/IbGy427dSpmER2x/sxBFEVquo
         1g4reBcH275IgX0L/bNfq4wrv+Bdcyr3PtytMqWXZmvoAxLOm42KDUBaehyW6UdAkCmk
         YPiXMFlO4aJWmRL9WujhUATqr/6k7njt9tA/vMPR7W4Uu2h8cVLv9ScxsEnXMaoecDFx
         jZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPrWFgb0bCTIhq6WEPwKeMmskhvN/IjG4l6Vi9lJbms5rMWKBapH1qkge9cEy7effLCYd4G+G6HrI=@vger.kernel.org, AJvYcCVwQxNIgHPCBrHrxZBKckkYzZexU+m/XulCr6g8n2mluT2GK52ar59x4mwrr24/0jZoMiHc5Ha2E0uv@vger.kernel.org, AJvYcCXMJuIWQTt5IGYM86LA6u4C871tFXCKQqRjV2AyPy21CTLdMNOyWfGQZdcN/TTS4PJE5oYNxY3VBzq9TXP1@vger.kernel.org, AJvYcCXwwonuSB0ahPwOZmSDCPQgQ2COIILA7rOknbgwPpMhTWNxWEhpLk/yoAl88MRMvgE50C21Mrv9vwVQ57gAgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzwhVdtGCLNMajT8WG1f76CdneqvCHW3vDK3XmttswSmQvTQWI
	0jK+iO4UaDVSnobzgxEgOuMUM+9+NRhP+nAeYyL5/yXYYtZijrhJNXKT
X-Gm-Gg: ASbGnctO4It7lR2v+j9epOms7VpSKbCgvhACxtHWEAsnJuwt/f8rc2PwO7xZqH/L1Oz
	FmhWsOZgkIUkerB1XZLmmq0ozcLZJjaAxf4DkO1WkcFL9s2RRrxiqEx12BKEmxdyq6wnSCFIBYo
	6R+1P7fx8QrHUPuyr8s9UJoP0lMRO2u0iI8v67mbRWzzHUHa+LeEcakEvz7hwQFlOumO1+Sy3Oi
	xVvzZv6wbVZE1KQnUj+WtpjyB37eD80YBPDYAOdLfzUz0egBTZ+GvSp8dS6JwylTmgQIQEL6hu1
	KFx5i9EIA2I1cp/obhUolCbhV/tOh8mnvObCR7j5EM4Eq+zuttTOcF1iyjbkB8MBTJPgfi1M2vR
	Rxj7DHAoV3pxPJw==
X-Google-Smtp-Source: AGHT+IF73hX0JJIFBHibtD6A0+6uqUWfKLCEXmyBw6pOmIubhMzzPV9Jpbwsi9M9zd7Nm7jge6Jo8g==
X-Received: by 2002:a05:6808:1b07:b0:404:e0b3:12f with SMTP id 5614622812f47-40b8876eecbmr6495647b6e.11.1751568640087;
        Thu, 03 Jul 2025 11:50:40 -0700 (PDT)
Received: from localhost.localdomain ([2603:8080:1500:3d89:cd4:2776:8c4a:3597])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f90d1ccsm68195a34.44.2025.07.03.11.50.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Jul 2025 11:50:39 -0700 (PDT)
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
Subject: [RFC V2 01/18] dev_dax_iomap: Move dax_pgoff_to_phys() from device.c to bus.c
Date: Thu,  3 Jul 2025 13:50:15 -0500
Message-Id: <20250703185032.46568-2-john@groves.net>
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


