Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F74551EE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242843AbiFTObj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiFTObZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:31:25 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 605F54D27F;
        Mon, 20 Jun 2022 06:45:57 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c21so14775720wrb.1;
        Mon, 20 Jun 2022 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0/acyt1Yt+CAGQuKAQvux2R5oV+9aowMrjxJPhPJg0=;
        b=JKr80j5SLAtgWYBjXbYu1S8TrJOm6rEmIATGKCTlUHCPnhqX1qsVJWS1ezQZcPxoQ2
         0cKoBMjtRMEj3N8krNd3g7m2via6rbMoM0uK3MSoCaP1TJkK9YI5SMg1WB5T/v2bBVdU
         BmaFsQYn44+j/7P7QBHgE5VmlT4w/TZlqPjcLDE6YC223xzOy60K7ucHSGY6rnG67gSe
         SYxloaK1QKbKlj+t/txmFZYNKiDKAEOKrbN0X6slXN9cpBe94J/2VsrQJAVL2Kpod/uW
         XlOG1SuOJeLHhU4AwX/uP2yjuclcNyVqHeUFA3CGWRKiEFO25kx2T+BpahBfZCimTuNy
         tDxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q0/acyt1Yt+CAGQuKAQvux2R5oV+9aowMrjxJPhPJg0=;
        b=0VNmoQN/vp2xUUMk6Lb3SR9iBBro57JRdDhbPHpkho1SpLkg12JzDdHp8jLf7vmJyn
         BfBZBOIFDuRA5Jc3/UmmLYxuwTrO+y2XL1mwSCkRC3Zi+LHS1kA48X7BpaLgqBqCuSKj
         CE6BFdvoY5xyObA4EVZXIX0YocPd7RDoxKxcC0BwGGPs5E7+y0tiqwtMt1vFHyCxSxFC
         R+x1CwAmFyXH4NTFo6p6McsF+GILeYexkdeJ0ck1K5hz6Tx/WUBT82dZwl6NXSTE/ZMU
         JpVuTzZQTPEiXDq4nVbWAZtpS2o2eMcQoNpLexnb5L1FG4IIfgC26/QIkHrPWFAha+DP
         nBOg==
X-Gm-Message-State: AJIora/P0pdTcXMjU1NW657r7U+V6nPxpv71+lIWW1zYhjHbGTS7WJfC
        JXA0gtPxA4pyBlYQNWl6rUU=
X-Google-Smtp-Source: AGRyM1v0xdrU9GSikc5+u5xsEwVE1HqLR3/RIa2OBOElMvwqMkQk6UZmQ7tbOYgyVvH9qZlG9IFAXQ==
X-Received: by 2002:a5d:4d52:0:b0:21b:93b4:6a2a with SMTP id a18-20020a5d4d52000000b0021b93b46a2amr2044268wru.576.1655732755861;
        Mon, 20 Jun 2022 06:45:55 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d6150000000b0021b932de5d6sm1634355wrt.39.2022.06.20.06.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:45:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 0/2] New fanotify API for ignoring events
Date:   Mon, 20 Jun 2022 16:45:49 +0300
Message-Id: <20220620134551.2066847-1-amir73il@gmail.com>
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

Hi Jan,

As we discussed [1], here is the implementation of the new
FAN_MARK_IGNORE API, to try and sort the historic mess of
FAN_MARK_IGNORED_MASK.

It is worth mentioning that the new API enables the functionality of
watching events ONLY on directories (by ignoring events on non-dir).

LTP tests [2] and man page draft [3] are ready as well.

I am going on vacation in two weeks time, so wanted to
send these out early.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20220428123824.ssq72ovqg2nao5f4@quack3.lan/
[2] https://github.com/amir73il/ltp/commits/fan_mark_ignore
[3] https://github.com/amir73il/man-pages/commits/fan_mark_ignore

Amir Goldstein (2):
  fanotify: prepare for setting event flags in ignore mask
  fanotify: introduce FAN_MARK_IGNORE

 fs/notify/fanotify/fanotify.c      | 17 +++++----
 fs/notify/fanotify/fanotify.h      |  2 ++
 fs/notify/fanotify/fanotify_user.c | 55 +++++++++++++++++++++---------
 fs/notify/fdinfo.c                 |  6 ++--
 fs/notify/fsnotify.c               | 21 +++++++-----
 include/linux/fanotify.h           |  5 ++-
 include/linux/fsnotify_backend.h   | 46 +++++++++++++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 8 files changed, 113 insertions(+), 41 deletions(-)

-- 
2.25.1

