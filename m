Return-Path: <linux-fsdevel+bounces-28170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB17967731
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 17:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E0A281E81
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 15:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9526D183088;
	Sun,  1 Sep 2024 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="lEXqHMKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCDE17DFE9;
	Sun,  1 Sep 2024 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725204411; cv=none; b=VMoEKQ5lwTJRODGdPtBcFeGnK0mCMROegamFGQL/MTSm4h18bdFADX4bYNl/VrxJY91Yl12QleFxInhEpwqCed/ebeDZE4Xnt9tXAAEmy7t4s9EjVJpSemhm7TtJfio+UyfXXDaS0ZSa9P5T58EsDMDgVqDOkkPXSVvFYZyFIB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725204411; c=relaxed/simple;
	bh=+oifxVqYLcNvH3TFN5BAAGfli+t14t1naa2f/ObStAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shAApzKfrbfXfMOGHjI8istTUzHit7F6tsOlkruVYVd64SMrLqlYbJWDWQ1ztFvVFzZm4mPor3r1ooii+Rll6q2lklLD6Jbf7uyk/s7VUJJExwPRuqFP2ksVAPcED5RvXImKDoXJMIqB2GVselMrzM/dEYlPAH3v4pEkIORfHck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=lEXqHMKr; arc=none smtp.client-ip=80.12.242.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id kmKIsidNBCul1kmKIssdEm; Sun, 01 Sep 2024 17:17:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725203836;
	bh=yMZLdMo/JqwLkmyPxql8GWXtKMmhtxUaz8IUp+tEwGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lEXqHMKrvk3EmUMskjBe4akGxwLbP0rxLetnREdXUjVchWkcVt+83IY6Di9th7+/W
	 hmdKIN1km+D8RNlUTl+s6bKTWzkFDHdJ/XUSYg0X9FNkryptbUV1hK0gCBqDwKOZyQ
	 UcgGwWi2EUyAEbncUgpZeePcvOzXZi6gpFJq/h3dJEGxzD/+K7pKiA1sNy7AIDHyNm
	 lJL8lP/ogPji4OfRZ5ufIj4fz5zCjrF/VH0fcbBTPeuy0sNHDrdeTCeEozw6SIjV6h
	 0opMTXGzRDc4FmZTv4E3+6fgmErNWl1LawAN5I5hLMkrYL9Mgmmzv4r3XloyK5QMnv
	 8ElmmS7NxMoFw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Sep 2024 17:17:16 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: [PATCH] dax: Remove an unused field in struct dax_operations
Date: Sun,  1 Sep 2024 17:17:09 +0200
Message-ID: <56b92b722ca0a6fd1387c871a6ec01bcb9bd525e.1725203804.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.dax_supported() was apparently removed by commit 7b0800d00dae ("dax:
remove dax_capable") on 2021-11.

Remove the now unused function pointer from the struct dax_operations.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Slightly compile tested only, but "git grep dax_supported" now returns
nothing.
---
 include/linux/dax.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e3327af4c..df41a0017b31 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -27,12 +27,6 @@ struct dax_operations {
 	 */
 	long (*direct_access)(struct dax_device *, pgoff_t, long,
 			enum dax_access_mode, void **, pfn_t *);
-	/*
-	 * Validate whether this device is usable as an fsdax backing
-	 * device.
-	 */
-	bool (*dax_supported)(struct dax_device *, struct block_device *, int,
-			sector_t, sector_t);
 	/* zero_page_range: required operation. Zero page range   */
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 	/*
-- 
2.46.0


