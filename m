Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3CD5EC402
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbiI0NQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbiI0NQC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:16:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F7B1408E;
        Tue, 27 Sep 2022 06:15:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A757B61977;
        Tue, 27 Sep 2022 13:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD417C433C1;
        Tue, 27 Sep 2022 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284557;
        bh=vAAEpjl7gdo2NZ1wWJKQpSd6KTl+oelIC5q3HFgBipw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YN3VOrp1+OULQhIhLpElyhPgoYjbxY+JsYn/DwC7xRRiaQ4i3YhT+r59ayKuKLEHi
         dHMKv4eplFYHd5tzdRzs2+puUwzqwTU+8ySK8JB9/4933T87DJPRNh2N003h52QaFV
         0bD9JEaMivZZSfwnUgqru8/AS8mN9ol4EeLZ4YGasXz7+hwapF4KZpZiYN00+9071j
         Oungei7XjHc7GiZessEoymIRa/1bEI/Yps2cI9lixJHpEEO2nkL+vZSSzJyMb/eQ1+
         hcYHlcYVytbFMhQ63di0mlWSUSyun3+9pFYlhaWyf6ZB9TkA1ghykZuDSn1WI8cKyt
         HWUPPGnt9r1xQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v10 02/27] kallsyms: avoid hardcoding buffer size
Date:   Tue, 27 Sep 2022 15:14:33 +0200
Message-Id: <20220927131518.30000-3-ojeda@kernel.org>
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

This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
hardcoded size of the input buffer.

It will also make it easier to update the size in a single place
in a later patch.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 8551513f9311..25e2fe5fbcd4 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -27,8 +27,14 @@
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
 
+#define _stringify_1(x)	#x
+#define _stringify(x)	_stringify_1(x)
+
 #define KSYM_NAME_LEN		128
 
+/* A substantially bigger size than the current maximum. */
+#define KSYM_NAME_LEN_BUFFER	499
+
 struct sym_entry {
 	unsigned long long addr;
 	unsigned int len;
@@ -198,13 +204,13 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
 
 static struct sym_entry *read_symbol(FILE *in)
 {
-	char name[500], type;
+	char name[KSYM_NAME_LEN_BUFFER+1], type;
 	unsigned long long addr;
 	unsigned int len;
 	struct sym_entry *sym;
 	int rc;
 
-	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
+	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
 	if (rc != 3) {
 		if (rc != EOF && fgets(name, ARRAY_SIZE(name), in) == NULL)
 			fprintf(stderr, "Read error or end of file.\n");
-- 
2.37.3

