Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE63742A8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbjF2QXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 12:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjF2QXP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F3B1FC6;
        Thu, 29 Jun 2023 09:23:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7DD861593;
        Thu, 29 Jun 2023 16:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4D1C433C9;
        Thu, 29 Jun 2023 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688055792;
        bh=ovjigv8qptlynrOEsJvCtRFFDOTknNKzUCTNiWi4Fhg=;
        h=From:To:Cc:Subject:Date:From;
        b=tBnEB2TL3BB1Za5i/ByduAiLyL/ZliIq28Qn4IhJXGD/Ez+EW7LDroGAZsfSt29pj
         ju/1u5PQyOHWfUhqJGMoah0RtfvbOTonrRZmLaR3sSo4mnZGMlB8PLLweNoCHwa2mN
         dX7MJQR60ASzeLe1ncvYJf9w26a4B+UzmmWd/XGZuCQ7k4fqO1ShEwU9VJfO2S2scg
         sN5Ip423GVFs3DonU7VwYnGzJjYKYcw8DYZefF1/jD6vmLlX6HlcSLr4RWtW0qFbcD
         925hPZ12KLkG4qi9bXbgh8IM+9p5Fy61kg8m/SjxcdrGQpD3v2unRwOGNNLRpmubBN
         AkV0ttTgjsy6g==
From:   =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 0/2] Two cross-compilation kselftest fixes
Date:   Thu, 29 Jun 2023 18:22:58 +0200
Message-Id: <20230629162301.1234157-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.39.2
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

When you're cross-building kselftest, in this case RISC-V:

  | make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- O=/tmp/kselftest \
  |   HOSTCC=gcc FORMAT= SKIP_TARGETS="arm64 ia64 powerpc sparc64 x86 \
  |   sgx" -C tools/testing/selftests gen_tar

the components (paths) that fail to build are skipped. In this case,
openat2 failed due to missing library support, and proc due to an
x86-64 only test.

This tiny series addresses the problems above.


Björn

Björn Töpel (2):
  selftests/openat2: Run-time check for -fsanitize=undefined
  selftests/proc: Do not build x86-64 tests on non-x86-64 builds

 tools/testing/selftests/openat2/Makefile | 9 ++++++++-
 tools/testing/selftests/proc/Makefile    | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)


base-commit: 3a8a670eeeaa40d87bd38a587438952741980c18
-- 
2.39.2

