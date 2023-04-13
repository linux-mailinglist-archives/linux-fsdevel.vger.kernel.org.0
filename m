Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530596E091E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDMIlp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 04:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjDMIlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:41:42 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CAE83F0;
        Thu, 13 Apr 2023 01:41:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b4dfead1bso66167b3a.3;
        Thu, 13 Apr 2023 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375293; x=1683967293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxlZLNEAIx+YLthls/vDAdHOCL9Iccp7lWdFeZ5TM8k=;
        b=JyGTSKCxF5cz6BLgcNYhgd6dvP/726iQ9KrZa/VYNPZFe+TSkEID9gTAG4zUhXmWO2
         V2aUcHgxyiFPZdTJsiPdBIoq+lQJwaHkt59pq7WCQvKWxTQMnvFIjtU9lCgAY8e8Ojue
         D609fHMcHBKQxLfhzLDxu4BPJ6Q5GDm0M6k2HnBRq7lot5F+V8fug1N9pkR/morrWeCH
         7VKq2daPLBWiF+IGjDIPVFv+xv7nvWJfi9pQ3grqP+lSmP032FcITua0aBIHu0QPphXh
         M9V1phKhjQYxjhJpof0s7hJ5C7GXgNTfdYflay0HdvY5/pKfZPGiulAjomKlOdW2DFf7
         u2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375293; x=1683967293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxlZLNEAIx+YLthls/vDAdHOCL9Iccp7lWdFeZ5TM8k=;
        b=AcBanCCLU4Ok8b05OZzaE+gWHB4dUHLyMYDf9ubwbkMTaIDguMyEfiErpmK1EjU2BW
         9AHUzeLZv8LgnEWAZ9KTWcnswVysN7Sl7WP9Jtebgx7CgxGO7dUlKq7VpQmrjg8DWern
         AkCvgp/1Gwuj+6iAi7kdpfFsaOq5hXTW5o6z7TPPZUuavu0H950GdC7/6dyjgJZSV3Ly
         w4yg1lqZo++mmnIj0cq4i6WTh95Dq+BJGZs7Mtt2UDnCMz8bNPurGcTutXB6U1d2Kagz
         ptihhKcYrAtQ1Cv4NCh++1z2zMEEtlYvprXAPK857v+p5Rp2NOvaCKndASpfDnWEJaKZ
         dNEQ==
X-Gm-Message-State: AAQBX9cVjX+fzt6fiaPyOMOebXQVT8m57g32PFBypvbgvyMkiJB4zHzJ
        NBkuAgFgmUfmYJJG0/LIVFmt/foc8Jw=
X-Google-Smtp-Source: AKy350Z3GFFyiKkPlVha5Ic6LQYdS2QdKYmNgR7FAV/hcVbVL2A3ssoHzIZXrxc3+3uFs/+JNu3/bA==
X-Received: by 2002:a05:6a00:2e9c:b0:636:d5be:982f with SMTP id fd28-20020a056a002e9c00b00636d5be982fmr2958434pfb.6.1681375293293;
        Thu, 13 Apr 2023 01:41:33 -0700 (PDT)
Received: from rh-tp.. ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id g8-20020aa78188000000b0063b23c92d02sm817243pfi.212.2023.04.13.01.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 01:41:32 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [RFCv3 06/10] fs.h: Add TRACE_IOCB_STRINGS for use in trace points
Date:   Thu, 13 Apr 2023 14:10:28 +0530
Message-Id: <1b57f3a973377392df1f1d02442675ac5fd0c115.1681365596.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681365596.git.ritesh.list@gmail.com>
References: <cover.1681365596.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 9ca3813f43e2..6903fc15987a 100644
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
+	{ IOCB_EVENTFD, "EVENTD"}, \
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

