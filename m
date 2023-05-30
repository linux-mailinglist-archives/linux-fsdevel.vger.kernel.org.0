Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C482B716C92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 20:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjE3Scf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 14:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjE3Scc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 14:32:32 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C06102
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 11:32:30 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a950b982d4so23305ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 May 2023 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685471550; x=1688063550;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sS3/Bfwt7TvEDXuu7/He/mgRn4IfxDIex6g4PACeMk=;
        b=TPlFY3sS6/OYtQC0ozjQX0WNPBenow76gDcaot3VOPiWXJp28K8qANb2lorHHtNNpe
         OmtD1fp6f3trSbPERXJVMI/JYQmYvk6JPsUNupn5kYtCjZR5e6eS9J8TzEOG0AmtGQ1e
         yyVO9HnELsEW83+88u52R4bXnAWQycG2VTbZVwjXDSNt83eF/qpiN5Bz93q9I+IoqrJG
         z3JwVOX7gveo2e/bH5IEkwLNevMcT6oP9+XU8mETg+JoYfQSpJAD0AQj2xbc9LRGFwK6
         b9oqbdNxSEwS3kX+R+iVX21hha4GenbVQO+ulbb5gGIpfSbiKyQVCd52vDppNuaYs4RK
         Flxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471550; x=1688063550;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sS3/Bfwt7TvEDXuu7/He/mgRn4IfxDIex6g4PACeMk=;
        b=j0v5z1GAysYpDkcERfh/lRjegkdl3fiT1VrLj3N0SZEXNBGujN/VX6yTxQ0/N0N1Ro
         mod8jJ8pPWLzB9GuCrt2YYRLEHVyje9t164kJsQKJDlw6wnlOAdXQpEMJm2m4vFPVe7G
         4KWXKKw3WWy3Du0ZHy9NTotGra9rzcGAv3vOglv/99fyr2DEUnhLMwBqtwlYUmcg7+SF
         S/SLv45r4k8+Y244hFjRU93D5LxsCFvc4GeORo/rFIUtzF4diColi5UiXP9fCRdtCEx/
         aARfAzdk/Ct0NytKkvyWS2X1Fy5wREanipWGwfr4QM5SKXGw+IFQRWds2t5MkhCBxkRg
         MXbg==
X-Gm-Message-State: AC+VfDwCpJH/3Zhenneso2WU1otb3MzfnQdhJZMbEeZ2L4W6U7Zj3nAS
        EXS565zoprZ+BRRHGLj2Q0B0RQEomZERiclJldwcus9M
X-Google-Smtp-Source: ACHHUZ4c0qVs/v1Z0x3arLpGG81NNp/nncDFmE5pavfGAXBP886zvP7ttp4FXvBVFE+cppUlk7XrFw==
X-Received: by 2002:a17:902:dac2:b0:19f:3c83:e9fe with SMTP id q2-20020a170902dac200b0019f3c83e9femr223100plx.14.1685471549929;
        Tue, 30 May 2023 11:32:29 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id w21-20020aa78595000000b0064d47cd117esm1972236pfn.39.2023.05.30.11.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:32:29 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RESEND] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
Date:   Tue, 30 May 2023 11:32:28 -0700
Message-ID: <xm26pm6hvfer.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

autoremove_wake_function uses list_del_init_careful, so should epoll's
more aggressive variant. It only doesn't because it was copied from an
older wait.c rather than the most recent.

Fixes: a16ceb139610 ("epoll: autoremove wakers even more aggressively")
Signed-off-by: Ben Segall <bsegall@google.com>
Cc: stable@vger.kernel.org
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 52954d4637b5..081df056398a 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -1756,11 +1756,11 @@ static struct timespec64 *ep_timeout_to_timespec(struct timespec64 *to, long ms)
 static int ep_autoremove_wake_function(struct wait_queue_entry *wq_entry,
 				       unsigned int mode, int sync, void *key)
 {
 	int ret = default_wake_function(wq_entry, mode, sync, key);
 
-	list_del_init(&wq_entry->entry);
+	list_del_init_careful(&wq_entry->entry);
 	return ret;
 }
 
 /**
  * ep_poll - Retrieves ready events, and delivers them to the caller-supplied
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

