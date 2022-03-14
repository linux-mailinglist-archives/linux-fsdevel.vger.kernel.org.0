Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF27C4D8D45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 20:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244649AbiCNTv6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 15:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbiCNTvx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922C3EF01;
        Mon, 14 Mar 2022 12:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E17BB80F96;
        Mon, 14 Mar 2022 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF52C340EE;
        Mon, 14 Mar 2022 19:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647287421;
        bh=pyw+uUsWl3RVdP8v6qowJOWyQJdm2VaPP/Bj2TK1ByM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V35xPzC0SANL4OOpntptnxwfH3nLIYI5VEaA9BrwfwAu8bvPOHyAqVUw21vYwVrAk
         BE5/t7c15HReRasVusQQv81fElEBG3vFWSvir6e8NJI0FHrAmInGhKkxkr64Ge2tSt
         3Y5mzD6EWbBR2HGUd2PvFkmH64XSZ6Ije2djTBcdzpvhRp/Y+bGCgBRz4Q0WVx9TqW
         O4H6xttVahB95D7TRtPhoEdwKcjVctFHjWNYaQazpf9nZQlppkShxTpdFuo2PA2xNb
         FmQWRJtWbFVp4Pz8M8/ZiWhPityGzRb61SWCJO6KTXLpHDReAXGSpmLEadGt/jWb01
         VkyTxadUGALpQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 2/2] x86/Kconfig: Do not allow CONFIG_X86_X32_ABI=y with llvm-objcopy
Date:   Mon, 14 Mar 2022 12:48:42 -0700
Message-Id: <20220314194842.3452-3-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314194842.3452-1-nathan@kernel.org>
References: <20220314194842.3452-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are two outstanding issues with CONFIG_X86_X32_ABI and
llvm-objcopy, with similar root causes:

1. llvm-objcopy does not properly convert .note.gnu.property when going
   from x86_64 to x86_x32, resulting in a corrupted section when
   linking:

   https://github.com/ClangBuiltLinux/linux/issues/1141

2. llvm-objcopy produces corrupted compressed debug sections when going
   from x86_64 to x86_x32, also resulting in an error when linking:

   https://github.com/ClangBuiltLinux/linux/issues/514

After commit 41c5ef31ad71 ("x86/ibt: Base IBT bits"), the
.note.gnu.property section is always generated when
CONFIG_X86_KERNEL_IBT is enabled, which causes the first issue to become
visible with an allmodconfig build:

  ld.lld: error: arch/x86/entry/vdso/vclock_gettime-x32.o:(.note.gnu.property+0x1c): program property is too short

To avoid this error, do not allow CONFIG_X86_X32_ABI to be selected when
using llvm-objcopy. If the two issues ever get fixed in llvm-objcopy,
this can be turned into a feature check.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b903bfcd713c..0f0672d2c816 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2864,6 +2864,11 @@ config IA32_AOUT
 config X86_X32_ABI
 	bool "x32 ABI for 64-bit mode"
 	depends on X86_64
+	# llvm-objcopy does not convert x86_64 .note.gnu.property or
+	# compressed debug sections to x86_x32 properly:
+	# https://github.com/ClangBuiltLinux/linux/issues/514
+	# https://github.com/ClangBuiltLinux/linux/issues/1141
+	depends on $(success,$(OBJCOPY) --version | head -n1 | grep -qv llvm)
 	help
 	  Include code to run binaries for the x32 native 32-bit ABI
 	  for 64-bit processors.  An x32 process gets access to the
-- 
2.35.1

