Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05306EA781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 11:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjDUJre (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjDUJr0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:47:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C9B75F;
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-63b5465fc13so1728818b3a.3;
        Fri, 21 Apr 2023 02:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682070406; x=1684662406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=PCpIrgqZCUGRN3JcfgVN6Hc0kkp1kIA2jwFZwWobvN0EOHw+fKdvaMlMKS/FC8WOj9
         z1iTB/2s7eAYb1WDBDZSfqOIaC5LPv2G8bbSNjNLbTUvld71hMxCHk9C3gYvvFzbkYfi
         eeixEw6HfJzPcKGjyiiO47FWSJwYSNnl8C9K7CXbkRFAvY80VqLZZZfTp7HYF70mGFIN
         b7SBqSfl5vN/Je8tZcvD1NDj+i9Kd4P+i8Mhsr6KCLf09Wvhy4jp8aG9UN11L5cQ15US
         ljN0r920G7Ju9J8WG9d6X5pDo7dTvXGRWN843Bpxbfgaol1fDnDQIk6lXoul1FVJk21L
         DYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682070406; x=1684662406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=K8S2qCl1Jz92pQlPGHv+lW8e1EXbK7USg+EuqDwhRz9JQ4FcP6x3S6hj/oXGyYkd8V
         dRg3kEuoS/XHCqZe3d9rQaiveVtne4sO5+dQ0p9GmF4h9pHBSvyMzZUf+siCzZlcShWs
         OiS6Qm0FvrLORyexnlRyub7TCHtRnCPKJe5n1JBh/PcAB5Ef8jC+dGD8K3jqieqFwLHb
         8WADSW9JM4viuNnD1V3Qqc064IrsPq2M6t4sG5OQ4C0lNPExewl10vWlLQQ7TyMSw7m3
         XyqohOEE9D3qnxkggE2vGUvty8l/p0hDU5r3eG8vNvnZ60DAqIt4OTqZR4NWmLDcGhsu
         b0Bg==
X-Gm-Message-State: AAQBX9eKlxaeNbk1CHzAK706GYVgPFTw3+q3JZCGCq+gPhm2ojpjXwe0
        QUzbYAOefwxo63RPHBsaSJGDrbnFB+g=
X-Google-Smtp-Source: AKy350Y9ErCRIGLg0ao08klwZpqdmwaM2uiBZqox9cGC7juPf2ES2immQ0msql6qQHIGLQDV7W+gJw==
X-Received: by 2002:a05:6a21:6215:b0:ec:6039:f76f with SMTP id wm21-20020a056a21621500b000ec6039f76fmr4458792pzb.11.1682070406658;
        Fri, 21 Apr 2023 02:46:46 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:8818:e6e1:3a73:368c])
        by smtp.gmail.com with ESMTPSA id w35-20020a631623000000b0051f15c575fesm2295376pgl.87.2023.04.21.02.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 02:46:46 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv6 6/9] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
Date:   Fri, 21 Apr 2023 15:16:16 +0530
Message-Id: <12576fb7b6a9720cc1d5659e95beea948c27907b.1682069716.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1682069716.git.ritesh.list@gmail.com>
References: <cover.1682069716.git.ritesh.list@gmail.com>
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

Add TRACE_IOCB_STRINGS macro which can be used in the trace point patch to
print different flag values with meaningful string output.

Tested-by: Disha Goel <disgoel@linux.ibm.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/fs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index c85916e9f7db..bdc1f7ed2aba 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -340,6 +340,20 @@ enum rw_hint {
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
 
+/* for use in trace events */
+#define TRACE_IOCB_STRINGS \
+	{ IOCB_HIPRI, "HIPRI"	}, \
+	{ IOCB_DSYNC, "DSYNC"	}, \
+	{ IOCB_SYNC, "SYNC"	}, \
+	{ IOCB_NOWAIT, "NOWAIT" }, \
+	{ IOCB_APPEND, "APPEND" }, \
+	{ IOCB_EVENTFD, "EVENTFD"}, \
+	{ IOCB_DIRECT, "DIRECT" }, \
+	{ IOCB_WRITE, "WRITE"	}, \
+	{ IOCB_WAITQ, "WAITQ"	}, \
+	{ IOCB_NOIO, "NOIO"	}, \
+	{ IOCB_ALLOC_CACHE, "ALLOC_CACHE" }
+
 struct kiocb {
 	struct file		*ki_filp;
 	loff_t			ki_pos;
-- 
2.39.2

