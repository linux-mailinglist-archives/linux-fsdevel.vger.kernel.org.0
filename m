Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F6179396B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 12:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjIFKEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238456AbjIFKEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 06:04:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6830310F5;
        Wed,  6 Sep 2023 03:04:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D285C433B8;
        Wed,  6 Sep 2023 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693994649;
        bh=MeWPiqJiO/jOcKwTD539iGDPqH49TJT55WL1+BWZcg4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=mqcTxzQE5uGFNnU1YlI2ew6jyQZr0W/KWa39DRlrc3RqyZ25Qv46LVmC81T7876PC
         0LEqBoFQn0g3pV7ZXGv8mW7WVN9mc2tTGoCmS2zv5OIrHFexKr7zG/eigAymiMKye3
         DNbXUJir37GZrOdvfBp7dAwmc0Ka7xo7us96GAsWILWBsR4cRgd6eJX2KF/H/Ru4IE
         U6UV7JTa8qmkbdxywL6frapqNa8N+wqqGpaU3/wRgFCvQrk1XNn7XExO+DsEHhJbVC
         Ho5sHtb9IqtXn7/e1NodRMAEnHjjUtBczUE/hkcdhc7fRiiJ1SlmdGmWOatMqLZgr0
         M8+uxvNcVjICg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id EADBFEB8FA5;
        Wed,  6 Sep 2023 10:04:08 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Wed, 06 Sep 2023 12:03:26 +0200
Subject: [PATCH 5/8] riscv: Remove sentinel element from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230906-jag-sysctl_remove_empty_elem_arch-v1-5-3935d4854248@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1003;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=t3WkpVtcuZNgLfzODS/f6Wl7+8aj87aPFtcdo3tcO7g=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBk+E6Von/T+ilU5pBn4tuVN9msXbNXiDEdCeNZM
 WZu4HJ8S0eJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZPhOlQAKCRC6l81St5ZB
 Tz3jC/9dN3MWg/3ZWUm/XKdTghUQEp17Vk2HqbZ/vM6brez2iYSNe78aEZgEeiVqr9uX1yKcNlL
 yv9Yx9SlvuX5AVA7JTJD9S9MXahhpbfHtiI9Am58HnMs2Z7Lzl2Ko/pKVIMu8J+pCSzNiPqpFOZ
 xe1xyI5cemTS8YFjjL/q9ABG7R+ug+GAv2Iuy+7jJn2PQ7Fyh0GFdc4zsjdwQBY+4vB0SxFV6ka
 XuUtM9oMYkSjDy7a9pdUOxQBBy1xBFnjmsyS8srdB1t8+/A4rjeqcZIytVtQejZa8lqPjmqoMuk
 XZOreS5jqEblBcNJPg41oJ1o0J8jTiG4qbQZ65xtyyVPeSYekAyUVQHxF2iZ+WkIPV2APheEDU0
 Cemyp+peINjokedAcLEjKDIqxg9XQNYXhTdmBvhU2FdgRkKIBf67ryX5hN5lkSktgPVaJqSFWvc
 Bn01a42l5syjn7KRc/p1e2FbBVgv2tHfrjWzpcWJaHvsbjOKL24B4TSWJBtabzIHzyYXs=
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

Remove sentinel element from riscv_v_default_vstate_table.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 arch/riscv/kernel/vector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 8d92fb6c522c..a1ae68b2ac0f 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -254,8 +254,7 @@ static struct ctl_table riscv_v_default_vstate_table[] = {
 		.maxlen		= sizeof(riscv_v_implicit_uacc),
 		.mode		= 0644,
 		.proc_handler	= proc_dobool,
-	},
-	{ }
+	}
 };
 
 static int __init riscv_v_sysctl_init(void)

-- 
2.30.2

