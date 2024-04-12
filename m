Return-Path: <linux-fsdevel+bounces-16773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A38A265A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965F8B22F45
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 06:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4E024B23;
	Fri, 12 Apr 2024 06:20:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A53234
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 06:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902852; cv=none; b=EzzT6DTLVAj8GozqHnq8E4v9grZmswA6RGlvlxGlxFrh9rfCKzPDCew1//sedZqI7C7AbOe9JylX7zpIKOx0Dp8PdXadUED5AjhDpTwPaUWEaPdcBzHSmgc2RKiLLvxEHAkubKtlNrAW+mqwIJKpuEZnzsW8VbHJnoyk3BCflu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902852; c=relaxed/simple;
	bh=aQTSkG25ABXe+42CWBhZdbeL2Dig0lCBrs/gHZfrF30=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VwkVyPA4hZpDTTSXLGjqt8ADq3LQl3pEW/vZMGLtZslGHdv2fQI1B1sCR2OmzFGB7qKSjzCAG1sPK7Ik9ZxCItzndXQZrVt6jE/wPCYY4OysfbAA4CMvhnvBYLEAy0rCga7nXl6argIPeCZpKwrc9iwM60tMS0qsit7sYvQuIqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VG5y93VYSz1wrM2;
	Fri, 12 Apr 2024 14:19:45 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B6A021A0188;
	Fri, 12 Apr 2024 14:20:41 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 14:20:41 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 0/2] mm: batch mm counter updating in filemap_map_pages()
Date: Fri, 12 Apr 2024 14:47:49 +0800
Message-ID: <20240412064751.119015-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Let's batch mm counter updating to accelerate filemap_map_pages(). 

v2:
- estimate folio type from caller and no need to return from
  set_pte_range()
- use unsigned long for rss

v3: 
- make is_cow to bool in patch1 and fix null folio in patch2
- retest, improvement same with v1

Kefeng Wang (2):
  mm: move mm counter updating out of set_pte_range()
  mm: filemap: batch mm counter updating in filemap_map_pages()

 mm/filemap.c | 17 ++++++++++++-----
 mm/memory.c  |  8 +++++---
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.41.0


