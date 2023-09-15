Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E06A7A261C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbjIOSk1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbjIOSj7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:39:59 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4FF49DA;
        Fri, 15 Sep 2023 11:39:11 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RnNJD57K5z9sW2;
        Fri, 15 Sep 2023 20:39:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2grCxcqK8FKtyCgTOlZ0MTRPcri5sYlchrmngCOgl8U=;
        b=j/WoRm7kqZ2NoZ5OjDxKOQdGsBPUtApoPN7xyVBhTkrQsnhPqztuwiVWc2+UMXFhXmucnn
        yV+5CVecVrEDZ/RgmtLrE4lsA0aMvZFUc6TXMrY/E0TUv11fr40etSwDNW4JstoTE3PGdc
        wzKsqHxrr54nqKGxraGFN5jT4guAQfbru8I95DPokA3ewiwi5qz50a3aIhjBlV9pFFIWnV
        /3j3RMZ/xhGVgtsWXbHphYwPMEotMMqn+UED9KX4/9IgzyhYXmjjJeptgYB1o9oG1BDw5K
        SfyVH8Havcutw80kiMU8+RDv5/rYTA2MFLmQBkfN08ZgPi5O8qpzk1LIGJ1oUw==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 06/23] mm: call xas_set_order() in replace_page_cache_folio()
Date:   Fri, 15 Sep 2023 20:38:31 +0200
Message-Id: <20230915183848.1018717-7-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Call xas_set_order() in replace_page_cache_folio() for non hugetlb
pages.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 4dee24b5b61c..33de71bfa953 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -815,12 +815,14 @@ EXPORT_SYMBOL(file_write_and_wait_range);
 void replace_page_cache_folio(struct folio *old, struct folio *new)
 {
 	struct address_space *mapping = old->mapping;
+	unsigned int min_order = mapping_min_folio_order(mapping);
 	void (*free_folio)(struct folio *) = mapping->a_ops->free_folio;
 	pgoff_t offset = old->index;
 	XA_STATE(xas, &mapping->i_pages, offset);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
+	VM_BUG_ON_FOLIO(folio_order(new) != folio_order(old), new);
 	VM_BUG_ON_FOLIO(new->mapping, new);
 
 	folio_get(new);
@@ -829,6 +831,11 @@ void replace_page_cache_folio(struct folio *old, struct folio *new)
 
 	mem_cgroup_migrate(old, new);
 
+	if (!folio_test_hugetlb(new)) {
+		VM_BUG_ON_FOLIO(folio_order(new) < min_order, new);
+		xas_set_order(&xas, offset, folio_order(new));
+	}
+
 	xas_lock_irq(&xas);
 	xas_store(&xas, new);
 
-- 
2.40.1

