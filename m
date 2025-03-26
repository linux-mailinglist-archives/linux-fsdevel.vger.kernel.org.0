Return-Path: <linux-fsdevel+bounces-45089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE791A71970
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 15:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5803BFE25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 14:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0111F2C5F;
	Wed, 26 Mar 2025 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="B8qKfZkW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB201C8638
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000566; cv=none; b=YSnfxkJpD/7EMhJp9fsFYkQWlKbYQqL0rb8WLowNnPameE+XLDWvpOlRG3rqd2rbWW9MrB8Q1agMTQ9bZM1xkd165YvARWHmny8bsLWHwBQo1HXgrmpmo/S/0BE5N3bQv8/wACb1+fFiEE4zE09+7mos268YlM+3tpxIEd/8Q/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000566; c=relaxed/simple;
	bh=AGunnTLAw5lTuH6SsD/sMvxG9Gr1cJo6gPHAUcIVnFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=PQYup+FgUgPrL4p5Im9TFqaAnJxV6zvysnmJX2ecV8m5UvcZ6GDGO3DAONHyNlOXZj0te/BiBWeIJ9YHnsXH48jmTyWwgQyETcQNJDSi06pKmhZdBI3jlOrio3pHN1F/BIEsx6kVzYW1d7zukrVlyx/7LSdxL0S4XqNQ+y8fiIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=B8qKfZkW; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250326144921epoutp01945086f38b23b7277624e98e3d4aef95~wYcaT_oGo1299912999epoutp01P
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Mar 2025 14:49:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250326144921epoutp01945086f38b23b7277624e98e3d4aef95~wYcaT_oGo1299912999epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743000561;
	bh=PvMcIFBpghuJtM2xf/uXNWsaSErjxIY7zcXBIjwPBxw=;
	h=From:To:Cc:Subject:Date:References:From;
	b=B8qKfZkW9HoJyF1/sXAkBx2t0kzRq2Y+GCp6phehgCUA0qnGvYlIWr2aLiNvhRvk3
	 jg2blhoN30NjRK15vpwOQPswtU4X9/XFhLrG/nIXcVZuaOTi/3o6vcIx2Yk4dqXlCt
	 DQLBhoj8GczccZiM6R/2emUYeqDTJ42vO4/ZDijQ=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
	20250326144920epcas1p1600652c78cdba835e964c248d4be8405~wYcZgqUcf2108921089epcas1p1U;
	Wed, 26 Mar 2025 14:49:20 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.36.227]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZN8nX0l02z6B9m4; Wed, 26 Mar
	2025 14:49:20 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
	epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BF.1D.10189.FE314E76; Wed, 26 Mar 2025 23:49:20 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784~wYcYJKFtO2109021090epcas1p19;
	Wed, 26 Mar 2025 14:49:18 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250326144918epsmtrp10915de4994d13fa30065075f8a332688~wYcYIanw42811128111epsmtrp1x;
	Wed, 26 Mar 2025 14:49:18 +0000 (GMT)
