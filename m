Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586F375876F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjGRVqK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjGRVqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:46:08 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C931993
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 14:46:06 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57a43b50c2fso41636557b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Jul 2023 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689716766; x=1692308766;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oZyVDwK3otNe1aFKsK5m2BlqgA8vBaRGLZSB3UKDdYk=;
        b=AZqxtqXAjBOCZAEl39imvIBaER7BhGzflFaWl/m5Zz9t1dlz9kDUMuAszlEUshA3DO
         2wfvkMQVW0bnovbxO8kZA6kos8l0u9EfPIhhqqtcAeojsex5yJz11T9SQgE81LRvoDpj
         KBhp9+d4tePpBAm4b7W2m9i0RLQ2zO5dd/uLrhE4Hd0J7PIz/Aj4yGjyRBxOGde76pBg
         /chcj0WXc8VFUdzGums3KjVVn1KFY/3bRN+FkGs9JB+yKZA67mPhvHQBPwy6Fj0Ao5HY
         ufOURZ2cQP3iilRer+Plp9seqm+0y7KxyH5oVdhWQnBbPbOXcqsriTyrNAHrHaIi0BJ1
         cPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689716766; x=1692308766;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oZyVDwK3otNe1aFKsK5m2BlqgA8vBaRGLZSB3UKDdYk=;
        b=lKCSLdJT/eIkAAXJ1ClHml+Gg2S4Vo4BULpsaEIHrs7yRvuQajFshLe/3Ysj+cwkgo
         HfckEVX3tj4xeTvScRCq+IASYm4UPFKg0NDsnC78lhuMOFpVkL5Cqc5rPNKXCyyWoCcP
         Lt1Z7OCa57mVoryzjlNqCETk3geXi3cbcnI+uug4rNTSVi99aJ7V9oJKcN3fYkmV3AZs
         3zNJparmO0hBdXX0LcR2pTjZpUs8KEbnPeuhGKvuzdan6M4ldEA/p1FPCsAcb5qbi/bG
         8Ov+98G2CxRgAgN9M0b3ZJDWjCiOOYIU0JLaoUXvg56usNhre4PAI9UYuVz/rNDnqmAJ
         QzFA==
X-Gm-Message-State: ABy/qLao1locspvKL6UIn1Eadfjzl8T9r8cpBHkrOxfwduScewOX1Dns
        eAKZThLa1z5C4U++LCwO0K2TalsDiwZrciA=
X-Google-Smtp-Source: APBJJlHdSd7OCAh4bUiKCrr5Fzb8ctcbPN9KVGaTCOvQpuKSQKH/lagJ588BacwVRKe8a2DfX/MHUTHa7Mxrl8A=
X-Received: from robbarnes3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:6451])
 (user=robbarnes job=sendgmr) by 2002:a81:e448:0:b0:573:87b9:7ee9 with SMTP id
 t8-20020a81e448000000b0057387b97ee9mr181676ywl.4.1689716765754; Tue, 18 Jul
 2023 14:46:05 -0700 (PDT)
Date:   Tue, 18 Jul 2023 21:45:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230718214540.1.I763efc30c57dcc0284d81f704ef581cded8960c8@changeid>
Subject: [PATCH] fs: export emergency_sync
From:   Rob Barnes <robbarnes@google.com>
To:     bleung@chromium.org, linux-fsdevel@vger.kernel.org
Cc:     Rob Barnes <robbarnes@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

emergency_sync forces a filesystem sync in emergency situations.
Export this function so it can be used by modules.

Signed-off-by: Rob Barnes <robbarnes@google.com>
---

 fs/sync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1edb..b313db0ebb5ee 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -142,6 +142,7 @@ void emergency_sync(void)
 		schedule_work(work);
 	}
 }
+EXPORT_SYMBOL(emergency_sync);
 
 /*
  * sync a single super
-- 
2.41.0.255.g8b1d071c50-goog

