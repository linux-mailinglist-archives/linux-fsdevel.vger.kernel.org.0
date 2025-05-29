Return-Path: <linux-fsdevel+bounces-50064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 115F5AC7D41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 13:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E72A11898EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 11:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6272918DF;
	Thu, 29 May 2025 11:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qFu2RBvN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB362918E9
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748518461; cv=none; b=od760otnkPFJ6LzDcwr6uc57sTSFrPGqd5eki6eoSmzNM5lkBAwUBG4Z3/JLYQvXUiMoNljWp1o9MoSMC7vvlmeyUxr17MvEBMzEXjqntQ/skcxe9hUByPrUpJaWNcxQnu7E/2VQRJu4RZxDeH5ZDRR2ybH66wDZpB59czoVGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748518461; c=relaxed/simple;
	bh=AvshCjFmzExHwRxduu+FeUsS3ZP3gR0L5bOFFiOF5gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=HoV/BNT4n9LfaY3QES0/bgJ3ZiMTsTuS/Ww0DHtMpMDWliE/Gqt5xSYTIivKCgKT2vom8oCnODyW5K6A5g3ceeUe8fnMJuf8KYTRD+dcyqZc/ArO6sQapcnB2MyFJghTmkGGigQaPhIPmKQPDwlOqmBxVTdQgPIbGy8yr98kzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qFu2RBvN; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529113418epoutp04cdc45b2d21a86e57351382d053ff52bb~D-EYSIuKx2428524285epoutp04Z
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 May 2025 11:34:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529113418epoutp04cdc45b2d21a86e57351382d053ff52bb~D-EYSIuKx2428524285epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748518458;
	bh=5UKmqLXR0SIvc4dfCdeb83oafI/Njtr5UdFaODU7FB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFu2RBvNXHWNmiq01V1MxikIMwpwRLJDr99QjFrNaJle0RwlD47xRGi73FOWrTqUU
	 +O9QGnz3eG+0v8rRxXuSFyTWWV4s1KrPxU3XWjqMpIuL8GgyjVV8mADambr26uqOMS
	 6ttAJRXZfcuBtqZdCgt7zSEueb8zo1I78m1nH6oY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250529113417epcas5p4913bfcdebcbf40173aa088f75116ecc8~D-EXr8ISM1596915969epcas5p4A;
	Thu, 29 May 2025 11:34:17 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.175]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4b7PQw1Fqdz6B9m5; Thu, 29 May
	2025 11:34:16 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250529113311epcas5p3c8f1785b34680481e2126fda3ab51ad9~D-DZugUHF0980809808epcas5p3Y;
	Thu, 29 May 2025 11:33:11 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529113310epsmtrp24c693352404dc8921ffaebdb46d76e3c~D-DZoI3zJ3201832018epsmtrp2U;
	Thu, 29 May 2025 11:33:10 +0000 (GMT)
X-AuditID: b6c32a52-41dfa70000004c16-96-683845f61a79
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.A2.19478.6F548386; Thu, 29 May 2025 20:33:10 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250529113306epsmtip27b8bc9c2fd5f4139f51a8dda75df7888~D-DVgb9KP2456924569epsmtip2m;
	Thu, 29 May 2025 11:33:06 +0000 (GMT)
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
Subject: [PATCH 13/13] writeback: set the num of writeback contexts to
 number of online cpus
Date: Thu, 29 May 2025 16:45:04 +0530
Message-Id: <20250529111504.89912-14-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250529111504.89912-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvO43V4sMg0nLDS22rdvNbjFn/Ro2
	iwvrVjNatO78z2LRNOEvs8Xqu/1sFq8Pf2K0OD31LJPFlkv2Fu8vb2OyWH1zDaPFlmP3GC0u
	P+Gz2D39H6vFzQM7mSxWrj7KZDF7ejOTxZP1s5gttn75ympxaZG7xZ69J1ks7q35z2px4cBp
	VosbE54yWjzbvZHZ4vPSFnaLg6c62C0+zQUacv7vcVaL3z/msDnIeZxaJOGxc9Zddo/NK7Q8
	Lp8t9di0qpPNY9OnSeweJ2b8ZvF4sXkmo8fuBZ+ZPHbfbGDzOHexwuP9vqtsHn1bVjF6TJ1d
	73FmwRF2jxXTLjIFCEVx2aSk5mSWpRbp2yVwZVy+q11wja1iZe9RlgbGo6xdjJwcEgImEq+v
	fGDqYuTiEBLYzijxYeUzZoiEjMTuuzuhioQlVv57zg5R9JFR4tqKiWxdjBwcbAK6Ej+aQkHi
	IgI3mSXOnT0D1sAs8I9RYvcrHRBbWCBG4uz6RjYQm0VAVWL28RtgNbwCdhJNZ19CLZOXmHnp
	OzuIzQkUX7TkKyOILSRgK7H05loWiHpBiZMzn7BAzJeXaN46m3kCo8AsJKlZSFILGJlWMYqm
	FhTnpucmFxjqFSfmFpfmpesl5+duYgSnBK2gHYzL1v/VO8TIxMF4iFGCg1lJhLfJ3ixDiDcl
	sbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJg1OqgSn3nsKHdUEZXB3/
	31+61rnj3FbLW0wfYp0aEl+cOzgrpXP/vyyBDMZFqwIuXN4T1fzt47t21nnG6oI6273rj1/U
	DW/rWWKvP+PuUY7HZw8dW9YTcfFDntJn+4dPrB4ahc88cSpSZMnVutsmAT5Zn+/E6i38t85q
	W3z45H+s4TfU+Rb16/942v1BvFkr7qNY7JmNH57aqPPyvP5krnZAe/ZryUeV199mzU00bf08
	+4BReOTT+l1+f6fZZqr/6n5ZqvZXd2rr/+KA5zktbmcndev81jXurtj4hW257O7dDE3u5yaL
	lR6QbkxOftwuv7UvXT9tzes9allf/UOMNVNSjP5skMiP6rI45q7YVKbMOUWJpTgj0VCLuag4
	EQASq0MleAMAAA==
X-CMS-MailID: 20250529113311epcas5p3c8f1785b34680481e2126fda3ab51ad9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250529113311epcas5p3c8f1785b34680481e2126fda3ab51ad9
References: <20250529111504.89912-1-kundan.kumar@samsung.com>
	<CGME20250529113311epcas5p3c8f1785b34680481e2126fda3ab51ad9@epcas5p3.samsung.com>

We create N number of writeback contexts, N = number of online cpus. The
inodes gets distributed across different writeback contexts, enabling
parallel writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d416122e2914..55c07c9be4cd 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1046,7 +1046,7 @@ int bdi_init(struct backing_dev_info *bdi)
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
-	bdi->nr_wb_ctx = 1;
+	bdi->nr_wb_ctx = num_online_cpus();
 	bdi->wb_ctx_arr = kcalloc(bdi->nr_wb_ctx,
 				  sizeof(struct bdi_writeback_ctx *),
 				  GFP_KERNEL);
-- 
2.25.1


