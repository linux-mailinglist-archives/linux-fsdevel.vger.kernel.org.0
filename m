Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8253F603ACC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 09:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJSHkg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 03:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiJSHke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:40:34 -0400
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 00:40:33 PDT
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9F05F133;
        Wed, 19 Oct 2022 00:40:32 -0700 (PDT)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 8A3855FB28;
        Wed, 19 Oct 2022 09:32:36 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs/exec.c: simplify initial stack size expansion
Date:   Wed, 19 Oct 2022 09:32:35 +0200
Message-ID: <2017429.gqNitNVd0C@mobilepool36.emlix.com>
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

I had a hard time trying to understand completely why it is using vm_end in
one side of the expression and vm_start in the other one, and using
something in the "if" clause that is not an exact copy of what is used
below. The whole point is that the stack_size variable that was used in the
"if" clause is the difference between vm_start and vm_end, which is not far
away but makes this thing harder to read than it must be.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 fs/exec.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 768843477a49..990891c5d8fe 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -840,16 +840,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	 * will align it up.
 	 */
 	rlim_stack = bprm->rlim_stack.rlim_cur & PAGE_MASK;
+
+	stack_expand = min(rlim_stack, stack_size + stack_expand);
+
 #ifdef CONFIG_STACK_GROWSUP
-	if (stack_size + stack_expand > rlim_stack)
-		stack_base = vma->vm_start + rlim_stack;
-	else
-		stack_base = vma->vm_end + stack_expand;
+	stack_base = vma->vm_start + stack_expand;
 #else
-	if (stack_size + stack_expand > rlim_stack)
-		stack_base = vma->vm_end - rlim_stack;
-	else
-		stack_base = vma->vm_start - stack_expand;
+	stack_base = vma->vm_end - stack_expand;
 #endif
 	current->mm->start_stack = bprm->p;
 	ret = expand_stack(vma, stack_base);
-- 
2.37.3


-- 
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source


