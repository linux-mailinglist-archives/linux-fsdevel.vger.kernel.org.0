Return-Path: <linux-fsdevel+bounces-55684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C6FB0DA55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572DF3B8E90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF6C2E425C;
	Tue, 22 Jul 2025 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eSociMXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E371A0712
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753189170; cv=none; b=a1wXXuSgLI1v/MGrG0/vnEVVXmJtuu7mIq/18TlN6udHruTJIDuS0+oeAqPzTQ6c3BS1Tz/fqL/5QJNPELYXw4ALLvR4EvTkLVQfmlSk8NVT/s8TFepUemMJ7tLxdvv9QXiyPTqmkOq9YPEk+UTgv4PyKcs8DeYXrhdryhp2/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753189170; c=relaxed/simple;
	bh=dNboiCYnvOQ/i/dAAniiFz8Cxzdg0xu2uLo3rxvmf0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=uRKFJrv3LxoRUWrmY6G9fg6S8cN8Npy7pfm/X2C0TRRN8ngIuhI4IIWhssqq5sqQ5ANUXhTTCfyvHm9lJSO+z5HqMr8HoV+A/qIP5uNdgVwOLOwX4kNiQHYlE22rRI2swGOasiodPHNtjkEjbBqVzrofVwOuZutWzTk/iVI0Z44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eSociMXI; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250722125926epoutp0472e1c5257c694e02908cc2a18bb6b459~UlEIMK0cH1317813178epoutp04h
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jul 2025 12:59:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250722125926epoutp0472e1c5257c694e02908cc2a18bb6b459~UlEIMK0cH1317813178epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753189166;
	bh=t2N2RdsmomzGRnLA5OCrx1H5380TMeiOrBLlyLmumAI=;
	h=From:To:Cc:Subject:Date:References:From;
	b=eSociMXI/r3TMoFBO2he9W2Zp5hX0PXsB+s1y49jAxDfu/QX3AyOvcYsjFf8fOb2l
	 VcVv96O891LAbiKJkAtc6C2pHnD6TkmaaAvFfsEpA+gMI++/kZsajEQM3dZhL8ceh/
	 StlGvY9FsxTcdheQ47s9mXa/P0XINVc7Meq08aiE=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250722125925epcas5p4448e922074292bb7621d1ccae707c08d~UlEHv-pu70936109361epcas5p4a;
	Tue, 22 Jul 2025 12:59:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.95]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4bmcmD6hQrz6B9m6; Tue, 22 Jul
	2025 12:59:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250722120822epcas5p100667bdb8c199361a66dcef2ae09fdd1~UkXivYGzL0066500665epcas5p12;
	Tue, 22 Jul 2025 12:08:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250722120820epsmtip2b3cbbcaab6ae301751f037453e0a26ee~UkXhFrVyo0221102211epsmtip2j;
	Tue, 22 Jul 2025 12:08:20 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
	hch@infradead.org, martin.petersen@oracle.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	joshi.k@samsung.com, Anuj Gupta <anuj20.g@samsung.com>, Christoph Hellwig
	<hch@lst.de>
Subject: [PATCH v3] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
Date: Tue, 22 Jul 2025 17:37:55 +0530
Message-Id: <20250722120755.87501-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250722120822epcas5p100667bdb8c199361a66dcef2ae09fdd1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250722120822epcas5p100667bdb8c199361a66dcef2ae09fdd1
References: <CGME20250722120822epcas5p100667bdb8c199361a66dcef2ae09fdd1@epcas5p1.samsung.com>

The blk_get_meta_cap() implementation directly assigns bi->csum_type to
the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
blk_integrity_checksum values are not guaranteed to match the UAPI
defined values.

Fix this by explicitly mapping internal checksum types to UAPI-defined
constants to ensure compatibility and correctness, especially for the
devices using CRC64 PI.

Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
Reported-by: Vincent Fu <vincent.fu@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-integrity.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 61a79e19c78f..056b8948369d 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -83,7 +83,21 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 	if (meta_cap.lbmd_opaque_size && !bi->pi_offset)
 		meta_cap.lbmd_opaque_offset = bi->pi_tuple_size;
 
-	meta_cap.lbmd_guard_tag_type = bi->csum_type;
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_NONE:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_NONE;
+		break;
+	case BLK_INTEGRITY_CSUM_IP:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_IP;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC16_T10DIF;
+		break;
+	case BLK_INTEGRITY_CSUM_CRC64:
+		meta_cap.lbmd_guard_tag_type = LBMD_PI_CSUM_CRC64_NVME;
+		break;
+	}
+
 	if (bi->csum_type != BLK_INTEGRITY_CSUM_NONE)
 		meta_cap.lbmd_app_tag_size = 2;
 
-- 
2.25.1


