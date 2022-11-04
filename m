Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D1C618EB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 04:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiKDDRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 23:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiKDDQ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:16:59 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254F522BE9;
        Thu,  3 Nov 2022 20:16:58 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id YEU00154;
        Fri, 04 Nov 2022 11:16:54 +0800
Received: from localhost.localdomain (10.200.104.82) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.12; Fri, 4 Nov 2022 11:16:54 +0800
From:   Deming Wang <wangdeming@inspur.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <ebiederm@xmission.com>, <keescook@chromium.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Deming Wang <wangdeming@inspur.com>
Subject: [PATCH] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 3 Nov 2022 23:16:44 -0400
Message-ID: <20221104031644.1955-1-wangdeming@inspur.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.82]
tUid:   20221104111654b93665246d00bf0b2870faeb81a5701b
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Deming Wang <wangdeming@inspur.com>
---
 fs/binfmt_elf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 528e2ac8931f..d9af34f816a9 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1160,7 +1160,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
-			retval = IS_ERR((void *)error) ?
+			retval = IS_ERR_VALUE(error) ?
 				PTR_ERR((void*)error) : -EINVAL;
 			goto out_free_dentry;
 		}
@@ -1245,7 +1245,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					    interpreter,
 					    load_bias, interp_elf_phdata,
 					    &arch_state);
-		if (!IS_ERR((void *)elf_entry)) {
+		if (!IS_ERR_VALUE(elf_entry)) {
 			/*
 			 * load_elf_interp() returns relocation
 			 * adjustment
@@ -1254,7 +1254,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_entry += interp_elf_ex->e_entry;
 		}
 		if (BAD_ADDR(elf_entry)) {
-			retval = IS_ERR((void *)elf_entry) ?
+			retval = IS_ERR_VALUE(elf_entry) ?
 					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
-- 
2.27.0

