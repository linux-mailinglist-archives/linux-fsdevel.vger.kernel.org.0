Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB56C605B02
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 11:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJTJUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJTJUw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:20:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3816FF26E;
        Thu, 20 Oct 2022 02:20:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id bh13so18677999pgb.4;
        Thu, 20 Oct 2022 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lE6Lj+s17AGERDULG36HKSoQs/IM2VqC9skcKKUuohw=;
        b=aXTQ2ssE/G9Hp/de0VbcCT7sbCyrpcl9D4nMOGtl5M3e/VUGGXchqs4l9xKck2/A9O
         STarcVVTRh5No7i6GvHCI+klzbNUajy0zm00X4SYiZETuouOcfqICG9muRsRCH+oSe59
         lwkRYUIWnaHgXm48hbzKF0VKWYcwQ85ykUBKWr3kwAd1GIE7en+rxmwh4BSb6oqECZGB
         UrylPxWKQSb6nOpgXi3zgVnREEYh4EhvbakhGV6+ldNbYAy4S8lV4wqgZpdIr07G6g/C
         dhqW/Ye27MpwoZB23afPtVJ0LAU8ZnEGNo4Bt+0FITU+3V3VykerLHoOoHSnspQEPZL2
         psrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE6Lj+s17AGERDULG36HKSoQs/IM2VqC9skcKKUuohw=;
        b=SXrHn8AD7dYFmIVydKSXHXtXtKxhB5V8PCpbAWgIbS0e8cJ7THbD+6jMC/RE4SN9eH
         Ud7/AiWK4aD761MnZPsg2XqGfCq7gGIy5v1wN4W7AVPdU7wBmP2/g9zNVq5DnjD/1APP
         HG26LiWA5e3joBnbd4ZekM0Fl8hWu3I9a93WyxDqpK+BTdRmPAR7NI41wR7BC9gqFSFO
         UbqhvfpFgnQrg3CmaJTxX72FSyMFG/3oSVY7/pLVoHEbgDF0pc8PhK4CKQdr6RF2rfKY
         bko2C35u4dqZGEKBrwr+nJrU3zX6sc47BcQB57IxDtGfQjUytlt2jkdTGXQBjySrPf33
         4/Tg==
X-Gm-Message-State: ACrzQf00JnxUTeL6Keg9QXT2FW5iYeTJfGKVTKPayyn1KnRozcodSXPl
        fztTZ9d5RobbGo4ahZGlGuQ=
X-Google-Smtp-Source: AMsMyM7voFmOKMwEJQf/Xl7ei3P6EWZyi1mW1DeqcCJwCqysX40mxjee5bIKHnVqt+fwwnnZPMm3Gw==
X-Received: by 2002:a63:2b41:0:b0:46e:9364:eb07 with SMTP id r62-20020a632b41000000b0046e9364eb07mr2850156pgr.46.1666257650692;
        Thu, 20 Oct 2022 02:20:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p189-20020a625bc6000000b00562e9f636e0sm13353704pfb.10.2022.10.20.02.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:20:49 -0700 (PDT)
From:   cuijinpeng666@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     akpm@linux-foundation.org, liushixin2@huawei.com, deller@gmx.de,
        cui.jinpeng2@zte.com.cn
Cc:     guoren@kernel.org, wangkefeng.wang@huawei.com,
        jakobkoschel@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] fs/proc/kcore.c: Use strscpy() instead of strlcpy()
Date:   Thu, 20 Oct 2022 09:20:44 +0000
Message-Id: <20221020092044.399139-1-cui.jinpeng2@zte.com.cn>
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

The implementation of strscpy() is more robust and safer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 fs/proc/kcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 71157ee35c1a..47b9ac9229dd 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -421,7 +421,7 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 		char *notes;
 		size_t i = 0;
 
-		strlcpy(prpsinfo.pr_psargs, saved_command_line,
+		strscpy(prpsinfo.pr_psargs, saved_command_line,
 			sizeof(prpsinfo.pr_psargs));
 
 		notes = kzalloc(notes_len, GFP_KERNEL);
-- 
2.25.1

