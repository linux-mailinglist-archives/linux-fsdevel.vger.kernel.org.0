Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16647B513C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbjJBL3X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236695AbjJBL3U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CB6E0;
        Mon,  2 Oct 2023 04:29:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0AEE9C433B8;
        Mon,  2 Oct 2023 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696246157;
        bh=YTd+W/HJJzt1g+AotSrQmZSQ/u4v4LR76hzUk9+8KRY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=t8eQLWHy0x9yNcAeYoiq3u/17r0Fsj0jLO/922mjKowsWcFf+75qeFzU1gn5X+IgO
         jYBuJ9EePK9gcf6rm91bxqi5oJA5mfSJGaF+JCh/8ByuZw/vdZdI4zBna/kfihS8AI
         9HMGhp650xt+NNRAkAC+m0v3NkT/Uxb4qlVk6HEf4NkiuSptjmrV3IBk+bGBHN7GBS
         m68QMmle0GFzWbXH1NGW9NBBfKniS2uzYqAZzGxZm/9189ik/1htRX4OT6pDYV14+s
         +8XPmujmnz19k9UO5LOfKAqEpxhvskIzF90mJh+LlPfyp8HOw6ha+lMNAjKMiexaAW
         3Q6sC2KCJX6Bw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id E5C24E784A4;
        Mon,  2 Oct 2023 11:29:16 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Mon, 02 Oct 2023 13:30:39 +0200
Subject: [PATCH v3 4/7] x86/vdso: Remove now superfluous sentinel element
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-jag-sysctl_remove_empty_elem_arch-v3-4-606da2840a7a@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=cvzMuUejqMQP+BGPAXWnJqy+jCdRUm5VfxRP0+Qgc7g=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlGqoT7g4+JWiQV8k/61XdOPQ2RonRomvKi5kxu
 mRiOWMGwOuJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZRqqEwAKCRC6l81St5ZB
 TzjdC/9fKc+Cn6prbqpjfusVIp8cAMfZKAPr4G3moB2aTF1BnakvXHfY7Wf9qwA/bzZeofKl7SL
 M1RA2NsVoOzzKzIwtzVeR1Kgk1eRKiCCLRhMJRzoIhlnBR3/jLV5ygVGxnehDO9QwyxuPBS7bH/
 n6q/KD3vIeim+dgRREVJhCB0KtJ0kkl7dDm9c+iXNgXuxzcE79yiM1ljMw3v887zH5IUulV62vj
 7u/dB2tzjJS5b8Nv8RHdLNWr41UUEXu34VNBYbeAZQ0IKyBb4NGS2n96ZuxpwbLIri3BIYaC8Tw
 SU3xeiJ2N98pVOgDSYA1ZcpyFFPmKSCPDBeaJ48w3mkpLW6BwYvYb2F6lqwTUzDKfNhkti7+nOK
 UnZy656UxYdqQ+D5YLCSK8yHkWSvy87yo/DFL3YDErBvdoUZftuyxuV1jvPf50fO8rFalb9YQ1N
 E9YxTE4f+PYvGFKRxMLF+jQGebqh+zmc2AcJX/3ETJb6Hcl/7hAJXaAHf8nsOaWQ0Wxcw=
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

Remove sentinel element from abi_table2. This removal is safe because
register_sysctl implicitly uses ARRAY_SIZE() in addition to checking for
the sentinel.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/x86/entry/vdso/vdso32-setup.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso32-setup.c b/arch/x86/entry/vdso/vdso32-setup.c
index f3b3cacbcbb0..76e4e74f35b5 100644
--- a/arch/x86/entry/vdso/vdso32-setup.c
+++ b/arch/x86/entry/vdso/vdso32-setup.c
@@ -67,7 +67,6 @@ static struct ctl_table abi_table2[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-	{}
 };
 
 static __init int ia32_binfmt_init(void)

-- 
2.30.2

