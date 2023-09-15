Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F577A26F3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 21:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbjIOTJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236872AbjIOSlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:41:13 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC043AB3;
        Fri, 15 Sep 2023 11:40:17 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RnNJY3FJzz9scf;
        Fri, 15 Sep 2023 20:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JnevztC5Xa5eXhjQG5gs4g0W7d3IJ4EIEPKbSlyaPoo=;
        b=k4Yc0OosuSwPR3GTilJO7yik1UFI1e6xzGKpUTNNry/gNO9lqC1Hn++uqllS/hFhBaUp6j
        6BBBUZpa/0JEi+Ai24ps3Zh96w+C5hA/SBom+sueFZylFoXiFJ3xBsGSVR7Kx39XhlqT2H
        YOlLsSed4aroEit7x8wYZ8RvZOJZ+pga6uAq12op8NlVwJZFuRyGjiIOX/IasnXvy7of8E
        Bw4C9te4wO/7VvuvE2h4jtQPMc4DTeaiNz65EMObnRF4FhfyLBhafL3EofkDiD+TjE1xXb
        nF23dD6KEojM6yEaCJImMCaCLpilwthMJTX0vmP0FilI3KujhBBnBd4Doz0C6w==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 12/23] filemap: align index to mapping_min_order in filemap_fault()
Date:   Fri, 15 Sep 2023 20:38:37 +0200
Message-Id: <20230915183848.1018717-13-kernel@pankajraghav.com>
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

From: Pankaj Raghav <p.raghav@samsung.com>

ALign the indices to mapping_min_order number of pages in
filemap_fault().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3853df90f9cf..f97099de80b3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3288,13 +3288,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file *fpin = NULL;
 	struct address_space *mapping = file->f_mapping;
+	unsigned int min_order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1UL << min_order;
 	struct inode *inode = mapping->host;
-	pgoff_t max_idx, index = vmf->pgoff;
+	pgoff_t max_idx, index = round_down(vmf->pgoff, nrpages);
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	bool mapping_locked = false;
 
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	max_idx = round_up(max_idx, nrpages);
+
 	if (unlikely(index >= max_idx))
 		return VM_FAULT_SIGBUS;
 
@@ -3386,13 +3390,17 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 	 * We must recheck i_size under page lock.
 	 */
 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
+	max_idx = round_up(max_idx, nrpages);
+
 	if (unlikely(index >= max_idx)) {
 		folio_unlock(folio);
 		folio_put(folio);
 		return VM_FAULT_SIGBUS;
 	}
 
-	vmf->page = folio_file_page(folio, index);
+	VM_BUG_ON_FOLIO(folio_order(folio) < min_order, folio);
+
+	vmf->page = folio_file_page(folio, vmf->pgoff);
 	return ret | VM_FAULT_LOCKED;
 
 page_not_uptodate:
-- 
2.40.1

