Return-Path: <linux-fsdevel+bounces-53317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90777AED83C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 11:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E357189A6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B69245029;
	Mon, 30 Jun 2025 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XI9hQOMD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BDE241131
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274537; cv=none; b=CN1tbpPOXa7yeOp+eACrHaeAw+U0OeRnZJIlGaTqbE83t1KnOv1gchedu1VtSwi+fcp1XQQrjFlaHPGVjGRGW0aJP/BwYVfgvnAM7yskFJQYGYtiW+iNWBy26ebk+68yF/JCQmztI3DiJz0WRvsURL7ol12YaaRlWZNO0G1mXL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274537; c=relaxed/simple;
	bh=kXAjAVJHFsC7i4aDtKf0DDIz9IZ1ZanfvxHTmIWG70s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=TvygWH+gVAjvXAAF8oMpiE4NwxJr+TlviP/uh/91X0FFNdUjRDukp3gtDCrkjGFeTtb/JbIo+8nIT13hhLwSPbgPaRlVdqt33QhMolFKxcDPLx6UKJIdc85zFNjiDwj4IgoBwi+qRuL3ZPNWgSVhxN2rpvWP5nN7w4XdRed13Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XI9hQOMD; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250630090853epoutp04fe6196cc00553c3fef23e384ecb9f82b~Nxujx_Md82270522705epoutp04i
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250630090853epoutp04fe6196cc00553c3fef23e384ecb9f82b~Nxujx_Md82270522705epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274533;
	bh=QaGuEMvkKlwN1ihT1o08PdW/fRKP7gO6quxDhwV3Up4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XI9hQOMD5txMojDNVEG0NAI/Tdnp4uMFNIG6Npw49xiF152nHRoHhp9WPc8pswoMF
	 YAr8PyPJ2WTgoi27FBZhNUxvzwf6fG3I+i9H73UuiJmj1BT511e+NLJ/KyIYgcGoj3
	 1XRjnfqh996fMidldKQNpySyEJR/c3ZBR+fEA1Oc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250630090853epcas5p1360ee3b7344287ef895816d6562b1bc0~NxujSI1nJ2452924529epcas5p1_;
	Mon, 30 Jun 2025 09:08:53 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.178]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bW0hM5ljyz3hhT7; Mon, 30 Jun
	2025 09:08:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250630090614epcas5p383dde7cef99658083e2ff520f6fac994~NxsO7Wrgv0768807688epcas5p3n;
	Mon, 30 Jun 2025 09:06:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090611epsmtip28622666e788ca5dc32705c76f0d8b72b~NxsMuP0-51089210892epsmtip22;
	Mon, 30 Jun 2025 09:06:11 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-next v5 3/4] nvme: set pi_offset only when checksum type
 is not BLK_INTEGRITY_CSUM_NONE
Date: Mon, 30 Jun 2025 14:35:47 +0530
Message-Id: <20250630090548.3317-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090614epcas5p383dde7cef99658083e2ff520f6fac994
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090614epcas5p383dde7cef99658083e2ff520f6fac994
References: <20250630090548.3317-1-anuj20.g@samsung.com>
	<CGME20250630090614epcas5p383dde7cef99658083e2ff520f6fac994@epcas5p3.samsung.com>

protection information is treated as opaque when checksum type is
BLK_INTEGRITY_CSUM_NONE. In order to maintain the right metadata
semantics, set pi_offset only in cases where checksum type is not
BLK_INTEGRITY_CSUM_NONE.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 685dea0f23a3..500a9e82d60e 100644
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


