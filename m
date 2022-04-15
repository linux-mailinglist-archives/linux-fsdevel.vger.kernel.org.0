Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD6E501FCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 02:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbiDOAw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 20:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348305AbiDOAwz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:52:55 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8E59D07B;
        Thu, 14 Apr 2022 17:50:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so7229552pja.0;
        Thu, 14 Apr 2022 17:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7qFU3NnrdLY0FuN4koKNS9V3uA2/Asco9ivOOjqnBs=;
        b=EG5/gJNR4vY4Ttvbs73oI5gwZIFdQ12qIYnhQJPGDSfo9F0xiaN7hr7YPe9Sk3VOvf
         AIJOM3DK2prO/8A+DbgVj8l3HdwXWKEigZACGaNLBkzNZ3kKJyfplhhhYuRYjHEJ0xsJ
         gLweAiE3tPly0putKtMBVMwRizHeyFDNuv4aADnqp0ZSxAwXV0YT5qcmKjJGonTDMJqu
         DjHl/rBxB+ICAI47MBPlQ9RBx1V1l0cPJhCz5Po5bIqffFqPYFceH+bwywp3dxAavlpB
         OPsKBA78GBzowORKtastHvjCRmb2nyNXelCkNte9T05Z+xlLhmuxw/J5iEJjmdUap5ba
         Yc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M7qFU3NnrdLY0FuN4koKNS9V3uA2/Asco9ivOOjqnBs=;
        b=KhUNIa2FTbRNfdj2aEfUAOtsWzCHpC9lNE3A0wWJYT0OI+nHUceI4pc9Si4Sk2SkKg
         6T7K7xovx8sV3ZRN5Gwd/MAApxNY2oXIyKRo82/kVSXQ80qVvBNnrUZIWY89u3efOeTe
         cBrutz6zFNVBgT4rxYMcysMFqYnBu3h+F8s5m3a5EiMugj54+PsTMt0amf6Jo/7eFG/K
         uhnIApAhj4isYg/qBNRzZAVArBI2X4G8UKv4QSDEfrTB3izG2rUwGDkekLA8bfZQXigP
         WDn2ouSt4XAT0D6oC+QWnqIssom6GBMksYi7QZCBFLfB7tNKr0m5X4KyJtzPmy4/T3is
         N4cQ==
X-Gm-Message-State: AOAM533eqU8pVZUXqGKq3Z+lQjQEGFwAMz8TgDKAZJMSgYUXbM7QINi9
        nC09+2Pqu8jdXp4wEDvJfgslabWF7qc=
X-Google-Smtp-Source: ABdhPJxHP4H8iPrjozDQ5gCufQPEuxWsnLf1+yxohn0fa/ZGsGvocxAH8MK4xIvCtRr8RdqR2vQvEw==
X-Received: by 2002:a17:90b:1e44:b0:1cd:c300:8ff8 with SMTP id pi4-20020a17090b1e4400b001cdc3008ff8mr1318294pjb.221.1649983828527;
        Thu, 14 Apr 2022 17:50:28 -0700 (PDT)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:bd71:fea:c430:7b0a])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm2921779pjx.42.2022.04.14.17.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 17:50:28 -0700 (PDT)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        stable@kernel.org
Subject: [PATCH] fs: sendfile handles O_NONBLOCK of out_fd
Date:   Thu, 14 Apr 2022 17:50:15 -0700
Message-Id: <20220415005015.525191-1-avagin@gmail.com>
X-Mailer: git-send-email 2.35.1
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

sendfile has to return EAGAIN if out_fd is nonblocking and the write
into it would block.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: stable@kernel.org
Fixes: b964bf53e540 ("teach sendfile(2) to handle send-to-pipe directly")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/read_write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index e643aec2b0ef..ee59419cbf0f 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1247,6 +1247,9 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
 					  count, fl);
 		file_end_write(out.file);
 	} else {
+		if (out.file->f_flags & O_NONBLOCK)
+			fl |= SPLICE_F_NONBLOCK;
+
 		retval = splice_file_to_pipe(in.file, opipe, &pos, count, fl);
 	}
 
-- 
2.35.1

