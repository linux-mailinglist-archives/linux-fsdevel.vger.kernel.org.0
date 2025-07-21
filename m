Return-Path: <linux-fsdevel+bounces-55552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B25B0BC6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3543A7A7BA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 06:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335426E6FF;
	Mon, 21 Jul 2025 06:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YUKuj6sU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC44026E6EF
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078844; cv=none; b=gujPE4Uj7Nv4+EEsZ7dKThzwMuF8YAzc+W/+J1DNsBhj2wb+kB1uen4hkZu3CZIDdSN5mDjDqIuGuRBT16BxT/2mDva8pHjLA6SwZuFQT/wme25W9N6q/ro1yeIrm9HfpAZ6tocjjXzRG4DUDUV8p0vHHTyLoWzsl7fTR5JGDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078844; c=relaxed/simple;
	bh=fQk6nSWeQuF0vCVcMA4Ltmv16D5fu/QW6hFWoM8Z/G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=HRKQERIPczb+stnDZcrseuVsi3V7bG1RwM66mFJHN4P8PbJpF//JLqRBZtB6wVys1AQZgT+D0IfMw1d02kvS7kRQZVf3uToP+El5Sgh0N/3oKu6EzibbQaPF3jlBM/hC/D90tEC4GhdUr/KwBzTHqruIY9Vi4BqqxEzFxbyDqt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YUKuj6sU; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250721062039epoutp03c39eec7863f8a651976864e2f02a3a59~UL_qieey80646006460epoutp03J
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jul 2025 06:20:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250721062039epoutp03c39eec7863f8a651976864e2f02a3a59~UL_qieey80646006460epoutp03J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753078839;
	bh=/XDvTMExPc0Dk39AQxulHgbEVBf+0npFbOQqjpCb3KM=;
	h=From:To:Cc:Subject:Date:References:From;
	b=YUKuj6sUvf7gsaAK5mqAKjZIZEAsIkwQA6JuY1EZvAeLkB2S6heUWo5dBUfZ11lEC
	 DqF6BoS7SX87q6WTnt07sRET2DQ8e1Gcg6GvTBl/llizIKJESuLxYh0zWDiYGZkhuV
	 zQlXwhoeXs/jH5JhZ3zdbx5GMJTrcknoUxSj4ICQ=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
	20250721062039epcas2p231de33c9e10289860dec2211b5db9ca6~UL_p7L4xK0939509395epcas2p2P;
	Mon, 21 Jul 2025 06:20:39 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.36.68]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4blqyZ3ZDHz2SSKf; Mon, 21 Jul
	2025 06:20:38 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3~UL_ouoOxF0449004490epcas2p24;
	Mon, 21 Jul 2025 06:20:37 +0000 (GMT)
Received: from rack03.dsn.sec.samsung.com (unknown [10.229.95.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250721062037epsmtip18cc76bfe8dac1a5b8d8cb913d91e9f0d~UL_opJvV50948009480epsmtip1K;
	Mon, 21 Jul 2025 06:20:37 +0000 (GMT)
From: "hy50.seo" <hy50.seo@samsung.com>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
	kwangwon.min@samsung.com, kwmad.kim@samsung.com, cpgs@samsung.com,
	h10.kim@samsung.com, willdeacon@google.com, jaegeuk@google.com,
	chao@kernel.org, linux-fsdevel@vger.kernel.org
Cc: "hy50.seo" <hy50.seo@samsung.com>
Subject: [PATCH v1] writback: remove WQ_MEM_RECLAIM flag in bdi_wq
Date: Mon, 21 Jul 2025 15:40:24 +0900
Message-Id: <20250721064024.113841-1-hy50.seo@samsung.com>
X-Mailer: git-send-email 2.26.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-234,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3
References: <CGME20250721062037epcas2p25fd6fcf66914a419ceefca3285ea09f3@epcas2p2.samsung.com>

if it write with the write back option with f2fs, kernel panic occurs.
Because the write back function uses bdi_wq and WQ_MEM_RECLAIM flag
is included and created.
However, this function calls f2fs_do_quota() of f2fs and finally tries to
perform quota_release_work.
the quota_release_work is performed in the events_unbound workqueue,
but the WQ_MEM_RECLAIM flag is not included.
Therefore, it causes warn_on_panic.

workqueue: WQ_MEM_RECLAIM writeback:wb_workfn is flushing !WQ_MEM_RECLAIM events_unbound:quota_release_workfn
Workqueue: writeback wb_workfn (flush-8:0)
Call trace:
 check_flush_dependency+0x160/0x16c
 __flush_work+0x168/0x738
 flush_delayed_work+0x58/0x70
 dquot_writeback_dquots+0x90/0x4bc
 f2fs_do_quota_sync+0x120/0x284
 f2fs_write_checkpoint+0x58c/0xe18
 f2fs_gc+0x3e8/0xd78
 f2fs_balance_fs+0x204/0x284
 f2fs_write_single_data_page+0x700/0xaf0
 f2fs_write_data_pages+0xe94/0x15bc
 do_writepages+0x170/0x3f8
 __writeback_single_inode+0xa0/0x8c4
 writeback_sb_inodes+0x2ac/0x708
 __writeback_inodes_wb+0xc0/0x118
 wb_writeback+0x1f4/0x664
 wb_workfn+0x62c/0x900
 process_one_work+0x3f8/0x968
 worker_thread+0x610/0x794
 kthread+0x1c4/0x1e4
 ret_from_fork+0x10/0x20

Signed-off-by: hy50.seo <hy50.seo@samsung.com>
---
 mm/backing-dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..6ef5f23810fc 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -491,8 +491,7 @@ postcore_initcall(bdi_class_init);
 
 static int __init default_bdi_init(void)
 {
-	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_UNBOUND |
-				 WQ_SYSFS, 0);
+	bdi_wq = alloc_workqueue("writeback", WQ_UNBOUND | WQ_SYSFS, 0);
 	if (!bdi_wq)
 		return -ENOMEM;
 	return 0;
-- 
2.26.0


