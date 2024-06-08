Return-Path: <linux-fsdevel+bounces-21283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9757F901210
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 16:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332191F21EBF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C083117B402;
	Sat,  8 Jun 2024 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="n+yonB1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828F817836A;
	Sat,  8 Jun 2024 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717857358; cv=none; b=QVJjP+avOP4q41nWD/OP4WozBxxOpVRYDvNZDaAcojkJthmMbQSd/mezErmKfxCyA25gDJfHFSrIBizfHzfVIS95jzjb3uEJ+rGB0RXduXPifrvap+HhveJJZ2O/RXjNFbZ6Wi9VNDzFsJrknPmUwRLCDSJptpZKNcP611MYAsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717857358; c=relaxed/simple;
	bh=Gw3IHsF8xwkAd4RVR6D2AlTIiy5xd3jFHG78ox0JiaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozAnevETDe5Z0TCmPzPdjMPfSNbkRj/Iv2YrNzb04qa+DYv5kgLHR6CNjnMxV3cbNuArsDiRmNfi8DGY4paka5LymsO/aeZOD5fz37YE/VWRu6K+jwBSwSklsegmH4AC3THgj0cbN3yrDQVZDNZJNzxk6PoXl4QzxHpQ2k2WIVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=n+yonB1f; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id Fx9Rs04TztVxQFx9fsAXpW; Sat, 08 Jun 2024 16:34:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1717857291;
	bh=fNkS2pUJH/530BOXMXUfzjEuADK4W5StN8pRfow5/4g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=n+yonB1fz172Vros/qBrBgV+34VqIPu2Ma2lTpEMPK9plDEW2RWqUEVfatlzY/J8X
	 iZtRHxcosamF26qyzxYpUXxSp4UlxHjvK39lM+AOhJ9Dw64B9qZcz/FBYE6hkYYxEo
	 GPWcMlAh+5DhwRerxD/2Q2iF2Lu2euHB/szT7szFNiK2IaPJHAdZUHAsXLP9P6B7R8
	 voeGdNC36i88uUkKK71xipDXsmpnJjX/9fKOEGfzTQWIN0dh6Sxh2nNIdoJ3UUFgsV
	 oDKYxX36rx5ivekm8kqkwEiMsG/rY2PIqjNu1g8mTFWBIjpu6NzmjixWfckYMAFBSM
	 bVA8C/e+Uy9ow==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Jun 2024 16:34:51 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jk@ozlabs.org,
	joel@jms.id.au,
	alistair@popple.id.au,
	eajames@linux.ibm.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsi@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND 1/3] fsi: occ: Remove usage of the deprecated ida_simple_xx() API
Date: Sat,  8 Jun 2024 16:34:18 +0200
Message-ID: <8e28b0c45fe8f28ca4475fe0027f8099c41259f0.1717855701.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
References: <cover.1717855701.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So, this upper limit, INT_MAX, should have
been changed to INT_MAX-1.

But, it is likely that the INT_MAX 'idx' is valid that the max value passed
to ida_simple_get() should have been 0.

So, allow this INT_MAX 'idx' value now.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
---
The change related to the INT_MAX value is speculative.
Review with care. (or I can re-submit with INT_MAX-1, to be safe :))


This patch has been sent about 5 months ago [1].
A gentle reminder has been sent 3 months later and an R-by has been given
[2].

However, it has still not reached -next in the last 2 months.

So, I've added the R-b tag and I'm adding Andrew Morton in To:, in order to
help in the merge process.

Thanks
CJ

[1]: https://lore.kernel.org/all/6e17f2145ce2bbc12af6700c8bd56a8a7bdb103d.1705738045.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/57291e66-fb7d-4ef8-985e-7e85866c90bb@linux.ibm.com/
---
 drivers/fsi/fsi-occ.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index da35ca9e84a6..f7157c1d77d8 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -656,17 +656,16 @@ static int occ_probe(struct platform_device *pdev)
 		rc = of_property_read_u32(dev->of_node, "reg", &reg);
 		if (!rc) {
 			/* make sure we don't have a duplicate from dts */
-			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
+						   GFP_KERNEL);
 			if (occ->idx < 0)
-				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-							  GFP_KERNEL);
+				occ->idx = ida_alloc_min(&occ_ida, 1,
+							 GFP_KERNEL);
 		} else {
-			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
-						  GFP_KERNEL);
+			occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
 		}
 	} else {
-		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
+		occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
 	}
 
 	platform_set_drvdata(pdev, occ);
@@ -680,7 +679,7 @@ static int occ_probe(struct platform_device *pdev)
 	rc = misc_register(&occ->mdev);
 	if (rc) {
 		dev_err(dev, "failed to register miscdevice: %d\n", rc);
-		ida_simple_remove(&occ_ida, occ->idx);
+		ida_free(&occ_ida, occ->idx);
 		kvfree(occ->buffer);
 		return rc;
 	}
@@ -719,7 +718,7 @@ static int occ_remove(struct platform_device *pdev)
 	else
 		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
 
-	ida_simple_remove(&occ_ida, occ->idx);
+	ida_free(&occ_ida, occ->idx);
 
 	return 0;
 }
-- 
2.45.2


