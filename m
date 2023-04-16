Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF636E36FA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 12:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjDPKJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 06:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjDPKJ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 06:09:28 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E019B3;
        Sun, 16 Apr 2023 03:09:14 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id lh8so9761387plb.1;
        Sun, 16 Apr 2023 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681639753; x=1684231753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=KxowZcfjv7AC9b6QebS+yTXkkBqTFQ/4d4wvDU7rzezI+v2XQ9qZamT/QpHEPRIFa+
         VlIv06KcbCOAWLATTwi6NEpYekuq70mpmQOyCIF5mWWfcMd0yJYgkfOWUr/74HyMq6Po
         82rQtX8n70BUWeHqznFJdJa38HcERKD9zhsLeNIXGoOHrwpoNAc7aQ0GJbBVw2uwxWnd
         /kx5/78P5/mFNO5gl3njKtL9F8MyReaMKYgk/Ry4wi9d8eY9UxjcelmoK8I1auSG8u8s
         RUSmDgPSfe8K4Bnwqv/6SMxv8gFivIuQZwpxuY0fnFjlR1b5GhYpzIStkDuk0PvvKl4v
         jxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681639753; x=1684231753;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=cMSXj9jyZJguRQXC0uKdQ2Yh2nMJ9yTFoQkK1rRymsD5zyQ6+tj38073u2jqecJg3t
         wTo9Y8bzpc6fkX39v6CRnmLM0MhmM7tN/+hO8Uv/ybIhtTkbkfWpLKfBPAHBAgHvTk+d
         CV3Rh3x6Vehz+tnYrRPcmIA7Gsml3jZcioJS1+9vKUYdeHXUoe93JMFkE8K++USsMelA
         57snZqabNtxoLZIlK7wXx9e+lkRBUo8Lx5ZVBlmT04dXCagQvz5VHRRrt0IGWpfGp9Ut
         H9gQABN216yRugTi/xf6dxmqKbKw0qONYcKfopW0Mu//uFrhlD9+rF6k6aTJ3ksHu7fR
         fxMQ==
X-Gm-Message-State: AAQBX9d6cfBUDnRfvQAt0/c2T8Cu0wPhn/SAPsVkLIKrFAzyZ3nU2IBH
        taUrMvWmkW8Ok75rsUGyjrNonFUjP1I=
X-Google-Smtp-Source: AKy350ZBAB2Uo+KtuYCnvu8gJisnCFLWrOYBCEI30YYo6X3nT16bGienUv1qaayyPmLLnB1fPFNEPA==
X-Received: by 2002:a05:6a20:428b:b0:ee:f290:5b5e with SMTP id o11-20020a056a20428b00b000eef2905b5emr4895247pzj.43.1681639753194;
        Sun, 16 Apr 2023 03:09:13 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id h9-20020aa786c9000000b0063b733fdd33sm3096057pfo.89.2023.04.16.03.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 03:09:12 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv5 6/9] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
Date:   Sun, 16 Apr 2023 15:38:41 +0530
Message-Id: <d264d84cf81272540ac8b9d32f21f87a4318dfab.1681639164.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681639164.git.ritesh.list@gmail.com>
References: <cover.1681639164.git.ritesh.list@gmail.com>
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

