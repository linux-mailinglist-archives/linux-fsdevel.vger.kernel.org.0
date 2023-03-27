Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3C6CAC9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Mar 2023 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjC0SFD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Mar 2023 14:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjC0SE5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Mar 2023 14:04:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9F2D60
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:57 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id p17so4239968ioj.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Mar 2023 11:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679940296; x=1682532296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zFM2a+ZzYXSxFvSgVUFtAECG7wgpfdxpPdXdbVNH0aY=;
        b=Op5McrhWUmqPfmlzUd/fkuZH2T8PHSJMThHTbKtxyoS1VPgAR537V3XFCiA+rYU/Ko
         tb4vxMidldiPki+Ziovlm4DEfjPofT5uaGt6ETAx3aHiNPJRc+KjtfKW25Nd6RURtdWd
         EIyeCyQbCKiQq2clKCfQDuIa+xd0CrPNXjulx3cHuuk/WySKjv+Hh4oTuBiJ9dm8C7B4
         CitREeBdHLwvwjV/e/Z6WePhKObzs2UHxJjlbwqSGI8orQjQ7ca2Q4dpLs5msJMqo1OA
         shg4XnqIEGFTDfaooYShsJQmalrlUUp2UMGzrz0bAv3E6JClcHT3VAR35RQ3bjxib2Hy
         VRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679940296; x=1682532296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFM2a+ZzYXSxFvSgVUFtAECG7wgpfdxpPdXdbVNH0aY=;
        b=ImoILDQyaiKGAIe2SZnMW559kIJSe+w/edwoLQ2EGEHRxSCYP8vQyp0r8pa4lUwj9I
         ohJ50sxyUeOpLrMceH8cFU0smjiSUdraizEEUVWh7Nrw2Q314HHZV8chs0qVA901L3o9
         MzD+ETquPFQrGVx15MwvaLr8pV6dRi8vXF1QKEH0Vrggj5gR4BKeivi7pc0Oufb+Zw0j
         VikIEI2yqbZNMUGnYb07ujO+AN6C3vu06jl+cVCnLSZgd4WBo+3d3rmiFZMOascy8w5u
         h+YP0FoR/M8LL8QhBi86NDPun6gv2PuVvu9JpCYFCsbcBQ4WaAfwZGJ6kHjcGdx9sPdr
         jU9g==
X-Gm-Message-State: AO0yUKW/03atpsSrnQ7fCwaSRG2DikAqjlT6pHFMFHNU8sV4Sdogk5ID
        JFX19yGbJMzsBEkDwwnjiwjcSdW/fTQXp3RAYmUTvA==
X-Google-Smtp-Source: AK7set8T4r9lWuPxghF9ysmw/Rbpm2zoIC1qC9C86F1Of9w7080HBGaWgpck6FlWDd3/5EThK1t89w==
X-Received: by 2002:a05:6602:2dcf:b0:758:6517:c621 with SMTP id l15-20020a0566022dcf00b007586517c621mr10171718iow.2.1679940296137;
        Mon, 27 Mar 2023 11:04:56 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e28-20020a0566380cdc00b0040634c51861sm8853235jak.132.2023.03.27.11.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:04:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] mm: make process_madvise() deal with ITER_UBUF
Date:   Mon, 27 Mar 2023 12:04:47 -0600
Message-Id: <20230327180449.87382-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327180449.87382-1-axboe@kernel.dk>
References: <20230327180449.87382-1-axboe@kernel.dk>
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

In preparation for having single segment iovec imports be transformed
into ITER_UBUF, ensure that process_madvise() deals with those correctly
when iterating the iov_iter.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/madvise.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 340125d08c03..2bd0f6c067bb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1503,7 +1503,12 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 	total_len = iov_iter_count(&iter);
 
 	while (iov_iter_count(&iter)) {
-		iovec = iov_iter_iovec(&iter);
+		if (iter_is_ubuf(&iter)) {
+			iovec.iov_base = iter.ubuf + iter.iov_offset;
+			iovec.iov_len = iov_iter_count(&iter);
+		} else {
+			iovec = iov_iter_iovec(&iter);
+		}
 		ret = do_madvise(mm, (unsigned long)iovec.iov_base,
 					iovec.iov_len, behavior);
 		if (ret < 0)
-- 
2.39.2

