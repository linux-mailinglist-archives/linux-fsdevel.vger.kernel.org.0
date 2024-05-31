Return-Path: <linux-fsdevel+bounces-20609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FE58D5F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18E60B2160E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7787015099D;
	Fri, 31 May 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="oWRW3qCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE31420A8
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717150581; cv=none; b=uCdS5MAfJn7G1O42O1dJuXjhWPMj3YxHm3H7taW0SHdrsmJlpZ/GjdX83FiCeLx8xLTG7gd84U27g3wN1Pd+Wh1PpJ61KF5gaBXGUJgQA9FqCfoeVi1CrxXkphJzOov4yio+Q6o381HUb1fdSMFIRuzB8i/LyW/C3jb3JMbwg7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717150581; c=relaxed/simple;
	bh=QHgyjjJaCiC23glQhIuoKAJ2DmNT6bQlQnJB0Ht2ZpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=SoKiAsic97voeg8c5C+KpPB/h/QfG3RC8wgnrUqNyv/wyJZs3wX7R3UK7picmPOSz/ZnapRKs9WNB82L+edy1P8KenX42pJOBZk1KYkulUk1NIExruaL1ogNFziSv4oqdSJZKu+2AFOS3x4zchKtlqKARfBrDGeON8taqq7i6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=oWRW3qCV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240531101617epoutp046e50381a258825f8743f74c85a36a264~Ui1olJUNr1879718797epoutp04C
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2024 10:16:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240531101617epoutp046e50381a258825f8743f74c85a36a264~Ui1olJUNr1879718797epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717150577;
	bh=/KU+xOxNrt2ZnfYjFJ1+VO+CSsfLs3zgl8VpEFUWhc4=;
	h=From:To:Cc:Subject:Date:References:From;
	b=oWRW3qCV0QFNuHCCi+pkAhuHqUIH+LGMv2bP1VPZFwZcFswcsuk/eHwwumdovBrg0
	 ppww107fNIvCHCkVks5OV9Mzq6WdcXMQZzYkcfTvJL8ibuHr1LduRNvJ+z/ZWY4YKm
	 6QurtSXo6CltubY3RNZXCjT+859TgGPiZY8KBTQA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTP id
	20240531101616epcas1p3ae240bce1c93c1ce35fc32475543ce16~Ui1n_uCWD1793917939epcas1p3R;
	Fri, 31 May 2024 10:16:16 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.226]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VrJtS1SbNz4x9Pw; Fri, 31 May
	2024 10:16:16 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
	epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	70.A8.08602.073A9566; Fri, 31 May 2024 19:16:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20240531101615epcas1p3f0085b563af62c7f83699b0135cc832a~Ui1nRqTi81794517945epcas1p3R;
	Fri, 31 May 2024 10:16:15 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240531101615epsmtrp1b3b592a72c12134a5c6ab76b4ed8049a~Ui1nQ4tgJ0964109641epsmtrp1o;
	Fri, 31 May 2024 10:16:15 +0000 (GMT)
X-AuditID: b6c32a33-c9f8da800000219a-40-6659a3708afb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.0E.07412.F63A9566; Fri, 31 May 2024 19:16:15 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240531101615epsmtip296f408870311044c8070f1ac3fc2da5e~Ui1nDfC7B0954209542epsmtip2d;
	Fri, 31 May 2024 10:16:15 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: linkinjeon@kernel.org, sj1557.seo@samsung.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
