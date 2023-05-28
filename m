Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2AA713BCC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 20:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjE1Soz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 14:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjE1Sov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 14:44:51 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979AB1;
        Sun, 28 May 2023 11:44:47 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64d1e96c082so1923580b3a.1;
        Sun, 28 May 2023 11:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685299487; x=1687891487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyjlDSIQffiBz94m+7qOi6jUFMwLIf/LyrTK9DsOjUA=;
        b=Un9DHhM8TW3EHQq43OAA0Ogd3lKDCjk40R7E2SKFoH0vJxv9UdeDIFWBxL66SkMdaU
         X3z9UxahVzY8yK3w1sPAcHVzArfQy6EvitNCRL5PeRn24pF2LcOSnS/pZ6t0R2+ycor8
         rvGEDN6tJtAC7si/wvow8iNmQXDYhWNr+VoYUDOP4QDosm6niKgufq4eBdmx9SDrmRae
         GdW0O86XeoIERzdhrPzQFLzFaLpxY54wZiPTDsGOpE3rR3Rafki6LmC5NO++/4wXEfJI
         8+HOCRTQVqqn5BtL8bUyD0n0fWEfY2q663fXaPQOOy1JfowlDKnKWI6W/BamTyk2lmYR
         rLlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685299487; x=1687891487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyjlDSIQffiBz94m+7qOi6jUFMwLIf/LyrTK9DsOjUA=;
        b=gWki0U6z7xx/5Znf+IEnCCXzD/0qTKeZ9o+p+UNNHuZNmozxlZa+hGfAJOc4sJOwFk
         1uqZLiRueTYVJMP5Zv/PhisSGNoBBnxO1Yu6xnS8Xndxgl52UXvz/EFrKcMMX0OyDGWi
         culzwrU9kx7pJvWZ+z/OU8m8mYCqKf/V8ANR+REYItmAaEg+CGi50TM4z/pPBcFwNBje
         ngiqAnkEXUuL37nbYT0bx54suUDy60cvcL93k2rVJgu1Zz2/VOQhCPjuneBWd7qSJ0sf
         31hx9YZfIXa/7tTWSKZ4ym6G+v2S3Ad2K8Ak/2Ftx8kkHoD6FnSjyfOElof1VkDTuVmR
         ntJw==
X-Gm-Message-State: AC+VfDyU74pKcNWsZGqyFe+7ET/mpcmPARwgXGgy3p5er45pHb0B5ksW
        DNiDebJ+qh7JnV0J+EqfWWQ=
X-Google-Smtp-Source: ACHHUZ5zW/1h08AQmHowCqrrh1SxgfsI0UBae44jNzqPq2Ab3Ujo7WM8MI5PGX9oSiEstous+gZbGA==
X-Received: by 2002:a05:6a00:170b:b0:64c:c5f9:1533 with SMTP id h11-20020a056a00170b00b0064cc5f91533mr12576431pfc.33.1685299486709;
        Sun, 28 May 2023 11:44:46 -0700 (PDT)
Received: from fedora.hsd1.wa.comcast.net ([2601:602:9300:2710::f1c9])
        by smtp.gmail.com with ESMTPSA id i18-20020aa78b52000000b0064d4d306af9sm4155893pfd.79.2023.05.28.11.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 May 2023 11:44:46 -0700 (PDT)
From:   Prince Kumar Maurya <princekumarmaurya06@gmail.com>
To:     skhan@linuxfoundation.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chenzhongjin@huawei.com
Cc:     Prince Kumar Maurya <princekumarmaurya06@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org,
        syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Subject: [PATCH v3] fs/sysv: Null check to prevent null-ptr-deref bug
Date:   Sun, 28 May 2023 11:44:22 -0700
Message-Id: <20230528184422.596947-1-princekumarmaurya06@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <000000000000cafb9305fc4fe588@google.com>
References: <000000000000cafb9305fc4fe588@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sb_getblk(inode->i_sb, parent) return a null ptr and taking lock on
that leads to the null-ptr-deref bug.

Reported-by: syzbot+aad58150cbc64ba41bdc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aad58150cbc64ba41bdc 
Signed-off-by: Prince Kumar Maurya <princekumarmaurya06@gmail.com>
---
Change since v2: Updated subject and added Reported-by and closes tags.

 fs/sysv/itree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/sysv/itree.c b/fs/sysv/itree.c
index b22764fe669c..3a6b66e719fd 100644
--- a/fs/sysv/itree.c
+++ b/fs/sysv/itree.c
@@ -145,6 +145,8 @@ static int alloc_branch(struct inode *inode,
 		 */
 		parent = block_to_cpu(SYSV_SB(inode->i_sb), branch[n-1].key);
 		bh = sb_getblk(inode->i_sb, parent);
+		if (!bh)
+			break;
 		lock_buffer(bh);
 		memset(bh->b_data, 0, blocksize);
 		branch[n].bh = bh;
-- 
2.40.1

