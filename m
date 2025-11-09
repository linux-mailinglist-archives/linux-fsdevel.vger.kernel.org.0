Return-Path: <linux-fsdevel+bounces-67579-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59665C43CDA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 12:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14364188C45B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 11:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C242DC79A;
	Sun,  9 Nov 2025 11:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PzRzahBw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79601272801;
	Sun,  9 Nov 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762688834; cv=none; b=SRnPGD0e0RXRZoVhzfanF2QSF39DNBL9WwFzb6+6JF/yJaEZsCb3BT0XC5nxAYQxVG+iBsDG1dzOlxRTI+SHr36pGXS3oo7PL/xpINVAk1mMaMKp3escycqnr9zwCey6UKoWJu06vjXOkmFeqfqAEe3/lDbCN4mrZN67TH4azWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762688834; c=relaxed/simple;
	bh=TGbsIJbNdmZDoghwpLH5vb7hIw6MrViTyBvoEOlSxQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IovwMywg+rNtaaFDZ9e7ImLKdirqM8TKoqugNYDN1J7H/2OGrZMZvG9MA76IDPgvnDrRJpwzfgJV0pL2kXNIWccbCJxdQ4jkhyCUPX+IVuU8lNqtfYeyJzQlHxH5SEPrSxBGM1RsnqLnVRS0rOSGshQDbKeP3MOluveEVLdvRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PzRzahBw; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762688833; x=1794224833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FnH+XOeMpGV+rIc6L0kniRTBsRQVu5GU526boyROU3A=;
  b=PzRzahBw+juIBN/D+CrIOp7zzB9UWL9YHv2skYjeKplJ2L2hROBrMZ9y
   9q9INuKJV30VAhb4ghBrYqr3uWHUnNNSnQgo6H4nl8bZB2q2mixVfk8GX
   ai/bTPGnW+kOVLZjvNXk2mf0QDaw8f6O2CoM3rKhEt8Vqegc7fyodBXoA
   StfYZOnHkhVDYx/IpLZWqoxPKhWv8D1s4sjoVI9Y9zpU8QAPUYi/tvzco
   vxKmhkn0achcf0TIRRFYnS37o9jaaktHY/Nm8wqjB1T7KuPiJhDERv7oz
   fVc4TBYLBoABTwYi1+PvbIexzI69aGunwTkzAaieCpFqDc4gcuME70GUQ
   w==;
X-CSE-ConnectionGUID: P7BRPApNQ3CsxQ5GEntzWA==
X-CSE-MsgGUID: XuE1YFYPT6W/VeQKBjpq5g==
X-IronPort-AV: E=Sophos;i="6.19,291,1754956800"; 
   d="scan'208";a="6525068"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:47:10 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:12405]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.49:2525] with esmtp (Farcaster)
 id a48445c3-2db9-4804-9d90-8e6dec0a1b66; Sun, 9 Nov 2025 11:47:10 +0000 (UTC)
X-Farcaster-Flow-ID: a48445c3-2db9-4804-9d90-8e6dec0a1b66
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sun, 9 Nov 2025 11:47:10 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Sun, 9 Nov 2025
 11:47:08 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-kernel@vger.kernel.org>
CC: <farbere@amazon.com>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong"
	<djwong@kernel.org>
Subject: [PATCH v2 5.10.y] fsdax: mark the iomap argument to dax_iomap_sector as const
Date: Sun, 9 Nov 2025 11:47:03 +0000
Message-ID: <20251109114703.16554-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7e4f4b2d689d959b03cb07dfbdb97b9696cb1076 ]

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Eliav Farber <farbere@amazon.com>
---
V1 -> V2: Added missing 'Signed-off-by'

Fixes:

fs/dax.c: In function 'dax_iomap_iter':
fs/dax.c:1147:44: error: passing argument 1 of 'dax_iomap_sector' discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
   const sector_t sector = dax_iomap_sector(iomap, pos);
                                            ^~~~~
fs/dax.c:1009:17: note: expected 'struct iomap *' but argument is of type 'const struct iomap *'
   static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
                 ^~~~~~~~~~~~~~~~

The issue was introduced by the cherry-pick of commit 8df4919cb921
("fsdax: switch dax_iomap_rw to use iomap_iter")

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/fs/dax.c?h=v5.10.246&id=8df4919cb921b28809d05feae3e98dc5d8b48146

The upstream change made callers pass a const struct iomap *:
   const struct iomap *iomap = &iomi->iomap;
but dax_iomap_sector() still expected a mutable pointer:
   static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)

 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 91820b9b50b7..2ca33ef5d519 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1006,7 +1006,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-static sector_t dax_iomap_sector(struct iomap *iomap, loff_t pos)
+static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
 {
 	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
 }
-- 
2.47.3


