Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5E6290BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 04:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237079AbiKODSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 22:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236825AbiKODSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 22:18:05 -0500
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0320D15A3E;
        Mon, 14 Nov 2022 19:18:03 -0800 (PST)
Received: from ([60.208.111.195])
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id JEG00156;
        Tue, 15 Nov 2022 11:17:56 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201602.home.langchao.com (10.100.2.2) with Microsoft SMTP Server id
 15.1.2507.12; Tue, 15 Nov 2022 11:17:59 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <viro@zeniv.linux.org.uk>, <ebiederm@xmission.com>,
        <keescook@chromium.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] binfmt_elf: replace IS_ERR() with IS_ERR_VALUE()
Date:   Mon, 14 Nov 2022 22:17:57 -0500
Message-ID: <20221115031757.2426-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   20221115111756b87c5982aa519fccab65dc704674a7a4
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Avoid typecasts that are needed for IS_ERR() and use IS_ERR_VALUE()
instead.

Signed-off-by: Bo Liu <liubo03@inspur.com>
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

