Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3158AD33
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 17:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbiHEPnL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbiHEPnF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 11:43:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0E32A721;
        Fri,  5 Aug 2022 08:43:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87499B82757;
        Fri,  5 Aug 2022 15:43:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CC2C433B5;
        Fri,  5 Aug 2022 15:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659714181;
        bh=J1kZYuBmy2p9V5rJr5cWhtju3zoN163Uf1mW1Uq9geI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e8h/Dnz3+T9yxjRHLCJRam5w2Fn4wq6T0R23bnnYeBGP4qGZu+Z+xLKLfmFtSNxS0
         EqV+SBlXQZ7p0gPmkZ0+iTKiTpumo5tOCHKqixSCqOAErJcij+0pgwoFa6VzLASOgH
         jozFX2RvYEPtB757t8FYgVtTOEfjMaj/eDmZYlLVmXxhZeXkLufHFpXS2a5POoYnPN
         es8jYALEHHX/fMXeHLQ1pqCyx+RTTkZAtqxbVO5XJdqdvq8Pfel4jHeP7vHGUTvi5W
         NN3ab+Ypcmmb+sG7I++Hgp1Eysnr9JUTECUj9A5Wb5C/3f/DLRlkoQIestZPdfIdY1
         SORg/L8hubOKQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v9 03/27] kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
Date:   Fri,  5 Aug 2022 17:41:48 +0200
Message-Id: <20220805154231.31257-4-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-1-ojeda@kernel.org>
References: <20220805154231.31257-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
gets updated when `KSYM_NAME_LEN` changes.

The relationship used is one that keeps the new size (512+1)
close to the original buffer size (500).

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f3c5a2623f71..f543b1c4f99f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -33,7 +33,11 @@
 #define KSYM_NAME_LEN		128
 
 /* A substantially bigger size than the current maximum. */
-#define KSYM_NAME_LEN_BUFFER	499
+#define KSYM_NAME_LEN_BUFFER	512
+_Static_assert(
+	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
+	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
+);
 
 struct sym_entry {
 	unsigned long long addr;
-- 
2.37.1

