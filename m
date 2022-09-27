Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78D5EC3FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiI0NQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiI0NP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:15:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2AC13F41;
        Tue, 27 Sep 2022 06:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B0B1B81BBD;
        Tue, 27 Sep 2022 13:15:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBA48C433B5;
        Tue, 27 Sep 2022 13:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284553;
        bh=lLVeSTRx1wtOeyOrw5Ac0zU5OsqN3eIH/yKi5nlw5oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JfobuIomzOqA7iIuZRwMLdEfiteOj4BxAZJ0aMBI89dEj2rpxMzHYgkUfekjz5oEk
         GDWO5JXvIzdJOGZ7jQRBhtL/d1Jb8wW17CVZXx3O5IDl1SF6q725XAJL7U66hx0U6h
         gFt6S6/6GzvhQmX9t0Vzy1BNdAuD3UQhmefACmtrPuHxVaoM38xhDpb2bT+tEJ7VxP
         QcY81qnFcwCssmazYJJBTcy/OPRPQiXkzZZ559uWuBQFy2pvcD9tjaGGcefBPADY/9
         mpRmWo720SVO1W7NMc1Ym2w/GG00/y3PIPdNq62ebHmpkmcuDwmCHIs9FA2RtPUdGC
         qnekh2e+bbSAQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v10 01/27] kallsyms: use `ARRAY_SIZE` instead of hardcoded size
Date:   Tue, 27 Sep 2022 15:14:32 +0200
Message-Id: <20220927131518.30000-2-ojeda@kernel.org>
In-Reply-To: <20220927131518.30000-1-ojeda@kernel.org>
References: <20220927131518.30000-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

This removes one place where the `500` constant is hardcoded.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f18e6dfc68c5..8551513f9311 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
 
 	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
 	if (rc != 3) {
-		if (rc != EOF && fgets(name, 500, in) == NULL)
+		if (rc != EOF && fgets(name, ARRAY_SIZE(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
 		return NULL;
 	}
-- 
2.37.3

