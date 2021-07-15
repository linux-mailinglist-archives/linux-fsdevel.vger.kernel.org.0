Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A743C985F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 07:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbhGOF3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 01:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhGOF26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 01:28:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131B7C06175F;
        Wed, 14 Jul 2021 22:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=0j89Y9aRfbS0Rk8ILDg18YHesTGwlxkjEArXWx9pLdg=; b=rtZ8plYfg2O2vQnMqCcN8Ix1eV
        0XJ3QSThuBsUacVKOjdcIEAp2lxqyCZfpWvfL3hS76LBjhmK4tzKQWTC+ibKYHQbVguyCr3NUCT/l
        PfiDy86CIphQ+viU7oNBndb1wti75NmlHC6gxm1d+t1Cee2mwhtd/5LFKF1TA7HA4/TBS5bfjsZBK
        B9GlLpfAAYV2XjdDz31IcMs6Ff/yg+qAPAiXiogB7y4H3S19Ap1QH+jLHS2AQiTBQ2T0KDtCjUZwJ
        ns8WUYvvrwBXkKxngBqKxGgMunIOwXrWcWD/izHm4xbuTwdbZ78ZPrjccbmsd4s/WgKzPl7y51run
        ct8aCKMw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3tqn-00312o-KS; Thu, 15 Jul 2021 05:24:07 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 133/138] mm: Fix READ_ONLY_THP warning
Date:   Thu, 15 Jul 2021 04:36:59 +0100
Message-Id: <20210715033704.692967-134-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715033704.692967-1-willy@infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
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
index 25b1bf3b1cdb..81cccb708df7 100644
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

