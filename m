Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56BE7B2757
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 23:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1VT1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 17:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjI1VT0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:19:26 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Sep 2023 14:19:23 PDT
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4133B19E
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Sep 2023 14:19:23 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id lyIVqxYRoFUAIlyIVqcqAN; Thu, 28 Sep 2023 23:11:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695935510;
        bh=CT0rFoQj+YDKwuwWbEo3e5SQCHTQDs01F+cu4QFHXgE=;
        h=From:To:Cc:Subject:Date;
        b=GKDTgvqa9RYXrDd7JRIRmjq5ZV7qkctMPq1hXE3q0NsVLQwHqbGamk6UI1d2nPUpt
         wmUHjQPqpiZSvfFThnPHZQ2OsNfff/EifuIlFkkCm4pxAgDynuyUt10RDW0/PDJ/aT
         UPvUPd+uHpExnaTjcnrfd/tYK46sKW2p98W/51Fz1R9mWWGcR56KziyEuF2+VLXSIx
         x2k+9Ab7Qqdyrc34Tu/2AY4DWIj8qCuvaBo7SBAEZBcTRIkJjOanuxFrmrAjQBGHDf
         6F4KAUSeyAOuIB+DMWS8I1GmEtE34dvPw1W+jfFqPlRRlsQO+Mh3i1Z3wEOm/fA+hQ
         aj0DiKIrWPF5A==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 28 Sep 2023 23:11:50 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] radix tree test suite: Fix a memory initialization issue
Date:   Thu, 28 Sep 2023 23:11:45 +0200
Message-Id: <b1f490b450b14dd754a45f91bb1abd622ce8d4f7.1695935486.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If __GFP_ZERO is used, the whole allocated memory should be cleared, not
the first part of it only.

Fixes: cc86e0c2f306 ("radix tree test suite: add support for slab bulk APIs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/testing/radix-tree/linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/linux.c
index d587a558997f..8ab162c48629 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -172,7 +172,7 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t size,
 			if (cachep->ctor)
 				cachep->ctor(p[i]);
 			else if (gfp & __GFP_ZERO)
-				memset(p[i], 0, cachep->size);
+				memset(p[i], 0, cachep->size * size);
 		}
 	}
 
-- 
2.34.1

