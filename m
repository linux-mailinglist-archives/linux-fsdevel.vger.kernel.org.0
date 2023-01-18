Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FBE671921
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jan 2023 11:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjARKkQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 05:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjARKjO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:39:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88874F85B;
        Wed, 18 Jan 2023 01:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=MhCSeZxb0+ckteL2o3EcN0B0EMYZcaQYxCAND8YfTVw=; b=zb1P9ij/tKigVouQ1O/C4uCAS7
        +JypLZQNpDNL8SKR+sx/aWG6SqmtWucbKq/npM9f01Nx4vipYaGkmRmfWPM8//WBMOWyul+joXZdf
        kI5DelXAG5u3Mial8ZsWDnwcWoQEls3QmRsMZpx+Ma9ZXSGvSOElPAlQ+CVHpa0i0ip+rT5GjIbdg
        S5G36phYR1i2oNyuWdEu+/jo4jmYoCDTehy+LLF2qrMRA/2CXC2tH9oCz02ukaqRRI8A/Yxuj3r11
        ZC3nBMs5rlV1N/an3gFPLb/4i4RUC1kPq64ESJTixD6mQn5Lrv1DKGai8eyUnSX8o2BGpovyOd4r7
        +F3UHI8g==;
Received: from 213-147-167-250.nat.highway.webapn.at ([213.147.167.250] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pI4yo-0009vw-M1; Wed, 18 Jan 2023 09:43:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-afs@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nilfs@vger.kernel.org
Subject: [PATCH 1/9] mm: don't look at xarray value entries in split_huge_pages_in_file
Date:   Wed, 18 Jan 2023 10:43:21 +0100
Message-Id: <20230118094329.9553-2-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118094329.9553-1-hch@lst.de>
References: <20230118094329.9553-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

split_huge_pages_in_file never wants to do anything with the special
value enties.  Switch to using filemap_get_folio to not even see them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/huge_memory.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1d6977dc6b31ba..a2830019aaa017 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3100,11 +3100,10 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
 	mapping = candidate->f_mapping;
 
 	for (index = off_start; index < off_end; index += nr_pages) {
-		struct folio *folio = __filemap_get_folio(mapping, index,
-						FGP_ENTRY, 0);
+		struct folio *folio = filemap_get_folio(mapping, index);
 
 		nr_pages = 1;
-		if (xa_is_value(folio) || !folio)
+		if (!folio)
 			continue;
 
 		if (!folio_test_large(folio))
-- 
2.39.0

