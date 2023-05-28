Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F75713A7C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjE1QUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 12:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE1QUc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 12:20:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778C6BB
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 09:20:31 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3J87qJcsWrDwx3J87qjZRk; Sun, 28 May 2023 18:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685290829;
        bh=a2vlfOS/zd156pwgWbEvLCkl+o6nZ4EPHRWlCYI1/Dc=;
        h=From:To:Cc:Subject:Date;
        b=KVeczUZ2SyAWnA9n3+aJnOifGCiTgEBfhm1Wso9EJlktFte7I/K8YRWaX0PD1LAA+
         TyZ45qzvlxznn3FHzzU/LgAHEWWLn5J1J/FW9lQFLfhvBA0W+f/l2ZD5tz2osdtA0x
         Rnzuzet0WwEtNtln/r545IpoMMkikmB/3McAaG56VrZucC2AFhJN8xHSvcCce5aDU0
         kdMGUJzsigwyY+rtfN2seE6H1bMQFwOB248InKFtDuqb5TAvEqi/l4PGejxwsz8Hwl
         CHwz7QDQcX+mOs3cme9JFRxThY7U6uqMBO1tMEipxYN4CAgH/WOy+9Tcc2IRhAjSne
         iXOfKYaNp6gfw==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 18:20:29 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/2] binfmt: Use struct_size()
Date:   Sun, 28 May 2023 18:20:24 +0200
Message-Id: <53150beae5dc04dac513dba391a2e4ae8696a7f3.1685290790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use struct_size() instead of hand-writing it. It is less verbose, more
robust and more informative.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested on arm
---
 fs/binfmt_elf_fdpic.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index d76ad3d4f676..237ce388d06d 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -748,7 +748,6 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 	struct elf32_phdr *phdr;
 	unsigned long load_addr, stop;
 	unsigned nloads, tmp;
-	size_t size;
 	int loop, ret;
 
 	/* allocate a load map table */
@@ -760,8 +759,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 	if (nloads == 0)
 		return -ELIBBAD;
 
-	size = sizeof(*loadmap) + nloads * sizeof(*seg);
-	loadmap = kzalloc(size, GFP_KERNEL);
+	loadmap = kzalloc(struct_size(loadmap, segs, nloads), GFP_KERNEL);
 	if (!loadmap)
 		return -ENOMEM;
 
-- 
2.34.1

