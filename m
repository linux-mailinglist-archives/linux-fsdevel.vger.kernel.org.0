Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB0F63AA49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 15:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiK1OAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 09:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiK1OAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:00:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D71B86B;
        Mon, 28 Nov 2022 06:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AE6BB80D9E;
        Mon, 28 Nov 2022 14:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91F3C433C1;
        Mon, 28 Nov 2022 14:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669644048;
        bh=0ELPsvk3FLg1BIlCM+py6A5OLl2DQuOQYYfbE5wR6Ow=;
        h=From:To:Cc:Subject:Date:From;
        b=Oeuvle2NspMTbgCO8EbQi8zXPdGNsIjszEUe1o3MJWH/k+jXmQCkvSRGSMJ2piuT+
         yNcvtrL1FRxkscSZvYzwxmKjIkVejk2WsSTGoVD0ygKj41lGgo3r4OyDU/wre+IhiP
         ERDpgjSEJwyFLR2R9XG3bRnao/aGtQR3cHolha5xnLnokcHIgSqJlkVUUFsn9LtsnD
         VN8kLPX6aaAgzIpaUmSfaEEl5BsKuo7pCiwLGvXAxdG2ZGfRc7CEoBUKsyMrUGK2sB
         eYvX8RkZQMD5vGJmkv+1wIRESIAqj4DW5W0W6mYfINXfeYuKuAbkJHXbrfX31ViNff
         qRswGR/eJGCJg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] coredump: fix compile warning when ELF_CORE=n while COREDUMP=y
Date:   Mon, 28 Nov 2022 21:50:56 +0800
Message-Id: <20221128135056.325-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fix below build warning when ELF_CORE=n while COREDUMP=y:

fs/coredump.c:834:12: warning: ‘dump_emit_page’ defined but not used [-Wunused-function]
  834 | static int dump_emit_page(struct coredump_params *cprm, struct
      page *page)
      |            ^~~~~~~~~~~~~~

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 fs/coredump.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 7bad7785e8e6..8663042ebe9c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -831,6 +831,7 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 	}
 }
 
+#ifdef CONFIG_ELF_CORE
 static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 {
 	struct bio_vec bvec = {
@@ -863,6 +864,7 @@ static int dump_emit_page(struct coredump_params *cprm, struct page *page)
 
 	return 1;
 }
+#endif
 
 int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 {
-- 
2.37.2

