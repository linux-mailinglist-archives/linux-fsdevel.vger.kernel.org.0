Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CA17A265A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236748AbjIOSni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbjIOSnU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:43:20 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756023A9A;
        Fri, 15 Sep 2023 11:40:06 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RnNJj5YhYz9spC;
        Fri, 15 Sep 2023 20:39:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxVtlX4JC4EQtNnH6RIJ+6iaeftg/wvFMQDW4McP7fo=;
        b=fhFmL/xOdq9mWLRpb+jiRZQGXQH+v9Jn5su2cxMbr34SSR2VWXkAgjIRsLKaW4gQu44flC
        ac99JAjExWoh/6PTq9AGdXvJTewS4mWWjcU8AwxzTqTqhvOnuPZcZ5HgczOylODoRurLAS
        dBOKCG5FBvoZxsnu9YkS7LcQp0YemfRvv5zpGUolR7hVqtYLEuI+LrAh7OmYZQmhFgbnSd
        cNe8R2/Kte9KfMu0Vz5bUpVjB4o6PFg6ddvgFTssdCPEm9woE0ZYBLMWscLd5hZFJV0luH
        kv6+9jNXZ5NWVNUcbSomGZ/kPoUmVQTyJIYr4I4QDmrpyENc7FzrWcm3inttmA==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 15/23] readahead: align with mapping_min_order in force_page_cache_ra()
Date:   Fri, 15 Sep 2023 20:38:40 +0200
Message-Id: <20230915183848.1018717-16-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJj5YhYz9spC
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Pankaj Raghav <p.raghav@samsung.com>

Align the index to mapping_min_order in force_page_cache_ra(). This will
ensure that the folios allocated for readahead that are added to the
page cache are aligned to mapping_min_order.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/readahead.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/readahead.c b/mm/readahead.c
index 2a9e9020b7cf..838dd9ca8dad 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -318,6 +318,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
 	unsigned long max_pages, index;
+	unsigned int folio_order = mapping_min_folio_order(mapping);
+	unsigned int nr_of_pages = (1 << folio_order);
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -327,6 +329,13 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * be up to the optimal hardware IO size
 	 */
 	index = readahead_index(ractl);
+	if (folio_order && (index & (nr_of_pages - 1))) {
+		unsigned long old_index = index;
+
+		index = round_down(index, nr_of_pages);
+		nr_to_read += (old_index - index);
+	}
+
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
@@ -335,6 +344,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
 		ractl->_index = index;
+		VM_BUG_ON(index & (nr_of_pages - 1));
 		do_page_cache_ra(ractl, this_chunk, 0);
 
 		index += this_chunk;
-- 
2.40.1

