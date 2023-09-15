Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE67A266B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbjIOSoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbjIOSnh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:43:37 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA948449E;
        Fri, 15 Sep 2023 11:40:45 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RnNJr2x9Tz9sbr;
        Fri, 15 Sep 2023 20:39:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MKZNT2C20PsiAht17s5oJnb138+SmsAPSOiRhddgUA=;
        b=OSDk9FFxIdRoXpbbJK7NtCBBEbBqbJXSbQ07rvOBw++aALFk+mh/xxdarUdNR4FVlQRF17
        67UxVmkLS2OLxkjk+Ll9RummAEi7HciYPbO9Z2cBpMGtt24csMF9mj/Hk7zipaGkJ6uh32
        Ct8c4gPXLiSnOw01drlPlIaLlnRBVRgWowE8ZQbP6rTJbkllrV9wlYlk84VeHiSctXNOjP
        abj4O3zIc0YGlB/1ZOy/IwN/jtsEoCNZu2tkZ/e4qSfNNxLpodXBEK3pvwM6c9CuxXqvzD
        UdDGI/JtrIJGBBxolWDhZOsfoPzAosRAcphz0UPvnj346nrxjmRCHSmp2JtQ2w==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 17/23] readahead: set the minimum ra size in get_(init|next)_ra
Date:   Fri, 15 Sep 2023 20:38:42 +0200
Message-Id: <20230915183848.1018717-18-kernel@pankajraghav.com>
In-Reply-To: <20230915183848.1018717-1-kernel@pankajraghav.com>
References: <20230915183848.1018717-1-kernel@pankajraghav.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4RnNJr2x9Tz9sbr
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

Make sure the minimum ra size is based on mapping_min_order in
get_init_ra() and get_next_ra(). If request ra size is greater than
mapping_min_order of pages, align it to mapping_min_order of pages.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 mm/readahead.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index fb5ff180c39e..7c2660815a01 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -357,9 +357,17 @@ void force_page_cache_ra(struct readahead_control *ractl,
  * for small size, x 4 for medium, and x 2 for large
  * for 128k (32 page) max ra
  * 1-2 page = 16k, 3-4 page 32k, 5-8 page = 64k, > 8 page = 128k initial
+ *
+ * For higher order address space requirements we ensure no initial reads
+ * are ever less than the min number of pages required.
+ *
+ * We *always* cap the max io size allowed by the device.
  */
-static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
+static unsigned long get_init_ra_size(unsigned long size,
+				      unsigned int min_order,
+				      unsigned long max)
 {
+	unsigned int min_nrpages = 1UL << min_order;
 	unsigned long newsize = roundup_pow_of_two(size);
 
 	if (newsize <= max / 32)
@@ -369,6 +377,15 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
 	else
 		newsize = max;
 
+	if (newsize < min_nrpages) {
+		if (min_nrpages <= max)
+			newsize = min_nrpages;
+		else
+			newsize = round_up(max, min_nrpages);
+	}
+
+	VM_BUG_ON(newsize & (min_nrpages - 1));
+
 	return newsize;
 }
 
@@ -377,14 +394,19 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
  *  return it as the new window size.
  */
 static unsigned long get_next_ra_size(struct file_ra_state *ra,
+				      unsigned int min_order,
 				      unsigned long max)
 {
-	unsigned long cur = ra->size;
+	unsigned int min_nrpages = 1UL << min_order;
+	unsigned long cur = max(ra->size, min_nrpages);
+
+	cur = round_down(cur, min_nrpages);
 
 	if (cur < max / 16)
 		return 4 * cur;
 	if (cur <= max / 2)
 		return 2 * cur;
+
 	return max;
 }
 
-- 
2.40.1

