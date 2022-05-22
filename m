Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5584D5302E8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 May 2022 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiEVMIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 08:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiEVMIF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 08:08:05 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EE639BA0
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:08:04 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l13so14600133lfp.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 05:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:cc
         :content-language:to:content-transfer-encoding;
        bh=nL/dVGmV8SVJ8XY9T2y2Xs22TOu5OlKd3euuTOmb9S4=;
        b=dY9UcXK/oJMSJoYU12izmW/FnAYwMTMLETztr1WWz4D35LIy+rNOSlcLBClNMExUV4
         eHEeIEy+7ymmdgalKmq++LKhP+izXt0PfSl8q2zKMjp4O2exWq2yLZxkn8re8UVRiVIr
         oM5roUeyoU4kPZxOGlwqIyUf+anbiXuarA+i8RhdcGfZKwY2dPikHRkZokh7QyG28yHq
         LThHQM0PsCHxCAZDma4zPtDWmsgClF7dfUUo+G8Ji2OxnkKX9bNhVohFctjMBrviEv5Z
         qSP5tIL2QsZ7m3I/h2+XQ5zdb8bOkcgtVdg9v7G9Jvq7CHfciSKIxASYktFZXeHUzkAr
         uZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:cc:content-language:to:content-transfer-encoding;
        bh=nL/dVGmV8SVJ8XY9T2y2Xs22TOu5OlKd3euuTOmb9S4=;
        b=3p1vjelxX//cdq7IsYOFg6SBE5GnxeKYRRanyhIn0Uzf14LWmmdHNsr5h9N0qcGVSC
         b2pCJ5QDtU2UAMW4J0kxqH9US/jF9VVIdm1m+dAHmYBsuhSa5LQ8LQhrqOBmp58Aewtv
         em/SlxGZaRg57PQvstrQKCmFGUCxpqb1cpsKw7YwxsfZya/KDEi7L1goI72quFpvx0Qi
         Qg4dX4QvADTtHvkgseONHf0kwF6mlVlrxRkfC83N33WpQ8N6r8cb7sWnAQjGlw2SARK+
         al8EQts86EqtURDsWzv+nCHh2svQP39H2A+/ecO4Wh4/sFBXtru5ilGu5utuu1yZSiJG
         aP5g==
X-Gm-Message-State: AOAM532Z5JHQyA0ieEmVIQGzCn3GFqiAONQrkmMTnsIQQxVGamdlnslR
        tQgSuYw8aXiZpb7+eDMH4b5r1A==
X-Google-Smtp-Source: ABdhPJz4u143hIp4L2y7X/tAAADLwuCPw7Sg31/7fzUEYGRi6yX27/JAVA8CEjTrAmFDQdog8/Yeeg==
X-Received: by 2002:a05:6512:3c84:b0:478:19f2:bc2e with SMTP id h4-20020a0565123c8400b0047819f2bc2emr9440081lfv.324.1653221283073;
        Sun, 22 May 2022 05:08:03 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.185])
        by smtp.gmail.com with ESMTPSA id u1-20020ac24c21000000b0047255d2118csm1433942lfq.187.2022.05.22.05.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 05:08:02 -0700 (PDT)
Message-ID: <9adfd6ac-1b89-791e-796b-49ada3293985@openvz.org>
Date:   Sun, 22 May 2022 15:08:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH v3] fanotify: fix incorrect fmode_t casts
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparce warnings:
fs/notify/fanotify/fanotify_user.c:267:63: sparse:
 warning: restricted fmode_t degrades to integer
fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
 warning: restricted fmode_t degrades to integer

FMODE_NONTIFY have bitwise fmode_t type and requires __force attribute
for any casts.

Signed-off-by: Vasily Averin <vvs@openvz.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
v3: split, according to Christoph Hellwig recommendation
---
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index a792e21c5309..16d8fc84713a 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
 	 * originally opened O_WRONLY.
 	 */
 	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       group->fanotify_data.f_flags | __FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR | __FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
-- 
2.36.1

