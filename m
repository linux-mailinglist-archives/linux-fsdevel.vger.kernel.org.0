Return-Path: <linux-fsdevel+bounces-18067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B88B5243
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A741928188E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBBC14AA8;
	Mon, 29 Apr 2024 07:24:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19D1426E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2024 07:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714375479; cv=none; b=K58JWDn8Fkj44dv+yFyyUk7XmKjsR1yura0qzr4oQpNIHpgbP/FiJhN0Uar9rgyho5h7SwPc9PDDImtYOTXZpNKH1kyafxrexznkK8bPzmCqft1P8K8Kswwr/8pmD8MZKM9uR92SpTlhw6JJP5QleVckW6GRhp2j7QbTXrPc5jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714375479; c=relaxed/simple;
	bh=v9i7XZ7Jr9oe74DBwuaLoWLH30mxrLkc0t8QcDKevt8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O3CjE7c4+4r8rmTOOI38Rm64okJjesSiF9GZJz56GxwRvkyz3YKUOXItZ/WNwP96kjIIONKh45K9tlPO8uUuX4cI0nGlVp4FkCmNkRepE8S2NI1Hj6RaKgDU149m02YSsLMZtAqTM9sNCGpWyQTCk7WFTcom1Ds77D7nJ7cJQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VSZWM4BYqz1RDTr;
	Mon, 29 Apr 2024 15:21:19 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 73978140390;
	Mon, 29 Apr 2024 15:24:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Apr 2024 15:24:28 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH rfc 0/4] mm: filemap: try to batch lruvec stat updating
Date: Mon, 29 Apr 2024 15:24:13 +0800
Message-ID: <20240429072417.2146732-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm100001.china.huawei.com (7.185.36.93)

It is similar to mm counter updating, try to batch lruvec stat updating,
which could save most of time when all folios in same memcg/padat,
lat_pagefault shows 3~4% improvement.

Kefeng Wang (4):
  mm: memory: add prepare_range_pte_entry()
  mm: filemap: add filemap_set_pte_range()
  mm: filemap: move __lruvec_stat_mod_folio() out of
    filemap_set_pte_range()
  mm: filemap: try to batch lruvec stat updating

 include/linux/mm.h   |  2 ++
 include/linux/rmap.h |  2 ++
 mm/filemap.c         | 75 ++++++++++++++++++++++++++++++++++++--------
 mm/memory.c          | 33 ++++++++++++-------
 mm/rmap.c            | 16 ++++++++++
 5 files changed, 104 insertions(+), 24 deletions(-)

-- 
2.27.0


