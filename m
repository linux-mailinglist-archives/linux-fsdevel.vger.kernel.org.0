Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71616727A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjFHIrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 04:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231224AbjFHIrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:07 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700319E
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:05 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-558b6cffe03so215480eaf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 01:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686214025; x=1688806025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ReHVJUdk4k/dMmoONA2QuZAXZtonUaqX3/C9lDPVK7g=;
        b=GoEKseHhe6g5uipypMbKd5f27TlU0oqBuxJ/QolY4p7yzPmkIcGgaRB4S0Xuddp3gp
         yuId9mvz9khBjKzctq01FLHIVLEdmJ3VGacltmZr/k/nhEE/Pt0kjzjQuBp4Qne9XEVi
         gek3LxAiDmral6i5MarJnwSwADHn//6Wg9xQFOTuQgiBE9zM/LVgztU2Y+1jyjj5vlNF
         mEBQu/RQg7wttIxS7Ako+IGmc2UliHmSrRWKXXZWqTWpY3n9tuI02AYlMfc80l0Y60B/
         JP4SOIpfjfCWgIa+nh2tZpwUETfZpwN122ZoK6cuB1y6u1CVd1Dc8w3XxhffPI//vqLf
         bsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214025; x=1688806025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReHVJUdk4k/dMmoONA2QuZAXZtonUaqX3/C9lDPVK7g=;
        b=iol8kJgnXbCKK27nC5pMP3ZyEtUKmrCUmAcg7F9qMTOyExa7LFuCc/WRnPBkR3OEYY
         KJZtNcylQYGAliJSxF6Q/iXh3zYKBlcd/8qRE+3TtS/i+RMYccDgUBrcItp9At2eChuJ
         aSFWO4q7jct7IKeAT1Xe5hbjMtRyMQAd9XJktyB0qs2r5Cp+UnxhaN0K7GKKNMFsYMS3
         l7hAcQLCpDikRd2WNAiMLOqSTXhit+2gwfLB1dcrj8QJHPJz4F1F7R9XvjCq2kALolR9
         BFcAYdJqAf7alBVESigR6pIPx4FprbEY4/WPJpk5YAyK1r4lDos5AFbaOev2iOT9texw
         Plxw==
X-Gm-Message-State: AC+VfDypN6vZoq59/rOlgVIgznKTTiKu0DuMZ89Ruv32/6Shh0g9JVqG
        3wYCIPUqFZCsQQAP7RW3jMqh4SO4efb8uFVnWUs=
X-Google-Smtp-Source: ACHHUZ5BQbGh7uaqOQ8mK52wJMu1Yp++xtM6dClSvazH7XoVNYOmkc38rehdzoXRkowvoecDuvDM3g==
X-Received: by 2002:aca:220d:0:b0:398:2e8d:3ca7 with SMTP id b13-20020aca220d000000b003982e8d3ca7mr5196004oic.56.1686214024838;
        Thu, 08 Jun 2023 01:47:04 -0700 (PDT)
Received: from localhost.localdomain ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm614160pfi.169.2023.06.08.01.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:47:04 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@osdl.org>, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 0/2] fuse: fixes for remote locking
Date:   Thu,  8 Jun 2023 16:46:07 +0800
Message-Id: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

This patchset fixes some small issues of fuse remoting locking.

The first patch fixes the missing automatic unlock of fcntl(2) OFD lock.
The second patch remove some deadcode for clearness.

Thanks,
Jiachen

Jiachen Zhang (2):
  fuse: support unlock remote OFD locks on file release
  fuse: remove an unnecessary if statement

 fs/fuse/file.c   | 21 ++++++++++++++-------
 fs/fuse/fuse_i.h |  2 +-
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.20.1

