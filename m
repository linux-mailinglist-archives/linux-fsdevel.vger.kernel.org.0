Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F68603ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 09:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiJSHnG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiJSHnE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:43:04 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D499C786DB;
        Wed, 19 Oct 2022 00:43:03 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 69C9C5FB28;
        Wed, 19 Oct 2022 09:43:02 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: fix documented return value for load_elf_phdrs()
Date:   Wed, 19 Oct 2022 09:43:01 +0200
Message-ID: <2359389.EDbqzprbEW@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function has never returned anything but a plain NULL.

Fixes: 6a8d38945cf4 ("binfmt_elf: Hoist ELF program header loading to a function")
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 63c7ebb0da89..cfd5f7ad019d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -456,7 +456,7 @@ static unsigned long maximum_alignment(struct elf_phdr *cmds, int nr)
  *
  * Loads ELF program headers from the binary file elf_file, which has the ELF
  * header pointed to by elf_ex, into a newly allocated array. The caller is
- * responsible for freeing the allocated data. Returns an ERR_PTR upon failure.
+ * responsible for freeing the allocated data. Returns NULL upon failure.
  */
 static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
-- 
2.37.3

-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


