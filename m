Return-Path: <linux-fsdevel+bounces-16677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCAC8A14D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC3D1C22B17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825F028399;
	Thu, 11 Apr 2024 12:42:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51140C1F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712839363; cv=none; b=LFoX3VkDGpnGMR/7ITVO4K2brFaN4rR+bjID3xcQItWk7vdfLO04W8TEvGrTPvKNbN3Fnc6WqTcakOpCZfPrOuWBX1xMVcIpSqiBxIhCH0yXH0k3Yr4TIvMkMOLcjFXgnTujptgfltFdLmaSyq4UsByERpbKsmfbSE+z3iusEgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712839363; c=relaxed/simple;
	bh=Ja3aNM8pCxWLHqK0Gn2xwzFebvKSTdvM5ogm8qpcTuo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KtpdeFIGZtpg/+XhCmTP7cf/bP4gmMjXgUqeAhqRl57yC6TkAG79yvayafEGRiAWJnMp4NaGEX2bVpAhOFTBQUhTUsGfFFgKJUo1CQeq48eK+vx3Gnx56J90pOhX4flYUGtFUaxhLC7B+AWS6OlJu5vuGsf4tAu6VANomC+ux8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFfRp20s7z1yn4Y;
	Thu, 11 Apr 2024 20:40:22 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1ADE61A0172;
	Thu, 11 Apr 2024 20:42:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 11 Apr 2024 20:42:38 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "Matthew Wilcox (Oracle)" <willy@infradead.org>, <linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 0/2] mm: batch mm counter updating in filemap_map_pages()
Date: Thu, 11 Apr 2024 21:09:48 +0800
Message-ID: <20240411130950.73512-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100001.china.huawei.com (7.185.36.93)

Let's batch mm counter updating to accelerate filemap_map_pages(). 

Kefeng Wang (2):
  mm: move mm counter updating out of set_pte_range()
  mm: filemap: batch mm counter updating in filemap_map_pages()

 include/linux/mm.h | 18 ++++++++++++++++--
 mm/filemap.c       | 21 ++++++++++++++-------
 mm/memory.c        | 30 +++++++++++-------------------
 3 files changed, 41 insertions(+), 28 deletions(-)

-- 
2.41.0