Subject: [PATCH] exfat: fix potential deadlock on __exfat_get_dentry_set
Date: Fri, 31 May 2024 19:14:44 +0900
Message-Id: <20240531101444.1874926-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDJsWRmVeSWpSXmKPExsWy7bCmvm7B4sg0g6+vWC0mTlvKbLFn70kW
	i8u75rBZbPl3hNViwcZHjBbHWtazOrB5bFrVyebRt2UVo8fMt2oenzfJBbBENTDaJBYlZ2SW
	pSqk5iXnp2TmpdsqhYa46VooKWTkF5fYKkUbGhrpGRqY6xkZGemZGsVaGZkqKeQl5qbaKlXo
	QvUqKRQlFwDV5lYWAw3ISdWDiusVp+alOGTll4IcrFecmFtcmpeul5yfq6RQlphTCjRCST/h
	G2PGrq9XGQvO81W8/L+DvYFxJ1cXIyeHhICJROORNaxdjFwcQgI7GCW+zf/EDOF8YpSYdeQK
	VOYbo8ST3s1MMC2PNz+ESuxllJjbsIoFwmlnkpj/8gwzSBWbgLbE8qZlYLaIgKHEjCO3wIqY
	BSYxSlxtOAE2SljAQ2LOnHNsIDaLgKrEnnW7WEBsXgFbicXHrjJCrJOXmHnpOztEXFDi5Mwn
	YDXMQPHmrbPBjpUQ2Mcu8efnKWaIBheJ9dc+sELYwhKvjm9hh7ClJF72t7FDNHQzShz/+I4F
	IjGDUWJJhwOEbS/R3NoMdBEH0AZNifW79CGW8Um8+9oDNVNQ4vS1bmaQEgkBXomONiGIsIrE
	9w87WWBWXflxFRpcHhJvmk6D/SIkECvR82EW2wRG+VlI3pmF5J1ZCIsXMDKvYhRLLSjOTU9N
	NiwwRI7aTYzghKllvIPx8vx/eocYmTgYDzFKcDArifD+So9IE+JNSaysSi3Kjy8qzUktPsSY
	DAzgicxSosn5wJSdVxJvaGZmaWFpZGJobGZoSFjYxNLAxMzIxMLY0thMSZz3zJWyVCGB9MSS
	1OzU1ILUIpgtTBycUg1MDue3LFA3EfvXEeAb8Uar1v3+Vp5IHdltZydLlr2qFz8eVXNlR9Xz
	o7tmLXy3UZczyatNd9FEp+2R/Mdcps37MDXl4Gf9M5YF6S3XXZbek3huv4R9KbO18uq1l8wF
	0szlbL4Xzzt44h+zeNqXzkenLXKua/tvEHTseJubeKbodatJW91MiQ9nH6+5++1z7HSHZxER
	fhM7snfWBhmZvM8/d37u059tz2xSa9elKagK/eJLfHWsUpBfNeRMadhetSXBbBIFMXfyHgeU
	73l5pDrFcdHl51diazOW7UqXqQ5nM9t0MST/Qp731e6OPxqM8wQ46q49kkpe+cpb5PmqAMbd
	F3/e0O725hHP2rBDTm+NEktxRqKhFnNRcSIADeEhAU8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrELMWRmVeSWpSXmKPExsWy7bCSvG7+4sg0g6bvGhYTpy1lttiz9ySL
	xeVdc9gstvw7wmqxYOMjRotjLetZHdg8Nq3qZPPo27KK0WPmWzWPz5vkAliiuGxSUnMyy1KL
	9O0SuDJ2fb3KWHCer+Ll/x3sDYw7uboYOTkkBEwkHm9+yApiCwnsZpTYepW/i5EDKC4lcXCf
	JoQpLHH4cHEXIxdQRSuTxKrPT5lBytkEtCWWNy0Ds0UEjCUenWtmBSliFpjCKHH53RawmcIC
	HhJz5pxjA7FZBFQl9qzbxQJi8wrYSiw+dpUR4gZ5iZmXvrNDxAUlTs58AlbDDBRv3jqbeQIj
	3ywkqVlIUgsYmVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgQHo5bGDsZ78//pHWJk
	4mA8xCjBwawkwvsrPSJNiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalF
	MFkmDk6pBqa12oYt/83mffK8J71csP2/XOdt1TpmJ5PwkOuvz3f8EMkuKt0hPkVu2j6hPUzc
	n3TK94u5ZWobGEvuz85mffDEqmadq2VP2Ow36S8t7zBtWZxaPLNfS5nx1tXt67afWv/jM4OO
	/b87vnLvBFu/uvqlfxY+tEzdS1G+/MSGL7M6Zd5me523Y9sSckWtK5Gru8rt8rODZgynJhVv
	M6h4pBveNH3C8/UzzISLj9++semNk9u6PgvnJ9vUPlhtVAi8UzxtWl7Val/RlDWcPkuun5b2
	Fav3l2nXu/yrpEP0Sl7PgYmeXv/2rGb7cab8QyNDp7viz9KXn6taXBOMwouPvugQ6/lnf799
	tt7iushZyUosxRmJhlrMRcWJAP0cIv21AgAA
X-CMS-MailID: 20240531101615epcas1p3f0085b563af62c7f83699b0135cc832a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531101615epcas1p3f0085b563af62c7f83699b0135cc832a
References: <CGME20240531101615epcas1p3f0085b563af62c7f83699b0135cc832a@epcas1p3.samsung.com>

When accessing a file with more entries than ES_MAX_ENTRY_NUM, the bh-array
is allocated in __exfat_get_entry_set. The problem is that the bh-array is
allocated with GFP_KERNEL. It does not make sense. In the following cases,
a deadlock for sbi->s_lock between the two processes may occur.

       CPU0                CPU1
       ----                ----
  kswapd
   balance_pgdat
    lock(fs_reclaim)
                      exfat_iterate
                       lock(&sbi->s_lock)
                       exfat_readdir
                        exfat_get_uniname_from_ext_entry
                         exfat_get_dentry_set
                          __exfat_get_dentry_set
                           kmalloc_array
                            ...
                            lock(fs_reclaim)
    ...
    evict
     exfat_evict_inode
      lock(&sbi->s_lock)

To fix this, let's allocate bh-array with GFP_NOFS.

Fixes: a3ff29a95fde ("exfat: support dynamic allocate bh for exfat_entry_set_cache")
Cc: stable@vger.kernel.org # v6.2+
Reported-by: syzbot+412a392a2cd4a65e71db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000fef47e0618c0327f@google.com
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index 84572e11cc05..7446bf09a04a 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -813,7 +813,7 @@ static int __exfat_get_dentry_set(struct exfat_entry_set_cache *es,
 
 	num_bh = EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZE, sb);
 	if (num_bh > ARRAY_SIZE(es->__bh)) {
-		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_KERNEL);
+		es->bh = kmalloc_array(num_bh, sizeof(*es->bh), GFP_NOFS);
 		if (!es->bh) {
 			brelse(bh);
 			return -ENOMEM;
-- 
2.25.1


