Return-Path: <linux-fsdevel+bounces-14968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610958859D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 14:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1696B21C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C56B84A4F;
	Thu, 21 Mar 2024 13:16:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FA84A37;
	Thu, 21 Mar 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027015; cv=none; b=owbiqVX0nIMCkJElthlxSj2ZSHJCBXDTV1J4oTP0ZIU+HYRMtWgMLSYm8n6gLab2hwt79ZF+R6zZLoRGKH41Obn6/gVpRYxchATFLXAPjwokzvI+445LBVNF0H8GD7myhWUoAkYnAvfUnAha47TSYXPST+H8TEYZKzVlSFT5Fx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027015; c=relaxed/simple;
	bh=NnhdgZ+fHdsMTH63wmWpTrWtLm6hi5tB7hLyZAa6TPM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ClMOoJhFVt7YpBRpLzNJvKfyU2+fxlJBiZwNYJSTOFDFOaNaXrx1HGCobZcCiR5yqlv79TtyC9zvI8VaTRKv95elr4bhobUv6A+8OE3iWJpJ6ncrV86+FNvr+Z0RCTvIR2CC52jZyKCykHXc51yCeaTBd3aTUn/YSKuKbru/a6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V0mBb53zvzwPZB;
	Thu, 21 Mar 2024 21:14:15 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 9341F140FEA;
	Thu, 21 Mar 2024 21:16:49 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 21:16:49 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/3] fs: aio: more folio conversion
Date: Thu, 21 Mar 2024 21:16:37 +0800
Message-ID: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Convert to use folio throughout aio.

v2:
- fix folio check returned from __filemap_get_folio()
- use folio_end_read() suggested by Matthew

Kefeng Wang (3):
  fs: aio: use a folio in aio_setup_ring()
  fs: aio: use a folio in aio_free_ring()
  fs: aio: convert to ring_folios and internal_folios

 fs/aio.c | 91 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 47 insertions(+), 44 deletions(-)

-- 
2.27.0


