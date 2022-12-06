Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54F8644E47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 23:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiLFWAA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 17:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiLFV77 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:59:59 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1850932052
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 13:59:59 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso7486877pjh.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Dec 2022 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4sS3/Bfwt7TvEDXuu7/He/mgRn4IfxDIex6g4PACeMk=;
        b=pQO92IjQKB+SOGPWNMh0aE4nFKYW/Pn7ZUmkjc6/P+o83c6xL7XPGkrAZulj5NphgB
         Lij1XDxyRTjH5mDYKYtI0WFyLdUgQLunyYR6cQe/KQIUUfvNDrZWf7yjWgxeEscz0IeY
         pnXDqMvKu8dVpe2ItbrqisZY3O6L5+S6OsFvcV4qkZKhXoACvAFJQSKNoMOwWxy4Rczn
         sxJJvrDUIz/dNZRLF/o+U9fPFTW7Nc0wMeXzzXMQC4DqsOfB3HlwMo1iyHy8JuIXDcOZ
         RvU7vP0CUuNxQLGHaKAyN/MrJxVUw8cVtNXrn7SBIrCvJhq09ZuJf6zyWaVaxDVBFJFL
         0Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4sS3/Bfwt7TvEDXuu7/He/mgRn4IfxDIex6g4PACeMk=;
        b=cRBbEMEZhdLBX2QB2yQZq+68MchLugxG/t13o/R7J2ikAIbLwfStD0rKyN0hqfv4jS
         0MK1ZgVqlZEYXvlrGgHVinXsi1r89Pn8DOUgBX07Mpma8sgpkacezps3CbN9dpO5GVU3
         FPAD5CVjJVd5WYCDiax8vKo08eb51CUYGZ0LiHIj/r4zsRKhDo86+Bw5CBz7gqpwMcvP
         HqvNw6Jo05UVKBCb1F9eiWwc7lFyvIYgNSGS4ZXJwTN0UUm0rVaPR4GCJWYLgF52nZYR
         WprbHct72D0kfNWKWfI/lO/WL5Ot9zuBQi5nEC0r24NoPyJzj/14ehXQz/WUqyYjLeDj
         drWA==
X-Gm-Message-State: ANoB5pmloArxt23vAFHfv7cNfp/eqV61pJumHKoRJnRR5jqeLGMKYoLB
        3PHVQb9fbWxFy8FRqGgZTSJgFQ==
X-Google-Smtp-Source: AA0mqf44Vu6I5P1NQX0oOC74yAQp/ChdhSl8xuR6L0bGeV30BhGtFFrXa2TWloSLWpC+S5wd+U6ibQ==
X-Received: by 2002:a17:902:bd83:b0:180:87d7:9be8 with SMTP id q3-20020a170902bd8300b0018087d79be8mr84987371pls.85.1670363998428;
        Tue, 06 Dec 2022 13:59:58 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id iz21-20020a170902ef9500b001811a197797sm13055997plb.194.2022.12.06.13.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 13:59:56 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] epoll: ep_autoremove_wake_function should use
 list_del_init_careful
Date:   Tue, 06 Dec 2022 13:59:55 -0800
Message-ID: <xm26h6y8mbvo.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

