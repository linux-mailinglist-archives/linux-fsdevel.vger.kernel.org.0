Return-Path: <linux-fsdevel+bounces-29846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B01A97ECFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 16:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 943BEB219B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 14:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F73F19F13F;
	Mon, 23 Sep 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="itUHupd9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFBD19F108
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101118; cv=none; b=oQH16RFxHaRCswBIxtZC5a8h47vUQDrMBK5nEciWGf1dkhe/rglkDL/MfxMecfaiYrNGmpFVMWDnpTMu4VXswLRaYlN6n0HNemDRhzN+/1ecgnOzPJEOhrunvLa+VUoFEIc35QxAe9wDP5GaoB6qcSrpC7m2FomRie9O+bZ29qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101118; c=relaxed/simple;
	bh=rNFDCva2KWTzuiiQKZHnO0yo1USSKpc1lsKNZpOytg8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:References; b=HYjB5YOhc0JCHnFfcYEIG5yQD5BejPQyVlHqzeCsglrHxoKkIq6l4Zt3k2rfCoQGchqgMbzrYtYvfWBT4X9ZbVSpMJDBwnQTq5SbyKa+aT+ufS/NvUDMq4nuNk6W1iR0tuWxYPpY7p8j8fVh/pACJ2Z2QbrUSvjWuClN66XWESY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=itUHupd9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20240923141828euoutp029741d4a9fc4e655b2f2609fe4026a1b1~35U6q-Pnq2196521965euoutp02j
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 14:18:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20240923141828euoutp029741d4a9fc4e655b2f2609fe4026a1b1~35U6q-Pnq2196521965euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1727101108;
	bh=Dyzc2+DKoyZITwPw6RrDvsKqxkkQr5T4Bmdb9zKY8TI=;
	h=Date:From:To:CC:Subject:References:From;
	b=itUHupd9P2TeM7zo2RqFnC5GGDebSD2ubFhmfCmdQhJtcQpGTempycr4aKXCSB9Aq
	 gL+d/qRpR8uIwdJo4A0FhdtbNhE/xfc7a/7VYn+jVp40AFxtOIv2fDkKmbXXleP166
	 I8EWQwXadYwlqVkxP/heIRSHAIotbgr/+dKjFDu0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240923141827eucas1p18dc8306f2696c421be1619504ec46b5b~35U6Sywjt3104131041eucas1p1Z;
	Mon, 23 Sep 2024 14:18:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F1.7E.09875.3B871F66; Mon, 23
	Sep 2024 15:18:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996~35U55c5p73103231032eucas1p1c;
	Mon, 23 Sep 2024 14:18:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240923141827eusmtrp2da4efbef7be0bf121d9bf4dd7e29a575~35U54jffK1866818668eusmtrp2C;
	Mon, 23 Sep 2024 14:18:27 +0000 (GMT)
X-AuditID: cbfec7f4-131ff70000002693-c4-66f178b3877a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F0.AC.14621.3B871F66; Mon, 23
	Sep 2024 15:18:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240923141827eusmtip225e700362b94580c0bf6c1e76ae3f728~35U5toMC70427404274eusmtip2f;
	Mon, 23 Sep 2024 14:18:27 +0000 (GMT)
Received: from localhost (106.110.32.44) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 23 Sep 2024 15:18:26 +0100
Date: Mon, 23 Sep 2024 16:05:01 +0200
From: Joel Granados <j.granados@samsung.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Thomas =?utf-8?B?V2Vp77+9c2NodWg=?= <linux@weissschuh.net>, Luis
	Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Joel Granados
	<joel.granados@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>
