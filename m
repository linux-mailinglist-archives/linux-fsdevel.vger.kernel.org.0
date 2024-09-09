Return-Path: <linux-fsdevel+bounces-28918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C38970DCB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 08:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F6E41F22801
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2024 06:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89118176FDF;
	Mon,  9 Sep 2024 06:17:45 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 189.cn (ptr.189.cn [183.61.185.101])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95AC101F7;
	Mon,  9 Sep 2024 06:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725862665; cv=none; b=ZFieNLztU8xKvO1l/c3uoDxnc+bMefEBVEJ8mtTeqwiQo2RpRxpKbDO0lc9b47aUfCN+eDE3vrw6I8htiqA7tzcwHtzFFvktWENMqh6MFVb837WwECA/WabNbENaJJN55A/RL/BUVLetYcnNcJzZOgEmmV65XfWSKm5cgE1wAFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725862665; c=relaxed/simple;
	bh=V5nSOAXQRm890+80kRs6becI47NhojlDPCW+3UaHPEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixh/HPax+KY8FtSmFqDvblukVKJ9Fw9dgT0Ux5KkEswft3+cuacc1k8Ddrazl9GMY36YcS0bt1kDdqyZmGC9iB/LtOpXEemGVpuopREztxZ3YUAOukJv8lPqm9asPoL9DOjNDqSEXBhbBsqPtm95/SeYNQHPBqNUwDx1avPPFTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.243.220:8405.744959442
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-123.150.8.42 (unknown [10.158.243.220])
	by 189.cn (HERMES) with SMTP id E365C1002BE;
	Mon,  9 Sep 2024 14:17:37 +0800 (CST)
Received: from  ([123.150.8.42])
	by gateway-153622-dep-68cfdf7599-nkmwn with ESMTP id e80b8439e6f344f8b2eb94403cb88e37 for willy@infradead.org;
	Mon, 09 Sep 2024 14:17:37 CST
X-Transaction-ID: e80b8439e6f344f8b2eb94403cb88e37
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 123.150.8.42
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
To: willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] mm/filemap: introduce local helper for_each_folio
Date: Mon,  9 Sep 2024 14:17:35 +0800
Message-Id: <20240909061735.152421-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

Introduce for_each_folio to iterate folios in xarray for code style
compliance and better readability.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 mm/filemap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d62150418b91..5386348acacd 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -62,6 +62,9 @@
 
 #include "swap.h"
 
+#define for_each_folio(folio, xas, max)	\
+	for (folio = xas_load(&xas);	\
+		 folio && xas.xa_index <= max; folio = xas_next(&xas))
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -2170,8 +2173,7 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
 
 	rcu_read_lock();
 
-	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
-			folio = xas_next(&xas)) {
+	for_each_folio(folio, xas, end) {
 		if (xas_retry(&xas, folio))
 			continue;
 		/*
@@ -2306,7 +2308,7 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	struct folio *folio;
 
 	rcu_read_lock();
-	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
+	for_each_folio(folio, xas, ULONG_MAX) {
 		if (xas_retry(&xas, folio))
 			continue;
 		if (xas.xa_index > max || xa_is_value(folio))
-- 
2.34.1


