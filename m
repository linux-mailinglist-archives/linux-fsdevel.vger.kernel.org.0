Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14907713A7F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 18:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjE1QUp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjE1QUo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 12:20:44 -0400
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0CBE
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 May 2023 09:20:42 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 3J87qJcsWrDwx3J8KqjZT0; Sun, 28 May 2023 18:20:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685290841;
        bh=0xJS/fpIMbVgICwjevG2Mh+kQS4ETIrWvAeZpBHPlyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CBwvekAV1qKxJ4DwNqJ9ZDO8acOPtMMg7Q+s4w4fKGbs2vPD7lOV9bOSC4EI2vg4M
         qWZaaXL7whDH7BvYKkoTs6xIAtYksqhzfEtIUf9gQTRoSoIUVFxoVqHeIEugaQ1U7E
         CoQ7h2Wo6Fns43siy2gzzdgF5LVRjW+zxjS7t47FmlOloWjca03H6LskQi5vMINkH8
         MunknPlfBTPdPZFUEaGKzlaSAA2yJERP3fUHh5Ng9udhrXyXWVqqdJsml+CHZcmst9
         vBSXNuRwpT4Lf7pZsMpXtBbKAdlnWBlgkxNaUa5v7Z/10k6HZdHMCrBXXwBg5zYHE1
         F6HtkeE+iygIA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 28 May 2023 18:20:41 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/2] binfmt: Slightly simplify elf_fdpic_map_file()
Date:   Sun, 28 May 2023 18:20:25 +0200
Message-Id: <4f5e4096ad7f17716e924b5bd080e5709fc0b84b.1685290790.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <53150beae5dc04dac513dba391a2e4ae8696a7f3.1685290790.git.christophe.jaillet@wanadoo.fr>
References: <53150beae5dc04dac513dba391a2e4ae8696a7f3.1685290790.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no point in initializing 'load_addr' and 'seg' here, they are both
re-written just before being used below.

Doing so, 'load_addr' can be moved in the #ifdef CONFIG_MMU section.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested on arm, with and without CONFIG_MMU
---
 fs/binfmt_elf_fdpic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 237ce388d06d..1c6c5832af86 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -743,11 +743,12 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 	struct elf32_fdpic_loadmap *loadmap;
 #ifdef CONFIG_MMU
 	struct elf32_fdpic_loadseg *mseg;
+	unsigned long load_addr;
 #endif
 	struct elf32_fdpic_loadseg *seg;
 	struct elf32_phdr *phdr;
-	unsigned long load_addr, stop;
 	unsigned nloads, tmp;
+	unsigned long stop;
 	int loop, ret;
 
 	/* allocate a load map table */
@@ -768,9 +769,6 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
 	loadmap->version = ELF32_FDPIC_LOADMAP_VERSION;
 	loadmap->nsegs = nloads;
 
-	load_addr = params->load_addr;
-	seg = loadmap->segs;
-
 	/* map the requested LOADs into the memory space */
 	switch (params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) {
 	case ELF_FDPIC_FLAG_CONSTDISP:
-- 
2.34.1

