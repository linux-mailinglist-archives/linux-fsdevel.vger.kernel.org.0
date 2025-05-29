Return-Path: <linux-fsdevel+bounces-50061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279FFAC7D3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2204218975B0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2034628F93F;
	Thu, 29 May 2025 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SEPudA+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC052918CA
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518454; cv=none; b=VXw3Yx0BSj3XDdS0eP9QczV085KYjJ5hSCUJ4Z4TMWdfC/riadYXlfI2tZK5K0IGCIP1B990cdFkOWePzKNqDhNoI80EsvpKqcCEVJBQc7W2vm1uuyPoZK30VTT0rPvglqWEgZfeLeTXABzheaRGqr9mCPYtAAtTRiMCJY1dAYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518454; c=relaxed/simple;
	bh=sXFNJGbvsPUVase9LQlwM8MI/RoihHRIbpm8Bm8drhs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=eb3sNBdJ0GbIbYRCTNc7hQfLRz37vluyTBoXt6eI5eTxG21YlsH6DYuXknBWwBA7Rx1QBaxdfmegD1JxKJ3aPBubZ+XdO3DkX6T4UI4lFpVzqD7bEymjth0ROBy42H5tY7RqgxeJyOZoS8WuR6lDClKYBgDC7EY4Y6gIMfHgL50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SEPudA+0; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250529113411epoutp02029e35e921078736f2c62dce0b3c24a1~D-ERzktFW2285522855epoutp024
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250529113411epoutp02029e35e921078736f2c62dce0b3c24a1~D-ERzktFW2285522855epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518451;
	bh=Zn7Pts0ou2iSXgETzzKNoOTqw7EC8RrgMd0Xe7Ygfcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SEPudA+0D06vWELpPkQrq4B1L0GjzwbndNP8ZZwSnFdwoRMksArUgD58PWrONwKsS
	 oeGC5NqX4fa/YviaMkUplhyNbLsArEVm90XS94pVXVVwUeD+MwMp7ynSJWSBIPknDN
	 olk9iXHyECZCls2dtYPyDeTQzeNCqph4f3XmZu6Q=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529113410epcas5p479a40e38a740560a53f1518e9dd71db1~D-ERVzu7h2801228012epcas5p4V;
	Thu, 29 May 2025 11:34:10 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.175]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b7PQn3Gnrz6B9m5; Thu, 29 May
	2025 11:34:09 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea~D-DNfLdhB2501025010epcas5p4s;
	Thu, 29 May 2025 11:32:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250529113257epsmtrp107bda94680d50d120a7cbed6884bfd27~D-DNd_opW2108121081epsmtrp1U;
	Thu, 29 May 2025 11:32:57 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-5b-683845e9c6be
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.E0.08766.9E548386; Thu, 29 May 2025 20:32:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113253epsmtip27ef7254c0e9880bcb299ee33499ee18e~D-DJpOhM12454924549epsmtip2N;
	Thu, 29 May 2025 11:32:53 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, p.raghav@samsung.com,
	da.gomez@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, Kundan Kumar <kundan.kumar@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH 10/13] fuse: add support for multiple writeback contexts in
 fuse
