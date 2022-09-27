Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D6F5EC408
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiI0NQg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiI0NQF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:16:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E42B14D13;
        Tue, 27 Sep 2022 06:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9806198E;
        Tue, 27 Sep 2022 13:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E6BC433D7;
        Tue, 27 Sep 2022 13:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664284559;
        bh=n6vTZCyTn3fjGmfDlGpFKj4XD812C86b9jJJrat0UaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fww58ksY0/HNpSio73JGVSzwP3DMpjMUuGJzg+3i+ovIXqc/sHUYV55FfZoLtTImI
         eLh91fDkn6amEs5or4Edq2yrmBxoOLeVBspE0qYXnH0MQop0ahsAA2+FeHYXZwcu92
         ft8PN9wbJLkA6aL7gaxXkDeE/YM1Jkx8/zn3j2kAM4ksmFdu07XFl/wO8ch9n0rKUZ
         VXbWwuxtfWacOMNan3IZiOqpzFkZD+C4DjUq0d65qvA/eT/H6AhB/PUwfqq9B8/Ks4
         qP86MnyGbLfZy8xhDpYo/S45ZoFonyArLmsESISwrqbBfqUh1VEet3a0fRLSZgtTIP
         qf1PKrGMfpvAg==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v10 03/27] kallsyms: add static relationship between `KSYM_NAME_LEN{,_BUFFER}`
Date:   Tue, 27 Sep 2022 15:14:34 +0200
Message-Id: <20220927131518.30000-4-ojeda@kernel.org>
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

This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
gets updated when `KSYM_NAME_LEN` changes.

The relationship used is one that keeps the new size (512+1)
close to the original buffer size (500).

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/kallsyms.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 25e2fe5fbcd4..411ff5058b51 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -32,8 +32,18 @@
 
 #define KSYM_NAME_LEN		128
 
-/* A substantially bigger size than the current maximum. */
-#define KSYM_NAME_LEN_BUFFER	499
+/*
+ * A substantially bigger size than the current maximum.
+ *
+ * It cannot be defined as an expression because it gets stringified
+ * for the fscanf() format string. Therefore, a _Static_assert() is
+ * used instead to maintain the relationship with KSYM_NAME_LEN.
+ */
+#define KSYM_NAME_LEN_BUFFER	512
+_Static_assert(
+	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
+	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
+);
 
 struct sym_entry {
 	unsigned long long addr;
-- 
2.37.3

