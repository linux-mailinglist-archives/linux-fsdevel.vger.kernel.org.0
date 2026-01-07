Return-Path: <linux-fsdevel+bounces-72637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB77CFEAE2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC08A30AB26D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5691B3A1D05;
	Wed,  7 Jan 2026 15:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hurcpro+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA2393DC3
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800028; cv=none; b=m8Vq9wRtpru+DeLZuqWteuE+raM5D30kCbm8MEajYekmQiCSPWkK0tLqlT6MW4PolV+QARIgw6UR1b7y3w4lGeDqHdUq5PTiIpUDzaum3At7fWNIA4UTAor2NckFBqBaRKc11D3IlD0v8xMYGEFLamvfYkk5QiBml+hR5cPLMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800028; c=relaxed/simple;
	bh=NuWusZLC5UQlkk7hlcFERKM1c2CGKJNdml11bqf0XyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecXX14VzbS5Jm5s9NDlPhkBVFy4l88zk+0LbNw+6Hj0Altm6I43Bj319pmzrb33RyZRBaJw4Uid1xkEAblkpshlyhnry3KXm6muTZhNCyfM8S6DC1RUbI4wd1y9QeRrx231by/IE+8vxqVrPW2RucqoV16HvTZzp00aUa06WALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hurcpro+; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=Groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45392215f74so1095273b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767800025; x=1768404825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmVFHvoo6qZY7RUGgdXNII0ab/XeZ6ETTaZK349UK+g=;
        b=Hurcpro+8LEtZ49Fvgl+naOUniaWSrr/jLSb8QJPmUHiYENbE0g0KrAFu25i91KrFP
         F717IoaxWysjYc99rZofw7HUlRRbcOiAOpnZMoIprDKPFaCQXEF4raacQxZb2jwrwMHv
         A5BPNjgo0p5Epru9PkGls/pD3t4qcIjyc/z3dARYelhNNqmNnAaYBvS1VZw4rw0SNJvz
         Ytw6LQAQDSg0diXBAUDlIbq97k3cDYRX64HyTPsL/M9Acnx9JX4bBVvSbxVvNt+F1shE
         gejKbtEcnf0PXEeVv1FO2oSoq+rFsNKxBT1WcY2fhmEvUFAE8y/Pdx1GF/quZi9JDls/
         jSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800025; x=1768404825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PmVFHvoo6qZY7RUGgdXNII0ab/XeZ6ETTaZK349UK+g=;
        b=DyMBdJm+iVVCvaZeBPuPcWOmBcCxszNjyctNizv7R8T55hyC4PifUZKPDsBuBx4JhX
         CVXhXJEISl0mtVC6xEqDT4hMWhWANpn+LLM4iBzYSZcoVLlx1sFJ7nV6ifbxFo6JgjEA
         zvCjFkvzqLCE1Q4OU9ep3tTk4Dzs9oQvSrzyQLSRD3T6XkWDbBxN+Sv3F84TbM9XqYb8
         3X2TRiKcNoj3VLoMgHl+++Wwe5BxbBVaLfvUbFpp9tSyqqYBVDLFgMpcdPCokOiuxKxU
         wRmmZUYTTCTHAoTViBH3mqROGxtGSFdmUvKVjgz1uChW32bxB8DWZ5kfTDrmJYudDbyH
         NuIg==
X-Forwarded-Encrypted: i=1; AJvYcCW8r8lbQ3rDRhMcuJgX8aYfMGWU1NIMjh2mZT1iJAP6Sue4bhj6IGcJwB3AyvQBCV5wlqJrHbvzoBoQgEQr@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJ+duMCPg3DmY0BJxbd4VSIyjzd2ZOZH1kSUr8TsS6jB87KBv
	IojxU2tEh3ZhCNh1Uv6BaL9OPobv534zrYIsid0zi1QP5koL5RB+l1U8
