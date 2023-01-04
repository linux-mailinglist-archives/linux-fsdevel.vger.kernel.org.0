Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC965CDA9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 08:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjADHgr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 02:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjADHgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 02:36:46 -0500
Received: from mailgw.kylinos.cn (unknown [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B0316585;
        Tue,  3 Jan 2023 23:36:40 -0800 (PST)
X-UUID: d4dc11e734dc43b28f8560359914f1f3-20230104
X-CPASD-INFO: e2afb6bb2ecc4f77a279924541827dc2@roKbho9okJJehaWvg6mCcYFjZ2lpXlS
        EdmtYYmWUj1KVhH5xTV5nX1V9gnNXZF5dXFV3dnBQYmBhXVJ3i3-XblBgXoZgUZB3tHSbhpJkkg==
X-CLOUD-ID: e2afb6bb2ecc4f77a279924541827dc2
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:184.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:0.0,CUTS:94.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5.
        0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-5
        ,AUF:4,DUF:11592,ACD:192,DCD:192,SL:0,EISP:0,AG:0,CFC:0.513,CFSR:0.065,UAT:0,
        RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:0
        ,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: d4dc11e734dc43b28f8560359914f1f3-20230104
X-CPASD-BLOCK: 1000
X-CPASD-STAGE: 1
X-UUID: d4dc11e734dc43b28f8560359914f1f3-20230104
X-User: xurui@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by mailgw
        (envelope-from <xurui@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 244177007; Wed, 04 Jan 2023 15:36:39 +0800
From:   xurui <xurui@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     trivial@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, xurui <xurui@kylinos.cn>
Subject: [PATCH] coredump: Fix a compilation issue with CONFIG_ELF_CORE=n
Date:   Wed,  4 Jan 2023 15:36:26 +0800
Message-Id: <20230104073626.1093400-1-xurui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A compilation issue occurred when CONFIG_ELF_CORE is not set:
fs/coredump.c:841:12: error: ‘dump_emit_page’ defined but not used [-Werror=unused-function]

Signed-off-by: xurui <xurui@kylinos.cn>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index de78bde2991b..95390a73b912 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -838,6 +838,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -870,6 +871,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.25.1

