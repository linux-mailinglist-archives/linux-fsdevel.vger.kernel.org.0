Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B76DD18D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 07:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDKFWp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 01:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjDKFWk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 01:22:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CDD272A;
        Mon, 10 Apr 2023 22:22:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h24so6923512plr.1;
        Mon, 10 Apr 2023 22:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681190549; x=1683782549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4dSPNE3Doov2vjKV7WUgwllOPrKHYZmVcXEsUSEDqE=;
        b=ZBwRputxVnrrh9nkhVvx622zvApJ3pZF6BIPu8U/Ti/I+ODOA8YauWahUPQ5eRlaZV
         wLUhIa8V7lXhnH7aR/cUKq6hmbG7fwzV1I57L89r7HkmlaVIdgA02eBxxLg4xa2pPZzB
         zXJ4U5pFhjIb2xMzzYOV6olqJtbf2UD4DjDzrCuHbxpDdWx8x01dLL6L8IshV8y6bZX6
         iH2RWA8WZLWg+K8lWhyFlJx48voO21OaeIeQTpnMAKZmr0DDbohPuibhfOSDHLC6fqYr
         lLtPZqw5Lz9czGSqEJvvjkS6ZOBtPFtiEE6A2cdamdCJP38zrM0+YfDBR9LJJf0PD0zg
         j2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681190549; x=1683782549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4dSPNE3Doov2vjKV7WUgwllOPrKHYZmVcXEsUSEDqE=;
        b=nye6AH515EVAm8szsJWPF7iQ2I3Ixyi4U4TwscMyG0S0xDuSoS4WTHvwgaswCQrueN
         u+Vtg5jBGHt/excq2BwVXPRFvdn6pwyzpNpNhlCTNsZFbbw82BNE5QmATU0EziW8zLEs
         +/qLE+k1hDpu91OqJjGdPuap7BrygW1VacpF+ZHzoVlSdM0ZtSQgTgeQCcvO5ChnxgH+
         LvVX7/ysJQZwNMjrix1W16taXhDcl7I99Cj99D3W21wUvHLACII4xyV3TAQ9fRue/BO0
         6oSsvSrhra6Qd31eNUp+RuJC75Ypg7K36Hdhh1lo58SNOf/vYy43foSU4MsZrnb5b1+Y
         7Alw==
X-Gm-Message-State: AAQBX9d5RW0fMNrfuSnhYi04Qz2wkUkb4V3BeChvyytt5VMCUhY7KWlX
        /d2pxEs6bZq4fQyBaRN+1fkTNNYkV98=
X-Google-Smtp-Source: AKy350YOEfxGE1KJtXfmR9igT+vpkwMbgKkfSWMmvzWYRDBCp05ffZk6w2ybAE0WEn2qjdg71askgw==
X-Received: by 2002:a17:90a:1953:b0:23f:7666:c8a1 with SMTP id 19-20020a17090a195300b0023f7666c8a1mr2177550pjh.18.1681190549237;
        Mon, 10 Apr 2023 22:22:29 -0700 (PDT)
Received: from rh-tp.ibmuc.com ([2406:7400:63:7035:9095:349e:5f0b:ded0])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090abb9300b00246d7cd7327sm646154pjr.51.2023.04.10.22.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 22:22:28 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [RFCv2 7/8] fs.h: Add IOCB_STRINGS for use in trace points
Date:   Tue, 11 Apr 2023 10:51:55 +0530
Message-Id: <d02f3e41ef7e2af88640cc8d4403f54530942776.1681188927.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681188927.git.ritesh.list@gmail.com>
References: <cover.1681188927.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add IOCB_STRINGS macro which can be used in the trace point patch to
print different flag values with meaningful string output.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/linux/fs.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21d2b5670308..496159869af1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -340,6 +340,20 @@ enum rw_hint {
 /* can use bio alloc cache */
 #define IOCB_ALLOC_CACHE	(1 << 21)
 
+/* for use in trace events */
+#define IOCB_STRINGS \
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