X-Gm-Gg: AY/fxX4p+r5EavMq7XEzloT+Cuxuh0sg/PJzgRxIEXV2mzkIbUfQZwNn4z4gwIcL39q
	ZT1Ju0e40+BjF7uotjb4ZTJpt7WGiYPyD+yFBGXfFllOOQ8negnBy4FbL/KgDN3eqm/kyKHoWpD
	TPqRfeR5g1xGlXkiagv/pxeSCoO6MrDA2m2mgx0Io+2MKWZAGu6nmOhakX98f5xC6dt3dkyYdJg
	XA8FK++YUnokBrL1xi/rjjUGUjig88d0GQEnFt5OtRKJ1L7x7qmgH4L0pGDWHz/fdczfB9jpthA
	GaHb3TdKEnkPR3onQ95LsOvdCGKPX2vS1gIv+8o6us0U+Uy8Lsu/IeRlf9/aGAnTAmS+QxGh3zS
	BU5eec2AClQ1cfiLpxI5v/+q19huOFrAreQ//UJDmXyOzHlIafTiHDW3NVQbt78ED1SnLhVuHR8
	ZyPDmvPEpWZD0kKLIp/mRDYPyF8OI7SnPPLTF2s6EDTYIj
X-Google-Smtp-Source: AGHT+IHkLI2SMyhkKOgLjFmL6YFwT+7moAdIUHTTTIFi2bmiuCeEJRn6ElXDVg0S7UXRPCs1iwtC5Q==
X-Received: by 2002:a05:6808:c2d8:b0:45a:5584:b84d with SMTP id 5614622812f47-45a6bebe564mr1179771b6e.32.1767800025297;
        Wed, 07 Jan 2026 07:33:45 -0800 (PST)
Received: from localhost.localdomain ([2603:8080:1500:3d89:a917:5124:7300:7cef])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a5e2f1de5sm2398106b6e.22.2026.01.07.07.33.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 07 Jan 2026 07:33:44 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
From: John Groves <John@Groves.net>
X-Google-Original-From: John Groves <john@groves.net>
To: John Groves <John@Groves.net>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Alison Schofield <alison.schofield@intel.com>
Cc: John Groves <jgroves@micron.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	David Hildenbrand <david@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Fuad Tabba <tabba@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Shivank Garg <shivankg@amd.com>,
	Ackerley Tng <ackerleytng@google.com>,
	Gregory Price <gourry@gourry.net>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>,
	venkataravis@micron.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	John Groves <john@groves.net>
Subject: [PATCH V3 01/21] dax: move dax_pgoff_to_phys from [drivers/dax/] device.c to bus.c
Date: Wed,  7 Jan 2026 09:33:10 -0600
Message-ID: <20260107153332.64727-2-john@groves.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260107153332.64727-1-john@groves.net>
References: <20260107153244.64703-1-john@groves.net>
 <20260107153332.64727-1-john@groves.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function will be used by both device.c and fsdev.c, but both are
loadable modules. Moving to bus.c puts it in core and makes it available
to both.

No code changes - just relocated.

Signed-off-by: John Groves <john@groves.net>
---
 drivers/dax/bus.c    | 27 +++++++++++++++++++++++++++
 drivers/dax/device.c | 23 -----------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index fde29e0ad68b..a2f9a3cc30a5 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -7,6 +7,9 @@
 #include <linux/slab.h>
 #include <linux/dax.h>
 #include <linux/io.h>
+#include <linux/backing-dev.h>
+#include <linux/range.h>
+#include <linux/uio.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -1417,6 +1420,30 @@ static const struct device_type dev_dax_type = {
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
index 22999a402e02..132c1d03fd07 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -57,29 +57,6 @@ static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 			   vma->vm_file, func);
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
 static void dax_set_mapping(struct vm_fault *vmf, unsigned long pfn,
 			      unsigned long fault_size)
 {
-- 
2.49.0


