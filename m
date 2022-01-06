Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0002548684A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jan 2022 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbiAFRTy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jan 2022 12:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiAFRTy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:19:54 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABBAC061245;
        Thu,  6 Jan 2022 09:19:54 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h1so2909620pls.11;
        Thu, 06 Jan 2022 09:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2b/20xiMTEmtimxOT1Bzfz18t2DbkOsAhWklByj61+4=;
        b=Tkmd3CiWT/pLVRsCGoObyBA6LGVVvMuE1vw6Neso3hyQbfl76BMOo7s1S2esVqznK1
         BiG2BueQuqQAX98X/1poE/bJ151CtuQIevAJpof/uO6Sb3b08WobMOGKurt0Y/CY9M2y
         f6cjprwbKYZDCWFLCVntwj/xw4fY6Q23QXrH3VIADsbEpKcAFIOH/CvOqqr5aHW213bR
         Ci39e3pOJHo6qRgbTbZOs8wZ3oiB2oK5PSSXPsHNxvJF71a2badysf6MJTneWNrL6WTA
         kt4wAOZAATG/QzlMo7lWciQQqege6Suvns6Xm3HWc3C8l41TP9pB2oJLGFlODW56REXN
         d3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2b/20xiMTEmtimxOT1Bzfz18t2DbkOsAhWklByj61+4=;
        b=V00GQ41M4k6UiAaX/VaYUUSAqh2UxUWT6myHsHZiOLAdFg7+Mm1UZfcS51U1s3NjKK
         lvI1D8O/tqlNDFQcLgrALsONfWh/xiBCLEUUyarFulUP3ZIBGIH1J4WQGGIaib0J8MYQ
         ezOQTILhW/HsfBUXl86F5BaSy7sTmLBMAU0QQDNXkKJ5YbPEvpqcaY0ScPAsZgQ3NG3g
         xXqMMNKOhqPuxHGJG2KGxGxiugJ1I+I53OqDk2Xc9nBhe4VIfofTmwK4uuaC7c9sAIhZ
         eGjtJ0UUX3lrNotVzRo4fYILsdoroCCClvRfPNPR+OvryhPo3YnkwaudOleKcvfm4JVS
         G39Q==
X-Gm-Message-State: AOAM531l/qVDOPvysT+6HHYA3l32f76ctrU/SrQbRPpBhMPDLV0O90DN
        oCC30tvXUp492g4YWf2ajrqhQEMCmdc=
X-Google-Smtp-Source: ABdhPJw5hjCfSx/QUZdiJEVCEI+C9od2l9CHZvZ4A6EzxMUlcYZc60Urw9PIaRqF3JnSWfMSmkUIYQ==
X-Received: by 2002:a17:902:9698:b0:149:b7bf:9925 with SMTP id n24-20020a170902969800b00149b7bf9925mr22337460plp.49.1641489593433;
        Thu, 06 Jan 2022 09:19:53 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:8500:5f14:bd71:fea:c430:7b0a])
        by smtp.gmail.com with ESMTPSA id z2sm2510744pge.86.2022.01.06.09.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:19:53 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH] fs/pipe: local vars has to match types of proper pipe_inode_info fields
Date:   Thu,  6 Jan 2022 09:19:46 -0800
Message-Id: <20220106171946.36128-1-avagin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

head, tail, ring_size are declared as unsigned int, so all local
variables that operate with these fields have to be unsigned to avoid
signed integer overflow.

Right now, it isn't an issue because the maximum pipe size is limited by
1U<<31.

Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Suggested-by: Dmitry Safonov <0x7f454c46@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 fs/pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 45565773ec33..b4ccafffa350 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -605,7 +605,7 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 static long pipe_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct pipe_inode_info *pipe = filp->private_data;
-	int count, head, tail, mask;
+	unsigned int count, head, tail, mask;
 
 	switch (cmd) {
 	case FIONREAD:
@@ -827,7 +827,7 @@ struct pipe_inode_info *alloc_pipe_info(void)
 
 void free_pipe_info(struct pipe_inode_info *pipe)
 {
-	int i;
+	unsigned int i;
 
 #ifdef CONFIG_WATCH_QUEUE
 	if (pipe->watch_queue) {
-- 
2.33.1

