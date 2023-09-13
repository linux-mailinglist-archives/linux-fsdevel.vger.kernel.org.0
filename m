Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED70379E32B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 11:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbjIMJLx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 05:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239300AbjIMJLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE43419B5;
        Wed, 13 Sep 2023 02:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F839C116A5;
        Wed, 13 Sep 2023 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694596291;
        bh=ksLU1HhgDy0MhjOqDh9D7XFTDE0gr0igDsdY2TtQW18=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=BLO61mdJNn6CFbNVYJjrwbyXdBVv5NFrqAeXI2EoDlrYgpyjKA/a7K0mcAbrDsEUS
         /zRt3jzQjiD7tnH79ngNjTRrpWltErPT9PWMgRJ80QBu/DRSztMYa3I/EkrTmJCFOl
         5ktxTNb522azMcoeSzoUUNYza35JGtsN1La6L5VMCtSH3HssQ+WHpVRrXoUspvn0S4
         X+ENyNMkwhS7Bg69Ei4IM/HT316zTaCS6/3aC5bdKZ8KY28N7Oindn6ORq753wVWXO
         AstD/NMFYFbd2rxWuaP+AzEkxFO4MANSJwiL4Nctt5RUoICOQoeM+63DVHgNIXTLsw
         L/Q6xw4TF/Y9A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 24C79CA5518;
        Wed, 13 Sep 2023 09:11:31 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 13 Sep 2023 11:11:01 +0200
Subject: [PATCH v2 7/8] ia64: Remove now superfluous sentinel element from
 ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-jag-sysctl_remove_empty_elem_arch-v2-7-d1bd13a29bae@samsung.com>
References: <20230913-jag-sysctl_remove_empty_elem_arch-v2-0-d1bd13a29bae@samsung.com>
In-Reply-To: <20230913-jag-sysctl_remove_empty_elem_arch-v2-0-d1bd13a29bae@samsung.com>
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
        Guo Ren <guoren@kernel.org>, Alexey Gladkov <legion@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-csky@vger.kernel.org,
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=lfucH0fE8uQFBzo2EP5V/PmdZ4osPZqCeYafiOtbfRE=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlAXy/IrVGWKts3t7qO7epOhGK03/TUs7HC3Aht
 61eeHhSd6WJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZQF8vwAKCRC6l81St5ZB
 T1qXC/955BgLg+IseBXTIS9fcvV95BuKTAMxBJeylP/3uT/84KdU6CA8PQILJr4QWPTncvV2oFg
 C5js1ma1h0Ak2ndYSvUUh7C24rfIM5N7HW0X6W2rgeo/TUzexc1bQDk2YaRJuUABtI/+7MQjBY9
 dN/JjBF9PdLXde4EcRVrJfvYjOGX9A3CYI+V+Sb6o/J4zva5hvRuVPWF6czcENFd0P1OxVT4A5P
 K7QEmzlxVqbYMqcR8NxJOwoGiuxkaJ6q7St95Nm7KMh/+EtR1RDI2MhkA4pQtPrsUZSyKlmopcT
 FZujBQxUfYpXn08bUXhQlor7gLp3KkSVugiPZLHoqNld5DzvBZWgmgF8yiH7RjXVfqzC8MmaQTy
 WRz63EbdYN4/8UInqWjBuxPPitn9iucNOMRWV4E+GyCSmMjmF8oQvSC/FHjikZhp9qeNZ2Js2p3
 +hhsDdk3on0AxHDllu98rHNusDz6G/ueEuVhC+eYmyDvjXtif26siW/vEQe2Lc9PMNWQY=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove sentinel from kdump_ctl_table. This removal is safe because
register_sysctl implicitly uses ARRAY_SIZE() in addition to checking for
the sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/ia64/kernel/crash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/crash.c b/arch/ia64/kernel/crash.c
index 88b3ce3e66cd..fbf8893a570c 100644
--- a/arch/ia64/kernel/crash.c
+++ b/arch/ia64/kernel/crash.c
@@ -231,8 +231,7 @@ static struct ctl_table kdump_ctl_table[] = {
 		.maxlen = sizeof(int),
 		.mode = 0644,
 		.proc_handler = proc_dointvec,
-	},
-	{ }
+	}
 };
 #endif
 

-- 
2.30.2

