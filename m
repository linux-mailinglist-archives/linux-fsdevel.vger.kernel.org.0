Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91A4275753
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 13:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIWLon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgIWLon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F988C0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:43 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k13so14367127pfg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpkPd+fTAhj2X7V3WWb/Fwmg/vataD1CR1qCbhap4f4=;
        b=CcC/ZKUA52pIruP3I4urrZThCQrurCSIokR3kJEDalZXoWegpoul8123h+hDEjQI9+
         O+kEOOeGedDgxnLXxLqIgA+0pLbB1F+96jrJjq7kmsZuB23Q6AQIwjgsuxBDuETafreP
         cZS07S7mLWy/mS4F0N9Gk5EBE31cLoenAgAwmBgi0t5IS/cbOUTBmDmnAaTIKeJkmJkZ
         iYH0SywXPjRzRQE7diu+as2/OCiGl9Vu6IhjYVMErGgBe27e+rkxMMRnOSLbSPt0TsRN
         BAu9E2U+akRkYQzA87V/dIvHAqNQ3Ws1jK9tIV3lElE0wfBqGFFkuU4IgRpG9OAQHNrt
         YaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JpkPd+fTAhj2X7V3WWb/Fwmg/vataD1CR1qCbhap4f4=;
        b=UM1B7JJp+GwRbIpqHuw++KANGQkaNMaRFZnqnC3THCDwX3uvFzotIN0pgPmoa+n3EV
         L6QhAAbJgB8ta6Er/hclyJWJ7+7XBQ0e0PLNH8PHQT86kQxjCcVIrooLKYf2PWET61tz
         rCWXx9DmQHRPQqNwSNxhxt6Zymvy/uO5Q6MgWEZy9q303B54oY1SOcJOpvcb0U9ePk50
         2ALHE2l0/hCV4HjHtClfFtHXe/L1VaDfCD0ZKLws8Cv0kCEZORJQkbrNGmurp9AggTtn
         KD343E+d71xQJQ4kEhFkGBxkCqR4+pFHqQfbimDB6KAlh4unAiN2B42NP4joq6vFBE/S
         Zx5w==
X-Gm-Message-State: AOAM531CUFQMkJfly2bFClUW7YN/CqdbHWO4d4pTxBZWiCdhRW1zPuJU
        140yYmsIZrs5yaaJju9GufjNEWYXyCVr73KL
X-Google-Smtp-Source: ABdhPJyIwoJChwdK0TVdZJm3mJJaHP9asayg0CoeYv95i56+QDjppUSQr6vPEoZM3F2mMX5ltg5tNA==
X-Received: by 2002:a63:4a0e:: with SMTP id x14mr3038895pga.222.1600861482687;
        Wed, 23 Sep 2020 04:44:42 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 0/5] io_uring: Fix async workqueue is not canceled on some corner case
Date:   Wed, 23 Sep 2020 19:44:14 +0800
Message-Id: <20200923114419.71218-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

changelog in v2:
  1. Fix missing save the current thread files
  2. Fix double list add in io_queue_async_work()

Muchun Song (4):
  io_uring: Fix missing smp_mb() in io_cancel_async_work()
  io_uring: Fix remove irrelevant req from the task_list
  io_uring: Fix missing save the current thread files
  io_uring: Fix double list add in io_queue_async_work()

Yinyin Zhu (1):
  io_uring: Fix resource leaking when kill the process

 fs/io_uring.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

-- 
2.11.0

