Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03625793954
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbjIFKEW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238430AbjIFKEN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1D310F6;
        Wed,  6 Sep 2023 03:04:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EE7CEC433BD;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994649;
        bh=4qu6gNf1P779rn1wd4BnvavbHAx8Qh/H9OngrcT0avw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=BTOvay+ljaBED9elt4djmeJQK4mwQhiBE2AFfBF+/Wba07j+eCNKbDlUWbg3RpBDw
         hGmvsrZBZRQN6ojN6QuRL90gXHQ+S77viY+Jvpn1Zazw8J4hBnNjQ1X6wDu6RGm2aX
         AT3/yya8ZgE+dq5MrLZZAwB8zm9nJjCGkcw+6J4Ums1J4F21+rxmhb8CnLXJ2qN9Dk
         UNa5hTht1yl2vR5HK/8m2/4Us34yldYRFwpdsUf+oLFdiPUgJMas4iJPFr0DnvYDET
         cdKEB0Q9J7lPiBpgo3FsBxD/iR4gzuy6loxD29M4zow3QzJOcIO4xsZUdExd/kTpTg
         xhBKv1/AiWH2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id D673BEB8FB6;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 06 Sep 2023 12:03:25 +0200
Subject: [PATCH 4/8] x86 vdso: rm sentinel element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-4-3935d4854248@samsung.com>
References: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
In-Reply-To: <20230906-jag-sysctl_remove_empty_elem_arch-v1-0-3935d4854248@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=vL1EzsjYbFXKFrtK9nHJVvAi8tmBe++iatkzXK58byA=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6VLWSScWJxr1IbmgKPa1RZW7ObxI6WU/TSb
 /w1xzkBrsGJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOlQAKCRC6l81St5ZB
 T411C/4nYVxay01MI0fYlh2tXeRCZT4XrLhFpLHSsLO88W+1QBZQtZ8gO2vM+93YWSmHFkQoCsR
 KcoJwZ+EkkMf8WsQfME5NZZe9QqAWa0BuN3fag7YtX7JeDKjC5MraH/M3Zm35qVZ29hSCd/4mDY
 8DDTvWypGbwepR7WT38A30v9LrG80iOyooAB06kaGaxwXBA3ii+b2P6VHUVMlvMLuWkUOyok6/z
 nA2x0x83Wvsq170HlyQKHOBwap14ZhJ6OPoFSyTWUr6U983PpnqsfDmTcYgdE+OARYk8x4Ngmcx
 IRZjjJbvj2Sm+tgS6ENeITYZVJd8V0y0m8MU6xbC9ZLpoWEJGxj6JLAvO/ZSPaiRekoLloMAteJ
 es6duh9rqCsTesV5rsulOZIo6tufJTM0rY9CFw8vaGH/f/Kt3xBuSdy2fhgoBSo+hfeoGpSsKyE
 sbPcJ2atpAF8XbaZ3GdfKliG0jmCzxzi14sxh9li2gbxkwNwKNDKPBCYFUWsOqoMQezN8=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel element from abi_table2.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/x86/entry/vdso/vdso32-setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index f3b3cacbcbb0..37b761802181 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -66,8 +66,7 @@ static struct ctl_table abi_table2[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static __init int ia32_binfmt_init(void)

-- 
2.30.2

