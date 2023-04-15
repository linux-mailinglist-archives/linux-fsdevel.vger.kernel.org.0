Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029026E2F8C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 09:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjDOHpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjDOHo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 03:44:57 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328E49019;
        Sat, 15 Apr 2023 00:44:56 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5191796a483so1160065a12.0;
        Sat, 15 Apr 2023 00:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681544695; x=1684136695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=jFOFwyy3sNBSjRqyH8M3Jqs/3hXDZqy8ajlKuvzqmJkgjkToo1Gjc0MAkYwRDoQyie
         yyc8BRv/p7of6b9bZHML22pTs/1QlJpZdgiQaJW9CwqgR+SEAWCYXe0G+xbq0d7+D44p
         Klpn4kESSoD9DmhBGURLb4INlfBzOX9+0U46Efp7U9OIiM7ye7ELHSJJ0zTD2/3fbNOh
         0e7lhEnDVIBXE1fEyOOkGTIZz6/Xe1zMoTu1ePMEfK+kIhKS8ndLrawjqHRT9/f/WfFh
         6olmKY2bxsyBx+lUKrinF/VsEYsacf1ywLKilq7hl7lnCZsKX95naIKOPq77RyR1qCop
         dgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681544695; x=1684136695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTMdTuJ1OD5jmTv0pV5ODd1Pf3L2FjXJKk2J+PBTNqI=;
        b=fCmNyukooK3e0MlAnxbHXKIbq0MTtBKjKI61uYz2aG+DCyelTDNGA2S96HXw7ymL5v
         v/yNs48tnAxYSCrHBqvGcPzg+EqvpOLa7HDQXl8WnzNqdrPAIMtUmMMksesevYzu2PlZ
         lXXyR6O2Pnd4QfmMwbVSZ3/MAmm5Mkrsy83dXpjA24qNpOEeKZno4/2xoNEOgM1w++V/
         C2LTL0ZQ5cenS24sJbhQWirtQoQVrAyE9CU0U38xdTgX4HSZMdD8TImgQyt+2AYX1vXo
         /9h187RRIHFDmQk91ZDTADd9dmX1Qs1uoVG7oJuRl8RY70rqE6VbU5cZT/toB+NzdY0M
         K3wg==
X-Gm-Message-State: AAQBX9exXaRjvgtmqg37Zy5mRU0Qr8W+GGAQAULFuncam+EiAPJxBg6m
        668IkZhSqXk9Fty0hVFB7ryfemOXUeY=
X-Google-Smtp-Source: AKy350b897C3EJIGHiO70O0YVw9HfkI1MNCBDSVe/WugbWQtSc7Wh3w0VdIHcQa5LE+rLzVEXYgQ3g==
X-Received: by 2002:a05:6a00:b50:b0:633:490f:a18b with SMTP id p16-20020a056a000b5000b00633490fa18bmr11676202pfo.23.1681544695389;
        Sat, 15 Apr 2023 00:44:55 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:2dd2:1827:1d70:2273:8ee0])
        by smtp.gmail.com with ESMTPSA id e21-20020aa78255000000b0063b675f01a5sm2338789pfn.11.2023.04.15.00.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 00:44:55 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFCv4 6/9] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
Date:   Sat, 15 Apr 2023 13:14:27 +0530
Message-Id: <afec2f43ce60273475c80f5c684cb1a4f2fa1699.1681544352.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681544352.git.ritesh.list@gmail.com>
References: <cover.1681544352.git.ritesh.list@gmail.com>
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

