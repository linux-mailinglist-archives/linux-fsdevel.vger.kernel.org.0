Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8010F3E7BD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 17:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239566AbhHJPMv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 11:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbhHJPMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 11:12:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82314C0613C1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:24 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id m36-20020a05600c3b24b02902e67543e17aso2040263wms.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Aug 2021 08:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmLY0n20K9AbW/spIOodAwTXteJwdmYcVh7cXB/CSW0=;
        b=CpHpSkZHrwV4hfANxnJZo2FJBIkkseiMDiq9Z+JU6k72veAq1WrxoA1CfpxUP6rSYj
         ynmdx37jH8f2JXDd581uhNAYodevE/n9ZJbMKsjsCOUXsDaKnAe0b5c1ws7++L4DqxFp
         w1ntli8D4gygbt5mLQRP5tMUg0ZRURah5gDulLNauXsr1kWPogvF8z2VO7Q2B2lgobtW
         I67u6LP002PahsoJKNaxrGTlgbMUPJOjHSUTfOn0JGUgSt5Utr4bNTbgKrOKRsIncCvN
         AkW+oA5XuxV6GG+8GdRCq2kb/zDC+XpeWe1WCOcpZTvqE2WMEmqTrCw+v1ck8Mxqz8Ti
         4qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rmLY0n20K9AbW/spIOodAwTXteJwdmYcVh7cXB/CSW0=;
        b=j4F+r7mbaZiIwNVCo6wHB+kQkcAFzkwSCd9PL3sreDxvlfUqYB4oSlmOzpA1iySR+s
         o+s33Wrr8Q0vedZZ4mom+Cfxch+IAkywyyWicF9BFJjW4gKt6yjttBW/+nAB8Bu+fiGT
         Hv2yNtaQ4CtWzLtqs6GhtOzr26808C9U77TxsXNxJfX9ZssM0S1f40UMcno9SZ5qgIP8
         sGaoY7ZmUhe9MpMAuPnoBv3Zwbzw/NJ02iREn5vN4JZP9B6JnVgV16vddGWLttlv9Nj4
         KveoHYSixctrdB8j8n3INfhjpSdHorqcERDjJ3duLfmzQIhk2PJjbnKFvkNgSrd5qi39
         PRZA==
X-Gm-Message-State: AOAM533cxI+AwP1vGWfnt31jMysSPiNRl6ymGVnTSsPPm9Y6WDY4ZbSw
        lcLIwfG/60VhwuUKZtyxc3w=
X-Google-Smtp-Source: ABdhPJzXSEHREahT7PLprXk3MTu5fahVSoMT7rK7ga7K4eOdmp9aJ93ioVdr4zbdcfdxPBFxccrrEw==
X-Received: by 2002:a1c:8093:: with SMTP id b141mr17533942wmd.177.1628608343102;
        Tue, 10 Aug 2021 08:12:23 -0700 (PDT)
Received: from localhost.localdomain ([141.226.248.20])
        by smtp.gmail.com with ESMTPSA id k12sm9568920wrd.75.2021.08.10.08.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 08:12:22 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/4] Performance optimization for no fsnotify marks
Date:   Tue, 10 Aug 2021 18:12:16 +0300
Message-Id: <20210810151220.285179-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

Following v2 addresses review comments from v1 [1]

[1] https://lore.kernel.org/linux-fsdevel/20210803180344.2398374-1-amir73il@gmail.com/

Changes since v1:
- Rebase on 5.14-rc5 + pidfd patches
- Added RVB
- Helper to get connector's sb (Matthew)
- Fix deadlock bug on umount (Jan)

Amir Goldstein (4):
  fsnotify: replace igrab() with ihold() on attach connector
  fsnotify: count s_fsnotify_inode_refs for attached connectors
  fsnotify: count all objects with attached connectors
  fsnotify: optimize the case of no marks of any type

 fs/notify/fsnotify.c     |  6 ++---
 fs/notify/fsnotify.h     | 15 ++++++++++++
 fs/notify/mark.c         | 52 ++++++++++++++++++++++++++++++----------
 include/linux/fs.h       |  4 ++--
 include/linux/fsnotify.h |  9 +++++++
 5 files changed, 69 insertions(+), 17 deletions(-)

-- 
2.32.0

