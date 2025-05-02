Return-Path: <linux-fsdevel+bounces-47955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7577AA7C9E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 May 2025 01:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55DAC1B66112
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 May 2025 23:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC342222D4;
	Fri,  2 May 2025 23:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UL7USB42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA7216392;
	Fri,  2 May 2025 23:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746227593; cv=none; b=oDPWzDgZJXegQ1VFJNyaiI0zdcYYIWepxxZePb5eroQfrR1YbKamLV9wTv+MuwJo751HJ6ntqYtrirh2aib7t6GtSri5MK/xteWLHV/TN6i/xFA6h7a1gDkYKjhzYDO0DopIV6f9j28zS8B2H2OzZgfnrsxm2d8fvM6Mj55pRsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746227593; c=relaxed/simple;
	bh=QYP6lnCShPrtTgzkde6VITbgIrA70+3QGCrOmt1wYWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3B6eevCYgjjHhP2SlXLBWLCEc+Nc1QJj0nZYb4ZzjwDKbwtVTJftCK/QIXtH5r28hoXNkE6owrgSnlNCd0Q2aT27dsGn+WRZ3x93Vnnp4BqBUbFzOJAeKzaj/t7nG0XF4rvgU6ATONchg8u1z+VAAoflmxE8ld0Uy19JGqehnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UL7USB42; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7xZlHB96OdbsZaadFl1ZFhCP7efudJCxUbyl8Hjq7Dk=; b=UL7USB42ja/xg2QvVFYXQUTMgj
	BFhH8t0FKunrNRA+uM1gqFMjAvHTN/J9S0kz+P9r+i0EsiGO8f3HAE/HfU1cKhCz177Rz1JfACrOw
	UiiOuE+cqPIh8afcmHkX+JoyAy/rDSVaHbPmJxEcKKjOqCIDeCCroqE4ByiB2z0K26gRCVbl9flqO
	sod2DlawYKujJLfwOZJ/36LiNsgC/zZJBtXYT7rm5lfEVxTuls1DKUSNpEMjQJ96sK6HAOD7ITJQB
	thuko/0aZpgB40AeA1Lo1sD9SNECIN7LJs/0CKDmGDTjrqzOlWwTcPXT/vlhtgJl/XosNpPx1Skye
	UnhcMHjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAzZ7-00000003DHD-2UoX;
	Fri, 02 May 2025 23:13:09 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: brauner@kernel.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	mcgrof@kernel.org
Subject: [PATCH] swapfile: disable swapon for bs > ps devices
Date: Fri,  2 May 2025 16:13:09 -0700
Message-ID: <20250502231309.766016-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

Devices which have a requirement for bs > ps cannot be supported for
swap as swap still needs work. Now that the block device cache sets the
min order for block devices we need this stop gap otherwise all
swap operations are rejected.

Without this you'll end up with errors on these devices as the swap
code still needs much love to support min order.

# cat /sys/block/nvme3n1/queue/logical_block_size  16384
# mkswap /dev/nvme3n1
mkswap: /dev/nvme3n1: warning: wiping old swap signature.
Setting up swapspace version 1, size = 100 GiB (107374178304 bytes)
no label, UUID=6af76b5c-7e7b-4902-b7f7-4c24dde6fa36
# swapon /dev/nvme3n1
swapon: /dev/nvme3n1: swapon failed: Invalid argument

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

I had posted an RFC about a heads up about us needing this less than a year
ago [0] and well, we now need it for v6.15 since swap code is just not ready.

Christian, this should probably go through your tree.

I tested it on a LBS device where the logical block size is 16 KiB on
x86_64 and confirm that while mkswap would swapon would be rejected.

[0] https://lore.kernel.org/all/20240627000924.2074949-1-mcgrof@kernel.org/T/#u

 mm/swapfile.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2eff8b51a945..c24ec16dfc7a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3322,6 +3322,11 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto bad_swap_unlock_inode;
 	}
 
+	if (mapping_min_folio_order(mapping) > 0) {
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
+
 	/*
 	 * Read the swap header.
 	 */
-- 
2.47.2


