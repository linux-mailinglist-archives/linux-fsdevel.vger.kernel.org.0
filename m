Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2E523CFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 21:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346541AbiEKTCV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiEKTCT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 15:02:19 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC3161296
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t6so4273293wra.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r9u+ahKwpk+8g1Gq16NEAr0Tman+TDEAuSUs7czHss=;
        b=LL5lvazw5mCmBKVwn0p/N2Z2AuK+Rc0khD/zxm0FDACW3YH4nzAITnSbGUS0LqTUFn
         T3j2vdDhAPCL+BGq73ApReVAiTuXcYDt0vZf+3uovghddm6O/HEjyfF+wqrUCHGcomgt
         Hi8jPWy7PEDJTurOQVE2TTvN/VC0XLEkD4e6SV9F9cO1EYfXRJn7zNOltKT2pCkDWnad
         JX53Yr2Xv8h8LcHW2MVimwKCjhfUBPMG4dwpS6GI+FO9hUmPrGyySLLTtJz9s/M+EHSx
         dDeSQ3IJY+pT7DxgZtW9tOLpyB5tlHAOPRLH17pcJbfl/TnrVNctIDkvp+i+G/3MMFDi
         wz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2r9u+ahKwpk+8g1Gq16NEAr0Tman+TDEAuSUs7czHss=;
        b=ro8O4e43S4h+Z2CSBH2/UkkLJJ6vsH/Sx3EfiNK8C7SDwQ7qk+cVwLyitYE5KITeP2
         pMTeF1AEND260psFRVDze1jwSiWOw/nJRNkrVqUYlSQw38IbN3Ffxhff1KHVIQCoosD6
         SpJXZlHL1ksPDoFOBCLz5/JADXx4Qf2uq+p2Z55NrBhgM2JXMV55rWcWYHdiWRZTsr4f
         u7GCnGaTVZqxfUsqED+FWKanYOP63YqtVoN/qhpjMsjtGp9l7D4qMwsGuxJEs7NeWVKJ
         VMiTPZ1stAhUz+RUc2VJpyWgznvBDIgsslgU5eCfS5YSURdz+9svNJPKnV39+ytePnbh
         HuAw==
X-Gm-Message-State: AOAM530+AUAppjinSnyw21fIYU+0XdDdgBAq96ZJr2fZIJYPgOIgmjq1
        VgjRmiNsoJGlMj/Azs4SnpU=
X-Google-Smtp-Source: ABdhPJwXReMEAp+Wo2CE8JCWvdPajcP9Rc/ZAp/K523Ffz+MoG6rDi/OeLF6iSWCz3CqF9Kz536CoA==
X-Received: by 2002:adf:e44d:0:b0:20a:d88e:94ec with SMTP id t13-20020adfe44d000000b0020ad88e94ecmr23208825wrm.311.1652295737124;
        Wed, 11 May 2022 12:02:17 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.68.18])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003942a244eebsm435527wmj.48.2022.05.11.12.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:02:16 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for fanotify parent dir ignore mask logic
Date:   Wed, 11 May 2022 22:02:11 +0300
Message-Id: <20220511190213.831646-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Jan,

The following two patches are a prelude to FAN_MARK_IGNORE patch set [1].
I have written tests [2] and man page draft [3] for FAN_MARK_IGNORE, but
not proposing it for next, because one big UAPI change is enough and it
is too late in the cycle anyway.

However, I though you may want to consider these two patches for next.
The test fanotify09 on [2] has two new test cases for the fixes in these
patches.

Thanks,
Amir.

Changes since v1:
- Change hacky mark iterator macros
- Clarify mark iterator in fsnotify_iter_next()
- Open code parent mark type logic in
  fsnotify_iter_select_report_types()

[1] https://github.com/amir73il/linux/commits/fan_mark_ignore
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore

Amir Goldstein (2):
  fsnotify: introduce mark type iterator
  fsnotify: consistent behavior for parent not watching children

 fs/notify/fanotify/fanotify.c    | 24 ++-------
 fs/notify/fsnotify.c             | 85 +++++++++++++++++---------------
 include/linux/fsnotify_backend.h | 31 +++++++++---
 3 files changed, 73 insertions(+), 67 deletions(-)

-- 
2.25.1

