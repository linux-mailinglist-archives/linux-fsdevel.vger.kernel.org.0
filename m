Return-Path: <linux-fsdevel+bounces-14955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DEB8855A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74FC1F223AC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Mar 2024 08:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8745A117;
	Thu, 21 Mar 2024 08:27:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4C2E41A;
	Thu, 21 Mar 2024 08:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711009664; cv=none; b=fwLqS3Kf1tDILVBRgW1WoR49GzGIcYFKHaZzsP01YzjgysNJUsrw0sIlLalJRPaBffTxI9ID3oYkiO6hLSuQI2/vh8Qjhq9jJ95uZdbuYqNS+cvjoWSZeW6ssoc75OKryZXWnVCn3ovEb3Ukiid5OmU3XlwM6omevvacgpGLNCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711009664; c=relaxed/simple;
	bh=fX8Ji1w5GlegFTVQrthuRLrhBH949INdDZAkTey3mpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OG7kJ8Da16nWprpnKrlUSZ47yWDDulMAdte4agcM0yjrYnqhPIWfipgdiZ9J7N1bcf3m4PODfXHJ/GPdC50HY+gFvDdgfIJZ9aQknL46UWTrZZBh++p7QgmkRlRfTttXvMHoGPr15PCX7CIkpa5MohXKuCM+D+imq66NwjmWhqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V0dpz44zfz1vx3b;
	Thu, 21 Mar 2024 16:26:51 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 333941400D5;
	Thu, 21 Mar 2024 16:27:38 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Mar 2024 16:27:37 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise
	<bcrl@kvack.org>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, <linux-kernel@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
CC: <linux-aio@kvack.org>, <linux-fsdevel@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH 0/3] fs: aio: more folio conversion
Date: Thu, 21 Mar 2024 16:27:30 +0800
Message-ID: <20240321082733.614329-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
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

Convert to use folio throughout aio.

Kefeng Wang (3):
  fs: aio: use a folio in aio_setup_ring()
  fs: aio: use a folio in aio_free_ring()
  fs: aio: convert to ring_folios and internal_folios

 fs/aio.c | 92 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 48 insertions(+), 44 deletions(-)

-- 
2.27.0


