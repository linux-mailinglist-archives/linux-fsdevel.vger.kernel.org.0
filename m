Return-Path: <linux-fsdevel+bounces-17020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791068A63A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597B281B70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 06:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3405B697;
	Tue, 16 Apr 2024 06:17:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8543C08A;
	Tue, 16 Apr 2024 06:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248233; cv=none; b=Ip6NU5Al1ZuAYo5NF17B3OmT1fcIaHI7O1wm3JTJTR1DXQa7k9Pd/2pX4yk5tg0wLKLheW31V2DmIKi/U8aLtXvdl5wn6WTOZuAyFIgWdp7Ffo24cQ0xMfNzqAAcNZ1KPqgMY2guAwFfHGCQMED5m4N5+1AGy7vSdqWtnuRymsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248233; c=relaxed/simple;
	bh=gJQU4Bkk4LOP5HF/9EDNIiyhoNs7Y26nmkx+uVMNmyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Xj4DSLBEaFb6XgWUgFTnN/D4t+ccH9mkOVjks0zFJN1QJ+Vi+fn96SGOqmHft9K9v2KuGvst4FzJZELOxkUONjZoUZYNwykPIcraHaU4rNlTFomvrtO4OWt3gjnr8Py4UYPPm0DVzXNFIruZRoEZk7Zn1izPrxRBfAAWjNL2hpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VJYdP4rLYzXlMb;
	Tue, 16 Apr 2024 14:13:45 +0800 (CST)
Received: from kwepemi500009.china.huawei.com (unknown [7.221.188.199])
	by mail.maildlp.com (Postfix) with ESMTPS id AA9B018006D;
	Tue, 16 Apr 2024 14:17:02 +0800 (CST)
Received: from localhost.localdomain (10.175.127.227) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 14:17:01 +0800
From: Long Li <leo.lilong@huawei.com>
To: <willy@infradead.org>, <akpm@linux-foundation.org>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yi.zhang@huawei.com>, <houtao1@huawei.com>, <leo.lilong@huawei.com>,
	<yangerkun@huawei.com>
Subject: [PATCH v2] xarray: inline xas_descend to improve performance
Date: Tue, 16 Apr 2024 14:16:28 +0800
Message-ID: <20240416061628.3768901-1-leo.lilong@huawei.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
 67108864     16384  2230080   3637689  6315197   5496027

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
v2:
 - Using '__always_inline' instead of 'inline' guarantees that xas_descend
 will definitely be inlined. 
 lib/xarray.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/xarray.c b/lib/xarray.c
index fbf1d1dd83bc..84faa433cd24 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -200,7 +200,8 @@ static void *xas_start(struct xa_state *xas)
 	return entry;
 }
 
-static void *xas_descend(struct xa_state *xas, struct xa_node *node)
+static __always_inline void *xas_descend(struct xa_state *xas,
+					struct xa_node *node)
 {
 	unsigned int offset = get_offset(xas->xa_index, node);
 	void *entry = xa_entry(xas->xa, node, offset);
-- 
2.31.1


