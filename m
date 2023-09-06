Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFE79396D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbjIFKEj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238455AbjIFKEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD910C6;
        Wed,  6 Sep 2023 03:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4748FC116A4;
        Wed,  6 Sep 2023 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994649;
        bh=aS1CKaB6IFSQkKTbYW+1TFmWQDgffGuIc55cdYEnypg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=ZP55AfhYN50EjDrCcB8iW90YByCyC9iI7NvOypziRPiBsL36v4/AH2CIRK5jiBx71
         FFnu77u00PPBrzOpwW99gzZlzkv0btytdQzqjvyoOQMjpDCaSorBYmJ4sO0dJv58qR
         2jsxP3XA2cOYiZH/ihFSxL88c11EEngkf3G67jxi/kOsjw6H/q5EzwPVprfDKYmmq6
         u+i3v4S2PaNE5NWxYG44kOk4AO/h9ykWOIx+gX9L+yO1LkgWLrmIvtAUQBmwg8N0aN
         WDMRwKzn4CxUyIfjfdILa1m5J6Nmo6MdV6iHbPJN3zWpCnEvw5Qx/tqIe9MCcDonn4
         Q/rnhxDsvinSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 32D19EB8FA5;
        Wed,  6 Sep 2023 10:04:09 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 06 Sep 2023 12:03:29 +0200
Subject: [PATCH 8/8] c-sky: rm sentinel element from ctl_talbe array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-8-3935d4854248@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=7bf5/tJGBhUQ9WK71ygDU4S0n97i+v0/NjwZE0o5pgU=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6WREfxGpSEon2IoEhHuwmPhd3lTNK0oImor
 fAfRY0k+XKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOlgAKCRC6l81St5ZB
 TyDwC/9FZEUSgEzlF7Ci/QWFlhzpOZwTgs6G1qVsDC2AsbhA0jgrplsVHcwsNKyVlmGgQ5vfrta
 AH8fSSOEcSJfoy1ev1mzCDfYY+AwZD0Iy9ga2WQ2skPBd9sjsJmzzsq01zWuRA3K8vELOvAmw5X
 5wDlhgg73sM7bY5QFpAvBOUwA0iCDvesjkqvKzOcDtOI7UHvrhvA4aU707BZq6KxCZ2sjHNMG7/
 L0mYjBGd9aLOWanKzP6FdWafWJZVG1SXFRLtfhYGo1kAHi0uSOYPGzvhR0TCbXXWVgwaFfJgjyJ
 CIDqEL5JsAA1uo9NErYbwccIFdf77G8k2faRS0nqc9bwzQkHIYpauUZZgzHkq7RlWXiMx+wiIsX
 ZNw2x+uXfqg2gDOa2PUzENunfeKSWXRdUUbLHyvQylboT6rPMLIct3GIuYh6cpwNTkzK886rmRn
 7/5Cf/CQU1gWgoVV9rRFdJSkFrYISwOHblDUKSVegiC+VPuuYfY+EPVPZcrT2S+IYb74U=
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

Remove sentinel from alignment_tbl ctl_table array.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/csky/abiv1/alignment.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index b60259daed1b..0d75ce7b0328 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -328,8 +328,7 @@ static struct ctl_table alignment_tbl[5] = {
 		.maxlen = sizeof(align_usr_count),
 		.mode = 0666,
 		.proc_handler = &proc_dointvec
-	},
-	{}
+	}
 };
 
 static int __init csky_alignment_init(void)

-- 
2.30.2

