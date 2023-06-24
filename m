Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D388B73CA75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jun 2023 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjFXKbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jun 2023 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjFXKbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jun 2023 06:31:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE710F5;
        Sat, 24 Jun 2023 03:31:05 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1687602663;
        bh=hzizDE0ofd3T5vSSD4XlksVV4PJv55T5z7/2M1lRIzg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=s736ziZIOYjSRE+ah/C5l268BQPA45kdL1qrax+pxBfF+O7My/Q6C+a14kXoky8vd
         YD0T5fapsmdqU7/11Y2mxLLX8GEhHfH0afuNV9akfrNn7cs69o9wmwfopXqDBOuSmm
         5N0JpQv4GcnWJyxfOmMl/njB2v8Q++EXPaz9O8XA=
Date:   Sat, 24 Jun 2023 12:30:46 +0200
Subject: [PATCH 1/2] selftests/nolibc: drop test chmod_net
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230624-proc-net-setattr-v1-1-73176812adee@weissschuh.net>
References: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
In-Reply-To: <20230624-proc-net-setattr-v1-0-73176812adee@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zhangjin Wu <falcon@tinylab.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687602663; l=1385;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hzizDE0ofd3T5vSSD4XlksVV4PJv55T5z7/2M1lRIzg=;
 b=DF/vX9Kb4oDrP3HJyxHWbLrQCz+jWOTPWYigChKBgenfVT0teCpk23ZpjtVERScZTkb2ojuco
 R0JddflQm3cANkMb6S0BW1K7oDY/9Vp863E3rP4pbXqXGkRt2TgfmL1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The test relies on /proc/$PID/net to allow chmod() operations.
It is the only file or directory in /proc/$PID/ to allow this and a bug.
That bug will be fixed in the next patch in the series and therefore
the test would start failing.

Link: https://lore.kernel.org/lkml/d0d111ef-edae-4760-83fb-36db84278da1@t-8ch.de/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 21bacc928bf7..7e649814a241 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -512,7 +512,6 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;

-- 
2.41.0

