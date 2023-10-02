Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8447B5154
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjJBL33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjJBL3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:29:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE7FD7;
        Mon,  2 Oct 2023 04:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5371DC116D2;
        Mon,  2 Oct 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246157;
        bh=8Y0OZ+ek4AhIcf8Sjp8fQ2M9HKsNYRF/q4Q31JpOT5o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=HoYlpryWcQZV4xEoh38551sI60gfNK4cNGdEKgXPz9x08VsBC5G/69LBFbXuToEgn
         BfBDfABhYQMaA/7y4/yMOLRE2yxXFJEEmhWmuOXt9SqvBUrhF02pxsFB+Oy95KS3Uo
         lMq4M9cbbqTcQLk8Mt0GHY0NkCOn4Jd8OvFimK3fza9rF9VZ+2Ar+cUV7TeEgsIf0n
         AfN3Z6+zr6tOgqL9qirOQi2pRK98RKq8bt6HNDMvcyBkOvRb/QX5w6hRjj7JYKtuUg
         tRfO2u8Hi/A7XL6lw6dB721W2W3IWPxGFfSchln4SLcXKRGbevSUs6wqi75teA8l65
         WpR4VjGman2fA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 3A93FE7849A;
        Mon,  2 Oct 2023 11:29:17 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 13:30:42 +0200
Subject: [PATCH v3 7/7] c-sky: Remove now superfluous sentinel element from
 ctl_talbe array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_arch-v3-7-606da2840a7a@samsung.com>
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
        Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=1079;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=aVH730u6MpA8SyXSwY+KroDm6RkQOYcUB41QGWJqNpM=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGqoU5tuFWjnPIMvFbKyN6zHH0cwg/pUFRD/vM
 SfkGU2MIlyJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqqFAAKCRC6l81St5ZB
 TyUKC/0c39WVZtnSe4HAi+KjUVd8v38cq95t+0bYTAm0t4UjG8Lsp3T5G80IFPYLmapvMnK4uVe
 Lyeg6+WlLJagatcnmBtfVxhCU0ewAPcEqiwiP6qZx3c8PLEexEriY2mthOka69yhwr3nKHEnyV8
 Bqp7zzu/E1zwrNE1+/cSzV96Y/lZ/qWZCRPRHR7SuOeWwWTDbyhgveJ+cmUr4q6nwLVv9D8Vj6M
 B7kOycGh+RMxgVTKEAlnSPVgKcwgHE24nlo5RUyuu77WXCMlCIrZdyyNDZrrQykuiXWNxLKiMrj
 XLAE5oYgpIZ9uRGWS1dzT2edeQ+COFGaR51Q/tvQualP2kfj7A2dQzLIAF8fmcWYwWVMj1RN44o
 jz1VmKwvgpAAwhyJL1nlRqp0Dx+iccYp2zBAhv5X8ptE4axnZuJSjdUGQVapPNd/0eA4u87Ubaa
 zmvv90vSv16KKgBYe+ABuMSkfh7iM8iC7eDe4BQqUi7MyRotUfD+EMFwsoiIIw56IZ6Jg=
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

Remove sentinel from alignment_tbl ctl_table array. This removal is safe
because register_sysctl_init implicitly uses ARRAY_SIZE() in addition to
checking for the sentinel.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/csky/abiv1/alignment.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/abiv1/alignment.c b/arch/csky/abiv1/alignment.c
index b60259daed1b..e5b8b4b2109a 100644
--- a/arch/csky/abiv1/alignment.c
+++ b/arch/csky/abiv1/alignment.c
@@ -329,7 +329,6 @@ static struct ctl_table alignment_tbl[5] = {
 		.mode = 0666,
 		.proc_handler = &proc_dointvec
 	},
-	{}
 };
 
 static int __init csky_alignment_init(void)

-- 
2.30.2

