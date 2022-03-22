Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7854E494A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 23:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiCVWpn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 18:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiCVWpk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:45:40 -0400
X-Greylist: delayed 1203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 15:44:11 PDT
Received: from 10.mo550.mail-out.ovh.net (10.mo550.mail-out.ovh.net [178.32.96.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898F15DA28
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 15:44:08 -0700 (PDT)
Received: from player794.ha.ovh.net (unknown [10.108.4.253])
        by mo550.mail-out.ovh.net (Postfix) with ESMTP id 8887C23AA1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 22:06:30 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player794.ha.ovh.net (Postfix) with ESMTPSA id E7DF9256E9672;
        Tue, 22 Mar 2022 22:06:24 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005581338c0-c49d-48a1-bf29-e376bff1df54,
                    39C76792797FC4B206737A387439D6B5F87E3063) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Matthew Wilcox <willy@infradead.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] idr: Remove unused ida_simple_{get,remove}
Date:   Tue, 22 Mar 2022 23:06:02 +0100
Message-Id: <20220322220602.985011-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5216857219424093830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudeghedgudehhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeelgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are no longer used anywhere, remove them; update the
nvmem-prodiver.h to refer to ida_alloc() which is what is used now
(see drivers/nvmem/core.c).

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 include/linux/idr.h            | 8 --------
 include/linux/nvmem-provider.h | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index a0dce14090a9..273b2158a428 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -314,14 +314,6 @@ static inline void ida_init(struct ida *ida)
 	xa_init_flags(&ida->xa, IDA_INIT_FLAGS);
 }
 
-/*
- * ida_simple_get() and ida_simple_remove() are deprecated. Use
- * ida_alloc() and ida_free() instead respectively.
- */
-#define ida_simple_get(ida, start, end, gfp)	\
-			ida_alloc_range(ida, start, (end) - 1, gfp)
-#define ida_simple_remove(ida, id)	ida_free(ida, id)
-
 static inline bool ida_is_empty(const struct ida *ida)
 {
 	return xa_empty(&ida->xa);
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index c9a3ac9efeaa..e957cdc56619 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -75,7 +75,7 @@ struct nvmem_keepout {
  *
  * Note: A default "nvmem<id>" name will be assigned to the device if
  * no name is specified in its configuration. In such case "<id>" is
- * generated with ida_simple_get() and provided id field is ignored.
+ * generated with ida_alloc() and provided id field is ignored.
  *
  * Note: Specifying name and setting id to -1 implies a unique device
  * whose name is provided as-is (kept unaltered).

base-commit: 5191290407668028179f2544a11ae9b57f0bcf07
-- 
2.30.2

