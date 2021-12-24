Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4753C47EC16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Dec 2021 07:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351641AbhLXGXc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Dec 2021 01:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351609AbhLXGXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Dec 2021 01:23:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52301C061759;
        Thu, 23 Dec 2021 22:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GCyk6zZKp2RWgTwwI6EI0gxE2WA30PmTu4Hdr1H/26c=; b=fRfYZji/kkL4OAtwBJ8/8Jhd9G
        LHsAeeiqY/q707TiuPSZPUSDOYPohmjG7ha89f0p6OFZEy1Rv79NrVmUFsr+nWhzJ8Ard8xPBpyHu
        2r5NlGxKLtBWSKH/3hcLVPtcGexIpkekb4g21NWGT/+R9vps6f2nDttMaOeER6MRQw1iA6w3yMAL7
        f75b1tn7ZH6NdN1wE2qybYZGQF6ZAlM/xlEXJKY29IZ2Hg1PWNSFoTlu43VG46lbYnOur5EfJdcJp
        Fy0JFkaz+cgavltYhY8SVvDWvjW+joYEpcuwKoqVJ8bMAlMcAyhnoeEbTJaModnp9UwKxwdgeHjm8
        pTDXSP0g==;
Received: from p4fdb0b85.dip0.t-ipconnect.de ([79.219.11.133] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0dz1-00Dn6r-Nc; Fri, 24 Dec 2021 06:23:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 09/13] frontswap: remove frontswap_test
Date:   Fri, 24 Dec 2021 07:22:42 +0100
Message-Id: <20211224062246.1258487-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211224062246.1258487-1-hch@lst.de>
References: <20211224062246.1258487-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

frontswap_test is unused now, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/frontswap.h | 11 -----------
 mm/frontswap.c            |  2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index a9817d4fa74c1..c5b2848d22404 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -18,7 +18,6 @@ struct frontswap_ops {
 
 extern void frontswap_register_ops(struct frontswap_ops *ops);
 
-extern bool __frontswap_test(struct swap_info_struct *, pgoff_t);
 extern void frontswap_init(unsigned type, unsigned long *map);
 extern int __frontswap_store(struct page *page);
 extern int __frontswap_load(struct page *page);
@@ -33,11 +32,6 @@ static inline bool frontswap_enabled(void)
 	return static_branch_unlikely(&frontswap_enabled_key);
 }
 
-static inline bool frontswap_test(struct swap_info_struct *sis, pgoff_t offset)
-{
-	return __frontswap_test(sis, offset);
-}
-
 static inline void frontswap_map_set(struct swap_info_struct *p,
 				     unsigned long *map)
 {
@@ -56,11 +50,6 @@ static inline bool frontswap_enabled(void)
 	return false;
 }
 
-static inline bool frontswap_test(struct swap_info_struct *sis, pgoff_t offset)
-{
-	return false;
-}
-
 static inline void frontswap_map_set(struct swap_info_struct *p,
 				     unsigned long *map)
 {
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 42d554da53bbb..f51159f0d75d5 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -179,7 +179,7 @@ void frontswap_init(unsigned type, unsigned long *map)
 		ops->init(type);
 }
 
-bool __frontswap_test(struct swap_info_struct *sis,
+static bool __frontswap_test(struct swap_info_struct *sis,
 				pgoff_t offset)
 {
 	if (sis->frontswap_map)
-- 
2.30.2