X-AuditID: b6c32a35-737e8700000027cd-eb-67e413ef0064
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	05.70.07818.EE314E76; Wed, 26 Mar 2025 23:49:18 +0900 (KST)
Received: from u20pb1-0435.tn.corp.samsungelectronics.net (unknown
	[10.91.133.14]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250326144918epsmtip101730a348a9d61efdbe7a43f38ed3c30~wYcX7tfee2376823768epsmtip1j;
	Wed, 26 Mar 2025 14:49:18 +0000 (GMT)
From: Sungjong Seo <sj1557.seo@samsung.com>
To: linkinjeon@kernel.org, yuezhang.mo@sony.com
Cc: sjdev.seo@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, cpgs@samsung.com, Sungjong Seo
	<sj1557.seo@samsung.com>, stable@vger.kernel.org
Subject: [PATCH] exfat: fix potential wrong error return from get_block
Date: Wed, 26 Mar 2025 23:48:48 +0900
Message-Id: <20250326144848.3219740-1-sj1557.seo@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMJsWRmVeSWpSXmKPExsWy7bCmnu4H4SfpBhs2M1m8PKRpMXHaUmaL
	PXtPslhc3jWHzWLLvyOsFi8+bGCzWLDxEaPF9TcPWR04PHbOusvusWlVJ5tH35ZVjB7tE3Yy
	e3zeJBfAGtXAaJNYlJyRWZaqkJqXnJ+SmZduqxQa4qZroaSQkV9cYqsUbWhopGdoYK5nZGSk
	Z2oUa2VkqqSQl5ibaqtUoQvVq6RQlFwAVJtbWQw0ICdVDyquV5yal+KQlV8Kcr9ecWJucWle
	ul5yfq6SQlliTinQCCX9hG+MGbePnWQreM9WcWvlBaYGxi2sXYycHBICJhJbHh4Ds4UEdjBK
	fGphhLA/MUrsn+PSxcgFZH9jlFi4oI8dpqFh4VZGiMReRomDDZeYIZx2Jokzx7aAtbMJaEss
	b1oGlODgEBHQl2hpqgKpYRZYySixalMjM0iNsIC7xLxHt8FWswioSszZ3Q5m8wrYSjTOb4A6
	T15i5qXv7BBxQYmTM5+wgNjMQPHmrbOZIWousUtc7GWEsF0kLp+fDHWpsMSr41ugbCmJl/1t
	7CBHSAh0M0oc//iOBSIxg1FiSYcDhG0v0dzazAZyNLOApsT6XfoQu/gk3n3tgbqHV6Jh42+o
	mYISp691g/0IEu9oE4IIq0h8/7CTBWbtlR9XmSBsD4mTvxYwQ0I3VqL3xGGmCYwKs5B8NgvJ
	Z7MQjljAyLyKUSy1oDg3PbXYsMAQOYo3MYLTq5bpDsaJbz/oHWJk4mA8xCjBwawkwnuM9WG6
	EG9KYmVValF+fFFpTmrxIcZkYFhPZJYSTc4HJvi8knhDMzNLC0sjE0NjM0NDwsImlgYmZkYm
	FsaWxmZK4rwXtrWkCwmkJ5akZqemFqQWwWxh4uCUamDKX828t/tfvqTNpPo7+w57rp4u2Vz8
	ZeN89Sdbvotp3eI85OYVZiK8+qHgRa/dNf2bZx948fxRRsYCxSf+lnUy+TV3dk39pmTPU/FB
	8NCDift9XCfr/RPsncIbLGeQdEU4q+3XpM09ActX7j1+7Zbg3rizttaHj32YI3w7T0B0+dEP
	e0x1y3z0Il5HmDy8fPiyi3p8yIue1dPKq1ecmBHr3+Nro37h4ouLe/73PA+uuPJmo/l0nYNZ
	qr2rPqxlv9Ow4FFv0/ETeRsN9m5XLlToTG/qWBl9r8M3JeL9T5Pb77oqpM0XGK9+N/eJl5+z
	2Q9Jt7agN30Xeu0f3F3X5sgV9pY7+RVzssyZTsEvpt67lViKMxINtZiLihMB9kR97WYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSnO474SfpBtNmmVm8PKRpMXHaUmaL
	PXtPslhc3jWHzWLLvyOsFi8+bGCzWLDxEaPF9TcPWR04PHbOusvusWlVJ5tH35ZVjB7tE3Yy
	e3zeJBfAGsVlk5Kak1mWWqRvl8CVcfvYSbaC92wVt1ZeYGpg3MLaxcjJISFgItGwcCtjFyMX
	h5DAbkaJvQeOsXQxcgAlpCQO7tOEMIUlDh8uhihpZZI42neAHaSXTUBbYnnTMmYQW0TAUGLD
	4r3sIEXMAusZJZqerWADSQgLuEvMe3QbbBmLgKrEnN3tYDavgK1E4/wGqCPkJWZe+s4OEReU
	ODnzCQuIzQwUb946m3kCI98sJKlZSFILGJlWMUqmFhTnpucmGxYY5qWW6xUn5haX5qXrJefn
	bmIEB6uWxg7Gd9+a9A8xMnEwHmKU4GBWEuE9xvowXYg3JbGyKrUoP76oNCe1+BCjNAeLkjjv
	SsOIdCGB9MSS1OzU1ILUIpgsEwenVAOTqPCpY7+mbbl9ybZqv3/PonyXr6yeVRuKTaKj82Ym
	RB2NL7DOtvvTrOAl6VxZYHBPd92BlhTfrbdDCkvjJjYZXTq+zKf7uV+D85uIOa12FR6/f0a6
	buGdkS7E5RZY2WTQxJN2WuH6hC3rZkTFdvhr3MiJmCjhIvNR741OvWbBqniW/sZrxW9ZE2WN
	VqpPS98jEJ+X+FrgybGVBlfZ4x+18nX2WVhWnHTkfCE+q61iy8FV/hbRgr8dDH+2/95TGrRU
	xN6Kp2XWeYerewVv9kz4EDy7aVHEZWumt9abPymJMNhLR6vwr2Zb7/LkQGJQxI/jJrOnXNG5
	mBY0Id/isvC+03mnvBh/7V0V/H/rDCWW4oxEQy3mouJEAFlDL0fFAgAA
X-CMS-MailID: 20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
X-ArchiveUser: EV
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784
References: <CGME20250326144918epcas1p1bf704db657010812a18e9fef5c3a6784@epcas1p1.samsung.com>

If there is no error, get_block() should return 0. However, when bh_read()
returns 1, get_block() also returns 1 in the same manner.

Let's set err to 0, if there is no error from bh_read()

Fixes: 11a347fb6cef ("exfat: change to get file size from DataLength")
Cc: stable@vger.kernel.org
Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
---
 fs/exfat/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index f3fdba9f4d21..a23677de4544 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -391,6 +391,8 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 			/* Zero unwritten part of a block */
 			memset(bh_result->b_data + size, 0,
 			       bh_result->b_size - size);
+
+			err = 0;
 		} else {
 			/*
 			 * The range has not been written, clear the mapped flag
-- 
2.25.1


