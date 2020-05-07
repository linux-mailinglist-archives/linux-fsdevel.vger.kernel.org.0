Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1491C9DA2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEGVoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgEGVob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 17:44:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B1C05BD09
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 14:44:29 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id s9so5896492eju.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p3qBa9K9MbgLEfhWUqlAktM7PPXv8tgud53nGFCyYG0=;
        b=dkeBq94OBb3NF7kVoAbkVx2HSO3CU2chuvwHNFGEWXV0yhNdXxm/WFjxCC0MkuBwOQ
         ukTQVmH3uUPgYCweOd1LQwPUAiwXSwuEHHA3DGaAzdHCj7mD6A77knGTR2DbyLLaoMmr
         P9/xT7V4BL2slYRI2haV4GFVTBcxtTPf1JtlHWg9BSOm7kTAMgWRJ5oRuiN5qcHOOlyX
         BNtTA6Fe24s8s4Oa3ZVX5xjq6Kj2yZ8P5YLEXdWpAx+lfEA+3pPnLlKxThXhKsFv5fWe
         zkNndfIoksb9SEG4OkxblR24QSkvS1+qVaCorcEY8RlAtYD1QYFhXRzyfiZlmBPsE72S
         mwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p3qBa9K9MbgLEfhWUqlAktM7PPXv8tgud53nGFCyYG0=;
        b=Mn/XDTgTUVoSCa5tZBb7D8j8cxDFNHpM60I0VjnRm4UUDLqG1DfRJX2OQy4XAWjppU
         yHEOEPwz1EMQAOEMkm6rwUHh57rFiPo8FtJ5/Hg3ceVcnL5LUWjGQ+P+QbtjlNY/wP+E
         0PS6zL7vg85i56txxbZeXoM9qh54ROxSoC/uhINukMXa1i2fSibQI93nHQss6Nun+YBg
         /5YqxkQ1VnB40eYNzyRMEvp/sHTiOblTvTF4S9r2gDsaZOnvXvf4h8oD4U4n73YTG0tC
         1XU9evVP44HBpw6tm4Lr+Jqai6b2/ZBOmegh1sYlFkoSftnnk3VglCV/K/T9mIut8yTx
         hZiQ==
X-Gm-Message-State: AGi0PubYNkWjYkSGW78yZxhTxjXVSWJebHzZyyA6ssxfiNPciu/NEVMp
        3t3RkGqQrSgU413b8kOzvhblEiyv/E0EfA==
X-Google-Smtp-Source: APiQypIynmIlSHyf+k65C+y42oKo8PLrA1c4S7WEkoE13fKDpP+OJZwLHdb5GIwza40Y5+tp0xnxFQ==
X-Received: by 2002:a17:906:a857:: with SMTP id dx23mr14469278ejb.52.1588887868069;
        Thu, 07 May 2020 14:44:28 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:a1ee:a39a:b93a:c084])
        by smtp.gmail.com with ESMTPSA id k3sm613530edi.60.2020.05.07.14.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:44:27 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     david@fromorbit.com, hch@infradead.org, willy@infradead.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [RFC PATCH V3 10/10] mm/migrate.c: call detach_page_private to cleanup code
Date:   Thu,  7 May 2020 23:44:00 +0200
Message-Id: <20200507214400.15785-11-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
References: <20200507214400.15785-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We can cleanup code a little by call detach_page_private here.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
Added since RFC V3.

 mm/migrate.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7160c1556f79..f214adfb3fa4 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -797,10 +797,7 @@ static int __buffer_migrate_page(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		goto unlock_buffers;
 
-	ClearPagePrivate(page);
-	set_page_private(newpage, page_private(page));
-	set_page_private(page, 0);
-	put_page(page);
+	set_page_private(newpage, detach_page_private(page));
 	get_page(newpage);
 
 	bh = head;
-- 
2.17.1

