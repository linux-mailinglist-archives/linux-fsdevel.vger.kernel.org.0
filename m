Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3861793976
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238414AbjIFKEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238492AbjIFKEV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414A10F9;
        Wed,  6 Sep 2023 03:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30DD3C4AF6A;
        Wed,  6 Sep 2023 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994649;
        bh=h0a5x4tcjiRLI8hBcyPKIVxtaEtL9PHUZfFV4ZC2g6Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=AvJt7V+5voaWDvo82nQl2Rw6T11YgG4afxMzvHyyxnIcmbw5kcK+qFHjnW+PHVU9B
         Fud0JMe7TPH4Dvn3AjYKpKOCUO5S9e51+dz2SDencAHrwF1i9D46Wmg24VdR4+7UV+
         ZX1WaMuOCtLFE4IKchvqCBSri48qndIH5Aa8ttMHybFQYfEhJrWDJ4OetnUnOKh0x6
         OgS59PEZQX22SqHGJamFivJGssHHrFozSancic+89UND9ML4CQuhR5X5ptvW3chOKY
         QUCym4fANBCGPbSEV1PMnHEH8unlrog1mxFAxGSmPPC/rDJ6Xcd7waqLVWeHxVDr8h
         0y90e1GdV1nkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 1C85AEB8FB9;
        Wed,  6 Sep 2023 10:04:09 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 06 Sep 2023 12:03:28 +0200
Subject: [PATCH 7/8] ia64: Remove sentinel element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-7-3935d4854248@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=904; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=KVD0r38Cili5TZDRzSBYSSUVuCqs3hfxf9D58EVeiJs=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6WE//Xcwga/1NK2RLvtOot92IMQidneKT5p
 v+BAfqJ9cuJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOlgAKCRC6l81St5ZB
 TydxC/9h8/rccF341foOCgTiAME0wS/e9CbIyL0MBWHLnGQcnYp+RhqdOL0GqHAz726Be1j15kO
 v6YfgptJJw0OJvMP2WWim+xDgOYuBwfWffbIOEjiAZuahyU2itf1YdleanEZfHhbUqci//oJqSh
 0ajDFBrA+FJKGxCR89VZ01mvGJI5OzswbPnBN32NY4P6KwIE5UoxBLOyxfcT7EtwIQWKpqTk8Pk
 Tulducj2tt8/hPjMNRJetxGELK6ZaYDuLeG7JX3IXgv06/gZXR08QuTLJXmTBEC7oy80w8isUKr
 hY3CrAwd+3lFltSZdYchIvP73k94L3GvSEJz/G4tAoYa/ULVVQw5ClmPo4Se9AmCl7KWNCFFxk3
 YU67Wru1bC8mqE+BTU32baxgXb4PMz/bRGO5NXF5C2K7CYClJy4ZobHb94Ib7QdkgbMhGjwyBoE
 AxKe/dAVVCRcQ7EK66c3SmG+78AEf84jHaVHhmR0xjp7NumHR5XRJFCWi13YS3+jpgjhc=
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

Remove sentinel from kdump_ctl_table.

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

