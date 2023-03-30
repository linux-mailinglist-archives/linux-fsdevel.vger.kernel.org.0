Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56A6D0BB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjC3Qrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 12:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjC3QrO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:47:14 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E03CDD4
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:13 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id q5so4721418ilg.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Mar 2023 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680194832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jpwUjTOd1XNUvc/0wj6/ArC+MvM71+0/O8hmrQy2F/M=;
        b=jrlfYvCIHJ4LXZi2Xqy7ue+zXTv0IN9AMsja3fZUzMERaxBkkp1nEKFHp8vhZr8uZH
         NnjRT6Ak+PL3nldTQURPYWzekcUnIdyZcrT4adYkph2ECoiXibjdFaPVGY1AnK+NuFZw
         eCkTy2WA2vyCgTac9UbEe/JHr7cG+tt+QZ+4sreF4H82syh6YBbgzprsfa/zqheMje7A
         PE1HBtO5N0f6H5h+pa/tzD0DUYg93+5lelMZRIRAkNKxxuhLZb3aL0eM4SzCk+ltu2O/
         qhIhLH86m+6MRg/NgWiYA72Q55nzVGcC122bynXzcNf9kLqppDne2+qJeDxCLsez1/Dl
         nYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jpwUjTOd1XNUvc/0wj6/ArC+MvM71+0/O8hmrQy2F/M=;
        b=BeWRLZAW3Euvd1mo3rO5sWOquJyV6MILU80IXZh8EkmRBe9Qdjnta7ZbmL2p1Robz7
         w+xPcDsgWIS6yMwSn8M58yACj2K+P2tq5jJjtLA3XI+/4F7kTZAr9Nq+o4VK69ftgsJP
         aqPgGvcKs5/cb3bMEFRPAUzEjTArv0Q1S2JDaMfmsDSYQ7sNlearbnMMhB9WDp2vRSjL
         s/6mj+ZFEeTW+BzU4OVr+Ak2tIz7yDnWB+YwpKs4j32C4HXB7gHJPmWRP34Ph6yaW3Sz
         fGzyCDtA0M5gaxPAu9EfDbFPiwheAtYw38ERUO1NL+c8/ZJf4kwLMwdfFiyznkb8sg9D
         +cmw==
X-Gm-Message-State: AAQBX9cUrvcEuGtjBIG/fhtQqOYgAtQ6hT97jPrIR76WmgILb1wwL/li
        G7cYHfjqFTzDYefOaAdcPgwOs7uSLJBZXyst+1cTDw==
X-Google-Smtp-Source: AKy350YgaLyFdyIkSqO644lZmbDb4MesLLur6QZjVw34wucOOoDXj1ELcUDejMDQUUiRRzAf38OV1w==
X-Received: by 2002:a05:6e02:b4e:b0:323:504:cff6 with SMTP id f14-20020a056e020b4e00b003230504cff6mr1735885ilu.3.1680194832515;
        Thu, 30 Mar 2023 09:47:12 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id v21-20020a056638251500b003a53692d6dbsm20876jat.124.2023.03.30.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 09:47:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 07/11] iov_iter: remove iov_iter_iovec()
Date:   Thu, 30 Mar 2023 10:46:58 -0600
Message-Id: <20230330164702.1647898-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330164702.1647898-1-axboe@kernel.dk>
References: <20230330164702.1647898-1-axboe@kernel.dk>
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

No more users are left of this function.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/uio.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index b7fce87b720e..7f585ceedcb2 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -148,15 +148,6 @@ static inline size_t iov_length(const struct iovec *iov, unsigned long nr_segs)
 	return ret;
 }
 
-static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
-{
-	return (struct iovec) {
-		.iov_base = iter_iov(iter)->iov_base + iter->iov_offset,
-		.iov_len = min(iter->count,
-			       iter_iov(iter)->iov_len - iter->iov_offset),
-	};
-}
-
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
-- 
2.39.2