Date: Thu, 29 May 2025 16:45:01 +0530
Message-Id: <20250529111504.89912-11-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTZxjHfc+djpqzYuYrLJLVmAWiKF7wZZsw4tiO+oVsMc4bWO0ZJba1
	aUHZliirohOBVQWFHpYAQoK0gLaA1iMIxVsFKhYvdIPiBZ3iDFogIxBBCy7x2y//3/95ni8P
	g8sGiVAmTZvO67UKtZySEI1t8vDFzxORaunI+FLUWCvSqKTOSqGuWgtA2Y4pAhlNb3Bk6fuD
	Qi/a/AC1F3ZiqN4Tj4a6GzFk8VoBqr/mA6h7YDYST02SyNviwNAZy1UMCacOYGigzoyjhpFR
	EnnKv0OXmlwE8lmnSNTV0k6iHtMTgJ6K53A0XHmQRq03f6eR/893S269uU6iibES6uv53M1y
	yDnMfTRnr4rkujszOFv1EYqz+Y/T3I2iCYJ7Zi8GnFg6jHGiN4vi3LczuaHmuxSXX18NuEJh
	P9dReoXmqk7expJkmyVfKXl12h5evyRuu0T1oL+A1OXOznTm+ukscDw4BwQxkF0B871PiBwg
	YWSsCGBXkQubEZ9Csc9BznAIPDP5Dz1Teg2gUCDgOYBhKHYxHDNuCORzWC8O3Z0d0wM4Owmg
	OLgowCFsEhSrrNM5wS6EdfdPEwGWsnHQ3jH2/kA4LPb8Rwc46F1eXjEKAixjV8NKb837/sfQ
	VTxAzOwPhwcaBNwEWPMHyvyBKgVYNZjH6wyaVI0hWhet5fdGGRQaQ4Y2NWrnbo0NTL9DZMQF
	cL76VZQTYAxwAsjg8jlSY3yMSiZVKn7+hdfvTtFnqHmDE4QxhHyudO6zPKWMTVWk87t4Xsfr
	/7cYExSahSVWfu7e6GIKN44cWtRk8S0kZ+XFLNhXM0XLk1TGBPDRvODHtjUlKQUgepTcN/Eg
	/Fvbhcz1P3S/cAzF9ks9VNn3yy4VxB698lkReFkb8/pwySf2oJ7iyU2kf1mr+Vh/TXbehL+v
	MtVdGLfTGnpU1lr2ReuS+//KrYpvWtRGRVtF7suz2xNWzV/+o3VLGXHN4xbY9dcHBYuTeO77
	K2yW+2JPc5ry15BHvcciHwqmlsR149v2DBt3rOltij3cHKLN3v9wnIxX9zaHba2Zalt9eZUR
	O6JzJYS2fxkfkfH0noPV8XcaJG7TWt9Q/k/BJx7XudM1h/7em79SeJWb/ChZ+Zt9l5wwqBTR
	kbjeoHgLOVHo+30DAAA=
X-CMS-MailID: 20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113257epcas5p4dbaf9c8e2dc362767c8553399632c1ea@epcas5p4.samsung.com>

Fetch writeback context to which an inode is affined. Use it to perform
writeback related operations.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/fuse/file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7817219d1599..803359b02383 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1851,11 +1851,11 @@ static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 
 static void fuse_writepage_finish_stat(struct inode *inode, struct folio *folio)
 {
-	struct backing_dev_info *bdi = inode_to_bdi(inode);
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 
-	dec_wb_stat(&bdi->wb_ctx_arr[0]->wb, WB_WRITEBACK);
+	dec_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
 	node_stat_sub_folio(folio, NR_WRITEBACK_TEMP);
-	wb_writeout_inc(&bdi->wb_ctx_arr[0]->wb);
+	wb_writeout_inc(&bdi_wb_ctx->wb);
 }
 
 static void fuse_writepage_finish(struct fuse_writepage_args *wpa)
@@ -2134,6 +2134,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 					  struct folio *tmp_folio, uint32_t folio_index)
 {
 	struct inode *inode = folio->mapping->host;
+	struct bdi_writeback_ctx *bdi_wb_ctx = fetch_bdi_writeback_ctx(inode);
 	struct fuse_args_pages *ap = &wpa->ia.ap;
 
 	folio_copy(tmp_folio, folio);
@@ -2142,7 +2143,7 @@ static void fuse_writepage_args_page_fill(struct fuse_writepage_args *wpa, struc
 	ap->descs[folio_index].offset = 0;
 	ap->descs[folio_index].length = PAGE_SIZE;
 
-	inc_wb_stat(&inode_to_bdi(inode)->wb_ctx_arr[0]->wb, WB_WRITEBACK);
+	inc_wb_stat(&bdi_wb_ctx->wb, WB_WRITEBACK);
 	node_stat_add_folio(tmp_folio, NR_WRITEBACK_TEMP);
 }
 
-- 
2.25.1


