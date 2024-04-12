Return-Path: <linux-fsdevel+bounces-16761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151CB8A23C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 04:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AD28433B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F96211198;
	Fri, 12 Apr 2024 02:30:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26352D53E
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889001; cv=none; b=LgKCjeS4exxFliw9jeNy02uWxJsaa2+I2jGLC2zoePbvL7IxejW/78oat6qrP2syDCxSkdMdUeT4ZWdBIqn1qJtazPBWNYDWTCgMEKvluhInLHRIsWXeayiGeuqG2rs+/idT7qUnk1cjvacoszzWzbhwRANmLWFZTfwN/0H08ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889001; c=relaxed/simple;
	bh=Sen99vYRGsAOQm3v7IZmr2vHDtK5KZwwXbmHCFWbyRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lziZ2oQ/PsFao1GCGsiWnM497mZnL4w0op7anIfgAgoru/EpRkg1dp9L0WxxbxfUG+9zstnsakjAUvKNMRchZLdy6QQHd3NvwmHffxOHNo3aIwt8W6V6SYrFR/FbhkvA9SsYufa+SlTn383Qu9aeB8uOFKJ6nM3B/t57jPiByAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VG0nb2nCwzwRcq;
	Fri, 12 Apr 2024 10:26:59 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id A66F518006B;
	Fri, 12 Apr 2024 10:29:56 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 10:29:56 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 0/2] mm: batch mm counter updating in filemap_map_pages()
Date: Fri, 12 Apr 2024 10:57:02 +0800
Message-ID: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Let's batch mm counter updating to accelerate filemap_map_pages(). 

v2:
- estimate folio type from caller and no need to return from
  set_pte_range()
- use unsigned long for rss

Kefeng Wang (2):
  mm: move mm counter updating out of set_pte_range()
  mm: filemap: batch mm counter updating in filemap_map_pages()

 mm/filemap.c | 14 ++++++++++----
 mm/memory.c  |  8 +++++---
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.41.0


