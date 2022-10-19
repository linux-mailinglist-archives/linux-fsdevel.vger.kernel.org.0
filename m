Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847CF603AF5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 09:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJSHwb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 03:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSHwa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:52:30 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556671055D;
        Wed, 19 Oct 2022 00:52:28 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id D99715FE74;
        Wed, 19 Oct 2022 09:52:26 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] binfmt_elf: simplify error handling in load_elf_phdrs()
Date:   Wed, 19 Oct 2022 09:52:16 +0200
Message-ID: <4137126.7Qn9TF0dmF@mobilepool36.emlix.com>
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

The err variable was the same like retval, but capped to <= 0. This is the
same as retval as elf_read() never returns positive values.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 fs/binfmt_elf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index cfd5f7ad019d..1fdc92e95170 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -462,7 +462,7 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
 {
 	struct elf_phdr *elf_phdata = NULL;
-	int retval, err = -1;
+	int retval = -1;
 	unsigned int size;
 
 	/*
@@ -484,15 +484,9 @@ static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 
 	/* Read in the program headers */
 	retval = elf_read(elf_file, elf_phdata, size, elf_ex->e_phoff);
-	if (retval < 0) {
-		err = retval;
-		goto out;
-	}
 
-	/* Success! */
-	err = 0;
 out:
-	if (err) {
+	if (retval) {
 		kfree(elf_phdata);
 		elf_phdata = NULL;
 	}
-- 
2.37.3

-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


