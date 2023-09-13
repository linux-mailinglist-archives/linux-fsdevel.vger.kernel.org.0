Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A89579E330
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 11:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239383AbjIMJLy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbjIMJLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A51BC0;
        Wed, 13 Sep 2023 02:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2438FC116A4;
        Wed, 13 Sep 2023 09:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694596291;
        bh=neku3bTCLd8IglpTrtn5YSfS1u8bct6QtrT0n8vQ+lQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ERVWG+xelJhWJO/pE6ZpZqbYBufn/m6Org9hCcDXMkTmBpkBJNwrGcPjHjggWwSjg
         xHSwzqHBlZEaRvodwTEsTM2UPPEWIcriaDpPyFrPAVtt0aMxdW7R25OmEcQQUIO1iq
         BFzpp7+o/G7EMsNhqHZpkhyqKwHYmiagZH+yHECEv0qdbMzn4txgV9xb0AB6vtd0WP
         O3zX1B9D7AWoHLEwnVBvNiwAdyk18/HGfvAhpqONmEMHQvA6MTM9pFo7GH7nwksmiC
         3cepVxgJG8gcgElZlEO9vwZ+0fBYaHr56xvhry9vyHUgdx7Vq2R2Pzfd00GKowmfBN
         6tO/av8ZPNvzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 0C42BCA5517;
        Wed, 13 Sep 2023 09:11:31 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 13 Sep 2023 11:11:00 +0200
Subject: [PATCH v2 6/8] powerpc: Remove now superfluous sentinel element
 from ctl_table arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-jag-sysctl_remove_empty_elem_arch-v2-6-d1bd13a29bae@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=Y5aFvjpy8hnP3BxMe92wukoMH7BspM7ptVXcM2uJq5s=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlAXy/xLS9tN6wR4DTogukmf0SR2Ukel+W6p3j5
 MCK5Hj/WweJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZQF8vwAKCRC6l81St5ZB
 T1XIC/sE7BuNn+96xT2x1msylJMtzgid9hN+e61HJ/NrDH1qqtScW6m30OKC6e0si6quzFz+YTi
 pAV4GZ7idF5xMOvHsbvwHIV1RwdZ9DhNtNL/LcDHG/XvJ7MwTgh/8AoLebpm6OVkPQzqaWghP1b
 bzT8rmYjV96saQgi8rPwt5ll57v8gv1g5ILyY4y+b+6f2Be19zRDDsj4YI3KdSau+0Rkw0OzdOr
 YOniWyBhmeW8vrb7Dfj3gECbAbjc2ndqLK72/WvPmgSrYzSVOezRh/xCsdldI9yTZOMnsLSSH+X
 GdOpAmEzI2XbDYlu3A2G8O7cg/mK+ZxT0+EA+PGFF8F8/pkZzHBXH02cunz12+R+VITnonmfxDD
 evvGMCqFZn2DmF/LgB+pptc/gO+Gs4uaedB1/T1oRlknK5y5fLNj0ce0Dw6GubZDNd5LaWme77D
 rnaLwKeVw2DfKOzgC+qKXHFSFjgISSSh1/pXUwVODumOI/GkOK8K95eDP4hfIXZ3+/M1Y=
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

Remove sentinel from powersave_nap_ctl_table and nmi_wd_lpm_factor_ctl_table.
This removal is safe because register_sysctl implicitly uses ARRAY_SIZE()
in addition to checking for the sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/powerpc/kernel/idle.c                | 3 +--
 arch/powerpc/platforms/pseries/mobility.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
index b1c0418b25c8..a8591f5fa70e 100644
--- a/arch/powerpc/kernel/idle.c
+++ b/arch/powerpc/kernel/idle.c
@@ -104,8 +104,7 @@ static struct ctl_table powersave_nap_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
-	},
-	{}
+	}
 };
 
 static int __init
diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
index 0161226d8fec..d82b0c802fbb 100644
--- a/arch/powerpc/platforms/pseries/mobility.c
+++ b/arch/powerpc/platforms/pseries/mobility.c
@@ -60,8 +60,7 @@ static struct ctl_table nmi_wd_lpm_factor_ctl_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_douintvec_minmax,
-	},
-	{}
+	}
 };
 
 static int __init register_nmi_wd_lpm_factor_sysctl(void)

-- 
2.30.2

