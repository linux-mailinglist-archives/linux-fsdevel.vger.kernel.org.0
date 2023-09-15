Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5177A2693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236537AbjIOSuJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 14:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbjIOSti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:49:38 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1EF3A8C;
        Fri, 15 Sep 2023 11:47:53 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RnNJQ0N8tz9sZ5;
        Fri, 15 Sep 2023 20:39:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
        s=MBO0001; t=1694803158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3APo23DtYMF4HiSm9np03AfVKr1TDxQPEqBIBU7EQLQ=;
        b=Zj3MnwSGDMAwBq1bun9wQMD03apsZ8TkPzzZY0G+xVuRFHlA8jTRS9j0z03rhiuPfuRL6p
        sz/dnlC30Ddq95aZ8BgLQPzAOrlr7XRSaj2o2j1LWlJXmR+xzOB4D1lfcoHYkXXJNM7T+e
        o1eXt+BU1FmCmk3Anh7cikxoynzKwfGc8hH7UoHccj4k2DZXzQFOkU0phBCRGBrFG42T8t
        rlNeZG/822yhWUKUgM45Id9Xd6OxjN5FfHbNRbbHF90yh5ppnDsJruqnEsC/WrQJlyPF8N
        aYOfhwR5VntP4ab9n0nA+F2XRQXfgH4LmqvrkX9lLSLR7mCEJyhlXYJSK5HJdQ==
From:   Pankaj Raghav <kernel@pankajraghav.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     p.raghav@samsung.com, david@fromorbit.com, da.gomez@samsung.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, djwong@kernel.org, linux-mm@kvack.org,
        chandan.babu@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com
Subject: [RFC 09/23] filemap: use mapping_min_order while allocating folios
Date:   Fri, 15 Sep 2023 20:38:34 +0200
Message-Id: <20230915183848.1018717-10-kernel@pankajraghav.com>
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

Allocate al teast mapping_min_order when creating new folio for the
filemap in filemap_create_folio() and do_read_cache_folio().

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 mm/filemap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 21e1341526ab..e4d46f79e95d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2502,7 +2502,8 @@ static int filemap_create_folio(struct file *file,
 	struct folio *folio;
 	int error;
 
-	folio = filemap_alloc_folio(mapping_gfp_mask(mapping), 0);
+	folio = filemap_alloc_folio(mapping_gfp_mask(mapping),
+				    mapping_min_folio_order(mapping));
 	if (!folio)
 		return -ENOMEM;
 
@@ -3696,7 +3697,8 @@ static struct folio *do_read_cache_folio(struct address_space *mapping,
 repeat:
 	folio = filemap_get_folio(mapping, index);
 	if (IS_ERR(folio)) {
-		folio = filemap_alloc_folio(gfp, 0);
+		folio = filemap_alloc_folio(gfp,
+					    mapping_min_folio_order(mapping));
 		if (!folio)
 			return ERR_PTR(-ENOMEM);
 		err = filemap_add_folio(mapping, folio, index, gfp);
-- 
2.40.1

