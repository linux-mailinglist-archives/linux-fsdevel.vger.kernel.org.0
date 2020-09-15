Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C5526A0B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 10:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgIOIXu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 04:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgIOIQ3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:16:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A561C06178B
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:16:05 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 7so1555140pgm.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 01:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCyQLZIomtOO1i6n72+em9VVg13AQuPSjMf53LDYaqM=;
        b=auIoq9oCUFxSo4pwN0sve/6Y70uneeWypGCBG5hiKQEvrs5xsnPny5hFer4eYtvobB
         i1e8/4/NUocwRqRvZU4d3158MMYfZg9uMyBexYuihdiruBMYNWdXKwXZmAO2N378J80N
         eqkHCtMx81ILLcpD+YrJBxPJuBdMEMfiKoVJ9PCflvPIRPoKR3aLmjbC9JpchjGEgL+2
         OAAG2s6uGACAX/l/xxBhnVkglCSTQNyHNAdoPoaq3u4mqUNcVpJM4OnR+IYbo/Jgnt2E
         jYrW4IZZm931VWbRzDf+K2XYOH9XodrcyeKISXf5fabViRfS4vXU4n23bTlmOwPIyfCG
         FM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CCyQLZIomtOO1i6n72+em9VVg13AQuPSjMf53LDYaqM=;
        b=pUK4seuV70rLonXj2QAOiD+zU1NLduHx54Nufg5dNnYSl5YMNyWUFFx9oF+vALyCuK
         bnsWvCxtGnj3GxFBXoy2YAJgl6C1xBwXKCtORdJ1qV/m/7P77TS3fs77+h1vlwcKMa9/
         TpmJj1vdAEcitSrW7b6anzd1zf6FDPdCrHiXHE1uGTvaaawxwpe0zD2ay7Id4X0gp57y
         Z1g8guKq8j7hQORfLu6wkutT04eIVlRMYcIVJbdq65sLRfgx0UveBJPqsHSWLp8sl3Sr
         EGR55O0m4z5zZKuT4X7NM0yZa84ejnTCQhbI5ZAt1CoFzE7AGjJ19Ta0TYBhNn+BJB2q
         kPVg==
X-Gm-Message-State: AOAM530u9ql6fPvSx5nc0KxEVWopma9Hg0pj5dPUvxcc09MXaNF2h6z3
        OBuIllEc1/bEKjM80gd08Srp4Fou/Jbw52cP/no=
X-Google-Smtp-Source: ABdhPJz/sjjpFc3hiXj9N7JffKpq8GhR5gx1bxMX6eM7XMcT5j1DHbJd+okuEH1Z85Q1f72+EGOhYg==
X-Received: by 2002:aa7:8249:0:b029:142:2501:39dd with SMTP id e9-20020aa782490000b0290142250139ddmr827130pfn.44.1600157764267;
        Tue, 15 Sep 2020 01:16:04 -0700 (PDT)
Received: from localhost.bytedance.net ([103.136.221.71])
        by smtp.gmail.com with ESMTPSA id x19sm10539429pge.22.2020.09.15.01.16.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 01:16:03 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 0/3] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Tue, 15 Sep 2020 16:15:48 +0800
Message-Id: <20200915081551.12140-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We should make sure that async workqueue is canceled on exit, but on
some corner case, we found that the async workqueue is not canceled
on exit in the linux-5.4. So we started an in-depth investigation.
Fortunately, we finally found the problem. The commit:

  1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")

did not completely solve this problem. This patch series to solve this
problem completely. And there's no upstream variant of this commit, so
this patch series is just fix the linux-5.4.y stable branch.

Muchun Song (2):
  io_uring: Fix missing smp_mb() in io_cancel_async_work()
  io_uring: Fix remove irrelevant req from the task_list

Yinyin Zhu (1):
  io_uring: Fix resource leaking when kill the process

 fs/io_uring.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

-- 
2.11.0

