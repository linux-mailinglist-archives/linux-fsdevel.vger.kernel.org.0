Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E5B7A265C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbjIOSnh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237089AbjIOSnD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:43:03 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A135BF;
        Fri, 15 Sep 2023 11:40:01 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RnNJW0zkCz9sZG;
        Fri, 15 Sep 2023 20:39:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlByD57EXAWo3wBYWh+1jomz9iI/v3Qz7x+/AUImBzs=;
        b=nuY8POIALXl0in4GfMc25TJC8coBeQG43+Ouex9LRzUcKwK8I5c7EEHIH+My1vP7A91IWR
        JpL8fg2KOkRRAcvKGXz+vA5/mbGmclH2WEI7vYKQZvUUY4PW+gydMVf/nU+wSdB/tEf3iD
        7fIcfZwKxubSL8Be38uKFiNVIgOf5DyDHV87W0Y8X7Qk+tOJCtgkLZ61qi2KNIDwl4i7WX
        csxEGgzn3f5nPGSOcT7rO7zljDx1HiVZ9pDcU5CfZ4XyxCcK3iXZVxeySqazerokuxygMm
        51rE3zIIvycA/2oxNMkX9/yceDwSbawy5u9l3xIe2eEB7PyD2gY58zVvZs2hxA==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 11/23] filemap: align the index to mapping_min_order in do_[a]sync_mmap_readahead
Date:   Fri, 15 Sep 2023 20:38:36 +0200
Message-Id: <20230915183848.1018717-12-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Align the index to the mapping_min_order number of pages in
do_[a]sync_mmap_readahead().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 8a4bbddcf575..3853df90f9cf 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3164,7 +3164,10 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
 	struct address_space *mapping = file->f_mapping;
-	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
+	int order = mapping_min_folio_order(mapping);
+	unsigned int nrpages = 1U << order;
+	pgoff_t index = round_down(vmf->pgoff, nrpages);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
 	struct file *fpin = NULL;
 	unsigned long vm_flags = vmf->vma->vm_flags;
 	unsigned int mmap_miss;
@@ -3216,10 +3219,11 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 	 */
 	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
+	ra->start = round_down(ra->start, nrpages);
 	ra->size = ra->ra_pages;
 	ra->async_size = ra->ra_pages / 4;
 	ractl._index = ra->start;
-	page_cache_ra_order(&ractl, ra, 0);
+	page_cache_ra_order(&ractl, ra, order);
 	return fpin;
 }
 
@@ -3233,7 +3237,10 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
 {
 	struct file *file = vmf->vma->vm_file;
 	struct file_ra_state *ra = &file->f_ra;
-	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, vmf->pgoff);
+	int order = mapping_min_folio_order(file->f_mapping);
+	unsigned int nrpages = 1U << order;
+	pgoff_t index = round_down(vmf->pgoff, nrpages);
+	DEFINE_READAHEAD(ractl, file, ra, file->f_mapping, index);
 	struct file *fpin = NULL;
 	unsigned int mmap_miss;
 
-- 
2.40.1

