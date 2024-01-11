Return-Path: <linux-fsdevel+bounces-7796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E46C482B0BE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83A931F244EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CA94CDFD;
	Thu, 11 Jan 2024 14:38:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5D64C3C4;
	Thu, 11 Jan 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 11 Jan
 2024 17:38:39 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, "Matthew Wilcox (Oracle)"
	<willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Alexey
 Khoroshilov <khoroshilov@ispras.ru>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	Karina Yankevich <k.yankevich@omp.ru>, <lvc-project@linuxtesting.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH 5.10 2/2] mm/truncate: Replace page_mapped() call in invalidate_inode_page()
Date: Thu, 11 Jan 2024 14:37:47 +0000
Message-ID: <20240111143747.4418-3-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240111143747.4418-1-r.smirnov@omp.ru>
References: <20240111143747.4418-1-r.smirnov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/11/2024 14:25:57
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182570 [Jan 11 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;r.smirnovsmtp.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/11/2024 14:31:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/11/2024 1:37:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Commit e41c81d0d30e1a6ebf408feaf561f80cac4457dc upstream.

folio_mapped() is expensive because it has to check each page's mapcount
field.  A cheaper check is whether there are any extra references to
the page, other than the one we own, one from the page private data and
the ones held by the page cache.

The call to remove_mapping() will fail in any case if it cannot freeze
the refcount, but failing here avoids cycling the i_pages spinlock.

[Roman: replaced folio_ref_count() call with page_ref_count(),
folio_nr_pages() call with compound_nr() and
folio_has_private() call with page_has_private()]

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Roman Smirnov <r.smirnov@omp.ru>
---
 mm/truncate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 03998fd86e4a..72d6c62756fd 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -232,7 +232,8 @@ int invalidate_inode_page(struct page *page)
 		return 0;
 	if (PageDirty(page) || PageWriteback(page))
 		return 0;
-	if (page_mapped(page))
+	if (page_ref_count(page) >
+			compound_nr(page) + page_has_private(page) + 1)
 		return 0;
 	if (page_has_private(page) && !try_to_release_page(page, 0))
 		return 0;
-- 
2.34.1


