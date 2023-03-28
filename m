Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2F56CC95B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 19:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjC1Rg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 13:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjC1RgU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 13:36:20 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D40BDD5
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:19 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id v5so4149647ilj.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Mar 2023 10:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680024978; x=1682616978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUQpl1oWFdL7IxlxYgl03xOfPQkkFY7MMHFgeypc77w=;
        b=ER3LpRgsniOjcjFAHTBdUrXrZvGP68K999Rxb4KF5++9cPbmpkf6E9nBIuhG9Jpu55
         YSHxAQ47Sio50ltVAtcaatFGiR48+k3NwaeyIHxf7EhDLVpkqmBILE7WYoKu6iCvo2Sx
         GOs9uVn0avXHjttE15SAY6/pp5YAf+mg2LKSSBpK/ULFlYu7+TgmPtLC8q1Tjd9QtFSa
         KJVoKSi7arQWFU7t6TjKeikbw5/N+1N3/P2HbpZSX047tiSZY+tX9lOa/6yT2Yw6uLYL
         v0jF/NV4/ZV0KCFubVhUUGs6+gYCCtJNfGZPsVpG6ce6rp3LWT8B+HAiILBoK0629kHq
         9aZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680024978; x=1682616978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUQpl1oWFdL7IxlxYgl03xOfPQkkFY7MMHFgeypc77w=;
        b=drJ+V39Lnwik2eLK1n61CV/cRp9ULf+7BqzEMD3k4YQ/JMcx8yIzrQgpuUKpg8BZhv
         S45PiUBeiUmb2MQx/4oOfVEGclzGp6QBE/Vj7u4udioAbuJC+ne6WX/7/6vw1qHfQnyo
         gXDN3SPc0qfndFCRiESXy90528SSXx2RTt5RdXH1ohqgESNOh3CM9Fu+j+tPnnUy+pFg
         hmXEPFCD68MhBdssZE8ZaC97kLBYiUUwWg/AK3z7DlVJ0L8YrZ95rYJlAY4NBfOcwXA4
         nxt60o6wrvvy6Na1FMKFRgijiNOwtlxuDX/sqNF0NOXyh9dUaOC/cDsTIUH1dElCewCe
         hMNw==
X-Gm-Message-State: AAQBX9eXdadmEzwAR+3wZd9TGJ/pSs1nobeGScaMTcHX9uPc4ouuL9XN
        yFqitAVcQu0y9EwiDFQshlg+yfgf3Oz5t+fbVi8dIA==
X-Google-Smtp-Source: AKy350YH6eGwPDcLUmZXAMY8+Kyn5iddxlOgqYqWZx/kjzb3lZTDTKW/p6e9TMiftyWXUYV1lxi8pA==
X-Received: by 2002:a05:6e02:1bc1:b0:326:1d0a:cce6 with SMTP id x1-20020a056e021bc100b003261d0acce6mr1905213ilv.0.1680024978551;
        Tue, 28 Mar 2023 10:36:18 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm9994115jak.108.2023.03.28.10.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 10:36:18 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] iov_iter: add iovec_nr_user_vecs() helper
Date:   Tue, 28 Mar 2023 11:36:07 -0600
Message-Id: <20230328173613.555192-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328173613.555192-1-axboe@kernel.dk>
References: <20230328173613.555192-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This returns the number of user segments in an iov_iter. The input can
either be an ITER_IOVEC, where it'll return the number of iovecs. Or it
can be an ITER_UBUF, in which case the number of segments is always 1.

Outside of those two, no user backed iterators exist. Just return 0 for
those.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 3b4403efcce1..8ba4d61e9e9b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -168,6 +168,15 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 	}
 }
 
+static inline int iovec_nr_user_vecs(const struct iov_iter *iter)
+{
+	if (iter_is_ubuf(iter))
+		return 1;
+	else if (iter->iter_type == ITER_IOVEC)
+		return iter->nr_segs;
+	return 0;
+}
+
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
-- 
2.39.2

