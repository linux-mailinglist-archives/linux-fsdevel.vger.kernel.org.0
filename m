Return-Path: <linux-fsdevel+bounces-19984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C728CBC70
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E753A282AFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790EB8061D;
	Wed, 22 May 2024 07:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="CmV4swUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from jpms-ob02.noc.sony.co.jp (jpms-ob02.noc.sony.co.jp [211.125.140.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC5080025;
	Wed, 22 May 2024 07:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716364385; cv=none; b=kH2+3v54qm0fDZniCeMJUQvyOcY3w0mKR1r+A0FqkmwQIw314h5gwbplis65lH5ecsg6K/2pudP6dkiDcdwulhOTjRBqc02Udln4pe7GczJLA2TmWd2AMpInWOnzTMKSxkL3kP+6+M6VynjJCRApH4+U0S6OnOpNl0dG5em0S/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716364385; c=relaxed/simple;
	bh=u/nje6kivX57y9Efk6JRMSDlSj6Fx4OLxIkreKTXcoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NA0eexVsfFEmwDl9d2XOixoPK6iSaWmvPeQrzyw4Izotot3p/BnXslMbldeE+fIodQGwKpVw7YwkuZq/0+46EoCM0DRL3X4Gua3YcdAgARmce1oNeOpX8GBtJ073Z02nLli8RM49dh/YqQ/rGhZ1sgDIROybbTyQnXCXJ6NjCoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=CmV4swUx; arc=none smtp.client-ip=211.125.140.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1716364384; x=1747900384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ATSJTIQ7YlfNHhI2J03NerUHdvI37i6ERHqni1M7vn4=;
  b=CmV4swUxDU6eAPw5sx0gh/dW9eZuRbnPUkIcMSPf4vxeaktqcXm2TV3O
   +fRN8TZz6beWQzjwYsdWwZ0NqsiZKtlqecPjl1Kxx5A4SFrc+/dvZrBxn
   Fh0AfIbnqSGugxLB1nc5GQxFVxXfxrWvyuQ3sM0rggroSKvRJZP6IVIsH
   akd0nA1WbIjvNHJpNSwmWwYC/p9Vy7/ygwcfm4qh2M3yzuRdU49Mceioj
   BfU6Dj8s6ZaKkVJAJYF6CoE+Dlv5tsrpyD3DYT+yhX7Idqh+/jn5azoH9
   S8JFvAEYmMU+QC0ZOE2L75k25A+jkpioomUCNVgDVYG0trtK/U2z84Kup
   A==;
Received: from unknown (HELO jpmta-ob1.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::6])
  by jpms-ob02.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 16:42:51 +0900
X-IronPort-AV: E=Sophos;i="6.08,179,1712588400"; 
   d="scan'208";a="415026696"
Received: from unknown (HELO OptiPlex-7080..) ([IPv6:2001:cf8:1:5f1:0:dddd:6fe5:f4d0])
  by jpmta-ob1.noc.sony.co.jp with ESMTP; 22 May 2024 16:42:51 +0900
From: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sukrit.Bhatnagar@sony.com
Subject: [PATCH 1/2] iomap: swap: print warning for unaligned swapfile
Date: Wed, 22 May 2024 16:46:57 +0900
Message-Id: <20240522074658.2420468-2-Sukrit.Bhatnagar@sony.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
References: <20240522074658.2420468-1-Sukrit.Bhatnagar@sony.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When creating a swapfile on a filesystem with block size less than the
PAGE_SIZE, there is a possibility that the starting physical block is not
page-aligned, which results in rounding up that value before setting it
in the first swap extent. But now that the value is rounded up, we have
lost the actual offset location of the first physical block.

The starting physical block value is needed in hibernation when using a
swapfile, i.e., the resume_offset. After we have written the snapshot
pages, some values will be set in the swap header which is accessed using
that offset location. However, it will not find the swap header if the
offset value was rounded up and results in an error.

The swapfile offset being unaligned should not fail the swapon activation
as the swap extents will always have the alignment.

Therefore, just print a warning if an unaligned swapfile is activated
when hibernation is enabled.

Signed-off-by: Sukrit Bhatnagar <Sukrit.Bhatnagar@sony.com>
---
 fs/iomap/swapfile.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 5fc0ac36dee3..1f7b189089dd 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -49,6 +49,16 @@ static int iomap_swapfile_add_extent(struct iomap_swapfile_info *isi)
 	next_ppage = ALIGN_DOWN(iomap->addr + iomap->length, PAGE_SIZE) >>
 			PAGE_SHIFT;
 
+#ifdef CONFIG_HIBERNATION
+	/*
+	 * Print a warning if the starting physical block is not aligned
+	 * to PAGE_SIZE (for filesystems using smaller block sizes).
+	 * This will fail the hibernation suspend as we need to read
+	 * the swap header later using the starting block offset.
+	 */
+	if (!iomap->offset && iomap->addr & PAGE_MASK)
+		pr_warn("swapon: starting physical offset not page-aligned\n");
+#endif
 	/* Skip too-short physical extents. */
 	if (first_ppage >= next_ppage)
 		return 0;
-- 
2.34.1


