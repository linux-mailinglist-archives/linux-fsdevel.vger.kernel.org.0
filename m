Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177B0522F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 11:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237887AbiEKJ3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 05:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiEKJ3W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:29:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C3EE6B48
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:29:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s15so790972wrb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kA1teJ0zydV1nJzzbCz+aoq9AuCIVgdi+Mg5ScfoZjM=;
        b=UyVRGmYDFhtbfx0qysnt66NeVBDJ+BC13hNwUr1E9z2JgrRedyteTF8BY66CJiWjE2
         ry9iBNEfF7Jt1PLQE9qt0qswubo+yoa+KL3lCxpCeq4kApCOh/sGF3LmKAmBqpBul2cT
         do/UOtrxsf6KzPSiczjAS8F52SmRJoOmvq3Oq5EU9vN0SBRXZYYpb9HzkZnLAjFz8oO9
         o47d+mQK7p/DVOCio8Ca/7iUkbE2pLAoLVNAmLruDBX/J/UeesKRIAC4eJe+H9CdAIns
         NNvNwV5Ol0a/QOKlhk8lh7z7ImSL1kXxRRToVtggvAzZrF6YMn8b7juhRbdj/Bs1zNHo
         kUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kA1teJ0zydV1nJzzbCz+aoq9AuCIVgdi+Mg5ScfoZjM=;
        b=VvpQiJyWPSNt1xVr11+Hp3OBRes/tXU7X+gmbBI4pH9Ottmu9YN4n1Gndr656TShPz
         vSKGaD4lgrVjZTwU1jVtTL486ZJoI0AQawL4Y+/yG8oxsvhSq7GldK/C4mDEtg4/+F5t
         wG6s2GFVG8x5D/3348SQ50BKx4oIZjGt5L037otZLbXUyUqKDFbBrcw/NMLvGVn2Fsl0
         P3TdzOEk/+Sxcu8DGI9wGHyNANhsZU0aiLVV4E0KGpdoNNZJ5lTK6rs+kqHyGfKs0vrV
         giy2xhMRw9+5WV0Ki3odH17N9k66dpfCvL3xqa5FCu+N9Lbo9FGOguGeiTecqVw4Xs+1
         93cw==
X-Gm-Message-State: AOAM5316Zix/GmVWobA0pLiWLTfc0sVSCQg1YjY6HbaMMv1eV9Y97sr9
        S4Zr4EbDS+4dXo2lJID6hEa6sjDK2bo=
X-Google-Smtp-Source: ABdhPJxMrUaII2hAidy2pm5D3WKjwH0Rv+ihIaHe7cpTuLbjoKE02zS3Cs1tdwOugEWr/4ej7uodkw==
X-Received: by 2002:a5d:4283:0:b0:20c:cb51:4a8d with SMTP id k3-20020a5d4283000000b0020ccb514a8dmr10857014wrq.3.1652261359259;
        Wed, 11 May 2022 02:29:19 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.18.175])
        by smtp.gmail.com with ESMTPSA id f13-20020a7bc8cd000000b0039429bfebebsm2036676wml.3.2022.05.11.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:29:18 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Fixes for fanotify parent dir ignore mask logic
Date:   Wed, 11 May 2022 12:29:12 +0300
Message-Id: <20220511092914.731897-1-amir73il@gmail.com>
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

[1] https://github.com/amir73il/linux/commits/fan_mark_ignore
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore

Amir Goldstein (2):
  fsnotify: introduce mark type iterator
  fsnotify: consistent behavior for parent not watching children

 fs/notify/fanotify/fanotify.c    | 24 ++-------
 fs/notify/fsnotify.c             | 88 +++++++++++++++++---------------
 include/linux/fsnotify_backend.h | 17 +++---
 3 files changed, 61 insertions(+), 68 deletions(-)

-- 
2.25.1

