Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1B4D038A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Mar 2022 16:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiCGP65 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 10:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCGP64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:58:56 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D27D3137D
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 07:58:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q14so8483276wrc.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 07:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aMEwz0f8oMtTUlEEc6d78LRvDC3Z3vq8gaNJsX+WUM=;
        b=Op7+c8mpdiQSW83nvkxWGiAkRLo4OAHywTDKAJg75wuWlcq3GC3T2r/hocItfkgRWT
         UNAD8FfpM9BqQgbcALuiFiOIeIcSgDN/efyutdM211Ej3dfevr84PIlOHAJNCAuRFjlq
         /ZIVKJgOjaGlBztm6zv0Nomvf83z+0i53T4I1FzPvG3sgtRs4zpyIq4+oCb4rkER3Jdb
         R+bGUsuhyDdoIn/jvhP+LwCLVIRXd76pkfCN5NfB2gfyREDyfb3XV960fO05fvZVhocv
         3aBuyBkecV5vZxpdfRgMxF7T61Jdf2ol1j4Rt0FUBEkKVi2nfOL1yZQrtrvopKrYBn6+
         ctVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3aMEwz0f8oMtTUlEEc6d78LRvDC3Z3vq8gaNJsX+WUM=;
        b=KfvGKByvt0Lg246Sokk/Xs4exvCPR8A2KT8p0xYWBcGmT1KR7/+frUEwN5mFcY3SZ4
         c1aNVK1lzFliulAVpxoBKj/CzVJi25zq5/SOLF4bwv0hsnyhaNKM181i5GBWS4Ld3/03
         W5sTI7S46uCDqDwVZEqZJM5KblveJ1j9uCnxdhZJ5mP2OJWKj/WQmcd5Zi73X9ek8v/z
         JHhOF3/yHX1OLo6AI0te/0VRfH/s+ZET2hFgIvN6km1S/WoJqQ3qpyIrJQelnDhko+1h
         IBDZBniGMivqDxx58A2CXhDE5OfVlzqnOg6LFePU1Imr0f+4diKa7DSmR/5JkqtDhY86
         WGjw==
X-Gm-Message-State: AOAM531V2kePtYCFDhIxKqA7DPP1H8mGyhsOMoZTznquwP+HWptiIjBJ
        6HCfkoXIzuztpUaWyfPDqJ/qi2jzFaM=
X-Google-Smtp-Source: ABdhPJxKMJ+PcdXq2N+wwgyW/ixyuJ0GxOxf9qHYYO2XaSwW3AROu0CGEqmEVUf1TsrrmUPVK3WP4A==
X-Received: by 2002:adf:f389:0:b0:1ef:5f0f:cb83 with SMTP id m9-20020adff389000000b001ef5f0fcb83mr8523353wro.26.1646668679686;
        Mon, 07 Mar 2022 07:57:59 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm11686591wrv.79.2022.03.07.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 07:57:58 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/5] Volatile fanotify marks
Date:   Mon,  7 Mar 2022 17:57:36 +0200
Message-Id: <20220307155741.1352405-1-amir73il@gmail.com>
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

Following RFC discussion [1], following are the volatile mark patches.

Tested both manually and with this LTP test [2].
I was struggling with this test for a while because drop caches
did not get rid of the un-pinned inode when test was run with
ext2 or ext4 on my test VM. With xfs, the test works fine for me,
but it may not work for everyone.

Perhaps you have a suggestion for a better way to test inode eviction.

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxiRDpuS=2uA6+ZUM7yG9vVU-u212tkunBmSnP_u=mkv=Q@mail.gmail.com/
[2] https://github.com/amir73il/ltp/commits/fan_volatile

Amir Goldstein (5):
  fsnotify: move inotify control flags to mark flags
  fsnotify: pass flags argument to fsnotify_add_mark()
  fsnotify: allow adding an inode mark without pinning inode
  fanotify: add support for exclusive create of mark
  fanotify: add support for "volatile" inode marks

 fs/notify/fanotify/fanotify_user.c   | 32 +++++++++--
 fs/notify/fsnotify.c                 |  4 +-
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     | 40 +++++++++-----
 fs/notify/mark.c                     | 83 +++++++++++++++++++++++-----
 include/linux/fanotify.h             |  9 ++-
 include/linux/fsnotify_backend.h     | 32 ++++++-----
 include/uapi/linux/fanotify.h        |  2 +
 kernel/audit_fsnotify.c              |  3 +-
 9 files changed, 151 insertions(+), 56 deletions(-)

-- 
2.25.1

