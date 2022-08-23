Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DC259D0E2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiHWFzG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239864AbiHWFzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:55:05 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D75072D;
        Mon, 22 Aug 2022 22:55:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r69so11389107pgr.2;
        Mon, 22 Aug 2022 22:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=lE4zJKGK5ufDTdByQbany0NxSjQhvKLLUTqV6VW29nI=;
        b=cenQlbBwYrY/Bcb7h/cEeGbJUnpnDCu1SbkqjuhF+S+0s8AlQoUKudxKXaKMxJTNBK
         0o3C6sd+8/fiQAQDOkAiYjte5nZGjp0a+wE/+/GuGI60KQFjvuHvcciQQdQKmvQFJnBM
         sa4K9sf2MHOg0Oi7WtOkaZMXTMVMTzRRbhZBFMkszMoWh7zoQUN9mXmo33XN71f0I1Qw
         srfAtqyii0OgXHcZOirjlANsoqfAvqlIiw7sBeUXmt9VENsSR37FjyyFZyQTcRmGZNwI
         Na9Ob2+/fpFBzdZGVxrv6848dVTZCj7tBbg4cj5RDpbdOJB76plgaC5vtdk/LzVgVesm
         eHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=lE4zJKGK5ufDTdByQbany0NxSjQhvKLLUTqV6VW29nI=;
        b=SycnuLTatJ3GAYrsi3loQaWXZBHKdiO5Q7JF47EPS/RcvldMM5MWHPRbEE1alR2EYi
         dIPhh15QzowrbeCqgmjf5n9be6z9LSfYUlERUB3UZ33LKqgAKblFuypI90ICt17KcVI1
         z7GWzZMUcfBQ6u+daUCX9WqPjLXd9h2QCxNSfo6rbBGIbUh9HS3qVGoZrWUO1obdbaBs
         9pRW6wNrW1qaHJTlM8fb7LlnLtKBtFWABmyBMLP1Mfj6PYotVmmkWH/EjwcVwdd98KFZ
         2kajD02zef9ye5Jh1SZD6baH5lNkSPVVSlEuuY9yARUpp+ZNB3ksvFa9KSDs2WYUK4Iv
         R52A==
X-Gm-Message-State: ACgBeo1p5RM4LnzkYz0ViUCRO44Zd8Lz21MEfmLTNkMX+H+2H+h0xl1c
        K0t+nkKx8H2C1MgK2KDmuGBABiwQrNY=
X-Google-Smtp-Source: AA6agR47DBq74RT643R1hTcVqVmmFRYjijJq0VD9j4Hq5h6jEcdBU8ZyB8iWSqazAoEuAybzmHfDUA==
X-Received: by 2002:a62:1c56:0:b0:536:4f4b:d99e with SMTP id c83-20020a621c56000000b005364f4bd99emr13850296pfc.64.1661234103876;
        Mon, 22 Aug 2022 22:55:03 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id s8-20020a63f048000000b004297b8cd589sm8320109pgj.21.2022.08.22.22.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:55:03 -0700 (PDT)
From:   lily <floridsleeves@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v1] fs/coredump: check return value of dump_emit()
Date:   Mon, 22 Aug 2022 22:54:37 -0700
Message-Id: <20220823055437.1450407-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Check dump_emit() return value to see whether it fails

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 fs/coredump.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae202109..4f51bdcecc5e 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -762,7 +762,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		if (cprm.to_skip) {
 			cprm.to_skip--;
-			dump_emit(&cprm, "", 1);
+			if (!dump_emit(&cprm, "", 1))
+				goto close_fail;
 		}
 		file_end_write(cprm.file);
 		free_vma_snapshot(&cprm);
-- 
2.25.1

