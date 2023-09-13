Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B9A79E320
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 11:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239296AbjIMJLt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 05:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbjIMJLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:11:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4EB19BD;
        Wed, 13 Sep 2023 02:11:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6B92C433B8;
        Wed, 13 Sep 2023 09:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694596290;
        bh=RibUDN9R+mVe2Lz6B7/1/Dio8c9tfQM7q2jS6jar4RM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=PRyNez8Os2r73tRnPuMkOsNStqVtl6GUBe6Dtb4wua2O3Z2WQDaETz0xSqQNi0+ZV
         k2J0Xhph6ulihlVMPwEtUV2BhzROmRMIgvZhoiby/ePvz1kzvaOq8PGLsXVJIjYS2c
         EiE6iQYMTpD1X1viQDoQEQvVUz5uB9EZIQw5DF2iYLn2CFh+6K6qJqyXAmpkeEU/dh
         gzJX1VlKpU12g3dzx78JvFg99ONL1+sghX3CBQ2fQN2kaRBTHw4Q/yzIWAilVs06EX
         uEUVoRY60WHnICf2u7H/R3oV7Sqnk+gSe27Xv/CilA2UYLUBl3yPoUjspuVD7WsiHI
         x6nRiaIdPIfow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id ADEC5CA5518;
        Wed, 13 Sep 2023 09:11:30 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 13 Sep 2023 11:10:57 +0200
Subject: [PATCH v2 3/8] arch/x86: Remove now superfluous sentinel elem from
 ctl_table arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230913-jag-sysctl_remove_empty_elem_arch-v2-3-d1bd13a29bae@samsung.com>
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
        Joel Granados <j.granados@samsung.com>,
        Ingo Molnar <mingo@kernel.org>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=/mE3FCrO8N9N5ocA17o8WorvC+93ienB9ASm3953JX0=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlAXy+P6IyIJVAiVruEBhUNPQKqpELjF18dzfN2
 Sau5oc9p9+JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZQF8vgAKCRC6l81St5ZB
 TzOGC/wKtjbMwVyYSrKGZCdpsS8BeR6Sb+Sw1O/9MDzjfyeDErxvdriTX+K97uSfafn9EC9VkE4
 3+Dp5zJgbrSjxpxaY2pQf/y4ZqY0JxZ0XcLRBRaXvXHA4u/m2ZyMGMCFwXPcQ0TxgJJaeL7z1M2
 e0gVVu0zh/JY3KgtFwL3m+F2xqoPO5vSfr0CQMtxeGtoCRzB7GaeJOZKfjaNfg9MTQ9pd97hzBv
 IUrCdqoOJomMpsFaPQH7XD/nTx/PznAIXJTILEYG3Q5+bJd8wNgyEu2FJqYY5PJrl4XgVS1lxo1
 kU6vP6K1K5MEB4/41nrGXYIbQaG5xcCKIJ6aaIe5MI7VPHkPALZYq34tMa04Rb6q1qZlNVGmgln
 zZrnVgpFSoN7JFJig1ruKLb7yTIGrMX/dyYqV4XGkG5Tf7fyvC4WTycYJB590I/V2P9s9jSr8xv
 9FPq+RexsVQK5qYHFtthR/GrgPD5lrwWhuEzkCp0GM7f7Kh9f4hEAmQ+CxP14FEa65FCw=
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

Remove sentinel element from sld_sysctl and itmt_kern_table. This
removal is safe because register_sysctl_init and register_sysctl
implicitly use the array size in addition to checking for the sentinel.

Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/x86/kernel/cpu/intel.c | 3 +--
 arch/x86/kernel/itmt.c      | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be4045628fd3..e63391b82624 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1015,8 +1015,7 @@ static struct ctl_table sld_sysctls[] = {
 		.proc_handler	= proc_douintvec_minmax,
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static int __init sld_mitigate_sysctl_init(void)
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index ee4fe8cdb857..5f2ccff38297 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -73,8 +73,7 @@ static struct ctl_table itmt_kern_table[] = {
 		.proc_handler	= sched_itmt_update_handler,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
-	},
-	{}
+	}
 };
 
 static struct ctl_table_header *itmt_sysctl_header;

-- 
2.30.2

