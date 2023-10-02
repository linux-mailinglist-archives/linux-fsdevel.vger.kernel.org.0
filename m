Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C9B7B5137
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjJBL3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjJBL3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DFBE1;
        Mon,  2 Oct 2023 04:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E58DFC433A9;
        Mon,  2 Oct 2023 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246157;
        bh=paEg7jbS6ClwadfTjCY8spaWc4zoBRD4LNZENNl+tI0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=g63JmB3FwRN+ONhF0yFWNoeQbjgW/+dLj88bOfgo+g4WnhlVqgsUhvBXVnqIBEzEa
         NKA9xpv4v5bqJz5FshYIhdGxjJU/3V+BIpN6DXNW9yYrdu3/naHi10PvjraNLxtpvP
         lqVL9unEsn8m6mroat6KP9YTq+agMsSs1+ErBDFVshRf5GSQdusPBba1LGchOx1Xw8
         ZC73IWYzrJKtOWva3dJcYa0yaY51FbhDQU/XF7igYRnnXwiQodv8iGaZ712BCL6IEh
         wNHCzz00hC9vYtc17q6bF+uXjeU37b1Ejcs8O5iyNoQZWkXnhXqj8ZfBgNxH5Kk0qe
         f49vMMABDx3zA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id C993EE784B3;
        Mon,  2 Oct 2023 11:29:16 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 13:30:38 +0200
Subject: [PATCH v3 3/7] arch/x86: Remove now superfluous sentinel elem from
 ctl_table arrays
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_arch-v3-3-606da2840a7a@samsung.com>
References: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
In-Reply-To: <20231002-jag-sysctl_remove_empty_elem_arch-v3-0-606da2840a7a@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1593;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=PwJWF8dvooepoMNz/p+1M3MxYdMvjcobbwcaQ8BSBXs=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGqoTaJgUocisU/uKHeKQW8lN62asIcRF0tSyU
 j1bINvl5aaJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqqEwAKCRC6l81St5ZB
 T2WoC/42iLPK3Fpv9v0/UXHAJOtoq4rmwpC6LV+o8A8lRqkO0uVf5VMImgogTwxzXQr1P3Yp0/f
 VkRKFwLFysV0LI5OTH18s+1eSsihUKcyNYRItL+Uq+SG7vI8uv3w4uq7ydWykr0/1p5fe90bFnZ
 rT/ph6DGwQ4RaSRd2IwaAXrJoLHLTaGD3zAA5eRCmU++8Rwy2+XIB0JWzH9N6Mp7B4yMOH+oCni
 h64V+45R1T69SCPmnI4rrG9sYfo2+IWLBGP+D8FI36C+FMUkuhSBjEnDfpt24eZTWWnMsAsJRbS
 541J6mTwxGXlPqq3c2f4wXLAMWCm7qio0X0B9ufvk4Ck4h8LNlUwr4yB41O/apZOtev+opRUo2B
 KvuQDk4hosgIzP4dO6PC22swDlVoomqCwgBL6V0twDOwiRoFLJstFxcGJY+c4YgKfSn9XOzxLK0
 boNkZU5mRziaQEPzuSz2ndrwThriKlNPPGY3pJaax9H01L2JtJ5vAJV1/zgY7rDFMm7jU=
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

Remove sentinel element from sld_sysctl and itmt_kern_table. This
removal is safe because register_sysctl_init and register_sysctl
implicitly use the array size in addition to checking for the sentinel.

Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/x86/kernel/cpu/intel.c | 1 -
 arch/x86/kernel/itmt.c      | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index be4045628fd3..d9bb53f49a4d 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1016,7 +1016,6 @@ static struct ctl_table sld_sysctls[] = {
 		.extra1         = SYSCTL_ZERO,
 		.extra2         = SYSCTL_ONE,
 	},
-	{}
 };
 
 static int __init sld_mitigate_sysctl_init(void)
diff --git a/arch/x86/kernel/itmt.c b/arch/x86/kernel/itmt.c
index ee4fe8cdb857..9a7c03d47861 100644
--- a/arch/x86/kernel/itmt.c
+++ b/arch/x86/kernel/itmt.c
@@ -74,7 +74,6 @@ static struct ctl_table itmt_kern_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static struct ctl_table_header *itmt_sysctl_header;

-- 
2.30.2