Subject: [GIT PULL] sysctl changes for v6.12-rc1
Message-ID: <20240923140501.b2i7xggemwvmqcs7@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djP87qbKz6mGcztUbU4s/gOi8W6t+dZ
	LfbsPclicXnXHDaL3z+eMVncmPCU0eJR31t2B3aPTas62TxOzPjN4vF5k5xHf/cx9gCWKC6b
	lNSczLLUIn27BK6MSzP1Clp4KjYv+sXUwHiTs4uRk0NCwERi4owmti5GLg4hgRWMEns/dkI5
	XxglZlxaxgThfGaU+HzgNhtMy75305ghEssZJZomtjPDVW2ef5oRwtnMKDFl41MmkBYWAVWJ
	zqnvWUFsNgEdifNv7jCD2CICRhKfX1xhBWlgFvjEKPF7+m92kISwgIHE3C9/gWwODl4BB4kt
	E1JBwrwCghInZz5hAbGZBTQlWrf/BithFpCWWP6PAyIsL9G8dTYzxKWKEl8X32OBsGslTm25
	BfaOhMANDomJL6dCJVwkzh77ywRhC0u8Or6FHcKWkfi/cz5Uw2RGif3/PrBDOKsZJZY1foXq
	sJZoufIEqsNR4t+xdkaQiyQE+CRuvBWEuIhPYtK26cwQYV6JjjYhiGo1idX33rBMYFSeheS1
	WUhem4Xw2iwkry1gZFnFKJ5aWpybnlpslJdarlecmFtcmpeul5yfu4kRmHxO/zv+ZQfj8lcf
	9Q4xMnEwHmKU4GBWEuFd9+RtmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS1OzU
	1ILUIpgsEwenVAOTF8vkg5FVbM3ZYgLdTvPYAlg3VL3u5a9vcanzqmfd/YmB7SvrFZ3/tvV6
	2bZCa6K7ruemHbg/Ye6B1mTrvZo/PnskH2mVyqyozLu63+Rdx/+eg+vqFhw+2c/6Jb3um0X9
	/ln3tmlPDCtvjdiavTTOXMA/8OHquji7on2ainNlp2hGfhf42BKhJ7N9QovyIiWFORZza917
	F7WEfY5XD+oT3+23lK/+zOHNB+3+hQquT9iwNmzSPTGm7/a1SXeWbTafHRpjMGmWj89qjx/v
	kht3Hlv2ZMHPR7UKjWf0e+z+bXw96cQ/t/4t6x46NWW8k2paEN/x55hFy4+8+LmfhatP8Z5X
	KZ+bO/vCnd0813cpsRRnJBpqMRcVJwIAbU2TXK0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7qbKz6mGZy8w2dxZvEdFot1b8+z
	WuzZe5LF4vKuOWwWv388Y7K4MeEpo8WjvrfsDuwem1Z1snmcmPGbxePzJjmP/u5j7AEsUXo2
	RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZl2bqFbTw
	VGxe9IupgfEmZxcjJ4eEgInEvnfTmLsYuTiEBJYySky6tpodIiEjsfHLVVYIW1jiz7UuNhBb
	SOAjo8SFB6kQDZsZJZ69uA+WYBFQleic+h6sgU1AR+L8mzvMILaIgJHE5xdXWEEamAU+MUrM
	ePkarEhYwEBi7pe/QNs4OHgFHCS2TEgFCfMKCEqcnPmEBcRmFtCUaN3+G6yEWUBaYvk/Doiw
	vETz1tnMELcpSnxdfI8Fwq6V+Pz3GeMERqFZSCbNQjJpFsKkWUgmLWBkWcUoklpanJueW2yo
	V5yYW1yal66XnJ+7iREYZduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8K578jZNiDclsbIqtSg/
	vqg0J7X4EKMpMCQmMkuJJucD4zyvJN7QzMDU0MTM0sDU0sxYSZzX7fL5NCGB9MSS1OzU1ILU
	Ipg+Jg5OqQamaer7j1of1fjiddDq1J526RsvtWew5M3YVCxWc+pZYc+a/Lv8GWXbPEVmT56+
	/+A7xjN/W+s1Ffa6putnbEjpbXyyK+vQ4jeuKXbF3jNPKWiIXpI9GP9TPWez1A5mj61Zj41+
	R8x4aKxe9y+gsXkpK+/NDI3W7Pfcaw7ahlbsK7q43eGx7Su+JbGMOwU2Ty/iPLw1cG2Gj+vW
	hbVXzl2LFgj4+7d+ikR3g5GOixYHQ1jm0xulZy+sv1tUwntq8l4/KRGfSNE3rsvntS+v/JrR
	XD858t2y5ysL18lWtaesl/pf/l3mhoeegMExUdNJj0UP1/MdiZ8f1Xl56aNXh/5tt/BT3bhC
	WLaW00Whh6dKiaU4I9FQi7moOBEA8VkNrzsDAAA=
X-CMS-MailID: 20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996
X-Msg-Generator: CA
X-RootMTR: 20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996
References: <CGME20240923141827eucas1p1b9c0dbe3baea82475f7ccd26a0169996@eucas1p1.samsung.com>

Linus:

One bugfix and one non-code change for this PR; did not get things into
linux-next on time for proper testing because my PTO ended way to late in the
cycle. I expect the next cycle to be busier as I move through the backlog. I'll
be sure to use the co-maintainers to avoid having this situation next time.

The following changes since commit 5be63fc19fcaa4c236b307420483578a56986a37:

  Linux 6.11-rc5 (2024-08-25 19:07:11 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/sysctl-6.12-rc1

for you to fetch changes up to 732b47db1d6c26985faca1ae5820bcfa10f6335d:

  MAINTAINERS: update email for Joel Granados (2024-09-20 12:25:06 +0200)

----------------------------------------------------------------
Summary

* Bug fix: Avoid evaluating non-mount ctl_tables as a sysctl_mount_point by
  removing the unlikely (but possible) chance that the permanently empty
  ctl_table array shares its address with another ctl_table.
* Update Joel Granados' contact info in MAINTAINERS.

Testing

* Bug fix merged to linux-next after 6.11-rc5

----------------------------------------------------------------
Joel Granados (1):
      MAINTAINERS: update email for Joel Granados

Thomas Weiﬂschuh (1):
      sysctl: avoid spurious permanent empty tables

 .mailmap              |  1 +
 MAINTAINERS           |  2 +-
 fs/proc/proc_sysctl.c | 11 ++++++++---
 3 files changed, 10 insertions(+), 4 deletions(-)

-- 

Joel Granados

