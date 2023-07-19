Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64347594E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jul 2023 14:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjGSMRl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Jul 2023 08:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjGSMRk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:17:40 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7B7E5;
        Wed, 19 Jul 2023 05:17:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fd0f000f91so2891145e9.2;
        Wed, 19 Jul 2023 05:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689769057; x=1692361057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aqMjhx36/qsRqmm9s0dXSO/evM4+sGU1PIfLMOXcEo=;
        b=R+ari2l89cCalb3+6TZkzJrBv6676JTcoIFYBjnuSyoRhbOtNe57J7wuIX/N/bN0/n
         jA5hAgiFpwFafDgfMQtqqPFMC8XVmiRPO6+3hIv7k2x/zjEJ4ggZPuEd/ZStDPEJ8iDU
         s0YCUIYmWrJXQ0zBxhAMjD0cSzigF0Ctdn8dt31blo02nKpMroJ1gENziHfmDUfUIPcc
         6Taa6GtOESUI0BIHUEqUHgNLC6y15zepWaXVJghJQuSEhws0Pw/2d1o0iQ3hgoAfFxrk
         iOqUqWYtWz4eObFa6311R3wm8inHO/Br37UeuTHnrLSeYWtpB4erGHLfkb+e2qFjQaIo
         0K9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689769057; x=1692361057;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aqMjhx36/qsRqmm9s0dXSO/evM4+sGU1PIfLMOXcEo=;
        b=bsuOE4xX5sEaSJxfvf2/bjId0G7MVUzsBP6WoJbLe2x+gsF06JxLgVau92w8f8TXzM
         fAFSuCfz+xG7m0RSviGQkm0krXNS+kyHhurxYgnOGuB4JVaF2rrYa2KBZOtibfBo+3OZ
         nlxHo8mlGIVIhmrvnEIfIV2CINpEB1fitnQMKLI2JuIFBDgAmNiICzNdscbdoq+Yfc2W
         oZO5OGOgZj0Hd30YzZb6Bf4kZzH9TvLFsQBxsIfZOC1Y45QAbyoTJx2OTryqb+OcHfhL
         oO9kOddq0CxzjZWDVX4KU4DBaGqRlkV23AqzpkVc2eDHnlK/4X0htXp5fPTO1b0rRo3J
         rVSw==
X-Gm-Message-State: ABy/qLbYaS7ff8OhIXHFk1iVcwVlbiMCmtP89xaPAf+5Q2f/1MdMx25T
        B5tPQw/gjmOYS01zPbNtZn0=
X-Google-Smtp-Source: APBJJlEMLW8USslKCQ7vAH+PZY40i51w6PKWkoCFFKfn0x/Jz2zMTePXB+T9jCJhR2itd56/P09U9Q==
X-Received: by 2002:adf:fcd2:0:b0:313:fdbb:422 with SMTP id f18-20020adffcd2000000b00313fdbb0422mr4421498wrs.43.1689769057336;
        Wed, 19 Jul 2023 05:17:37 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fc3b03caa4sm1947785wme.0.2023.07.19.05.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 05:17:36 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        linux-fsdevel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: hfsplus: make extend error rate limited
Date:   Wed, 19 Jul 2023 13:17:35 +0100
Message-Id: <20230719121735.2831164-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extending a file where there is not enough free space can trigger
frequent extend alloc file error messages and this can easily spam
the kernel log. Make the error message rate limited.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hfsplus/extents.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 7a542f3dbe50..3c572e44f2ad 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -448,9 +448,9 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (sbi->alloc_file->i_size * 8 <
 	    sbi->total_blocks - sbi->free_blocks + 8) {
 		/* extend alloc file */
-		pr_err("extend alloc file! (%llu,%u,%u)\n",
-		       sbi->alloc_file->i_size * 8,
-		       sbi->total_blocks, sbi->free_blocks);
+		pr_err_ratelimited("extend alloc file! (%llu,%u,%u)\n",
+				   sbi->alloc_file->i_size * 8,
+				   sbi->total_blocks, sbi->free_blocks);
 		return -ENOSPC;
 	}
 
-- 
2.39.2

