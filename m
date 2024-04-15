Return-Path: <linux-fsdevel+bounces-16897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DB08A4689
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 03:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931041F21E01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 01:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B0FC19;
	Mon, 15 Apr 2024 01:21:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B14C81;
	Mon, 15 Apr 2024 01:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144080; cv=none; b=BzM0FGKzlFFAGTz0ODddQPqJbMyoVaAgocQ0kaS7LcCFNv1PoN7nJ0YmdBcA9UtUxV4wr7f4w6alntwMi7Cs42+ho7Z7koWuE2MJy5YGPK75/biiPVQgITPyPGRmlIh2Y3YvnWzKJx6UHMFqF5KhCnrRZ8MU01c63fu7aewyG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144080; c=relaxed/simple;
	bh=D/vN8IOJYDo7I7Gn+TQ1u1kvDwd/wpq+BL/NN9WiDVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HJsrg49aC6hKpnv2hoLapELvOTeFrJM2SXN9tWI5zPgX/h8TqLdGFyI3d0AdjUQrCI2cJBKPQtXU1RPRkrGIcv1dYmcw/bL2gGKomw5VH5ooFcvVLXwnuS6azkXcDKgvqT0CFFMAcJ7tfxAYGAXozAE0L3NfCsk+S6naemMapgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VHq703MCZztSPX;
	Mon, 15 Apr 2024 09:18:20 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id DD81814010C;
	Mon, 15 Apr 2024 09:21:09 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:21:08 +0800
From: Long Li <leo.lilong@huawei.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH] xarray: inline xas_descend to improve performance
Date: Mon, 15 Apr 2024 09:21:36 +0800
Message-ID: <20240415012136.3636671-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500009.china.huawei.com (7.221.188.199)

The commit 63b1898fffcd ("XArray: Disallow sibling entries of nodes")
modified the xas_descend function in such a way that it was no longer
being compiled as an inline function, because it increased the size of
xas_descend(), and the compiler no longer optimizes it as inline. This
had a negative impact on performance, xas_descend is called frequently
to traverse downwards in the xarray tree, making it a hot function.

Inlining xas_descend has been shown to significantly improve performance
by approximately 4.95% in the iozone write test.

  Machine: Intel(R) Xeon(R) Gold 6240 CPU @ 2.60GHz
  #iozone i 0 -i 1 -s 64g -r 16m -f /test/tmptest

Before this patch:

       kB    reclen    write   rewrite     read    reread
 67108864     16384  2230080   3637689 6 315197   5496027

After this patch:

       kB    reclen    write   rewrite     read    reread
 67108864     16384  2340360   3666175  6272401   5460782

Percentage change:
                       4.95%     0.78%   -0.68%    -0.64%

This patch introduces inlining to the xas_descend function. While this
change increases the size of lib/xarray.o, the performance gains in
critical workloads make this an acceptable trade-off.

Size comparison before and after patch:
.text		.data		.bss		file
0x3502		    0		   0		lib/xarray.o.before
0x3602		    0		   0		lib/xarray.o.after

Signed-off-by: Long Li <leo.lilong@huawei.com>
---
 lib/xarray.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index fbf1d1dd83bc..31e95b461c03 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -200,7 +200,7 @@ static void *xas_start(struct xa_state *xas)
 	return entry;
 }
 
-static void *xas_descend(struct xa_state *xas, struct xa_node *node)
+static inline void *xas_descend(struct xa_state *xas, struct xa_node *node)
 {
 	unsigned int offset = get_offset(xas->xa_index, node);
 	void *entry = xa_entry(xas->xa, node, offset);
-- 
2.31.1


