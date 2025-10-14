Return-Path: <linux-fsdevel+bounces-64122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 310ECBD947B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FBA3A3434
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 12:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EC3128D0;
	Tue, 14 Oct 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HU1owRtt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D9A3128AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760443891; cv=none; b=rdUkMEsvJGRy8hwZuGIYfirQ8fui9HmnpHVj8+rDd7AZrO0mCqK0Ml+mLwFQu7Mvq8WWvgSkaKGoZGEPW3vIe6c2NuDVE2Nen8k2KRQUMDZqM9d+XUsxXnU72MnkONBlMZVGpB/BJ4r0tT85cVrJXMPwqI5vAjUM+94ySnpGpwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760443891; c=relaxed/simple;
	bh=fNGpQFig8Sias58rHupglF6VljJZ6gxFyxLbqRdVK9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=ehctmgQBPVNVyeAVEDT1V53Vc57Kn8rFzQsQw2CZHWK/M/mQtiydJNARdHDWfN9YafCRB69jhhRpq8Z7saNu+3eqCilqU9iAf9hM4Q+BY+ObiZ/ZaT/hdZsrLPE0RfYgStj+oS1Wd0x5lemK3jBzngsv5bszOFpb7yZgvdkqMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HU1owRtt; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20251014121124epoutp048b515509447f9f96ba30af5d47c172e8~uWmK_O7D_0942109421epoutp04g
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 12:11:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20251014121124epoutp048b515509447f9f96ba30af5d47c172e8~uWmK_O7D_0942109421epoutp04g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760443884;
	bh=dwBpUXQfG7i2fALdF6f1q8XsBcwMf2eGmUyV9zrLQHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HU1owRttA0sQRI1Z9TN9qM1ddUI4JJUFuaaQzl2wcJbmMM5rTkBDDZ0WzFIKMxaAA
	 lI7GVfJew83fPS3YuYz7LV8eeCqvzI/jXQ+gvJ3c86LtMJFJmokaLIg8Z3HghP5TQW
	 m569xP+4XDE2j2xY3S6/UNvzDpn6pRUL9ISvshKE=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20251014121123epcas5p1330df23fc6e704bfe3dacd803c760035~uWmKOQOu51962519625epcas5p1O;
	Tue, 14 Oct 2025 12:11:23 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4cmCk256b3z6B9m5; Tue, 14 Oct
	2025 12:11:22 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20251014121122epcas5p3a01a79d090c3cca8caaf78c0f411e4c4~uWmIzFnPN0753207532epcas5p3L;
	Tue, 14 Oct 2025 12:11:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251014121118epsmtip14e669bdfec98f1f53a760340393d0778~uWmE96OG51256112561epsmtip1K;
	Tue, 14 Oct 2025 12:11:17 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: jaegeuk@kernel.org, chao@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, miklos@szeredi.hu, agruenba@redhat.com,
	trondmy@kernel.org, anna@kernel.org, akpm@linux-foundation.org,
	willy@infradead.org, mcgrof@kernel.org, clm@meta.com, david@fromorbit.com,
	amir73il@gmail.com, axboe@kernel.dk, hch@lst.de, ritesh.list@gmail.com,
	djwong@kernel.org, dave@stgolabs.net, wangyufei@vivo.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, kundan.kumar@samsung.com, anuj20.g@samsung.com,
	vishak.g@samsung.com, joshi.k@samsung.com
Subject: [PATCH v2 13/16] writeback: configure the num of writeback contexts
 between 0 and number of online cpus
Date: Tue, 14 Oct 2025 17:38:42 +0530
Message-Id: <20251014120845.2361-14-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014120845.2361-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251014121122epcas5p3a01a79d090c3cca8caaf78c0f411e4c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20251014121122epcas5p3a01a79d090c3cca8caaf78c0f411e4c4
References: <20251014120845.2361-1-kundan.kumar@samsung.com>
	<CGME20251014121122epcas5p3a01a79d090c3cca8caaf78c0f411e4c4@epcas5p3.samsung.com>

The number of writeback contexts can be configured, with a valid range
between 0 and the number of online CPUs. Inodes are then distributed
across these contexts, enabling parallel writeback.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 mm/backing-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 0a772d984ecf..0a3204a3a3a3 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1046,6 +1046,12 @@ int bdi_init(struct backing_dev_info *bdi)
 	bdi->min_ratio = 0;
 	bdi->max_ratio = 100 * BDI_RATIO_SCALE;
 	bdi->max_prop_frac = FPROP_FRAC_BASE;
+
+	/*
+	 * User can configure nr_wb_ctx using the newly introduced sysfs knob.
+	 * echo N > /sys/class/bdi/<maj>:<min>/nwritebacks
+	 * Filesystem can also increase same during mount.
+	 */
 	bdi->nr_wb_ctx = 1;
 	bdi->wb_ctx = kcalloc(bdi->nr_wb_ctx,
 				  sizeof(struct bdi_writeback_ctx *),
-- 
2.25.1


