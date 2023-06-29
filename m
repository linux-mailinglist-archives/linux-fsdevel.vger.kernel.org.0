Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC9D742A90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbjF2QXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjF2QXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:23:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB78ACF;
        Thu, 29 Jun 2023 09:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B56061574;
        Thu, 29 Jun 2023 16:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17D3C433CA;
        Thu, 29 Jun 2023 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688055794;
        bh=XKHVV9536ZEIq0lSPWe7Ma20H9zvrB69ScTYKRNgSug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6kZoAurVeEfkpLZfC9kxcAJWpzl/UUi+VNi5k1i3Dndk9Pb9ABQQu6Vuhx4/V8Ym
         eYeawEma6ZTO9P034Brnv+y+iANOqT7owHEUXd79yDDf0EE8zQV1kg/E+13nQfIehy
         bi2qq9G/sfCXcpXVSG8tsSx3dd5zLBJmJSYNixYZ0JRhsNYKQ1jnxQoBwfzM4lNxHs
         XLxAFCeETZrWAqGnxg/3yTeN0voW/UL/EQ+m1SxkxBivGz2Q16XKHs34qfHrcfA1nh
         qjGGdKBBR6AiJjCflcdzAfy8xLzozEfx/hq89IOm3E6G8GxRGM7Qjgvb2HRl/t4C0H
         XezKnlpSIying==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 1/2] selftests/openat2: Run-time check for -fsanitize=undefined
Date:   Thu, 29 Jun 2023 18:22:59 +0200
Message-Id: <20230629162301.1234157-2-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629162301.1234157-1-bjorn@kernel.org>
References: <20230629162301.1234157-1-bjorn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Björn Töpel <bjorn@rivosinc.com>

Some architectures, e.g. riscv, does not have support for the GCC
option '-fsanitize=undefined'.

Check for '-fsanitize=undefined' support, and only add it to CFLAGS if
supported.

Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
---
 tools/testing/selftests/openat2/Makefile | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
index 843ba56d8e49..f13ad02a18ea 100644
--- a/tools/testing/selftests/openat2/Makefile
+++ b/tools/testing/selftests/openat2/Makefile
@@ -1,6 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
+# We need this for the "try-run" macro.
+include ../../../build/Build.include
+
+CFLAGS += -Wall -O2 -g -fsanitize=address
+CFLAGS += $(call try-run, \
+	echo 'int main() {}' | $(CC) -fsanitize=undefined -x c - -o /dev/null, \
+	-fsanitize=undefined,)
+
 TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
 
 include ../lib.mk
-- 
2.39.2

