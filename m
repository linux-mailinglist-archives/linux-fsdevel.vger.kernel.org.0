Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4804A4D8D53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Mar 2022 20:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244723AbiCNTwY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Mar 2022 15:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244683AbiCNTwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Mar 2022 15:52:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B391D3F301;
        Mon, 14 Mar 2022 12:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C92B80F79;
        Mon, 14 Mar 2022 19:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0768CC340E9;
        Mon, 14 Mar 2022 19:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647287417;
        bh=kMPXQdSDTqPZw7TxTqFO8+ozgcvhKk61vNuNGq6NqZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=aBYW5qr3K6D3J3laM6P3okKIixNitcz6eBEnEBls1QbCSU3MFvseZZdwZWbWqzmPZ
         T1xfXLDSYrcnDo3BO1UPC9Apfgj6XXgSHSdI+/fEImHikC2tXcSd6mK2gPVFvHZjSE
         ejnPBgt4ksCpDHJuo2kfZTRRuUltdiLxmObD5soPqUtzC5wglgwm9SqpwzlwWtB80K
         UKokgPWfw8A0jf/rK0SQMW9LTSQ7Qr34QOqFuPbN4MFfRAcMAARgCgSUuctH384LSm
         z/FTZFxvo1dXxy9MW9Q+Kn1E/rBwfk9A5DQ8XDyPQVJJyyAa6voZsrCOY4AIxI7eE4
         p/ZVemtnuIHvg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] x86: Avoid CONFIG_X86_X32_ABI=y with llvm-objcopy
Date:   Mon, 14 Mar 2022 12:48:40 -0700
Message-Id: <20220314194842.3452-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
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

This series disables CONFIG_X86_X32_ABI=y with llvm-objcopy, which has
had two outstanding issues, which are further outlined in the second
patch:

https://github.com/ClangBuiltLinux/linux/issues/514
https://github.com/ClangBuiltLinux/linux/issues/1141

The first patch is from Masahiro, which moves the CONFIG_X86_X32_ABI
back into Kconfig proper. It was initially pushed as an RFC:

https://lore.kernel.org/r/20210227183910.221873-1-masahiroy@kernel.org/

The conclusion of that thread was that the check was still needed
because of the two issues above. However, with the introduction of
IBT, specifically commit 41c5ef31ad71 ("x86/ibt: Base IBT bits"), the
second issue linked above becomes visible with allmodconfig, which
heavily impacts automated testing.

The second patch builds on the first by just universally disabling
CONFIG_X86_X32_ABI when using llvm-objcopy at configuration time so that
neither issue is visible.

While it is unlikely that these issues will be fixed in LLVM, this could
eventually become a version check.

This is based on -tip x86/core and I would like for both patches to go
with the IBT changes so that there is no build breakage.

Masahiro Yamada (1):
  x86: Remove toolchain check for X32 ABI capability

Nathan Chancellor (1):
  x86/Kconfig: Do not allow CONFIG_X86_X32_ABI=y with llvm-objcopy

 arch/x86/Kconfig                       | 13 +++++++------
 arch/x86/Makefile                      | 16 ----------------
 arch/x86/entry/syscalls/Makefile       |  2 +-
 arch/x86/include/asm/syscall_wrapper.h |  6 +++---
 arch/x86/include/asm/vdso.h            |  2 +-
 arch/x86/kernel/process_64.c           |  2 +-
 fs/fuse/ioctl.c                        |  2 +-
 fs/xfs/xfs_ioctl32.c                   |  2 +-
 sound/core/control_compat.c            | 16 ++++++++--------
 sound/core/pcm_compat.c                | 20 ++++++++++----------
 10 files changed, 33 insertions(+), 48 deletions(-)


base-commit: f8afc9d88e65d189653f363eacc1f3131216ef7c
-- 
2.35.1

