Return-Path: <linux-fsdevel+bounces-67578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21DC43CB6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 09 Nov 2025 12:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA0188A64F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Nov 2025 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DD01F12E9;
	Sun,  9 Nov 2025 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rB+J4r2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10472DAFC4;
	Sun,  9 Nov 2025 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762687933; cv=none; b=UMtbzdpgWl0ax27hVDKwXOWxhLGOVXTh2y8CA6QpA0svP3PY7g5+W3eKA3ArI0eXQ6879FznIZ6CSbXDqqr6C2JkL3lJVV3D76Am6rjuvfqoxC1C40KU4v3WM66XJddDm4B8+2MJy0xqvknkXmSRsiePiFOkGkjJZKckIZ5zUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762687933; c=relaxed/simple;
	bh=6r0eF+WH1mot3ni1/RVKSUt9cGCRPn7R5QzoB+OxGMk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbAu7iR0zhvvkCFC5IApKCnPWW8GU/ZY13RgV4bjGU9cqsGzU3Y0b5XXsA2hzOrQEWfz/TcxNxFMonoGifmAw5vS8/QplDUV+ivh7/teUxNaJvzxHkJbpPtPdt6UvXtjdd2ZIcd8DQjMMHqiQJY0LeiuzTsTZIQDJNDNiQz6lAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rB+J4r2V; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762687931; x=1794223931;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jgvQbpAKKBmkhlenj4NFNbBd7PeB0015JyRabKipVf8=;
  b=rB+J4r2VMuwGgUkRu5vVc4eFr03en4lkTr6RF7aIb3iK/p3YVoMI5Qcl
   WCIZ/xhGbX0iTr2I/Jl8FQ99+qPKeUcpWROGqxtqlYK/ogx99gdKINR+f
   sEo0KKUEShAXxIeUdDKCrH/mDfuEsmkwrG/6fopDK/2HBrf7mi6Wx3DQI
   SyeenCNzV15hxy07Bh64NSBiYP4uAdtuyMfmT3YPZWjQQzFGGsAbbfSw5
   k5D6NkvKyreVtqrQC0VhAGNjWk7uFs7jxBy82MOzTU3aMV86W/BzACatU
   CrQLLW8kD3V7hvrxGDYHw4UCdDREWouJOrtqn1nm8pktU6t+9llzogc4G
   Q==;
X-CSE-ConnectionGUID: 2RvX3hwMTeKvhR0HgKXa/A==
X-CSE-MsgGUID: SScG/Nk8QdiQzrMMzQpYbg==
X-IronPort-AV: E=Sophos;i="6.19,291,1754956800"; 
   d="scan'208";a="6594050"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 11:32:09 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:11584]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.195:2525] with esmtp (Farcaster)
 id 4656579d-2873-4fac-a161-02da17491e34; Sun, 9 Nov 2025 11:32:08 +0000 (UTC)
X-Farcaster-Flow-ID: 4656579d-2873-4fac-a161-02da17491e34
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Sun, 9 Nov 2025 11:32:02 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Sun, 9 Nov 2025
 11:32:00 +0000
From: Eliav Farber <farbere@amazon.com>
To: <gregkh@linuxfoundation.org>, <stable-commits@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <dan.j.williams@intel.com>, <willy@infradead.org>,
	<jack@suse.cz>, <linux-fsdevel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
	<linux-kernel@vger.kernel.org>
CC: <farbere@amazon.com>, Christoph Hellwig <hch@lst.de>, "Darrick J. Wong"
	<djwong@kernel.org>
Subject: [PATCH v5.10.y] fsdax: mark the iomap argument to dax_iomap_sector as const
Date: Sun, 9 Nov 2025 11:31:51 +0000
Message-ID: <20251109113151.48263-1-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 7e4f4b2d689d959b03cb07dfbdb97b9696cb1076 ]

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
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


