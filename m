Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A183344D93
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 18:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhCVRkG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 13:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhCVRju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 13:39:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C55CC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso11597200wmi.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Mar 2021 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8+5xbAWKoDsP0ByNu0spIiDFN4FVbFPlkqK23+z5XQ=;
        b=KELYG1fVhq7NryoWAkjuj5ooXe4RNxbJVTorZZ3oZN5LA/zH2xO52sQ4I3v9KUrHvS
         UxRCYnWSFas6w9x+dKAQ5OFQeRrA5dvwFFD3Q8N/TiBQmVonsrBtsbIxcEnf2nCJ8WH0
         MB4r0ZnJ0ogA6UUhP+ey5eKXEIDxFzP27IX32JRmp0aq1wUMc2zi0Jtm895TeW3wspjr
         oOwJiMMaME/8pnweqATmMnmKm45X+pas3u77MGfPekMUicryIDR3pjWl1OMK5OOW2gT8
         3n/8oWh16bJbdPXdggwgTu+D35QP2e9gZu0ftr/q7yWQwk0d8r774qVsnvi4xxTBT1f3
         7yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R8+5xbAWKoDsP0ByNu0spIiDFN4FVbFPlkqK23+z5XQ=;
        b=KiEmkh+jMgS6SRyWlJRW4QRIkzvntMFpWYtbJ0DqWpFcg1DURvm1jBWfn7uVZYKPyO
         ri282LqriIqrjHf5/8hPGAW3GD7HtfxWJUcy6yrId9rTkqkbpDkw9C4+R7I8AXxAyADZ
         W6oAcPU/gQ4TaxKG879vkZa7qsqENCc/20RxFzJZh/LDSyJTSVO8JC+3TOewuJG+Yjet
         +pGF3oEqwARD6Q8rNb2rUkMjN0MRfPHoUdroxLd8mZtdDnyp3GqDpU1uBhcppLYe0gO7
         100rqMPOobYz/nFWA/LpXFOwxBVEv9HF+7q8Dx84H/QpBy25f0ZnosNDCNU72HfmjEUN
         adJQ==
X-Gm-Message-State: AOAM530NNcmaSpa2hMpUmmC29MRvFgVMBoMnhqVdj306QOhctbsSh+EH
        QDrNxmIh/HtxHxT0RDD2X+4=
X-Google-Smtp-Source: ABdhPJwRxPNffLb/X1yGjTTcslGxaJ+lyPyCfQfVnYQ9k0jEdppt41YZZD/2pj6ojYIMz7+DSf9SuA==
X-Received: by 2002:a1c:60c2:: with SMTP id u185mr125700wmb.157.1616434787961;
        Mon, 22 Mar 2021 10:39:47 -0700 (PDT)
Received: from localhost.localdomain ([141.226.241.101])
        by smtp.gmail.com with ESMTPSA id p27sm138790wmi.12.2021.03.22.10.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 10:39:47 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hugh Dickins <hughd@google.com>, Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/2] Better fanotify support for tmpfs
Date:   Mon, 22 Mar 2021 19:39:42 +0200
Message-Id: <20210322173944.449469-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jan,

I needed the tmpfs patch for the userns filesystem mark POC, but it
looks useful for its own right to be able to set filesystem mount or
inode marks on tmpfs with FAN_REPORT_FID.

I can break the cleanup patch into helper and individual patches
for the fs maintainers, but since its so dummy, I thought it might
be best to get an ACK from fs maintainers and carry this as a single
patch.

Thanks,
Amir.

Amir Goldstein (2):
  fs: introduce a wrapper uuid_to_fsid()
  shmem: allow reporting fanotify events with file handles on tmpfs

 fs/ext2/super.c        | 5 +----
 fs/ext4/super.c        | 5 +----
 fs/zonefs/super.c      | 5 +----
 include/linux/statfs.h | 7 +++++++
 mm/shmem.c             | 3 +++
 5 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.25.1

