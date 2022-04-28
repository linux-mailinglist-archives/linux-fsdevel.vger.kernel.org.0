Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F7C5146C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355189AbiD2K3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 06:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351354AbiD2K3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:29:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA468E1A4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 03:26:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m14-20020a17090a34ce00b001d5fe250e23so6852406pjf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 03:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9vQyV3VXopoorldZBhqjQOAWXe3vDxv13+Q7J/GRjI=;
        b=k34t64cr0M1Pd5rgryr65LjFpeQq9cxLmOP8dt0bLLIiDZpB/xS5ywbHML+rq9KFP8
         qJ5A+kupDtJAPClN2y/KVp/wmfyCXAiD8zycTA1LxjqAnGio7h27B2W7G/3ZJesFTrjM
         EnDPcOoc3gcd8Vqn4zEj8OSqB8ALRpoQSaB5/Ys78FUGef/K5+WjSe3oDpII+HyKYsmX
         GmwRDT5ozDLcDIIstFsM15Ngm6eRMbVIW4bONfEkNlRaRaI8q/KMv3b1A7OAC+Aw2qaK
         1Aix8Y6hUaMSXiQuUiyH2cLQXQlMjf/OdcwNQJvLgA7oVsXVG9SWzrPU2sZPpa9XDWSv
         Jotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9vQyV3VXopoorldZBhqjQOAWXe3vDxv13+Q7J/GRjI=;
        b=dJdPd9UImLWYasEBUdijgB6aR4U9E1nOpPREwlYtwjcuW8C2qap3diW3BfcLxjzl1I
         t2dl5SKt2ioHUNfqCkTdPb+xYXiKos+ZoaEglbBfopKxL7iO5Hu9HPusYdXCmj/BoC+A
         LGBVZAywvu837eyBOTbAkj3qK8xIq0oW/EsdHkANckDcf+LWPussO9cIX4/RoYWUAKfC
         RI9Rk1AZLgkIIGrmwzPzv2V5V4fT0gO0bslGFSBP9yNPxqd9rfTpsazExsYIuhR0rHUv
         qOdhtAx+6DeaqkMKKdFn645aHspeAqZUumo13QYDH4UF3aiOFAMcY3z8OZlOHEw95BIa
         3wWg==
X-Gm-Message-State: AOAM530nV0Fp3U8emE20slEaCZjp1fObG1AqsaRSQKThickM4NNpCz6h
        juIxyN7KPdFMyoN/5jKeAGYSGw==
X-Google-Smtp-Source: ABdhPJy6M+E3y/ei0uS1zFcgKhBsp3sk6J3D0I/zhjzkWgMr5WPhz+ZNkg/j9ZjgM0cUVu0Yt3heaw==
X-Received: by 2002:a17:90b:1c01:b0:1d2:add6:805f with SMTP id oc1-20020a17090b1c0100b001d2add6805fmr3086211pjb.29.1651227973166;
        Fri, 29 Apr 2022 03:26:13 -0700 (PDT)
Received: from yinxin.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id l5-20020a63ea45000000b003c1b2bea056sm1042659pgk.84.2022.04.29.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 03:26:12 -0700 (PDT)
From:   Xin Yin <yinxin.x@bytedance.com>
To:     jefflexu@linux.alibaba.com, xiang@kernel.org, dhowells@redhat.com
Cc:     linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org, Xin Yin <yinxin.x@bytedance.com>
Subject: [RFC PATCH 0/1] erofs: change to use asynchronous io for fscache readahead
Date:   Fri, 29 Apr 2022 07:38:48 +0800
Message-Id: <20220428233849.321495-1-yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jeffle & Xiang

I have tested your fscache,erofs: fscache-based on-demand read semantics 
v9 patches sets https://www.spinics.net/lists/linux-fsdevel/msg216178.html.
For now , it works fine with the nydus image-service. After the image data 
is fully loaded to local storage, it does have great IO performance gain 
compared with nydus V5 which is based on fuse.

For 4K random read , fscache-based erofs can get the same performance with 
the original local filesystem. But I still saw a performance drop in the 4K 
sequential read case. And I found the root cause is in erofs_fscache_readahead() 
we use synchronous IO , which may stall the readahead pipelining.

I have tried to change to use asynchronous io during erofs fscache readahead 
procedure, as what netfs did. Then I saw a great performance gain.

Here are my test steps and results:
- generate nydus v6 format image , in which stored a large file for IO test.
- launch nydus image-service , and  make image data fully loaded to local storage (ext4).
- run fio with below cmd.
fio -ioengine=psync -bs=4k -size=5G -direct=0 -thread -rw=read -filename=./test_image  -name="test" -numjobs=1 -iodepth=16 -runtime=60

v9 patches: 202654 KB/s
v9 patches + async readahead patch: 407213 KB/s
ext4: 439912 KB/s


Xin Yin (1):
  erofs: change to use asynchronous io for fscache readahead

 fs/erofs/fscache.c | 256 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 245 insertions(+), 11 deletions(-)

-- 
2.11.0

