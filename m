Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B24605F77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 13:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJTL4J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 07:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJTL4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:56:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F289616E284;
        Thu, 20 Oct 2022 04:56:04 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id l4so20075535plb.8;
        Thu, 20 Oct 2022 04:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QfEMq48V5eFN0VrM2HYUoVegivK/iVeEKYnMwW6hA7w=;
        b=Cyl5KTkXEp2CRgTe1763UrkbTjbp8kN8IbZfihSeKtAuINP1JR4IcJpEWZBlSPlzHm
         6/e9CSHukaC/m5T380e7Di+F+GFOmyLyDf8OeoLzFbDUsveRwq535x5LyuDVpIMm27Qh
         E2KWhNjZ8sWvXYOs/qM32lBg9RED1lgMHTGjaZk4P41pY0zmWUQBZB60xgcpRrt2nX62
         SKJLtJVEv9N6wpr1RS9vGNjgirkF521NhrXlSufwRbKhvO2D2s3hzvnib0OcFcn5rEDp
         6+hgMJZEZVQ4DX5y4gqCf/ogS33bM5B25zOLZHKeP1m7SSWNfNe+8ybAWTuDpiHWjthx
         1WzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QfEMq48V5eFN0VrM2HYUoVegivK/iVeEKYnMwW6hA7w=;
        b=Z13i4thZHtXZ8EOhxCAjpps0ArhOZtIZ8NQqcchQLTVq4z+5ruaYq25z9Q9usy75+r
         xWmWh8m6NckkQMEuWjyRhKSTru5iY4xrMOdhoqnWym/bt8hZUTlQrkxMTYkGH6YokjVb
         JOVkng2koYNob9A9bXPw/1/1zDiBgvHiJVem4g5lcxpvjUX7yk5QFIWm139nkwMdvpb8
         DjjrUB7KANxhl2kfhRdSYoTeXK6+1TZo3BpsegRuu9r7ORsQi0Z4egH680e7w7ubkNnB
         DFOhatpKOLk1bW7HAFQweaVB+gRHM1oPIoF//Lt6LDQRi1ibXa8jGXaGeD6EHUJ7CoY6
         +uIA==
X-Gm-Message-State: ACrzQf2wTBy5ubi3+OReTnFngG5U86o9QZyOuEdSCOqLU0fpj6fKUoIe
        0B0kbR0M3sZs6JWPRQtcFCg=
X-Google-Smtp-Source: AMsMyM7yLdXwgSS3YZrB6gbeJtcSboqSM6NN6zlyigcL6QP9UsA3LJx3j3kTyOQ0B+qgypo7xy1aeg==
X-Received: by 2002:a17:902:f78c:b0:17a:ef1:e902 with SMTP id q12-20020a170902f78c00b0017a0ef1e902mr13483537pln.5.1666266964456;
        Thu, 20 Oct 2022 04:56:04 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0017f80305239sm12784647plh.136.2022.10.20.04.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 04:56:03 -0700 (PDT)
From:   yexingchen116@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     viro@zeniv.linux.org.uk
Cc:     ebiederm@xmission.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Subject: [PATCH linux-next] binfmt_elf: Replace IS_ERR() with IS_ERR_VALUE()
Date:   Thu, 20 Oct 2022 11:55:58 +0000
Message-Id: <20221020115558.400359-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: ye xingchen <ye.xingchen@zte.com.cn>

Avoid type casts that are needed for IS_ERR() and use
IS_ERR_VALUE() instead.

Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/binfmt_elf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 72f0672b4b74..afd2d6f1c21c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1166,7 +1166,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		error = elf_map(bprm->file, load_bias + vaddr, elf_ppnt,
 				elf_prot, elf_flags, total_size);
 		if (BAD_ADDR(error)) {
-			retval = IS_ERR((void *)error) ?
+			retval = IS_ERR_VALUE(error) ?
 				PTR_ERR((void*)error) : -EINVAL;
 			goto out_free_dentry;
 		}
@@ -1251,7 +1251,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 					    interpreter,
 					    load_bias, interp_elf_phdata,
 					    &arch_state);
-		if (!IS_ERR((void *)elf_entry)) {
+		if (!IS_ERR_VALUE(elf_entry)) {
 			/*
 			 * load_elf_interp() returns relocation
 			 * adjustment
@@ -1260,7 +1260,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 			elf_entry += interp_elf_ex->e_entry;
 		}
 		if (BAD_ADDR(elf_entry)) {
-			retval = IS_ERR((void *)elf_entry) ?
+			retval = IS_ERR_VALUE(elf_entry) ?
 					(int)elf_entry : -EINVAL;
 			goto out_free_dentry;
 		}
-- 
2.25.1

