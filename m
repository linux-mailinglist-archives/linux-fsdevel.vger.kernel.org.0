Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62C23C42CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 06:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbhGLEU5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 00:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhGLEUv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 00:20:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7744DC0613EE;
        Sun, 11 Jul 2021 21:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X+IZ0Ep8TTXU5sz3UYPBHrP2s83IdnYHuhDKO7Blwyw=; b=NG75D3frxlpfIun9/yUjWh7jk/
        cWAgZllhumtuZBVkpBQqh46HEXmuqP5aqPhfg5vtkR/gNJ5DQEEkBFi/b41WNfQnV7156TEZeIkuB
        dDmh+jZrmrzil/2V0n/7wsSMO88wIJRgzXEcf4QGFiRx773lQtDL1tDaopownWbfIaaQg1qAqkGRH
        AKQOh6+YEEQldu/crDZr0Krl8mRYgHQMO060BjexEaw5jl34MT1DYTCbgNf+exINOK/VO5hLgU6QZ
        TZj3/9RJIhLNGZtVYuw+t1sVGAJno+szcqFOIdsfkCwwhBUS49vomT0VTvA782sR9kpKCC5fFrctl
        nPO5yokg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2nNN-00GrgK-OC; Mon, 12 Jul 2021 04:17:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v13 132/137] mm: Fix READ_ONLY_THP warning
Date:   Mon, 12 Jul 2021 04:06:56 +0100
Message-Id: <20210712030701.4000097-133-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712030701.4000097-1-willy@infradead.org>
References: <20210712030701.4000097-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These counters only exist if CONFIG_READ_ONLY_THP_FOR_FS is defined,
but we should not warn if the filesystem natively supports THPs.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 26a001ea7869..71844b55d0a8 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -146,7 +146,7 @@ static inline void filemap_nr_thps_inc(struct address_space *mapping)
 	if (!mapping_thp_support(mapping))
 		atomic_inc(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_thp_support(mapping));
 #endif
 }
 
@@ -156,7 +156,7 @@ static inline void filemap_nr_thps_dec(struct address_space *mapping)
 	if (!mapping_thp_support(mapping))
 		atomic_dec(&mapping->nr_thps);
 #else
-	WARN_ON_ONCE(1);
+	WARN_ON_ONCE(!mapping_thp_support(mapping));
 #endif
 }
 
-- 
2.30.2

