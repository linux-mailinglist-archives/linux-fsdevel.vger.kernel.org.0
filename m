Return-Path: <linux-fsdevel+bounces-52010-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4C9ADE341
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 07:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423D317B8E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 05:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B9D209F56;
	Wed, 18 Jun 2025 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nBMS94Mc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A90204866
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225974; cv=none; b=V15xmXUh2TGHI5M4pG5fb1hIrZWn+CWgD3Z90DR6j2gt7UTMT2EiPwaOTKupmpxB2+SRiO1vOZ/SsWByOYaRyor7DXrb2ABgAM6ouftoJms0uWZV9mFxUERGtXIJORkEdF7bMEPKiI5MVm83lXwQW+BgUU0mwhlrUaerKzmhfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225974; c=relaxed/simple;
	bh=hdapkcgYw6+N8+D882ruhXJMTl4F4HtQPux4kxGRBAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=cYp+68IeuN5qAam/hgGNVWA46FhH2n/kqvaJId0i0PQbOcVNtfoEzdRtA2aVKQhiAp3AmBD/qK85JrE+tk0bMSxopgHQIDuf1nISrktcqE8RLXQaXfTLc9xG0YOKmRXP8a/KbcDKBc17FBK9ZDD7wOWetzwROwwf74ZyYKZNC5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nBMS94Mc; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250618055251epoutp02d6f3d85b0f15a55381cef1a645d6a786~KDT9pDkDr0240302403epoutp02S
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 05:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250618055251epoutp02d6f3d85b0f15a55381cef1a645d6a786~KDT9pDkDr0240302403epoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225971;
	bh=P9rhI3M7s6EbOCh7ZiCRSWzpm7qAxT8KWdNbiPOdVhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBMS94McR4AwItNl0UtFDZIg22YeJdyw99JhCgRYGwqJ3IZe6zfBkzjfIPXkQX0kM
	 LGxT5BgmZW35ViDkUIC7pu5dAg3AfjlOX9w6Wmr709M2pI5La2Sz4IMWFBLHzxoviR
	 S7guo31o6MEbAYGIlmgWU7ZqAvz3D1OJpkZNsEzs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250618055250epcas5p15320c75e8f4734fa471555600d9ef004~KDT9KVtMg1875218752epcas5p1i;
	Wed, 18 Jun 2025 05:52:50 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bMXvh4QM9z2SSKw; Wed, 18 Jun
	2025 05:52:48 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20~KDTe2xqUa0262902629epcas5p1S;
	Wed, 18 Jun 2025 05:52:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055215epsmtip270a800a0d09f720d08a95d921a3fbbdf~KDTcxWJrd3156031560epsmtip2f;
	Wed, 18 Jun 2025 05:52:15 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v4 3/4] set pi_offset only when checksum type is
 not BLK_INTEGRITY_CSUM_NONE
Date: Wed, 18 Jun 2025 11:21:52 +0530
Message-Id: <20250618055153.48823-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618055153.48823-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20
References: <20250618055153.48823-1-anuj20.g@samsung.com>
	<CGME20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20@epcas5p1.samsung.com>

protection information is treated as opaque when checksum type is
BLK_INTEGRITY_CSUM_NONE. In order to maintain the right metadata
semantics, set pi_offset only in cases where checksum type is not
BLK_INTEGRITY_CSUM_NONE.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe72accab516..806b6e73276d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1867,9 +1867,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->metadata_size = head->ms;
-	if (bi->csum_type)
+	if (bi->csum_type) {
 		bi->pi_tuple_size = head->pi_size;
-	bi->pi_offset = info->pi_offset;
+		bi->pi_offset = info->pi_offset;
+	}
 	return true;
 }
 
-- 
2.25.1


