Return-Path: <linux-fsdevel+bounces-30458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C5A98B7FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C5F28446B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7719DF81;
	Tue,  1 Oct 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="PXi81XRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1974B19D09D;
	Tue,  1 Oct 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773872; cv=none; b=eyX4OBHArEyZLHd9hQGFxEXeWL7Th1NS10Fmjf7im3OQIVjx0XXlsOUK7FJdK+2z295wYLzBi2sdfXLTsRjXfAyGLJlAqmIELgRxewHA3ad5yvIVqOL+hDjPH4Sxg847+IpYVZqtCRCHcTlnGC1dPnVzVwRqP4jZGl39gWUIgRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773872; c=relaxed/simple;
	bh=Np8uxb82WjqCqAHczCUqm9zGpxcxVDATjiaqYgBCXUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDp8Jhnvm0h7oL5Tb7bIpmEDC8M+ix3cMM2hU9+BUPYSEwGsb1E87IzkpmjRuUpqM/qHeDV0ElX8J1qT7MQAEiewSYDxUH52lVZAEhhTT0hAnga/MGNPjHQBv+IJkPQVKICQVZzHQWsE53JiTAYc7LfGCTvOjd1UsI7+b6sf7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=PXi81XRX; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 68A0221B9;
	Tue,  1 Oct 2024 08:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1727772833;
	bh=SLgx5JiLnCawPFqRiV5IdAXRHlU6ft555LdTRa/w6wI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=PXi81XRXHH7CjdXQo/+33F4bfy4kGj5LMlZDJHXGsSOoMXP0JhxbGtcctCVRPQHJe
	 ubIyZYdAakaBfC8wjuFqSh8RB6KsHq+80NODrIdLVdtHtu6gFNdhMoZnB+H3FK+Arz
	 dpqHSnRBEC007ysO1sT8jbbzEyx0WqdFsDpVLX+s=
Received: from ntfs3vm.paragon-software.com (192.168.211.162) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 1 Oct 2024 12:01:26 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 3/6] fs/ntfs3: Sequential field availability check in mi_enum_attr()
Date: Tue, 1 Oct 2024 12:01:01 +0300
Message-ID: <20241001090104.15313-4-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
References: <20241001090104.15313-1-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

The code is slightly reformatted to consistently check field availability
without duplication.

Fixes: 556bdf27c2dd ("ntfs3: Add bounds checking to mi_enum_attr()")
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/record.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 427c71be0f08..f810f0419d25 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -237,6 +237,7 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	}
 
 	/* Can we use the first field (attr->type). */
+	/* NOTE: this code also checks attr->size availability. */
 	if (off + 8 > used) {
 		static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
 		return NULL;
@@ -257,10 +258,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		return NULL;
 
 	asize = le32_to_cpu(attr->size);
-	if (asize < SIZEOF_RESIDENT) {
-		/* Impossible 'cause we should not return such attribute. */
-		return NULL;
-	}
 
 	/* Check overflow and boundary. */
 	if (off + asize < off || off + asize > used)
@@ -290,6 +287,10 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 	if (attr->non_res != 1)
 		return NULL;
 
+	/* Can we use memory including attr->nres.valid_size? */
+	if (asize < SIZEOF_NONRESIDENT)
+		return NULL;
+
 	t16 = le16_to_cpu(attr->nres.run_off);
 	if (t16 > asize)
 		return NULL;
@@ -316,7 +317,8 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 
 	if (!attr->nres.svcn && is_attr_ext(attr)) {
 		/* First segment of sparse/compressed attribute */
-		if (asize + 8 < SIZEOF_NONRESIDENT_EX)
+		/* Can we use memory including attr->nres.total_size? */
+		if (asize < SIZEOF_NONRESIDENT_EX)
 			return NULL;
 
 		tot_size = le64_to_cpu(attr->nres.total_size);
@@ -326,9 +328,6 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
 		if (tot_size > alloc_size)
 			return NULL;
 	} else {
-		if (asize + 8 < SIZEOF_NONRESIDENT)
-			return NULL;
-
 		if (attr->nres.c_unit)
 			return NULL;
 
-- 
2.34.1


